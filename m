Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE974CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9KR-0001Fk-Eu; Fri, 29 Mar 2024 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rq9KP-0001FK-N8; Fri, 29 Mar 2024 06:19:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rq9KN-00041X-Ql; Fri, 29 Mar 2024 06:19:17 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56c0a249bacso2325196a12.1; 
 Fri, 29 Mar 2024 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711707552; x=1712312352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kb9qI7gq+IGZ5T4J3Jz/QfENZnAZjXKrcESSwJXMMDg=;
 b=h/gQPlBWvDhSg4ngGIxkR4HBq0LHghi+OdjhvxRtXti+cm/zbXMyn0E+SaiQvpi65J
 G421XV+uLtCnJjci8sf+s2AL3tfFmGHI1exYUaYNUG+ES7+6SRgI3gRI159kYdo5s/Fx
 j/Su4fwsw/nHtweWsS03SuSA0i4L/eql1h5LT91ADYdZvJYN15scaLv/VEE2dM9ReaLi
 V2AfXbF2suqdzJZaXClF8sNyCV85jD2XDPjFiyzZalXnD897EYU3QmLm25hf/Yb9dv7/
 b40zVYUGjSmFT8rkAo9oJyvnWYi5WauR8YnhpwGlS9ioc5vrUjtlQGy5UJU0eA9AxaI8
 JwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711707552; x=1712312352;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kb9qI7gq+IGZ5T4J3Jz/QfENZnAZjXKrcESSwJXMMDg=;
 b=oT+AXr3lZzTmoscJZefF8bXQ6T3Xo7TeQvbLzjKs3MtswHVF6xggDqvGUuP0jd3EOI
 tbJC3eF2VlhK12w5Eb5YreXzZG5BaWoBkaDaC2JBBfGeEtxOz5mOHjWgniK1TYTq3sQ5
 qvi+ZOpNKoMK7NxViy9Pjpr8JBamg2kh5/ijC8QyRB6re/PDLAL6feTuajYpd5sVBn9e
 +Brr/gOxAR2kJZByPCT0mD3iRL1HyuttMbfDxyVx29KnXr48CRXyN9Np8hQ4rvfKGONN
 L7Ji1iN3Q6INXofGSBRScTyfv0eYM3dbegQEZeCY7/RuuvR+8RJviUYj5gGRyXhIaBl6
 S2yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCo4ssNE3mUma70dl66OsVYW3lfedodA5omyXOUxbO2NBdFl0qr2DyDl0rx7ogaB3Ba9rbdqWh0v9hWIUv1NQgaUp6/3UYQA==
X-Gm-Message-State: AOJu0Yw1lrL47AsDrVmIYriq4U0kWEVw0pvsxf/HV5wCv+MXDk9ftg1J
 dV7w85xfwx1Cxpn68TxYNEqVQYPapPpV2M+Q7PwqzzmDUnu01GbTH4QRovZM
X-Google-Smtp-Source: AGHT+IEcl4xvJEFS+X4GlOWR7EMRJc5KHNd+RIZhyHCa1SGaaFi5ox9HF+ywEOE2XcSrO6vYJ4DSOQ==
X-Received: by 2002:a17:906:2b09:b0:a4a:20df:e032 with SMTP id
 a9-20020a1709062b0900b00a4a20dfe032mr1201226ejg.66.1711707551786; 
 Fri, 29 Mar 2024 03:19:11 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf0a70002c50961723b70ff2.dip0.t-ipconnect.de.
 [2003:fa:af0a:7000:2c50:9617:23b7:ff2])
 by smtp.gmail.com with ESMTPSA id
 ak1-20020a170906888100b00a465a012cf1sm1788323ejc.18.2024.03.29.03.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 03:19:11 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:19:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com,
 devel@lists.libvirt.org, richard.henderson@linaro.org, mst@redhat.com,
 thuth@redhat.com, qemu-trivial@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_for-9=2E0=5D_docs/about=3A_Mark?=
 =?US-ASCII?Q?_the_iaspc_machine_type_as_deprecated?=
In-Reply-To: <2dbf45c6-33a3-4ebc-a78a-75305836022e@ilande.co.uk>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
 <vyepknhyulwvmyypt74i7gvu4nqqqzhgdj2fxi66rgdnipi2co@ildhvlycqf2v>
 <2dbf45c6-33a3-4ebc-a78a-75305836022e@ilande.co.uk>
Message-ID: <2BB514FB-47D6-4B1E-9463-4F4811015F29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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



Am 28=2E M=C3=A4rz 2024 14:09:52 UTC schrieb Mark Cave-Ayland <mark=2Ecave=
-ayland@ilande=2Eco=2Euk>:
>On 27/03/2024 07:09, Gerd Hoffmann wrote:
>
>> On Tue, Mar 26, 2024 at 01:30:48PM +0000, Mark Cave-Ayland wrote:
>>> Heh I've actually been using isapc over the past couple of weeks to fi=
re up
>>> some old programs in a Windows 3 VM :)
>>=20
>> I'm wondering why these use cases can't simply use the 'pc' machine
>> type?
>>=20
>> The early pci chipsets of the 90-ies have been designed in a
>> backward-compatible manner, with devices such as the IDE controller
>> being mapped to the standard ISA ioports=2E  So even an historic OS whi=
ch
>> does not know what PCI is can run on that hardware, by simply talking t=
o
>> devices using the standard ISA io ports =2E=2E=2E
>
>Hmmm that's a fair point: I think the pc machine has a PCI-ISA bridge inc=
luded, so ISA devices can be plugged in as needed=2E The reason I ended up =
on that configuration was because I ended up chasing down a regression, and=
 wanted to quickly eliminate things such as ACPI=2E

In theory you could pass `-M acpi=3Doff` to not instantiate the PIIX4 ACPI=
 function, essentially turning the Frankenstein-PIIX4 SB into a PIIX3=2E Ho=
wever, this also removes SMI registers used by SeaBIOS to handle SMM setup =
which may create unwanted side effects=2E On a real PIIX3, these registers =
are located in the ISA function=2E I wonder if it made sense to implement t=
hat for greater compatibility=2E

What do you think? Gerd, what do you think w=2Er=2Et=2E SeaBIOS?

Best regards,
Bernhard

>
>
>ATB,
>
>Mark=2E
>
>

