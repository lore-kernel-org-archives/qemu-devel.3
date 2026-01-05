Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30928C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcY2z-0005Yb-7O; Sun, 04 Jan 2026 19:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY2x-0005Sc-Cv
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:02:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY2v-0005sa-Sg
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:02:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a1022dda33so107460265ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571324; x=1768176124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DkgRYzMmrn4MrfGap9rVuGNNxDjbY50Yr/6iMbDwnU=;
 b=eX8RYF0y51Ca0LSr5M1eb4LhImvf4EWWRmyO5zOp9yFedabeNAV0isE7QJerZxSbS6
 sojaX/8/ObQn5AqaVfTuPiHkgZIVrGTqgBY4o3RG4r+83vuKAFgaalfcYc6NjlSlejrd
 ypZVnp/+/c7eFjYDvD2ecSCc4SBhK2iT4c84t/xEQBrnYWMxHVhZ8Zdsg4E6yqdk+W3v
 zInLLnXjCDSi1XIvl4Y8NwvirNM2IbZIE7F7LoRzjq7tSEN5h4PgUqVSL0zcgt7NLacM
 5Dk4hk/yLjEKn2NzuhduXxG7XCjeyrT/CxWP4OGA0VgEgYano/aT+Y4bBQpa8EZIDpQ+
 BW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571324; x=1768176124;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DkgRYzMmrn4MrfGap9rVuGNNxDjbY50Yr/6iMbDwnU=;
 b=V2zBk0ISw0YFy6VPgoErp0gpnkMbCT1wPljkX+MfJeJrgFqxXxeYb6e6TQ7sBNkvi/
 ZvXwvU0aqVmLI8NJcCMZLs9kNG6U6MjoCi7jEbWEQs+KCezjdIfoOmA5St5kBDbA59l0
 nv7aZOhR5OPHovJWwc7uofWi8L4rF+TGp/G7x45b68QmbY4R3YBxgrt6fYTUs3KjYew3
 5Xh7yL1aW8EhBSAg166Czh2MZ6qo85XKZWjPU/03iSwmRy2/YJxjn71j6SKIy/Z7Rfcj
 0rfWqT13i2xC0yv2P9YwTQnzqEW0Bnf//pAUpLtrrDEs5c/g1F+l29VGgpgLsbM8Lbmv
 /9lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8LqaZdpMR2Ly9MgiuVuIFkhXmwVD5/J/G001AFg03OOYgV59ST3eb4RKh7mI7bKpGzhxHDTfDzzrm@nongnu.org
X-Gm-Message-State: AOJu0YwfWbDoeWBXBn6dWzDQHRdLY/RQTDa5tcsYtWdKR5SDCfGGwll8
 SJ8w9UgCmPMyYQVP4er+WME0ZBGAwd5vBgxziezp7bcRREInR9xcON1MzpDOxBGdBSxECjYNgEC
 g/91sYgs=
X-Gm-Gg: AY/fxX6Fd4hyrDo3Ww6lrejHPP+U4RsLwmabrw+eG+ruyiznTpOe7PIOTBJgiQ8wv46
 /ariL/6Sy5kXCs7cqqzt7CicfsI8CeUVcegLssPugG3FVAHOaP4SM0o3q8EYmzyqDnJGTl1Z+Bk
 hWgRveL1hahk2Q53SJb1s0IiLi7Y6NErDllQW25a/QT4h6Cm3/pCDS5KHGWNn2uMqJDFtPrHcxm
 +L/1xzWUFYH8alQEHoMcR76v3j9duCmIlDqXGNs1di8ImifR+H0E0NL90haW1OQ5yT8h+s0MDOm
 8aEZX7PJfICC9rqh2ny93alvmFcIhdHv+e7RyXaH2trhIfQS8DFG7ZMbzj35NlTvkrPbUyRgcpY
 d9nrb5/xgrZ/luznBUGqPM9V2kDcqTD9TanZbYJB5ajZaYqbaYXwRkODhzINt7kMT8kFJc0uXFD
 FKE990IP/5FtJV1+J3XqN87MxEhiH+bg==
X-Google-Smtp-Source: AGHT+IHU3V2LavQfs6YWx7LGU2/JTni8ri8JOOkHneh3oKogpCVp6XBm8aVEm+4WUJIMvMXAMdpOhQ==
X-Received: by 2002:a17:902:e846:b0:246:7a43:3f66 with SMTP id
 d9443c01a7336-2a2f220d878mr512624195ad.7.1767571324123; 
 Sun, 04 Jan 2026 16:02:04 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d2bbsm436581135ad.55.2026.01.04.16.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:02:03 -0800 (PST)
Message-ID: <26f83bcf-4eee-427b-948c-3b2b0924c97c@linaro.org>
Date: Mon, 5 Jan 2026 11:01:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] target/hexagon: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251224160708.89085-1-philmd@linaro.org>
 <20251224160708.89085-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160708.89085-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/25/25 03:07, Philippe Mathieu-Daudé wrote:
> translator_ldl() is defined in "exec/translator.h" as:
> 
>    198 static inline uint32_t
>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    200 {
>    201     return translator_ldl_end(env, db, pc, MO_TE);
>    202 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since Hexagon use little-endian order.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hexagon/translate.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

