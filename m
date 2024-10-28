Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5B2D1359C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 12:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5OX7-0007lu-LE; Mon, 28 Oct 2024 08:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5OX4-0007l9-N5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:07:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5OX2-0001hS-66
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:07:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so29901585e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730117254; x=1730722054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X6Wx3Ft4RvGHGnrjLN/OFmKjuZS1W//vEqGNZNt6GJ4=;
 b=kUSSsssKhPAzh8GR5aGW7IMIWuffIdp8tsyaAoXae7ykFk+kUPfGpu9jwTq/vOAe5c
 JuUxhpKIYFQJIcLJ0e0ByjAb6xUMHRxlaSN/2PuMz8vJh3/7Hjz2SM1dU0/Hoo4x1Xtv
 JMKbZaMD8kb9ltV4/c7VzqLTxC7n/1DbQ7R8zaQ5PfQAd+Ti5wePwyDLMekiAy1cg9nh
 vxBkyVO1HOZyc4nxcOgrt+OPc/mMGou7CBbC76EY+Zy99U8m3cN9gLumSxuofIiaWCn8
 Ny6khQQC+XD27QHfe/xIJKdTDP3AsmQEN8n5+7fPVMQWl4G7Ta7/3G936lyjuTev2D+Y
 C1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730117254; x=1730722054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6Wx3Ft4RvGHGnrjLN/OFmKjuZS1W//vEqGNZNt6GJ4=;
 b=is6E0IbZka4zgdnzRa22896hyANvyfcUJsL6Bj/1yt57abctOfGk5g9+o1thDvQl/J
 ruGSW5uSAOfQseIU/9ELI9pr4LpXQ6SjUnm57wHoEdW/qNdHTxurTLTxLalBKH+UnqKq
 UjZoNU0e5xqo0tgQCzCv9uwd5r+E4PeRoGdL4NROafoKdgE6/rZYG27c7DE8/eP9jjnh
 SaxKi0FoJPkvncoMN03kMfLFr437bH622Uvyx6YnZBA/AVzl0mDQ7afdKVEFU/S49lrZ
 xs6LJa/uHSEWuW9bZwOHPLQzo2Hd9iX8B+7kO6l9DMQE5BVR42gY7iVEpl64ID5DMdo5
 c3fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWvOdhuLYUgeLd4RLQbV1GMaClNp4wCVOZCmy6Zy+6WrIo0vXl0l6uQqqo4LA2QAOteYaUpF4hrxDB@nongnu.org
X-Gm-Message-State: AOJu0YzjtuHkmIiao11Y4lErp/VzItaouIQ9XhWpgMn40PPnzPra3auk
 fOr0afRMw5GSajYNasK0qFY9f8Pivdlxm4t8VvAwZke1mAbfI3ee2J8w6p3VlZE=
X-Google-Smtp-Source: AGHT+IES/MuXIwTkWTiHcJbqDLRiWEWFoqeXYdFmixdyHC6J9JYlXCnzXq7mg6x/6e/s8HqwByAxuA==
X-Received: by 2002:a05:600c:1549:b0:431:405a:f93b with SMTP id
 5b1f17b1804b1-4318b5b2c33mr109449265e9.10.1730117254018; 
 Mon, 28 Oct 2024 05:07:34 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b56742asm137432575e9.21.2024.10.28.05.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 05:07:33 -0700 (PDT)
Message-ID: <4ab2af89-4e1a-4658-ae0d-6721df2a3b91@linaro.org>
Date: Mon, 28 Oct 2024 12:07:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] softfloat: Allow 2-operand NaN propagation rule to
 be set at runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> IEEE 758 does not define a fixed rule for which NaN to pick as the
> result if both operands of a 2-operand operation are NaNs.  As a
> result different architectures have ended up with different rules for
> propagating NaNs.
> 
> QEMU currently hardcodes the NaN propagation logic into the binary
> because pickNaN() has an ifdef ladder for different targets.  We want
> to make the propagation rule instead be selectable at runtime,
> because:
>   * this will let us have multiple targets in one QEMU binary
>   * the Arm FEAT_AFP architectural feature includes letting
>     the guest select a NaN propagation rule at runtime
>   * x86 specifies different propagation rules for x87 FPU ops
>     and for SSE ops, and specifying the rule in the float_status
>     would let us emulate this, instead of wrongly using the
>     x87 rules everywhere
> 
> In this commit we add an enum for the propagation rule, the field in
> float_status, and the corresponding getters and setters.  We change
> pickNaN to honour this, but because all targets still leave this
> field at its default 0 value, the fallback logic will pick the rule
> type with the old ifdef ladder.
> 
> It's valid not to set a propagation rule if default_nan_mode is
> enabled, because in that case there's no need to pick a NaN; all the
> callers of pickNaN() catch this case and skip calling it.  So we can
> already assert that we don't get into the "no rule defined" codepath
> for our four targets which always set default_nan_mode: Hexagon,
> RiscV, SH4 and Tricore, and for the one target which does not have FP
> at all: avr.  These targets will not need to be updated to call
> set_float_2nan_prop_rule().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Reindent means a couple of slightly long lines in comments,
> but those will move again in a later patch, so seemed clearer to
> not re-wrap the comment and then re-rewrap it later.
> ---
>   include/fpu/softfloat-helpers.h |  11 ++
>   include/fpu/softfloat-types.h   |  42 ++++++
>   fpu/softfloat-specialize.c.inc  | 229 ++++++++++++++++++--------------
>   3 files changed, 185 insertions(+), 97 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

