Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557E0CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 07:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSrVE-0003t5-OT; Fri, 29 May 2026 03:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSrVD-0003sM-D0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:19:31 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSrV9-0004TL-Vr
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:19:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 98F24C01EB;
 Fri, 29 May 2026 10:19:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:42a::1:0] (unknown [2a02:6bf:8080:42a::1:0])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id MJVx9i0XduQ0-sZk2Han5; Fri, 29 May 2026 10:19:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1780039162;
 bh=vMAkBig7buka1b72YTDQLWvUsaJVfTMQ9SIBANMYKLI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=r0AfO0H7YQJ4AGsHo3XSGFSZHqkUvRF82SjbMQwEtAU7l5dSEOWzxtM8qe4R6SSto
 MpvzSB7eCFyD1vYRWGr1vtusXzUf667Qajmqw1Pfwu2ofaLzzp/pmlpDr4BQaOBlGH
 5FS9vlOroEv45O2oJ0HXM5D2ePrvTLLXnDeUMWT0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4f0f12ec-504e-45c6-b53f-e7567bb46b34@yandex-team.ru>
Date: Fri, 29 May 2026 10:19:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with -incoming
 config:*
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260528212947.368132-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29.05.26 00:29, Peter Xu wrote:
> QEMU doesn't yet have a good way to specify migration parameters so that
> they can be available even during early stage of QEMU boots.  It is because
> the migration object (who owns the migration parameters) will only be
> created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
> reading migration parameters is illegal.
> 
> However, QEMU does have special use cases for such, namely only-migratable
> flag, and cpr-transfer. Recently, we have one more possible user to read a
> to-be-introduced new migration parameters during backend initialization
> phase.  We can introduce yet another global variable (or per-device
> parameter) to bypass this limitation, but we can also seek for a generic
> solution that we can setup migration parameters very early, even during
> backend initializations.
> 
> See this discussion for more details on the context of the problem:
> 
>    https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local
> 
> This patch wants to take the latter approach.
> 
> As a start, introduce a new way to specify migration parameters in QEMU
> boot commandline, as proposed in the above discussion:
> 
>    -incoming config:key1=value1,key2=value2,...

Do I understand correctly, that with qobject_input_visitor_new_str(),
it automatically suuport also json-like syntax

      -incoming config:'{"key1": "value1", "key2": {some more complex structure}}'

?

> 
> When specified, QEMU will parse a string formatted MigrationParameters and
> keep it.  When migration object is created, it will apply all the settings
> as initial value.
> 
> Since the application of boot parameters will be after object_new()
> completes, it means it happens after all machine compat properties or
> -global settings (which should be done during instance_post_init()).

[..]

>       to issuing the migrate\_incoming to allow the migration to begin.
> +
> +``-incoming config:key1=value1[,key2=value2,...]``
> +
> +    Specify migration parameters in QEMU commandlines, so that these
> +    parameters will be available even during very early boot of QEMU.
> +    They will be applied properly after QEMU boots and when the migration
> +    core is initialized.  From that POV, it has similar effect as setting
> +    these parameters using QMP command ``migrate-set-parameters`` or HMP
> +    command ``migrate_set_parameter``.
> +
>   ERST
>   
>   DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \

So, to have a "defer" migration with preset parameter, I need two options

     -incoming defer -incoming config:key=val

right?

-- 
Best regards,
Vladimir

