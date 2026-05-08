Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18084CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHsz-0006Sy-8n; Fri, 08 May 2026 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHsx-0006Sj-L8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:52:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHsw-0008PB-95
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:52:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so18454215e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233961; x=1778838761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6JMRgM4QLQeztAryNn/XGiaK5Xuygl6URIEOWgcm/s=;
 b=lSh70xLSi63yRrJ68+E7yXHRO/rgZQkUY8FEggoxFHGlmNCN1XuhQEs3kO39bk1uKc
 L3iJL+pEG1b60dqeEy1R+mIlEmWuA1sROCPxNjGD/IjLxBshwUOwuMlKBEvT5BWD6x4k
 +U39cxOQ8cKuvHmyNuAHSrJadpHQkGLdNJ81dofU59PYmGvl19PcIao/FuHBj+pU+Dcn
 t6rOOVZTMDGC0XfVqNgr/aNZ3YshBiQm6KYhTgmcyvwjVwMiaPC/hrApjgNT9WkUkgVk
 g/k06GgxgwCVGemZKB0CXQtKVJePDozzT6XM5FmmixnjJoMvvPyJ2x4zUDMD8fUjbV2r
 s55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233961; x=1778838761;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6JMRgM4QLQeztAryNn/XGiaK5Xuygl6URIEOWgcm/s=;
 b=NWfMSg+lfRTpCCJyIj8xhogJbIMMK+fHwZfvsWF1ZpPUo4irsYcMlAyn9mLeQlrsGc
 zsWv37QkIs2d6ZysB4x3yxu7mOrVpMb902D3guNsWr9tvtRlZbjyQsv2lB0r9QOvZEUI
 uZ0gg6I0SqGEyalMRx3mNu7MwPXwgZaOQKqEEf5D2pHdSpQSCGuNvpESXwH9D3/j80IV
 HNiecwnSRqDudmQcHmA8qHWtwxqw5+sqJrx7NevFJUi9nIEK2yhUuyWXpoLUOTGlrk/K
 lLyd+KoPFL7PtMln3t896AjbH43647HOPmjeFZodYgI5ba+0FlobyeqUNLxhTqHBGWZJ
 ziUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ87uzKNn1FKUu+xS3wm+3IRZA6W1YZv8pueEytbGbjtASm6Cf4Wd5h8k2ia4oOr84yGyrE+W7Cg8JQn@nongnu.org
X-Gm-Message-State: AOJu0YyVO0IzppPYbNGziixX7SeULDlipXoN8VfKe0qPoAeA6F7dN72D
 Y9dhr6XcuYxqSa09vzySMOC+GXI+/Cfqo/tZqUHyi79s6TzgB11tVlNef5eMarf1LlxGtOEWMQX
 mzp37jHc=
X-Gm-Gg: AeBDietOmlyGQfv8ace8tGPfWcChtJjzvyiA4NSlx//DgODCHAtu5vNU8FRRFjoy7aJ
 y4ZZoFIH25LgLwV6Z8SAJ6jBTXV40ORpj7Sk0TtpWkJxlGwNFA3Bthv25VdAVucGOfgyfmnf76m
 YAumldSOrMQ5VGhC9B77xX1x2Ad++pBUiERy1EUeDordo/326a7tQ5bqNTYcd7F/5MfPGpMUkTC
 nHF7fnQR9KakgceFYcS5Xp8feoisQ2cGt48BB/uj7LgoFwxPS0AgDOHhjpnPPea6m2ugp5rVxRI
 TMiqdVNGso1GFZax4s03NmA2GVY/sz/+tlnNjCjpfqwSnGZvbalRaoUP6CmJVFOqOqxMdYnguXJ
 X2fZ7aO6apx/6PPHC47lKfxg46p1HVu2UbEWXFzTjhdzTG5kPpbGTVaMn8oBEsRPcn2fGfZH9RI
 drc5ONAeFCxMruaa45cHL4+sM4dGyBzqV6ncSp0KoU7qoLdvzpggP7GMGVm2upeFEXStjKCg==
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48e5dffabcamr93927105e9.9.1778233960920; 
 Fri, 08 May 2026 02:52:40 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68eaf237sm32760395e9.6.2026.05.08.02.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:52:40 -0700 (PDT)
Message-ID: <17362602-5736-49fd-9d49-f292a3517f3d@linaro.org>
Date: Fri, 8 May 2026 11:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] fpu: Use accessors for tininess_before_rounding
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-12-richard.henderson@linaro.org>
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

On 8/5/26 00:17, Richard Henderson wrote:
> Rename get_float_detect_tininess to get_tininess_before_rounding
> and move to softfloat.c, as there are no external users.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 5 -----
>   fpu/softfloat.c                 | 4 ++--
>   tests/fp/fp-test.c              | 2 +-
>   fpu/softfloat-parts.c.inc       | 2 +-
>   fpu/softfloat-specialize.c.inc  | 5 +++++
>   5 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

