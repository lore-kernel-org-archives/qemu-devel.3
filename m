Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF79C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 21:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTplX-0004kc-1P; Tue, 16 Jul 2024 17:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTplM-0004i8-RX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:31:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTplJ-00081i-A8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:31:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4267345e746so41895025e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721165461; x=1721770261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ulj0BqZZziH9hOi27BPQyxY2nNGLSfc7a7IUJ8SBeMk=;
 b=y/nD+XPFnu6pC/ltYg/3KDOBvg1zp7hTvYlF5788fepXqiQ0sKWfmtCwcdKDKMtgPt
 X1KR9t236jV4ZHb6oYqCFjTi/tgCBfFKJflSEh0e0JUOExKSrZ2Jkv1YGrg5ZP5C6wV7
 Sg+V/h2jnDNUEZZF7aAdcTLQLkXvhMCS23nEwO3rl7xhFN1sHlDPSOSr9lXqw3Q49y84
 vk0/JSwX3z1VFJ7WkkKOjgekEqWiTmvVAvCDN/i+xxB7B/O80VOJkeTKULqqp92dDkkr
 Sl5p/Kb/q2TVphpUI8zEQudowVD6j6UeHPxLKjKHV8U3V/uwDjPwnXhKoU2SABLCajn/
 HPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721165461; x=1721770261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ulj0BqZZziH9hOi27BPQyxY2nNGLSfc7a7IUJ8SBeMk=;
 b=gRjkDpBVLYoZw+34TAO+DJhLnfF5+hIiyYXxSHJHotUKaYFvdiNzy7oH1MyhZ3ya9o
 y30gfN6gZWAuveXzMF7B4wb5mbyBkIeGHRDseRyu/8u3rfo/LnAEZbUZ6oYVCRUASDty
 gQCWBjUtGYEiJpSJxFpSu/xqFx9DB650RgS4LA9Jar1opjw3ouWX80TtlC/k3Hav89n+
 MPsPs/Oa+YUX8IrsLUDPhwoUtrfUY0O951JdM1qmhiLstLaYnGd8PrjkRZNTXqZpradf
 dnivt9jAKOAcBIIeETiOo9tKWZnpUG0ON2149IAPPyZP7ifj5dBdVUIfZo0Uxp1ICT8D
 2ybg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4/JL8CUrCzRVIROpaeKTvLuflwb5wHQcIykhsYUXrlZ2eLvQvMr3zB+ytPOQMRgwWemOH/K9JjZb4GB6CvEy0LW1sFUM=
X-Gm-Message-State: AOJu0Yx1hYPRwdHgPaaKWj1x8dF/4O7rlNQ9AhTiBP6k/4h/scb7d+ZP
 Nv3M4/LLsjdLSeNNBr/ME+UKmyYqy67nGB4sO6kTuby2ghsZ7hAlImsx59GuFMI=
X-Google-Smtp-Source: AGHT+IGJcVVokyQ7/YDnA9HfAwTUelrOYHO+PuhHtlZdbvA+4M/cjlmujv+TQzqtaeDEV+E1HKdAeQ==
X-Received: by 2002:a05:600c:19c7:b0:426:5e8e:aa47 with SMTP id
 5b1f17b1804b1-427ba666c49mr23929225e9.4.1721165461060; 
 Tue, 16 Jul 2024 14:31:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d74d5sm181490285e9.46.2024.07.16.14.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 14:31:00 -0700 (PDT)
Message-ID: <61f65df7-d7cb-4b7d-8c72-6526b349e501@linaro.org>
Date: Tue, 16 Jul 2024 23:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch/gdbstub: Add vector registers support
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, maobibo@loongson.cn
References: <20240711024454.3075183-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711024454.3075183-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/7/24 04:44, Song Gao wrote:
> GDB already support LoongArch vector extension[1], QEMU gdb adds
> LoongArch vector registers support, so that users can use 'info all-registers'
> to get all vector registers values.
> 
> [1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1e9569f383a3d5a88ee07d0c2401bd95613c222e
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
> based-on:
>   https://patchew.org/QEMU/20240607035016.2975799-1-maobibo@loongson.cn/
> 
> v2:
> - fix tab line wrapper issue.
> - Link to v1: https://patchew.org/QEMU/20240621065406.864232-1-gaosong@loongson.cn/
> 
>   configs/targets/loongarch64-linux-user.mak |  2 +-
>   configs/targets/loongarch64-softmmu.mak    |  2 +-
>   target/loongarch/gdbstub.c                 | 70 +++++++++++++++++++++-
>   gdb-xml/loongarch-lasx.xml                 | 60 +++++++++++++++++++
>   gdb-xml/loongarch-lsx.xml                  | 59 ++++++++++++++++++
>   5 files changed, 189 insertions(+), 4 deletions(-)
>   create mode 100644 gdb-xml/loongarch-lasx.xml
>   create mode 100644 gdb-xml/loongarch-lsx.xml


> +static int loongarch_gdb_get_vec(CPUState *cs, GByteArray *mem_buf, int n, int vl)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +    int i, length = 0;
> +
> +    if (0 <= n && n < 32) {
> +        for (i = 0; i < vl / 64; i++) {

Preferably using FOO_PER_BAR definitions for 32 & 64 magic values,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +            length += gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(i));
> +        }
> +    }
> +
> +    return length;
> +}
> +
> +static int loongarch_gdb_set_vec(CPUState *cs, uint8_t *mem_buf, int n, int vl)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +    int i, length = 0;
> +
> +    if (0 <= n && n < 32) {
> +        for (i = 0; i < vl / 64; i++) {
> +            env->fpr[n].vreg.D(i) = ldq_le_p(mem_buf + 8 * i);
> +            length += 8;
> +        }
> +    }
> +
> +    return length;
> +}


