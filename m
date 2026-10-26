Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B83606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UWz6E9lc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLMkx-0003Fc-OW; Mon, 26 Oct 2026 11:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLMkq-0003EL-SO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:36:57 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLMkm-0004Gj-Sq
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:36:56 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b056d58f2aso27636927b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793029006; cv=none;
 d=google.com; s=arc-20260327;
 b=a9IzxmJkSW6MEMwyUBARhIb0Wgon8rgC+pb4qoaWLvwDUEwRsYNHY1wZnCnD8YAwUB
 dBfxU+Vw1q0R+2oTxrLocbxK5OLvzP0tJv1tAOM9UFGf3x6wCDuxC93NixupnDfbwz19
 +q2CTB//zx1E8Nflpb6nDLbv7l69VUTee+pT7aDwRT8XaJDWQkeVX/1rgP5IjHtF5/QT
 sC8YMEUME7//jRE0atjCNsemrtaesTpy7EEy97P+mCsWtgnnGgJ+6v+t7sQkJDEJATuZ
 EBAnLYDL6eR7uQQSRAXlXS8XphOC1cwCxTwIdNYJmgn/sPzHtqzwpBomqdUjpeVx8ari
 qDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mkGLhs4+xKTUISTmCatc+U8CXhEnCwXeDsHnBOc+0Ns=;
 fh=XTTVB6ywah99SChND1zlNweUq8YqXd4UiqbWz1Dd4iI=;
 b=RgktmzIxxlvBXbgA0TMNGd8o5zyLvUTKgxezeFBeOBZnzgoWhSyigIdGcSefXFDrj9
 +GQYKETar1oPVeXf8HXQXbJVcZ3b+ygZ9pQbA9SCNnotp6rPcKRiPfKwhKSOKvftSX8s
 /2uTz6ars8wHv22of0gsy0LqXT4GmIq5KB3PAwpvOkXu6HBbTPBxKwqpXnlAUn+iFPZQ
 cDb4yoWa0g8cZRz/oVDuS5w8mYLGjFNDE4/ABp+BYsM8jhZl3Q2SKNHOTwIS6nvKHDrT
 Ykt0ivjYCVM/HJgfUEWYtNR0xRBw+k3YZuQm+az7M8lixHCuYcFgFFHYHWCSP0Dw7GfG
 RR2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793029006; x=1793633806; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mkGLhs4+xKTUISTmCatc+U8CXhEnCwXeDsHnBOc+0Ns=;
 b=UWz6E9lcWRXKrinCMumLJV0Li7EcU1Npqvl9TjRUTNN4O9EJ7bzjTjPOjpR5UjJwJi
 yXKhm8c8erXYKKbk8H5EBq0lTlcPfha/J364WG57OKAo1F+pwXmsS2TEtUNByNAEruYe
 /uAE2hhYKpPEZ757FQQtnoeDFgvfliQ4G8SNc4AkSdHUxI2o1g6Zu3++JwCtHzBCGssL
 tthrh3gcFqm1Hj5HLCmlK+tHa9j4D7CTmBJEiEIOECDaNTwpjW7MNoVX56D5mpeW598F
 yYv/qB1Ayc3Z9hPA0g1XgW+BtAtegbYEeAs2eZQq85LFXuKflXsoAMX1HI689+0h14yD
 Zcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793029006; x=1793633806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mkGLhs4+xKTUISTmCatc+U8CXhEnCwXeDsHnBOc+0Ns=;
 b=bb3xhiZtG+W4KrDWkBXPYzxZJbHRlB5GREkPf4GhLexU2hAJC1OEyGXs93o1YFznFN
 OagNJLEDBiXbqZVH/Rt3xGNnJ6WjussDNttyLYNyoYWC8zFmEkfgnbvmVkJOKBpAZylx
 GSiXPkAZModraI5SZwF1z2cijolO0Y3xcyLVa5M8/VB4KuEIkg8o9U33Bk+eNzxurBaV
 qrAQrIxxaEmieD7hGuwVWXOOes5INxif5DTUr0HVNbg7mhbKeCiGYgv7DEXZsHmw1RQi
 xEMb2z3W8zxsjSmZwA43JltSQEgwmfqlMH+q/xjqN4fRD4GzuSn6T3OOiuvyrVCUZzSk
 +QFw==
X-Gm-Message-State: AFq9FYLuJGTtxqlio0LEItsmpFgVKR7piKZqhyWdiDLK70hu+STZ4LBy
 waomM7L5lY7f/0FimyB86yskW6Dip9IqR3tIt8uhY4JiRpwo/a1My8SR+Eelflkz2sdImIHPhjO
 K//ygwFdSiqIxJOabf+gNOkgPLi8Cl0bCpNiKS0K2sA==
X-Gm-Gg: AYBFou0Z8BMRFn9EhxSl58e1+QIMwL4ZGJ/WQDEle2w3vhVmWtdh+7kdcBHM25wAEbw
 PJ/MGL/ISL9GGJV5rze67vbBGVoAjU7EH4FG3wxyArNWT+ohur3Gj6klNPYJ/QWduQf89uXl3tT
 ekdyi0bGPYjMUfTzNa7zyj1VdXvV/vm52iR6yWGzYhCvSeysc3ophoZNVhN3mOIiCMua81zxna8
 6TSVmnkTWx9T2WeNqL1pv598+AGPv2SfeHDcgjvci1Fgox/NHAAv9tmyPIsrLETx7H3tsup2NSR
 2ZiSBl2VE6F0OxE+Rht2z7JDif+8mYIOdRPS1k9LrWUHUE7IY9XJacos3bcR4dSsZBb2YOL//hD
 Jk2ZQYuAV5DrBRYK/ufK+WwnyXkUV/sr3+UFezDpjDIy6EenrYzo+6Ed+1RB3rapSP1QAOsUCX1
 fFyQOEqD8R0CsCK+uLxa2W5KonBOuGej1B9rIado8rmg==
X-Received: by 2002:a05:690c:c4e6:b0:8a8:909b:5c61 with SMTP id
 00721157ae682-8b1921b63femr10734377b3.19.1793029006461; Mon, 26 Oct 2026
 08:36:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
In-Reply-To: <20261023135924.64990-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 15:36:34 +0000
X-Gm-Features: AclHuK_7kmbDEbEc-kipOCXNTGvvj-zj3uUOIhdRR5w4kVIBu6_dRxHwb3QV3Eg
Message-ID: <CAFEAcA-OwXgzMLLU7YCVKg_0XJ6UXC7idf0o0dcg3mJn=zGu4w@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 14:59, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> This series gets raspi4b's PCIe root complex and GENET Ethernet
> controller working end to end: the PCIe link comes up and devices on
> it enumerate, and GENET passes real network traffic (DHCP, SSH, bulk
> downloads) under both older (Debian 11, 5.15) and newer (Debian 13,
> 6.18) guest kernels. Most of the GENET code is Sergey Kambalin's
> 2024 series (patchwork series 829638), carried forward with his
> authorship and Signed-off-by kept.
>
> v5: thanks to Peter for the review of v4.

>   - Dropped v4 patch 14 (GENET migration state): migration state for
>     the GENET device was not asked for in review, and the points made
>     on it (no post_load function is needed, and
>     VMSTATE_BUFFER_UNSAFE is not right for registers) mean it would
>     have to describe every register field by field. The series
>     therefore no longer adds migration state for GENET; the root port
>     keeps its vmstate from patch 1.

I asked you not to implement migration wrongly; I didn't say
you could skip it. As a general baseline, all new QEMU
devices should implement migration unless they have a good
reason (e.g. they are explicitly experimental) and they
set up a migration-blocker explaining why.

For this device migration is not complicated to implement,
and so I think we should just do it.

More generally:
 * you can implement device state as an array of uint32_t,
   and get the benefit of e.g. migration and default-read/write
   codepaths being more concise, with the downside of having
   to write s->regs[R_FOO] instead of s->foo
 * or you can implement device state as a set of fields,
   and get nice-looking s->foo access within the implementation
   at the cost of needing a switch case and a VMSTATE macro
   per field
But you don't get to implement device state as a set of
fields and then say "but I won't do the parts that that
approach makes a pain".

thanks
-- PMM

