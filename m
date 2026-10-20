Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28284606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ulIKxfsK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCgE-0000V6-9l; Tue, 20 Oct 2026 12:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCgB-0000Ue-CF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:27:11 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCg9-0004G8-UL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:27:11 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ab43af5e97so10379387b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513628; cv=none;
 d=google.com; s=arc-20260327;
 b=SXk8aJgaKa21BJHn9M4iA+3QwLD58k130HbmQUfo4d4ibtgZOCG0siQ5AXZuHZfA4E
 rh2w4CbOQGUEdMaoK5ylATHcip5uTlf3sJUFZxKlBH4MfABI6xvcj/jjE90h6W5GGJgT
 vpTvBzLZylrZm1rZjRe7BeG6/F3jLW82b/lgeh3D7zc4XeaI6JSte24yf/36S+upehco
 CPySrOXKMq182KYDquXMLVGLBq1pGsxOIE5qtEhpFEBix4zh3FQe3IG+WeTPiayG9DMH
 3VZZ4DXgY5H/QVg9sNo9iQo52it3vw2UDcTMl+7rVv+n3Jwov67hNYiWzAEX2exLW5yD
 Owyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ciUzy2+xlwruDHhswN3vsLK0iURu5Kl9UfgL5Gb+gTI=;
 fh=aq957924oWJXgFifECYCimVzOC4ACNeU+NC0Fh9lbBQ=;
 b=L7ZoPVXWX/CE00jQY/ooDGLGJMtt54I0hMwAdi+P+sHJQ3EN36M47cghovMD0wBXZD
 w8wzqpaatb0oeL8N1RX94+bsSB/hTi2kPTi3XWHYMpwd8CqvtmOdgzpMdasIDTlNprO2
 1kybnaxm4fpvl2P5mEgRGMwpTSj2bHHfQkaJfOC2Oc4bGlC8RF9XNrzeBvXpHHNixOKw
 VgWaebvJduo4SyFmaIc6XiOClx0lBvdyYq3eTfQ6krFTQB3slj0J1kPcSkB1aB/Dv6MO
 vZPW8qxr0a5CO8u70PS9eL2AzXF949nXumRJcRBHebeoOoMpPKRzlXzUJM2GNJcwg/gD
 kOcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792513628; x=1793118428; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ciUzy2+xlwruDHhswN3vsLK0iURu5Kl9UfgL5Gb+gTI=;
 b=ulIKxfsK/N1THowZlY85JoKVBSb9rBZbljJZQoUHFIgV4BAF9gOJcw+BmxJExtFwyR
 0uJltQ2AD/+rY6h0stMnQw0PRz9boHt8OL1+4I/X15IcsTnNBhSBQupAjokbBU/WBSCP
 OFLpLCWOaWR7NcTrxI/tWvShvmdmtXn1JECbJ72ud5ViCYMipbjNCZ4/EmWHifBfR5ZA
 1LSmzS4vfeqthPDN470YTf+Le7VscMHm8yZpjWwQBcID6yrZholms8rOYSX3Yr2I969O
 VQ/zRsrUdQgpekQjIotrn8yV5Gd85bBctVulUtIkWz/NbpMy59ioU5t3JAfuBR2ai0KS
 AzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792513628; x=1793118428;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ciUzy2+xlwruDHhswN3vsLK0iURu5Kl9UfgL5Gb+gTI=;
 b=JhVTu++KCadF1p3ZEhs7+ZYOLoWN64KxsIItoHww8o0OZlMG9iF8YMADShShUJ+E3L
 0fMSIcB8YMHr3B9eDrnMhdiK3Ilhl2LNYRRvY4hZ25ojd2WW2SXiCSBMlgb+4hHUkDwh
 wD8eksElgGwsZHc5lVdHxJ3gNdPN/Tfk10+iv1pXoMeT82UDm2f6MrI0eM6PhhbrprUy
 boQKwFdB1a2eAea9ycJ3+ECooeKZqx5V4fd0zJ295rvY4mBIM3y9a9oYYXAAEK/Xxzyq
 xVFLuA1bkVoMVf5xssIgEuHw8OpthINoVzTTqkKhoHGpYUjBRoPBhBv09yXeSuGgY9/O
 McYg==
X-Forwarded-Encrypted: i=1;
 AKwUvByv0djplXSoctZW6hUEC4REh6TV0YBh5njGh3D2pzfQ8Q6Ufg7Ue1IInX32gnH9miJQuon+T+vI/84a@nongnu.org
X-Gm-Message-State: AFq9FYLWd80irprHTHGodyAKMxCwnAIGKyADcsMBidF8aEvWg/4WTU9y
 oWXdGWT3aSZq2JCBsIFifRRB+y+oS1RR0MzxMjk+KSi5YkwPuW0gKaL6o9YWC0+AeOZWtIyAyTC
 KJtxF7oRAIG0lEK8mcTFFJ0vtqBQJtIVJ+LTxSa0Yvg==
X-Gm-Gg: AYBFou1EfPmHA+fZ3JScb3OWEdUw1+hp++Ht6Y8DF5oHTP1AJibSvQ/4MMRbFeed4xn
 fKLsH8KsXUY60uPsXnAtntMintHg2UkFhF/Z6N3vkQfMt4loNfAdbPZgzUYZ2bn9llOorp1aSKV
 ilEnJSwf7HdVeSjMmM0uouCs87RWvFJyFh4wkelzmFmwPCdbQo8bS3Qc+2hBOfWdQhdB2qxiKrY
 jMchjF4dry7Eti1YciyjFPbRLNRnXh0xgTpHRhjfKlNV7c21YKpaVaCk7nhz1nTFndWxKs8+3DJ
 FBYNaDQKbCFogrATmtc2W29qgusJ82uT9HoL/TnA+f0uFE3hk44ZAobJHz+Twa0ycSb2tUAqaol
 jIeFf9BwmJyx6rRxXCwVsOmHer8uMnQfPXpxI8WEt0saLW1w9Xg==
X-Received: by 2002:a05:690c:288:b0:8a9:9f40:24b4 with SMTP id
 00721157ae682-8b11ffdcfd3mr9303527b3.15.1792513623300; Tue, 20 Oct 2026
 09:27:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-22-mark.caveayland@nutanix.com>
In-Reply-To: <20261019120517.1448687-22-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 17:26:51 +0100
X-Gm-Features: AclHuK_GG3xd3jb3G-pcWY9ph0D-7_Tu77TTN6sv2RLan-q546w3SCV2MEkiB-g
Message-ID: <CAFEAcA8sjxsGW2kdV-YcXs2h4-aKdSYC5a-kxGJ1nxKjwmWU0w@mail.gmail.com>
Subject: Re: [PATCH v3 21/28] kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 13:08, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents the KVM in-kernel PIC for an x86 machine.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/kvm/i8259.c | 91 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

