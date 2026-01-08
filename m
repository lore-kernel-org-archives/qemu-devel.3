Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F1D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxGd-00021k-0a; Thu, 08 Jan 2026 16:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxGW-0001yU-Kh
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:09:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxGV-0004NI-A1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:09:56 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a102494058so10440265ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906594; x=1768511394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Duyw6ONB5GTrjYCK0aQgK9XwXkgbI2mlty9X5uZtA20=;
 b=XJ8SIC1ViGOZtKIRnrH3XkYScnrS1V+kh5qukjnsBbohgD0gb7Q49ULbDMceo98eDM
 +gZQceG4ikJISQLYVYJCOVU0krSHHlq6Vz+XXNnV70/V7XlTxWz7u4dR/Eh+fUhhctNd
 9YUC5ChTMeBAl2COXLy5EiHvFctcZKoe36R1KYjiilFergZAQu7glQOn6nM/Yw5qvOQ0
 VtTCgJI6T/F/PXxXuVrLSVmmpo0KALfpzVfdVAENxaY945lVva25SqKg7ogW38XwaU5I
 dKk4AkPldK60WNYJNN31CHCT0JMUT2yhV+dc5/rBhrnTbXgNCgJvRbAFGunNBoV5vpwj
 dJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906594; x=1768511394;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Duyw6ONB5GTrjYCK0aQgK9XwXkgbI2mlty9X5uZtA20=;
 b=ohjV1EpOkm0sV0Gbz4EE+5gBzsQPj05ZBWgNqU6RxJQZQdAhEnNCgjU1SRIevcEgbK
 R5TJU0yDpIx9Pcpmhoa0pCKXQr2Bqy2USTmcznqFS7ofznRBeFjOQpYVJMaNFEJv9Z83
 Q2yyz+EzibseaBHAqeWqiDk0x1hl1THB/WIPSL78A4k2FE4ItP8gsrJvq8fGNYxcMd52
 jnsvq0S02j+72v77mSPi9s0zf6bp8Zl6+KrMiobol6mGu/V+SYayAQKBZ6QvmVVgiGVx
 px7W5JFq8U/rbGrmrCt3QFFGeIkLbM3fexnSTUcs+8NQfKoxXEVjRZZp9qeomzpkrm9e
 67pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCPMScENJlIWxr8+FFOGl27lPsBz3COcrZF7lHL3bFUhhV85OH0bvqY5/6ovHJnGm42L6afX6Fh56u@nongnu.org
X-Gm-Message-State: AOJu0YzoULKCM+nvJiiwGk6miglf8bQ/q7lKXLgCZTjzLyv71x5VEzMT
 WUaK+w0cCtD6IQwCzfRo1n08+l5D2FebdQU051y96o77NuiOHLH0e3SLHKCBZVft4U4=
X-Gm-Gg: AY/fxX4L9YvdYGg1/hixgnBtbjdgXH9rgeNfd3fLpXi8A55wvYLADhNmTA/rxA2PIQB
 I6ocJoa8NC17SXLdAgfbjxbW9QYQbhsguAIIP50qC6q1bFQttfAMeWIBe6vhqQAOyXFhyGN9Yrn
 RvJ27IQ2T505cONajaFRGVnIUO3UtRCOZK8nYKErUy/MhnGd8TfC8reotBo+1WUMj/YCvL2mk7V
 amOQp9UCeEKk73wb/o0A0JgWX6kdt7SIq/HSBTEA4g9QdnE++K1hXSZ2PVLXy2/jYb0WUh1T9yD
 TCFJCBZRUZ4yI089EsCslhYMcBvZYbrloqAKPH4HF8ne/WM7zv24me1CwcZFj/FS2EVl0mfHAqJ
 BfUB1/3zWBguG7/SgrFFMdl0GmAMD+nCJD/JT59RbvWw0iAiuyXSkApziUZFVQBB5xF6nH++6qF
 dzP83X64nZQQmT6XWJ3JJHf+oRS+RFu2aCO+V95P7dd2sa6HtWDiuqOwI9
X-Google-Smtp-Source: AGHT+IFR31mkFwLvRIoOLJ/9xRJbw8V/uoYaM4gbXl9slUGEb8eH82wDBUsuoNmYPCHcTFhOEDwBSA==
X-Received: by 2002:a17:903:478d:b0:2a2:b620:12d9 with SMTP id
 d9443c01a7336-2a3edb0e069mr82838145ad.5.1767906593804; 
 Thu, 08 Jan 2026 13:09:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a328sm85692955ad.4.2026.01.08.13.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:09:53 -0800 (PST)
Message-ID: <0f261c7f-0c71-470b-8442-90b1e3673518@linaro.org>
Date: Thu, 8 Jan 2026 13:09:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/50] target/riscv: Drop TCG_TARGET_REG_BITS test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 54 ++++++-------------------
>   1 file changed, 13 insertions(+), 41 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

