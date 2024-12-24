Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2C3E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 11:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ3YA-0001Xd-4G; Tue, 24 Dec 2024 06:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tQ3Y7-0001RO-Be
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 06:58:07 -0500
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tQ3Y5-0001Zm-H8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 06:58:07 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mdvyo-1tzfkG0XGY-00d2CF; Tue, 24 Dec 2024 12:57:58 +0100
Message-ID: <8feb2b30-9b15-4b3c-8517-efedf912745f@vivier.eu>
Date: Tue, 24 Dec 2024 12:57:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
References: <20241218195247.5459-1-deller@kernel.org>
 <20241218195247.5459-2-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241218195247.5459-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aCLyfig2OdGcc6LlVOiyacOhrvh8FjU5wz1ORrRwUEJfJDZsaQi
 2Zbrnt4+II3pXWQ2as3bDN26J/LngNhevSWvLcWKjs2A9KsN4HDx+Mr/dliDNsZOVyiiypP
 yLQu63Ds5AM4ifCSpOFs6Ye5nYSx4LQff6aL1yTPVCgoYa7pyEu1blOb6RgzxmR3WwlR4cb
 Te0rYGrBMoouDoCn2VhHg==
UI-OutboundReport: notjunk:1;M01:P0:9joAgb7UkHU=;anfUL7L+uMg2P/rJ9DtiyUFN22y
 akyyKtmSB7p8ZvYdy5Va0uq0HOUGlIAMj/JcUcMYKRJ5M0DovvbBqnaiZ7XiqMXVTBnGm3nP3
 1HU7FQATw+Dd0OHgNzgBcR18UhRp0/PkbEo6W/6gER+byEiPTJankFJlRNaplEnlXKFDZ1dr8
 Wrq9iIExxcWTvC2WX9K9GmJxtmzEzNrPcK5kK/KEWS+E1s1Zjyz/ihIIyj8+h0S2+p2vpJnKV
 PaxzGG4UHqEISnR0aovFAFc7IM3p4KIiKU5pU+s5j4jynbkGNxzsAtmmzUmRJPoBhL/CkXVsg
 cCZ6eYVPZElKueeskPSlX6HPBx81UKvjHcuRTw2n3WNzscP5khsPzUWzrESZbOTq1UYqG9G/c
 OM4g1ztMTUMPUYqQvYzIRPEfoYI6jTyofPPDcqCv7VFZ3DNsl29MQVGoYZtcH21j4hgIm2kuV
 LCsDWM+XoODEnKEJ4NjGcehZkCIekd70V37yH/W5yEXC4uMirfftIrLJN0PMB9w41w2oocyzz
 ekKliTop3Zsc28eIXUbUb/bOQ1amkuwDGBxFyXuS54Gr6vTHfzpa0pjjGcNsjJAPyuFzbTHna
 11CVj9Kb4itLD6VNqsu/7xdlkXSqbkwLlUL8wUJ6z3AePAZCP6B1mfIIPcNECWHlQsqwcisvL
 S9YBgpHGYuwAW9YPxE3/2GQ1Ds2dsmora+k83Bq8IqJDC6wHiwz+aNNE58jp0oVRFwiMRMTMH
 utCwTdgWioAB7/f4fnsuof9Ip6RPri42S/VQO8Br9XYPj1ND6WX4hoW0D8Bj95tWJZUlqwtWk
 IubMfFL0afd6GztCnq3qJAtOFYZUhkM4jjjDFpK0munGx695lG5bBkTLXedJs2CeZeZ6xbFJZ
 y8pT8ltXix/LdhjvspDIv03c2STrfyeMjf4ypUpwv5uoI2IIiF6X/xk7yvqtmihWuDtA2IRsd
 PROzTqbDAHau31Vfv7xTd0P3wgD5PnV/+AF1XioFyYp2CAkG38EEaE9HoBzdsIUeV1VFN2PGz
 WzM8OxvOmwHuOUEV/rRnHEBoVsHTz421CIy3R59
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Le 18/12/2024 à 20:52, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Fixes this warning:
>   Unknown host IFA type: 11
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/fd-trans.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index c04a97c73a..6191e3115b 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -1143,6 +1143,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
>           break;
>       /* string */
>       case IFA_LABEL:
> +    case IFA_PROTO:

IFA_PROTO is NLA_U8, it should be with IFA_ADDRESS and IFA_LOCAL, not IFA_LABEL (it is NLA_STRING).
I agree, it doesn't change anything in the code, but I like to keep same types together.

>           break;
>       /* u32 */
>       case IFA_FLAGS:

Thanks,
Laurent


