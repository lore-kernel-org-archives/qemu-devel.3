Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA970606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T51vlwg1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLZx-00006g-JO; Fri, 06 Nov 2026 10:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLZt-0008RF-59
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:10:05 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLZr-0004CB-II
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:10:04 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67be9601f31so558040d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793977801; cv=none;
 d=google.com; s=arc-20260327;
 b=OgnpfYTfua97rLpIm2XtxRTi/xIBVb90RHypASSW7+8mHNzvGnQWbDMPT7toLjrP9K
 GrDluToSHbOlHG8i2CJ6D5hQ4GLGYuisIiZEs29nDcVPl0O27O+ka+cAhhZ7d3ad3M4f
 GydcboRp/gQwvCRqPe1umCiwFeUT4w9o7AQj28ALfp7K7fg1mYXt9/Q3kzgPekpC25y6
 J00VEynM/kh5SWhASPviwGJacG1Iug4IE5VLSdcKCIRJGL2TNYrsYSpu5fENFMhiaB3+
 Nr0llTvo++VM9mZLHfA+88bQYpLBuqA+GhaWrygvmfvH1MQcN4ImWBfXvrzDVvYjJUbg
 M8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5yc9T1zRNK7Z1rGOPdCtKkir82ZD7AjqoHTexBGKdl8=;
 fh=VRcZPmT6Amq8CJg6YQ9jtV39fafV0LyayVlqP5p8az0=;
 b=DJS4rPCfv/6Acpx1LB43TwEnUA0asWTMwM7B45ScD/kKKBVlI9Q+05nDjItC+epkbq
 /6eDnA7OyJMOY95FPHGKhPZREhwgZ2OftRNSqKK30QU67rUw1N/1j5UlgZfpkHiVI7E0
 lR/clK9Nz2pNsYio7YRanZmQ0t2u8DiK26P7Vx+noALol6sdUMlkKBUk0AITAD7Rd7BM
 9gCCQACSMWhW9hN4qmf9xDKhT41HBmxB9JRoWwWFOJTfh6j1gMk4K6e2ZhLMlFRHwKTq
 V1zJ7RfbiXvH2w1esvA2BAVis5l2a+ZRREfb5yVIcg3S4wx5B8YSZxPGNiAr7bKP9HF1
 YwZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793977801; x=1794582601; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5yc9T1zRNK7Z1rGOPdCtKkir82ZD7AjqoHTexBGKdl8=;
 b=T51vlwg1NM1Qx0x/lWrsKDKDmbr3Ynyyo5VakKUvD2MbU8w6iRR4dl/VRwiGEvq9XR
 pQTEAc6GDMZQRuU6Zohra/CXLvhLJLCfqj9yS2FEgd1QdI5Njj83lfI04w/dk5Std7Jl
 IL7mZEMeYvg2tvdbNGJ4CJ+wcLleYSZcgOAa5jNNNMl+RI0xc1pVxp9qALA40UJK4USJ
 Um8guRDGAgYMkymMmtCh9EZ1OgOLPK6r1kVcTDomuYMkFTgmg/zW3w1iA/RWgyNag5LF
 NU/LGnalsllLNm+dG/ytlRqyWB413XD5Zr3RD51wu/QSGbD0HR0a4EE2dObJ8Mq+pSth
 qeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793977801; x=1794582601;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5yc9T1zRNK7Z1rGOPdCtKkir82ZD7AjqoHTexBGKdl8=;
 b=NLEOvrtpyx9cF5JS2V/l4Gm0PZpZvG7t4AH+QyNRvdvmK3sf+xfoWTxeV+UvTbpbyq
 dFU2QEHkUmD9lmyymkPvP0caRZCTwBmGApOZGdOnUP7M2dZO1Fc9bXLFLdEjq8grDcNC
 7N4qmyWCdqJ7WseD9nxaBaotnRPW0DaOL+6xrbPZqqNDewa+15iIrFcybwU+5JbnACRP
 fBTuc0CW9JzLHbfnJFxCHPZmVKlNYt/yLY8WdqSWOwtLPLvSUTI6HgEry46uFBUYW3Yg
 hQ9FPDD1jtLZHYxJbVHRNWmKULUJ/mi5aDTYGhl1pf7Anvy6rXRD8dIAf49P2CAfuzIG
 4XAg==
X-Gm-Message-State: APuU4Z8s5T33vmvxReMfgopdsDfmuh925Eosxo/030LBbM+aSLoeJ380
 FpjDWDfw9Tx29KoU+2t6preT55aCAFEhV2llc2bbcif9K45qAjTw5L0f0II1fr1n1YVkUINQJYC
 m7oTaiUlLymHsPXhDcV//IrI5RVp9ToQ797ZruTAoYg==
X-Gm-Gg: AYBFou20TMD1eGGtO8+lOG98WpRR+HD+hlcy/VMVQFypKVXQPKkIx8irjR+vKF6FxgT
 x3VEcms79ULYMuZLgrWxW1RjBW9aoklMykfteX3a3XEjtfVyU5if3KV3bIA6c94qzXU0n7vpVvz
 Unf1GiDwrQG9ShB+ywRxmK8AduR3bVZoxirR3WX9pCehxTK7O4FPkbCGozGGUyY7hyIh3wqdu0F
 SNUMFBKmE/bNdiR9H9bNn6CnerU8ibPFTiV12anAFv9cPbmKC70xw4+deIOCD24AXgLpi2/dmZ/
 PgXTJINAXNONtn76QQfvYIoIUF421ZSFX2uB8//ovOyXrfejrQWIksMv808pl5HurpEkh4u96C9
 HJ+zxOCGjhNPURq0ZHjAL07y6n96Zz7a5cTLxCAP0Ce49xR/yXFG1fMJt101ckW5SPTPud4THPB
 f1i1DxihNbA+wlaTam7mIu
X-Received: by 2002:a05:690c:e050:b0:8b0:c7d2:7060 with SMTP id
 00721157ae682-8b341b4b0aemr10750207b3.107.1793977801067; Fri, 06 Nov 2026
 07:10:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-armv6-xn-check-v2-1-1291bb77a6c2@linaro.org>
In-Reply-To: <20261106-armv6-xn-check-v2-1-1291bb77a6c2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 15:09:48 +0000
X-Gm-Features: AclHuK8nI5vcBdu2zcAdKCQTnR9rPi701N95Hb-bE1kvwpaRCak5Ab-nC8JIqNA
Message-ID: <CAFEAcA_=-miKcdxRkJsP+XdGV2AMSYR=EPMuGzMZ4M8xFyetKA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm/ptw: check XN for ARMv6 in get_S1prot()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 10:28, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> For the ARM_FEATURE_V6 case, it seems like we retrieve AP and XN bits in
> get_phys_addr_v6() but we don't check the XN bit in get_S1prot().
>
> Change the `else if (arm_feature(env, ARM_FEATURE_V7))` check in
> get_S1prot() to plain `else`.
>
> Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Change else if to plain else (thanks Peter)
> - Link to v1: https://lore.kernel.org/qemu-devel/20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org

Applied to target-arm.next, thanks (with a slightly expanded
commit message and a cc to stable).

-- PMM

