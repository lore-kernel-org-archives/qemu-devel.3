Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DECAD3517B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7v2C-0003iG-9R; Wed, 01 Apr 2026 08:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7v2B-0003hz-DP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:50:59 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7v29-000112-Ue
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:50:59 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so220956366b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775047856; x=1775652656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcRmbsIvaveKpw/GQzZjT9a7MrE5y2O2yz/kvFV7ELY=;
 b=D0rsylmKS5Wk2oE95dI2okUzjbLcJ/9iqnIKVxfKUsgoYPOCBENDNWhkQh3gbBB+N3
 5HJxOaXmP9kKf7nJ+/4EFxtX2Kvy3RAtWkksP4JlpaNDTjnfK2yCAU7zArKf94DLScUW
 3cQdwJ6y8/zCZfEtd8yc3m8JL95ZlmW1bwKOg5jlpq6zYjoq/dBA5uCLZivU8a43f6Nd
 iDmyzlHzxrgjWgbjTMhebOrqMLCWcSG+ZfT/gsR+7VAHdJBYxFu59MkIdBr1hLrmDXKL
 lWNJFTR58qGAyfS57Dn7lF4++MCENbTFeNPEZRdpVrnAyMHh9BeSUeBAd4dOoCaFB/M+
 buSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775047856; x=1775652656;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcRmbsIvaveKpw/GQzZjT9a7MrE5y2O2yz/kvFV7ELY=;
 b=WTMK7eW2dvJxbz1vqIko3YiHCs3vwITeBE8tmOJ38DsiA1eHHjBJ7ye6ZvXdSNDzUR
 yBwKGAA5Ol+LFn9fhb2Z1e7y4TfLW4YTZwcSHX5azK03Slr0dTDkpi26X/DaVYHF2cWd
 1Qrny6PubuAJU/LkbxCkL+uu3hqIUkwdUWj9yQ/IqmL+7yw8wySSRBnhgStD0zvxp3cX
 yXlZDvszO1kHwvZ26VjnN+qrW6F5pGBmSQcx/uVzm7vWiItFF0NlZnzbs4CcUq7Kf3H+
 WYK8Dp81eadevOQjtQVmHTfXCaZ4XhhmfuMlV7/W2yrNxCXg24ndy9Y2XBWpnY0l3OUs
 AHmQ==
X-Gm-Message-State: AOJu0YzCiiwdHn/knQbehJfjGrANYLmwClWBYw+4Q4s/ec6QeflHCdG3
 6KwdMce3/1eR8v9masnxPiPojdZhzO1Wv4RZHFpGGdUYlt694QTgZmiv0ZmD2Jv+3c0=
X-Gm-Gg: ATEYQzxNSiOzXxgckSPJ66Ex4OsCNh4osFmup4ELjHq9OKgo+PHUuZNxrX/M75KVyx0
 0OdTgkZvdUKp34pjKo4QCetsevtKJPXoPDg4tXyL5dvCB4k9stspx0v/hBwW7eO7TnLnBBPaMGq
 i3yMUQ9nQUqSM47Kv4FUpHA/tuIJoPKaEtTBfpw1wc9mzZFbl8bk9npY5hfGzP7Bfvu+mfZM5jH
 DeoQwQZu7nVxpA7zrPw+3onl1JOXNmvI3JqG3EcCyJNzMM+FMLEXED+9tt7cUHr8iylXkz3pjZo
 USvGTAC+ifjfq4u1ZmFfFZEUrQQVrDhcZu7uAQU3biqH5UclFm/2U0NJH4CM9uYHcp3999GMC+A
 65/PnHwY4h5QC37LmhsxV/LVt1i6BOTjO4P5axcI7IDhQtuyYjCJ4U5kk6ACM0laN24+sFXM2dy
 tGHA4A6poqxaAvGPV/uXHrrRmSGzKhIaeBVA==
X-Received: by 2002:a17:906:b313:b0:b9b:3a1b:e2ec with SMTP id
 a640c23a62f3a-b9c138beafemr192553566b.14.1775047856099; 
 Wed, 01 Apr 2026 05:50:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5924sm520159466b.32.2026.04.01.05.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 05:50:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5CCE5F8D9;
 Wed, 01 Apr 2026 13:50:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 03/35] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
In-Reply-To: <595c4e17-c6c8-4281-bee2-8ed50d27d582@linaro.org> (Richard
 Henderson's message of "Wed, 1 Apr 2026 15:43:37 +1000")
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-4-alex.bennee@linaro.org>
 <595c4e17-c6c8-4281-bee2-8ed50d27d582@linaro.org>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Wed, 01 Apr 2026 13:50:54 +0100
Message-ID: <87a4vmq1xt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/20/26 23:05, Alex Benn=C3=A9e wrote:
>>   static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16=
bit,
>>                                             int coproc)
>>   {
>>       /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA =3D=3D 0 */
>> -    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
>> -        | (is_16bit ? 0 : ARM_EL_IL)
>> -        | (cv << 24) | (cond << 20) | coproc;
>> -}
>> +    uint32_t res =3D syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
>> +    res =3D FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
>
> !is_16bit.  I'll not mention it again in the series, but take as
> given.

Impressive that I managed to run all our tests and nothing tripped up on
this!

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

