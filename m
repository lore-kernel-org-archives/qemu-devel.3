Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC6BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yg4-0003Qq-C1; Wed, 01 Oct 2025 11:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yg0-0003Er-VM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:23:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yfq-0003vA-O8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:23:32 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3324fdfd54cso68986a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759332192; x=1759936992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fDF6Sg9u2Vw257ANpAWT59/FXtDgYfz03veqv0HWmWQ=;
 b=n2eaHnCnPZ3rP57nLu9l223MeA2jidXskTqtPAOmPXTs4OokUC8LhQEvgB6erzLrts
 Z5oOjFZzQHOTwp/psZge9emhuM/gt1jUb3HACljtaZsMMF2kczbzv4PZjdkaVsPDfgAH
 DgK0HsV22cx+/7qicbZYLUu6JtnpAtUnavjY6Ldi95wkSSl+riPARZ02cASHTnRB26nS
 RnJ3bdXxHgThwIq/vdp1pIjsPKVdz8R53a8WDrfrYrn8yaSkTdFqSt1waEQeqkiHnm7f
 1M8mjdMVtt9jHZ2bpjQ0nrliQS9LXQH1cqVq3IN04oLbXT4O1r+t2+lEaqbMvtUk8jVh
 XREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759332192; x=1759936992;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fDF6Sg9u2Vw257ANpAWT59/FXtDgYfz03veqv0HWmWQ=;
 b=GK8kUyDYu5+lEpqnhlQyJI+6ZByDfEJp1z1UnQpHkR5q71OeYWDFOC38rUsdbFl/eg
 xkhdP2b8VUWJiWgJKeycaEINKuc9/TeruhcjoTXD6apySd3u7KYE9Ldgd2RWYC7s9pO8
 6sD4Hyi9lkrurgUC4U25DEVonlY1Z/Szgx5qHALIi8+tIYhtLWoQdAf/H7sMLu7ZGoAW
 fpEYwubfJtFM5tVd5Dl5pFVhTA9jMzofUMcgjY9RS3gBxeIgvzE6slg9bjYZvdFHT1SW
 fsuAFNYYcmp7RISF9OMF8z5iRlMJOBpNKLQOI/9QoS1IBTyMoZbRPM0NaGmHnuY+n2T/
 a7OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKisDoz7Fe8LVqdphMkm69oXtXiKOui00AAKmyrf9YQEunqSY4rafYR6cwUg/sFQQy2pcAGOpQNcb2@nongnu.org
X-Gm-Message-State: AOJu0YwQcHI2ufHMNmzks/P8CN677z2pElD6eKtZ/Kjhn9eqznmbX6ul
 9Ncj549gswgfTAyb7ia8mmJQb/U8v3i3nCo/DS/JNk3Nlu1jDAoFARG6hFd623qI6Bc=
X-Gm-Gg: ASbGncuud3WuHVh3X0hGeGknt32ME7YGQH0HPcX3Xgd737J1owe98mml+wLnT8yMeAI
 iTWMRfFdVSIinPsJp+PLCPNk3c950c5jVv4b9C+x4zXOUHkwt1+k9QfoqObpbtKhesuYfXTpbqO
 xR6Vg87sfqrDAzXX/D/LCjKCjVFNCHvGoK5yYB9LLGTm3U+fIGIx7qi8mGM63q4+sUE3KCTyk0f
 yEqe169DZkFNSDbxQN3SlPJaCKeDyRKPvBnk62r86cgwij0dnoTmRXbWPGlyS4paDN5BQv7ntan
 i9iLZDik/KslnfFH+eLIR2mf0FbV4oXuvpAX3YJGC3zl99+oR0HqoeaT9o6ae0pjn7DUgN4w465
 V1BS+4xvNdxotPe0YA7vRLCQCuPNH6k3Pl+wri9mO52tR2tCPNHnE3DitAErWWPTdoOYkBAUEUE
 HQGta6yAzESXX2KHVisz0pH0zNHDW7kX8=
X-Google-Smtp-Source: AGHT+IFbtqdobKnfecQfdcyLvhVvim6ri4kRoo6O8n+a4aWb+I7kV8WMEsQUHyZdgKy2ualpG6NYbA==
X-Received: by 2002:a17:90b:1811:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-339a6f78c72mr5071490a91.37.1759332192478; 
 Wed, 01 Oct 2025 08:23:12 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339b4f5513dsm35614a91.21.2025.10.01.08.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:23:12 -0700 (PDT)
Message-ID: <c8692c60-8c94-4978-9559-9ac4b46666bf@linaro.org>
Date: Wed, 1 Oct 2025 08:23:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/25] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_lebitmap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> Remove the now unneeded "system/xen.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 103 +------------------------------------
>   system/physmem.c          | 105 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 106 insertions(+), 102 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll note that the ifdef is bogus.
It's only *used* by KVM, but it should compile everywhere.


r~

