Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA39E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 11:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ3Yx-0002aK-En; Tue, 24 Dec 2024 06:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tQ3Yr-0002G7-Ou
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 06:58:54 -0500
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tQ3Yq-0001tF-80
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 06:58:53 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MEFfB-1tIbIi2vsz-004vRv; Tue, 24 Dec 2024 12:58:49 +0100
Message-ID: <a8046b48-1004-4cef-9783-1077245efd97@vivier.eu>
Date: Tue, 24 Dec 2024 12:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/6] linux-user: Use unique error messages for cmsg parsing
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
References: <20241218195247.5459-1-deller@kernel.org>
 <20241218195247.5459-3-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241218195247.5459-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nsqaN/kaN8qmVvByuH49+zPYOLb0iv7gwXmZZMqXV2dbmIumVSf
 hqzhbVDO1oiqmX+n3Yn26UXOCzlGvATVUH9LhVQ3oQs2iilJ0Ym3CyULhsVhU9annpQI02s
 XZQvQv7qpereiipwGPU/jk/GFYNj8rR8Z/X2nFAG3H+tSMZNaVa/70t9oepRv6lDhRJkgm8
 6VuUEfRUZymVggKFb50tQ==
UI-OutboundReport: notjunk:1;M01:P0:PpYtrsPRaS8=;J8TUcD9V5Qys0uayVDBSTkiI+1h
 hyJ95LV5CpYWmVqQmMwuK0r2WYajD0IK6Aa3z5Px1WWYx9xwsF5djK3ZbQOoEXXR+BkDqKLL1
 EG67KvE9jfS/byZCL90fKZgIthJvHLyIqngI5j738EvU+h+TSnyAoAVx/LT3METEzAr9gOTkD
 qHxVa+PGDz2PgjR1f00Ql+yUPMjZXP/of0xBiLrLStgPfVndobprXL4kemOEsOnThoz5TJknl
 EDIUgyZbvybVg4sS9ZYiHoU6Y/YhyNMadWO62uC467OUBsPRZjbPf6KbLj0VLEXSaYgqRAViM
 v9Y9de9R3zzSz02YkFmJYEuLnOjNUaXh1RZF8rpQboN868+QsdGLyQYY1DpBSlJ4mNyjJOQ6u
 DWOM3lHtQQiqZ0LXqgd+LTMEMZzALl1kVQJlvFXjIDwSUqIaXAo18fMUPBCPs4inOtzfbauBq
 IebilxyDAoSb4ejddCHJ6aSd/fYkSAUHsY8ShnOvKOWOOxeKc5QsmmyVxstGdgpz0UmAJGKqE
 RHYRRCiQno1Jp64pLCSKO/d36NRF4uv5ZJ+MKX7yzulFpU3MvT1pcyH4vE5+2bczovuGnzUTA
 DiG/44eABj9TqPzc/h3mNxDI0oznh+1CGHbHGCnmQXAmDWstjOrWVJwsm05kho1083/U/OA4K
 iCtsnAFKVv4qug9eiAKCz4usaCJfACcPd14U/O54ghSHhJALozyRkp4innkENLgzOA2e8klmA
 Zd5MDNDWvzZMsLl7QL3/MZQAEsr1qWPCXFwACbu9RuiqciRbepszgKUJMb/DboFdGcuZ7E+ds
 QzIDQx+3TeZTLT3qbcMq/4On1g8alHTIThYoxVDuVmSgN+VFgLAgn6Ozc1OLjI8euQ9Mhn5oJ
 kX6kGTGERCJ/LEUEEFVg4AqUQDK9uFkqR6nVP0xseTFCH4JyY83BCC/HiGVAS4HzvjOW+niWC
 +9RtfdcT5KTXgHX/UpiIdUFn+Z3m3WfgJu2TW1J80i86587352nXBzZPYoeLeR2hre47AziHb
 if7QlvFWGvzZEAot0z1tIekNKYQMuNI/rdAnqI5
Received-SPF: pass client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
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
> Avoid using the same error message for two different code paths
> as it complicates determining the one which actually triggered.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1ce4c79784..494323efba 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1825,7 +1825,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>                   *dst = tswap32(*dst);
>               }
>           } else {
> -            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
> +            qemu_log_mask(LOG_UNIMP, "Unsupported target ancillary data: %d/%d\n",
>                             cmsg->cmsg_level, cmsg->cmsg_type);
>               memcpy(data, target_data, len);
>           }
> @@ -2047,7 +2047,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>   
>           default:
>           unimplemented:
> -            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
> +            qemu_log_mask(LOG_UNIMP, "Unsupported host ancillary data: %d/%d\n",
>                             cmsg->cmsg_level, cmsg->cmsg_type);
>               memcpy(target_data, data, MIN(len, tgt_len));
>               if (tgt_len > len) {

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

