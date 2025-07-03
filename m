Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0068DC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGy4-0002XC-ON; Thu, 03 Jul 2025 06:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGy2-0002V4-Px
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:58 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxu-0001J7-6n
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:58 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so54381567b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537689; x=1752142489; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GVPrrhJgvJ1GHo2JFSyjI9uU+Hr0MsYTK0epYU+8Uic=;
 b=hMJtNujPYxD70mg2mPEaLCo19anfrNiB5nCd1bBMa1IYtH7JflYWo6hc+CJwVsNkeO
 fJn2bKknAgZ7eSCYqMHLMF+9GqkqdF/aTQ7UDwJ3TvKk9NvoYwrX2K42t2Ym51XebNd7
 F5wPDfiErtknLGOTootxmD4DDrtGHVfIYsh8HxWlDlmOqaO9lE4jf8MZYs1Poo9oAd+a
 B7Y54Tu9sVevETL9rEsrtr3jymK+FZ+0XTqJyupIoLKpmNqaBX0mrpoyXRD/pmfFUPWl
 C/v1v4Nv05lyNtzH8XHygv3H0ODBb3czcF2GnUCXk7BrTJNh3CUFdJbFJ3hb39MJhKX5
 MnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537689; x=1752142489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVPrrhJgvJ1GHo2JFSyjI9uU+Hr0MsYTK0epYU+8Uic=;
 b=V9sT5lftAjW0lnjqF2sa5y7DcRJEFWXgHBhBbDGAI5AZDP+f4YH21+XN1tJYs5bZD5
 q49757bYKj7HlkCNiQnfjgfZJSx/DpiVuSV4JCG2apU7hWiUAWWgnuNioZYvAP3er26M
 kZtP0WGux+aloWJhc1DWGQaKoxwsiJMnU7i9Dqv7SI2Tl2XE6Tjxpp7r10EArGkrefoC
 MD7OpCn7HA0s+qGYllZWlUHpcrO3KACgfVyHWrArvQ14tuynhmtfjMD0+ak+9XEQQepX
 xF/nu/U8ug9BNyBxaDx+uZfCHfpyE0Ggqh+PVj4nbRfcaquN8upKAe0vhuF0zw2HXLFJ
 pH6g==
X-Gm-Message-State: AOJu0YwminRErDP/vtOxY0cFnBNTJxZFOJxyJ6qaFCb6dFjtkGr59Cef
 2sCIxDhTQYoUIFkAeyN+lQ+y8/tpEGMvFfJJPPmlsFLv9GI/uNoh8qKuDIWotZikBK2XweuqOP6
 9xNc5lAWnw+6hnXI6eiZdH9hjF6C55nnC3zbsFwqLsgS9/CpO112j
X-Gm-Gg: ASbGnct0HkTTmnxvb43vy7YoM5P3WlpeizZs128rLGFGoEItsjHLQJVyBjHauK5B6w6
 lY3tYnWgmH1sstEjxK04IFEArAnHByd6bvIu/44KGiievd+B1Ddn+hlKj90E4x2DmtuqqMgQT7I
 f//TZJpz5/zeRFv9grO4fIMakQWr37K9KTMeZNe39IvQ9P
X-Google-Smtp-Source: AGHT+IGhapjFLjUq/mgWziG+tULVqJgd/KPpmns6XIgqyAPGU8FwBrFlozwOP8zjuNdoDB1vGLhKwkwV89bEPw/hl1w=
X-Received: by 2002:a05:690c:fcc:b0:709:197d:5d3c with SMTP id
 00721157ae682-7164d2c7e12mr92979817b3.11.1751537688835; Thu, 03 Jul 2025
 03:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-46-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:14:37 +0100
X-Gm-Features: Ac12FXwF78y1FKI4ROuI6EsEh39wGtB2lrL1F1Ueju0OHtiDlMj3HFfk8iOW_CY
Message-ID: <CAFEAcA8xWkjJwgqi0SJfttGOkJCMn32Ef6vu8CbizuzHMJWG5A@mail.gmail.com>
Subject: Re: [PATCH v3 45/97] target/arm: Implement SME2 SCVTF, UCVTF
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

