Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EF6C0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrE9-00046f-4w; Tue, 11 Feb 2025 09:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thrE0-00046M-O1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:26:57 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thrDy-0007jH-7h
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:26:56 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CD4CD4E600E;
 Tue, 11 Feb 2025 15:26:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Z1nbuUMfFFao; Tue, 11 Feb 2025 15:26:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E95104E6004; Tue, 11 Feb 2025 15:26:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E744074577C;
 Tue, 11 Feb 2025 15:26:48 +0100 (CET)
Date: Tue, 11 Feb 2025 15:26:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: Add a ppc sam460ex test
In-Reply-To: <6b18058c-8c02-4171-abb0-ca7ef7d3fd4a@redhat.com>
Message-ID: <2175f9ff-d561-b405-2a69-ef7251d6b51e@eik.bme.hu>
References: <20250203092606.491933-1-clg@redhat.com>
 <6b18058c-8c02-4171-abb0-ca7ef7d3fd4a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1862968807-1739284008=:29847"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1862968807-1739284008=:29847
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 11 Feb 2025, Thomas Huth wrote:
> On 03/02/2025 10.26, Cédric Le Goater wrote:
>> The test sequence boots from kernel a sam460ex machine with a
>> virtio-net device to check PCI.
>> 
>> The buildroot is built with config :
>>
>>    BR2_powerpc=y
>>    BR2_powerpc_440fp=y
>> 
>> and the kernel with the '44x/canyonlands' deconfig and virtio support.
>> 
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>

You can also change this Cc line to read:

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   tests/functional/meson.build          |  1 +
>>   tests/functional/test_ppc_sam460ex.py | 38 +++++++++++++++++++++++++++
>>   3 files changed, 40 insertions(+)
>>   create mode 100644 tests/functional/test_ppc_sam460ex.py
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8d30c5bafd87..e4ab6031511b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1555,6 +1555,7 @@ F: pc-bios/canyonlands.dt[sb]
>>   F: pc-bios/u-boot-sam460ex-20100605.bin
>>   F: roms/u-boot-sam460ex
>>   F: docs/system/ppc/amigang.rst
>> +F: tests/functional/test_ppc_sam460ex.py
>>     pegasos2
>>   M: BALATON Zoltan <balaton@eik.bme.hu>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 868f4a64b60b..6a5f1dc405cb 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -193,6 +193,7 @@ tests_ppc_system_thorough = [
>>     'ppc_40p',
>>     'ppc_amiga',
>>     'ppc_bamboo',
>> +  'ppc_sam460ex',
>>     'ppc_mac',
>>     'ppc_mpc8544ds',
>>     'ppc_tuxrun',
>
> I'll sort that entry alphabetically into the list, and then pick this patch 
> up for my next pull request.
>
> Thanks!
>  Thomas
>
>
--3866299591-1862968807-1739284008=:29847--

