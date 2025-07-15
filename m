Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4284C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgw0-00007T-CL; Tue, 15 Jul 2025 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgES-0000Ve-Ps
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:02:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgEM-0004Yf-Rx
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:02:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so36123625e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588120; x=1753192920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UNlFSgzj2n1UwvZChUhOmnewBJp2CDZWtQZsad+y6Ew=;
 b=X2FRzaokvGxxZ0vN0vl/DvPbYLsBh002YquvBji0Os2KEgVuQqBrHnNGu9mcekUqd3
 DI7bxPE4BL47VCHyhMWS05NzKL1hNSg2QnvrYxXeAuheW8ahDqusIH9VSPDWDn+dhEz+
 6DuXdx4gUzm/8ojRd9tSwzKPJiXuEF+upr5cfUUO8OednMqnVZQMs65dOFOxBTPf7rRQ
 xBRKiuP33BchVG06wkaAl7nFAeif58xvZ0PbFe7A7g8LN71sZ4E1cJy9RdXvV7kCU92g
 329SeXsBabWEK5Vlru4+9Bi0mgJsGbcnN7kcvtzOercb6uEQHbblPAN5+iJb1MqlxKxe
 J2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588120; x=1753192920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNlFSgzj2n1UwvZChUhOmnewBJp2CDZWtQZsad+y6Ew=;
 b=ucpIj9gFg6kUCQ5UKVzNth0mdSZXI7BUxqld33sRBjU+F0TF7otzgRgNJAt8IehMEc
 ByZBJeIOuausvBM4YxxOPTp870KQR+tuvdOnkbksLTZ6h/SUpSASi24TXfchnSf4qFg+
 EP8wk5PzlP4jAFs4XklGPQdwwr3EBKZ7/OfAaaq93DcVuL5hIXEFvtOZ+UJ+zl/mtnZQ
 yxSHXTzb7SZihc8kuoMrHrGR/I5E7Jw9J2n2os6GpmwPzhagTjekh38dNb6mru/U1k5u
 HnvTbiAZSpsBq/BYJBi5KRp3HO9kux8qwjAXCvWlELS55TU4rVJrZp1RmjGA/OVtq9MX
 plzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBW8JLJj4swyncafRqq3cmBKfFgXbo0d+0hRJ0OGN8kMDOzlMEEdyUTzkuP3AHqUlOloWGw56i0LIs@nongnu.org
X-Gm-Message-State: AOJu0Yy+EuZPt47pjGF4m7Ohm8eKcdBGhjvzhiA66h2oEIpnv8rFKw3K
 VEKhXbL0GQBwNIRIPEbQj7NtjKhKid1+MX5fwqCuPfSp1fFk1/FsVFR12f5cQIfzPbHhSmpMHTA
 pcI4n
X-Gm-Gg: ASbGncuFDry5XitY/V4VEqWuorqs7E244M7PgMr9MRuvXYYNprXbWg8l3hlzSzpiYn1
 5Q/7dvrTEqROVKHzY1oN1ZGG+jyoHzHc6/Ho0DBsxuDcfw4owkGCQ1QZwQFl5raVlV/jVyM58yg
 1VfhI7hnMqvz98rFg0t7W2sm/09iOFHaBeKKr1IXXAa8DXjl5SUEvZL6sPp+12PCmhmaW+jqBOg
 JN0rbPpQzapFkLVtJEfmJQlhCVDN/o6lp0Mgza/uqtCJRshys/9/kRrWnhkNew9i4TCl34rtBla
 Un7L6pXGRZDbQMviEEo1mpLuQ4Uto0XjJLG4ldR9cTw0KXFn/Ouc8T1evd40XNWB4O5Cf/eBbLv
 WAIMhJdpc6TziumP/omk7I5ekMXLIwGQT6DjH/HYruW45SkUGqGVauLSXnUjYgSphKKFf9hk=
X-Google-Smtp-Source: AGHT+IEOTDEhtZ2sQTDASygYd5Ho7vHVnuTfsTcxprlhtSrYVZibUkCZP6tUZFZcIyPpjUDvr7/+eQ==
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:8879 with SMTP id
 5b1f17b1804b1-4561e5a903dmr66453555e9.9.1752588119184; 
 Tue, 15 Jul 2025 07:01:59 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21fdsm15223556f8f.33.2025.07.15.07.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 07:01:58 -0700 (PDT)
Message-ID: <6c3f1467-8e47-4941-bd65-c27559b4bab5@linaro.org>
Date: Tue, 15 Jul 2025 16:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration: Fix postcopy latency distribution
 formatting computation
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-2-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715124552.28038-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/7/25 14:45, Fabiano Rosas wrote:
> Coverity has caught a bug in the formatting of time intervals for
> postcopy latency distribution display in 'info migrate'.
> 
> While bounds checking the labels array, sizeof is incorrectly being
> used. ARRAY_SIZE is the correct form of obtaining the size of an
> array.
> 
> Fixes: 3345fb3b6d ("migration/postcopy: Add latency distribution report for blocktime")
> Resolves: Coverity CID 1612248
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/migration-hmp-cmds.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


