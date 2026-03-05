Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C83CF513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHUi-0005ic-NR; Thu, 05 Mar 2026 17:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyHUg-0005hk-TY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:48:34 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyHUf-0007qJ-BK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:48:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso71588195e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772750912; x=1773355712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+633dY73xSn08tThGB24JtCEt7w15my9Oj7BSCTrS4=;
 b=bx2WwippWrJYbyijxcLWPnWMGG4y5V62K2MRyuhFLZm437o2bWxOh2reeypX1vRQAJ
 WqpGixOHyksuShabEg1/FG1t9a8+67ri3K1ZH9Y7/k5KAoBbu22ueLv8xxCEiedQ5xIa
 y1Sp7hGZOnT5umKOFUe4DTCk9SlJBaSEVNaegOqm8z1xjyWanVExt2oHM8uJYBcrysvO
 2+AD0QGOEpdmtYHxbHXKJ4Fx72g2TuJst0K+XzKEJeiSU6qdF/4vCbz8YPw8f16j/8S8
 +W+Hp33QhtQWVLcSnEM77yb/dpq0dKx2WWKB64Jjsj5L8iAHE0ETZhtVwQvQBFxh/SoS
 Msvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772750912; x=1773355712;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N+633dY73xSn08tThGB24JtCEt7w15my9Oj7BSCTrS4=;
 b=VuXtcvsTARJAYHNsXclhKMySexgdecKZKeDQzyahWV3w5OAvz7Z6S/Ht+9m0qxmj9u
 rPapz8sUAv4Ew7YwGJwl6qIR/wZc2r6oxj1a7kVOmJn2DfWwVXuJdSdbBtDl8pKZ8dh9
 ZV516whzZwMSbafwvXI2hDmk4i9+OLk9by0khWHf4Szv5EQaX/TdoC8PIZx80UUh9z7p
 GsWckDf0pdM7z5TQWpuNXYwvUC0DlR3GLWus/xa0XFeo7o7oBFhi8gEinve+4ixROl+H
 gcI+B7sIUx03kByRmXIcesqiV3BCw0m1KZaGYN/HeBFLjWB40lmQPoOc5lCKYmJuogkb
 iAXA==
X-Gm-Message-State: AOJu0Yzncex+sFUju5Hsrla3CMZkzlrrGjOR74fDvXL1BuJ/YPzspzU2
 jUpKex7i1GQEQ5Kv7JkZKfQLptF3CIgW9Iy/grHYKXc55d0Z6uDStZwG
X-Gm-Gg: ATEYQzyxourDKtqHexvONV/Opc+k8DmdgB1l2dv6sFUCZb3d8FS69S0REWUUiQrepLw
 LfGpgvTjd5ACpB1IAfUiWQNK8eEt//tTF5eogZ2z6K28/RpRgDHLSyfdPEqlNdfYbi1ZgY5K6KN
 GXd55NPQTkJkBVdnbUCeY1Bt07KwvxlMeNLXp4hySRRd9RnjaZdjDnj44THRV9r1Zv0UBjCN+Cp
 6sVglqEcSBWgX3/Zq9hQZ2RMuT6ueE7v7g9Qr6CTqTTEeVngrLd9oawaTnem/KwyTcR3HQcCqCz
 SGeQVMFa+XQwT6NU+TNQJCRr83Y49/vwWeu238P1EtO21UF87ex83wZaKIJnoEGaOMj4X6zEpbX
 2odfDDECFf18s5tKMej/Pj/St0hCkQ3qeQ+Jf9RhQ8kBqY/DxbzfffDqfz1SRwJTcBmoVRE7lDJ
 D76NPRpyJKU/8wrU2nqyX6MkPvQbf29RVZDca2IGo6onTK/BGQfFEqWYs43YCWK84OC9fmzjbkw
 4khFFHn9t/HurJJ7y7cgqol3OjgIBHi2Rjfd7aaHGhr5xg=
X-Received: by 2002:a05:600c:6388:b0:47a:7fd0:9eea with SMTP id
 5b1f17b1804b1-4852359313emr18122585e9.3.1772750911349; 
 Thu, 05 Mar 2026 14:48:31 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2989-c400-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:2989:c400:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852449e73dsm6187555e9.3.2026.03.05.14.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:48:29 -0800 (PST)
Date: Thu, 05 Mar 2026 22:48:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
In-Reply-To: <CAFEAcA-bOjd7vRKpnzU18aNUFuMb4eJYcDAH0Xcbf4SDr6ZO5g@mail.gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-12-shentey@gmail.com>
 <CAFEAcA-bOjd7vRKpnzU18aNUFuMb4eJYcDAH0Xcbf4SDr6ZO5g@mail.gmail.com>
Message-ID: <AA6DEE5C-A8B8-4B5C-BED3-2C9FE48A0CA9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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



Am 5=2E M=C3=A4rz 2026 10:03:12 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>On Tue, 3 Mar 2026 at 22:22, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> Rather than requiring users of TYPE_SERIAL to initialize the MMIO regio=
n
>> themselves, make it generic enough to be configured via properties=2E T=
his
>> makes TYPE_SERIAL more self-contained and prepares it for being turned
>> into a SysBusDevice=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  include/hw/char/serial-mm=2Eh |  3 --
>>  include/hw/char/serial=2Eh    |  4 +-
>>  hw/char/diva-gsp=2Ec          |  5 ---
>>  hw/char/serial-isa=2Ec        |  1 -
>>  hw/char/serial-mm=2Ec         | 51 -------------------------
>>  hw/char/serial-pci-multi=2Ec  |  5 ---
>>  hw/char/serial-pci=2Ec        |  1 -
>>  hw/char/serial=2Ec            | 76 ++++++++++++++++++++++++++++++-----=
--
>>  8 files changed, 66 insertions(+), 80 deletions(-)
>

Hi Peter,

>
>
>This does leave TYPE_SERIAL_MM a bit of a do-nothing
>extra wrapper, as Balaton says=2E However I don't think
>it's being used by any versioned machine types,

Most prominently, the riscv and loongson virt machines use it, but aren't =
versioned yet AFAICS=2E

> so we
>could maybe look after this at the possibility of dropping
>the wrapper (by having serial_mm_init() create a TYPE_SERIAL
>directly, and dropping TYPE_SERIAL_MM entirely)=2E I don't
>think we strictly need to do that, though -- being able
>to clean up the reset handling here is worthwhile in
>itself=2E
>
>I do have one question:
>
>> +    memory_region_init_io(&s->io, OBJECT(s),
>> +                          s->regshift ? &serial_mm_ops[s->endianness]
>> +                                      : &serial_io_ops,
>> +                          s, "serial", 8 << s->regshift);
>
>This means that users of serial_mm_init() which pass 0 for
>regshift now get serial_io_ops rather than serial_mm_ops=2E

This is correct=2E

>That affects a handful of machines=2E I'm not sure if
>this makes a guest-visible difference (very possibly not),
>but for a "refactoring" type patch like this I'd rather
>err on the safe side and keep the same MemoryRegionOps
>if we can=2E This could be awkward, though, because we
>definitely have users of TYPE_SERIAL_MM which rely on
>the default regshift property value being 0=2E Maybe we
>can have the handful of places that want the serial_io_ops
>do an explicit setting of some property to request that?
>
>The other approach is to analyse the code and satisfy
>ourselves that serial_io_ops and serial_mm_ops with
>regshift =3D=3D 0 really do have exactly identical behaviour,
>and note that in the commit message=2E

I've already sent v3 to fix the lifetime issue you pointed out and attempt=
ed to take the last approach from above=2E But then realized that a justifi=
cation in the commit message isn't as straight forward as anticipated=2E I'=
ve left some thoughts there=2E=2E=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

