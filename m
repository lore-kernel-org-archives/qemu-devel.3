Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D411D462C4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFZl-0001bH-OR; Wed, 13 Nov 2024 10:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBFZj-0001ax-1d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 10:46:35 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBFZh-0001DE-3R
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 10:46:34 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb6110c8faso65722281fa.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 07:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731512790; x=1732117590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z7u4YEEn3cb1NSljyuIRBPB0esooHatUpF/cpdMl85c=;
 b=rrTBKduLv11UAjnazcqUplDeiHdd4qzztXzaH5L9onBPNodgfrZldn59TZ2qcY+RNs
 iucSIAYzSSuMAPm+KWpQq+Pzq4prr3Qsu33psBHR+9J5jcWz+9g2lx6vdDWJsQsq2zYB
 VdZy9oqi5h8lcA7T8kZezHqGak8hF6xs3JZueiXrvfN5npbSArIuYH25CKuM21bWXpOP
 o4Emq23P7z91uXKXDltUfR78RQQFv3KCakNPnCPUkmG3xy+95dBKqjdk+05nBJCQDde6
 b4XFSSDKaPdNvE6yzY2RPLy87s+hSLEpMYSkK7l5fwRLC39EZqzjIgUxpSuIW+QtQ6iQ
 4RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731512790; x=1732117590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z7u4YEEn3cb1NSljyuIRBPB0esooHatUpF/cpdMl85c=;
 b=S7EORRD+GGvZUqbTPUV9LoUNxgQptcpeWX2EXR7hJU8w8zjrs0aSezeg9tfK5MSa9h
 GT232inN4VGa9v5GkpXQEK/GeZ3xTKh2K0xpdEoN/lwlbgi+tbIX7kHuz8KHsj3mWGDi
 fOZLnZJaiyygd0CZjyCu/1Tpcc7mCbb3TsaMiE7HrfEYmoysXZXBJ9T1es6tkPv229ZM
 9a3YWwI5v0D4ANaW0QLzGVtcrvaBzsMQFE7MNmAiuvjNcifrKl52nzFtx3Rz7O8ZfOOh
 303BCT/9YbEOeiwVAP2FL+hAN1twv/56Th9tX7x0wacnsiGwN0giqKLPMYjW4q5oo/i4
 Tyag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUghY9zxMa5bveTtFeEN2vGl9S8awu5CpyTiaAwaeZE0V6PgAcq7+svhXDAi4rlWrJs8RjWL9QVdVqI@nongnu.org
X-Gm-Message-State: AOJu0YyJ1eSC2Y16zFd7/tLBaJzVgm//Ir9C18StBmxUTDpLWSz4wzCJ
 Fr7busctUnBzH2a4+icGwHP6uxztTomLP7VB2Atp6zL1u6q6GogZD7hqsOMAoYo2kWiaY49RBYW
 vDLzxSAF9aFf2Nni1OscM4W8OhXcEglYS0I9RdQ==
X-Google-Smtp-Source: AGHT+IG8pnR4b1T6NkEdp4wYT5WT/Wg2Sg74OosxrlnEeYG9KcgPUgFvKmoQiLdVk+58ATLSCrE+q3yo2udXm93GBGs=
X-Received: by 2002:a2e:a813:0:b0:2fe:fec7:8adf with SMTP id
 38308e7fff4ca-2ff2029fed5mr101267331fa.38.1731512790335; Wed, 13 Nov 2024
 07:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
 <20241107195453.2684138-2-titusr@google.com>
In-Reply-To: <20241107195453.2684138-2-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2024 15:46:19 +0000
Message-ID: <CAFEAcA9OK1g-d1AkyzQ_KDdREd+tQdFQFpBocGyNDLwPi6D-BQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] bitops.h: add deposit16 function
To: Titus Rwantare <titusr@google.com>
Cc: minyard@acm.org, clg@redhat.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, philmd@linaro.org, venture@google.com, 
 wuhaotsh@google.com, milesg@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Thu, 7 Nov 2024 at 19:54, Titus Rwantare <titusr@google.com> wrote:
>
> Makes it more explicit that 16 bit values are being used
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 2c0a2fe751..05179e3ded 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value, int start, int length)
>      return ((int64_t)(value << (64 - length - start))) >> (64 - length);
>  }
>
> +/**
> + * deposit16:
> + * @value: initial value to insert bit field into
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + * @fieldval: the value to insert into the bit field
> + *
> + * Deposit @fieldval into the 16 bit @value at the bit field specified
> + * by the @start and @length parameters, and return the modified
> + * @value. Bits of @value outside the bit field are not modified.
> + * Bits of @fieldval above the least significant @length bits are
> + * ignored. The bit field must lie entirely within the 16 bit word.
> + * It is valid to request that all 16 bits are modified (ie @length
> + * 16 and @start 0).
> + *
> + * Returns: the modified @value.
> + */

Why do we need this rather than using deposit32()?

See also the comments in this thread
https://lore.kernel.org/qemu-devel/CAFEAcA9H=w29-8CQStYYNwEU=OEB=NzxpioaqGEgSpc4KnPOHQ@mail.gmail.com/

where a deposit8() was proposed.

thanks
-- PMM

