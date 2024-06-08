Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D1AC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 19:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG1Lw-0006FT-CZ; Sat, 08 Jun 2024 15:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1Lv-0006F8-6f
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:03:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1Lt-0001qQ-M1
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:03:46 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6818eea9c3aso2454546a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717873424; x=1718478224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/me+LvmxwPsNvxGAWU4NHMCEOs2aPmngEYNYWdFU1MI=;
 b=fzePJle1P75W7ED6cDIjoTgnQAa7zPpc65saH6IFB9EzIDNWrWlXvFcQAjovTHeZBy
 Lr1FFi3C/DJBRUxUrpy9YiQhHO7PMU3cKvajNt3kSiqZKBGqoqpmB6O5Hn5+HwFrLxGb
 +pbbPYIYYJW2dZKEKY0CIvIeuCJQ0GGHl7StmvywsgR49ftP8JLRxM3U4+h8UbVtgDHx
 GL8OpKvpoTOeP5Koc3x2MBVcYTmMXlXRICR4orCAXkj2aZMUe7WyLHAuSOvfWinSDXfL
 7+faoAd9JcQZjU2/AbfzEpko5bGEuFMflvk63d767szQgOdPI4WvHEHvLtQri+pM3rLx
 LiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717873424; x=1718478224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/me+LvmxwPsNvxGAWU4NHMCEOs2aPmngEYNYWdFU1MI=;
 b=jIPinJrixDBc5hBssTYgucwhsuOPz/+rUwb/dQjrhE1vpjgKonLjeBpFukqfmKmImO
 9Gx2PHHo4rum0mNffZ+c/xOl2/IgpB8K7tGX60kNiggVAo+3w3YW7yWMccwvOyZNdeLO
 lfTHbDxAcu+1UnAJ0EHwISvoRADmpCWYLJlNYItwQexT1D+8GpxxE85UAWj01FA+PT2g
 /cSD0nXwyrvnNECJZeIHl7WmO5trklFWiKBQ0OJnLPhkcNMhN5pz/9e/H7VN2Ta/1kyS
 8MnxyNzKvfddQiAFrU0jVsuNzILZJPtQQqv85FQp7bj4BpTCtuiii/z9e7loFLG/TSvZ
 bvwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1QJW+7gFX76e3Z7T2RDf3gQJWJmOcfHOktvOACUxaOjQBxDcx5NhpsnnCv7hda+9A5mWL0gfvmCI/oonCKsBljsD3jKM=
X-Gm-Message-State: AOJu0YyF8haXQE05giWbL2ZUIdXjijUgJ56SnkzXJJwhyJao6ZN/QC2q
 q/K237gMvUxkr8L2QAQa1FMC+00zTnODVnpyAGu5QsCwgpOsTfPBWhTxr+f5ts+n/dLrOC9WmlN
 i
X-Google-Smtp-Source: AGHT+IGfZ6fG7Mt3BRcK08In3YtQQrRSyEWlWso2RlSBHQGepyGHF54ymixZIZ10MGOPeXVSO8RtUw==
X-Received: by 2002:a17:902:ce04:b0:1f4:a77a:3b81 with SMTP id
 d9443c01a7336-1f6d031f867mr72574415ad.41.1717873423636; 
 Sat, 08 Jun 2024 12:03:43 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7ccd3bsm55263095ad.176.2024.06.08.12.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 12:03:43 -0700 (PDT)
Message-ID: <c2e29e40-f35e-4bb2-93d3-7b924dfca5c6@linaro.org>
Date: Sat, 8 Jun 2024 12:03:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] target/i386: convert non-grouped, helper-based
 2-byte opcodes
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> These have very simple generators and no need for complex group
> decoding.  Apart from LAR/LSL which are simplified to use
> gen_op_deposit_reg_v and movcond, the code is generally lifted
> from translate.c into the generators.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |   7 ++
>   target/i386/tcg/seg_helper.c     |  16 ++--
>   target/i386/tcg/translate.c      | 148 ------------------------------
>   target/i386/tcg/decode-new.c.inc |  48 +++++++---
>   target/i386/tcg/emit.c.inc       | 151 +++++++++++++++++++++++++++++++
>   5 files changed, 202 insertions(+), 168 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

