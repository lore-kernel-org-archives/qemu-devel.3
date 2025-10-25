Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E58CCF9E9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 20:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCkUQ-0000yn-7z; Sat, 25 Oct 2025 16:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCkUO-0000yV-5m; Sat, 25 Oct 2025 16:03:48 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCkUK-0000FQ-7C; Sat, 25 Oct 2025 16:03:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18E355972FE;
 Sat, 25 Oct 2025 22:03:39 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Vl2wa1EqAuGr; Sat, 25 Oct 2025 22:03:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F2B755972FB; Sat, 25 Oct 2025 22:03:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F0E545972F3;
 Sat, 25 Oct 2025 22:03:36 +0200 (CEST)
Date: Sat, 25 Oct 2025 22:03:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH] hw/pci-host/articia: Add variable for common type cast
In-Reply-To: <a7280729-ff67-46df-bcd3-1de5f6df84c1@linaro.org>
Message-ID: <12695325-a81c-8dc0-dc02-b63cb819ecbe@eik.bme.hu>
References: <20251025125512.19967597305@zero.eik.bme.hu>
 <a7280729-ff67-46df-bcd3-1de5f6df84c1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1054418449-1761422386=:44805"
Content-ID: <8e1bc861-3113-3fc9-6718-c075f660b563@eik.bme.hu>
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

--3866299591-1054418449-1761422386=:44805
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <af060f02-394b-fbe8-181a-f95d7a064a08@eik.bme.hu>

On Sat, 25 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 25/10/25 14:55, BALATON Zoltan wrote:
>> We need the device casted to OBJECT often enough in realize to store
>> it in a local variable that also makes function calls more readable.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> Based-on: <cover.1761346145.git.balaton@eik.bme.hu>
>> 
>> hw/pci-host/articia.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>> 
>> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
>> index 761e89bc8f..56fe3b6953 100644
>> --- a/hw/pci-host/articia.c
>> +++ b/hw/pci-host/articia.c
>> @@ -174,24 +174,24 @@ static void articia_realize(DeviceState *dev, Error 
>> **errp)
>>   {
>>       ArticiaState *s = ARTICIA(dev);
>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>> +    Object *o = OBJECT(dev);
>
> Preferably "obj".

Since you said preferably I take that as personal preference and leave it 
as it is :-) I prefer shorter names for these to match s and h and to have 
a chance to fit in the 80 char limit with long_snake_case_function_names.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I hope I can still keep your R-b.
Thanks,
BALATON Zoltan
--3866299591-1054418449-1761422386=:44805--

