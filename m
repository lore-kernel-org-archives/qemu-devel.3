Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C2606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ucBaGhhO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOjm-00042b-MI; Tue, 17 Nov 2026 14:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOjl-00042K-U2
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:21:01 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOjk-0006QJ-FH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:21:01 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so801097a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943259; x=1795548059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zugUQdwwE+1rGGNyyoR0j3lEfg09MZ7Srp4TvhzUMLQ=;
 b=ucBaGhhOABuH6SPtHr5trhx4zeImtrgDXEnvUnd0nytN54AV4y3YzzZ2FC4Qc4MaLc
 vxw1EiCVPIer1P/fSfMv495WrMBTlthws8OFhuyf5Q3EdDqMWGhSI2l67OmpjsajsdEa
 hDjbTUw9Q7iVMEmD490n8xYzaWd0H93pRAJ64WyVaQm1wB3j5IiSB6opZjs5vP/L2/Yv
 TB5JaajmSY35LBqkzQtG17whSJFaq9793kHy5mhpA7wXxMpa4mdsM+JNTwsgeTCNRwq5
 pj4Jb26svTToNwvsD3u4YwtpCr8opkLIX550JycOpiHFt+NkDZAorYEn0W2MCG/KZ1aY
 maiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943259; x=1795548059;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zugUQdwwE+1rGGNyyoR0j3lEfg09MZ7Srp4TvhzUMLQ=;
 b=Z/rfGrxB8OBVt6LSADzjgEbA3qVpPynhOnM2VS7IUHlz6f791TCzgXj6Nr48T6n6/z
 0XqNOyklH7CVQi/XOvENcdj2r1t57EivaekEzXHNS9SzTxnrw3hGGjNZLBcLN3MIAIT6
 Ggs7RnM1kIXuU9LyRdIoOF+/BaHfFIil1MrmxQNq/WmRXz4EUr1gJe8h4MYUqBQTj+3S
 bJOf99kP/3QcjEXt86i6TfVawNM4IVGrFw4eRJHbix5GI+EKhJ4ZdcHA6el8n8dpIXbn
 VblzTYLu2BQPL8h+BnqgnbdASMe+I+eZK3FhX4LWBvT8qxbFOB2w/E3XIrkBY23Egs3R
 ywpg==
X-Forwarded-Encrypted: i=1;
 AL+hErG2uoiKYQN+9ErHfqldNDmeZOzV+ODYFTKtDVNu1bWbpxHZ9h24WbSYwwM2GypayeyutrxbqH9iqWrs@nongnu.org
X-Gm-Message-State: APuU4Z+SA2s+KwsQFt+u77VYbEsRBNreasRpE2dl+FtfZMVLvWFzsuMX
 5XJ7rdjuVGFeLjaChNXQwDviu7+K2nRVr+hp3+Ut50yT907NgxqGGzFzmbde+0sU6VI=
X-Gm-Gg: AZFdTZfYxPIlSMuXY/1ozu98T3TNlU61VPZXfSkwRq8FnaGPnsgKz6I+LC2dzX4kiAS
 ugOlkqYMaO5VwGC7KdEQi7YBbgPz9GFjC38HO/WfNHtKtzU2hzk/W+E0iLWKkSTlqlkF1c4sNA1
 PCq9xmGhcFZe1ORoXu9DwxbmF61/Hyexww2vQz+l4rZ8rNmqc+m4H8RG/lndJyYn5xmNjO5dB1n
 rg4xzI725S7P2TJqc8kJa/YONJRClHSDaQ7SLg1gHrjsgc43iOWXdAGjLdcUE2iRKPs7oH6lPaH
 qHsdF/Lo60lf5zjl+Q1TGxGFzWtpx5LhT6DRtGC6ug11UoHG8hrFh8zWTPbE2c793g2u7Rgz1bZ
 m1FFAp5oW3Iy12KoFNgJoGx6Xwcwl49EaHHDAbJgCKDUO37rnhZGczoH1sVooq8w/bhLJlpUgqE
 +3GTtQbn3hNqX3/i1uma154RUbQddc0o+nTxpC6C9AGat51DODbOc/u9Ly1p2zIyzUFn3UVAshM
 6FoDP8itV0CAYGVrLBvwwjLkW7FYFXEvpiAJ1196bi4QHB2wSbY04xbEn66PIuFjNwr/blRrhVy
 1fjnP97Db0fMuHTk3UePWwXKZXQoQOY0p7fte0lfKZjoJNoOIzkR8FG9TC9Zv5eECrJKjuo=
X-Received: by 2002:a17:90b:3fc8:b0:3ae:3b3d:c617 with SMTP id
 98e67ed59e1d1-3b3d07e37aemr218428a91.29.1794943258883; 
 Tue, 17 Nov 2026 11:20:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187df25sm326924a91.3.2026.11.17.11.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:20:58 -0800 (PST)
Message-ID: <7bae40f2-edf5-40e8-9942-bd429e7d0f9f@linaro.org>
Date: Tue, 17 Nov 2026 11:20:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] target/mips: Fix nanoMIPS BLTUC with rs == $zero
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-15-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>       /* compact branch */
>       case OPC_BGEC:
>       case OPC_BLTC:
> -        gen_load_gpr(t0, rs);
> -        gen_load_gpr(t1, rt);
> -        bcond_compute = 1;
> -        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
> -        break;

I don't understand why you're discarding bcond_compute?

r~

