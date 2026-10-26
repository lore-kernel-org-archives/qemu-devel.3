Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1250606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IgXKrlnB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLN4Z-00083e-4W; Mon, 26 Oct 2026 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLN4S-00082e-Ci
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:57:13 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLN4Q-0006TH-MO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:57:12 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0d126f631so26647707b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030229; cv=none;
 d=google.com; s=arc-20260327;
 b=HsekwGD6n+QI/rWB4N4Gmy9I7jWpGNvAshvUTq/DkHC6NYeZTFFZW1MLimMRmIljGM
 H7Yf2Dq7B/8S9GXeBVrD1Kqm2YXUPEZsgYhmOhLHszZwO2PonktNtBfRw0Q2Mo9KIgKz
 736ws0jEr4qvP/OX/iSzWiT0xqOIqgDD17C7RXu+DTk1I42+UkeqtHN5QRcpjJXF4YvM
 D8Jls5J4fEK4ZKHs+8fZJQuW5Gc19MRuQoPAc3XGuB8vqiOHvL2S/YAzs+bunOQSjRUG
 Ga78ISbwaZ1e1MBYkFkXrhtWang0icOsgYcW51/K4/i9T3dhsmBEhQSYKtghAtjXeySX
 JZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zx0KTyhOYR8ruT5VlXEVTdnIHHi3M2k8T+AyKfHyLrs=;
 fh=XTTVB6ywah99SChND1zlNweUq8YqXd4UiqbWz1Dd4iI=;
 b=IQaUMLiFpR9EPTWpGt2BhsDuVV8bwiCBooifEks88iV8IIZT5LvW1q/5+waeZIfVdS
 kcu2h7ljBemqQJxa7mQAmct12XM5x0AA3Fpx18jn+tX0YOo0AD9V1i20iZFelc/BA/+V
 qVxFUbuSL7yazzoHCQvPlpAvitFd/nkk5rJHxJoGeTcHYFHD4CDKf6zt7qnLJBORwd7q
 I3le4DTbedA98y4zfHcSdLkjctzG71SXD135CYWTl1n5GAysgR+I9uqCjezFrubr46WP
 LEOcjDZcJxqnBxVwjwXEtbwZxYmu69akSAaGXGbv+McGEm1IXn4JIRZSwWxjh03a4xlU
 aa1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793030229; x=1793635029; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zx0KTyhOYR8ruT5VlXEVTdnIHHi3M2k8T+AyKfHyLrs=;
 b=IgXKrlnBrWSoNi1VJWGpqbboXerqdgMiNDMu/tf58AM7tzrPrn/P/lGAtvQW8abI2W
 tCReDpfbLS2S4t6zAV8fhd/dOMkvnzvhWYMnAW4KwT+fO7Bnzv+Ih/iRtTlEz8FaTJUZ
 YSZSSpg//P41SsCMMnhMra6GzdR7rG78gkTYJvkkzdPBfAXNE7mUSMHPoBe47niL3hRG
 +uIImc8W3iyQQdRENkR6bxnx1v4x5iZwyvBlEd6IlDiCArzR7Jqypy79o++fGWtOI7j0
 dB4WsEMSCL3pqgBCe1jIAwKL/IVVyQRRsCF6hFt3F2rbAR1FXlI4/kdLwpNixjQi9WJM
 Xbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030229; x=1793635029;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zx0KTyhOYR8ruT5VlXEVTdnIHHi3M2k8T+AyKfHyLrs=;
 b=RwhwwNw+exnQJdPfzfId3pq5gTULZG77ukyn2X4+df8SbCCcgqpg0+S/9sKdGPGHHt
 psFyy4oH2jdtOW4T0+u3tHev42W405tlcMyX471j/RT4qw6BzQQNui4rW/vzlOezcOEP
 JKeVDEAMPxkMUvfx34TCUcQBSub0biJhPjo8ZWYhx9kIrCfp259R52ISbKqoiLmO5sJB
 wO/VxkzcDsUhTKhZs/EfI8JL8NLoWJIuidoeH0Er0jf8VP+Ze5I+n/wRVHiEEFRhVu1E
 c1Qa/TRMMAsk2V/GQuCv9B0Qg8kS6UHnkGrHW6tEbqS77Cg9BeUu/nV+53WitOyxrPEN
 u06A==
X-Gm-Message-State: AFq9FYJKEpgfXhVr6Ej7kswFNGtPiF6nQE3tuqCyvlJQr6uO5Dj8+kIP
 KzPmbH0T59qQQiOMbiSycaqZU1hiU15J4a6Esl9c703/fv++5zDz84sVkqvYxmRpMEBgo3YYSFp
 efa7Tx3SZzMbkMj8vrRdJWe5EA0kJkcr11eqZtlghwg==
X-Gm-Gg: AYBFou153zTic3eEZUESJ6wf7XvYDfSZmHbNWhsYBsO3c4jNk/2u4muKu7e4f62gvil
 +xHRfuB+DclFjCkTR/9DMBjNn+G+Y2KMiMiBY5d7VsP60i9bU8QtM0H0wkFoa5K9QEbz83hgR3m
 OeqRUX1TDNBXAL2s1hYwJOYk1KHWcRdjBQ1BD6hOJJso2gglmjK2aduFlNxp26N9Ecm5vzFfEkV
 aHsJRpzKn1yQAEg35tj3bUwuUZgtWcUY26n03xdF/1uEwhSDovIOCYkQCzVhp9V6BkjhuCYj9a4
 SPCoZczyvthGa1sCQyPh1GfwwBkD1Pv+S3acw/pPywPXuH/ZN00TIQiYBg0aqZEQIMRaGScf/2h
 2JbEtJzF1Ok7SRmLj8myFHuvi+RjKlL0xhfqcS4k3T9gaj1JvFJQXUMla2uA9rU1tAMavoWQhib
 AagrUduZY2Wch500XAAbA5
X-Received: by 2002:a05:690e:2621:b0:679:992e:3acb with SMTP id
 956f58d0204a3-67a454233e9mr3564621d50.58.1793030229113; Mon, 26 Oct 2026
 08:57:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
 <20261023135924.64990-3-marcelomanzo@gmail.com>
In-Reply-To: <20261023135924.64990-3-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 15:56:56 +0000
X-Gm-Features: AclHuK97d_JZkXguIbsfiFJqJ2XfqzDI8SVzAIjq6k1hHrDb-ij9jQQMlvcIC6M
Message-ID: <CAFEAcA_t=VXby_UkxG_s4X0tbsOq8JDR4yP2g1iQKwG0uYf84A@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] hw/arm/bcm2838_pcie: add BCM2838 PCIe Root
 Complex
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 14:59, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add the PCI-facing "root" part (D0:F0) of the BCM2838 (Raspberry Pi
> 4B / BCM2711) PCIe Root Complex: a PCIe root port with the vendor's
> device/vendor IDs and capability offsets, not usable on its own
> without the host-facing part added in the next patch.
>
> Adapted from patch 13/41 of Sergey Kambalin's "Raspberry Pi 4B
> machine" series (patchwork series 829638, posted to qemu-devel in
> 2024 but never merged) against current QEMU master; the surrounding
> PCIe/GENET networking support for raspi4b was left unmerged upstream
> (base scaffolding aside), so this and the following patches complete
> and debug that series to get real networking working under
> raspi4b.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

