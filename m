Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B688C25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 01:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sB2mX-0002c9-IL; Sat, 25 May 2024 21:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sB2mV-0002be-L2
 for qemu-devel@nongnu.org; Sat, 25 May 2024 21:34:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sB2mT-0006Pq-Vz
 for qemu-devel@nongnu.org; Sat, 25 May 2024 21:34:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4f2b1c997so4335456b3a.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716687276; x=1717292076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kKHWUY7FDmWKAlgniCnV9Mz3W7QVEpooFWF4M8GZhJY=;
 b=VZ0wjMgOkYGwtGihlCZ8zuKdvH8fGgWF5y7j95bzTWTnExGXbx8uhNpdCLzsfU/ZRN
 ONjBIygPS8aCiZ4Gw71ZTZfG084fGDSxrym8I87HakkkocTD1AJU8Jf/UlUvj1wI9clT
 hk6QrVjwQ1TTzYih8Mj45vDRxO/7bP204Z/XCarxOX5JWTBrQUTUGpq8OzjeEa3SVEkK
 5moVKO/0GtkmBzFiXuGWRhh4Ro4bvAIcQnGVD/XetA9aAp4YS5YPtGYKBsxE3lyB9FTy
 jxLgBAkfY3BWzdTbqSHmq8YCpJwNit807pUCcAiSxL50DLiRQohcyvR7VGxYRhsaqmQ7
 bVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716687276; x=1717292076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKHWUY7FDmWKAlgniCnV9Mz3W7QVEpooFWF4M8GZhJY=;
 b=I5FgyszggkJf5DM84mMC1OGb49tzMOwKCVsGbsKg0jHmjHfj+eHWM8HARTj/ty9rtm
 U319XqJEdiAV0esRDIRqNFrJXiII9V+alyYjOIYODySqgOr0jiwcdjGViunrMUP3tL2u
 Fehc02e69FxPNA8qRmZ6vv3iBEfi+3DLn30405ajPLBXbuuVavsJahUfhATJYfvPhouY
 x0L0W+7kqUeohT0RVtpqDfZ7S5MRpRRTDgAd3rc8T+IrHmh5w8xbEAf3IWZtDu1zxsQz
 M9hDY6wkOmnh8yO7rbW+81NG2QlUG5XMQ2iMmSrxr6elF0m2TOFCd57IHar+Zdu8O9A4
 sOAA==
X-Gm-Message-State: AOJu0YxjAuCiymCZEvuuumLEDaYJCiDy6XoY/QA/GkgRTCB2IlKs7CIm
 z0tYQ+92Di3+LDRucs4sJNBISLIUwtbyvwr3wfdePQEGYW0gfigPwX4angYfcke2/p17hFIoELG
 5
X-Google-Smtp-Source: AGHT+IEs/lpAPjYv3aMXQjipwq+FnmGYo2N4pe27xM7uxI8JpvrZFlnFJeATGCYW2yk1LmT2v29Lhw==
X-Received: by 2002:a05:6a00:2907:b0:6f3:e9bc:7ed3 with SMTP id
 d2e1a72fcca58-6f8f37038a7mr5443161b3a.17.1716687275677; 
 Sat, 25 May 2024 18:34:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd2d909asm3018418b3a.178.2024.05.25.18.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 May 2024 18:34:35 -0700 (PDT)
Message-ID: <0bad0fbf-2d4c-4b06-a339-c1064d3134f7@linaro.org>
Date: Sat, 25 May 2024 18:34:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/24] Build system and target/i386/translate.c cleanups
 for 2025-05-25
To: qemu-devel@nongnu.org
References: <20240525113332.1404158-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/25/24 04:33, Paolo Bonzini wrote:
> The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:
> 
>    Merge tag 'pull-tcg-20240523' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-23 09:47:40 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 70eb5fde05bdd051c087669ffcf2aee39e0c8170:
> 
>    migration: remove unnecessary zlib dependency (2024-05-25 13:28:02 +0200)
> 
> ----------------------------------------------------------------
> Build system and target/i386/translate.c cleanups

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


