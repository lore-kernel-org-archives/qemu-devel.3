Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFFECA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoN83-0000Yx-AB; Tue, 19 Aug 2025 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoN7x-0000Xc-MD
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:15:56 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoN7v-00047i-Rp
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:15:53 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-afcb78f5df4so883358266b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755612950; x=1756217750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sgsqZutBAefXwYkP3/sz9z7SLv7C3kGIfxQatOoGJBQ=;
 b=U0QartKEix/TTrCpIGbcwtNrySNC9NSQHn40BB6zeC+rpiPUI1HHiWHsLDo4NhXioi
 iB9TXXWzKtDwvd/ZubP01l8mGL3JFgskmr15FCRafJMikLe+k2WnmtRMT+lf4PkRODS5
 ndsPD5BkjSBvFxSDiH+tMO866Fb5VDr392D0xp7H8S7PBjbnW/t0vOinDq3Wnk43vf5U
 aGr9wEC+1w3inTyXdXCysw9KlkGLrn4fsT3ikBu6atJ/Dq5+S6GaGN8txfsr55+iVWIe
 +si5Uw7W7YC75DOt3PsvKroRPaDBytz2aLgOuqYO1S98xs0ZdDg/q0Sz/mI4rNjwNT7P
 9Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755612950; x=1756217750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sgsqZutBAefXwYkP3/sz9z7SLv7C3kGIfxQatOoGJBQ=;
 b=Z+4uojypoWOYq9eRCGjjcrpQXcIJ6It1F6zwRk5XJmnP3GeXEynvUu+8kFav9EXD1D
 LYBhvUA+Cp5qhW6IOAdj4dHBR41mbVK2p4jrHazcMVtnP5gQ0dlIv0JljqMXHW3R4qC+
 3yZCi7QKyqih6yhS9FFaSTrrDNZ35r2ldE4kxk00lV7QU/x8BtiX38yHHRhrm3gTmctX
 bORvPedH2bGkcJVGpvCSAw3Vqjzuh7PK44ah7ZgJSoutiGccKPm8cYtaCqKy0CsAhrK5
 yFrc+EuK0Tsc6C2QolatnY67VpkwXVHxbBdA1ILCotQ7xf6ekyVZwvsaMif2yKkVpgTY
 +rog==
X-Gm-Message-State: AOJu0YwlfaycV7k9XHY7RrHdv3USxuJfrwYOidGnkrdJG4GEJCKkyws8
 jheTRpQZD2tMtBxKU/m6c2kp0qCUCXeMf/9tniVFpTzmrqzHU/IwN3HRGSvsVqbV2A/zBsD8kjW
 ZAPOxWQ+7+ve2oR3wvFYl2p78q7HSRHeKzw3H4D0jkQ==
X-Gm-Gg: ASbGncszqmkZh03b4hln257RE2fHu1/GfYakEZYVuwV661OnQubiemMVJ4ZO0+RBiHr
 qqyRNFU6ueuttBCUCVhM+weDpJFv92va8tChTjzQ0Wgh0+Ou2JjCfUdQkgIUdXfBeD/towiwQPL
 14LaVXSL9O+u/pprzWBmTf9DFzxZvN/tAAyyEHBnCKM8+Fksd6w6WppGiPfWxOTIeQ0PJEwlP8U
 XhnoXvp
X-Google-Smtp-Source: AGHT+IGZ2fJo6Xu1DlSZFD2dNNrtjBBbhERgEWUvByohYn0LO6TNu7KT13qjAmoWS8/Oyn/wBSeW6e87axl4AFad48s=
X-Received: by 2002:a17:907:3e0d:b0:ae0:b847:435 with SMTP id
 a640c23a62f3a-afddd1eb455mr254673266b.49.1755612949928; Tue, 19 Aug 2025
 07:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-4-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:15:37 +0100
X-Gm-Features: Ac12FXwajp7nx-bKif0B-2Wc7S7TqlVRZ52K1okbV3Dh1y301bICLlhk5ntIf3c
Message-ID: <CAFEAcA-VuoK0C2HXMViFk0wDzWJ+czaHFKnetJ-DjVCo-DHd4A@mail.gmail.com>
Subject: Re: [PATCH 3/7] accel/tcg: Add cpu_atomic_*_mmu for 16-byte xchg,
 fetch_and, fetch_or
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Fri, 15 Aug 2025 at 13:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

