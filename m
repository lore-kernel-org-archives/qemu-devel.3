Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9D606A78B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WHzKxCk2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSNR-0006MY-T2; Mon, 09 Nov 2026 11:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQSNM-0006La-6w
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:37:44 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQSNK-0008Pa-Jx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:37:43 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3b08cf16decso647642a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794242260; x=1794847060; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gdvNdGbVEs8jMqG4SL/jDM/S1tWXFAhscwwSjBn8L1U=;
 b=WHzKxCk214osadABBLWEMxBRWWYCRll1VFBJoHmx9OUL24RAiKTrykPmHdiMbFdqoB
 Rvm1DI2PWdTeO0HFqL9/qEOsZJFsVn3i8C4a9co+YTzdhrpn9+MtlncT5ITW1Px6KOOy
 hpXFm37Lv0gKn3iXqG9lKDVDMw1asikq5SEeoUnppRnLUnU2TzG4OsaGZW3j21heeYzO
 aWPa3Cq/cE83yMjxjFAWSvWSTMwsmxNzVD8DQ/lp+LpZyb7Lpi/P484oksC6zMB+cXPa
 Z+vVgpB1EfZfM9mfpoaXTkpanez2PY7tN2Hgws2hHrsDLojESs58eBPCQfW+kBQRJx6G
 P6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794242260; x=1794847060;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gdvNdGbVEs8jMqG4SL/jDM/S1tWXFAhscwwSjBn8L1U=;
 b=aBYzuvBxf2SToKemTkvYRk/JXajMsPlnp8adaRU5gzzTQJ+BOpzAIdyRfQR+gfDrA2
 9F5IYLnHQws54WrLPn4do3D/HkS08GoHnUC4YsJr4SZ3049Gyf543eH83+VudeBFo0jh
 NLHrQxeFkSb9Zm8DMzPNxxeTSsTwsNQNUmWdBfBhOmfvwhTkUIdV1fdlZB0148i997ba
 359im7up+iO8JyJ5cayTcc0K0ApE40xbocR/EibZaoRtytRMpmX8EWcxwmVQCD8j/1m0
 au1OWX8ADqgYnoUi7FOSKWlcAPxjjfg2jN85JdJwL76JuDoYjLrnHeUovuMM8TZ2EA9j
 VSLg==
X-Forwarded-Encrypted: i=1;
 AL+hErGCo3nmxNVyR9TyHx3Ii1U6SMODtcMgaPfL48V1DupiCpSysVF/TcJztYRNNoZOip+HHQ3/Co1FU4he@nongnu.org
X-Gm-Message-State: APuU4Z+iCi+lbDBI8uqU8BHsxSZ5iB3/H9MDOZuH3XQIpY6MM4ft/5Xy
 y4IgWZqdh39sGEGyn7wRK9mMAp1Sqeigp+ojuV8fr1W6Xze60asipa8DDxbERQ9WOLY=
X-Gm-Gg: AYBFou2dwZ6/KbqXjNXaQcngtE8Hq/dcMIEUTjP7bSx1DtAprq1rf6X2koE+H8rt7K0
 I3nqGsJAx5Y1qHrfVhbZpCZ0IZNiwVUX+XhBAmyYGiiQLdo/RGfURV1bN6VHkd2tCu7zTyM87rq
 rRYBO9RO7YJrxgZAUnaQY+mLyURnVLrXtmCeOE8uHl9pBCgxXP/pdOzS7+z5alAkFO7TznfZfwS
 wnCrT6T+GeGz2E2xzitVnaZlXz6Asj6yTeaj/qjvgrkeMQaMHAAHyRzXdo53kBieodumzSgnErG
 TOFUsawY5KSch63Bz09x3eo3xedpqXg2qDnVTzOf7VaYTiPUsqz2lcMrM5IIf7mLIZ7RN6FxkyB
 cKX27VuCj4ebQO/kM/In2liAAXsc4rfxbF63G8Q0HozfUuMvTULKmwCIKHvnnScUxWzgJDAR/oL
 F4BoukthB/GdmgNDQuF75/mTK7PK7uqYjRyESRmVlWUeETKp3E2eGuyrvPqSaYMESe23jxaQrWJ
 fk597KZlLLX23n9B+7ZZ6OtdVSGadhTCXh6ZVinXtxrDKJLstzZHW5SZq2f0sBhJ2DmsOIQCgi+
 zOv4cbws8lVySeGNvJ4Y4Pwync+Fcnyas5TA9iOSO7bQulXhjp+sTn95R/9hqOF/bB+c8O4=
X-Received: by 2002:a17:90b:4fcf:b0:3ad:4a8b:c703 with SMTP id
 98e67ed59e1d1-3b166c92cecmr212819a91.19.1794242259948; 
 Mon, 09 Nov 2026 08:37:39 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1679c487asm16566a91.0.2026.11.09.08.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 08:37:39 -0800 (PST)
Message-ID: <90bcca84-d694-4b0d-83a6-bbb9d675404a@linaro.org>
Date: Mon, 9 Nov 2026 08:37:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/tcg/icount: Fix shift=auto incompatibility
 checks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261105131549.42175-1-philmd@oss.qualcomm.com>
 <20261105131549.42175-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105131549.42175-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 05:15, Philippe Mathieu-Daudé wrote:
> icount_configure() rejects "shift=auto" combined with "align=on"
> or "sleep=off", but the checks read the file-scope variables
> icount_align_option and icount_sleep. Those are only assigned
> from the parsed options after the checks, so at that point they
> still hold their defaults (false and true). Neither check can
> trigger, and both invalid combinations were silently accepted:
> 
>    $ qemu-system-aarch64 -M virt -icount shift=auto,sleep=off
>    $ qemu-system-aarch64 -M virt -icount shift=auto,align=on
> 
> Test the values just parsed from the command line instead.
> Both commands now fail with:
> 
>    qemu-system-aarch64: -icount shift=auto,sleep=off: shift=auto and sleep=off are incompatible
>    qemu-system-aarch64: -icount shift=auto,align=on: shift=auto and align=on are incompatible
> 
> Valid combinations still accepted:
> 
>   - shift=auto
>   - shift=3,sleep=off
>   - shift=3,align=on
> 
> Fixes: abc9bf69a66a ("cpus: Fix configure_icount() error API violation")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/icount-common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

