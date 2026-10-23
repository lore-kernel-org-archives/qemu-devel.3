Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kjrC5mcz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEX3-0002yp-DY; Fri, 23 Oct 2026 08:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEWt-0002vr-QU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:37:52 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEWo-0005Me-DO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:37:51 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0a921ee46so6967597b3.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759065; cv=none;
 d=google.com; s=arc-20260327;
 b=Dk1jJOIzgpOMIQFu5yzEKQkXC/jexETU9/s8JR04L0W60j7dVzM8nYUt9Ak2we3nzx
 cKIiWUITvcGfP+T07E8YZxJ0PxbIg9xCkDhjtiFM5KNPb2I0fmidM4fjwTBEq9wA+Q6j
 NG7iqFrlEECr8sO+iJ76DRzZ3SzC6Q7onxzChxeCsxy7Q90mCEqY0Db0PCZlwW7jHFMI
 xtLzJHk0R2nFqdsAkgzp/ylX9PyI4ouzga4vFc3I/6k4P1Nr8jChu+FbYkg6ka9Ex3o1
 A/2C8b44OSqfl2VGqF1z/uUytebsbrjThZYZo1fNbXslR0fwdCRS4THmfc+3OlCLm7DS
 jGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
 fh=TERpIxtD/VN+2paaei1T3Fvkpx14KuKLjSpKWE9rSAI=;
 b=ifUc+OWIcBZLgkFWrXGy804DWd4Q00QKORDSzwBjbGuI69zEiipF2t2Uwz0hLIjtRe
 L0FjoPLuiBiiHAUKUGEJ83SpGoGDYWsrHllxR0u7AOIbVNDTV8lpN+jghja2VLuNkTzS
 eGSFD5GXkhp8M+ICKP9blKN2xXswWBQJDaDPEeGxiukeSUMbrfm2akT00wTCfm+7dKxx
 vGXProzDZ+iovOPrwnXgNZesl16hmOQaBuaQvbPnoefmZt9Ve9gGdAH9PKKBFEuLmfxV
 OaMJRBYumMCZHRY2dAro6UopdRnL9xGYLOfYt533OSRio7fL2enL14ZHwbHlCZ6YL6Mi
 uwyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792759065; x=1793363865; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
 b=kjrC5mcznD4cgPeLNUleNu6WmGjYem+n1jP7zl14rp4cZY/ypEilfmTsLSoE2iMPx7
 OgZM7KrjH6ywZB6XEXfVOb1RvRId2vw75QPwO47fcFtIUBnIyfY98XBmmQ/g3ZyheM/4
 X6t0HSWlgkkc7cZ501G7k9MuNlW7eV5+VjpyL3PNSsF/ZIUF6gEw2pt8KQr+NO5cIUSz
 ZhHwOWi+7oDSjPDNJehQOtspoVZICBd7I5qF/2LIReUv2S0yG4SwrrNYMqR/P63KL7P/
 kGLik57Ta+Tw3IwbNs/QKYbCKIpoCAXFSRe8aI0VKJjptYhPd9dTKUHkqbM0zEki2UxV
 CGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759065; x=1793363865;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
 b=sRH5LTb38l8Tmk9P0rfMLHemCK+EYDgOrPxTXuo9ZUMhIe3EiSi434gwpiLE01ZO9t
 a2f/e8WaKEQ2b85RRVXTq/sQKK87F9j1xtldKDb4Brs5YWXqvxx5B89QwuZ4+dsDlltS
 fojjqEouTUDJsRZOy9OYK2+M1pSGdnpuoOqGhNh5XEi5dabw3R9ItDD9lYItRIZzx0co
 aDGIHpkt+q2BbNRQCE1OMANXz9F+Lpk38izLq1nJy/jez7THfKzFTrIzSpKCdCrFZ1UZ
 UjokZf/feEyLzGXc6b18lUa6FJcPb+gBto7tzaOQeACi+D1hfAPoyssF6M/BKXR6Q6h/
 cRfQ==
X-Gm-Message-State: AFq9FYJCpL8qQYyuQF4+VAGR5b1hWoMIGkPpgzyi3q0CuXgC4wyo+UPH
 s5ULNKYGydN8BmLZ/8Ih8J9GhLZ0HAixTepaEtoNs9YqS3m9NCmDsrg31gnQph9m5ErwjLY1ZaQ
 KBycMlHRH5WBGYZV2ZRzOYhb+BX1Hi15g1ayqMWLEYA==
X-Gm-Gg: AYBFou1WtamGwZy0e+3ei6HT5j5GHNDTvHCxMidnmI/rDj3nzENpIv8Uwg9w3ghJLhb
 1vuMQVG4r6x/z1NvgeCKW+AqYxR/ULBy9wnc0e6AH/0tti/1auy4ioeKtM0m60Og6HpHTGp0108
 aXdzgc39k/cm1Qm3fxvqeG//FKzPDktec/2EA3HfpWRGFTC6FuzURWv+v5hO6cQSUPvFYLprNTi
 UuMnFKLP4y5KTzaFhaZ9X7bCBqnBk/YZPdWBKzR4gzDqZFmYGVDyiL4KpiM/l7EmCJt8ngJAAav
 8juTXFsRB6ejXXwvYqgbbfQIzYBhIdryj613YXP+UIQz94FjIHrvZjkyVEaQqrrHwpnX90enCRl
 dSN7hDS8AG464SZuDz+V8QLNeNG1GOwSDe91jvZJWB/Tkxl4M3KEcmkhKgx6eEDtznTKxydFrEY
 1xUqNaWLfIREyunUiMoWX7ng==
X-Received: by 2002:a05:690c:550c:10b0:8b1:3606:65f6 with SMTP id
 00721157ae682-8b157d96b4cmr11350167b3.64.1792759064577; Fri, 23 Oct 2026
 05:37:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1792728982.git.deepagupta@nvidia.com>
 <529fc7538b61d0d2ea9a984087ff1d616dd65624.1792728982.git.deepagupta@nvidia.com>
In-Reply-To: <529fc7538b61d0d2ea9a984087ff1d616dd65624.1792728982.git.deepagupta@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:37:32 +0100
X-Gm-Features: AclHuK9ojQv69OAZTrmG7kBHeUcigZauSSNPGVhBPnbTfN_tKVHRQ_dcXo19pmw
Message-ID: <CAFEAcA8tV-Qc_GHxyCwaU-c0h5n5hcTCU07k0bvGiT8ePFu4FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/arm/kvm: handle KVM_EXIT_ARM_SEA and report
 BUS_MCEERR_AO
To: Deepak Gupta <deepagupta@nvidia.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev, pbonzini@redhat.com, mchehab+huawei@kernel.org, 
 jiaqiyan@google.com, oliver.upton@linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 06:22, Deepak Gupta <deepagupta@nvidia.com> wrote:
>
> Linux 6.19 added KVM_CAP_ARM_SEA_TO_USER: a guest synchronous external
> abort (SEA) that the host cannot attribute to a firmware-first (APEI)
> error record is returned to userspace as KVM_EXIT_ARM_SEA instead of
> being injected as a virtual SError. Linux guests treat that SError as
> fatal, so on a host whose HEST has no SEA-notified GHES source every
> guest-consumed memory error currently panics the guest.

So we already have a mechanism for the kernel to tell us about
memory errors -- the BUS_MCEERR_AR SIGBUS code path. Why do
we need to have a second mechanism that needs more code in QEMU
to wire up to have the same effect? Can't the kernel tell us
about memory errors in just one way?

-- PMM

