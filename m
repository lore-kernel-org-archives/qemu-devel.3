Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD3EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 15:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqnp-0003Ep-65; Thu, 27 Jun 2024 11:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMqnj-0003DY-0D
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 11:12:44 -0400
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMqnb-0003rF-Fi
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 11:12:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7FA521380164;
 Thu, 27 Jun 2024 11:12:29 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 27 Jun 2024 11:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719501149;
 x=1719587549; bh=Nih6KHrF2FQRonAiIB647Lub+TcrnZzq0J2fYLfcFMQ=; b=
 qgd8ZPsSq06iggsvBd6E/WeOp1kgdg/6SJb6BQ7qlYoOqLEVdta94kyZQZ7FrWQY
 PIDGCSErigU4DPsgnQ1eV+6aGQBLKPLEiRnW0KMAFdP26ySX3PKPIn4MjLNzGJI9
 TwdAtDHlFWK84gAnt3XeJLChUI9odg+MgmVGUey9pTnVKlIj2R4jRniUscq2O/wY
 klfVdPKRrCbIhWdaXtNjU8uOw1WShJ7DdqoL2QjpaHY3r4h5Bb0xS0kyM9T6SA0U
 cmFfUuXe3XCXaGt5M26X/j/QaS3yS90O94Bm9O8DGQEiL/I7CM59hozl3PSUzRfe
 gLIdHdRjkRyrhsidrKVkPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719501149; x=
 1719587549; bh=Nih6KHrF2FQRonAiIB647Lub+TcrnZzq0J2fYLfcFMQ=; b=L
 cWMFKmkKMIQbpsNyAw3zfUAxQqI2JnM3h/qI97FMqtZTLlb+VWkyd8JQXVrF/PA5
 PcR8y8TSux036+Wpi0oRNTmVChCFY74tgQ8ZmbaRey3I/K3YreaorlFho5G9cxs+
 H+bcVCldR9NsLGiH8AE+xpDegNSK/CokQBcpASb/6O1INZherTjjX3VTtZ/jtduX
 ao8Q8/0m4J7dpWa9NUpyXjc12GLGkbwg6BqjMEd3iJwjfHO3xJSl517efBB7Jb/z
 OYBhPvmeoYfg7+s2ghJCGd4bUAuw794lxvrenIfksw/rZzVU0L92VHSX5KuQ+PWN
 K2TTZPMYXe5Hhe7UCGkCg==
X-ME-Sender: <xms:XIF9Zq2NIxc5QUck-u-JjFrTC77aD1ToOsrAIi0lCl8gk6Y3iKbqUA>
 <xme:XIF9ZtHc3rRMrLjuINYapf8_x1anDlwVtGDVF6Hg5VlqRqVQ4jAZYCc7304awHAGI
 jWLVjRZ4fJYB9MNk-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggdekiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepffeulefhheetfeffgfevudekkeelleduiedvvdektddu
 gfeiieffjeeivefghfevnecuffhomhgrihhnpeguuhhmphgvugdrsghuihhlugenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdr
 higrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:XIF9Zi4jVAOSDx4CGIq4_RbU0zgbes49ZK5r0UUyx74oCXNxLv5U8Q>
 <xmx:XIF9Zr26uZl9fEr_gq5m1ItURncK9ZfS8KOeiuH2Wb3VVEQ-ZAZsWg>
 <xmx:XIF9ZtEUWpoNZcDArwg92A4kLVIKCoONL-fSEdASwRGt91NTpz4HBg>
 <xmx:XIF9Zk8_oZZ82nxAJ3PI8eBgS_fb42n9IVb-Zh1Jvrt-Iqdiv6n2lA>
 <xmx:XYF9ZjYzKulih-JjK7uYhlJLhH1niE59i9n514RCsCf3arxGRWLS9bWa>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B1CAD36A0075; Thu, 27 Jun 2024 11:12:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
MIME-Version: 1.0
Message-Id: <b21bca1e-6644-4dab-90d9-a7a5165ad5fa@app.fastmail.com>
In-Reply-To: <0e42f372-26b8-b94a-80bb-6403062d2f1a@loongson.cn>
References: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
 <acc08621-19c1-4ec3-9fc9-acb0eec79121@linaro.org>
 <0e42f372-26b8-b94a-80bb-6403062d2f1a@loongson.cn>
Date: Thu, 27 Jun 2024 19:12:08 +0400
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: gaosong <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>, "Bibo Mao" <maobibo@loongson.cn>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/2] hw/intc/loongson_ipi: Fix for LoongArch
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8827=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=884:13=EF=BC=8Cgaosong=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2024/6/27 =E4=B8=8B=E5=8D=882:38, Philippe Mathieu-Daud=C3=A9=
 =E5=86=99=E9=81=93:
>> On 27/6/24 06:13, Jiaxun Yang wrote:
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> Jiaxun Yang (2):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/intc/loongson_ipi: Gate MMIO=
 regions creation with property
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAINTAINERS: Add myself as a re=
viewer of LoongArch virt machine
>>
>> Maybe s/has-mmio/use-mmio/? Otherwise series:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>
> Hi,
>
> If we had done a simple test, we should have found the following=20
> problem, but obviously we didn't .

My bad, I=E2=80=99m currently traveling and sent that in rush.

I do boot tested with CI and I trust CI can catch those issues.


>
> root@loongson-KVM:~/work/code/clean/github/qemu# . /kernel.sh
> Unexpected error in object_property_find_err() at . /qom/object.c:1357.
> qemu-system-loongarch64: Property 'loongson_ipi.unnamed-gpio-out[0]' n=
ot=20
> found
> . /kernel.sh: line 16: 117708 Aborted (core dumped) .=20
> /build/qemu-system-loongarch64 -machine virt -m 8G -cpu la464 -smp 8=20
> -kernel ~/vmlinux -initrd ramdisk -serial stdio -monitor=20
> telnet:localhost. 4418,server,nowait -net nic -net user -device=20
> virtio-gpu-pci -device nec-usb-xhci,id=3Dxhci,addr=3D0x1b -device=20
> usb-tablet,id=3Dtablet,bus=3Dxhci.0, port=3D1 -device=20
> usb-tablet,id=3Dtablet,bus=3Dxhci.0, -device usb-tablet,id=3Dtablet,bu=
s=3Dxhci.=20
> port=3D1 -device usb-kbd,id=3Dkeyboard,bus=3Dxhci.0,port=3D2 -append=20
> "root=3D/dev/ram rdinit=3D/sbin/init console=3DttyS0,115200=20
> earlycon=3Duart,mmio. 0x1fe001e0" --nographic
>
>
> So to minimize interactions with the MIPS architecture, I'll submit a=20
> patch to restore loongarch_ipi for LoongArch.
>
> Thanks.
> Song Gao

--=20
- Jiaxun

