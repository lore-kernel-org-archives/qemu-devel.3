Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EA2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 22:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v305J-0000CZ-76; Sun, 28 Sep 2025 18:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1v305H-0000CR-B8
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 18:41:35 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1v3058-0007Q3-TO
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 18:41:34 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3369dcfef12so1961699a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759099278; x=1759704078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bw8Do6TCBTO6+PCNSxJoZxpFtGThJdCleJrfkPVVW6Y=;
 b=KYXQVbKerJVutz4lyxUJpXghv0lyKYYPcOlyGZiSoD3jV5oqt0fbeMbW95TpzdyazP
 Onp25a/Zx+QFOFoVt8QXPoMCZkcaxnRBArCxxs48Qe0MTY5oIMk5kks5X0UvjLdQ12wt
 qYvUJdy1ijJi4l2ESP652wYuSqSSW1u8ciSR6BbP54GzmCeZAX9faZq1tkvoaz8EFkBX
 h7/+b2DAoTCTxbx4zVsJFAwlUzPgj7M4vYYrcWTgBFAG5VlEleQErN3UY1HjqUL4RCnK
 kuZh0i26QxeAStK5Tqa+605u4AUgVGP13mCXo/jlA2hC6FZ5Q3x5vkvuJx742d/BsL7T
 mBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759099278; x=1759704078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bw8Do6TCBTO6+PCNSxJoZxpFtGThJdCleJrfkPVVW6Y=;
 b=r8Wu7LEBV2PkHp+QZulvstyuaV0nARO1qNHRT+jKge/UIL70Qbpy4Aus+mDiZheMaH
 avp+WY/IbG3t/iCJv2mqn89Nk6ODtqTtvynxEnX8cJO96kwT/vhTPhm0e+cWUH5WuhWm
 ihCvzGpGzWDTmPpFOgHDx3ckp/Xqk3uYmG125/iNGKG49t0EGiVBfeH+FpI5e3l0fWrd
 UIvxnyC/10nDGMjDXnETCDJQuy6WOLcBP3G/pSYMwbbFK5j7Z+L8ViA1HzoChCDzJUmP
 dmYQHicUqnrZPe2EQwJYsQICIeK3bvlaEYikvIg7nMi/kxpsDNQ3NVHhAihQwAHs9vqo
 LRsw==
X-Gm-Message-State: AOJu0YwXd/NC9PCrmLnF0rYz/HlIZvEYZStVVuivRkKxk5D8b/eS1J+o
 QHqmudM7mihnRfXijBXAkRPn0w1qvtnKd9JbJYe9HVTGBQhf+zR1yrfZJD9Wa8FFuCxksI3G4qO
 N7nvU61dInabBGigUwM//MHcfAPgP8Ns=
X-Gm-Gg: ASbGnctOnKY2gNvHeHW60HUbNELS+zN62uow62M2J3M/aeMPH+BV0hUxW00B2BnfkcD
 bWNAYiaP0BZu/oMe5cSERERJyEZ6VDEqFJ/owuqcTp4mh/jbfOsDXr5E00tNlRbnlwczcD7wz7f
 CqraUfx7r16ivxVdgOr9FWxKan+STT7uks6fPU80sl/vtc05fyqloU1ybKgfB0zGCaZWacalLbX
 HP5UKvb2wf7Cis77wrrHScVfCk=
X-Google-Smtp-Source: AGHT+IFlEqPODjwSDjHyIisdLTCCc1svInsgFmbCa2p9+TEpbDsDPn3g33Ou9ggGh/wkaPvN+6JNcE9QceOX4lHrwTk=
X-Received: by 2002:a17:90a:dfcd:b0:332:fb46:9a34 with SMTP id
 98e67ed59e1d1-3342a2c2a76mr18308145a91.29.1759099278028; Sun, 28 Sep 2025
 15:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250925013513.67780-1-philmd@linaro.org>
In-Reply-To: <20250925013513.67780-1-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 28 Sep 2025 15:41:06 -0700
X-Gm-Features: AS18NWCAFOaLNH2K6fg1xbGTirvhBYrPcR-DZLPQbiRPIlNDygS02bcFIw3tXug
Message-ID: <CAMo8BfJ6W+fCmBjx2bYb=0v-cOBb4_x+f6Bm7WCsCrgNsRtYEA@mail.gmail.com>
Subject: Re: [PATCH] hw/xtensa/xtfpga: Have xtfpga_init() only initialize MMU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 24, 2025 at 6:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> cpu_reset() should not be used with an unrealized CPU.
> Here we simply want to initialize the MMU, not the CPU,
> so just call reset_mmu().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/xtensa/xtfpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

