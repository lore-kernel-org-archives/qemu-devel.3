Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF10606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=espHubuj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXHc-0002PC-8W; Mon, 23 Nov 2026 11:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVXHY-0002OH-60
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:52:44 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVXHW-0000wi-8D
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:52:43 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8b4c8b51b58so2009172b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795452760; x=1796057560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sr2RGMod6Pz+fbc7HY/Qq+ntRLp6Zh+JOhvkJ6Dlcqc=;
 b=espHubujQs7F6CipEsjdJ7G5lUcalZxsDnvc7ev39TVsW1jb1/JfOIosVd5lp4+69S
 sh8YMBoUT0dfofu4gtME5Ra9gn6+1kyeYykGTrxX40WqCZy9Gw1mLhq55SrM+/PdRYQT
 KvQ/KZtHCMp8no6Q8XDgAt9v7c4+LKsL2XyeZM5RZErH6cyuS8trsMEQpUGf2ZiTM8kR
 fanBr5EmeVuCrPisLcAxZ+r9xSfgT16/SS+fWsS88Pt1Sqbd4k3Mp1eDZpssJHD4TyAz
 CXD35rxgp0k/oiKThGyRQWZCYAXLwKLYeXLI5/QHXgPwiysAjmg6FGe3POdn4eYrdNzN
 +zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795452760; x=1796057560;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sr2RGMod6Pz+fbc7HY/Qq+ntRLp6Zh+JOhvkJ6Dlcqc=;
 b=NvRS8Ialg37mQtzq1f0pnX58/OLcQDzsHrxLStv74wKKU/pzuSPGdu+0/tL7x2fDNH
 RNsFfb2//IYGF3s/GaxbBf6WKvVoEQajYGP9KFdep0XmbYoMeKkIL/lsSO5eKa1U+qQg
 rvELRmZXZxMTrTPHGlwvUMhJssOZk5HoGccExYj8Ma9B++8XuvUOxz21E1+vBk+s/2/4
 eYIDdy44YCUpEVJ7Qt2eUYYGryJKy8Rp4N2+Tph9SwNcMnm6aCVe6Chuk3Ie2VLRWPa1
 85AeZclou8RkzM3OHmgOLf1QitNWZBZgV4I7B1v8CTi2mjxBmncDGAiGCblm4wQnIOS9
 W6Jw==
X-Forwarded-Encrypted: i=1;
 AL+hErG4WD5Zs6k44SH8dXSOV628YkxIC2e1/oefD5h6vkKc4j8oyqM3ZZltrBeIu023ggIM43A7+E/NwGJ9@nongnu.org
X-Gm-Message-State: APuU4Z+YRNbCY5aXO8Ibsp3K5bfBh3kabw76EcFvKNUkPDtgq++LICWA
 w672T85fp7d8Htnsjrl4LunhSu4K6ewA46ds2mSlr+ZM3i4ff791+g+0x3eRTv2T3tI=
X-Gm-Gg: AZFdTZebKvzFYI39wD+TNcgRZTrTUpxCdXBipU7sVIEAlWRevlUT6sItrH6AebfKYdt
 sPFQ+qX27yFPH1hHwYFNSVWgMD53BXPGUYmgRqpYo4ySFDP1O1Qnl2L8RV2uTYUCJE+4ok5krzY
 AeL1OMtu5ZLX7Omwg7C+2Uiy0dTymwSlOuM1aLJMyikOOn+JvmlEXqKyX7Q1qtUjGnVSfwwEJRt
 hhr95jtpxcIECwz7hqSofTy+spn82lxExwflStlPsVbNAFuY3XWIgPcqyY1hbPC24oazAPlZ/Cn
 WG2I0tWSat0rpjJIUi3ukDyF31OzxXv4XPYOXWeKYHe4aDW2E1pm3OyuQ6rkLCUz8CYUwR++QiT
 cTm6bT8wBsjTZ2twsg9kbZ3KqkvztyspVNOi94WNzcSAeC7ESd0nu+SGDpXLn5jU5zrVrsBh+OQ
 C8Lc5vBPcs4X+GtJvUamgQPoL0tOW9WmG8lnLKiwXEWRuc48VvSOzRUXRv2+/9Nw+ItTCkonn3U
 MS0QNWVKBlqy6syjG2sURKCMU4bGiadbxsqdOvXS86zylZB+5H8aLDadIlgFhWUKlGCa1j+VW7n
 J7oUACAxpbTJEasUjwwgJ+3O+snYg3qQbBomwHZZvgk=
X-Received: by 2002:a05:6a00:4299:b0:881:4b67:ffd with SMTP id
 d2e1a72fcca58-8c87bfa7f89mr10686661b3a.26.1795452760302; 
 Mon, 23 Nov 2026 08:52:40 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c908a56acfsm5212686b3a.23.2026.11.23.08.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:52:39 -0800 (PST)
Message-ID: <d7a20465-61af-4332-a28a-d9645597688b@linaro.org>
Date: Mon, 23 Nov 2026 08:52:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261122161300.6165-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261122161300.6165-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 11/22/26 08:12, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e:
> 
>    Merge tag 'pull-tcg-20261120' ofhttps://gitlab.com/rth7680/qemu into staging (2026-11-20 14:52:05 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to 31b27c0b645e8c596e69027d714ce075f1374792:
> 
>    linux-user: do not emulate PI futexes given endianness mismatch (2026-11-22 16:57:52 +0100)
> 
> ----------------------------------------------------------------
> linux user
> 
> One PI futex patch from Barnabás Pőcze for linux-user.

Applied, thanks.

r~

