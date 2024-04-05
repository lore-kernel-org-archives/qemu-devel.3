Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5389C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssA5-0003ns-6q; Fri, 05 Apr 2024 18:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssA4-0003nV-4u
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:35:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssA2-0006CO-CS
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:35:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0b889901bso23909205ad.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712356548; x=1712961348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/jhNtvDp4iWd1zTOQylrjGd49P06JN0eIz/TU66bK4k=;
 b=NHuQa5bps2oSzctP6DnNiYh8Hpk7Ih3nqch5zJMLH22pDa8nARsXjqcFzbGNIfv22M
 g2l9RmavMOmnmdmQpJCd0nPXV0T58YsIcxR94SjSCYqdzLGliXvJNTZWbh2BZScksOnV
 rxUnb41Rc+tOwts/cxh4yD6SBq/2od6nebz2HH0QXlpZq6gv6R/Rw2mGnDygHMoVCGwC
 9419yj6mSXnvSu/4eTKrrc8raEu3J8cqOWxMtkWkxDCAkQitfGixnpgBGc6UFq1/5xZE
 qGWst1l017LaMppdGxJdCOGLgeulBviW1tQI0TxcZ3nJcKt2WCh5PQdwzy4G7FsUSLZF
 gQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712356548; x=1712961348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/jhNtvDp4iWd1zTOQylrjGd49P06JN0eIz/TU66bK4k=;
 b=or9gh2mvKWg9fJOFhPzL1PNLdIMKyNtYwGgj1l1uJTAUd4SZtR1YuHT77uA65PygKC
 02CHDa8lD+9GODtes9XYgdihAiCLoTR+ECiH2WXAKcIeUU2xOvhpvhpiJJDg4dTYnOwm
 Ibg5wGczYCjSE0yK3va5uJwVIJJ6w5SAnRA8wMfNdgjF1CnUZYUpfyKYdWADRi720GBt
 PguYp9Knx6ZE8jFjThT+RwLm5U7c71ExQyZnLyuA8oUMoKGDBSItg3tFmdFpmtfl6/3v
 sQyeW7J4JXjn6p+JVIGCjABOnybiM2j1tlw8sjWYRidj68/0Nn/s2eF+8Gw35pBfq/oV
 AJ8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQZOkPK9kTdQrx9KMwwN1m7F7pKVyq014766eYI0qnCbT6G1hgt4Njno7suLj6P8FLZJB1EmVtb99qQplWSr6V0BY4IbE=
X-Gm-Message-State: AOJu0YyWOYGfHicnp4IMJV/Ji/Lv50pDF7hDEaH72bSrV0nmiS1RIKI8
 9F07wtDGEHz9ipoiVNrpgf/fnQQCvRC/1pQ0aMljnQdnYJyolED3y8mIj/R6ctk=
X-Google-Smtp-Source: AGHT+IG88GtInTodL5ZtCimcW5cheNhVzO3V47VZctiaHlmolasgIBR2iShB+9c6pYn82QRzSbLURQ==
X-Received: by 2002:a17:902:ac8e:b0:1dc:a605:5435 with SMTP id
 h14-20020a170902ac8e00b001dca6055435mr2833036plr.31.1712356548473; 
 Fri, 05 Apr 2024 15:35:48 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 jy11-20020a17090342cb00b001e2bfd40b86sm2139726plb.47.2024.04.05.15.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 15:35:47 -0700 (PDT)
Message-ID: <64fe66bb-1aa8-4501-9477-a25e859152c4@linaro.org>
Date: Fri, 5 Apr 2024 12:35:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] small linux-user/syscall:do_setsockopt() cleanups and
 fixes
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240331100737.2724186-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240331100737.2724186-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/31/24 00:07, Michael Tokarev wrote:
> A few cleanups and fixes for linux-user/syscall:do_setsockopt().
> 
> Michael Tokarev (4):
>    linux-user/syscall: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
>    linux-user/syscall: do_setsockopt(): make ip_mreq local to the place
>      it is used and inline target_to_host_ip_mreq()
>    linux-user/syscall: do_setsockopt(): make ip_mreq_source local to the
>      place where it is used
>    linux-user/syscall: do_setsockopt(): eliminate goto in switch for SO_SNDTIMEO
> 
>   linux-user/syscall.c | 64 +++++++++++++++++---------------------------
>   1 file changed, 25 insertions(+), 39 deletions(-)
> 

Queued, thanks.


r~

