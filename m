Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A63606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RAXFu5AF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2bF-00030z-34; Thu, 05 Nov 2026 13:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xP2aw-0002zo-GJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:53:57 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xP2at-0002nM-Dk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:53:54 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b0cf2c0785so20066707b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:53:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793904829; cv=none;
 d=google.com; s=arc-20260327;
 b=CpOnEs4uODFtMCqGS7bjKqDRpTjDdjqbh00vNjKWERQ46UOa/Q370nIssGEoh3LBw6
 7apZetPNkuZKIG0/BvBq7+RlK1Mk90pkuSNcc+lOu+UgbRVin3flgt+BRSw2a1W79Yxy
 bovKYNqe6936bzgP1YzHUEzfOAO0hs3hG9PlpuEw0T15FuM+KXQ2ntdLOK0Bgo0FNc3u
 PjVv8bFyJPUv/uWM4U6y4kzNbGG/+F3tgfjDHRI5tVLzI7qf/NR5pbd1cFntMmM8odE8
 c+vMPPGZ1jqGoXEELJyY2QkRp2I/e0KCvzZoYG34VGO/Ib8TNrN+VKjORJdPmCYNnQr8
 Dugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YW6xkjCNkShheMexpg6Mgbg4Mj+93DQrHPO+NjitZoU=;
 fh=VRcZPmT6Amq8CJg6YQ9jtV39fafV0LyayVlqP5p8az0=;
 b=YZLAItsPlQkdkgQpGRqRVDgBN6U+bDE0Fmbk67YXn8pq+lMTkEG5/30PyqCDoERa+g
 fdcMIZII9IZd0HnwK4NxFEaaLIbMTctpTMFe2J81wKp2N7X25yA6O5lLB2EIqa9xTvMA
 Kt30qkPZs9ui6Vi0z2HhSFm1b0S5r2aomTx74AmuqX2mBvVXg5ewiAzVSbsSsQ5ZLlWK
 ZmtLYMI/VKjJU/WUAzhJW6fbbNR0SLt4jVgInsO+bTdh7mG053xstmfWW4uOC0ZFXi6M
 9KIthWqqIgghnYurclSA3oMJ3SLOhLd1SGJQ9vw1NgI8A7J9cYftUtkOOc6+kCUOIETZ
 8cww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793904829; x=1794509629; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YW6xkjCNkShheMexpg6Mgbg4Mj+93DQrHPO+NjitZoU=;
 b=RAXFu5AFjgDQHNHeY+kycT7wSV2dP0Cl1gcwzZKKa0QuvZiARuVsabITVgkVcEG2dY
 C87QgdbrrjI79Pi/8HLWb1yEv4pVt+Gd8r4JNaCa3aqjokwJkR2/S0hMj0FW4HdxcPey
 nZ6obmkZnF/fPY30W43QCHDZfb/CDQUv9fhfkGojd8ayac35st/5lmC9Doc065F8UCmg
 hsljMcGzce74QUV2S3Do6257IlEjlft8FdJdvgvY4d9vRf9FrxbTabXRX+PkJpxGPe0y
 wAiwzFRiia8dAO0NTurPPR9/zDoEYxiFYza/yiytlEEARn5B4mni1Yi7gqmylCzCH44m
 DQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793904829; x=1794509629;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YW6xkjCNkShheMexpg6Mgbg4Mj+93DQrHPO+NjitZoU=;
 b=W+FQU1eGWQWOsM2yyikkf6e1Yt3smEC+O5Gn4GUh67jAngu9XLAqb5WkvSTYy5LASh
 R5XSK0V385PFZ6hHLztlgK0tkB787Viw2zza/g+c2kymoM+QGtzTfZEC13zTdZfFtR8B
 y+i9eBRK0AMl0m6Nxx0Xp1vd3z4aurwvgUhyzzSLaEL1YviYNWg+PnUZQuTbsMyghAp2
 NillyRD3rntGF2aa9zGZKG+EcFDQTINxNk1YzWqEz+Q9YcYaHPFE6fNnCnZj6p0lZhdK
 QAXQSZvS7Bg47Q+SR0tUOIYZIjv37FPmHDNZm6iULK2pMyn8CLEfyF4R49bZbkt3+ayY
 DQ2Q==
X-Gm-Message-State: APuU4Z8owWl8tHm3O4vME//xmkrEkjoCpH55TLGQCW7FJxirw8eWdW2r
 wQ7UaQDqQUnGjh0nAeOtbPYkez8CCHfux7chsvhYBJEmvNi+QslMG0eAUkhoph9xfkMZJAuR/dQ
 DvpGrkHi0vCrPHOqYjRleDtAre7wQsu8n+rwfpcwWSA==
X-Gm-Gg: AYBFou0j6pTJfCEduTLu4I62dk9N10fHUBfne8E7RJHIKO+dj7z2R8A1O23K4Yii5ri
 h3wlKkdhfv4akM9YxXxu/LZsGkOQa4FATRTwHwQyU7EXLi3sxY7oz1Fc5k47AlcWw3JcA1Dx4jb
 dGD/o8Jv5eHCFrBpkRxyOfT2Qiy2whCNVc+G9dEx2eYCjbmD1W/MPOfFi59bk80NuG3Az0C+1tH
 LiXE7N3xItbfZ6/Kk9Onj6WqP+wxW0O91H8UWlBzOo+271jjEe4mIuQeOo9oVawL/qOnPxpnRY5
 KnjLDSkeIdH27gVZYbRI168apY+4FaNesi3wN74SHsc31MN9ZveRDJKhfzMbfITsu5MRqZUQAaK
 bag87KrCAh2jOcVuDZk+h2w8aJGPaOAV3qlaYj8Z+tpRlbQ1YKPbvUqWpbJo3SaaW3KYEssBg7O
 p76E8mYb/KXvW3aM5gkqURRc7fZkOw9IF1hW0harEnFw==
X-Received: by 2002:a05:690c:6d81:b0:8b1:c7fc:2b96 with SMTP id
 00721157ae682-8b2b67c5898mr117617877b3.105.1793904828868; Thu, 05 Nov 2026
 10:53:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org>
In-Reply-To: <20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 18:53:36 +0000
X-Gm-Features: AclHuK_KxyVpqOLh0Yi0USJVhvzRf33-34KWKel0EqdjeRvx112nQRWKikiTpeg
Message-ID: <CAFEAcA_qmyR0E3+n8GByA6=kDwDQomCpk399DEc8pOPr=sqEaQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm/ptw: check XN for ARMv6 in get_S1prot()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 09:44, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> For the ARM_FEATURE_V6 case, it seems like we retrieve AP and XN bits in
> get_phys_addr_v6() but we don't check the XN bit in get_S1prot().
>
> Change the `if (arm_feature(env, ARM_FEATURE_V7))` check in get_S1prot()
> to `if (arm_feature(env, ARM_FEATURE_V6))` since v7 implies v6.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

I think this is worth backporting, so:

Cc: qemu-stable@nongnu.org
Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")

> ---
>  target/arm/ptw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 2e67d02493bd463cfd2d31ecf1316272ac3f1d99..b8b22b014e0574340a85abe73f3d9611d2360219 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1595,7 +1595,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
>          if (regime_has_2_ranges(mmu_idx) && !is_user) {
>              xn = pxn || (user_rw & PAGE_WRITE);
>          }
> -    } else if (arm_feature(env, ARM_FEATURE_V7)) {
> +    } else if (arm_feature(env, ARM_FEATURE_V6)) {
>          switch (regime_el(mmu_idx)) {
>          case 1:
>          case 3:

Digging into the various versions of the Arm ARM and looking
at QEMU's code, I think that "allow this for v6" is correct,
but  I think that ARM_FEATURE_V6 will always be true here
so we don't need to explicitly check it. The two callers of
get_S1prot() are get_phys_addr_v6() and get_phys_addr_lpae().
If the CPU isn't v6 then it doesn't get those page table formats.
(get_phys_addr_v5() is simpler and just figures out its prot
bits directly rather than calling this.)

So I think we can make this a plain "else", and delete the
existing "else" clause that sets xn and wxn to 0.

(Strictly speaking it is possible to get here without V6, because
we don't enforce that a guest on a v5 CPU can't write to the
SCTLR.XP bit which should be RAZ there, and we don't ignore it in
get_phys_addr_nogpc(). But if the guest does do that then they're
in UNPREDICTABLE territory and whether we give them v6 VMSA with
XP or v6 VMSA without XP doesn't matter.)

thanks
-- PMM

