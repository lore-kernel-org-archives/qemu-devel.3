Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1A606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bggyQGuX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU6uD-0001lu-Se; Thu, 19 Nov 2026 13:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU6tw-0001cD-JG
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:30:35 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU6tu-0005E2-Sg
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:30:28 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67583c777abso1502308d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795113024; cv=none;
 d=google.com; s=arc-20260327;
 b=HmvKBRKjo8Pg6E2nkI0BkdvYlMAZHsUKZmnqVkWqCu4FK4fYWCQYBQjlWJqAS+8wle
 czVQG6g9sBuUjZ2tnENzkRkIG8K6hSeqzKT9DwtbgWU4F37h4YrREPhK3gTPDiDejN6v
 Ye1dR/hAJB1MeGAp2himhQZhvkRj1Am4Zrzz1qvc4RomMeA4woOShdT5bOt089OOrmX8
 LmP+EVqVLX7EygYkvWf03JJ5Aucoqd0hNAtEO0PdQ6WKdXirwmgYWGRs6PfBTVnNRyff
 1FlaMlGQCtRhpLtjsgbvIwGxPy/Id53LYdjrhsFQ5YRpraslylwqFo14t5vibmVJscvM
 bi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RzbOPqiXg9FAca1aSDrv5BLjGl2Ppu488Gz0E74Redo=;
 fh=TzfskRGa/6C5EpqINbGNdUAjd9sbShQ0gR80QPWZhUo=;
 b=jfP0EDE+cC46qRZmjV1u5mDuRakoaqwUnFMD39M/BLTczbcvvGx5jMIBFhxFGhz32+
 hyIf1bv995N34BF+1AvHGbW37ey7pDryAhlYzmuRL3zbZwaaPc1QRgOhchGC1VB2jMpe
 HSZufVQnhg0uzxMRQFHxiJta8XEgfGUaFWaQ94r3SPCOxvD880mjiPpIP9dPMrUhhxdO
 cYAN8b50uwJpViXQizITXEsRexzcGA2RjLOIFsnj7+0Z8EVas1cvoeaG8xJaAApQb2AJ
 fad2INCHyednIfdCqdUW/mQD+TP4bzSjbs8L2vn4VwU+Cr7G5PFAg/kGr83WohmJwfz/
 6f3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795113024; x=1795717824; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RzbOPqiXg9FAca1aSDrv5BLjGl2Ppu488Gz0E74Redo=;
 b=bggyQGuXhmd2MyPAM01Jf0Ke3+/37tuYZSO/iW3TtPtFuzcXdjROjHNxIhlvxmV905
 nFdo2ykPiUwy1mGJaCPQ1twl7bG5+VgRN/B6G53NR8A8Nho76dl4SaVxDU9mBxL/3MDA
 +TZyXiw8xNLnTOlqCLYSaBdm49tIWrnU6EFnk0p1CZEnOOjMm2qq8xfULf76YQzhMRdW
 xLOxAgNm8vX8cnbYBHfQECYVCU5bnus0V0H0Sk64pXmqA88wB/ypIQ8Fgsc/VtY3oCiQ
 wwPRP5fjdkq46gFsUgbrHp5fOK4FkekP/44RiUYeO4BIqGC/fskguGDiSa56a324BnYW
 ot2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113024; x=1795717824;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RzbOPqiXg9FAca1aSDrv5BLjGl2Ppu488Gz0E74Redo=;
 b=KRRyaY4eKH2QtIkgnJZVrfctk1FYYw3TrX2pD6hC4e9ZNUT7+FTZ2VkXHIqAQ3rqsK
 hN0JfcuY/M8X49ajF09XHSgOuIs7AHT+XZMwIyr+eNO0FYyLJLkaqVS05ZO+LyvmaH67
 Ou26oxXxBqkeqT5bcEEaU2TKl1/e/hqfANXhaBLDhVhaB/2HsBB0iZ3t6hqNT4MmMRmS
 mQSw0z8LpFz+E3bIERwH11jVLgrHG2bZ1ZP4kNytcsmzr8FUFpjd9AFzheOm+8Lnu6sP
 wWQ7SSl0J6CYM2bMf4jgjQ4qMTpvIYZnwZGpFLfZTrGy221qKOsiaytHt94Hv+MtGL/3
 8F7A==
X-Gm-Message-State: APuU4Z/38Z7ks65dVoe+gOcmo/wE13TGRdxzcEgNARD0WqbJwXThUurm
 c84NsOf7oYBKM0pgE4j3y5TVipi24qOd7/OiTcm5V7WrHhwqwMbaGSadaAvn9k3fk3vivP0ldUq
 ttiNVWqwwBM+9dGVt1igHUpkHYOnzl5qxw03o6Xylug==
X-Gm-Gg: AZFdTZeIkgNJ+9HOjeX5FDJ1Af09J79HoYp5wgJi5CR/GYS/b0Hi569+3GYgvq90fdH
 yGrDhT/1z48cF6w9th0MhNzY/f42f8+IWKKLtckFUZ4h91tYyYE5rIjDn9JGJMLEfEdU+voy/kR
 deWhH+WZ6tafhzlgklvJivRRTCN66O2M8Fl6SWLLdb4Cp+J2kGDsDO1kkumirZKHErEKhbT+2uq
 GwZ3wQemdtkgJgQFuclPDYHa0Wqh/QGW/bMsFdxbdCrfCI6vjHGTP6ymAb2iibyt57QhvrCfqn1
 u2UTqzW16wm+K1hmijAUK1jRTpXYeEzx+RaileGKb6GVOPhGypCL3DGXNVecCDifREpACiE0Btr
 MzAPZa1kBSPaOTp06uPZGPFsmAUWhPT7asbtLvYflzPS7hOvQIO6Msk1ieGjj/KppuPAEDliHar
 7nIqQEUc6GwV0WvV1cZQZx
X-Received: by 2002:a05:690e:1388:b0:67d:b5b3:b9a3 with SMTP id
 956f58d0204a3-67dec4af0dfmr740668d50.42.1795113024071; Thu, 19 Nov 2026
 10:30:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119173904.358593-1-richard.henderson@linaro.org>
In-Reply-To: <20261119173904.358593-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 18:30:10 +0000
X-Gm-Features: AclHuK8pXL0JtqJ5ZudDcpjYOgaN-e2G5isxq19BsbPC1ACKtsI0bq6JBPFus0E
Message-ID: <CAFEAcA-FcVuMcvm5OvO0oC7SSBUDrrp3wqmFHywWmpKrF87WRQ@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/i386: Add -msse to test-i386-blendv.c build
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 17:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fixes: 0f9a4145bf5 ("target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/i386/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Paolo beat you to it:
https://patchew.org/QEMU/20261119130738.269817-1-pbonzini@redhat.com/


thanks
-- PMM

