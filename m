Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C59DC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGyX-0003bw-Tk; Thu, 03 Jul 2025 06:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGyK-0003GP-FH
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:15:18 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGyH-0001aU-8l
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:15:14 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-711d4689084so85051437b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537711; x=1752142511; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8WH0JmMBT6AWG/mNHZQ4kH8iOn80Ux2TucSB14ZqeHw=;
 b=SerMAURuJ4KkvHk6KsSZfunLKVUahqivHVP6fuXon8qJoNSrT/QrQq384KZ6HJ9hkj
 SBIQG0FwDlVA6/KJhGdcsTl/FMdCrZhRtzh/iZ9JdmRCjg95AmfTxiBrvo9J3/+4kLRe
 4ddB+iQ9E7s9UR0n0G6FEUzXTCg4A1/LKMhNugsslyePOzg3EaOXHDdPxrW0cnIXFSKJ
 VOEyQyVRMwUd2aRRQJtS7yEbRI1oWUv4fZRy6Q+tpceN6lKGQ/VvYPPhqMXDggKYwySJ
 JZ3ggXjPGMoH9YjcyBIUnJAHDcmD15ogSPhmwC2OYwk0bsrU6AEayQXcPW84ckUAJT6q
 4utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537711; x=1752142511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WH0JmMBT6AWG/mNHZQ4kH8iOn80Ux2TucSB14ZqeHw=;
 b=U4k5GgMWWeGGlm9Q2KQRtaVWYf2zzE/B07+uoAeIJFTLUoEZ9Lai46trpcdasHZLHN
 SDGI+soEjaApvh4cK45M8RH+3A6POMBRvMuVNDcA3NhVBhCxMnK9cx1hW0RApdLSzsBf
 MkfjfTMmIw172pXJ0KNerKQuwAhUMU6HOmNGD9h5pw3xZ4c9pFX9W36nVozhlpZiwkee
 y9OH+8HtA17WbUrkZsDdxEVzEKWSPEfCcvBecVy2WEf92QeHMxK3pFjLeUn8UWWEfAOC
 h8ls13xKMyhSR9aniREvBJbQWTG5AVfiyxRbnxxG4SVPAyfNesa0gt2gBkut3wrg9FET
 hfpg==
X-Gm-Message-State: AOJu0YzuWejUGuTIiEUf0dauwHshTWSYK9U0mg4sej4ZxaxEPY/pXPZ7
 PxhoC0E9rIEm5zewcIpaIUBJ7PKNl7BxZWli+jR58ynuJsxSc1wjpGGgsAOy8qEbp4VYKtsxCAO
 GTGceDnRPvfF7mhrttZRXzD7qjo3Utk3+QTO68LUPHA==
X-Gm-Gg: ASbGncvedNceFxsuTw4d9BDNktTTkmpGkkab/fisf5A+OB2t+ZawmsP0jxFL/0u61dz
 5AlisRRyGcOPBhjoMKWVSd/oBf98uyARxm6eaprHxB50ymH5qm2t7zZO0Q9FyLntE3z0KZzU589
 qqyPmWxRO91Tz+WqztJr/XKJpAEryr5aeAJinM7dq0q3pF
X-Google-Smtp-Source: AGHT+IEs76B47z9UcRNwyRXM+AK6U/d6yOYWSxMdCfQ/8x82mtN6qP/WMJX7dk/7zcFgH/qsMUYeKinH06K8OIDUbKc=
X-Received: by 2002:a05:690c:4986:b0:70e:2d30:43eb with SMTP id
 00721157ae682-7164d358adcmr86988817b3.12.1751537711669; Thu, 03 Jul 2025
 03:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-48-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-48-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:15:00 +0100
X-Gm-Features: Ac12FXzquvm_wKyXF-enRT2RB-yaVR0l_VBoMhuX5XkIGanGqL4tiXFUQvVsRHk
Message-ID: <CAFEAcA_G8xXBdrf_QneAKYz=B1A-YPU1iqzgxWZ9nC0fwuG5jg@mail.gmail.com>
Subject: Re: [PATCH v3 47/97] target/arm: Introduce do_[us]sat_[bhs] macros
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Inputs are a wider type of indeterminate sign.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

