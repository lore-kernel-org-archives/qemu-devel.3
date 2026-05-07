Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC9CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL0zh-0002xt-H3; Thu, 07 May 2026 11:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wL0zf-0002xY-05
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:50:31 -0400
Received: from 5.mo533.mail-out.ovh.net ([54.36.140.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wL0zZ-0003Nb-Px
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:50:30 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gBGsz3pfKz61L8;
 Thu,  7 May 2026 15:50:15 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <calebs@linux.ibm.com>; Thu,  7 May 2026 15:50:15 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.22])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gBGsz2Zmgz22hh;
 Thu,  7 May 2026 15:50:15 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 525592034DB; 
 Thu,  7 May 2026 15:50:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003b1476560-5b46-4117-a4c5-fa7d79db3512,
 EDDC8C94C7FEC360C43ABB57E6DC23CBDA5D180B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f53a544c-5e66-4e0b-affa-f20445f17d4f@kaod.org>
Date: Thu, 7 May 2026 17:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add self as maintainer for XIVE
To: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Caleb Schlossin <calebs@linux.ibm.com>
References: <20260507154530.364296-1-milesg@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260507154530.364296-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13021876850043104440
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFIDIze1GHVxuFkw96WkKl+E7PUYTGXA84MPT94x3DkPvvEngP6i+NvRyrd1uZXx8rKu/UigVp/OeSKZRkRECm8ciRDMWkMTljablb1VhiknMWMd5xU/Q8eLfDdSPxIAf95bMMpUXDGHJCvRvAQwf3x8SyQp0s1d8OvxVjtFr5O9xZf5rM3s89hY4438B7biuYzRsUlAPXIS7V6cMW7NQqCdsV5+xLVqUWQ3ViyXDpWOERtR6Ao/wTy08eHPrH33xwiFgnU1dGsExLoFPYJIGvphHor/acr3VBqEpxnBPpiPi8afRLbWQY2mdt+4jEWiQeDqKbixfcKrHAv+qxUnt/3F2HUGAGfChpUOpXiGDaGbIEvwTblzeZ858s6ugLZ47K2ue34B6FcFgZI4geWhB/zr4OjESah2RPL7cDzI0Es/UeiGiaZTBfJcRikRq1av3pchWq0hqza9/D/Wry/h92Yjwtiwooe8MX2HLGT+pX57cEGICU3wQdFwMvFUQKsZMIBgDxwuhzbxrzpj4J5zalMBxKSNrLFd5uwIXs8NpRS/H7B1yQ6TH8t5+ijxtT/0Xz+GQZHApAElNt4+ZDyMlpXqhtPMRGKhF4/ygZad0WLbX1m+IvV1sHCBX6BDovWhI2eStT/3PSdmfvDKAdvV42K4TLJoCTZyCrOCnOWQHsAkA
DKIM-Signature: a=rsa-sha256; bh=CyZjB/GX3GN4xJdntckC40rPHeGCq/QqF640DB7dgJU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778169015; v=1;
 b=FOprvH0KsI0JNDV8cnq+R7mWkkqq0vJKgczZkgEwnbhrkBkCyaXbKx74sMeKSbPrlGcuZ4BQ
 6q/zbkSu3nS8EuV834tfikLB72b31f4GZyjbV2Ds+9Cr1xvvLr6opESfFx0JhOcyvUkv5gSk6/P
 LoPqzkdHqexhwZcaXD0mBJDWEn1IKM1YGUHnRF4j3pg1z2DlsTWPo1/S1vcYkVWlcTFuOCS5NeP
 9aPjgSPsK62jelmiDD13WQAJTX6E00MYG+UqbDQJrjnwfarcWRiG0Xt3GHB2/3vi1mKMsE2dOdT
 IkSfPKA3poJ8tUx+8J+SueSgNdkCrEKd4XNuLkH5WYAaA==
Received-SPF: pass client-ip=54.36.140.180; envelope-from=clg@kaod.org;
 helo=5.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/7/26 17:45, Glenn Miles wrote:
> Adding self as maintainer for XIVE
> 
> Signed-off-by: Glenn Miles (milesg@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d645953..37fb460a2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2877,8 +2877,8 @@ F: tests/qtest/libqos/fw_cfg.c
>   F: tests/qtest/fw_cfg-test.c
>   
>   XIVE
> +M: Glenn Miles <milesg@linux.ibm.com>
>   R: Gautam Menghani <gautam@linux.ibm.com>
> -R: Glenn Miles <milesg@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/*xive*

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


