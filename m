Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE154606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YQLHmg/T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNxmq-0002hS-6Y; Mon, 02 Nov 2026 14:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNxmm-0002h5-UC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:33:41 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNxml-0002ec-3g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:33:40 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso1449220a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 11:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793648017; x=1794252817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q7sDcGlhGv9Muyce0ffjAur6ljaZcLp1BqOmr6XVJfo=;
 b=YQLHmg/TO4wfuv9twvA6jJAJS9DxargkoCZAbMUjMki2rfWIIaDKMF8hDhv6Y/8RfN
 jcjip6qXGTGHT2BXzSKo4q/r3/f6QfvY1dNROqKFvEhuChkwgyh8Gj5cQ/dsKm72F7fH
 NxAKZSLNZxoWzfjKcsO3ksr0nnAzgMOYmaVeomMljUhm3mcVJRc5xfzf3pnlcWL1g3Yq
 vNkWWaWpqRG33tqfCVObk08GqxVuympf3sJJl+0JgHs61gAGst1+INLQJIxdGgIV5vqc
 b6sl/Km3LTlu1GreYPo7nFVn4ZvA2SwE6z2ggHZJhZB/wCHN2PzyWpQCo+IHZeM8x8qT
 G/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648017; x=1794252817;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q7sDcGlhGv9Muyce0ffjAur6ljaZcLp1BqOmr6XVJfo=;
 b=pzhaMNNHHe5nDdb/0dRao5X+pPBmbEv0i141Pum9Fjr1znaiqhW2UH9yRHbxEuPLUG
 DOuAezsk6cfH7fbk32C/BdQES1A0S9Rtxb8l6Bp0vNZ9neUwR7rpE6adMJhc/j8dwjNm
 ZQJBhu3QuTL46a4i+8HDRSzsQ4DMCyzoTDzjla2Pg5xSb3at2INAD20Xkzgb+/+SjB0O
 vavAasP5YXn55mY2BZaNBhWBJv4zero4SqzptudjUBMtTsewZyuOYhAK0iGzpaWQxhr2
 mSJ4p3dK0mqZcMAC4GJ9E/BNzU9wA6aqUuBmKi3HbZO/06QtVzj/jKSluvyiadu1+eyy
 Ct9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhlDMqm+9n6n0La3PL+5I1u5t11dWbLJqaJDTaCJEQd1sLuDiM8Hf+OwGSOy0Da/n+WMS0PMr+eYp/@nongnu.org
X-Gm-Message-State: APuU4Z9FCWOQ0rccsys6obbnTq4HpW8nERfuM8SOn08YxMsQUbNn7CPa
 +EWX3VDBIsmGkBsZ+hd1UPgJn3WbGO5JXAfWtnZj8RF4DlilJB8M1Qi+U2YQk6a0Kqs=
X-Gm-Gg: AYBFou0lOh+3ge+KIzwNwZ9rloovi/m3LIE6ODRDvPoAYG9tyXPrPWUy/ip+jYINACn
 i1wfI8b0Z0wbqHSXwaMVw+H8EsHvAnNcRksuuaXg32H0MMq7Bz9MfYs55VgswowA8FESJmHZvjU
 GQa6p5LvqCcGS6/2F3W8HaUTdK5d1xQ199rLeesQ64aicljPwmixgC2AMdKwMNhGSExUDDniyHb
 5Wk5os8oW/8F0y3q3AityPcL4d9ltW+PkvSzwYbQfFRiwI6m4PD+K1TdpnlB2B79Nr45Sk3JWxv
 Nh4ZkPYFanaQgn9y1qMB2h3VxUKehbadyHEPaJhElkVY/LDIKHjC2ENiwGB+lxQyUml8UO3+LCC
 op3pziBSgoMyAlMwWf71q0LDvL4OmS+Nkq1W7MvVzO0aCJ7fWktLscYO5l78ivOxd+34Gv32jYA
 623MrvFSXv3Ys5eXcvXa1xx6JgeWuM8GPfFVIV7xeO+sNu9yK8D6PJSyEraIe8Dd9246eP64euQ
 B7ghtBtOjth9fNJwBu0ICCovitQBHJ1sJ6vZKrj06jlhJ9zbYi8BIiRqqeEkaqNg/2x78TpGAS7
 jB0IquTiW2xzadcsC2uamy+efkApy2RYebBvjm6IGXmrAJYB/anK4UddOOKzucMKrK9UrQ==
X-Received: by 2002:a17:90b:3881:b0:3ad:5c64:c7a0 with SMTP id
 98e67ed59e1d1-3ae89814e7dmr8746844a91.38.1793648016771; 
 Mon, 02 Nov 2026 11:33:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c8b1913sm516705a91.10.2026.11.02.11.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 11:33:36 -0800 (PST)
Message-ID: <6e9adf8b-ad04-4fc0-97b3-0db8752f3362@linaro.org>
Date: Mon, 2 Nov 2026 11:33:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/78] MIPS patches for 2026-11-02
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261102144820.46522-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102144820.46522-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 06:47, Philippe Mathieu-Daudé wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/mips-20261102
> 
> for you to fetch changes up to 9e2af46dee82e1856f9bb89e79c3974a3bba28ce:
> 
>    tests/tcg/mips64el: Move R5900 tests to system mode and build with meson (2026-11-02 15:06:58 +0100)
> 
> Ignoring following checkpatch.pl issues:
> 
>    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
>    WARNING: line over 80 characters
>    #43: FILE: scripts/meson-buildoptions.sh:542:
>    +    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r6el=$2" ;;
> 
>    ERROR: line over 90 characters
>    #51: FILE: scripts/meson-buildoptions.sh:570:
>    +    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r6el=$2" ;;
> 
>    ERROR: use qemu_real_host_page_size() instead of sysconf(_SC_PAGESIZE)
>    #145: FILE: tests/tcg/mips/test_msa_load_store.c:113:
>    +    long page_size = sysconf(_SC_PAGESIZE);
> 
> ----------------------------------------------------------------
> MIPS patches queue
> 
> - Constify and remove TARGET_BIG_ENDIAN uses
> - Start converting MIPS16e/micro/nanoMIPS to decodetree
> - Translate MSA vector load/store opcodes
> - Re-introduce the R5900 CPU (system)
> - Improve testing harness (meson & TAP)
> - Improve testing of R5900 / Octeon / MIPS32R6

Applied, thanks.

r~

