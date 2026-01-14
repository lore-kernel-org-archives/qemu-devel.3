Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00FED37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 14:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1kL-0001Ga-Mz; Wed, 14 Jan 2026 09:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vg1jz-00011b-KF
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 09:20:57 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vg1jm-0003XY-He
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 09:20:45 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260114142035epoutp01ebff6c9656724ba88b13a9506c21205d~KntOVk9Mc1994419944epoutp01K
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 14:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260114142035epoutp01ebff6c9656724ba88b13a9506c21205d~KntOVk9Mc1994419944epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1768400435;
 bh=IWS08r5THQDTfHXCpKv81QTD9mTm/+YCCPbVWTRoH4s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FIYo7sESmKbW6IMmESAnFi8BII0ogXml3NzNiv41wU61FzzX6/qMk1VtPJOW1WY10
 EpDfzQ0XpaFlzMWRzEBYZHKoSvY80nl+b95gaG4Ta2ug5CP+27MFHOI7psJ+ehXNXH
 ppJ99PXm+ZvlXKHFwLpPnaUVCoMM5392cdkcmAe0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260114142035epcas5p4e6e1070b4751994fc25053b4a7b33351~KntOFphPb2748627486epcas5p4J;
 Wed, 14 Jan 2026 14:20:35 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4drpDf0Drcz2SSKX; Wed, 14 Jan
 2026 14:20:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260114142033epcas5p1b13b9923edadcc14a861e2cce8a7c5ef~KntMqvIRu0890808908epcas5p1k;
 Wed, 14 Jan 2026 14:20:33 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260114142031epsmtip2be46004e6e47a0e0b54e7dd7b7b56c92~KntKsqb_A0416504165epsmtip2j;
 Wed, 14 Jan 2026 14:20:31 +0000 (GMT)
Date: Wed, 14 Jan 2026 19:47:53 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 y.kaushal@samsung.com, vishwa.mg@samsung.com, ashish.anand202@gmail.com
Subject: Re: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Message-ID: <tixhu4eob36aeq5cbbvtudkpzvdvigiztii4bycwuj622m5ngn@vt7rf2iln6jz>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UFgxLx8uYM10DoLXutMMNVQaq9xWBjZS5BY6RL1eRnw@mail.gmail.com>
X-CMS-MailID: 20260114142033epcas5p1b13b9923edadcc14a861e2cce8a7c5ef
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f8af0_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251223120242epcas5p44b454df5afd0d517a4562a545ad11218
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
 <20251223120012.541777-1-ashish.a6@samsung.com>
 <CAFEAcA-UFgxLx8uYM10DoLXutMMNVQaq9xWBjZS5BY6RL1eRnw@mail.gmail.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=ashish.a6@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f8af0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>It looks like there's a missing piece here: R_BPBR in the v8M
>Arm ARM says that the event register is also set on exception
>entry and exception return.
>

You're right that I'm missing this. Looking at DDI0403E_B & DDI0419E (ARMv7-M & ARMv6-M) 
Section B1.5.18:
- "An asynchronous exception at a priority that preempts any currently 
   active exception" is a WFE wakeup event
- "Any WFE wakeup event, or the execution of an exception return instruction, sets the Event Register"  

So does this imply that even in ARMv7-M/ARMv6-M (not just ARMv8-M), the event register should 
be set on:
1. Exception entry (when exception is taken/preempts)
2. Exception return

>Why do we need to do this tcg_gen_exit_tb() and set DISAS_NORETURN ?
>
>Do we even need to end the current TB on a SEV instruction ?
>

You're absolutely right - SEV doesn't need to end the TB. It just sets 
the event register. I'll remove the tcg_gen_exit_tb() and DISAS_NORETURN.


>>          case DISAS_WFE:
>>              gen_helper_wfe(tcg_env);
>> +            tcg_gen_exit_tb(NULL, 0);
>
>Why is this necessary ?
>

I think this is necessary because helper_wfe() can conditionally return (when 
event register is set), following the same pattern as WFI.

WFI helper can return if cpu_has_work(), so it needs tcg_gen_exit_tb() 
for that return path. WFE helper can return if event_register is set, 
so it also needs tcg_gen_exit_tb() for that return path


Thanks,
Ashish



------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f8af0_
Content-Type: text/plain; charset="utf-8"


------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f8af0_--

