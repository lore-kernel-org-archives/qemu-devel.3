Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E93C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 07:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNRLV-0002Df-Ad; Fri, 06 Jun 2025 03:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1uNRLH-00024Z-Qf
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:18:21 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1uNRL5-0006Jc-0H
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:18:18 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M6UqP-1uUJ6F1ahd-00CHo5; Fri, 06 Jun 2025 09:17:58 +0200
Message-ID: <1ec605e1-6ea4-4970-b2fd-148ae26e4519@vivier.eu>
Date: Fri, 6 Jun 2025 09:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixes: failed to call mq_open/mq_unlink in qemu-arm
To: Zhang He <zhanghe9702@163.com>
Cc: qemu-devel@nongnu.org
References: <20250605144603.17475-1-zhanghe9702@163.com>
Content-Language: en-US, fr-FR
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20250605144603.17475-1-zhanghe9702@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9D0YHr7Cxtu4rDLka+fv4+7egm+lkFDd7W1B1H4LdD0jKcWYrsL
 lspwxaWeRpI1QbQkEGrvdT877LitPskCZ6euTdR5iBlclQc7bMsn0/QI/vdVXaApkNHYzJw
 UwO3FeP+yWOAq/jUAWaQmrHJJMZB2ccewwJzjxW/25VAtY6Cdz7YYjZlO1SNH4b+vqemqJP
 3xdpRQHTut47iOQ+LQJfg==
UI-OutboundReport: notjunk:1;M01:P0:z72ZZP4yB4c=;9PhJW98ZbTPZJk5YjodoZxZT+TY
 x6rtkDFLI3iWqUnVbp0JhRCrcnMi72x/ouqx7d0wbrO5eRFrhZ2D3KD4TFz774lgDZWNIuhZ/
 hL60POQ5V+0d+0fhGvcy69P/fyPw4Ty3y6B7m1qYdJd8XPndczBLdzyczM1V97E/RfhHFTqT4
 SvpTQ9jaCPHv1eBDYItAWqKN9KK6t8hwUfcTZPE37o8qRp/iJNku5GgMgBH54rzpqGCUR/p8t
 39KKGA59TohfNgwr4qXbPt00K1DGa1f9HOtIoOk7SCUCz3IVpfCSmGsxViPAB8YxHdDF8CcPj
 DttwBvPif3ZkMeVOcsArdjAeefkR31QAUq9SaPDIuyFZ2e1u5fE2T7ZijiLvNQYbJk6mOD0E2
 2husMLHa2+xUjfDAHr/di4kagKPZlFiGOwWCjlMoZ78JNZYKyA27gz35WxO6MxEE5ALM0goll
 ErfBRJho2c5mQasVyv5xP/IzcbZd/lOKPbMSlhY4UFC19wyuCEEE2iq7USjfSSdHYTHJYQYSh
 cVFxhbqFeQYr7o7wsTv2REUpMu2khX8fdA770sKkChh2oj7qE8mwF2hwvIak3e0mJQW1HCNKg
 aupJIkGr2NGdzx6RoNgf7dXxy2KbrLaROUaPF/eO8SuMnpqFjfQ4vtam4BzAERJ250rNyQsdh
 knoDPL7aI8jZKT//mnmWaSgPwNQf1v4zEB/b0hEKevpR+STGFj83XVHoVbDQ2XZ2G5QT5yFAv
 YDD2YKz4tY+jNd9agPynqcuJSx1FuvN0uBLMeZ8D9h8kQZ+zQZw0TS3Fv5H/ZJhOygz5L/+1T
 z/I4HFHmGWV/uxiWmrXtpiQ9Oyy57PlqC/uQ4Mwlq/sgyI8XnOw1ezRhXoCC9DsTgexb/xEG4
 dHXhudyaYuCZ03nX2WSOGJqLRPDGZYDhou9t2rYbTXbkWUjVDsfHqnxuZcxxbdFP1ARdgiq44
 B8U93hbM1UvcLwMugpftXq+T6UQnlMtfpGF3Km92GNjuz9eHRX744bVdwhabmOLuAkbgCGMo0
 zHmEZrCKDYprQ1UPBN1pxG/2x35TiXVCME9zPq4v0F3LCZ09H/J+EfLjhqIaxHM6Cyn+57eY9
 nJzsK8v1mB+ohi2khxuUoC43LTwZuTtY24Jsk8la4oBr8kL2YMT5btjtqgpXOUOy/h8MlXfWi
 2V/LaL/DBcPHZvzFqAL0FN4mI/ejBNfjufSianQGuIFBx6v4YEaIbs+0bphbEB63IrziCuUyB
 D9g+qMiAq/dwyLHrFw/DWGah6cjtW44+p9PEGws+JPSuKv2kd5JBVGk5aymCjT478QrKaygyn
 MCemujodSKnnFN4hgwtyzqborI7biF4+3fWQ2kV+I3MZGEyxxeRogDsea9KGz53lGe3fUbzVA
 UYoAvABySviE/b0L9NQ1MSCAIAGbpY+EVijlQ=
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Le 05/06/2025 à 16:46, Zhang He a écrit :
> i write some bare-metal c code need mq_open/mq_unlink syscall, but
> the syscall failed in passed name param check, arg1 in this scenario
> is the correct address from user-space, arg1 - 1 not.
> i have tested in arm cortex-m55 cpu model, maybe should add conditional compile macro?
> 
> Signed-off-by: Zhang He <zhanghe9702@163.com>
> ---
>   linux-user/syscall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fc37028597..be9610176a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -13058,7 +13058,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>                   }
>                   pposix_mq_attr = &posix_mq_attr;
>               }
> -            p = lock_user_string(arg1 - 1);
> +            p = lock_user_string(arg1);
>               if (!p) {
>                   return -TARGET_EFAULT;
>               }
> @@ -13068,7 +13068,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           return ret;
>   
>       case TARGET_NR_mq_unlink:
> -        p = lock_user_string(arg1 - 1);
> +        p = lock_user_string(arg1);
>           if (!p) {
>               return -TARGET_EFAULT;
>           }

According to the original thread:

Re: [Qemu-devel] [linux-user] Added posix message queue syscalls except
https://mail.gnu.org/archive/html/qemu-devel/2008-12/msg00966.html

It comes from glibc:

/* Remove message queue named NAME.  */
int
__mq_unlink (const char *name)
{
   if (name[0] != '/')
     return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);

   int ret = INTERNAL_SYSCALL_CALL (mq_unlink, name + 1);

   /* While unlink can return either EPERM or EACCES, mq_unlink should
      return just EACCES.  */
   if (__glibc_unlikely (INTERNAL_SYSCALL_ERROR_P (ret)))
     {
       ret = INTERNAL_SYSCALL_ERRNO (ret);
       if (ret == EPERM)
         ret = EACCES;
       return INLINE_SYSCALL_ERROR_RETURN_VALUE (ret);
     }

   return ret;
}

I think the '+' is to remove the starting '/'.

So if we call it from linux-user app, the string is '/XXXX', then into 
the linux-user glibc it becomes 'XXXX', so to pass it to the host glibc 
again we need to restore the '/' by doing '- 1'.

So I don't think your change is correct.

Thanks,
Laurent


