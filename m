Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD964C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 05:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcIr0-0001pY-PN; Tue, 20 Feb 2024 00:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcIqy-0001pK-KY
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcIqv-0001xx-Uv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708407576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NokBtaeLcYtIy/KkPBdQ+kbAirrEJUblmSfKgOgXHeI=;
 b=A7jVDZJ3CUHwe8vWDZHbtTAvgl94grP7MOvbo4e0YvMx11CyIE/h608OCNFHz6JdX6/6KZ
 7hw46UAuj6fuloP/rgg2GcGPrPvwa3eTZh0GnnPy3uWaB6keuE2Njb7S4YnM/p9yWcQxBe
 M35ZbB/WIlN42mEaVrr/yh5eFML7uPo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-v9ULBPmdPYSrLz0vcnHQaA-1; Tue, 20 Feb 2024 00:39:34 -0500
X-MC-Unique: v9ULBPmdPYSrLz0vcnHQaA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d57b2d2758so1509390a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 21:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708407573; x=1709012373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NokBtaeLcYtIy/KkPBdQ+kbAirrEJUblmSfKgOgXHeI=;
 b=ZxJn6iPJtmrxt19bdUUufFST/qVNimOPl2bGAe49pAIarxmoQZe92m0cKVoSCowf7d
 a7DLBvxGZaUHdarApYm3R/P68hYSMmJ+nLruUNGLzUjLUQwiuRhVCfalarXqQAH3yefY
 9ub4UQACTGAMtc0uaotrybOMhXmFZ1YREyZwHeNMsVPbAOg/pciqN5BxyuVw0ooIXZ7Q
 /7H+itfTDOA/EA4qQcTg4POXP+avR1PCduOfP5kivqjEfVB3ok6PlUs4HSSi2WKGkw5P
 9FJGBGXeOYtPqPGlh8mwKzV7NKsIWsCVCcZAnToLpYbwhYr9J+hnfYzwv+yw3dapSk45
 m54A==
X-Gm-Message-State: AOJu0YwwC8FP5UurzQ1ot9unUPPI2H7sMIJsEtOxcSsG1ycwwS5IbbAM
 WvRGneOWfGax9wK+pWAhRUIIahBliCyNGBgMujSTw2NsNVqbshX8/T9tjnYATv8L0a92EG5k+f2
 4SQo+y7EJ8cql96/tZmO//L/qUsg1ueTkYWCKeUyI7arX4nC0aCmb
X-Received: by 2002:a05:6a00:93a4:b0:6e0:93a3:cd04 with SMTP id
 ka36-20020a056a0093a400b006e093a3cd04mr17535692pfb.2.1708407573735; 
 Mon, 19 Feb 2024 21:39:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5ahf1blFEklGxtP061gOaseSLRfnBz6Vlc54ayr4kL3Nec613PgBNh/Or4TOcbb1iX9vpew==
X-Received: by 2002:a05:6a00:93a4:b0:6e0:93a3:cd04 with SMTP id
 ka36-20020a056a0093a400b006e093a3cd04mr17535679pfb.2.1708407573313; 
 Mon, 19 Feb 2024 21:39:33 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i188-20020a62c1c5000000b006e375ac0d8dsm5248698pfg.138.2024.02.19.21.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 21:39:33 -0800 (PST)
Date: Tue, 20 Feb 2024 13:39:23 +0800
From: Peter Xu <peterx@redhat.com>
To: Roman Khapov <rkhapov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, yc-core@yandex-team.ru
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
Message-ID: <ZdQ7C5dHIQsTVQE8@x1n>
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240215122759.1438581-2-rkhapov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 15, 2024 at 05:27:58PM +0500, Roman Khapov wrote:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
> -                      MIGRATION_STATUS_COMPLETED);
> +                      MIGRATION_STATUS_COMPLETED, NULL);

Instead of enforcing migrate_set_error() to always pass an error, maybe we
can allow migrate_generate_event() to fetch s->error in FAILED state, if
that hint ever existed?

-- 
Peter Xu


