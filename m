Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445F8C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVazN-0002Pm-Un; Thu, 01 Feb 2024 12:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVazK-0002MB-HB
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:36:34 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVazI-0003En-Si
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:36:34 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55eedf5a284so1565715a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706808991; x=1707413791; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o7HgMUcJYDwFYei9UXNeIyNP7q17jjzr/VJlzAOm+Hw=;
 b=zjXQ8v0r6V4DJjhc/XQVsyTeOgAaAw/SG9omhPRVn7iaveFNxU2EpXHrJGqbuxcATJ
 jHqeWzip24GHgyzfu8cc5w0ukr96OhbzFQR4nlY/jGoRXd/5f4npb5pfhvMdSMbhf/t8
 wOljCm2hGSNgu5OoblTtrY3NhNCHxp505WCS6d+5U54PeZ9muCyNKzu9uL+5xzFiT8EO
 qlnO479YbkTj+QW2imb82cGWlni72iErhtEkWGQWmUIbcwXfyaQy92777kGd4FPk0hDY
 CXoT9yQ5Cx+eBSxasA1elAfDJj66QQs51fGdE98FQpC1mXtjZMdG7G/2U/SLwnoaNvJ9
 51tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706808991; x=1707413791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7HgMUcJYDwFYei9UXNeIyNP7q17jjzr/VJlzAOm+Hw=;
 b=W3aqr7B2dytNqoGs3LfctGnTQOCdfGJ5HQbniuinA+mLgkE5dSm5U90nIjgMiodC0Z
 Pf3Dm5ALgmkKyJ2YBMx+Rz+64ZteDiSCHd5Ch8auTzmIXMFyCMfLDzGQMAO192rU/RrH
 P0rV6GNDIY0cqDyUlLqjT/NFo/iXMhfyaEErnxZc49aEa7A/E0GovTj/zKI3Fy0B3dbA
 4vnlX5xLq4wY4pXYVLPFNjSCfJUSkGhURdppjftI9z4mfnnyfUP7w6ktlOV3y/83APCP
 qvF2t+4+QPhG6iceyxTyCen9D13LMpgwaHzNQaXUkuOo6TZnbQYbPhWh+quAK+d8H80j
 BXaA==
X-Gm-Message-State: AOJu0YzDa9aQhbmtb/9zWhrlPGkhl2YjbYGUMUMw7UOycYirVZIoC7gA
 non9JCHufiBuvmtr8BqHG0/K7GmVRC2Rp6P4FubQxe3Chg4EnnpcL2l9q7H3MiOL9RwpnEFz+ca
 /ief54MXZws1pVVv8Bf/XOH2PaabBKWaF8iqmTw==
X-Google-Smtp-Source: AGHT+IHjj3Lac5j+821ojvbiRkLxzz99cZIiSugOl0Tho1G4mysYKnH7WqHcIlUS+Wy17wsb7DOXgLr6YuOrHDYBBbo=
X-Received: by 2002:aa7:dcc6:0:b0:55f:6b8:b2f7 with SMTP id
 w6-20020aa7dcc6000000b0055f06b8b2f7mr2255153edu.8.1706808991065; Thu, 01 Feb
 2024 09:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20240131002800.989285-1-nabihestefan@google.com>
In-Reply-To: <20240131002800.989285-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 17:36:20 +0000
Message-ID: <CAFEAcA9dC=voU+1jRqrnVgk1_-WQhz5R=+7qq1um4mEnWNY8cg@mail.gmail.com>
Subject: Re: [PATCH v16 0/6] Implementation of GMAC Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 31 Jan 2024 at 00:28, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>

> Hao Wu (2):
>   hw/net: Add NPCMXXX GMAC device
>   hw/arm: Add GMAC devices to NPCM7XX SoC
>
> Nabih Estefan Diaz (4):
>   tests/qtest: Creating qtest for GMAC Module
>   hw/net: GMAC Rx Implementation
>   hw/net: GMAC Tx Implementation
>   tests/qtest: Adding PCS Module test to GMAC Qtest



Applied to target-arm.next, thanks.

-- PMM

