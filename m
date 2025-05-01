Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C0FC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANSM-0005e8-6k; Thu, 01 May 2025 02:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANSD-0005VJ-EY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:31:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANSB-0000Jf-Ck
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:31:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso999299b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746081085; x=1746685885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+flyfCr2K5gCuRAHAXzcAsD7HUFjXjOK13DSSDK+KfM=;
 b=o+Wm5XCjNWSqkp53FYE3afodWgmECPYNTd5VuQ2riED1wGV/KCBcfK1zSWCX3Zp8AU
 mKF+ijo6A2WwUF5QT8yDK+sJbPiQgByKV8CGnKvfnJdJ9hY2SjQePzkGAtvPXRCnM0vx
 8UJ5K9Y5MfFG6JJI+j7PNZjgp1nqzHimiTQX8vBS3oh7K3S+N6wIwbJA+/R59tXn9l6F
 7aiWW32TfHri+hS6G1VQXga5ipp2PHyKU542hVpFODGWC+QhhKjsnFdyfRGgBKbw71EC
 csEsXvlHx64mlOAGmF4WqUPn4jLRztRn6m80wzDw/C1ROPpR8rwYBBtOzOvS/FyV+GM6
 MWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746081085; x=1746685885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+flyfCr2K5gCuRAHAXzcAsD7HUFjXjOK13DSSDK+KfM=;
 b=Mv/8dQ7ydwZnHBCuZeeJf3hMG46CZUmxVM5y5+neZwRii/yKSn8BqA3cCXJ90/o9u/
 WxbsZK0/fCWcneYIc71QUK2LCsU/dvHalzBpyHaysI3Tq3g+HeU1bDnSwRcmrAweI8Qd
 EuoIzmD3J+2smiXep2gIEYe2BgRPSl0951q0dKS8ODdlep9Fgkup5uONoNfh6RxhVj6p
 UnXGaLKwKE7tOtz+TUdlHjtEhHRNRu0jsgEFefGL0uE9hupw7vrDosp90CgOsyhvmNj+
 a/uXlSGh22cL8LvisCHUlgPgR+KxFt06XsbVhA3UryeQYg9B3aL3dHe9m9iNjTXW86GI
 Q8sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXQl+qHCjXSlYz8e47b9ZD9B7GAzbVt63y3YN5O99jgK1+NR1UXJ9SnqDRo0ZjoulkEIKZZzQtDPrj@nongnu.org
X-Gm-Message-State: AOJu0Yyx1zM5PSJ6qow3nEQIbsgiIbyhVM24iRBgAy9ZLldnYFKkZQOp
 qWfTyB3udJjuFpODLdrQiWrVefTv5ugp6XQTP6sa+wBthakniZCtQJcG5qFRp10=
X-Gm-Gg: ASbGncsWTKneBhqBFRE0xy4WsxGJAZXLoogDkZG8jgEjUckXCfEpuFrBlUQKGr+0mQl
 3fZCMewlF2EBRAq0rbnoPx0ILHsY8A4Sp9hnlHOrF3a1eCM7n9wsj9mYVkQH2mF3NF1XJjysIZ5
 Re+H+JyWhcDmY24P8JrAncXUA7U3yTnSVd4zT7LG5HK2RJeTN/NcIJUISqLxWmslGp2VAXA8p+m
 9fQsvw0AoU+g+ud/pUs+rhjjaUi/4punLhNhnatA88lW3c4R6+sW4kYVvC5AQGtrzPxKMd4zcRE
 IJaO/UBgT5tABUrId1Pma5bJzixehXRB7vwQJck0jRLR4PDSCxuwHw==
X-Google-Smtp-Source: AGHT+IGwwI7Aw3NT1EXuZzjRsWkKfsOM/D0sqBlUS/u0yvl+JOQr8ylWk6KpdrPevjzGe+wFKEj3uA==
X-Received: by 2002:a05:6a00:2402:b0:73b:71a9:a5ad with SMTP id
 d2e1a72fcca58-7404790287dmr2726732b3a.16.1746081085416; 
 Wed, 30 Apr 2025 23:31:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9f77bfsm120519b3a.109.2025.04.30.23.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 23:31:25 -0700 (PDT)
Message-ID: <baa46ce4-bcda-4845-91ab-0b1249d57468@linaro.org>
Date: Wed, 30 Apr 2025 23:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] accel/tcg: Don't use TARGET_LONG_BITS in
 decode_sleb128
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430230631.2571291-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/30/25 4:06 PM, Richard Henderson wrote:
> When we changed decode_sleb128 from target_long to
> int64_t, we failed to adjust the shift limit.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: c9ad8d27caa ("tcg: Widen gen_insn_data to uint64_t")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


