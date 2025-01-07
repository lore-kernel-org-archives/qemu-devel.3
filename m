Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A96E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVC5q-0001cT-LM; Tue, 07 Jan 2025 11:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tVC5l-0001bs-JB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:06:06 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tVC5i-0000S1-0C
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:06:05 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4afd56903b7so4082864137.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736265959; x=1736870759;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DW6AtDTP6p9aAbxryQCwFOHcIWGa0LNKqKbhK2pFSbg=;
 b=Mh8El9xD7A2KthA1/aIHpgOPTwDGzau09ICEks84tPDGM7+l3OFpq1QzpcWIGWrZ0o
 KDdts2cbU1fiSWuME3CEqNq+FyNF/h4NMbcuxeHF+Zww1WJhK9Fu9hVc5Ead8k1eJzMk
 Kw2T2RzofRZLNZWNRRGpYoowC1azl5831+7po5Q3J1iU5PB4t47x5S0LPyRovnwBVvD8
 aVq88gvCuzYBkmT1R+2id+kyQGzpwPOsSWR1DKyemuCdmsOmqOhf7yCE1r+fO35qY60y
 rZQY3NBa/ITQRXSrUrJppcYcyo6YL9uI3LGEBkKv7MppP3aajuvCDGvD1UZhpsCOI1AW
 0ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736265959; x=1736870759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DW6AtDTP6p9aAbxryQCwFOHcIWGa0LNKqKbhK2pFSbg=;
 b=OA6frPq5OGe4gNpzFdsqsrR0bkGllJzpeTo3NGC/2wZy6LunNb1BWEJvUmD/x4/lw1
 86MJEp9n87+bPesIwvNO77H21EFk8ODNaMayKFXRf4YOZoJl7e7EEIPI1pyXS8WP4hO/
 G6YeIoSHL++VlwDPPTOJSpPCU9Lyi1uu2Ix1eg1+7IHwGMgM/xSv1G/0G0FgNlu1S77H
 Vc7ttLWVVIeuM4/3ejDyiYBSCSaMuMgv/pGc7uPl3q+zcAUmfYAzGjetJyXyNh72/+eI
 lPcZKAXjMGZ1wD1J45oA3boKHU3eF5HtFjNfGhjCAk8P4D3/ux8o9ekKYnzVoF6l/GJ4
 wU7w==
X-Gm-Message-State: AOJu0YxDeRO0ithb8bkKRQwcbDp19kqQj4BgjAA+7jo+SNJCyX4pwYta
 1yzrKItvv6UJr/hq6gM12W+Ne7ld9NzrcGzQntd68QWK4oFAZ3wKMwV7csyc/Z7oJa2sjyViqvx
 rHm04NCD+mFmFj9dJX6DC3DXR7Ap8djcnKKck
X-Gm-Gg: ASbGncvpGMcKHi6VNVJ7zDiLEgBbOeDEH5uxj8S1n71b68BI1DJz7CIwhcjFQ6RtY+Y
 lkL0jf0rrURGqlqKnDYs+f+7u2/ONF+2c8eOyrw==
X-Google-Smtp-Source: AGHT+IHnvm0wirIicvFLXCsjhxeqdfXPSWhD5wgaDoQ7a+kX6VSy5zrbDlKzfeI0h8Z3tkUZRjPikQ+kSSSKjFRU4jU=
X-Received: by 2002:a05:6122:1999:b0:517:4e40:6838 with SMTP id
 71dfb90a1353d-51b75c65272mr44424236e0c.6.1736265959592; Tue, 07 Jan 2025
 08:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20241227202435.48055-1-philmd@linaro.org>
 <20241227202435.48055-3-philmd@linaro.org>
 <CAAibmn0zhrZjZ+SL7n7eg041a5APx-o4sCAp0YGDiwUk8gpgDA@mail.gmail.com>
In-Reply-To: <CAAibmn0zhrZjZ+SL7n7eg041a5APx-o4sCAp0YGDiwUk8gpgDA@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 7 Jan 2025 17:05:48 +0100
X-Gm-Features: AbW1kvb_ySWjF0Vl8NK1dVDj3D_1TaGuNYsqNrAlCsYHozoAfn3vBqik1FlzvKk
Message-ID: <CAAibmn1g6+btdRX99ZUvbaBm7hP_AnAGNfDHz4Wgi3fPn=waOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: Have ARM_GIC select ARM_GICV3 when KVM is
 not available
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c1f0a6062b1feb89"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e32;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000c1f0a6062b1feb89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Dec 2024 at 11:48, Phil Dennis-Jordan <phil@philjordan.eu> wrote=
:

>
>
> On Fri, 27 Dec 2024 at 21:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org>
> wrote:
>
>> When the KVM accelerator is selected, the Kconfig ARM_GIC key
>> selects the KVM GIC implementation (ARM_GIC_KVM).
>> For other accelerators (TCG, HVF, ...), select the generic
>> implementation.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  hw/intc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
>> index 7547528f2c2..762139d8df3 100644
>> --- a/hw/intc/Kconfig
>> +++ b/hw/intc/Kconfig
>> @@ -23,7 +23,7 @@ config APIC
>>
>>  config ARM_GIC
>>      bool
>> -    select ARM_GICV3 if TCG
>> +    select ARM_GICV3 if !KVM
>>
>
> Wouldn't this disable the ARM_GICV3 by default when building with
> --enable-tcg --enable-kvm? And then there would be no GIC available when
> running the built QEMU in TCG mode. (Bear with me, I'm a relative Meson
> newbie.)
>
>


OK, I've managed to answer my own question now by setting up a RPi5 with
aarch64 RPOS and building QEMU on that with --enable-kvm --enable-tcg. With
patch 1/2 applied on current upstream master, I get:

$ build/qemu-system-aarch64 -accel tcg -M virt,gic-version=3D3 -smp 4 -m 4G
*[runs successfully]*

with 2/2 applied as well:

$ build/qemu-system-aarch64 -accel tcg -M virt,gic-version=3D3 -smp 4 -m 4G
qemu-system-aarch64: tcg does not support GICv3 emulation
$

In other words, with the proposed change, ARM_GICV3 is indeed deselected if
KVM is selected even if TCG is also selected.


Possibly very basic question: is there any support for kernel-irqchip=3Doff
on aarch64/KVM?
If yes, don't we need ARM_GICV3 in that case anyway, so we should drop any
accel dependency on it in the first place?


If we definitely don't need the software GIC in KVM-only builds, I guess
we're down to listing each accel that needs it individually. Is that:

select ARM_GICV3 if TCG || HVF || NVMM || WHPX || XEN_EMU || XEN

or can we drop any of those? Have I missed anything? What about QTest?

--000000000000c1f0a6062b1feb89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 28 Dec 2024 =
at 11:48, Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" targ=
et=3D"_blank">phil@philjordan.eu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, 27 Dec 2024 at 21:24, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">When the KVM acceler=
ator is selected, the Kconfig ARM_GIC key<br>
selects the KVM GIC implementation (ARM_GIC_KVM).<br>
For other accelerators (TCG, HVF, ...), select the generic<br>
implementation.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0hw/intc/Kconfig | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig<br>
index 7547528f2c2..762139d8df3 100644<br>
--- a/hw/intc/Kconfig<br>
+++ b/hw/intc/Kconfig<br>
@@ -23,7 +23,7 @@ config APIC<br>
<br>
=C2=A0config ARM_GIC<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
-=C2=A0 =C2=A0 select ARM_GICV3 if TCG<br>
+=C2=A0 =C2=A0 select ARM_GICV3 if !KVM<br></blockquote><div><br></div><div=
>Wouldn&#39;t this disable the ARM_GICV3 by default when building with --en=
able-tcg --enable-kvm? And then there would be no GIC available when runnin=
g the built QEMU in TCG mode.  (Bear with me, I&#39;m  a relative Meson new=
bie.)<br></div><div>=C2=A0<br>
</div></div></div></blockquote><div><br></div><div><br></div><div>OK, I&#39=
;ve managed to answer my own question now by setting up a RPi5 with aarch64=
 RPOS and building QEMU on that with --enable-kvm --enable-tcg. With patch =
1/2 applied on current upstream master, I get:</div><div><br></div><div><sp=
an style=3D"font-family:monospace">$ build/qemu-system-aarch64 -accel tcg -=
M virt,gic-version=3D3 -smp 4 -m 4G</span></div><div><i><span style=3D"font=
-family:monospace">[runs successfully]</span></i><br></div><div><br></div><=
div>with 2/2 applied as well:</div><div><span style=3D"font-family:monospac=
e"><br></span></div><div><span style=3D"font-family:monospace">$ build/qemu=
-system-aarch64 -accel tcg -M virt,gic-version=3D3 -smp 4 -m 4G<br>qemu-sys=
tem-aarch64: tcg does not support GICv3 emulation</span></div><div><span st=
yle=3D"font-family:monospace">$<br></span></div><div><br></div><div>In othe=
r words, with the proposed change, ARM_GICV3 is indeed deselected if KVM is=
 selected even if TCG is also selected.</div><div><br></div><div><br></div>=
<div>Possibly very basic question: is there any support for kernel-irqchip=
=3Doff on aarch64/KVM?</div><div>If yes, don&#39;t we need ARM_GICV3 in tha=
t case anyway, so we should drop any accel dependency on it in the first pl=
ace?</div><div><br></div><div><br></div><div>If we definitely don&#39;t nee=
d the software GIC in KVM-only builds, I guess we&#39;re down to listing ea=
ch accel that needs it individually. Is that:<br></div><div><br></div><div>=
select ARM_GICV3 if TCG || HVF || NVMM || WHPX || XEN_EMU || XEN<br></div><=
div><br></div><div>or can we drop any of those? Have I missed anything? Wha=
t about QTest?</div><div><br></div></div></div>
</div>

--000000000000c1f0a6062b1feb89--

