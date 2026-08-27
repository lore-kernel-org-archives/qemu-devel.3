Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C5BC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 18:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzfIa-0006B7-Tf; Thu, 27 Aug 2026 14:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wzfIZ-000679-EK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 14:58:03 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wzfIX-0004Dp-Nn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 14:58:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2caed617615so2018705ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787857080; x=1788461880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rH8sSXFjHVzJoez+tRW0KkGO0UlXcpiGrSU7PjFWWFU=;
 b=QcKATPe38+tFt+KtU6GAam4n5BUiPgnnbrkHA7t36T3zmchD/05r6WufJ7gOXYIpI4
 JnM+8Zu3q2eAD7T3di1uu5pa1x5ew+bu8aAMWYlffbN6sjoO4Bh9iKoSBm1QZ/tdOtqx
 md4XvdJkaPsdYkxmMypfoZF6Dvie0Wg37ZNUp4G1qlWdgcMAmi/XcNiWkxDM3jl62Jup
 jBBVXu7yZBHmSgmNoNE4qWEDG7AV7Er3bHQh9pb2zNUvXX5MV4rzYD8eWJqjKIz2CzEW
 9DhGbGzeYNgquH3mEbALeyYYeO9pKL/i6pzOj5co0ImZO/pA7epZS3D6pyryYLmy8MIm
 rfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787857080; x=1788461880;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rH8sSXFjHVzJoez+tRW0KkGO0UlXcpiGrSU7PjFWWFU=;
 b=MNVwjZ0fUeB35Qg0NdPOPDQAVcug/SkWEGWDMWww6UDsJqKEvfmTovnFxo6QUV+2d8
 5SdDF/U+xiSoGGdGHYREPplo3bwzskXSfOZZbbwqXnicUnRRLUhZTTeyxaiedzuawMdU
 SpT26la4ffShVkDCWBtKw2ocOWYgKDkY9HD041plYVBEBjR2WDQhBddruLnf6EFO/uhs
 3EEAizF6PKMKZTJOK41hpn7RZQMPvbbk7magheympXSVJimWXjJwGhTRouPy+Cl2VSUd
 e58Rs+NryjSqCl/D7dQDQzeJwVhAB69goKqjO7iqUlt8HIGCS9dSrHTEd8DiB6V7QTRV
 OLPA==
X-Gm-Message-State: AFuF++kiPDmQxEW5tIvstOm6NOjos3GQ1Kw1qhHStGNlXwhiMsfqErCn
 fH3V0ihEaBkTpIR592tQoyFjCRypbbb5BID6vsdsAF1RWhSf80Uf6fDx
X-Gm-Gg: AR+sD11YpQ1mb7pwcp0ofzPM2nGUm/VIbe+CoG4XOLwE9yk6QYewaulxRm8qE/l0WSD
 kYgkuYNsLnHuIEtHnlh9CNUokc2u2xFcb0ghz+snR9jMvkHTqSPpN96gGBl5wE84/mdIZOfKfo0
 qBO5naliv3/E6rZ2jpcOWXSdP8zPs8m6rSVq8h287M/90AMDJSHK70bEbTs2heXkmmbWfRCPUjY
 CMJuslp/8htlBMXsUCJFEFO8r7V/71niMs0Eim1c1Kqs8TwYAqOKcgSGuTmkd4W+kLlyjTSb0kn
 /DOchZcFCRBfZgwQJ4g7pnNKaiIOtTSchlJDTF2IzJH6XRk6bSLXMpDTsM520opxU88U6SP+XlO
 SuSwuTN704xsu3ve7XbxZtbnR8mDdv7cWb/t7megJRQ98woAdMo6f+UssSWHqjXJ0tNx89cqswu
 g13rDjL0cFNZ+f8HgYXpK1cafaK/f4l1cgmjRvKSBJCY5VzZxRkLBEu13nyISV/J3reGE=
X-Received: by 2002:a17:903:19ce:b0:2d6:f6ba:263d with SMTP id
 d9443c01a7336-2d74dc7aca0mr18581345ad.7.1787857077838; 
 Thu, 27 Aug 2026 11:57:57 -0700 (PDT)
Received: from [10.42.0.135] ([14.139.241.214])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283da25c09sm36044725eec.31.2026.08.27.11.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 11:57:57 -0700 (PDT)
Message-ID: <bf444589-73e1-4cb6-8121-33d833f20431@gmail.com>
Date: Fri, 28 Aug 2026 00:27:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block: Add migration support for pflash_cfi02.c
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, kwolf@redhat.com,
 hreitz@redhat.com
References: <20260822183900.110111-1-ombarkare123@gmail.com>
 <CAFEAcA-f-=gP2GZEtTE7x=0mNvk0xL=TvHYDOvK=8GfVybuMQA@mail.gmail.com>
 <e4341a01-1a6a-46e2-8666-ee25b977a154@gmail.com>
 <CAFEAcA9RTg0=-+eokt9kfdRog+Mjkq-8==+HZCcQ1XuYtX+Nug@mail.gmail.com>
Content-Language: en-US
From: Om <ombarkare123@gmail.com>
In-Reply-To: <CAFEAcA9RTg0=-+eokt9kfdRog+Mjkq-8==+HZCcQ1XuYtX+Nug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ombarkare123@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


On 27/08/26 23:09, Peter Maydell wrote:
> On Thu, 27 Aug 2026 at 17:12, Om <ombarkare123@gmail.com> wrote:
>>
>> On 27/08/26 15:38, Peter Maydell wrote:
>>> On Sat, 22 Aug 2026 at 19:39, Om Barkare <ombarkare123@gmail.com> wrote:
>>>> +static const VMStateDescription vmstate_pflash_sector_erase = {
>>>> +    .name = "pflash_cfi02_erase_sector",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = pflash_sector_erase_needed,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
>>>> +        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
>>>> +        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +
>>>> +};
>>> Why did you choose to put this in a subsection ?
>> These states are accessed only if an erase is ongoing or if it is pending
>> which can happen if migration is performed mid-erase or when an erase
>> is suspended. As they are only accessed during an erase, so I thought I
>> would
>> put them in a subsection
> Putting them into a subsection means extra code complexity here,
> and a little bit of extra overhead in the on-the-wire format.
> We usually only put things in a subsection if we need to do
> that for migration compatibility (e.g. we added something to the
> migration state later and so we want to avoid transmitting the
> extra thing unless we really need to, so that we can still work
> with an old QEMU that doesn't expect it). In this case the bitmap
> is 1 bit per sector, and e.g. xilinx_zynq has a 128K sector size
> and 64MB total size, for 512 sectors. That's only 64 bytes for the
> bitmap, which is too small to be worth worrying about not sending.
>
> So I think we should just include these fields directly in the
> main vmstate.
>
> -- PMM


Thanks for the review
Will make the changes and submit the patch


