Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96ECC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwaTl-0002i4-Mq; Wed, 19 Aug 2026 03:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwaTk-0002gx-4o
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:12:52 -0400
Received: from smtpout8.mo537.mail-out.ovh.net ([51.210.91.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwaTi-0004l5-KZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:12:51 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hPySw43LMz48pW;
 Wed, 19 Aug 2026 07:12:48 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <npiggin@gmail.com>; Wed, 19 Aug 2026 07:12:48 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.94])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hPySw3GRnz6SRH;
 Wed, 19 Aug 2026 07:12:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A138B12E3F50;
 Wed, 19 Aug 2026 07:12:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00157f501f9-163f-4e50-9736-d2e6024e0b8c,
 C24CD8B75EED539221ACEA448CE881038350F7ED) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <4731356a-532f-4ecf-9f0b-ae7a6ac5f77e@kaod.org>
Date: Wed, 19 Aug 2026 09:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for PPC KVM and
 sPAPR
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20260819050545.21232-1-amachhiw@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260819050545.21232-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6300535881001708641
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFh7o15b17Lj4HYE7CewJrIIRywqLGDsiR5FHYwfwjnasy3IvLrhktK+5JqNaFFM4KudkO6LgXQzcpkGhjiHdatSuST99gZbHBPzUBjcK7W/vf+XAi+sTQt67SzYKdREfcElvJy3FfrhoE1ubGNCrwi64WiSAN3LZSrwoFDDOuN4z3S+wgNw8eUjrMjPZchwc+pybtgbQ3URu4vU+mH+tBh4118Gn78hDU1RBL9wOgyXAH+hu8b3CtPP9efY3HNnXLfG1k/Gpax1hHCMSZuWvqJbNzyd8pSoZRH4eAgE/D6y63RTq7R4S2pHVnBzJVmKjeqbwID9/ZwVds+PiIJiYjuOzj6sxZy0w9gANbvnu9UCbOtY61CZnncQH9h4W3SIGi2CkYQDxCT4VIC2oSlpY4yOVV6v5v01nLNrQuNeGl5wg5Cz8vEHjsoiW2wrXjPqgbIHGjDJy7aDoCJbUq83hwcZkx/0DpRD3LvkQ0JPN4CJZwWHL4TzTMgMdPtUVFfwMNFfT8LasajvN5S9p0XLCIL4SLAkKKUDx1PZfxAx5wJGLvEo2MMhasYYk4uMT4WuZmYMJfVHm9QGf+zeXm3oKJ3hcB5W/69qDzTHmSbcoGkPk3HM3xtJx+EIljs6gNsFE3+MyWb9BO/kyzI18ei/cESR8e34/3uCmt3tsOr9JaIyw
DKIM-Signature: a=rsa-sha256; bh=LSlsoz84kWmNfwTsZTuCwZUNYuh+7ms3+MBO/iRnNN4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787123568; v=1;
 b=RW1DF2UbZYV5GmJvj4PqAcPn6xJ8krpe21shv2i612C9kQoq9mOHkHeRwDglKwlqc28GiQao
 fXnvFTQq9kC9eo2s/QT4+JSzKTd63XXiCBFkZ1BQy9hbyWTaqOC4USM8OuUPskaRjd66yqkmtW6
 ZDfWlmMe7smoqN5u+090tkpF2tYM65SCADNJoIMPKhSxS3+CoqxrHKxSpMvU9loIxL06Lcey3vt
 xWbn4bwkC3B1F682V009WEL50QfJWHwh6FUUfJV2zLZ6crEmPUcdxtpJWDoxuCCGavi9ccu5Rsq
 gUJpVGNy3BC3JNAVZEo2mDHlsibbYu0GXJHgdaZqxbPSA==
Received-SPF: pass client-ip=51.210.91.27; envelope-from=clg@kaod.org;
 helo=smtpout8.mo537.mail-out.ovh.net
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

On 8/19/26 07:05, Amit Machhiwal wrote:
> I have been contributing to PPC KVM and sPAPR (pseries) for some time now and
> would like to get notified of incoming changes to help with code reviews.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b51f5c3e6022..1a1c77285d3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -497,6 +497,7 @@ F: tests/functional/aarch64/test_kvm.py
>   PPC KVM CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
> +R: Amit Machhiwal <amachhiw@linux.ibm.com>
>   S: Odd Fixes
>   F: target/ppc/kvm.c
>   
> @@ -1661,6 +1662,7 @@ F: tests/functional/ppc/test_40p.py
>   sPAPR (pseries)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   M: Harsh Prateek Bora <harshpb@linux.ibm.com>
> +R: Amit Machhiwal <amachhiw@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/spapr*
> 
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995


I would consider removing Nick since he has moved to other activities.
  
Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

