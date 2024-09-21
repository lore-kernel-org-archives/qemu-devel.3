Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70933CF9C69
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 12:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srze8-0001hb-0k; Sat, 21 Sep 2024 08:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srze6-0001h5-8N
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 08:55:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srze4-00041l-Nd
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 08:55:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so24783625e9.2
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726923325; x=1727528125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gUvtAHxnIrcy8adA/Qi2GWUz41NH0JY2w4an8OtCNY=;
 b=rfSQ1a+bxMA8EDRMcAOWnbMdYXK4NUiyYsgiiZDOCtNp1Li6OAXrmxK1k13Oyt9RQO
 3Fx/+089NR8+kAzindAB3TCGSBopvEWe/Wb792TJV7HCakeZ/MyYH39fwGyo7gs9MciN
 Nnky6KyANIGl0RqrdQwIrt+w9NfbnAqMfAOBCBmvr22JZsfChh2+DhNAKMUdj/TMXIS2
 NI+zKYk5MWsT46Ngm8G8DQBDrfmHFN6bOGcDTnoODgibOWrocO+atNkAUXAMz/McoNbP
 GLYUmJtGQM1U6Ws958iXqKHShfpcyB/zqQBk/MQ51lcBoR88MiCq6uDxWBP2l3a3il0q
 7mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726923325; x=1727528125;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gUvtAHxnIrcy8adA/Qi2GWUz41NH0JY2w4an8OtCNY=;
 b=OG3cL7cdoKR08GQHY/WNomakwQ6+xrA4zK8jTzy3nkxnxFbxQit1o5HtdTU2Y6w73s
 SxjJ2RrJxaUm47ENx6cEQg3R717uSVuokrxL8yIYVR20+hsHFvDnFsm6QsZ82i6WemRS
 7oI/7SLBkmigf6V0zsWLEEOD3ecs684TrL8vnGdal27ICthQdl2kqUG7r+dDRfDxeAEq
 8BNcn8foGnsZe3KtITCXBnLdSA5+iR0VC8CnBV4LyQwEO2tK2RYjuWiMbi7k8mrwysii
 mtXDFHyOd0PJLAPEUZUfpXoTnsofj0s+ZJ/ndtXgQXjLPRXrYwsw4H/9oO80yYHObbe1
 x3aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxau8oA5gGLOxTCipmRlSNCk4gDNSnkZsFol631mIgtitmJl2brndzsoaiaXhbui0dy6VhO5UhqBLZ@nongnu.org
X-Gm-Message-State: AOJu0YwVU5Xgw7yHMteldGYUYvb/sOAtbU5kDOL+d1hpHCkTiDeUR1oI
 FIbPTrognNFdbcur7ONvBjvfEnclNrHWc2FYFBxmE58RZwjEW+aQO5SGmTt3tYI=
X-Google-Smtp-Source: AGHT+IHmjVwhgpsTJPQ9MKO1m+Z0zsSWvRmeMTZI0bnu8Ln5rD6/fqTaol1Cx/98kUqulMUEsmcOvA==
X-Received: by 2002:a05:600c:1c04:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-42e7ad921a7mr53366455e9.22.1726923324530; 
 Sat, 21 Sep 2024 05:55:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78054cesm20088279f8f.108.2024.09.21.05.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 05:55:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBCD65F80B;
 Sat, 21 Sep 2024 13:55:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brad Smith <brad@comstyle.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] contrib/plugins: ensure build does not pick up a system
 copy of plugin header
In-Reply-To: <Zu4063fjfHC5hHUl@humpty.home.comstyle.com> (Brad Smith's message
 of "Fri, 20 Sep 2024 22:52:27 -0400")
References: <Zu4063fjfHC5hHUl@humpty.home.comstyle.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Sat, 21 Sep 2024 13:55:22 +0100
Message-ID: <87msk1dv45.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Brad Smith <brad@comstyle.com> writes:

> contrib/plugins: ensure build does not pick up a system copy of plugin
> header

I'm confused because this changes the ordering of the GLIB inclusion. We
shouldn't be including the whole QEMU include path.

How does this fail?

> With the ordering of the header path if a copy of QEMU is installed it
> will pickup the system copy of the header before the build paths copy
> and the build will fail.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  contrib/plugins/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index 05a2a45c5c..52fc390376 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -41,9 +41,10 @@ SONAMES :=3D $(addsuffix $(SO_SUFFIX),$(addprefix lib,=
$(NAMES)))
>=20=20
>  # The main QEMU uses Glib extensively so it is perfectly fine to use it
>  # in plugins (which many example do).
> -PLUGIN_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
> -PLUGIN_CFLAGS +=3D -fPIC -Wall
> +GLIB_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
>  PLUGIN_CFLAGS +=3D -I$(TOP_SRC_PATH)/include/qemu

Not withstanding the fact I've just borrowed bswap.h for a test plugin
maybe we should actually copy qemu-plugin.h to an entirely new location
during the build and then include from there to avoid any other
potential pollutions?

> +PLUGIN_CFLAGS +=3D $(GLIB_CFLAGS)
> +PLUGIN_CFLAGS +=3D -fPIC -Wall
>=20=20
>  # Helper that honours V=3D1 so we get some output when compiling
>  quiet-@ =3D $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(st=
rip $2)" && ))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

