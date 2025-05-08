Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F2DC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyBN-0004Ga-Ey; Thu, 08 May 2025 06:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyBL-0004Fk-NV
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:08:47 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyBI-0002vC-LJ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:08:47 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so778145276.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746698923; x=1747303723; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1H0+0F9vOVLheaEZEvUdOPFnTo+Yi5n5w8p9tg66jlY=;
 b=DdpNeli9l9HGy9ezC3P2Qbnfst/bYaL6wTBNK/qLdhwZ2ZY3a0Xic6tUs5rqo7Xidk
 0rHmaQN7Jjmmc0UkCEJAs/fIX3FLVPvDJdaKzjvgCSdaplZ3a0thQV5XzpwC4EaihwkY
 ow4dcl29ezKjHMevJv9/krsOl6a+4CopHOcr86IsMmuu1BA7Bv001Fj/Se8u+RcyJrIx
 mEkLIUSP5rHT3MHfbB3+2UOelpN9G1RD2ABVY7upmJwTMVdAonL5wmeDJsrq4NjpmJ9E
 JVu8l+nGRWVdyTKPrXqgJX4XzqzJZ/jnr4E9R46UbeoFt0fKg3aYPgzsQreDZUotS++C
 5qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746698923; x=1747303723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1H0+0F9vOVLheaEZEvUdOPFnTo+Yi5n5w8p9tg66jlY=;
 b=n5TG9QbsxrIavtu2I8ZXyvjp9AOSADBYohzw6RAuJKFrQdBEtnOigClFWmkqT3aiDe
 jJ9Bwg5QqmizlOw7xvvOCHWh6+TxE2Aoqbu1DhFFIZz4gG56NJSujSuw3nJ8QBZeYG9g
 TdOVZtjCLBH7OaP7FW0SFyYH63D55wt0TSiNXLsXSFimprNG0NLY/Z9OO3AempmPpnX0
 NDh1mdGxdygWAg+hSjS42I7RV2LbC1oyhAjQ/1Z8Fxxb/QCUfLoEfLv5QDSu+UiRqfZ+
 887gcHl59uFPIdcEtFD/lbhz5JnOQSG+AmXc3hPySwSXEHarb9OGWi1NflijJ25F1khK
 etZQ==
X-Gm-Message-State: AOJu0YxP9Cs99L2sRk1HFu5xh85FXydYfmRj31sK8jRobmoh1z5CDPej
 xx5iwkj9zbpaTcp8/B02DZADAeeWvhwBOjRQ2GBB58qsl8x3Udfhf65H7aFKufFX1QfphY0IvSr
 SEt8E72BK+Gtm3ABeQLpYeSn2Xen1SCOXbX7Z/A==
X-Gm-Gg: ASbGnctG1AK2PvTteETljA75LQUqbNjOquHpv/ZzDD3Zcymc/UqmsZGl2U3FOVb4ZH5
 jV0dBE4NylNBZJ/AZbSRu19m7x3F8sCU0PIRFvgvDlILFx3afTj7kLhoJuAgCnSlR9VmfA4Jvf0
 cZKQod+T8RQu7XZKM1Gvrhojo=
X-Google-Smtp-Source: AGHT+IHAFjKhVb7P78m/ux7WDmQOeEzYANSm2OTObw8LkPC3QsIjwxGCiY6aftn5mq53d1lzDEptDpZC92r0BZ5Ofsc=
X-Received: by 2002:a05:6902:2411:b0:e75:5ef3:893e with SMTP id
 3f1490d57ef6-e788143b11bmr8339767276.35.1746698922914; Thu, 08 May 2025
 03:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250507165840.401623-1-alex.bennee@linaro.org>
In-Reply-To: <20250507165840.401623-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 11:08:31 +0100
X-Gm-Features: ATxdqUGNuMZUmWvsDZGuey5CBwObIZjAL67p9J79vhahR9SoTWffafPG5Bi4MUg
Message-ID: <CAFEAcA_0cf=XEbH9VQdTHqu1wekSmFDLdqnnzpcwnshCT-UUCg@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: allow gdb to read ARM_CP_NORAW regs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Julian Armistead <julian.armistead@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 7 May 2025 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Before this we suppress all ARM_CP_NORAW registers being listed under
> GDB. This includes useful registers like CurrentEL which gets tagged
> as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
> registers. These are registers TCG can directly compute because we
> have the information at compile time but until now with no readfn.
>
> Add a .readfn to return the CurrentEL and then loosen the restrictions
> in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
> be read if there is a readfn available.

The primary use case for NO_RAW is "system instructions" like
the TLB maintenance insns. These don't make sense to expose
to a debugger.

If we want the gdbstub access to system registers to be
more than our current "we provide the ones that are easy",
then I think I'd like to see a bit more up-front analysis of
what the gdbstub needs and whether we've got into a bit of
a mess with our ARM_CP_* flags that we could straighten out.

thanks
-- PMM

