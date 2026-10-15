Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0387BCCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 22:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHTlU-0002E4-KG; Thu, 15 Oct 2026 18:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aksheynew.tanejanew@gmail.com>)
 id 1xHOr3-0007D5-Vx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:02:58 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aksheynew.tanejanew@gmail.com>)
 id 1xHOqv-0003x2-4p
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:02:51 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd5c9e52398so2514578a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792083766; x=1792688566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5sCj4amkDsYs1pfyEUgpMCDKBamRT7BGjJoSHqaXC4=;
 b=HL0szVNzQ8983/R+6RNhHwEBhf7A5NRn6TWS4+xLwz52e2Q+v1Fy4Tn1tef/FX6Rr3
 bbdePi3wE530He3aMeCG7P1DSrjct6n5QR3RRjX1sS+cCVMOhppfrtBbWVS4Ox+XF1BE
 chW+NtKY2IlgKNpX8zr7gQOSSt7Krm832KX0RjIahyGTdT61mgvFbdS8m9XtBT4DU31n
 CrZ8Yu80cz7rsdYx5vTpeFxe/EQqRydYzKNzYg2Bnv99QtZDszanYE36wBAmEv4PK2p9
 uc5Fu/1OLLIj4Fv62BDY3Vi3KfIz4Fad+nlS5Ob8kYhKAJ+dByS8Eaoj9Hv1Pm3wZav5
 4Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792083766; x=1792688566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g5sCj4amkDsYs1pfyEUgpMCDKBamRT7BGjJoSHqaXC4=;
 b=qVESNNN9dG8uWRfcbtLXaMEBRxWwol/zexZtlN9RYwTVFl1lUon0Mmtb6HDlnSkNGV
 BwmtSNMHO+HUHQaazaGHcpFymlXM+9f458/uyUoTUdEsvnmgEVSUIG2+VjTaFTFFTwe8
 VNir/V133hol7kGszAVa4vjsDli7vSlF9n2lelpmclxkWx3VM9kxg+VNtnmHpTpL3mkq
 dzKarcccYV5Ql1RBcJjLp+GGvT8sjvdTZG63s5eZ5b9kIGLEIEChHZqf0tyuVAiVayHd
 4gmr1FCyVGsYgJJG7dB2+FTOwa58r5eDxOwk4YaTCOw5fhpXOk+GgkrhBa6DjpRmUEc8
 FFtw==
X-Gm-Message-State: AFq9FYI6Kj4XKnyMB8Dd7WG/bSwy5fSUwTYYhXtJd8VBFqc/mKcl72CY
 8kx2ILojlL3BbPDV7c0FuPjtZKyrzfwReGeNndV4Nb4jgIAKIqHEA6K2OQP6bw==
X-Gm-Gg: AYBFou0tmgrU4umZc/nPr0wmq+wTdvNmy+TIoR9BTRldrxrnWus+BTW/bjEMbcGZeX/
 rgOb6K+9a7erH0+cNb3RnqF7i6yVvp2LvZJ/E8SjzpUr8UkkUxD4lLiEoZqVVzcqNExq2nkAJ71
 JOTUW1jqufmMvfUuxC3eDjz/W5osmogh1p9JrTV57tPLNXZS63xjhAbi4710EwXjVIaWFyU9bBK
 j4XG/CupzVuYxKeuZE5v3TD+A+oMyXuV6NNVHS9cM97XPfC7eS4GSsS2wFGpyrxVljhfhPiViM+
 fq8hps4Mz59sqGlnd4r19QWtvvGBtv3iFQltvmTU3g9PsqhFN73kM9+CONsjo4fz3XFFIIewzlz
 AAP87kbdb3kzs5Fi5s3AsfjvungSN7h30zWIu0AsOJPVDUUnxhHDlzDjriRZxBBokJJgLSXx6FL
 Eqb567Dk4ujwM4k1AkVyyQK02RVfeuJXYUt+JHAoW9rieMWTfxzvRNNZvg5yfohq8LYktCo6Qzw
 5hY57vbqRmfnbe8Ky/WEjMKSLKR4rDJBiLPGmR6CsL/+Jez8nUIhulWFMrQrFeciyRPXtKNakkF
 suMbAY1+7698KYliViTYmw==
X-Received: by 2002:a17:90b:2786:b0:3ab:b39f:41cd with SMTP id
 98e67ed59e1d1-3abb39f44eamr12881111a91.60.1792083765271; 
 Thu, 15 Oct 2026 10:02:45 -0700 (PDT)
Received: from STA-DBBJ1B4 (c-73-254-235-207.hsd1.wa.comcast.net.
 [73.254.235.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm5893712a91.9.2026.10.15.10.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:02:44 -0700 (PDT)
From: Akshey Taneja <aksheynew.tanejanew@gmail.com>
To: qemu-devel@nongnu.org
Cc: Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PATCH 2/2] whpx: i386: fall back to xAPIC when the MSR exit bitmap is
 unavailable
Date: Thu, 15 Oct 2026 10:02:16 -0700
Message-ID: <20261015170216.6895-3-aksheynew.tanejanew@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261015170216.6895-1-aksheynew.tanejanew@gmail.com>
References: <20261015170216.6895-1-aksheynew.tanejanew@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=aksheynew.tanejanew@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Oct 2026 18:17:31 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

WHvPartitionPropertyCodeX64MsrExitBitmap is not implemented on Windows=0D
10, where WHvSetPartitionProperty() returns WHV_E_UNKNOWN_PROPERTY=0D
(0x80370302) and whpx_accel_init() aborts with -EINVAL. QEMU started=0D
requesting it in ba1bda25b7 ("whpx: i386: x2apic emulation").=0D
=0D
Treating the failure as non-fatal is not sufficient on its own:=0D
whpx_default_props unconditionally enables x2apic, and x2APIC is reached=0D
through MSRs, so without MSR exits the userspace LAPIC never observes=0D
the guest's APIC accesses and the guest hangs immediately after the=0D
firmware hands over. Observed as a black screen with an Ubuntu 24.04=0D
guest that otherwise boots in about 40 seconds.=0D
=0D
Record whether the MSR exit bitmap was accepted and, when it was not,=0D
apply x2apic=3Doff so the guest uses the MMIO based xAPIC, which is still=0D
intercepted normally.=0D
=0D
Reported-on: Windows 10 Enterprise LTSC 17763, Intel i7-6700=0D
Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>=0D
---=0D
 target/i386/whpx/whpx-all.c | 33 ++++++++++++++++++++++++++++-----=0D
 1 file changed, 28 insertions(+), 5 deletions(-)=0D
=0D
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c=0D
index 9a9fc7d974..3e59aacf31 100644=0D
--- a/target/i386/whpx/whpx-all.c=0D
+++ b/target/i386/whpx/whpx-all.c=0D
@@ -57,7 +57,7 @@=0D
 #define HV_X64_MSR_GUEST_IDLE           0x400000f0=0D
 =0D
 static bool is_modern_os =3D true;=0D
-=0D
+static bool whpx_msr_exits_available =3D true;=0D
 static const WHV_REGISTER_NAME whpx_register_names[] =3D {=0D
 =0D
     /* X64 General purpose registers */=0D
@@ -2889,6 +2889,16 @@ static PropValue whpx_default_props[] =3D {=0D
     { NULL, NULL },=0D
 };=0D
 =0D
+/*=0D
+ * x2APIC is reached through MSRs, so emulating it in userspace requires t=
he=0D
+ * MSR exit bitmap. Hosts without that property must fall back to xAPIC,=0D
+ * which is MMIO based and therefore still intercepted.=0D
+ */=0D
+static PropValue whpx_no_msr_exit_props[] =3D {=0D
+    { "x2apic", "off" },=0D
+    { NULL, NULL },=0D
+};=0D
+=0D
 =0D
 void whpx_cpu_instance_init(CPUState *cs)=0D
 {=0D
@@ -2896,7 +2906,8 @@ void whpx_cpu_instance_init(CPUState *cs)=0D
     X86CPUClass *xcc =3D X86_CPU_GET_CLASS(cpu);=0D
 =0D
     host_cpu_instance_init(cpu);=0D
-    x86_cpu_apply_props(cpu, whpx_default_props);=0D
+    x86_cpu_apply_props(cpu, whpx_msr_exits_available ? whpx_default_props=
=0D
+                                                      : whpx_no_msr_exit_p=
rops);=0D
 =0D
     if (xcc->max_features) {=0D
         whpx_cpu_max_instance_init(cpu);=0D
@@ -3344,10 +3355,22 @@ int whpx_accel_init(AccelState *as, MachineState *m=
s)=0D
             WHvPartitionPropertyCodeX64MsrExitBitmap,=0D
             &prop,=0D
             sizeof(WHV_PARTITION_PROPERTY));=0D
+    /*=0D
+     * Windows 10 does not implement this property. Without the MSR exits =
the=0D
+     * guest simply gets the behaviour QEMU had before commit ba1bda25b7=0D
+     * ("whpx: i386: x2apic emulation") started asking for them, so treat =
an=0D
+     * unknown property as non-fatal rather than refusing to start.=0D
+     */=0D
     if (FAILED(hr)) {=0D
-        error_report("WHPX: Failed to set MSR exit bitmap, hr=3D%08lx", hr=
);=0D
-        ret =3D -EINVAL;=0D
-        goto error;=0D
+        if (hr =3D=3D WHV_E_UNKNOWN_PROPERTY) {=0D
+            whpx_msr_exits_available =3D false;=0D
+            warn_report("WHPX: MSR exit bitmap unsupported on this Windows=
 "=0D
+                        "version, falling back to xAPIC");=0D
+        } else {=0D
+            error_report("WHPX: Failed to set MSR exit bitmap, hr=3D%08lx"=
, hr);=0D
+            ret =3D -EINVAL;=0D
+            goto error;=0D
+        }=0D
     }=0D
 =0D
     hr =3D whp_dispatch.WHvSetPartitionProperty(=0D
-- =0D
2.50.1.windows.1=0D

