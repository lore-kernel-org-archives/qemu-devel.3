Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDBDCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kYF-0000BN-F8; Fri, 17 Oct 2025 09:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kYB-0000AD-9G
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXu-00080k-Pp
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4710683a644so18241865e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707857; x=1761312657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cs6l+ulzm2Pu0rQ5n5f0X6bnVXlbvi27lz9IxqVVmKk=;
 b=RygvZboqbRhNvoSg7RxbSoSBbbXrkURirKGWsM0scFJTe42qGo8vTFSLx5KFAj0PV6
 o3IugsIWDK865iFqjRabrq2r2Jgj0uKihz+yeteeE5LKhWmWMuWw0iMFWtt0VjNwfXK2
 dfha3bsid6pskeHDq0fP/Gjd98Dod7JzBKDO+2/UMce3F6i0G7kttOC8SF60dTbqFhwf
 WpGf+24GKzFNTPDn2v7oiM3hzc7rX5SI0WRPTgZHsI0UHfnemlwzAPY22sf8nZ7YxjUC
 6E8eiaV8c2twNDzy02f4tY77wOi5iwznYCTCTDQ3ZGq3EmNITsPqLudPxTF2Ibfea1hJ
 X1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707857; x=1761312657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cs6l+ulzm2Pu0rQ5n5f0X6bnVXlbvi27lz9IxqVVmKk=;
 b=DB2HFNZEh+meSBvPH027Pjg1CfIcO+w29a+G7a8OZTJU2eLlgWSlbz0SMVxcl0kHv5
 ukCziXZQew4KeDjekdis5mL2++SWOygRrVedcCOCjdcCq2sUkdcRaQRj3T3FjvyXqgHd
 UxU4OFLQwnVioCfx7ZS3YVfGNEIBAEi32CurZ4ehGvGOCUFyslePrT675k9yzwbWDaqY
 GIpvNaVEjgIeSJxC1aH++2y3EUM/Q6nY6IQUqFPqZmzb5vQkEASR3o0XBMHx5RecG/hm
 Y2ZlNsDD/OaCPRrLO2AeN9nJlbl70f9lhH2LxFT8DuCNJoqxZcvOAgwp8LoATo2IUQAv
 1RNQ==
X-Gm-Message-State: AOJu0YzjD6L9TddP/rCOeZIqe+PbOBYJYZigcRpBQbbiPvs3MO3qXu5F
 uwH2OUW33oNyGwrEyWaQmN0T0Jbev5W2SvgLgEYPaIVdL9JDoKW+fgdTBskpc/+qN9Xd4HjfaRF
 OdUsgs+0=
X-Gm-Gg: ASbGncsZs2woUr38tL/F6HY1Wuf0pA4hMBgRKlMl9JjC4R343RXhFTmrj1YO4mlAH2Q
 QPM24hzkCmmC/qqX7PemkZ9HOwYZwOLCuNvbhosat/NApa7CZhZLMUfV7lNlVQ5wiMoVSMrRMUu
 9rwTsz6ZxDwaJFThMFcPNgRVrdFzaqu62mBiogkeWah4tKbm4H48ivRrsGC4ZifExm3zoop7ZHX
 ardESdUsiGRQoMi4dLugeLnV5g3gbMbeSl1Syz1dGuMTzbdmRgYiYiJHed3eUHf+d6xeJQYK6j/
 khoeS1edqJMKQBF8pSFaCvYqQsKeZShJpiReiE3IuZYLHRtqjXHYqfa4I/HJBAAAlqdrvrUPd0v
 l0u1jJ5A0SaZlcl3wQTIgQ/JIEWPTpujmfCF93tAwMklnMdFi63m81T1Y947JIDH4FjVbKXuUxR
 kLVDdR+lmG1RxT0x7IEH1DJVL+OLPoQwxO3MODrc1SxlHK7j3pS3M7RtUzxCtiKKG8aIlbbps=
X-Google-Smtp-Source: AGHT+IFf3PiUKb2tRsGUrcWsD5ZYbeNsKnTJRdF9g/Wp99stbxGPlfjc/6aC5UzHaa0IUBm6nhP/sw==
X-Received: by 2002:a05:600c:3586:b0:471:5c0:94fc with SMTP id
 5b1f17b1804b1-47117249af2mr38195695e9.6.1760707856695; 
 Fri, 17 Oct 2025 06:30:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42708bcea1bsm2723796f8f.14.2025.10.17.06.30.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.1
 machine
Date: Fri, 17 Oct 2025 15:29:59 +0200
Message-ID: <20251017133002.61410-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 942b1e5a932..cf09b5c46e6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1022,30 +1022,6 @@ static void ccw_machine_7_2_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(7, 2);
 
-static void ccw_machine_7_1_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V7_1 };
-
-    ccw_machine_7_2_instance_options(machine);
-    s390_cpudef_featoff_greater(16, 1, S390_FEAT_PAIE);
-    s390_set_qemu_cpu_model(0x8561, 15, 1, qemu_cpu_feat);
-}
-
-static void ccw_machine_7_1_class_options(MachineClass *mc)
-{
-    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_S390_PCI_DEVICE, "interpret", "off", },
-        { TYPE_S390_PCI_DEVICE, "forwarding-assist", "off", },
-    };
-
-    ccw_machine_7_2_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    s390mc->max_threads = S390_MAX_CPUS;
-}
-DEFINE_CCW_MACHINE(7, 1);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


