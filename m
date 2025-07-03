Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE86AC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXH5Z-0000Pg-Qs; Thu, 03 Jul 2025 06:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH5X-0000P6-49
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:22:43 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH5V-0004ri-40
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:22:42 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e64b430daso59776677b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538160; x=1752142960; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I9HfEXraln6KjtYBXwnUUI297bke5zf62srW9A4hCMY=;
 b=J20jD93Ql/PvTd7xxCmEblVswznu0Cf62O3K8wJQA0y782s7+UdALvQNWnqtk/BFup
 PRuxBfYwIIKE1NCTaCqs2BzdPFfgXBOGPyM5NLvCWDTPnTc/eqRYyRpS/3xqKbKwA/1w
 ZD8xNcOmI7MGoyoT+wXGs26pl86EcWWzJOBVOGlH/zxJt6xlF7Q9K17e3vzy8KqnVQcS
 C2l1d5xxd55TxpTUavWI7ICO2tvrbYcR/d010YxNLBUNI0JwMHNd4wJdSyvz00/fr5MM
 3SqNUyW3B8h+yC36Nby9RO9Tqu574tBNKyAmnMJE3YMs4G0G0RkwlfQWXoJJaqi+ZBaS
 7RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538160; x=1752142960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I9HfEXraln6KjtYBXwnUUI297bke5zf62srW9A4hCMY=;
 b=JyLtwyY9dVPsA9KfzNlOV2KHohbgMv6Q4fxWd36TTprPJZBqBhDK3ket5spDV2PNo4
 djkb5lT8Mn3gNYJrNmgjduQi6mrEckGWyIc4A7xlj9lKAsd0rh5Zl4mSox1++NrBP7FX
 vrO/1RCvKZ09xtnDHqwQkrdtvsDJdqj4AAlfeMRIDTMk6to0ue9ePVTfAbjVMVDRq0gb
 OYhXOZtnWzwJ2r/aPKJapN9i14dFdoCZ32jg6bqgDnaceA3XxGt+BQl/JWiidJXcrUn1
 tPNLs6fDEVS9Dz3v0cHhi60w/CT8IdC4nLw593bK4TnEF9sc6AJYpU7dyFV1YCHcyUsM
 uE1w==
X-Gm-Message-State: AOJu0YzEDDZ8EWocRGHYehq+mdiCiAFbVizfRbJmeLlw12HQWsgbmz1Y
 tvG+EZRfjJRqzJp9WtHd3LxGpTswAcvTr4fSBLUD4vo4TW3cYmJLhpsH8v9U0SBhPnoA/TwyFCV
 wNBO+3XR1WONlmcjAYrjZG+OYifkgKfTut6CujtoVrw==
X-Gm-Gg: ASbGncso5kicWqcSJ97nnuKpJza0GRWJY8wNXyZID2AkMWywKj/DNlxTlsoacqQH8cj
 oNytbmZUnY+mvuPl8EH0Trr0XYK0xXLz51pdARUPKSmG1LUtefZ/TJoHl61DqOj6hcZBqkmaV6B
 XSC6BFoSihVzq7/U0auRWz25v/WjVRp2osuMkp/RjwFg71
X-Google-Smtp-Source: AGHT+IHiy2fe2B8ti9DwAZjKtFe97qFduoCvUGrIpl8Unhp/tHT8O0j4v/yCFpEwcar0KxJa+2z3KuETl6mC8ztryeo=
X-Received: by 2002:a05:690c:9b0e:b0:70d:ed5d:b4cd with SMTP id
 00721157ae682-7164d40a08bmr77133257b3.17.1751538159580; Thu, 03 Jul 2025
 03:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-51-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:22:28 +0100
X-Gm-Features: Ac12FXzANywrODbQf_xvVTJf1VcpaNP4MAZKBjsp-A3T3LD1_Q4rh9GdJZVRLaM
Message-ID: <CAFEAcA9XA5oH6nY-mASbXLE62kKprusjQt9NQVon5qNPntFqRw@mail.gmail.com>
Subject: Re: [PATCH v3 50/97] target/arm: Implement SQCVTN, UQCVTN, SQCVTUN
 for SME2/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c |  7 +++++++
>  target/arm/tcg/sve.decode      | 20 ++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

