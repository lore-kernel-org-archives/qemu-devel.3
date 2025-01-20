Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9062C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwXf-00012F-NH; Mon, 20 Jan 2025 13:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tZwXd-00010u-59
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:30:29 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tZwWy-0006Of-Qu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:29:50 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M5wgF-1tbrGb0cId-00CFpU; Mon, 20 Jan 2025 19:29:46 +0100
Message-ID: <17bbaf51-28b3-4147-8367-9ac80fa1ae4f@vivier.eu>
Date: Mon, 20 Jan 2025 19:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
References: <20250119044122.9637-1-deller@kernel.org>
 <20250119044122.9637-2-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <20250119044122.9637-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:esMeilR5l8IL8DzjCaWeRbqcu50UsRSChq13nh9MNfoW3+vbEir
 NGm4CBObQjX6MZstim3KSwHOlycJxGpg0vuNarpBkT39giDNYqtbw5HofgC4BVnSx0ZY5mx
 mUF1DzT/Mg22WpSdUsNFwAEidFlkcMPRjkOitN1Pv6I98J2XX8mZyQA9mHt3BQxujYENW16
 n5GJbnPBbZT1jXW5gGqTw==
UI-OutboundReport: notjunk:1;M01:P0:Lsy3EuJMZrA=;fAtn7Xe9uB/K2+uGeD4ReE8EArE
 U1yqPA/5AnSm8ZdGSIpVnl+b8vwDK1sDhXRpMOd3DbaH8HQxF31kQSokxjswqEa4eh89kg+XH
 vGkQ4r5w2EEFdb7D6uRvsQwIV+Q8+N9DETbAAtUsVahSe6FhA/JBpcMFd8ElDYS1r0fXZqdnB
 DBXRwQiGH5On3GO3r5MIxC/ISBNqKRcUmzhWZtTKMnrziSE3eTmbJl1+DFZ7gI0Dy1VhcEenK
 yj+MOPwhdYSNA3nZxTHkVjQm00lH0DPif3NTxSQGvzttwJwsxuYxPn8tN4YBp99vDOJGU2IML
 MNglMjShlAiR5Ww9vHN/dQARBJX++8oACSn46LdAWz9RWqtZ3Nf648mqaobqfIw+K9pxsDA1x
 NtZ1J09lmt6QtUNHu3x+FcThd5Sk6xdQMjtFTZAz/yVFuGUsoPMB/e+DcwLvWK4qnXEm+qPxU
 JLFfE134+5ysTNHWLabLaWV1brNOHPbJ2X1+jRePoXHjQrkKRLL05tAYMXOvz4j2srlMetHKI
 YtDTQBFccJXmfOFOPRRyg5EiWuq6LkSXZ67C52IhYWBJNcXD4Yl6XDT/tGTRt0Q0Oy5BzKca8
 b9Inktd4uB68zWx05WxFDhkc8AK/I+96n3ffjE7twWnwiPjtXNWFZLReLQmKed4nrUpGiQ/n0
 h5ZPkxfaInQ1nd+FO/YSjT944Mf2VgGK/4+o83xnD65vaXoTkbRs3DM6dyMTeHviIUXmWXvt7
 M/avYiZuD3nVJvV8p3ddcPt1W0sMN0Svox8RW/URq9/xb0RKADQ5bQkvs/n1kf5A+urlIKRWF
 Cs6KI3oVxjz6AFl1hjfZNS/5StVGNmMsc1XxaJHzY3Xrj0eLEnqLB8ZWK77wAQTAff4p+x2nD
 Wsghx9ST2wPmUDXDNp5tTPIkwXkUB8IQfXsEdAZfXZt52t4zB3rbItzCXvHF+Ajf42EFjTvpV
 eTOAhcquJ3WDmSmP/Q9VdzOzIByODBwlfLEY2IgtEOGJxeiDbz2ff+uFl3nSYDVLghJ/eF0DM
 BYEUPWhlXiyQA+ThiasCJTfZNgB0xK0iv6rmzbYITdOA1Ji4+RqbNRaRwFHBFQBYKAUbcTSGL
 +Ih1T9OCJnirxkiVEu1w2FRUoK735ikyaybPfMSH0mcle2CtJUOKcP0G0vGA+W7CCCrrNNdd8
 =
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 19/01/2025 à 05:41, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Fixes this warning:
>   Unknown host IFA type: 11
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/fd-trans.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index c04a97c73a..a86ed2f4b4 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -1140,6 +1140,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
>       /* binary: depends on family type */
>       case IFA_ADDRESS:
>       case IFA_LOCAL:
> +    case IFA_PROTO:
>           break;
>       /* string */
>       case IFA_LABEL:

Stefan has reported that it breaks build on ubuntu 22.04.
IFA_PROTO has been introduced in kernel v5.18.

I think you should define QEMU_IFA_XXXX enum as it was done for QEMU_IFLA_XXX, QEMU_RTA_XXX,...

Thanks,
Laurent

