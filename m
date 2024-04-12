Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F54BC04FF8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKgO-0006lZ-Mi; Fri, 12 Apr 2024 13:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKgN-0006lK-GN
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:27:23 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKgM-000342-05
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:27:23 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so1411261a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712942840; x=1713547640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=blSiuCRQkThnszztMNDft+rWd/OfnM0Cs6umsTzT5W4=;
 b=A034OmZBXdtpu4YfP+tOHKd5y61bnK4HQRsngloYCV2eqgzalE+e9I9Jgv+V/J2HgF
 pNagKEdq1yIK9iqYnh7NCQD7o+awmuEo4qE3MdQ1fveaoSMDb/svGlyn5EqqpIWTFAa1
 x2aM8k3uqsh6QbesOUNAXWlFFFDD4czjuaEfeSmp63ZkiBWYwXQUlN4ZCWsDK7Nhzs7+
 92CIKGT6ZEMv7AavPOt735LJZN5ykHoewdyg1RvFDBpO0475l/ap3fJr+HKSVVB8rBqc
 igQiajfQQSKMoDCz2swlgOvohl3wbzwfXukuobTsYJJU/MHQEK/qcgmTGxJLtHlO30QX
 Mvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942840; x=1713547640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blSiuCRQkThnszztMNDft+rWd/OfnM0Cs6umsTzT5W4=;
 b=rWT5BOvAsMqHcgAvW7p0TyLsFUWSmvbt1AqruXrzB7rR/wHy/hyc9J3693nhHGvgEz
 xwW9Rkfdxb2u0q7cwJT5EnS8X7Rv2jJgpIO6NPMOnX+65fiQSFxyfBNU0kTQrGABdR7m
 XxuB+SB/SWWnOoM0RDUPq4DJHuCl4PMOnvM6CYtE3Jhj0tXhxUu/wTqZWbc/S2dSC/bd
 SjRdQHoPsSoksCbFryYYLziua4sPh81szC5Vv7jeQ6h1Ief8w4GiBU7fPJE2j+UY/naE
 K+xpK//DZ0aVX4NdsylHyzfgupgT/yOupZAUMT9YcXguegMe9MmVWc8UkB9ucChWFvTW
 qZJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8hXI48D14ejDkW6NbHrBJJkkHg+cMSNCYjpNujBcBkdmwt15VZfD6PG8oELl8hb3zc0aFIHAVXAEfVQlxUUn8QnT5nrs=
X-Gm-Message-State: AOJu0YzrG8Og0kF+Gv9Y6iW5VZK98GD0u0iasUaU6CitL4HQjEvxtNWT
 BIHlBqVsboY8lMBXiKz7K8+qlZWqIvfB4g9A3gX1+w/5GxWIFK6IvfpbiBB+8dM=
X-Google-Smtp-Source: AGHT+IHZ6/uM8gVaOdAdxXvSBr+wsAES9Sj2lpOdOXi8re76104CgORYJUCtS4VKKCtGL50Oj+2BKQ==
X-Received: by 2002:a17:90b:e05:b0:2a2:7494:15df with SMTP id
 ge5-20020a17090b0e0500b002a2749415dfmr4851135pjb.9.1712942840469; 
 Fri, 12 Apr 2024 10:27:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a17090aac1300b002a269828bb8sm2909093pjq.40.2024.04.12.10.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:27:20 -0700 (PDT)
Message-ID: <ebe85e8f-1dc5-475c-8851-a333f38e795f@linaro.org>
Date: Fri, 12 Apr 2024 10:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw, target: Add ResetType argument to hold and exit
 phase methods
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240412160809.1260625-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 4/12/24 09:08, Peter Maydell wrote:
> We pass a ResetType argument to the Resettable class enter
> phase method, but we don't pass it to hold and exit, even though
> the callsites have it readily available. This means that if
> a device cared about the ResetType it would need to record it
> in the enter phase method to use later on. Pass the type to
> all three of the phase methods to avoid having to do that.
> 
> Commit created with
> 
>    for dir in hw target include; do \
>        spatch --macro-file scripts/cocci-macro-file.h \
>               --sp-file scripts/coccinelle/reset-type.cocci \
>               --keep-comments --smpl-spacing --in-place \
>               --include-headers --dir $dir; done
> 
> and no manual edits.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

