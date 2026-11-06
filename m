Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E711606A339
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HnWWezjq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLzk-0007E9-Ds; Fri, 06 Nov 2026 10:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLzi-0007Ce-Fs
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:36:46 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLzg-0007iV-Qc
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:36:46 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b315dd057bso4819397b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:36:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979403; cv=none;
 d=google.com; s=arc-20260327;
 b=YI6Nkw/2DNQEe1DkLmc26apFdI7fimkkdKBsspX5T8nPA1UQCAUJV+mxez91jEtphg
 bKptZlbfhogU39D3nOpG0EzldUmHE228YG5VjlWQxzMg+h6IiTwaQ2iSyKW9/46U7BWp
 9bEQGHWytwgASBGvo47cgQRb2EIMM5oczbMw/4q+M7avu/vMwNMlJxh8JdayryZJ/ENh
 HyOnxd/nbQYQLkVX5Xe6KmaLaKVSrofZ08PvCgkRFFN23ACqYVwPakrrMmMZnMRMv6KZ
 PaVi3YXdFhGoxwAcUEgiyVvgBvs1P8wSlCErh46Y+2sOnPFspRLUFqe4icQxJf4NM9c7
 52Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lA4GEPoU9ZOmt6nI2Rttty0979Gqih4iTATMuirj7tw=;
 fh=VRcZPmT6Amq8CJg6YQ9jtV39fafV0LyayVlqP5p8az0=;
 b=hAE86Gwek0DbW/XoFYHXyrFw69eYgjcyszXGj0GeXNHe4zxb7kKo37ZA+3uj+sOgc5
 YN1bKAW08rnfxy8Swr4QV8KCGo1y/H+B34wz/d3RNFKX+GeDbZA0OCWon58rcX/KrsTj
 CfhydQH9ZmtQQKEvNWXdme3jWCs6rofYm/JYp84BBi6Npw/TAWyticZ96Tb3KLJGk4Sg
 gWZh9JuDtLrB1+rV4MjlHJFof0MnZa3K5im9/gLuec/10xJhjvmnz6G+C8kCMjIpaVER
 WPax05gk2O4H5mUqHHBA5GHnGczdX46T8fNHD927UaNIJc2vXCLUt0EEdtD6I597uYMn
 i5mg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793979403; x=1794584203; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lA4GEPoU9ZOmt6nI2Rttty0979Gqih4iTATMuirj7tw=;
 b=HnWWezjqSFVoAZkDj5fP+QhtwxV+Eaavt29awb3yeXaPl6OEz00G8PzcKcxBQdOutA
 k7szJe5kkUFqyoBqWo62nb9jJw4VQAKtE6M9kxUNglxovnbR/zcbz2Vko0QM/QCrEVEv
 7E9GDZPO42qJ9jnhPZBE/LbfClaIgVsIjs5WXvtXur39tcIAaQeCC+8h8pzgQFG/8Xho
 SHvPfJ3o3XFDUNJ5QY7QIn4b9iURbvkpIx0bMK8ghLidIYgrJ64TGzg+XvGwO+apino0
 9jfzMabdIJ2dV6r6gOYumnKAV6KtofU6uFeKwHHEdcctg0Vs1umVY3qj/+MEI8UMEJQ/
 pAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979403; x=1794584203;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lA4GEPoU9ZOmt6nI2Rttty0979Gqih4iTATMuirj7tw=;
 b=F4AW34agpqa8pNSwDvDvCsxzUC97IY2CZTqjMeWfyFl5Q2tv3IqS2V0dn0EMnd8rOz
 bzO6/1bBk+yh4Rh5sfHaJkO0tCD3RLEAVRc6vMp5+5jnbMvPZt57U0LFn94gHNOQKmE8
 Z8p7aleSbnFON3CNJhR52KXV9jf6jwwUmiHFVm2Wc3qJQEjQo+/jeiQ8l+A39WknLxZC
 mi9ZiPpEMM8t/XidaMqzFnXTghDTwKUaRLhawdwRtzrRZx/TZ1mbGczw74HuObjTyd+i
 gqFybGCxFr85zPNwgft5I1kE3QEnoopWVH2DQwufoNbwx8ZxJtaVhJUjNpPIfEyw+9nB
 30qw==
X-Gm-Message-State: APuU4Z+LWJiWdcQ4DJ1HJFn0mOytbPGW+GHngyvmb+7YMWxHIboNR+Ga
 kmxDGLevp1t4phwnpwDWeKMuhkdh3KuPuUkIPwFLyXgUcDve9lCc/RMIhe18G/3yV729gwv0voN
 PyhmYUusaDUCU5hwBWKAGXQ62c9IsunR6SpzH4zMr5A==
X-Gm-Gg: AYBFou1R7u8FBHXX3jWXmDjTSvA1rVWMrsR+Vl+eTEBGmb/KcIxo6mYzwkup/ujXEnh
 wC8kaCyHoACvRfV6yjgza1Dau8Uu0LHkw+aGS90nJIEQE83OIa6wGNxF3BfrDWSLXoF70mN8fUK
 zNOMtDLu2dUdjAq6ZxbfseCs8fT1HAzoedYd6guGiSV7kKo+JUdf1OtrCpLsOh0eAlzMYsydovn
 X7/+IMf/UITmGwRw4m+9c+lV075GKbLiNUe4bfXjzTXl4xVun7SIXyfZfNi3Etq7vR/q2PwB2Yc
 h7bKxOHDlPAWZbB5t+tyt9UM6oKpsFzaEW/z97bf7vEdvawjxJ8iYY+WeTEumYiH7kV9MkPnxYZ
 2beBZXH///eexv9sJuLisgqWzOXxecFLgZMAeHFqigdYKFZNghYC4QRotH1wVpYcZ1i5EYCG4+m
 2LQz08Zy8T75e1cKetiDYZ
X-Received: by 2002:a05:690c:c5e5:b0:8b0:dc6f:40d0 with SMTP id
 00721157ae682-8b341928dedmr13484657b3.21.1793979403282; Fri, 06 Nov 2026
 07:36:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-gic_read_bpr_from_property-v2-0-9f096cce4814@linaro.org>
In-Reply-To: <20261106-gic_read_bpr_from_property-v2-0-9f096cce4814@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 15:36:29 +0000
X-Gm-Features: AclHuK8ovCrvEFYfrd6MUbi1A_HYZBNDt_CW-yGFhQdcF7DIlPdAdNqgSJxf50U
Message-ID: <CAFEAcA9GCg0QzcKUcsOO+oVMxATHJG_9OEL9Zi0uLCjvN-Do9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gic: read bpr from property
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 07:12, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Calculate minimum binary point from the num-priority-bits property,
> instead of hardcoding it.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Moved GIC_TARGETLIST_BITS back (thanks Peter)
> - Added an additional patch suggested by Peter
> - Link to v1: https://lore.kernel.org/qemu-devel/20261105-gic_read_bpr_from_property-v1-1-7e7392bfd321@linaro.org
>
> ---
> Manos Pitsidianakis (2):
>       gicv2: do not hardcode minimum binary point
>       hw/intc/arm_gic.c: move num-priority-bits check

Applied to target-arm.next, thanks. I moved the second patch
to be first, since it's a prerequisite for the change we
make in patch 2, and adjusted its commit message accordingly.

-- PMM

