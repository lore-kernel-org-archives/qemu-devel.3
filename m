Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EB5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kye-0007de-C2; Tue, 14 Oct 2025 15:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kyZ-0007bW-5O
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kyW-0002ki-Ku
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2698e4795ebso56309055ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471182; x=1761075982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ws7wXFf4n6weSUYzPSrXLxBnitGBeC+Xr5j8g6k9gDY=;
 b=X3vsSVOdjPzX6op3ho2kk0aACORHOOgXV2UfQMTNFtMbidi3kXVnkDnqQKXDZ2CSRw
 4CTGL7gCkF6ndihcXII5j0myOVlVGCia19lrYIbspLsSqdYy77qxHZws25q+/S1vFl0M
 bL7gr3Wx7y7SoQoWmEs8uF0YDAkStA88ETnMuM2aFK/ClUmyUZsSpPeV2FQQSwHmuxxg
 zCfaDJyuu95vAdHTMLwkPDfJ6R0EYusCZoX0ax7L3K7iLVqAAHPlmYbCGEgAnrHUVdfq
 ldm695+MixuMx5ssNmdwEELk5XR4jjuw6k9q5zhiswaV0a/WDeVHrsWke27TNQBNAwae
 L9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471182; x=1761075982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ws7wXFf4n6weSUYzPSrXLxBnitGBeC+Xr5j8g6k9gDY=;
 b=agBo/qNpLvO2xSrQMJ2qQ8spY+UTCLe1qA7y6q6jkKGhCZL2bCm7N4cNgX+2aZv7Vn
 GB42qQHtqlq+Yiq7oz8hhxPSSRZCXYEDr009Gq1vvqfn9/XqDLGt2jgBuKg6UWhD/3BK
 Oqj2Q3QX47YCaVVgf+ygt7WhnLwd3mMIFASy+aDlI5Cbe5UuPjKESsjDM1bh2whw+mzb
 7p9IklH3bsp7/8dDFBGiHriTGZcUNXTfAgb5Tsprmois9GD7K5OnaR0bVXAGRXUyD4xV
 wnrWb/Pd5QJU03+5rES9nMECWczL2d+VDGuqv8VqHPExHeDNE2RvTm7Jq8UMnZznGkji
 utnQ==
X-Gm-Message-State: AOJu0Yx63MW849HH88uCnQVBc5rKJV1lJe0EJsvwvr2tfQExorcnRDQH
 ePWkTp6P174XCY6112r4IwiaUUwHWCLvJXN+5A9WQRyQWN6aEk/fNC+PJhP2EImf3yMvbFJ5aGW
 Po8l1mZA=
X-Gm-Gg: ASbGncuse+gUmjEAiUChT/GsEd6KNHSanhSMbpb96gL5glEtlJPZUVjALqc8kOouPJj
 qvyecz6XjK7uBcUmDrIWcz7BSKHJkW3Tz5GqD95od58/Si8v6VNY4k6VlzAR1NJHMgA0698v1me
 G1IeBjLrCyUHnhDmERYFve2EXom70n81Y6ccFug6trh5LVFO/h5uGWOLf5U3wW4gJRDdeLd53Ah
 Is2sIqwxS/blZcTyKoFI+LP27XttInxeYfTWHMFpElUyk/4wloJ9TFg2O7ApgAzZiVhFJrFqxtK
 gCXIvrEq+lIi0z+LSHUekW8gHHWqCiwQAnxhlTOFuh26FSQ1WG2ASrTqfuRNKgt3Nk7YkdnpUsO
 f2ThvxGzG3CIe5z6qfTf9KVDm/15Yqric9Dz9BmCdAuGhTcCKtZjgicGjgAw=
X-Google-Smtp-Source: AGHT+IETqp8OlP9d56mXtTXhR/+1h+YS8j3mUnPt3b4byc8AK8KlreYccKBXOd38mhrrwmk6zh1fQg==
X-Received: by 2002:a17:903:1ae4:b0:25d:37fc:32df with SMTP id
 d9443c01a7336-29027402c61mr320428135ad.47.1760471181963; 
 Tue, 14 Oct 2025 12:46:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f894c8sm173032185ad.122.2025.10.14.12.46.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:46:21 -0700 (PDT)
Message-ID: <b102a9ee-a055-4619-94f0-6f96bc7dc77c@linaro.org>
Date: Tue, 14 Oct 2025 12:46:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Misc HW patches for 2025-10-13
To: qemu-devel@nongnu.org
References: <20251013191807.84550-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/13/25 12:17, Philippe Mathieu-Daudé wrote:
> The following changes since commit f3f2ad119347e8c086b72282febcaac5d731b343:
> 
>    Merge tag 'pull-target-arm-20251010' ofhttps://gitlab.com/pm215/qemu into staging (2025-10-10 08:26:09 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251013
> 
> for you to fetch changes up to 9fedc11ff127636900cc7a0a3e7214e5cb60a313:
> 
>    hw/hppa: Reduce variables scope in common_init() (2025-10-13 21:13:08 +0200)
> 
> ----------------------------------------------------------------
> Misc HW patches


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

