Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FBC1091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3JGc-0005py-EZ; Thu, 19 Mar 2026 15:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3JGb-0005pX-3z
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:42:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3JGZ-0002lO-6R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:42:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8298fad2063so606045b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773949365; x=1774554165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KDiWjsuXQr88b7E5LYVczEMty2OXp/+6TUEG2GzB9KY=;
 b=bv74CVeYDIg/iWOmOimxoK9MUB+ub73g3kup2mXl8zFWTJfmLPCp0zHYbEuTidlOKR
 gFVsU6g9OVr35/aViuPjq79SKUb0iL5HbMv3FxjyO6Qk/wLYFQjJZj2BFjJfhG96X1+R
 knpX0M+jJ83Mt0H3RJmiTetxoGMa6LVs0+Kf43Ji7icWj3icIZPe0bAx9YrSd+Rqhv9l
 np9zQHfFtbuXTpGD/M/RmbtdROXG+uV0LabNH6aHAIQGCxcRKUygdrHjKPRGonuUoIr6
 xfA40jK3IEiSAmkPWWDRnyGKpSZyI5oiBSdHgK5KM7iLWosif6xIpK9+bYce8qxn6jIq
 XrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773949365; x=1774554165;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KDiWjsuXQr88b7E5LYVczEMty2OXp/+6TUEG2GzB9KY=;
 b=NzOI88u5wYTimuh33t96WOnuL7AG8J0TKfWJ/w+Sfrq2eY1Ren6bt2bvYykyLjEYEM
 mtZrBA5Badd7HhXPUDgRYRibg6tnoC43vWJXe17b7ndJMh0XAxFXhV+KwF6n9gs3m7Ri
 TOfmpH80CBhDp/0k9Jwyr7DhQmO5T6aYuS1RqZBVe3d5t7UL6Vk5CRuxT1goOVGUs9Hg
 Cvnvh2pDmn1KYdBEtOT+SN2tN2vciy5MXDHZf/4ZKPC/tI8D7+w5Fptz9LyO5o+j0B2l
 miUu8yRQSgyVq/ljsGOsL4E/ijrX7ugKWP/Kvw8XmBwuZ5rZSbL7k7odU937FvO4Vm1I
 YY9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Ei1DrAQLpsNoCVll++MLcNKjCiZGFVQHv+gu0zpeOzR3Jb+hzGrF8rY7ULxhLmI2mEhAbDPU17E1@nongnu.org
X-Gm-Message-State: AOJu0YwAtqhkw4+I2mBpL3BcpZxTgQfe4JxNwiwbgkukun0MzYUp7VYv
 4//Wi2MSPL+cRzCW4GGpC5V2DPf6Q40m9SH3X1cv/nVK9QQgACns2D2DCHIVPYGWhvbmQT13QmJ
 W9S+IFXw=
X-Gm-Gg: ATEYQzymyF25GldIu8OABU2NaPwp3cUKeQLUVngRuT0TV9DKWB2VPOE+TXD9GyIZcz8
 map2JDRUa43NlojCjLU3MKOTWj048spfuRAO0EEB4/cyI3RoZUqbyMcKnTZBMLvhYTyBkcN8TxH
 zYaLhKckTHmUe6pCDJctCkmP9EKLZaRnsgNGbWMVZ3qy3F430cAYhaIPC5QBaWAq4Cp2l9ooJvX
 yWLR3ND8dRyS7Z9quROIP8JEBkyvPO6TpD3P6AzFbc5tH0m5YWQICagt/RiF6KQ6dJDpY0d72tb
 goG+DF2J9EpWXfVguteaiM3FDkIVT54LI9GoCgTVsGP3eyE/8nxp4FlVxSPfd0hGGNcB6ngwXWO
 vBPBraB9XwAgi8ekr2uns6D0HQsQUJBDj68BIXNtLucyFFr9enayCIS6HIknEnqpRtBC8dbXmUJ
 Fb1Rp+d00yuBc24lQ7QpvpVDQowxaDxmv6yBo=
X-Received: by 2002:a05:6a00:10d3:b0:7e8:4398:b34f with SMTP id
 d2e1a72fcca58-82a8c301dacmr385567b3a.34.1773949365173; 
 Thu, 19 Mar 2026 12:42:45 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bc1ddasm30475b3a.19.2026.03.19.12.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 12:42:44 -0700 (PDT)
Message-ID: <342f9079-018a-4c90-bb26-a1333eb67180@linaro.org>
Date: Fri, 20 Mar 2026 08:42:38 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Improve formatting for mremap()
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20260307193447.7873-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260307193447.7873-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 3/8/26 08:34, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Improve slightly the strace output for mremap().
> Print the old_address and new_address as hex values, old_size and
> new_size as unsigned, and the flags as integer.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/strace.list | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 51b5ead969..35f001fecd 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -641,7 +641,7 @@
>   { TARGET_NR_mq_unlink, "mq_unlink" , NULL, print_mq_unlink, NULL },
>   #endif
>   #ifdef TARGET_NR_mremap
> -{ TARGET_NR_mremap, "mremap" , NULL, NULL, NULL },
> +{ TARGET_NR_mremap, "mremap" , "%s(%#x,%u,%u,%d,%#x)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_msgctl
>   { TARGET_NR_msgctl, "msgctl" , NULL, NULL, NULL },

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

