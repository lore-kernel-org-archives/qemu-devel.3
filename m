Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AD2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiof-0004L7-MJ; Sun, 04 Aug 2024 17:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saiod-0004KV-8n
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:30:59 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saiob-0001ji-R2
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:30:59 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3db145c8010so6409507b6e.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722807056; x=1723411856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=maKEfPGhDz8Q8REyjHDSk3c5Ot+5RjEQp9kMRfvaAkA=;
 b=nI/DZLD63rdks2xfrLcPFDT1lB1v+p2XqvEz08wOuhdHZTxHADviKMdEWOc3kSkiSx
 FOlb1biYP1DYtDQDiaUlydizvA4NE/qO13mnDidn/CHC7XMQNncnAOHIoTGuOk9BFaqJ
 GHlmPd9U/0X+wflQBA8lG/48RqNu7HuuVZAi7ESttc2Y114uvZxpp/WS4bSP2ZaUprEK
 V9uJvr3+8O2b2BvACPtmunXKwDC77g6dSyDdfvNe5fB37vCz54Zk9TEzzmXyA2kt6l7G
 FBBIn0tyF5/XG0xzds4bmVlg5ILiQEr/NxKxv46rXDahmTocTdunfXcyB7HBr7zDKDnX
 Jhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722807056; x=1723411856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=maKEfPGhDz8Q8REyjHDSk3c5Ot+5RjEQp9kMRfvaAkA=;
 b=ciesoywVeh41bo/uutG5YfeT6R2nmyPOywQ0SZuEwNjAsRxF2za9CP6MUImEvH38nh
 IJ10k/9RSnTlEsYGd6AC49WMx78QJhITupYB4CSdFeYjeMBzxJy6T1T6nsFCPKn5OXSW
 bpOIa6KaPYOd9heq+OTCkawJ9Oj4IsFUYMDNp9plcQoBNeJGdaCL21xHOp6UXQXRvJP/
 NRDcd3uACND14SPIwdtPpG7mL2Ym/9JjG+UO0ohEssYogt3kIfAPPsTtx0DGiWo9osZd
 SpQGAhnfdJXgsmv0pBQRtzoRQpme7r4daZfkNx9eYZF6HDJEGvhpPIsLQSLa5jHooAeG
 R/3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ZBfobOziW448kQFsBftPj3kyev37c9m5QlLRORxatRy4pKDz5SpG/+0avbQYAL3snW5Cn2n3jG21ds52IbEadNUXmpI=
X-Gm-Message-State: AOJu0YxlCYqMHfkOGZwi7Tglnk5UM2t3zWULj7wBAh2x9yaTKyKXeo1t
 Na694n6bbS/pX8hfD9nlZ9039PPU1HTabPFZC9PHQxSYktQGlx3qJLIK+T4Zync=
X-Google-Smtp-Source: AGHT+IGSG3hYunos95UVI0VjBQ7ufi0bCkjp0fsb+/tNI72+OZJaKU8zqmrXfjilhRvctjcebLnlPQ==
X-Received: by 2002:a05:6808:d48:b0:3da:9fe6:9719 with SMTP id
 5614622812f47-3db5582f1a2mr13300931b6e.31.1722807056005; 
 Sun, 04 Aug 2024 14:30:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec4d998sm4308991b3a.82.2024.08.04.14.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 14:30:55 -0700 (PDT)
Message-ID: <5e330644-7114-4202-be2b-fa41434fcc53@linaro.org>
Date: Mon, 5 Aug 2024 07:30:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] bsd-user: Use guest_range_valid_untagged to
 validate range
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-13-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-13-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> This is the generic validation function, so remove some hand-rolled
> ones.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

