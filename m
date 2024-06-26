Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2ABC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 21:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMaDm-0003pI-Nk; Wed, 26 Jun 2024 17:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMaDl-0003p0-3V
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:30:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMaDj-0005tK-My
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:30:28 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fa4b332645so19155ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719437425; x=1720042225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcDiAsDif1Eei5fAlgDDnU99eoVAuojVWosCoiOaTuo=;
 b=KzR3CAYwbGPGWzzAdFiUf39JvRVqYfYRWxAOploNgg1fylbu4jJBrbH7TcgsLl8iDT
 I85OhXa/buVETDxwMmamMOHB3T9oWumH3x9HIgRoToPz8eSeFcNyUQ49br5mPBB5s9x9
 isAzHak/0YALjQ74yVqaGh6B3CW/0RMjGGPI9AOmJQ8p+yGB4CoFiBu8rolK9FKVFz7g
 A9snFoQQ/urR9fJczs1zS0uK8JQrhx7eUxQpD2+BTSnwXOrgSwpWw3jMQcZt/Bg4K3oY
 zJ8Ub7iit8DI2K4Y8ao7uY6S20iENpNLdktZlfgvuFwVWJdmZ3+TnhkqxM9CYQSE0sTq
 joFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719437425; x=1720042225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcDiAsDif1Eei5fAlgDDnU99eoVAuojVWosCoiOaTuo=;
 b=Vso4beNRm3vU2zkLZ4IbRnSNBDomC2A/qB1INIYHY1RJb+UzgT0jRAnius2D6sbnhq
 9Hf8cvtkW7MBBFYmS9ibkY8rmMi5duGIaYT3aDqaI+NzPq+GX9KEQ27k4COkpZMorn6v
 FEdp8L1dfvV4KMMXT8inyeEwtgGDzZOi2gffLEE/g2MgtuOti+NobW/gKgj0Jm8kzrhr
 lHbfit8+mZa/b44f53xcxTYRhpXnntWWK7FnvJYei4rRxXRckTLP0QJRdk+bY1EcjLmJ
 eZ/wDo8ETBGgYZ5S8rVa17zDcrVdrn+VfC4WceHoGEO5LLToWF+r30qqqhtfLiee/Z+D
 BMgg==
X-Gm-Message-State: AOJu0Yx5R7deEhGXoEp65Ii/G7V575E3yl1V+a3iQR/H4NamM7XJzIuT
 nFv6AYuSdmDOb/GRcPdR/eh9b3xLdlnSVBhCFsy0nC4c0Bw0w2/C8ksI4IqkCDipQMN3KXUsj8b
 L+rcWhdueKrS0ljq8tlGO/JGJVQonYrrf/b9R
X-Google-Smtp-Source: AGHT+IGqiN74y6JTTDly/tH9Dayp1HwOoqtz3GOsFLt5mg4o+LY4Ccrba5CsXEhILn3ch0Dh/skhWjHBZK0bcSw4yfw=
X-Received: by 2002:a17:903:348b:b0:1f6:a8d2:4ad9 with SMTP id
 d9443c01a7336-1faa96cffd8mr1256785ad.0.1719437424485; Wed, 26 Jun 2024
 14:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240625111848.709176-1-pbonzini@redhat.com>
 <fnhkw.xyx5xkm2lgb@linaro.org>
In-Reply-To: <fnhkw.xyx5xkm2lgb@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 26 Jun 2024 14:30:13 -0700
Message-ID: <CAOGAQer-HvuW8n1U8HpMNfSCAHkP_ghHG7PtyT_1FOdrXjhQ_Q@mail.gmail.com>
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, flwu@google.com,
 berrange@redhat.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=rkir@google.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Manos, thank you for looking.

On Tue, Jun 25, 2024 at 12:17=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Should we add an #else to provide a fallback for cplusplus until the
> alternative is merged?
>
> -#endif
> +#else /* __cpluplus */
> +#define typeof_strip_qual typeof
> +#endif /* __cplusplus */

You probably want decltype for C++ and, unfortunately, you need
somewhat more than just decltype to make this drop-in.

I am +1 with this patch (without '#error something'), we will define
typeof_strip_qual for C++ on our side.

Regards,
Roman.

