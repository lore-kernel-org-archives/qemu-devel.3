Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCCBC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 07:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vipV0-0000Tp-Lu; Thu, 22 Jan 2026 02:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vipUx-0000Se-0B
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 02:52:59 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vipUt-0003Oq-PS
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 02:52:58 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260122075247epoutp033be31b45b5866552a5df439ff3204104~M-k66Tghm2653126531epoutp035
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 07:52:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260122075247epoutp033be31b45b5866552a5df439ff3204104~M-k66Tghm2653126531epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1769068367;
 bh=Na47mxabXg3MGr1UzYGMEvZnn0FBX1d1vV4cg3/Sl+c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nPUvdyl1i23FMA9qKea+MCRX+D8rF7A69bI04bbUM8nv4Icp1c86hVs90B1+Q7tWv
 SKsL3Dg8HDCmGrywWVHJ4TvkxAJuC6ZnFQPqgt+/yAp04/W+EOUUu7d0onXX5qBOsX
 RgjTYJBOZzDdMkGyA6zf6ZJXoFo/lvraeVtNjAqE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260122075247epcas5p144e92a6960805aaecc10453c46c7f8f5~M-k6k5ePj1586415864epcas5p1p;
 Thu, 22 Jan 2026 07:52:47 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4dxYFV2sfMz6B9m7; Thu, 22 Jan
 2026 07:52:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260122075245epcas5p124286cd988101bae31dc7814d6f855d6~M-k5HimnR1586415864epcas5p1n;
 Thu, 22 Jan 2026 07:52:45 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260122075244epsmtip2a0500801e9a426ae4f67092eee9809ad~M-k31P9N52836828368epsmtip25;
 Thu, 22 Jan 2026 07:52:44 +0000 (GMT)
Date: Thu, 22 Jan 2026 13:19:57 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 saurabh@samsung.com, vishwa.mg@samsung.com, y.kaushal@samsung.com, 
 ashish.anand202@gmail.com
Subject: Re: target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Message-ID: <fmmzyufqtsuf3mbx4ss3fafmkqpr5rk625pdsplpwa4ywi3hvk@tvkyrczsr5kd>
MIME-Version: 1.0
In-Reply-To: <875x8vosy4.fsf@draig.linaro.org>
X-CMS-MailID: 20260122075245epcas5p124286cd988101bae31dc7814d6f855d6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1196f8_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f
References: <CGME20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f@epcas5p1.samsung.com>
 <20260121132421.2220928-1-ashish.a6@samsung.com>
 <875x8vosy4.fsf@draig.linaro.org>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=ashish.a6@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1196f8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>Looking at the Arm ARM for armv8m it says:
>  The Event register is a single-bit register for each PE in the system.
>  Software cannot read, and cannot write to, the Event register directly.
>
>So I wonder if this could simply be a bool - and in that case some of
>the logic simplifies.

Hi Alex,

Thanks for the suggestion! You're absolutely right - bool is more 
appropriate here since it's architecturally a single-bit register.

I'll make the change in v3 after waiting for other feedback.

Thanks,
Ashish


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1196f8_
Content-Type: text/plain; charset="utf-8"


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1196f8_--

