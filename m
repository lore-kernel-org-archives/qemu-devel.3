Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F157AC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wweJR-0002vu-Ns; Wed, 19 Aug 2026 07:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wweJQ-0002vj-Ey
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:18:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wweJO-0003wQ-L6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:18:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8F98583777;
 Wed, 19 Aug 2026 13:18:20 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id q53h0om9h5SU; Wed, 19 Aug 2026 13:18:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B20F6583229; Wed, 19 Aug 2026 13:18:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AFEEE583223;
 Wed, 19 Aug 2026 13:18:18 +0200 (CEST)
Date: Wed, 19 Aug 2026 13:18:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: marcandre.lureau@redhat.com
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 32/32] hw/display: mark most display adapters as
 insecure
In-Reply-To: <178708450916.1320462.1427984683087351414.b4-review@b4>
Message-ID: <d807df94-16d5-28a8-756e-b7971068e2c7@eik.bme.hu>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-33-berrange@redhat.com>
 <178708450916.1320462.1427984683087351414.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="3866299591-380028664-1787138203=:7142"
Content-ID: <bb3230fe-fbbc-0ff5-9492-a0460f21a1b0@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-380028664-1787138203=:7142
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <4bb77960-f463-de54-69d6-692f4eb2a809@eik.bme.hu>

On Wed, 19 Aug 2026, marcandre.lureau@redhat.com wrote:
>> Most of thte display adapters are emulating old hardware which is not
>> relevant to virtualization use cases.
>>
>> The exceptions that should be considered secure are Cirrus (PCI, not
>> ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.
>>
>> The Cirrus PCI decision is borderline. It has been heavily used with
>> virtualization in the past, but these days VGA / RAMFB are strongly
>> recommended instead. Due to its historical usage though, we can
>> consider the code fairly mature, even if no longer hugely relevant
>> to virtualization use cases.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Message-ID: <20250926140144.1998694-33-berrange@redhat.com>
>>
>> diff --git a/hw/display/artist.c b/hw/display/artist.c
>> index 3c884c92437c..caab4d1d4c52 100644
>> --- a/hw/display/artist.c
>> +++ b/hw/display/artist.c
>> @@ -1504,6 +1504,7 @@ static const TypeInfo artist_info = {
>>      .instance_size = sizeof(ARTISTState),
>>      .instance_init = artist_initfn,
>>      .class_init    = artist_class_init,
>> +    .secure        = false,
>>  };
>>
>>  static void artist_register_types(void)
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index f7c0006a879d..6e332e02d2fb 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -1080,6 +1080,7 @@ static const TypeInfo ati_vga_info = {
>>      .instance_size = sizeof(ATIVGAState),
>>      .class_init = ati_vga_class_init,
>>      .instance_init = ati_vga_init,
>> +    .secure = false,

I've missed the original series but why isn't the default false and 
devices that are secured set it to true? That way a new device would not 
be set secure unless the author explicitly sets it which seems better than 
assuming devices are secure when most of them aren't. Or if false is 
already the default why is it set everywhere? Isn't it enough to mark 
secure devices?

Regards,
BALATON Zoltan
--3866299591-380028664-1787138203=:7142--

