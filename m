Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC0AC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJiq-0004HA-7S; Tue, 23 Jan 2024 11:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSJio-0004Fp-O8
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:33:58 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSJin-0001y9-5X
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:33:58 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50eabfac2b7so5690361e87.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706027635; x=1706632435; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UVQj/pj2j2Q29AF21r65RdS6NR6Cczwvrqv9AsCTXVI=;
 b=HHQMPy8UlGVbMmaMfLOAig7H18ObOQISgg1bCw8h8V67NvCfxWsQ1zJvVZJwMvdvaa
 iPQd1jP6yngdmSo44Fuzx7gF/4+cJXb+6+Su97reQSBRAmsI4ZdbLEIbfTBmpwBAEy97
 1ZwHzV89MNLqvIcu1J4NV3DuVENodMJL4JEd66Dd5r/cl5EZhq2El2aMhS8TA2EgHSYo
 WkP2wFmSPZSbZ/fGiIOc2vi8tp/FKM7fydZQc8/O5hssCZJWskB+y4UmMOFcv5tdw7Ba
 G2Tm6Ju66rwpH6pjL6s/P5SNlLlHsrEz5jlzSoN4VdeCY8w+Q3xh86pIlb37xg3DcaSM
 JU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706027635; x=1706632435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVQj/pj2j2Q29AF21r65RdS6NR6Cczwvrqv9AsCTXVI=;
 b=nIcI/fxxWvxSuW9v1kBDH78keLJs2n6fSTO4CmxMrdHGF9ElG43Zrelg2+LiuCZOUb
 dPEBCjczjV0MgDp75Lt44BMvVqjlKsccg6j+txMob5yKm0FK2dr9ANIzhv1TJ3fI8T2e
 IXuxJDSXEgvv/jtnwAqfdl+izvgOy/78WPj7IEN4/wTrWhBdfbqPgaxVNZj/xMG3FvIn
 CccEvykuK5jEX6bf4pYV8Zwb1U3P7HqozSDppgWIjF61wz3l/hWiBV488cf4BRg1ameR
 uqA8bfE3zAmt/fIS+cA8DoiPTM5kpJY9nT1u61GTqwJYI9/rNcUd9wAX4GTDueXw/7z3
 LuUQ==
X-Gm-Message-State: AOJu0Ywr5irohrEKx/Nv1cExx3TU3XuUZqbgQTH3NgIfxC9X3JzUu/4d
 has1q7hzdinlUS6dvcBAmEKZL0M74FCO+bdwCyMfyJWqnx3SRWz2o75y3MsJhfudutJ6KfSSw8m
 HHtReIK5etDqjtmZZFmbfihMtiK11/EbsljeQdQ==
X-Google-Smtp-Source: AGHT+IEdiB9UYHlh2oL1Ub+k7anQ27oKag2OC2QrGSz9RYyCvhH0sUdYG+Vfy2GLaib9FvnfGV6FhkEgQX99Kh4NHBs=
X-Received: by 2002:a05:6512:1250:b0:50e:3720:e974 with SMTP id
 fb16-20020a056512125000b0050e3720e974mr3394861lfb.10.1706027635311; Tue, 23
 Jan 2024 08:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20240117140722.3979657-1-armbru@redhat.com>
In-Reply-To: <20240117140722.3979657-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 16:33:43 +0000
Message-ID: <CAFEAcA-tX=GPm1zDq5pnL+T_cbivKUQ1dZe_vQ0XAjvehWLdpQ@mail.gmail.com>
Subject: Re: [PATCH] migration: Plug memory leak on HMP migrate error path
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 het.gala@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 17 Jan 2024 at 19:49, Markus Armbruster <armbru@redhat.com> wrote:
>
> hmp_migrate() leaks @caps when qmp_migrate() fails.  Plug the leak
> with g_autoptr().
>
> Fixes: 967f2de5c9ec (migration: Implement MigrateChannelList to hmp migration flow.) v8.2.0-rc0
> Fixes: CID 1533124

Isn't this 1533125 ? 1533124 is a false positive in
the migrate_mode() function.

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 740a219aa4..99b49df5dd 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -764,7 +764,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
> -    MigrationChannelList *caps = NULL;
> +    g_autoptr(MigrationChannelList) caps = NULL;
>      g_autoptr(MigrationChannel) channel = NULL;
>
>      if (inc) {
> @@ -789,8 +789,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>          return;
>      }
>
> -    qapi_free_MigrationChannelList(caps);
> -
>      if (!detach) {
>          HMPMigrationStatus *status;

thanks
-- PMM

