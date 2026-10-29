Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763A606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LncdmgiH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPt1-0005Us-Jm; Thu, 29 Oct 2026 09:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMPsx-0005UE-17
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:09:39 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMPsv-0005ik-JG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:09:38 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso8261957b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279376; cv=none;
 d=google.com; s=arc-20260327;
 b=nZcmacrl9SS74jXCxFnt3PjiA4+ixngbU8e1RbuHtWsCoJm8HjDN+0nk/kGjspqNPi
 hCjnpkD/1WsRulWSeLBUOkQS66NZt6yb7PsnXUDXP5ZWDed64aubrIcKfUJX7CXno9I4
 sYn3IYRILj8271Lz711aDrJHUJs+As2j+j2sqx3VQHlYTb7OV9R9hg0NVsKg5TUZAp0Y
 66k3TV2IfJR9336JytbbrovxNhlZENEZh/RgwRccQgC06hou4Q8ECFhj12APSfTztHs/
 k3Cj3cdXYSYVsiNJ1g6dBA2r6m40OC79qW6/w021U5HI4loDFbFyMFdw906jE+Hrya7f
 hAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w7U7K32xtNZSnxwuBq+DRX3+WNFFwlJ/yJBNs+t+zRw=;
 fh=XTTVB6ywah99SChND1zlNweUq8YqXd4UiqbWz1Dd4iI=;
 b=Yzd0N2he11JaboeqZELXQCNZ4Sko7ZpQ3+ReDb2tRGWa3nZ+qk4Yt1ai6KxveXSUXH
 DOQ3qQFotQ2lGGyCIavTrRz9+gURyLo9F2n5CpKaG0YwSMLUy3Z8jOxKK6swhpgePzwE
 mzaZbdcjMZrC27k64GuPDmKxjRkRXx634gPey5paZ46f2n1ZlqY1QNCOb3G53e9wH7Du
 TEByvjr2wLLm+8NxKlgwPCfNXF6sz7zPmv8Sg2rE8S2afzZ9XAo2nbzsnonsa0Ojv/7N
 rgvwy85pSpXMdg9RPctDKh1LCfAeVz6jYtLII3oYato9X+K29rTgo/6dq9xsUl+b5/UT
 WUNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793279376; x=1793884176; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w7U7K32xtNZSnxwuBq+DRX3+WNFFwlJ/yJBNs+t+zRw=;
 b=LncdmgiHyzSF3FdMT0urmb6MYzPigW9MBm/6lwdEU5yPoxO0EXtnXVnYVNbf9qV4I3
 fo5/8uuI6ocVmSnRvJ5mzvzZONnAyQDLZUdD0POTUL34BmFiycUsL+7VA11NT3STI48m
 BrVg7QZQF/yf06hbhiGFijWaHUWdeq8smBWquTFEKskywQVPGjTj6E/SdAsh3pp2NgCe
 50NAxoYCSjcW2tdE138ypyKMuqaIEvxoIA/ASuOTkGIvWc+wQW0LferK+oMNbrU7B7h1
 iSNjl9VrtapLQa2AH6wAN3WNU2cww/YAA7mfWKUHT1En7XxfkpH0vHM4H7ixFq++hnTm
 n7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279376; x=1793884176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w7U7K32xtNZSnxwuBq+DRX3+WNFFwlJ/yJBNs+t+zRw=;
 b=TkqibrbGlWUPJ1bTvqahA0xwLQUkcz4SmwigU0SJ4QzegL+9/oQD7Xaf5VjAhKtzWY
 lu6G6gSnBqqHTirQqsX5JjA9MpTq0+5t2BdZ8p9PwKjokXUpiLu15x8z8LORz7hIe/W8
 9yZpzLBbut4ZPFmEmZRfKCnzTKjUp5Ig0oEt7y6Ft++GzUpGEj0XHv3ga0lO2Mg+0YVv
 YjpfTLdj36OMQw60T3UDc4p38m5zBKAqhvr3/k1r5l0inpXfmPsZZKhqLF4L4dVAUeQp
 sP4C4SJCTSnHciRkNLyHZ/71qLT7LcIsuexDicTtCCYjhQIlmLxUbmcNbG6KmzRh4Z3+
 fi6A==
X-Gm-Message-State: AFq9FYIMqZ5ZlREryefIoEgJzmVnYHKV5JKjHYX6ILOhjkhvWwkzFi/0
 lvgk5TMgtEY65x9aMaFhu+XXGpp8v/xt+K/LEKN2px7RwmqYOx1jcB+UhGoqoAghw5PPQjs4fU1
 WRYLfXSiJazK2S22iMKh1+9rfSEKhmByxoCC88kCSbw==
X-Gm-Gg: AYBFou06pBsei/AT/U4WShUlKAK6h7lExPwXVPZ5CaKCHotzMaOkr/I8Wmf3VZlkrzD
 LgDa+W5z9t5GCwovc/3v3mVKBDb4PvSCv8RNok3r4JvbOSgmwyBBKE+o4Yxuc1bcUX0t7yNNFfF
 uPSQb3aj3q9ZJLMApOGP3xa83D+D7o/uBRxVP6exz8QSdyGTcnqh1c6RwYtm3pp8XmgKrH/vypz
 oo830N85wuYctiJjYpPtE9JbrAS4HYjnLcikKrnqS06O7Km1zBKsZb/k8vZwqFv9b4/x3XGh9nn
 Z6wra91lUErx3CouOw09mK4wnUYdYVP7ymS1dEyUm6T5uy/E0MNOtJ4se2K+ZBf6lROC+8RcQzB
 m/k/8mhZVufyveNUaL8Aja03ZdaGWLk1XDdseUblyDykOzY2TBK8FEUce0OJS+NTzulNb4+R3En
 aWKQY0lRFzDVyAI/bXMb1bLv/pmwLKo60UgF20Ti6GJA==
X-Received: by 2002:a05:690c:85:b0:8a8:8945:c41a with SMTP id
 00721157ae682-8b1c656a434mr21708377b3.3.1793279375911; Thu, 29 Oct 2026
 06:09:35 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 13:09:24 +0000
X-Gm-Features: AclHuK__jkVtgNAMuh3PRt-5Flalu8UGsOdFKx4T9vSHT-MEcw7Wx2JYZlaPAMg
Message-ID: <CAFEAcA-Z-6F=PSEYt4p-RP1LcOCiPMQVLvqCXTRfgn_R48VQJg@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
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

On Tue, 27 Oct 2026 at 14:30, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> This series gets raspi4b's PCIe root complex and GENET Ethernet
> controller working end to end: the PCIe link comes up and devices on
> it enumerate, and GENET passes real network traffic (DHCP, SSH, bulk
> downloads) under both older (Debian 11, 5.15) and newer (Debian 13,
> 6.18) guest kernels. Most of the GENET code is Sergey Kambalin's
> 2024 series (patchwork series 829638), carried forward with his
> authorship and Signed-off-by kept.
>



Applied to target-arm.next, thanks.

-- PMM

