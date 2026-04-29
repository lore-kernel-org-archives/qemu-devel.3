Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274DCFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI4NI-00056Y-AX; Wed, 29 Apr 2026 08:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1wI4ND-00056P-Kk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:50:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1wI4NA-0003JZ-HO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:50:39 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260429125025epoutp045810accc0d201dac5f7ce85aee64ac10~q1Neae0hr3235732357epoutp04H
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 12:50:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260429125025epoutp045810accc0d201dac5f7ce85aee64ac10~q1Neae0hr3235732357epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1777467025;
 bh=GTuucdU2OAlcj8BfVn7RB5j2AhxYgooB4aQz/pOSuKY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cpFpCwOhROTD5K58+LYMHk3MTHM7VLSkJuk6fz2x2goa6v6s5cXLvIiKqL9kSvVG/
 PGrl5kTUkBDnq4HuECkBaMlRHQraEu8YSvv7iBbCUS3/PQQBf8wpcUGF2xPP3RC4u8
 lKvYJQlOtR93r+f64KneKtygNFZz5Sh5icLcW2+c=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260429125024epcas5p3e7721392539af2382bb2aa684decdfc7~q1NdxlKcH2886528865epcas5p30;
 Wed, 29 Apr 2026 12:50:24 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4g5HG75jklz2SSKX; Wed, 29 Apr
 2026 12:50:23 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260429125023epcas5p4dabb35157221f09bebfbcfea41071658~q1NcdwtgY0094500945epcas5p4i;
 Wed, 29 Apr 2026 12:50:23 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260429125021epsmtip2c54ca8f099b16dc45076220623e69b5b~q1Na-jgNx0179601796epsmtip2S;
 Wed, 29 Apr 2026 12:50:21 +0000 (GMT)
Date: Wed, 29 Apr 2026 18:16:21 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, komlodi@google.com, clg@kaod.org,
 jamin_lin@aspeedtech.com, nabihestefan@google.com, saurabh@samsung.com, 
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com
Subject: Re: [PATCH] hw/i3c/dw-i3c: Fix incorrect BCR/DCR extraction during
 ENTDAA
Message-ID: <exdu52mug6fh3bwj7ofo3jlltyuwjfnddxobio4w3jhaq6uv7k@boxo3j5ocef2>
MIME-Version: 1.0
In-Reply-To: <a19adcf8-de59-4c34-8e19-0234fa8e68d1@linaro.org>
X-CMS-MailID: 20260429125023epcas5p4dabb35157221f09bebfbcfea41071658
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_fa53_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260428102910epcas5p3980610701ef7374b681f74d75bc34f29
References: <CGME20260428102910epcas5p3980610701ef7374b681f74d75bc34f29@epcas5p3.samsung.com>
 <20260428102503.1641162-1-ashish.a6@samsung.com>
 <a19adcf8-de59-4c34-8e19-0234fa8e68d1@linaro.org>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=ashish.a6@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_fa53_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 28/04/26 01:54PM, Philippe Mathieu-Daudé wrote:

Hi Philippe,
Thanks for the review.

>Directly use .b[] instead of .pid[]?
Will drop the anonymous struct and use .b[] directly in v2.

>Or (untested):
>
>           dcr = target_info.b[0];
>           bcr = target_info.b[1];

On BCR/DCR indices: using b[6] for BCR and b[7] for DCR per the ENTDAA frame diagram in the I3C v1.1.1 databook.


>           pid = extract64(be64_to_cpu(target_info.d), 16, 48);
>
>or:
>           pid = be64_to_cpu(target_info.d) >> 16;

On PID assembly and the be64_to_cpu suggestion:
The current loop (j * 8) was written assuming t->pid holds the logical
value (e.g. 0x0000AABBCCDDEEFF with AA as MSB). core.c sends using
(offset * 8) which puts the LSB on wire first, so the loop recovered the
original logical value end to end.

For spec compliance (pid[47:40] on wire first), given that core.c uses
(offset * 8), t->pid must be stored pre-reversed by the target modeller.
With that assumption be64_to_cpu >> 16 correctly recovers the logical pid
on the controller side on both LE and BE hosts. Will adopt this in v2 and add
a comment to i3c.h documenting this requirement for t->pid.

>
>>+        dw_i3c_update_char_table(s, cmd.dev_index + i, pid, target_info.bcr,
>>+                                 target_info.dcr, addr);

Also found a pre-existing bug in dw_i3c_update_char_table() - PID is
split at bit 32 but spec DCT layout (verified from databook) requires the
split at bit 16:
     LOC1 = pid[47:16]    (pid >> 16) & 0xffffffff
     LOC2 = pid[15:0]     pid & 0xffff
Will fold this fix into v2.

>

Will send v2 shortly.

Thanks,
Ashish

------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_fa53_
Content-Type: text/plain; charset="utf-8"


------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_fa53_--

