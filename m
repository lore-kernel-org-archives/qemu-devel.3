Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB1AC36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 18:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1UPw-0002YO-DV; Sun, 06 Apr 2025 14:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u1UPu-0002Xa-1V
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 14:08:22 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u1UPr-0004qj-P1
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 14:08:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso338477666b.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743962898; x=1744567698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ps70++jYe+YEC09McFdJRKJofVL8FGBi55QiRJRTOrs=;
 b=Z2CORtGl3bX8KT/BldvpdRXuXs20vuL30IhWwEfc/CYBLt7XJ3I7rnE6nHiU+tANpi
 HKN5nNgD+SMcucyxZxmyTlywoDHjvz1NXfG+m2u1dJcLZ468p0XRs4GCRgstAiLeiTJ5
 mab5o823wehYJsmcKbr6wDbyd7iAdWa/xD1FGgwFeKA4rL69GLL1lHvFmFiUnRW2dESt
 RK4+rzy5mE+kQ0I3xgXUL1isL3dpE+u0544BNv/j7pdrv6p8SFWgpbac+Rh4HgEt0QV4
 k1DkRX5Cn8V7+wzy9cbQQ5C9c4IX3SxR5PVG4RdL1ljIDv4XtgM3d0qu8WBf3mJZxZ9L
 fmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743962898; x=1744567698;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ps70++jYe+YEC09McFdJRKJofVL8FGBi55QiRJRTOrs=;
 b=usgFiDc6ZS2XW2KhR0O6vUdaqAgSx/daaOJJfQhnjDRXwMpK+yfcbJdRdNYaAbuvTv
 7Di0IKsKL0hL6ZDW5CPKhfoRM0Hi0zFOyGLY3t9Mr1JluvbnWbIP1tJSq+2wCf3U+NOw
 HDLeBboE84Tqv7zcL371eT/uu4OcKigWSLWg9MZkYoc4oLWf70pVSEn1U9QgiEKaj1Bx
 TzLhF5kVFwFjdHbKfEU98YjjIeVpfuUsGzlQVX571HMvhyybcDSPh3ZNmZUBQG0k/gsN
 oPaG6rbS+/HbaPsEFjzh3PCgq30ZMc6/YAMAUEq8j/SbGrtuW3eLriTpqW4JEDsAZ53r
 vIsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5oX/DNDXA/YOr7I/1+mMh/fUuL+UGY281eLd4dWo5mWL3rgsNCJ74lqUP5jhoqvldtKz3o+jNOo5n@nongnu.org
X-Gm-Message-State: AOJu0YyRPNW4upKdO+liNbz5sioHx7u4k+4sPm8gxlHYKuCPmP14FB15
 Pu0wiEAf3+lTyHxd4XdVJuUsH4gafcB9ofyepDL5/9k7JYKgqu45
X-Gm-Gg: ASbGncsLUlI/b/uKJ7xPeJH1QgBTBSmOIllWYJ4rNiN4vT5TJEBIjt6Rx0H+F/eHNeG
 a3DI/5DqosYi268QkpVFzdabwxoGKjCqQ3jcW2jWeGqiuU/QtbReyC+xHC7+QOo4gU9WKBIpLLE
 DlgSDD677Vrft3pKNPj7RWDDoJ7ek4Aiwf/reh7ySqf5xzaXB8H6fZaQ4pk8dy/1C8YK6UdlFwt
 JyV9Ddg1YDYcusO/i1FNQIzQ5xmF1rvJRBXS9l1t84U1scwA4fV+aDl+lOsCe2WkSwPj1UCTQs7
 1a7MzcnhomTBw/eZ1bwJX3K+gvK23dZ9JqsSDEc1veBXBo0wdjPuE9nT1vKsHLcQWXRI1OY6aq3
 a7tXKedifL7MW5mmSRYToGaiyR1KKkgREdsqTXHsbctGTqYUycQGq
X-Google-Smtp-Source: AGHT+IHQawJxtpQ8Y6afkwyD4d80rp2PG5D9uaACqLQK32ve3SWPENRPkFwYyw6DAN/ZiQdW5GA+yw==
X-Received: by 2002:a17:907:2d94:b0:ac7:805f:9056 with SMTP id
 a640c23a62f3a-ac7d18c5f64mr1054798266b.32.1743962897412; 
 Sun, 06 Apr 2025 11:08:17 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2fcd-c200-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:2fcd:c200:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c01c0fb1sm625089866b.179.2025.04.06.11.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 11:08:17 -0700 (PDT)
Date: Sun, 06 Apr 2025 18:08:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
Message-ID: <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 6=2E April 2025 15:30:42 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>On 4/6/25 04:03, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 6=2E April 2025 01:31:49 UTC schrieb Guenter Roeck <linux@roeck-us=
=2Enet>:
>>> On 4/5/25 12:28, Bernhard Beschow wrote:
>>>>=20
>>>>=20
>>>> Am 5=2E April 2025 17:26:14 UTC schrieb Guenter Roeck <linux@roeck-us=
=2Enet>:
>>>>> On 4/5/25 07:25, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> Hi Guenter,
>>>>>>=20
>>>>>> On 5/4/25 16:00, Guenter Roeck wrote:
>>>>>>> This series is needed to support the USB interface on imx8mp-evk w=
hen
>>>>>>> booting the Linux kernel=2E
>>>>>>>=20
>>>>>>> According to the XHCI specification, ERSTBA should be written in L=
ow-High
>>>>>>> order=2E The Linux kernel writes the high word first=2E This resul=
ts in an
>>>>>>> initialization failure=2E
>>>>>>>=20
>>>>>>> The following information is found in the Linux kernel commit log=
=2E
>>>>>>>=20
>>>>>>> [Synopsys]- The host controller was design to support ERST setting
>>>>>>> during the RUN state=2E But since there is a limitation in control=
ler
>>>>>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>>>>>> It is supported when the ERSTBA is programmed in 64bit,
>>>>>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>>>>>>=20
>>>>>>> [Synopsys]- The internal initialization of event ring fetches
>>>>>>> the "Event Ring Segment Table Entry" based on the indication of
>>>>>>> ERSTBA_LO written=2E
>>>>>>>=20
>>>>>>> Add property to support writing the high word first=2E Enable it
>>>>>>> for dwc3=2E
>>>>>>>=20
>>>>>>> ----------------------------------------------------------------
>>>>>>> Guenter Roeck (2):
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw: usb: xhci: Add property=
 to support writing ERSTBA in high-low order
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/usb/hcd-dwc3: Set erstba=
-hi-lo property
>>>>>>=20
>>>>>> What about using =2Eimpl=2Emin_access_size =3D 8 instead?
>>>>>>=20
>>>>>> Could you try this patch, or provide me with a reproducer?
>>>>>>=20
>>>>>=20
>>>>> You should find everything you need to reproduce the problem at
>>>>=20
>>>> Hi Guenter,
>>>>=20
>>>> thanks for testing the new board, much appreciated=2E
>>>>=20
>>>=20
>>> In this context: Did you get the PCIe interface to work ?
>>> It instantiates for me, but interrupts don't get through=2E
>>> This is with the latest Linux kernel=2E
>>=20
>> Yeah, it works with Buildroot as described in the handbook=2E When I ap=
pend `-netdev user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0` on the c=
li I can `wget http://www=2Egoogle=2Ecom` successfully=2E When I omit it th=
ere is no network connectivity=2E This is with a 6=2E6=2E23 vendor kernel=
=2E
>>=20
>
>I had no luck with virtio-net-pci=2E virtio-pci works for me, but I can n=
ot get real PCI devices
>(such as nvme or scsi adapters) to work=2E

I now tested with the latest Buildroot recipe, changing to upstream kernel=
 version 6=2E14 and using the defconfig=2E The `wget` command still works f=
or me with virtio-net-pci=2E However, I can confirm that I need your xhci p=
atches for the usb storage device to be detected=2E

>
>> However, even with your USB patches applied, PCIe and USB are non-funct=
ional on the latest aarch64 Arch Linux kernel (v6=2E14 [1]):
>>=20
>>    [   21=2E102444] platform 32f10108=2Eusb: deferred probe pending: pl=
atform: supplier 32f10000=2Eblk-ctrl not ready
>>    [   21=2E102914] platform 32f00000=2Epcie-phy: deferred probe pendin=
g: platform: supplier 32f10000=2Eblk-ctrl not ready
>>=20
>> I suspect that some bits need to indicate stable PLLs or similar, but t=
hat needs further investigation=2E
>>=20
>
>Hmm, I had that too, but then I found that it works for me with the lates=
t upstream
>kernel=2E

I have this issue with Arch Linux but not with Buildroot=2E Strange=2E

Best regards,
Bernhard

>Try the patches at http://server=2Eroeck-us=2Enet/qemu/xhci/patches-pca/
>to see if it helps=2E The PMIC (PCA9450) may have to be present=2E
>
>You might also need to check the configuration=2E I just tried with 6=2E1=
4 again, and
>it works for me even without above patches=2E I played around with the co=
nfiguration
>to get to that point, but I don't remember what exactly what I did to mak=
e it work
>(sorry)=2E
>
>Guenter
>

