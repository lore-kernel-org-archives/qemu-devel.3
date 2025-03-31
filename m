Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF13C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKBv-0002LK-QW; Mon, 31 Mar 2025 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKBt-0002L6-Lq
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:48:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKBs-0001mB-2v
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:48:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32114205e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743446934; x=1744051734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=er6pDxh8XIqvAoPkH06hhDErlAezot/dtgnUBaxh+vA=;
 b=kvMumHUISOj19Yb3a4wuPSFz/TYxMb786SmvCGra2zUs8fSukk35at4I7oFcqWStwE
 p9jR+KN0qjTk2t9LU3nbVJjkBog8t/sCPdsXPHG2TZv8L2QTwk3K7zgHIkYTArx8V+Fn
 Ze0k0Bf0BtvJcLz+Xtpc6xciO0tcqJV0xTOwncPWbW7U3u78SykpC24V5N/L9ehSktFj
 XGIBLd3sbdrjoMpZdf49dLnhqb4g2vlPHXzsHqpPGmqrRknm/NnZIxZ8OUzJnq8Rm1Jt
 RQpvgPyjn2hOv3w+AnQofWDowggjW+hpEBzOYbRDCSP6XZGLIuqhGJv6sISAxqgoXHVk
 x2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743446934; x=1744051734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=er6pDxh8XIqvAoPkH06hhDErlAezot/dtgnUBaxh+vA=;
 b=vyL6ViIC5s8K1E8Bgt4Qu/4oEoVC/J2CatxUAr2bzcgt4jJ7O6JaUOPztKTjZGi6r3
 EJAOICaspznzW9NaFh0Z2F474zVt0Gg2wrRrBej+52dRqJMGco6LcKRT9IycfM0fvlK1
 av4LQTw+kcBpTBNijFJTBJChl+WZa+L7vkzKdBGwTx7McWQ0d04l4xJ8RTVavhJYl6sG
 qkSuRF0ZY3YPE5/p77K2MFwpJ4Dl1EzPV4wlDFFsiJ0+eJMeWe2/Av//+5WQEDP96XID
 LwKpv/8FMgChaUT8JwJSccHrL4N0dxd6i7DhKhiY5gQ63ldn/RIYgXlqKUBcBivUTtSq
 ejhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaC2Q6ajEYDABN2FZ1wg9XpISgXhcicj5kVkrw62P6cD0UqG9Z5SffvlHFxE67cbFR3pkNTYEhjn6L@nongnu.org
X-Gm-Message-State: AOJu0YzKZeD7PGgSu2kyZx+WSYxN9wapVejpbQLYTmigNw5zTW7flxN+
 DJSDQQYffLhUS7e2N/xfJYwBisyC4lGt01oQt1cYfKkxMi+ceNwLu28kNCDzOD0=
X-Gm-Gg: ASbGncvhShl5Rj5uMdziuWpvYvc9kAKTUMK250JWveb93BYoMwgo2WLIL9O+KWKVrq8
 09tumUuyHe+5fv8RAMeP8LmcRYUoQ/HyHlNXLHxsPMqC66T+t5k/GY7im+wRF9F34rbCUuciNR9
 PBTMuTVd48Rt/rc+eYSXPDM0y8CLsf2viOgWv1PgokznG3rk4g6+j2CEuNPC84m8CHNmyVYGUG/
 ZXp3odNxh9mjR+sSEkRv72X7U24iR20njUylMd05a1YrDXFN22n2iiCmT9af1ZN+75/KB9VoZFe
 lfCd01FqD9eP64xUpTE/M3Q1vgPmg/ZscMnN8S0GyzA1w7RllTbMK+15WBhH/JvaQWqedXk7FIO
 N8ViU1I/XPozp
X-Google-Smtp-Source: AGHT+IHTXxaUU3mPE4R4w1BUKCG1Lu/OwIUh8GZt8oBsaReHx8V9B62SXUG8Iq+Xu7ugIT90mJEI7w==
X-Received: by 2002:a05:600c:4e91:b0:43c:e7a7:1e76 with SMTP id
 5b1f17b1804b1-43e94a410ebmr63500765e9.1.1743446934179; 
 Mon, 31 Mar 2025 11:48:54 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314f5c6sm178267595e9.40.2025.03.31.11.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 11:48:53 -0700 (PDT)
Message-ID: <a4823d77-9182-4b92-8ef4-a894e25b0b9b@linaro.org>
Date: Mon, 31 Mar 2025 20:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] target/avr: Increase page size
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/3/25 23:43, Richard Henderson wrote:

> Richard Henderson (11):
>    target/avr: Fix buffer read in avr_print_insn

Patch 1 queued for 10.1, thanks!

