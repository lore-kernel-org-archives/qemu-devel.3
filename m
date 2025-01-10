Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77651E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFS5-0007WH-4u; Fri, 10 Jan 2025 08:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWFS2-0007W8-Me
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:53:27 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWFS1-00020n-1t
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:53:26 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mg6mG-1t5SPf2U0s-00q9Ru; Fri, 10 Jan 2025 14:53:21 +0100
Message-ID: <046d5854-8f4d-4095-9567-40179cd79393@vivier.eu>
Date: Fri, 10 Jan 2025 14:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] linux-user: netlink: Add emulation of
 IP_MULTICAST_IF
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
References: <20241227205449.29311-1-deller@kernel.org>
 <20241227205449.29311-5-deller@kernel.org>
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
In-Reply-To: <20241227205449.29311-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dwqJ1hspuYG+JqTHhmaCh5duiMn0FMo8XihW9n8jpjFEzgb2RIK
 T5LbOOKRcBhkw9kR3Mk2LTMQGoQEQcdzZqxLmsWXkeJJdpcZfCOd9psit+tw/Lo+P6hRuyy
 qdEOY33upkdZJIri9d8NqK5p75GxWZg8bChsqHj7/gArb8qQDpK6SUvgg6+rkdYCdrkkcAd
 8aP+QlfVgU7JNGsZnYW8g==
UI-OutboundReport: notjunk:1;M01:P0:ac6goJ0AvpY=;lW3Oqe7mmsnV4ZQSc3g29Fd/Ksz
 15z+BS6cTDKMalgk5Gt+LJO4KxqFwt5kVRrAZqbhL4sByKbPmA8rwA388T+zypW9R8GUL7DzI
 apL2gPV2Ty93Zj2E1L5l2RJl3iYsWAq/QOwdmat3ymDtIx/ymbRWieP7Ig17xFNNV5GekIG1H
 dp3A+9CZWLocZ7fd4mHA9+NwVpRMPYfram76PnivBqIIBwG3wLNLtXkPIfAafZBYLl32UXikx
 VfNk0dcwv63x1ay9DWIgiOQ4qjobK1iZHeT4xvQWkysmtaMDijShyYq3JZ1KGWhNRU6P/Jrs4
 YUurZjoADqmMDHN4o5B3MsUJCoxD/HzPCjrj3hS5c02Q/V522BYnny2zkU4hEAph6m9rODwm/
 KceFzv2t6sUx7IkuM5ZkXDNqgm8KxelHMWQsTSdqekfWKCDwywdc+GFYWj+WjuvhDaFBU3G1o
 uhTh9Od+g2j9BrGSKKaXqGVC+RUqLhlCq4OToaKW7HqFhZecVCWO8VmNgKqWT0qeveoFsoXhL
 Fk02kgpoRjdy9YpAlIU3jhUhyCHqffCt4DGtHiwyvuQofmneP6gWvXKx6sSJ0KnP2kHJY6ivs
 HAgU4aTt+k+AbKsj9821cjr90q1JJo8M5D1tzgbtmGhkMzNuHtbGECbDcpFZXZjfOh6tse9Cj
 n9TSxrppP1rTvEezhYwpwgZ/v3ymj5KYkrS9Ludklbq90nJHx09vPBWTENAs2rsPD70Vy9+Fx
 GSq32t6gcRzNAWlSX6ZX/fK5pGGRN/u8NChGSMjP9RJfBYAgJKfMgZ/vwgDLEztDpYTr6BCaD
 ejefHjXIDB2dxwzZZ+Bx9iPhzYA2P7BgSUd+mqUSVn8ku/th/qILj3QgUceACI/NBamerbs3Q
 jTRKc6oVJHLH4pZIYmzizus7po6BXys8DC209OpkyOHjweUDdG5wOYk2sZCQz9yuNHmgea/Dk
 +0rlz2k4+0VLPSN8vvLZFCkcse57mPRg/eZTdo4/SsPhS63DxQ1rEAi72C5RuyQu0f4ew5D7I
 /KXcrbETMJUqWnMpwAhNiVQTEv7WVb0kod7sZAo
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 27/12/2024 à 21:54, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Share code with IP_ADD_MEMBERSHIP/IP_DROP_MEMBERSHIP.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index bbe2560927..4360543e20 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2130,16 +2130,23 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>               }
>               ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
>               break;
> +        case IP_MULTICAST_IF:
>           case IP_ADD_MEMBERSHIP:
>           case IP_DROP_MEMBERSHIP:

Could you put in the commit message the information from ip(7):

        IP_MULTICAST_IF (since Linux 1.2)
               Set the local device for a multicast socket.  The argument
               for setsockopt(2) is an ip_mreqn or (since Linux 3.5)
               ip_mreq structure similar to IP_ADD_MEMBERSHIP, or an
               in_addr structure.  (The kernel determines which structure
               is being passed based on the size passed in optlen.)  For
               getsockopt(2), the argument is an in_addr structure.

It would help to understand why we merge IP_MULTICAST_IF and IP_ADD_MEMBERSHIP code.

>           {
>               struct ip_mreqn ip_mreq;
>               struct target_ip_mreqn *target_smreqn;
> +            int min_size;
>   
>               QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
>                                 sizeof(struct target_ip_mreq));
>   
> -            if (optlen < sizeof (struct target_ip_mreq) ||
> +            if (optname == IP_MULTICAST_IF) {
> +                min_size = sizeof(struct in_addr);
> +            } else {
> +                min_size = sizeof(struct target_ip_mreq);
> +            }
> +            if (optlen < min_size ||
>                   optlen > sizeof (struct target_ip_mreqn)) {
>                   return -TARGET_EINVAL;
>               }
> @@ -2149,7 +2156,9 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>                   return -TARGET_EFAULT;
>               }
>               ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
> -            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
> +            if (optlen >= sizeof(struct target_ip_mreq)) {
> +                ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
> +            }

I think you should have 3 parts here (like in the kernel):

if (optlen >= sizeof(struct target_ip_mreqn)) {
    ...
} else {
    if (optlen >= sizeof(struct target_ip_mreq)) {
       ...
    } else if (optlen >= sizeof(struct in_addr)) {
       ...
    }
}
>               if (optlen == sizeof(struct target_ip_mreqn)) {
>                   ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
>                   optlen = sizeof(struct ip_mreqn);

Thanks.

