Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0DCC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjUb-0007Hq-0B; Tue, 16 Jul 2024 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sTjUH-00065K-4E
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:49:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sTjUD-0004Jf-5W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:49:04 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 177EB4E6005;
 Tue, 16 Jul 2024 16:48:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kaG1qIX_pNn8; Tue, 16 Jul 2024 16:48:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1115D4E6000; Tue, 16 Jul 2024 16:48:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0F7A57470B7;
 Tue, 16 Jul 2024 16:48:55 +0200 (CEST)
Date: Tue, 16 Jul 2024 16:48:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Phil Dennis-Jordan <phil@philjordan.eu>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de, 
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, akihiko.odaki@daynix.com, 
 lists@philjordan.eu
Subject: Re: [PATCH 16/26] hw/display/apple-gfx: Asynchronous MMIO writes on
 x86-64
In-Reply-To: <CAAibmn1zEFWVt-K3LkucStVxL-jyj=EWThwwtewwyKbKodQ0Sw@mail.gmail.com>
Message-ID: <94d3d008-4793-1b61-7704-860ac6b4ba90@eik.bme.hu>
References: <20240715210705.32365-1-phil@philjordan.eu>
 <20240715210705.32365-17-phil@philjordan.eu>
 <28a35035-840a-4c70-aaba-4192f7cd8ef3@linaro.org>
 <CAAibmn1zEFWVt-K3LkucStVxL-jyj=EWThwwtewwyKbKodQ0Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1496784299-1721141336=:79122"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-1496784299-1721141336=:79122
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 16 Jul 2024, Phil Dennis-Jordan wrote:
> On Mon, 15 Jul 2024 at 23:26, Philippe Mathieu-Daudé <philmd@linaro.org>
> wrote:
>
>> Hi Phil,
>>
>> On 15/7/24 23:06, Phil Dennis-Jordan wrote:
>>> This change ensures that the MMIO write calls into the PVG
>>> framework are performed asynchronously on a background dispatch
>>> queue. Without this, we rapidly run into re-entrant MMIO issues.
>>>
>>> This problem only seems to exist on x86-64 hosts. Conversely,
>>> doing it async on arm64/vmapple causes other issues,
>>
>> Such as?
>>
>
> Sorry for being vague. I've just refreshed my memory by testing with async
> MMIO writes on aarch64, and the guest never manages to initialise the
> display at all. I've admittedly not attempted to debug through this in any
> significant way, though with PVG being something of a black box I'm not
> sure it's worth it. It works reliably on x86-64 with async writes, and on
> aarch64 with sync writes.

Only a guess but I think ARM like POWER has weak memory consistency so 
maybe some sync ops are needed between writes somewhere whereas it would 
work on X86_64 that has strong guarantees so no such explicit sync is 
needed? I may completely wrong though, it's just what this reminded me of.

Regards,
BALATON Zoltan
--3866299591-1496784299-1721141336=:79122--

