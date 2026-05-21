Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6876ACD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPx3f-0007n7-3Z; Thu, 21 May 2026 02:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPx3d-0007mV-Ib
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:39:01 -0400
Received: from smtpout7.mo534.mail-out.ovh.net ([54.36.140.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPx3b-0004qK-TB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:39:01 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gLdzM3cqvz6BkG;
 Thu, 21 May 2026 06:38:54 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 21 May 2026 06:38:54 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.77])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gLdzL4QDxz7tjQ;
 Thu, 21 May 2026 06:38:54 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 0062A1B43B57;
 Thu, 21 May 2026 06:38:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002bbe1ae97-708f-4679-9dba-69d454ae883a,
 155D954443A34AB19E7EFB78D45315E373F1C727) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <137d5d92-5dc5-4d0e-8fd1-01df54f9cf7b@kaod.org>
Date: Thu, 21 May 2026 08:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/aspeed_scu: Fix AST2600_RNG definitions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260513053749.132759-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260513053749.132759-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 12141141647892261912
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE6jM+1s/C6DzGOdsEXe/ITC9BuNJitQJ65aeMxkZpr9vxgIkX6UZKkmRWCIEuYOehRtvNT7+CcDsx/6FFSo19CIgS6vLLoNJwbekUX1Hfl0id/ekHrGYSkmG4rBGicWNyGfkxoRriZ9b7ShRtT6Ldo5Uz5pU+3p+0AkIVE4+gCJd2a1YJHmv9kvPIRV1l9uGgUzck8heajZlg6dAUhdnu8ndn6Vz2YIyZeG5U86Ij+MOYv1ZkprWiIROmTnRhbb9/RfQXc61M2p5YPX/Bkq5u8myWsYVAQE1rQ0G3fNnDmdAex8UuEdBC5/JH3+fDNEnXdPXqzZJ/3ltxyFHnW8PQOTqMS62n3Dcbm8/DcsO89kksuN1biYHG+Sy7HHorkZGukIo4/7HSx3/Q9SNtgJIfO4mQS2BCFtEXNqSeT7m7pUw99xN+R3rggqk+dj1MmKiAx0+pMKF4xy1XXTUr8JWxH+jmqDuM912bzmx8SYxXjp1dWIv3gkEfB3yQs9QRW2PgGTEDjGcPt+9+NNvFnmEGRZKU3tTXYtsOtKzVFUgZXNMFaed34XLMMkyLBTdtra4722d5pLNihyakPPy8DgMIVueh4nMbO3OwK/pORRXPZlnj387L9X8BNhtQT3PU8WJWCEyGnv9WD03ccebZ1tF4sdGbziL26uskrfJZQEThNeg
DKIM-Signature: a=rsa-sha256; bh=ZiBLaOM/2H1a74blP5O+8CBsRJ6g/GGJDioTV7wWjIw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779345536; v=1;
 b=QIWG53vu1kVnZaBTaE2VNPqv671eo+uPOkXOFsviedsY/4mxL0O6Oke05txDD8FUfaHLcnnC
 ik9j5YkL8mEJdWvZjnYM8nEM8WLrO52QYLqEoiQ5YtW6uKigeaTNm8yinj6eP8F1ADXxZqSbpub
 2W5SK6Etf+VvSRXQtF2Dx74gOSywgLjR0Xx+AvPLMJIc2mCF8At6ytE8kXAN+6W3p7ne3RMdrn/
 yMjQPDkryGOb2gPThtSCNDv3DuELF70WLKrKgzfGPfXFl34KaJ3yg/BgXEIqduODxQqq2SOQtJI
 OeE2l6jypsM6h4sDRvev0tSgAYdhwvziAMfDwtlYE0/wQ==
Received-SPF: pass client-ip=54.36.140.178; envelope-from=clg@kaod.org;
 helo=smtpout7.mo534.mail-out.ovh.net
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

On 5/13/26 07:37, Cédric Le Goater wrote:
> Commit e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support") introduced
> a typo on the definitions of the Random Number Generator registers.
> Fix that.
> 
> The implementation of RNG_CTRL and RNG_DATA should be rechecked on HW
> since the QEMU implementation always generates random data, regardless
> of RNG_CTRL. A comment in aspeed_ast2600_scu_read() admits uncertainty
> about the behavior :
> 
>      /*
>       * On hardware, RNG_DATA works regardless of the state of the
>       * enable bit in RNG_CTRL
>       *
>       * TODO: Check this is true for ast2600
>       */
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2350
> Fixes: e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/misc/aspeed_scu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index e4160356e443..9d9f43e6b563 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -128,8 +128,8 @@
>   #define AST2600_HW_STRAP2         TO_REG(0x510)
>   #define AST2600_HW_STRAP2_CLR     TO_REG(0x514)
>   #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
> -#define AST2600_RNG_CTRL          TO_REG(0x524)
> -#define AST2600_RNG_DATA          TO_REG(0x540)
> +#define AST2600_RNG_CTRL          TO_REG(0x520)
> +#define AST2600_RNG_DATA          TO_REG(0x524)
>   #define AST2600_CHIP_ID0          TO_REG(0x5B0)
>   #define AST2600_CHIP_ID1          TO_REG(0x5B4)
>   

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


