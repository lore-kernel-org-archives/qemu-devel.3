Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA1FD29C2F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqCl-0007EN-Fm; Mon, 19 Jan 2026 09:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vhqCe-00077r-8P
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:26:01 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vhqCX-0003jc-SA
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:25:58 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260119142539epoutp0167108ffe2205c28017023d67d124a5bb~MKAE_dPvd2474624746epoutp01O
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 14:25:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260119142539epoutp0167108ffe2205c28017023d67d124a5bb~MKAE_dPvd2474624746epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1768832739;
 bh=Ml8p3Hs0n7h/1LkC90I4r0H3Wwiit+IMmckorMtofAc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=njU6GpUvibyd3MBfgIvDh3hvmZJTCvxQMFcBRsESJCwq+tbKIFFCxLFNSGbgIfiYP
 rynPCgiO1ouMDUA1ANRY7yBYcHbO/smC5U7DckjyCdTsktKUYqHbKf0rqzHeK3+3RL
 x5diG7XpPB1kjVDwkOS9BXrQB4S9kIOKsyzo0dLg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260119142539epcas5p39a2ba7dad6a41ff784a60d7b43bf3c26~MKAEkh2LL1368913689epcas5p33;
 Mon, 19 Jan 2026 14:25:39 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4dvt6B0VxFz6B9m5; Mon, 19 Jan
 2026 14:25:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260119142536epcas5p2d9236e4c2d14ea6615b502556ecab9bd~MKAClJqHE2210822108epcas5p2F;
 Mon, 19 Jan 2026 14:25:36 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260119142535epsmtip2454953449bd94c239a8a247d920e52b3~MKABlmplP1108511085epsmtip2V;
 Mon, 19 Jan 2026 14:25:35 +0000 (GMT)
Date: Mon, 19 Jan 2026 19:52:48 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 y.kaushal@samsung.com, vishwa.mg@samsung.com, ashish.anand202@gmail.com
Subject: Re: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Message-ID: <odihr4w6t7ykwqb6v2la5wvs2y3be5htxggs7rzp5wtfcvyhdz@k6wb5c3n4rdv>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-DtfMjEg2SUNeMNRHfxmyYBuJ9tn2fR0LQxfNVrVoyUA@mail.gmail.com>
X-CMS-MailID: 20260119142536epcas5p2d9236e4c2d14ea6615b502556ecab9bd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_10ab09_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251223120242epcas5p44b454df5afd0d517a4562a545ad11218
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
 <20251223120012.541777-1-ashish.a6@samsung.com>
 <CAFEAcA-UFgxLx8uYM10DoLXutMMNVQaq9xWBjZS5BY6RL1eRnw@mail.gmail.com>
 <tixhu4eob36aeq5cbbvtudkpzvdvigiztii4bycwuj622m5ngn@vt7rf2iln6jz>
 <CAFEAcA-DtfMjEg2SUNeMNRHfxmyYBuJ9tn2fR0LQxfNVrVoyUA@mail.gmail.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=ashish.a6@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_10ab09_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>I hadn't looked at the v7M documentation. Looking at the v7M Arm ARM,
>the text doesn't mention the exception-entry case, but the pseudocode
>ExceptionTaken() function unconditionally calls SetEventRegister().
>So I think this is likely a case where the manual text was wrong and
>it got corrected for v8M, rather than being a divergence in behaviour.
>For QEMU we should set the event register in both these cases
>regardless of M-profile version.
>

Hi Peter,
Thanks for clarifying this I will take this into account for v2. 

>v7M's text is also a bit confused about whether the SEVONPEND
>bit affects only interrupts, or all exceptions. v8M seems to
>consistently say "interrupts". I guess we go with "assume this
>was a mistake in the v7M text". If you happen to have convenient
>access to real hardware we could test the actual behaviour, but
>if not I would go with "only interrupts" for both v7M and v8M.

Currently I don't have access to hardware, so I will take "only interrupts" into consideration.
In future if I do get access to real hardware I will test this separately.

>Ah, I see -- currently the wfe helper calls the yield helper,
>and that always calls cpu_loop_exit(), so the helper never
>returns. (I'd assumed that because WFE is conceptually a NOP
>for us at the moment that the helper would return.)
>
>We should add a comment similar to the one we have for the
>DISAS_WFI case:
>    /* Go back to the main loop to check for interrupts */
>

Sure will take care of this in v2.


Thanks,
Ashish

------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_10ab09_
Content-Type: text/plain; charset="utf-8"


------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_10ab09_--

