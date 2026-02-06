Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153A2EB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIGo-0003YW-Jq; Fri, 06 Feb 2026 04:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIGe-0003Vj-V6; Fri, 06 Feb 2026 04:36:49 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIGd-0005Pk-7j; Fri, 06 Feb 2026 04:36:48 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.173])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f6prW2klzz5vpp;
 Fri,  6 Feb 2026 09:36:43 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 6 Feb
 2026 10:36:42 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00290030bec-f737-423a-8065-aafc8690bb9a,
 C2DCEC2B1261BCA5104DC73024CD17A0EB88A4A8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a4980ac0-2a0d-4114-92e6-3719272ef227@kaod.org>
Date: Fri, 6 Feb 2026 10:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] hw/misc/aspeed_scu: Add AST2700 A2 silicon
 revisions
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260206053340.3716041-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: d362daad-02e5-43f6-ab2d-8f510380dfe3
X-Ovh-Tracer-Id: 13126585539415477054
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEECA4ihu89On7YIPdFP1YIGlKG0BQ4ELRzoIHN0wywv+CtmtGIgLbNZmWBTM1iFUVZuP2Wbez1r0xR9PL04j6hLoVXqWTSUHLU0TwWNvWZNDYat+3m6AOQGrZHSfZy7HZrbrQEREGRVb8DXjEPAia1FV2UzrXj7zTpZzTMREwyVrCk2s9xrH04TW0BB4ju4qjFLfV8Z+YZ+GhSGid79X2iwBz8VmWVFV1JzbbFphYZDmvTLWxvfyuTjmtobjgQ9X3ys/rz7GwHMzG6PwU1/cOUyVotMZywU26Ny5qJdJNMkVmNjiuxpRic6bMNrLh1ZqOWwRmjhgkybt2bi2fHvJJ0QChRW+a87D91n4LBzH7Wj/Ja6zJgRSuqXDE3Ne7yeZ+SjZReZTk/KId34U1WSDErkep/ZREQ1hwpf5ONmiXaclAH4aQCd2fMmUIYiYByzHOqqa3CnWXRWCYoFCCEESC/Yi1+ntLzj2SNdFf82A3uNK1VCuI9vkUXF5uSivSM+NBYrPbjR6evooWU3mwjgi/zvQlvvI4IOtr04GmXPJhdZFguzHMiTZH8G+k8SvtGq+Lvusu3EVu0Z71I7wZGYs2wL+nEsIwDKycvVI8O4OPQrSNEV/C4zlCE2GPEHfy4r6/J70QH5a8Uz0qDUSfXL24QSUdfbK6TBgHC2bRLIdruNg
DKIM-Signature: a=rsa-sha256; bh=67ATAuXTVroGjq0fGB2RVC2oXHZfn76qOVPWbvok7nI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770370603; v=1;
 b=qJi/890myFyMjRxdcGQkpNTIqlsSvcS3GZ2rc/iMMw5xjghGmA8DLAZgETfeL2r5cEOjsXDe
 ZWkUVXQat1NeO/ZieXx3yRTOM++uxhzrAjqnAPNog6r9QbDtBKyDbsLy6lDPm/xF8vE5+/DcpqT
 VjTgpFJ7bE4sgqshbZGoeM/N9/LwgQIywwRb35h/8HF45eb1kV2mQMJWOcL92PNi8TH+rb8jcC0
 8uHhnerR1gTlnIre/tIScNVM+Id8NQFAV8MlSYx/3qROnxwUm4C0kYGCtAFWJYzfQtqzjgdvZzW
 q1DvXyH0cyZXCvFgodFij8a746syEl7klM/cNNnH/DMmQ==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/6/26 06:33, Jamin Lin wrote:
> Add silicon revision definitions for AST2700 A2, and include
> them in the list of supported Aspeed silicon revisions.
> 
> This allows newer AST27x0 A2 silicon to be correctly identified via
> the SCU silicon revision register.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_scu.h | 1 +
>   hw/misc/aspeed_scu.c         | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index 313a79f2f7..d003955428 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -47,6 +47,7 @@ struct AspeedSCUState {
>   #define AST1030_A1_SILICON_REV   0x80010000U
>   #define AST1060_A2_SILICON_REV   0xA0030000U
>   #define AST2700_A1_SILICON_REV   0x06010103U
> +#define AST2700_A2_SILICON_REV   0x06020103U
>   
>   #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
>   
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 0edf9c1b16..e4160356e4 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -561,6 +561,7 @@ static uint32_t aspeed_silicon_revs[] = {
>       AST1030_A1_SILICON_REV,
>       AST1060_A2_SILICON_REV,
>       AST2700_A1_SILICON_REV,
> +    AST2700_A2_SILICON_REV,
>   };
>   
>   bool is_supported_silicon_rev(uint32_t silicon_rev)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



