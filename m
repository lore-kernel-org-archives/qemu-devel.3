Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20446EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnheL-0006to-Kh; Wed, 04 Feb 2026 13:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnheE-0006sW-CU
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:30:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnheB-00036Q-TR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:30:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso924215e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229838; x=1770834638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jb1F9Vr2vzh6XgXud4z+xI0erfynMFsLEm+U9URSLUQ=;
 b=ASdizDdn47AapKlhqyqKBjjWzl4q95jOPyR+EgSvf3tHLVA0yOF2V1ByghjAYUu0/m
 pYR9cn3RzzKdBHZeIQtFlcxMNbltaYaDMaJhpBv+r9zCfcWBp7599Q878x6nyuDtPC9+
 KorueiECupo48medC7kxbA0wCs9+6O1Z/7cHlMKzD1rOu7GSw07NbqWDUZxI9uhWi11y
 SZV2C48UduEaJGe4DgPuaDPP02k4ppZUMO4zWQLkEg5TkOxQgAPEhTOJ1oqNKRmdsxPE
 Rd1V8R+FfFN9yHuhwsT7m58ntfzX42cPhf2dChTi2I8b8mj0STVDTna4tOtmPGekYZYI
 SZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229838; x=1770834638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jb1F9Vr2vzh6XgXud4z+xI0erfynMFsLEm+U9URSLUQ=;
 b=H2Um4/k6CoOaOl9YphVgm0DVpoFhSXNqO+lEJj/Vi8LGXZCwSHmBZrayoRsoFLH8HJ
 8NSu2RfFu21BEKSQUVlUoqewpYAbS10U8l+BexVM7TLHiTESrjt00P0c5WmzF9QtFr83
 ZVHt8DMSeaGVeoje6LdGG+63Le25micX5TO8PLrtmhQqpuYRGR8id55TpVhSBJRsqSH2
 1ba4tGiE95tMFmicg8wEuRyK8eS6xbEqYqXMBxvLS0703uDOeFTuMPN9AA5VvuonaosW
 mbpOVJjTiCw96ZM1Ub9yEpXTCd25SZ4NE+zA+DXxJpS57qWjSkeuAaXLlk6Sd6iZ7IR4
 mflA==
X-Gm-Message-State: AOJu0YzZ5sadmguCKPEt9E6CRL8QslcfzFTUqPRaPV17pHDphi90Boe2
 EbsaJNs7ETArzJnvYChew0WjqS2k6nQmZcBfjG8JCOVbcY+tpIV7CvCLansRVfm2+FZfDf6i83Y
 eAXJU82s=
X-Gm-Gg: AZuq6aIlat4Hbi5eK1UktVYbWKvZK5GDLfXU+FzIfmHTYL6UnkzbACfYD4zltsUcERq
 r5ZchUn+DmWfUoWt0pYqE+XoiYaKu1ahISmkx2w4v9siGAWO0c+ild0jM3vC2d4/9Y/5rO3gPWd
 V5rk8KZR8d0KacqTcg7cVPzmks7r3/HYb70eWb4c6OAjRyK5PVw/Z0xer/0GRthViLi+QeUj46j
 iLyfsoHPyVxlBqm1GV9qVfhYxkGIYWYsqHjQR3WK6BKyOl8dC+xFEJxJFuT53DxBaYuuzua0ht+
 P4cwDWFTjfTlrsuIeQJZFvpIC31UlDDZ0V9nBNvgkwDIIM0GexuCWcDPPkLcD9Ty80LIvJffpw6
 rwQcQoZglj5I+6v6+5Xjn3BE9MWTjsJzoufgOoKOzhOkWFZ2hpAR7oF60M7SMPQ9zYrl3kGPLDH
 r1iC7AHiNc9QC872q/Z4fcYsDxk2PkxY7mnUi8T06tz/MQ2FoKetEEaA==
X-Received: by 2002:a05:600c:3143:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-4830e987c76mr60392235e9.22.1770229837677; 
 Wed, 04 Feb 2026 10:30:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d20319sm4249475e9.2.2026.02.04.10.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 10:30:37 -0800 (PST)
Message-ID: <8535c348-4eaf-4085-aa7e-c7219f8693cc@linaro.org>
Date: Wed, 4 Feb 2026 19:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] target/s390x: Expand TCGv type as 64-bit target
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-10-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204182722.44062-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/2/26 19:27, Philippe Mathieu-Daudé wrote:
> The s390x target is a 64-bit one, so we have these expansions
> in the "tcg/tcg-op.h" header:
> 
>   . tcg_gen_qemu_ld_tl() -> tcg_gen_qemu_ld_i64()
>   . tcg_gen_qemu_st_tl() -> tcg_gen_qemu_st_i64()
> 
> Use the expanded form which is more explicit when a target
> isn't built for different words size.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 54 ++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)

Argh, $Subject ought to be:

   "target/s390x: Expand tcg_gen_qemu_ld/st_tl() as 64-bit target"


