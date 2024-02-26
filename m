Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9F2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reb1H-0001N1-Uk; Mon, 26 Feb 2024 08:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reb1F-0001MG-K4; Mon, 26 Feb 2024 08:27:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reb1D-0002AH-SU; Mon, 26 Feb 2024 08:27:45 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD96D4E601F;
 Mon, 26 Feb 2024 14:27:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 8NCY8WvUWzbX; Mon, 26 Feb 2024 14:27:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C45AC4E6005; Mon, 26 Feb 2024 14:27:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C30317456B4;
 Mon, 26 Feb 2024 14:27:39 +0100 (CET)
Date: Mon, 26 Feb 2024 14:27:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 06/15] hw/ide: Rename ich.c -> ich9_ahci.c
In-Reply-To: <143195db-5c46-4435-8396-bb1927544957@linaro.org>
Message-ID: <bfde2a28-3397-8713-24a3-f588b459e2dd@eik.bme.hu>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-7-philmd@linaro.org>
 <54e1f04b-bef5-7587-f6d3-a87e9e036740@eik.bme.hu>
 <143195db-5c46-4435-8396-bb1927544957@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-360580400-1708954059=:37179"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-360580400-1708954059=:37179
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 26/2/24 13:52, BALATON Zoltan wrote:
>> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> Most ICH9-related files use the 'ich9_' prefix.
>>> Mention 'AHCI' in the file name.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/ide/{ich.c => ich9_ahci.c} | 0
>> 
>> That would rather be ahci-ich9.h then analogous to ahci-allwinnet.c maybe?
>
> We can have all ICH9 functions named ich9_foo.c, or all AHCI
> implementations named bar_ahci.c. But currently there is no
> particular style enforced and we have a mix. I don't mind much.

I think if it's in hw/ide then it should follow conventions used by that 
part. (Which did not follow any convention befure but Thomas adding a 
bunch of headers using - made it have a convention now.) If it's a variant 
of AHCI like the allwinner one then it should be groupped with that and 
named accordingly. If it would be together with other ich9 parts then it 
could be grouped there or if there wasn't already an example for ahci 
variant, but in this case only ahci-ich9 seems consistent within IDE now.

Regsards,
BALATON Zoltan
--3866299591-360580400-1708954059=:37179--

