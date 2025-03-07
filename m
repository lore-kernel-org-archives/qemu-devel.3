Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64F8C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 09:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqUB1-0005mD-6Q; Fri, 07 Mar 2025 04:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqUAy-0005lz-O7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 04:39:28 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqUAw-0004fZ-Kt
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 04:39:28 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so1345945276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 01:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741340365; x=1741945165; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FoYUnMOO5qw+G5tvkquUywqLJtBN0w4ltvm0//3rA0o=;
 b=SivyIyQnxL2knBEWUXced7AZz/6A8lLk1o4p4wAW4YaN93sWjRNl26a+zFJv8AtgbN
 YPu+ERX4Fda2fideoytE4oOtgPMQwBUA1D/3TNn956fvMSeL01AaKq4DooAMGua1jHU4
 uIJsEp+drBYVH+dtdL+ZXrRzH2pPuhrtc3ZJICBpdGenCdhpedfId0W585zQdiBG2ZJB
 WPn+Mb2w/bNYF2qbKHc/wY6MBymlxHqgDl7RurMLugIYyzswbtRe15PNI8vA2OnuPw7v
 ty+O9CiCB+QsMbXs8+vy4BhLWKS77wnQw6YMTVScpdZ/SuuGZOLNs9ys8PrDk8EfRNCX
 4Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741340365; x=1741945165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FoYUnMOO5qw+G5tvkquUywqLJtBN0w4ltvm0//3rA0o=;
 b=pjKdq5suW8de1rcl8FrJ7+AhkRXWN25rD5HKy+Nv540o4bSPle2hozl231/6eQQxQ8
 Sw4z1bl3au/ygDnpXZXcdu8o2fOudLJj29M/EqdRR0Ca0BMEgph4GkK8H/cQdRECxkek
 pjtXGvjpurM6WAc3JLqh7459BRPb0KfaCJmzWYXCjPlKyMSfdYKORyLja45pFku9tcok
 xzIiTI5bG5vxAz86pDlzXM8VHxwpzJLGi7/yqBtFhtr9k5Tn3H2riAMP/5YGBIDjUW99
 OTEKPQg0N9YdXxmdjA42lSn0WP4QvhckZqFe2SthOqs37lJyxMhrbjfkz4aQUbTTZY6a
 Vnig==
X-Gm-Message-State: AOJu0YyVOJnzoVk6DZ0hEXmwHOx62im7QCR+SGcW0VuBJgf2ejf+MTFJ
 mm9+OOvJo4Uq5Y7YrEzJgvo9FHfjo8agXOPsMmtxy+tYCLZA3qolepb37N0+3zADXazD2UYQlbI
 f3UMuA3JlI5R9mVWjY/8ZvHrJllaXkfvWXeBMmA==
X-Gm-Gg: ASbGncvL7l1XVZHLT6Mffx4GWExsVnpjaUeeRt4Xm4X1TryEqxEsRZgIDAV16lQKUEo
 4twsBNUCwHMyTLBuOY2ew5kPImz1a/NgmESUcWq3jBeCi3amjvi6lUAAnhvOBrL9xTdSTbjEUb4
 1HyGlVAb8Fxf93YhRC8T6eg/RGFxo=
X-Google-Smtp-Source: AGHT+IGRYO7nnH6tFDH/Ez8nd5a974JZSIeVbjZY/Pa2AX+7qpQhx0vnv/8SPpGXzXfUbCe5YFexHCtySj3eQVDFbx4=
X-Received: by 2002:a05:6902:2848:b0:e5d:e04f:f2bd with SMTP id
 3f1490d57ef6-e635c1dc48fmr3281112276.44.1741340365559; Fri, 07 Mar 2025
 01:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-8-peter.maydell@linaro.org>
 <54de9ed5-6314-4a49-a1ed-cc9d6225897d@linaro.org>
In-Reply-To: <54de9ed5-6314-4a49-a1ed-cc9d6225897d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 09:39:13 +0000
X-Gm-Features: AQ5f1Jpq98pAUIBOzdR_gz11R2zwCYL0WNxIXc9v7cyjfzCtTpQB_FhBDN2bk-w
Message-ID: <CAFEAcA-iYu3wUb7txeFLKm7T4P8rZWCzaLAZP7+SadqAa7Rn4Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/arm: SCR_EL3.RW should be treated as 1 if
 EL2 doesn't support AArch32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 6 Mar 2025 at 22:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/6/25 08:39, Peter Maydell wrote:
> > +/* Return the effective value of SCR_EL3.RW */
> > +static inline bool arm_scr_rw_eff(CPUARMState *env)
> > +{
> > +    /*
> > +     * SCR_EL3.RW has an effective value of 1 if:
> > +     *  - we are NS and EL2 is implemented but doesn't support AArch32
> > +     *  - we are S and EL2 is enabled (in which case it must be AArch64)
> > +     */
> > +    ARMCPU *cpu = env_archcpu(env);
> > +    bool ns_and_no_aarch32_el2 = arm_feature(env, ARM_FEATURE_EL2) &&
> > +        (env->cp15.scr_el3 & SCR_NS) &&
> > +        !cpu_isar_feature(aa64_aa32_el1, cpu);
> > +    bool s_and_el2_enabled =
> > +        (env->cp15.scr_el3 & (SCR_NS | SCR_EEL2)) == SCR_EEL2;
> > +
> > +    return ns_and_no_aarch32_el2 || s_and_el2_enabled ||
> > +        (env->cp15.scr_el3 & SCR_RW);
> > +}
>
> The computation here can be simplified.
>
>      if (env->cp15.scr_el3 & SCR_RW) {
>          return true;
>      }
>      if (env->cp15.scr_el3 & SCR_NS) {
>          return arm_feature(env, ARM_FEATURE_EL2) &&
>                 !cpu_isar_feature(aa64_aa32_el1, cpu);
>      } else {
>          return env->cp15.scr_el3 & SCR_EEL2;
>      }

Yes, but at the cost of moving it quite a long
way from how the condition is specified in the Arm ARM...

-- PMM

