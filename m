Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED19C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwEG-0006hR-Hb; Mon, 20 Jan 2025 13:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tZwEC-0006dr-2D
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:10:24 -0500
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tZwE9-0004K1-LW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:10:23 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsJXG-1tFWzb2tGU-016Ugn; Mon, 20 Jan 2025 19:10:17 +0100
Message-ID: <fc7a3ede-a321-4f7b-b9c3-6501e5cf2b74@vivier.eu>
Date: Mon, 20 Jan 2025 19:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
References: <20250119044122.9637-1-deller@kernel.org>
 <20250119044122.9637-4-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250119044122.9637-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GfukQGkNWGMayzdR+iJ1M2X1+UmxVgAResW+Q6RZUoYT+rs/vbj
 exT+QxYS6zcriFrotZchxWg8nc1HWNod1QM3hIsM05iErVnCsqvU4z/zLkjOAqVVnZl5LX7
 jhc9ALPu0TpjTASXFLeDvgXWgsw0/Eqgl8j7kneBuJI7urNfGRk2vUhtGbUejM0DpOrYuLm
 WPwQFC5W2FO4hAo2c8c2A==
UI-OutboundReport: notjunk:1;M01:P0:i59WJ8yHplg=;+jPl+H3QwfwUB82yyBMhZ+weVQe
 WKGY8emIxybCXXMC2HeIZ67qw+XFUUMqnzwCYNsXk78DOIdeE3Dd6jZhFZU96bCsFNpvjnYCT
 78qbkGP/BEYnd5ombV3de8RiAirH71UzWe+DU3V6suzYVXt4I2l/WsxupPeMa9epMc3VaZfp/
 Af0c4KjbIIy4Tj87N0L/Fv97GOERG2dr4dO4EbjyJvlYjVKovW226SqzSgjZQ0ndDuswcy0D+
 8l8UyDo7CGOmuUYMNLgoUpu5cayB5+F/qtivmwzjNxnweJanWRCYsoCJsTVblYNPx3WIo3PJc
 H3xxZAqiu7FoZ1J4xdOSublr+HhAkgWn/dYylQiZLNsUd4R5SIA2ZV7qT+xehDIp+0mnG7iqJ
 C/56RFXKKSslvo32E6q+PIt0VCYiv+AmJA91N8Qmc6KPeuEWPCOMZuJgO3m8XqFxum/sMTf0u
 iHJudUoE5DZFgh/0X374C26A04YtD/00+4WQ3IeE736ZzKePvFZspRKsaQd6SF0moGEfCN/dC
 48t8vmvyf643Kxn/jpdQwJP+dJrE12RNuu20rcRDdtvXNk3amYpAeW+4/cKuXhcYph9ZzVAUe
 f0/jOwuP0O492H/0XvrRbLme30lkc92seMmDEDmSjPRV0lUgRApckX5eGkYQw2oUjXIxLRD0W
 wDu9lUSMyMx+0bQUuDLA0UElwmSOC3Cind7rlZ0qawSHZGLvJC5cILS6LoZlKlC9Lix9esT4B
 XJ+elRLQX7Q7yo42P8xXU+4rBKET+aOpRaPpovZc+EeQLvNRh2AWwQ2fwX7aBEEibPT9uP2vY
 Gi5ogGvX+8BKREjROf8Wykw4UBOaMKnqQZC17Iivtgxfm5YG9XYVDdkgmQj2wvxiTphZ3mFmz
 bwdtpOB1tRMgvcWF6o1qlSCP4YzuMAOXc6Nh9oR2QR/QrygXsOe8HmEqH9FWBYtiKuVUp77kf
 6YfxkcR3/Uz7KyXMpa5gT2Ou/Snq5yky11QVd8fkm/KJ0K1y9JtGyNIJhX7jOKA+6R27JcQb5
 698/lPBIBq921Y5xC/0Hcr/IquEyPXQDj8pRlabOnO5R1D2PcDs+gHazvQk+5ROZ8uv8N0oX1
 RSllA4648mIIfNQW/9N8H6W51v0FhJ6sU8M0XY53sRHZyJe9b57wphninloyLELAPKK86t7W4
 =
Received-SPF: pass client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Fixes those warnings:
>   Unsupported host ancillary data: 0/8
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v2: (based on feedback by Laurent Vivier)
> - add target_in_pktinfo struct and fix copying target_in_addr fields
> ---
>   linux-user/syscall.c      | 10 ++++++++++
>   linux-user/syscall_defs.h |  6 ++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a157abc40c..df8609b4d8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1998,6 +1998,16 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                       (void *) &errh->offender, sizeof(errh->offender));
>                   break;
>               }
> +            case IP_PKTINFO:
> +            {
> +                struct in_pktinfo *pkti = data;
> +                struct target_in_pktinfo *target_pi = target_data;
> +
> +                __put_user(pkti->ipi_ifindex, &target_pi->ipi_ifindex);
> +                target_pi->ipi_spec_dst.s_addr = pkti->ipi_spec_dst.s_addr;
> +                target_pi->ipi_addr.s_addr = pkti->ipi_addr.s_addr;
> +                break;
> +            }
>               default:
>                   goto unimplemented;
>               }
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index faad9147c9..86d773add7 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2622,6 +2622,12 @@ struct target_ucred {
>       abi_uint gid;
>   };
>   
> +struct target_in_pktinfo {
> +    abi_int               ipi_ifindex;
> +    struct target_in_addr ipi_spec_dst;
> +    struct target_in_addr ipi_addr;
> +};
> +
>   typedef abi_int target_timer_t;
>   
>   #define TARGET_SIGEV_MAX_SIZE 64

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

