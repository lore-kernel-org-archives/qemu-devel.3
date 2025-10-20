Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB48CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApXW-00043R-59; Mon, 20 Oct 2025 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vApXG-00042B-RI; Mon, 20 Oct 2025 09:02:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vApXB-0005xj-VG; Mon, 20 Oct 2025 09:02:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3C9CA59703F;
 Mon, 20 Oct 2025 15:02:41 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hn76tG2pV5Xz; Mon, 20 Oct 2025 15:02:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 39A7B597306; Mon, 20 Oct 2025 15:02:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 37EC5597304;
 Mon, 20 Oct 2025 15:02:39 +0200 (CEST)
Date: Mon, 20 Oct 2025 15:02:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 03/13] hw/ppc/pegasos2: Change device tree
 generation
In-Reply-To: <2047e87f-36e8-4e5c-bdf1-6f08192ab55f@linaro.org>
Message-ID: <c7b8aea2-de8c-f4bd-6988-ce41719c10bc@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <f52d9cc6af5249e306ba7a9472ef781b8e1260aa.1760798392.git.balaton@eik.bme.hu>
 <2047e87f-36e8-4e5c-bdf1-6f08192ab55f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-274809944-1760965359=:46197"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--3866299591-274809944-1760965359=:46197
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 18/10/25 17:11, BALATON Zoltan wrote:
>> We generate a flattened device tree programmatically for VOF. Change
>> this to load the static parts from a device tree blob and only
>> generate the parts that depend on run time conditions such as CPU
>> type, memory size and PCI devices. Moving the static parts in a dts
>> makes the board code simpler and more generic.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos2.c        | 292 +++++++--------------------------------
>>   pc-bios/dtb/meson.build  |   1 +
>>   pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
>>   pc-bios/dtb/pegasos2.dts | 167 ++++++++++++++++++++++
>>   4 files changed, 220 insertions(+), 240 deletions(-)
>>   create mode 100644 pc-bios/dtb/pegasos2.dtb
>>   create mode 100644 pc-bios/dtb/pegasos2.dts
>
> Please update MAINTAINERS entries.

Covered in last patch that also adds pegasos1.dt[sb]. I could move that in 
this patch if you think that's better.

Regards,
BALATON Zoltan
--3866299591-274809944-1760965359=:46197--

