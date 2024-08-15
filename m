Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15D7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 06:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seTXE-0002iJ-3c; Thu, 15 Aug 2024 02:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seTXA-0002hM-Tj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 02:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seTX8-0007Ju-Vc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 02:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723701624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OY7z4PiiM3YrPXfe2mfFEaWUyYwu8zJPk8Qt5V2wsI=;
 b=WQ6Iwuj+YDal78pwekiMMD35r07/fr0o9hV/y6OywvKxmTYTcnUoBR0yVdj7HSqk1Mhf3I
 gSn+G7pIJ0URMqZ0qPioLQtYa1bjvBIUlsXEiVME1gdiRL+XbsaogJwIYFxe1h8wQXIRQ1
 4+m0CL4Ali+VcbR5HiICbm9hTvZHbgI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-RtZGBHx3O1KAIa5XUKYgEQ-1; Thu, 15 Aug 2024 02:00:22 -0400
X-MC-Unique: RtZGBHx3O1KAIa5XUKYgEQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cd4e722d82so563418a91.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 23:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723701621; x=1724306421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OY7z4PiiM3YrPXfe2mfFEaWUyYwu8zJPk8Qt5V2wsI=;
 b=foya/9Cz4G0EcU8pHo/y3oGKvjjQSjEJHMIIlTKvZoVRYNKrZ+gxMmMCTCVgKqRuTw
 EsEDGGwcBlUNPRMy3rDMMqkwNzl4jsBdAJsXutzBa2ACGU/hYy6vVrOH3yajtYq+5YgS
 pE7NPJ4QN7HI2wxXNKR8qJ07yESMjDn8THpIAtfOLQFQNGwmXMDwprQO4+/rZ9CfrubP
 JsgRPkD6EUARDcs826kbEAPh1x0zXi9qtwgbNrFpwgbysUZ68pwhxPSGjJhUJwjupMTI
 3h/T3viujtVQiXW7ZWfqBQPyMwr49dhQ4xfw5D6/xcMzpO5s0iCnS+y/NhQP7VETWdmy
 hVJw==
X-Gm-Message-State: AOJu0Ywlj8PhIjPUAFjLgrb8zdIzpABOXOiOIdjrEE2AycJDw41Kb8+j
 ftKFhjAxz7DkI8ujg1TTOq21MGmhmlzvgskrJh6ipe149GTgqIIuZXQOn6wNYPxa2dI5M7qbZvE
 pSvAVgpInKAlMC6/j3CudJgdh1cP5BcMec7ztLcZ4ybrjjULlp3gEWwJDh3K+WOcnDjRNwNfvFJ
 /dbQFxRR3cOleP3XsMWFWHeMa59BE=
X-Received: by 2002:a17:90b:17d1:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2d3aab347f3mr5635331a91.31.1723701619360; 
 Wed, 14 Aug 2024 23:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNmrmxwxTpjkWSdmG4uj+Yyt8xxEaUwbVqGC7Orgl8ZbH1J/hpXSNJxigxc4sVmvIznOZwFax80jsr6V7HHgg=
X-Received: by 2002:a17:90b:17d1:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2d3aab347f3mr5635253a91.31.1723701617527; Wed, 14 Aug 2024
 23:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Aug 2024 08:00:00 +0200
Message-ID: <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 15, 2024 at 1:37=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> Contrib plugins have been built out of tree so far, thanks to a Makefile.
> However, it is quite inconvenient for maintenance, as we may break them,
> especially for specific architectures.
>
> First patches are fixing warnings for existing plugins, then we add meson
> support, and finally, we remove Makefile for contrib/plugins.
>
> Based on the proposal of Anton Kochkov on associated gitlab issue.
> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710

Is the bug actually still there?

The Makefile explains why it was done this way:

# This Makefile example is fairly independent from the main makefile
# so users can take and adapt it for their build. We only really
# include config-host.mak so we don't have to repeat probing for
# programs that the main configure has already done for us.

In other words we should also take into account that there is a
documentation benefit to having a Makefile that works across Windows,
Darwin and generic ELF Unices. Anyway Philippe, Akihiko and Alex are
the best people to decide.

One argument from moving contrib/plugins to meson is that the Windows
case depends on libqemu_plugin_api.a which is built with meson(*);
that said, libqemu_plugin_api.a should be installed - which would
justify it being used from an "external" makefile.

Paolo

(*) by the way,


