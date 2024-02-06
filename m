Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B760C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUaH-0003gW-Ho; Tue, 06 Feb 2024 18:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXUaG-0003gO-65
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:10:32 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXUZy-00042F-3Y
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:10:31 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so4606914a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707261011; x=1707865811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nb6Wza40c6L36QhzW3uecpEsAvY+79c4j5Br1ngTz4E=;
 b=ZeGVvS1keiN8HuXV6kXz4RtsRSV78yhyoBsBGyP2Vab1X7dk2kKmcPrG5JbtVemOZ+
 7b1jSEV+xrfcsBjBwWo/Y/1tLEJvYnYd0j+bbBxB62IfMW67yUTy5OnnaNSLz6Dgl50Z
 pZBGjcr8EwuXo/UCFklrFjJmTtz5nixSNV4kMoDFvLu2O4O1gyM2HqcPjLUYsibvoZde
 xbaRTHoQI3mqNNq19fOk46d8khqFDzMs/uJ5xUReq9+olXA2nrHqTZcHFu7Uhcba+Tcf
 jCfDYmWsy0QbDSpmTzNqxJN0GztmTLUDu7nh4OvPOZpj4Pg+beB9BXQbmbec84PKX1EY
 Mb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261011; x=1707865811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb6Wza40c6L36QhzW3uecpEsAvY+79c4j5Br1ngTz4E=;
 b=HXdIDbLB3X/tfQQJJ/L1Ho+XjpFug9ZQdvQV0kmtC6Hm+psBufVHffBehWXQQ6TYlM
 MXbp9DhTH2czd5MEiAJaq1TL98ZFOE6/7rSwKWueyR+tg7YCyPL/nwA9EMDYn1t35OIT
 0tZnxjFc1BPyCLru2lbyAh0fa8uftXJb6J9ubcbo1xE3AwWisx4bTWNeZTXS/mDxLC3E
 foh05yAvfkSA2weukXwCafU8apUEIMaiswJtVbUe5F2f1eaCXcRdoRTdrAbuCHJRoNjJ
 OdvZl3Foy1k07wV8Mfz+7OkcruZyA3vnJ739dXhfgj/Dot2ORbdj4O8avrSSORXql8Hf
 GRdg==
X-Gm-Message-State: AOJu0Yz4/lyyxg/+mk/C2kOaIHHKvIH65p4Zxuw3UZOmWNduu5aZj9KZ
 FKiFtBHHvOHt6DrC6/FR7il32XAzTA99i9p8x85AxwDYqH9ymUZaRTr8xOF2c2k=
X-Google-Smtp-Source: AGHT+IHAtoQilVeAzoC0cCdT7fDQZqKuMGNMZLOkaYRLNPzU96FV8HYDzFBl9tWAu+DnPVcfxGyLBw==
X-Received: by 2002:a17:90a:34ca:b0:296:1e9:2c91 with SMTP id
 m10-20020a17090a34ca00b0029601e92c91mr1106496pjf.31.1707261010643; 
 Tue, 06 Feb 2024 15:10:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVpCbhnY7THJmic/xHgAtgBuAs61Aiv3C02c6MHjhe+jnmZLOnjeeQeDc3Slm6zIamODegwZadv7eJ8Zpj8RVxKsOIlDFVPPvDazJVe8Vf5bcTHeU7WsS6Qncs=
Received: from [192.168.0.100] ([43.252.112.155])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a17090332cc00b001d6f7875f57sm56263plr.162.2024.02.06.15.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 15:10:10 -0800 (PST)
Message-ID: <478af5cc-2eee-4d7d-9417-8e6af372f7c5@linaro.org>
Date: Wed, 7 Feb 2024 09:10:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] util/bufferiszero: optimize SSE2 and AVX2 variants
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-6-amonakov@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206204809.9859-6-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/7/24 06:48, Alexander Monakov wrote:
> Increase unroll factor in SIMD loops from 4x to 8x in order to move
> their bottlenecks from ALU port contention to load issue rate (two loads
> per cycle on popular x86 implementations).

Ah, that answers my question re 128 vs 256 byte minimum.

So as far as this patch goes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

