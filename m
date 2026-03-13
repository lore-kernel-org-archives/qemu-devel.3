Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A2107BCE1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18EE-0004oB-NN; Fri, 13 Mar 2026 15:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w18E5-0004lr-FY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:31:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w18E2-0003WV-T3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:31:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so12307225ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773430265; x=1774035065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63c0lPgLcS+hDqpkxxffQeA3FYm6eO1SrTaXuTxrM7E=;
 b=kHY+NBT4g1IT5Wx62JL63spCybDU/vWAvZf3Ih3o60/94IXYGHvxbpGm81AdLSZpd5
 rk+SIIX3NarxcBkhr3KGb23rv0+UIQup0S0kZ/Ip4q6wPzt8H3uhTI2EX5rnJ0f0XnTa
 OCrmmAq01nD2K/P4XrJj9y3q/PhdLtEOzWmNEGQ3RJxr9OR07ngHs2HK8DmjyEiNA2A/
 Nf6M66p/k1KB4sewd9yjuzNZm6WREZdCf7/79vXRxA3RCXOjJAbiGRRA/cszEP5BuJoB
 osVlqHaLgua5FI17XDtDW27+zTmPcWdtmqbl/WiqDTeKA+DG+NCd39PJlBf6jicmgN+n
 hUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773430265; x=1774035065;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63c0lPgLcS+hDqpkxxffQeA3FYm6eO1SrTaXuTxrM7E=;
 b=XM7DxCNvndzAaEOhvgvhpvmsXUdP+Zpu7f8hYmFYCqZCJiCJGuNBzL+mVY1ZB4HC20
 R6qJ/X2bT8jFqrEZiqFblhmB0bNdZ7gXGpnYGhsU0H7uAwlCbtceJNBTw52GTDxi4nFn
 f4SdDtxBYNLU0PsZoBZykZyFKnMNCQ0nLsz4l3/ZJejnaeOkg3b5TvlFqKI9uQmVUreN
 gfNixqMMBbC55tI8sesWORPndzKhRpLXcWB1uBfxiZIG6GqeATffJl99fkG1mxgSRGxg
 lA4px7fGUkbcrb9BkQmNLjWNRoFLNBBgAzbbJqcXAQEc2EatNZY4xXHSqXRQS5kTAXU5
 KTZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4fQKjn5E5idGBJgOZil7Nf9zejoxe2TsJbjclOW+ITUStmTMns/i9vCFK4nBWmuSPktFQnb9yglUD@nongnu.org
X-Gm-Message-State: AOJu0YwlOk+m+23SGJzN/PYOVcyruq0uIs4fvAmywADh2zhCKkn5NHGd
 9Jz+j0x84sYy88CzL5Rx9hMhBssgyYSrlGRpMPdPLz0BxzLSBCGpAD700iDGPeyq96s=
X-Gm-Gg: ATEYQzwumZmhe4zT/nhrM7aTt2/xUZycjGp/0YLAqV7Z7GtoBPacEJsjF2YUOxY8IIl
 ztgJtBUzjj90alJdi6xH1LcxuB07OzX6U6+3B0cu7DkStHfSRT56jxKNLlxbrTJAZJKBu06XDtv
 zAV7/VzhbSlATwmZG5Ay1VZruM/xSXa717Byf0Ih9kPgs4wT9lKJ3tZh99zoM3xxFQyU630GRc3
 8ScT6PFEDkLJC+gjQp+sxgZ8FOewewd800/5Nt/tuWy9mHqOzOwWQWs7fFNwGEhIdW8OpBkroJi
 T1VBciaUr+0fpROCVs66YMv2albnF/e5q0/BlAKbkboZcI5mZxlX2Rdzh3d12iNXgztafo6O572
 lfXZPFx/9zhBj/kmfKtcSyiZ3hcIiPWwpiMVplyqXaKdRuC3oLCa68fL1mlA3BGjgoZ792sUa2g
 EapwUJ2v074JCTWj9mkrbjYPtiqLUZ8ZbAxVgxNQYQpqYNGNG/DBsSLkxUeft74uqM0nmu
X-Received: by 2002:a17:902:f70a:b0:2ae:3bb2:a8cb with SMTP id
 d9443c01a7336-2aecac49127mr43644545ad.40.1773430265035; 
 Fri, 13 Mar 2026 12:31:05 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece62c581sm40520395ad.33.2026.03.13.12.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 12:31:04 -0700 (PDT)
Message-ID: <1d34077f-4a6b-4394-b640-4126c53d0aef@linaro.org>
Date: Fri, 13 Mar 2026 12:31:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] bsd-user: Copy linux-user/think.c to bsd-user
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260313-share-thunk-v2-1-5b52cfe6cddd@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313-share-thunk-v2-1-5b52cfe6cddd@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/13/26 12:15 PM, Warner Losh wrote:
> bsd-user's blitz branch has used this file verbatim for a while. Copy it
> verbatim, but update to the new QEMU standards.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> As suggested in the v1 thread, just copy this file.  Refactoring was
> difficult due to the inter-relatedness of all its bits with
> *-user/qemu.h file. We couldn't move it to common-user and putting it in
> that directory because (a) qemu.h dependencies and (b) common-user is
> built only once. It may be possible to refactor this into a .h file, but
> the interdependencies have so far restisted my efforts to do that, so
> I gave up after a couple of hours of different attempts.
> 
> ● 6e7455de310b: bsd-user: Copy linux-user/think.c to bsd-user
>    ● checkpatch.pl: 66: ERROR: do not use C99 // comments
>    ● checkpatch.pl: 78: ERROR: space required before the open parenthesis '('
>    ● checkpatch.pl: 136: ERROR: space required after that ';' (ctx:VxV)
>    ● checkpatch.pl: 136: ERROR: space required before the open parenthesis '('
>    ● checkpatch.pl: 142: ERROR: braces {} are necessary for all arms of this statement
>    ● checkpatch.pl: 175: ERROR: space required before the open parenthesis '('
>    ● checkpatch.pl: 272: ERROR: space required after that ';' (ctx:VxV)
>    ● checkpatch.pl: 272: ERROR: space required before the open parenthesis '('
>    ● checkpatch.pl: 301: ERROR: space required after that ';' (ctx:VxV)
>    ● checkpatch.pl: 301: ERROR: space required before the open parenthesis '('
>    ● checkpatch.pl: 477: WARNING: Block comments use a leading /* on a separate line
>    ● checkpatch.pl: 531: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> I'm not fixing style issues in copied files. These files need to be
> identical. Style issues have historically wasted my time tracking
> upstream changes so are more harm than good. I had a simpler solution
> w/o this issue, but this issue already exists in thunk.c.
> ---
> Changes in v2:
> - Just copy it
> - Link to v1: https://lore.kernel.org/qemu-devel/20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com
> ---
>   bsd-user/meson.build |   1 +
>   bsd-user/thunk.c     | 470 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 471 insertions(+)
> 

Good for me,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

