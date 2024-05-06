Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844B8C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44UX-0008Oz-9H; Mon, 06 May 2024 15:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44UU-0008OM-IE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:59:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44US-0004yI-Dy
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:59:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso9845415ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715025550; x=1715630350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDkgZz3ovFeA/gXnUdICgMTZrbw520CQlWxBpLRt8Hs=;
 b=eCx7bMQ6o+GzuwdGs21XbTNeFxoB+YxabJMdDPe5GRg3dWwji+QgLKqveclpDlMpgv
 I6CMZ6io/ArkBwDNDIbk/Qw2KU96DWQAmMf6Y/OHGb3JHhxTn3hpVa7EAGupmpgLJvvH
 VZyAG2EX1YvY4L9xDU0iyBusqZNmtD5Zqwf+fdw8ciRznTg8iZ4QiI8UiQCiJVyXhk8C
 tXHhiOk9x39g4z5CbguRdZnRpdM/Rb8fAphrPgua08lpCAbI0prsy91EnzV7yGKi347B
 OOtpQdytgdxXQISjSgbdUF6cKwKD/RdPuBoKwKYBmeQbMgwAI3x2r4WJ047VlV+Miowu
 pDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715025550; x=1715630350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDkgZz3ovFeA/gXnUdICgMTZrbw520CQlWxBpLRt8Hs=;
 b=XA+OqUhh9wXAUaAzrFH+6H4TAFmPfIEJdpeFUneLxk/KpLdHNiM/EVztqBCxAmGMuU
 abfu/lae3tjM4SWNwqZUDm3bdsrJ1y6H70lGuEAJEGm0pIY4Nu8hEOR3z4Z+/j+ZUiGX
 xh3dkmIwiUeD7iywXAT+GEZtyZ2ewvu33FrJXwLu73XT0FO+XHmsnu1efg4PkmON0SsR
 wASNVfSoX7PRO9whuyqT/Kpd9IRYCy/AIvKPpo7WiHopKbtP5WAtlrnhQsUABb2PlSxS
 +/U3nk9qgr7RP9aAgiSSYHdeHe8FYxoKjbJI4w8ptVW5A5adQRlSzhBnD9rimZ4wYgqe
 asiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGiZC9yZGCi1I4VNnjtLjEp1apGw1OeJnlMeB12tLfI7xw/06laMHa3Y1sFjQHi+RfnmOgQNSs/dTuXrzTDPgAhv+4Ou8=
X-Gm-Message-State: AOJu0YxQfqFhmUlr4V6Pgo6HRn5gvWMXfoTcXggSaL/XkZFLaHjdqJua
 goAhU/Eg964Xq0QQvpSupcr4j1PIApgLBLjbQyt/Fqn7zipuYWYbXrXQYvlUvu8GKhJ2FKQTIx8
 y
X-Google-Smtp-Source: AGHT+IHMA/Xq3FaSyyMnR5vXXXldaGq0QwJN6QF9+RdMvXqI0E6XAdzy8OVcid5qSkCDI1IRwER7/A==
X-Received: by 2002:a17:902:7409:b0:1ea:f9b1:8b13 with SMTP id
 g9-20020a170902740900b001eaf9b18b13mr9584301pll.31.1715025550519; 
 Mon, 06 May 2024 12:59:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 jj20-20020a170903049400b001eb7483a002sm8627789plb.209.2024.05.06.12.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 12:59:09 -0700 (PDT)
Message-ID: <418f3a85-cda5-47e8-ae79-d6860635fc66@linaro.org>
Date: Mon, 6 May 2024 12:59:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] Accelerator patches for 2024-05-06
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240506123728.65278-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/6/24 05:37, Philippe Mathieu-Daudé wrote:
> The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:
> 
>    Merge tag 'pull-axp-20240504' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-04 08:39:46 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/accel-next-20240506
> 
> for you to fetch changes up to c984d1d8916df8abac71325a5a135cd851b2106a:
> 
>    MAINTAINERS: Update my email address (2024-05-06 14:33:49 +0200)
> 
> ----------------------------------------------------------------
> Accelerator patches
> 
> - Extract page-protection definitions to page-protection.h
> - Rework in accel/tcg in preparation of extracting TCG fields from CPUState
> - More uses of get_task_state() in user emulation
> - Xen refactors in preparation for adding multiple map caches (Juergen & Edgar)
> - MAINTAINERS updates (Aleksandar and Bin)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


