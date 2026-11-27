Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F71606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i1u5XOVY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwM0-0001L9-9u; Fri, 27 Nov 2026 08:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwLw-0001I3-Af
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:51:04 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwLu-0001lu-Fq
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:51:03 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67dc7eb1442so8806081d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795787461; cv=none;
 d=google.com; s=arc-20260327;
 b=U7wEE76TFFzC3u6gMGa3NVUT+nwFTTg2+kwclXQ9rWPio7F4IMV3NYBkt4qVvZPEya
 0/FTQEuuHTxnV+p/jMIXjJY/NgVcb0oD0RU9EuBsZmcLlWlzDJQxrzYMMeuTxBCRx3+s
 x/8Gy9bhiplHY1jiE2WJffTbg40HpdA6wJpIrSXCoDyP34ZCxT1CKg0jZEQB/Or8cKta
 kgeAl4vZi59PmQwU4FFkwOeZQRDBbwMcNfbWKXgRhQs+yGNAZQurX/LJu0vaJM5+S9vJ
 zggSQ2dhrNIg76AyFoF8hSPbCC87FfWfIeS7yYRDuv21Stjn9tKN9E1dn1MpgBEtCeIz
 Z4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yWmYTTgYAAv4tYcLeqHqnQmFB7yGxhcFhP3aXN7ZeeI=;
 fh=Ic+PdDB0MxQL6ESDIMezI168/kyfmimyMkeYx2Qtfr4=;
 b=AiIOWxgxnvSF4V4p7IPc9UN/+Ntw8fpRXm1prTcYpNaf0edo4Z3jTN/r2W32GApBS0
 VeSsoRUNaCi3fSgKRnve+d31EptayysLLVCuZ2onciq8e3Yyl35ub6UuUc7xpzZFZITM
 +6G9O7qihQ6XdZc4FRjhw6fBEOAz8J2yrESMlTt2njOy+kxMgLbMD5pAgqgU3gfrXSEs
 YfiB41bERt4xJK0HJK8zNIy+34T95Ih0FadStgKsWgGMtQX7RPoKw3Tzs4yFxCtkbR1q
 edsNCyvHQhWHCJFkou6imXBuwuSHDM87e7YyAAcCEwoONarew16FClGPYruC20/mjwy/
 PODA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795787461; x=1796392261; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yWmYTTgYAAv4tYcLeqHqnQmFB7yGxhcFhP3aXN7ZeeI=;
 b=i1u5XOVY0jMHqZ1Prp4iGY0uz00OzEVbxyF7mXBCMNYzs5ZNTFDunaRaQ1xZ1iPWjp
 eiePe+LRnWnuZfEfB14jOPChdPOUkPZ7udgMZbASZbjWnj5edseSDyiUoTfFHBsuvfcs
 8kHOSQu1ak0SxdlES4fYYMNmKL8Wa+UHHcHlHNqsccZfhexq4ee1ym7K9kyY6R9/l7zW
 nrZ/gX/YU+Cc4CLNPFhMpG0SNuhUmNeqQKBj93NrD2ySN42QZVJtXQpM+jUzCTWBP2KD
 dRHWXANXX8c27Z9Ijj8/rl1gxVMU/oCqnADuvuU56ZhRni2Xk4Fex0HjYFBpWgrkb0yj
 Z/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795787461; x=1796392261;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yWmYTTgYAAv4tYcLeqHqnQmFB7yGxhcFhP3aXN7ZeeI=;
 b=wSFkh5CquT+cQ3J7fRivrd9EZU3BxXe1GwgPdufjAE8t+wVZqA/yasZTcCN0mTtayz
 unr+9UJ9bh6avgSOh4bhvEDWdSrOxcZAAclSkHqTzYUqgYLD5P0r44b16mY019ppKjRd
 QXc9WPa4Hf+yMvtaGKt6B5zEVBE5WvB6vZsi2NBm+pFeDN7asy6cGetDnkP6nuQ2Vpha
 II8p+29OhNCKti3gpkQTi8QmCxvmRDJ2NOVkR3U+LDL0fJwSFTmwu2/NBbueUUNzr/Y6
 cpJKGGzWOwQximzk0NfqvzmID3h1bxzAR+eor7VLqGuwvS+ZbCIBOpB4ROqOWK3J9F4q
 W+Hg==
X-Forwarded-Encrypted: i=1;
 AL+hErHLdrTLvuJ0mccls7fyptxEqkBQ2ituFTEDbdvQUrln1HAkFV8ktb6kJO+qA+OuxtuJ8A57jkfa5zOj@nongnu.org
X-Gm-Message-State: APuU4Z+bU63M9Ve0OYyXtSZ/nQ3KjpQkwTXh/Ji7hZ0LBGeGBiEjus0Z
 YZzEhSmNKXlW4n+mY6+CufTpMrKFGqXLSz+GQT4j9nIYWP4hTlAuONgdWbVxw4LKbkbwqZ6Xa2q
 WXd8zXnUSf11uIZwaiNNv5R/g+jitzMxyhKriddNtCw==
X-Gm-Gg: AZFdTZfx0nvC1403ax5+qPbGPcU6uikKxc0vIeDtLQpK0G5oRYldmm0oYcjCnlcIi49
 yBgBayTHiMXdMZ4R3Hyqzpknxyr8iZbzmoreVLEBDp61Z2wZr09zD0AdJG3+/0ATdbIto4I1t0W
 jsKWo6Am+2SJvDPN9S2+tXwwmpBiXUyC0GtunbIJy7fN2zSnBtPSjBKd/c3roLDlfC+EcD/PZMH
 0UjJSZiEPub5wEKnnowcqKkqckU4VY3MgXUeAVQoiIwp+5lr9XuaKc6IVvKKi24WVIS0eyRpJIt
 Qv8TbmEYeknNpj0PrO7c4DG/fznV0DsUeXt+L2/KKpAhJsb/84f4JDk+VHgd8sREIqKYffGqNMI
 Oa59X4Rfz7mtq6v5HMoTjR78Xb0kg1h9NxXNrGwRPJK+p8iQ5tiG+JXxPHTzlEYWBkE/ovJKM1+
 YyVQ2IiUja5a4gaGrhM7NF
X-Received: by 2002:a05:690e:1918:b0:67d:bedd:4939 with SMTP id
 956f58d0204a3-67df42b4d63mr13092270d50.5.1795787460859; Fri, 27 Nov 2026
 05:51:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-9-peterx@redhat.com>
 <87pkvqqtlm.fsf@suse.de>
In-Reply-To: <87pkvqqtlm.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 13:50:49 +0000
X-Gm-Features: Aa3M54qR64LBYNeWkubydr5Cue5eVlmHIL17yF2c625C2iQPfhFMpF-vh01h_-g
Message-ID: <CAFEAcA_By1BDLuZKaSVyKKwefe2KBaTf_4+tHMu_AORxOpWp7A@mail.gmail.com>
Subject: Re: [PATCH for-12.0 v2 8/9] arm/machine: Move all VMSTATE_VALIDATE()
 usages into post_load
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 at 13:42, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Xu <peterx@redhat.com> writes:
>
> > To pave way removing VMSTATE_VALIDATE(), move all four such uses into a
> > post_load hook instead.

> > @@ -1177,11 +1128,48 @@ static bool cpu_post_load(void *opaque, int version_id, Error **errp)
> >      ARMCPU *cpu = opaque;
> >      CPUARMState *env = &cpu->env;
> >      bool ignore_s_regs;
> > +    bool valid;
> >      int i, v;
> >
> >      trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
> >                          cpu->cpreg_array_len);
> >
> > +    if (env->v7m.csselr[M_REG_NS] > R_V7M_CSSELR_INDEX_MASK ||
> > +        env->v7m.csselr[M_REG_S] > R_V7M_CSSELR_INDEX_MASK) {
> > +        error_setg(errp, "CSSELR is invalid");
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * Check MPU_RNR in-bounds. If no MPU, we still migrate these fields
> > +     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
> > +     */
> > +    valid = env->pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
> > +        (cpu->pmsav7_dregion == 0 && env->pmsav7.rnr[M_REG_NS] == 0);
> > +    if (!valid) {

I'm not really a fan of this use of an intermediate bool, especially
with a generic name like "valid" and that we reuse later. Either
the condition is simple enough to do inline in the if(), or else
it's complicated enough to factor out into a function. I would
just put the condition in the if().

> > +        error_setg(errp, "rgnr is invalid");
> > +        return false;
> > +    }
> > +
> > +    valid = env->pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
> > +        (cpu->pmsav7_dregion == 0 && env->pmsav7.rnr[M_REG_S] == 0);
> > +    if (!valid) {
> > +        error_setg(errp, "secure MPU_RNR is invalid");
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * Check SAU_RNR in-bounds. If no SAU regions are implemented,
> > +     * we still migrate this field, but number of regions == 0 and
> > +     * SAU_RNR is RAZ/WI so also 0
> > +     */
> > +    valid = env->sau.rnr < cpu->sau_sregion ||
> > +        (cpu->sau_sregion == 0 && env->sau.rnr == 0);
> > +    if (!valid) {
> > +        error_setg(errp, "SAU_RNR is invalid");
> > +        return false;
> > +    }
>
> Shouldn't you guard these blocks with the result of what .needed would
> have returned on the source? Otherwise we may not migrate a value but
> still try to validate it here? I haven't checked if the unmigrated field
> may end up with a value that will cause these checks to pass.

They're OK because the reset values (zeroes) pass the checks.

We could rearrange them a bit into

   if (arm_feature(env, ARM_FEATURE_M)) {
      [csselr check]
      [sau.rnr check]
   }

   if (env->pmsav7_dregion != 0) {
       [pmsav7.rnr checks]
   } else {
       check rnr[M_REG_NS] and rnr[M_REG_S] both 0
   }

I don't particularly have a strong opinion either way.

-- PMM

