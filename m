Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA8FD9E15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvivx-0003GD-C9; Thu, 26 Feb 2026 16:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vvivu-0003Fn-4s
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:30:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vvivs-0003lw-Bq
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:30:05 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso908918f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772141402; x=1772746202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyjTaVC/oZKBKxlAITsiGyapD60mOc2gIVCRgG4M1+I=;
 b=a17gv5XaVV+du+1bcSNtz5YbHLYqc6xVtgBm7Ly2Ue/zEmvi57Y7LStsLsAjKQpjmn
 ChCYTnemdcd+i+JZoFpk5d/OV/wLUej6X0xJUHWl11IxUTith3PlrFSe2Jq/BIQFj89e
 erc8Zp1vCtScBKNxSoKi+zKdd68SlGjrM/GaTec5bT6zsK9kHi42RSh+Fza1a6aGzieJ
 YTS110qeF8E7VcqKxGY1lBRQatWAsLESpe//GSVKfI6HHFBYw+oHWB2DDkPUEGHY1Q+Z
 HMnUN9mixMgwv6hTcTjHAVz58b/otEYvsJ9pHdmfgttLNU7HOZhkcN9cu/TRGqrYzC3S
 GCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772141402; x=1772746202;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kyjTaVC/oZKBKxlAITsiGyapD60mOc2gIVCRgG4M1+I=;
 b=NO5KvBJhqZzfkWN55WGUXlD5u1HOShesWff5vJz5UHORVoFAeXJccbrPNbj/9dctPs
 ndTYgI3xy3yYVw2GoUiED4GHe8bqdenc2Ksa9U/QWGNCEAbnvZ7yGLeGdpOWDF582Qwv
 qC0HadxirUifZTbcY0y6u1SEOL+XM+fgfcE1aLCKiNmtIO0gXviKXERRBMqORw6uRF1B
 3bDhwSTcTuF52U9aap3Y7hgJkYODhZYMW8BErOLEx9r9nb4YhpfLecPp+qD8UKbPAAV8
 IgQqZEWJSG/p5PeTnMdeI+2Njj+6cV4dCUypE7ku3YfFhsOIXW8fTC2nEpZ/eXchbVgA
 szDg==
X-Gm-Message-State: AOJu0YxnX0OurTemb8r3wOiAQF13veYH63kU85Eimo7gw9XZa9TPogVM
 xLAEDMi964UVYoaCOZ5xv1iABZQV6w52TlSVEZw2mHSUNfmOeIT9N3wwJ7za1w==
X-Gm-Gg: ATEYQzzGWQsBKGTsg2kzDH/aIqCsqgdug8xONXvwdnGyxyXnAgJHb8mIwTbJ5+6dANB
 b8mqs3FhTwmGmZ+S9su4RIYBP5UBAtwTcuoqdGSe0N5QlJzuatANBfWKYulOA2jJ8y3TTl5Ga91
 CfR5euBlTS/GbzwRJtS3FIE+1BbWEYlHCstdClXvKgj69XElhdfJeDg4f0ayghpIbUWmArTDRne
 SXMFYUGYB0sVPM70FFHH1zfoYVwFIN4pF32Rk9BsyuS/PW5OT1UXGz2TDP+xi9Pe65u5T9YSofC
 JlrG9tzxBQN3Zj+4AnnXApZAUIWOZjiUqq9XquDurPel9s/CPFpZ3MfMHTwiSendirAcGIl4F1T
 wRDvnehfDMGSRHacfYAxpmKwrMupIZWrrTTLG5doBVJnj0yivV1zKuDrE85fGYqSeCn4LgWGftF
 eSZ0BlJNbGu8qMc/d5sVb2821capK7Fsdj7VfsWynaJqe+/r2hASYyOukimlH/AqRrmtUPKtIXL
 bDiuQqJC6LUcJnWet8ikTRpaIuDuf3DmbOrIA6LN/P9tcw=
X-Received: by 2002:a05:6000:2483:b0:439:9a2f:d9bf with SMTP id
 ffacd0b85a97d-4399dde1474mr557637f8f.7.1772141402177; 
 Thu, 26 Feb 2026 13:30:02 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2de3-af00-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:2de3:af00:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a25dsm2113029f8f.21.2026.02.26.13.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 13:30:01 -0800 (PST)
Date: Thu, 26 Feb 2026 21:29:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_whpx=3A_x86=3A_kick_out_of_H?=
 =?US-ASCII?Q?LT_manually_when_using_the_kernel-irqchip?=
In-Reply-To: <20260226181930.53170-3-mohamed@unpredictable.fr>
References: <20260226181930.53170-1-mohamed@unpredictable.fr>
 <20260226181930.53170-3-mohamed@unpredictable.fr>
Message-ID: <BA4FF800-5D8E-4D14-98CD-B219598E6F1E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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



Am 26=2E Februar 2026 18:19:29 UTC schrieb Mohamed Mediouni <mohamed@unpre=
dictable=2Efr>:
>Otherwise, interrupts processed through the cancel vCPU and inject path w=
ill not cause the vCPU to go out of its halt state=2E

Yay, thanks for tackling this!

>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>

It probably resolves https://gitlab=2Ecom/qemu-project/qemu/-/issues/346 ,=
 though that would need to be confirmed by testing=2E

Best regards,
Bernhard

>---
> target/i386/whpx/whpx-all=2Ec | 29 +++++++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
>
>diff --git a/target/i386/whpx/whpx-all=2Ec b/target/i386/whpx/whpx-all=2E=
c
>index bd3a1c49c6=2E=2E650d65c61e 100644
>--- a/target/i386/whpx/whpx-all=2Ec
>+++ b/target/i386/whpx/whpx-all=2Ec
>@@ -1475,6 +1475,16 @@ static void whpx_vcpu_post_run(CPUState *cpu)
>         !vcpu->exit_ctx=2EVpContext=2EExecutionState=2EInterruptShadow;
> }
>=20
>+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu)=20
>+{
>+    WHV_REGISTER_VALUE reg;
>+    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
>+    if (reg=2EInternalActivity=2EHaltSuspend) {
>+        reg=2EInternalActivity=2EHaltSuspend =3D 0;
>+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
>+    }
>+}
>+
> static void whpx_vcpu_process_async_events(CPUState *cpu)
> {
>     X86CPU *x86_cpu =3D X86_CPU(cpu);
>@@ -1760,6 +1770,25 @@ int whpx_vcpu_run(CPUState *cpu)
>                 cpu->exception_index =3D EXCP_INTERRUPT;
>                 ret =3D 1;
>             }
>+            /*=20
>+             * When the Hyper-V APIC is enabled, to get out of HLT we
>+             * either have to request an interrupt or manually get it aw=
ay
>+             * from HLT=2E
>+             *
>+             * We also manually do inject some interrupts via WHvRegiste=
rPendingEvent
>+             * instead of WHVRequestInterrupt, which does not reset the =
HLT state=2E
>+             *
>+             * However, even with this done, if the guest does an HLT wi=
thout
>+             * interrupts enabled (which the test_sti_inhibit KVM unit t=
est does)
>+             * then the guest will stay in HLT forever=2E
>+             *
>+             * Keep it this way for now, with perhaps adding a heartbeat=
 later
>+             * so that we get the CPU time savings from having Hyper-V h=
andle HLT
>+             * instead of going away from it as soon as possible=2E
>+             */
>+            if (whpx_irqchip_in_kernel()) {
>+                whpx_vcpu_kick_out_of_hlt(cpu);
>+            }
>             break;
>         case WHvRunVpExitReasonX64MsrAccess: {
>             WHV_REGISTER_VALUE reg_values[3] =3D {0};

