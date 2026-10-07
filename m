Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57181CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERQE-0006mr-2b; Wed, 07 Oct 2026 09:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xERQC-0006m1-2D
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:11:00 -0400
Received: from smtpout10.mo538.mail-out.ovh.net ([51.210.91.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xERQA-0000Ei-85
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:10:59 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4j0D5V0ZPsz6FR0;
 Wed,  7 Oct 2026 13:10:53 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  7 Oct 2026 13:10:53 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.33])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j0D5T2YsZz1xrR; Wed,  7 Oct 2026 13:10:53 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 EE49E2402C64; Wed,  7 Oct 2026 13:10:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S00617a45ec8-15d4-40d3-b84e-ad180e49bb48,
 55F3741E86F82430FE8C443D65E56F6716F373F4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.136.188
Message-ID: <809fa0e8-889c-43a6-95bd-6a536b6bae93@kaod.org>
Date: Wed, 7 Oct 2026 15:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO expander
 test
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 4962122364486200331
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEInt30jbAn7Ow/7fgB+j2w/UxQ/Y8Bc1Yr0npbQNJ39wud+g8sgrFx6KnyUhSE1rpCuZf/teP8heIXP2ci7DcPbtBp52drvJ8DAw4i4M5xxs+EqDpUJBmWLEoWGdciBBjczyBH8anQtDvBFK0jQpTJGuPMSJcywLJ2vY8s2etFwB7GCw4/sBAcBtUBS4xaQHOkyXxpsDo+k4EEvIjQpr9BEUbSCE/sMPGTjK+dAzf/EYj+hz3Evqm6gfEPILq1ohLfbPZ9kCmAx/Q9pbpA5pXSbasq3w5J0bwIgFeDI48rR669gRv2YDaBQ5y2OHj2rOLOPv5Xq2PT5cMAhEKHX8u8EQlfjecthirNySttu4Rvg+bIxQjGyk/Rvx+oSfJtSBWYf0NOR10V+jHSV6P2/p2g8GXKjAbz7oP5ykgrqCqw8q51DMoLIqH25i/wsjaV7m9nyuQ+I4vZFoSiA2p7EXWPkR/GVxCfTB0f8eVw4Cj9TpE9HlGFVg6/OcWjmsAHPiIxqb4yRlZ23UPVwfEkFzgrXhaVfHdEQorOkTigGygMfvRoVRE5jpxldXlwzoCBfoKEhCRZ3arecEiG5MhGCroT4ziZzZw+M5nmoqVFuvCHDYpkFfJNDWm1yOY6z3wQO9mTvcRw0CKHCtsdz/M3TsRxRcbu00Nz9BwpdoaNhQqALg
DKIM-Signature: a=rsa-sha256; bh=taFxztoqmRRv6d/v2uoqHsCs2r0py2UdzSqGlqInQ2E=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791378655; v=1;
 b=osgwRjhNyA6DS6tU/C1jDz9qvLb1RCf4U+mVR80JIsHneUi42cBSGrQud1djm+RlvuC935W5
 bzJaladprt6ceXQOLNogoQ9fk63xkqpk2WrL24UKn9phGFwuuT0DEUVMb33A5jRQiWIpqjl2dYj
 gVRVwbOQANNVDojuMJti8IzijP1IQL4xcf45rvn+lwkxVoEVUeBTI2baIgCn5Iti/KJgUlYKvAk
 ECgkblglt6cdzVK0DcWoV9uoA/aSUSX84VrDIJFUnszYdCeVBqvRwQ+C/iAiaIh92UD4CTfpY2L
 +oiTAiXQY4Fzm58QUaNrIx0ryIVqFtwU+r7HSbm7dj8uw==
Received-SPF: pass client-ip=51.210.91.39; envelope-from=clg@kaod.org;
 helo=smtpout10.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/5/26 04:04, Jamin Lin wrote:
> This series is split out from "[PATCH v1 0/11] hw/arm/aspeed: Use
> unimp array and table for unimplemented devices" to make the changes
> easier to review.
> 
> v1
>   1. sorts the ASPEED device IDs alphabetically.

This is already applied to aspeed-next along with :
https://lore.kernel.org/qemu-devel/20260930072501.2612119-1-jamin_lin@aspeedtech.com/

> v2
>   1. Split the device ID sorting change out into a separate series.
>   2. Fix the IO expander device IDs in the correct order.
>   3. Add a functional test for IO Expander 1 I2C.



Applied patch 2 to :

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


> Jamin Lin (2):
>    hw/arm/aspeed: Sort device IDs alphabetically
>    tests/functional/aarch64/test_aspeed_ast2700a2: Add I2C test for IO
>      expander 1
> 
>   include/hw/arm/aspeed_soc.h                   | 176 +++++++++---------
>   .../aarch64/test_aspeed_ast2700a2.py          |   3 +
>   2 files changed, 91 insertions(+), 88 deletions(-)
> 


