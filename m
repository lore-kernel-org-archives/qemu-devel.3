Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7084DC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsig-0000Lb-14; Thu, 10 Jul 2025 10:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsZw-0008SO-IF
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:49:05 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsZu-0008Hr-RF
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:48:52 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e73e9e18556so1159453276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158929; x=1752763729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbqj4BTrvpp2MG1rzYDSPi3IU6swA8w0WXXKs5LW8ec=;
 b=Oh/k7QrIIBAqBCdnR6lYrcg15D8ytGBUMJnlV8SsCbTyrqg95QCJ7CVS3WZlegHr0g
 M2RVQg0TpHxo1Vy0wm5fBTDtuCoCZIu8ppHfP+og6xStyF4xeICqubCUWkmbxfevRF9j
 2Ib6x8rzcjuslpG5HZf2H0ocVt3wnXRuCp8MpJwAy0T/oOpUA+9M9+Eku/BYutPK82D4
 UiBGBU1u1g+QwZ9eNMVFwIIA8eLd3mmYd0eat2wyce51eVjl1MmLSzwfjDX5tMe1fe3/
 VtOV/NQeE/QpxfCpCrxCA75JJl49yNKzzHH7On5aQOrIGhQFuyLcBe2uYg5qCy6/mRlA
 /oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158929; x=1752763729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbqj4BTrvpp2MG1rzYDSPi3IU6swA8w0WXXKs5LW8ec=;
 b=a3HblTSj1drLtvk3Oyjdd53Rr7LkzIjWbPHyzrdcY8mLnoJM8tMbyMp6FkinIy7ZHr
 bRqmOmmZg7iYbtyDV1KwD5OUyonJFcyQ3/V14vUUU5Y/exgCB0aSSYfK2yyIFgIpxOcI
 Ts2SZIVr7O6bSvxsZa4bv00HZ9PIESVeq92AIoki8kJeVXAGRhQTwi8cee99FNWyPBtL
 rqRUH2lhqSFKLK2bZceaObkSeYoT7Y56NWDyHEjFd894RjlSoC6tVlOm77stkw021DJx
 ysluomy0KoFXuKIV9eWDzWqf84qud0XEB3VqQCIlbb4AcDiAjDDjdrNRt2Ih5ir0Zw6n
 3sqA==
X-Gm-Message-State: AOJu0YytJbOhplDfyk17AHG8suJMqOswv2bzQ5AqZZWmqI8VzcuUPelC
 0TWHDOoyZ0Mr9DelzRC1yWkBSSWm4GWPCr47eAG/LQHsDJg0USSs5p0uuykgFso5EAIOO/zN1AY
 MkP58nsuVaABkwzd/JiTC5cJcq8mOnZtwvzeUqRUyqw==
X-Gm-Gg: ASbGncsuk0bIes/9FhppejgJe/YQF9wKjmyyGciB0dZQzM4il81ESrL7Efp4sKq6MkA
 Nu/DKNbGNaUgDm7CwFyvgfxLy/Cw5dDEk+CwvVPP9UYWZ28Lw1xISNdzpSdyOmiQ6xuu9OflLKS
 9/vYEZS+frrhwVSG6oWdZ+h0Um540E6p4DBTg8uC6SsOBIXNOSFSq95ks=
X-Google-Smtp-Source: AGHT+IFWaN1V+iv2aDOZlYDUm6cUx3WFL6Ki3d45VET4zCOHTenrwXxRdgqf+ht63bVKIWEXfUMIilru+x36szPQHHQ=
X-Received: by 2002:a05:690c:3403:b0:70d:fd6f:b151 with SMTP id
 00721157ae682-717c151b52bmr58575347b3.11.1752158929602; Thu, 10 Jul 2025
 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250210121045.38908-1-philmd@linaro.org>
In-Reply-To: <20250210121045.38908-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 15:48:37 +0100
X-Gm-Features: Ac12FXxIAOblgHyMQwWhlpitj3OuBTjHDYjdYeQepjsTbhSurdE6W4_FuZSiVCQ
Message-ID: <CAFEAcA9NWRDNEEJpAY8gm+yrHdY-UeaE0i43wu0CJBq+SKKrmQ@mail.gmail.com>
Subject: Re: [PATCH] system/qdev: Remove pointless NULL check in
 qdev_device_add_from_qdict
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jens Freimann <jfreimann@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Mon, 10 Feb 2025 at 12:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Coverity reported a unnecessary NULL check:
>
>   qemu/system/qdev-monitor.c: 720 in qdev_device_add_from_qdict()
>   683     /* create device */
>   684     dev =3D qdev_new(driver);
>   ...
>   719     err_del_dev:
>   >>>     CID 1590192:  Null pointer dereferences  (REVERSE_INULL)
>   >>>     Null-checking "dev" suggests that it may be null, but it has al=
ready been dereferenced on all paths leading to the check.
>   720         if (dev) {
>   721             object_unparent(OBJECT(dev));
>   722             object_unref(OBJECT(dev));
>   723         }
>   724         return NULL;
>   725     }
>
> Indeed, unlike qdev_try_new() which can return NULL,
> qdev_new() always returns a heap pointer (or aborts).
>
> Remove the unnecessary assignment and check.
>
> Fixes: f3a85056569 ("qdev/qbus: add hidden device support")
> Resolves: Coverity CID 1590192 (Null pointer dereferences)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Looks like this got reviewed but never picked up by anybody.
I'll add it to my target-arm.next tree.

thanks
-- PMM

