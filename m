Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E006C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59M6-00022H-3f; Fri, 11 Sep 2026 18:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59M3-00021n-V7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:04:20 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59M2-0001fg-BL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:04:19 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb5so39315a91.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789164256; x=1789769056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/bQdpjDG+G12Pai++NRjc9q7QopvOalG3cCiOY4dzYU=;
 b=GE6aYFXpYjqkZshgVl6vh5hpZPDTOaZ3sVDHqIFDQ7NcTC23EkUzrkaT9fT0FpkjOa
 VxLTZczjk5czU94bQWwD1SBYxuL+xDOzx+4xBM8IZOmwGRTiIx1TtbMxbkZL4U+hm1tJ
 aRLUrK6y8ReuEFbXuIKi6hT2qq0axqxXLtQ5DXgSS2t8rrJpqwX8ek3anJfqHaV1E1j7
 dNj1Mo3bSCZuGjcgM7zSoHZWhziN/orbLe08HFry/tHqIalNdz463KpTb1Cw634c8tP6
 RuJuI7w5fa2frv7yAjlTzZWMpdKrPot5BnLHInzcvvJMPgwYukW/ApfSqyk9dT3wJ0o9
 oyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164256; x=1789769056;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/bQdpjDG+G12Pai++NRjc9q7QopvOalG3cCiOY4dzYU=;
 b=LawH1TiHJL69ZFl7EIDmZTh2lDFI0SRleZatP+sSmTykW/UEZDvGo8J9eqoUApTekS
 dVNFe+GJfZr2D164NRbaROMKAD/5Fcas9CAZKNmMm68HKUW92EE0jmcSXrLEKm81x/8g
 daL014RNUPukuZzZ4sy2V7Usxa88IxfJ3ryOjKY6WSEuTuI7iXdIOMbYy26k4nRTtH+7
 kdMmpyiusxRfrucRTSrtqYpUPAfDax61UMl/YYfv7Xsex05cZ3hAlmP3/bx4qunRkKOu
 LUvp+xrkDfdhkLXDddneUEZVOXXLLBRyq+zcKVy9eRNT/64fDMdyAuDHr6KAkuIH12I4
 0dUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNi8hiri13Wd5FM27XQqpsB7fNsXOomlaZe9HRclBzUkZve5oaBpO45tfuEdEMgHNJ3Hx7kEmLfem9@nongnu.org
X-Gm-Message-State: AFuF++kufUEwjyD7FOC1KWzScq1QXLTgSV+2Tl6S+ERxkUj5u5/ff4k8
 xb30r8oGqbA4GsNBuPybc/RCWwp5uDxU+nFB7HjNbIZuwPw28t5L0m935itaLQMaHVWMtbVo5WZ
 LXbuzTHQ=
X-Gm-Gg: AYBFou2oTd2zwDTtwutV4vgcohJPI9AG5WOjT0oMCE4GJNsh8f7Yl4nlzffybAXcb16
 EeCwJsiHW9cGZNuubDIb6Qyj3V7ltsvDEVIDTTk2j+KVdTCNgVGtGGoD+uLIEn/XMFnvx2pO0n4
 +anFl93ByBCGScthUBff6vJad+i7yEF4sFDWFdEoaAk6SJxzUKDKSAbFus/d1Spxud9uH5ykIFd
 JAl2z8GSqkTH4DcWJOFJPVkVzEl8541iBC6+M2rwIDEDvMMls8N7AfEgAciya+7r/yrLyZKE4ax
 03mJtTRKt0OH4AzkBWcIeEa+U1P/pyiKHxEF/XXqqcMdKHCcQtDH1YlFyK09fEF6+507/OPxJmi
 Gd1JsJKFNDWh4DWyXxR9yNT3LJB6+HH9Y9w4o/e9dcc7MK6MbMYGGjltHMJHFxYSFN1wENYkwXE
 ShRbQk2k1SSW+yPJQSgt1AJGsu7iF6IDgb2moUEms2Effpp2D3lsMH47hodRXDIkGf/6rd7FjSy
 NiI5ntIKFK6pQ5ZTaxjRcuoHMUAnQqGA+OfxLrRuVPPM8/7SGt6heFYH/NTDqb+OKeLww==
X-Received: by 2002:a17:90b:5904:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-39dbc0cdea9mr333083a91.10.1789164255671; 
 Fri, 11 Sep 2026 15:04:15 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e5182fsm8959582eec.9.2026.09.11.15.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 15:04:15 -0700 (PDT)
Message-ID: <3fbf8cc2-34e4-4726-9b90-5849e02ad38f@linaro.org>
Date: Fri, 11 Sep 2026 12:04:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Trivial patches for 2026-09-11
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260911105635.955937-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911105635.955937-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/11/26 00:56, Michael Tokarev wrote:
> The following changes since commit 92c82d0d2e71ab6e39fd799b035bae98b375bfd5:
> 
>    Merge tag 'linux-user-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-09-10 20:59:05 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 4b93253f6d15642c934e33fbd96bf761a2f0efd9:
> 
>    hw/ppc/vof: Use qemu_tolower() instead of tolower() (2026-09-11 12:07:44 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2026-09-11
> 
> Just 4 small changes, the rest went through other trees.

Applied, thanks.

r~

