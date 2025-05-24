Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC3FC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIspe-0002iP-B6; Sat, 24 May 2025 13:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIspb-0002hH-9S
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:38:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIspZ-00012t-F0
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:38:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4c95fc276so1074562f8f.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748108324; x=1748713124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt2WcLCbfFiacoLg0DGWrz4orvDXkYYrdupoxPeaeGs=;
 b=k6K4OHGOyBo3SJO9Q1w+/LXHxEWvq7Sh1PNYqHX/EZusjw93hjZlcyORQtec0BVncs
 d8zmv1nE0p0cdH59kko83HBO6Gspch1KEAGjnjSddMWJ2KcrkoQr0v5ddJpzoTJ0uhfh
 pDE6aBLO42i/0wUTLjLTPcLbLizPNULqVGTd9z/IAPV8zafn661KEHlgx2qPp6eApZOa
 pL+b+QMcPxLgV1k4GCMn24tKsx7y5nv3owU/LGkBfsXziIPuQ5JbrofKqCgetOurObNp
 8E8vccMK/oQdJZ3uDf9wNXfYucpaJejzQe4wtBRabcKwl1G7m6Odkcvodu5GjCFj+zeR
 yvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748108324; x=1748713124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lt2WcLCbfFiacoLg0DGWrz4orvDXkYYrdupoxPeaeGs=;
 b=pgcqy1rvzGCud7Y7Uql2gTrlZoaB9/QIlAsuoWfVyi89Na2JXhFfG5Hw9xC4rtwrIw
 z0nnMfw5Mm9lIycT8rCScb9mOItKbd7ieExM86abtpJ0e+FsK//qLdzhZ9iTfU5kh1c9
 kL0wbbJjPZAx7DTrzM0YwUgyhGse6O8CrCVHQuvNEriw2dC5cwmQE1QKLfqQT2y9uZe7
 fHJqTiTxd6r3XImYOHsWqqxzshWD+3pImi+7ki5grWQMCxNVO+4qhciBMo6wb4MqEEJi
 o6iT9epw7hkDx0bL9Aly29v+O73obYPT+IIxh58Gip+wEjHx/TfBfe/3gfTZk/seHkiC
 aBFA==
X-Gm-Message-State: AOJu0Yx7g5Jdz0JMX98i8u1V9BFRlWx7o6sJ7gpcYT4ls5jydB0ApXZu
 TERsLGepSFDApTbCmBcCjYHh6uwd+hCnhHaxb9bHbV5A4RfPWvOXyyWFc5kKummcxM5J0kTLOkG
 QaiUqeamF/A==
X-Gm-Gg: ASbGncu66CjDxcfwipLptU+kWud3AbxlHrxaXk91ZwRg3klDMG3GFofzoO9V851JmQR
 0nwiwk4WmpadyQBD0bSMFHovW/Rxr2WROGJdr6PFOyGQzlntNguUFovoGzZz7vl9srqHHDcMiCH
 yum9SSBKBncc9m+3QmE+j4YXo0JFuJ0YfEieNZdm2/64zeTTejCvT3OTPKTHq6Hg1aWLgbcDaEk
 sqV/VeLkVmJgvlxifBigaLOZKL+o8FKeKzhu/yqQYou9r1u0wurD5ar62KWP/KR51mEA7qJZK+F
 haXpm7PD5MXx6m56IufIPAKkrg1J+peaU6+mZyzoRvDK6CRy/xFSf+97F8gLOBMp8A==
X-Google-Smtp-Source: AGHT+IEa5YQkJ55S6tgHzeKwE2VO5mNJBRdIvO9sk8g2ojfynNYSrZ+tHH060+GWSQJDpYkMM6G6Cw==
X-Received: by 2002:a05:6000:26c9:b0:3a1:fcd3:a788 with SMTP id
 ffacd0b85a97d-3a4cb49e29cmr3102706f8f.48.1748108323780; 
 Sat, 24 May 2025 10:38:43 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b295fdsm191404655e9.5.2025.05.24.10.38.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:38:43 -0700 (PDT)
Message-ID: <3748cb00-83b3-47f5-b8c0-a820fcccb559@linaro.org>
Date: Sat, 24 May 2025 18:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] target/sh4: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <dde42e30d6f5521c8568738d1abbbe5674192f8a.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <dde42e30d6f5521c8568738d1abbbe5674192f8a.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for SuperH targets.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/sh4/helper.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

