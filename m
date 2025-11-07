Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A318CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 20:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHShS-0004u4-2K; Fri, 07 Nov 2025 15:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vHShP-0004tu-AS
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 15:04:43 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vHShL-0003Q4-Ha
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 15:04:43 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7C13080871;
 Fri, 07 Nov 2025 23:04:35 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d76::1:1a] (unknown
 [2a02:6bf:8080:d76::1:1a])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id X4ukDf0FGa60-niVpmvr3; Fri, 07 Nov 2025 23:04:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762545874;
 bh=VeZqrtpwvHu8z5ivhULQYo7JwxUqu5IrZ9qTHo59bsU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=R38jFUmXdYGZk3mxyg43MfXzmHlWzHvA5TO8NoVWKmL2RyX9BfhmPKgy2GClkOMdM
 tG4osDZJghQdnvwVXjqeCnkY9qYzG/4gyCbtfaTJbFwV+Z8GXO9FS+y4yEaVzdPsiT
 46iE0e8IZNMplBG7GNMR8kh1xyj14YOweHgVm4ew=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c32d8bb5-8572-47b6-92fa-307ededef2b4@yandex-team.ru>
Date: Fri, 7 Nov 2025 23:04:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251104101715.76691-1-vsementsov@yandex-team.ru>
 <20251104101715.76691-8-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251104101715.76691-8-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 04.11.25 13:17, Vladimir Sementsov-Ogievskiy wrote:
> For further vhost-user-blk backend-transfer migration realization we
> want to give it (vhost-user-blk) a possibility (and responsibility) to
> decide when do connect.
> 
> For incoming migration we'll need to postpone connect at least until
> early stage of migrate-incoming command, when we already know all
> migration parameters and can decide, are we going to do incoming
> backend-transfer (and get chardev fd from incoming stream), or we
> finally need to connect.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   chardev/char-fe.c                   | 22 +++++++++++++++++++---
>   hw/core/qdev-properties-system.c    | 26 +++++++++++++++++++++++---
>   include/chardev/char-fe.h           |  9 +++++++--
>   include/hw/qdev-properties-system.h |  3 +++
>   4 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 504c3653e5..349b462e14 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -189,13 +189,24 @@ bool qemu_chr_fe_backend_open(CharFrontend *c)
>       return c->chr && c->chr->be_open;
>   }
>   
> -bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
> +bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,
> +                         Error **errp)
>   {
>       unsigned int tag = 0;
>   
>       if (s) {
> -        if (!qemu_chr_connect(s, errp)) {
> -            return false;
> +        if (connect) {
> +            if (!qemu_chr_connect(s, errp)) {
> +                return false;
> +            }
> +        } else {
> +            /* DEFINE_PROP_CHR_NO_CONNECT */
> +            if (!s->connect_postponed) {
> +                error_setg(errp,
> +                           "Chardev %s does not support postponed connect",
> +                           s->label);

Hmm this means, that vhost-user-blk will not support other backends at all. That's wrong.

We don't need this error-out. This chack should be done later, when user will try to
start backend-transfer migration for unsupporting backend.

> +                return false;
> +            }
>           }
>   
>           if (CHARDEV_IS_MUX(s)) {
> @@ -218,6 +229,11 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
>       return true;
>   }
>   
> +bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
> +{
> +    return qemu_chr_fe_init_ex(c, s, true, errp);
> +}
> +
>   void qemu_chr_fe_deinit(CharFrontend *c, bool del)
>   {
>       assert(c);
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 7aa5cbb510..9803e582e9 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -266,8 +266,8 @@ static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>       g_free(p);
>   }
>   
> -static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
> -                    Error **errp)
> +static void do_set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
> +                       bool connect, Error **errp)
>   {
>       ERRP_GUARD();
>       const Property *prop = opaque;
> @@ -297,13 +297,25 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>       if (s == NULL) {
>           error_setg(errp, "Property '%s.%s' can't find value '%s'",
>                      object_get_typename(obj), name, str);
> -    } else if (!qemu_chr_fe_init(fe, s, errp)) {
> +    } else if (!qemu_chr_fe_init_ex(fe, s, connect, errp)) {
>           error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
>                         object_get_typename(obj), name, str);
>       }
>       g_free(str);
>   }
>   
> +static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
> +                    Error **errp)
> +{
> +    do_set_chr(obj, v, name, opaque, true, errp);
> +}
> +
> +static void set_chr_no_connect(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    do_set_chr(obj, v, name, opaque, false, errp);
> +}
> +
>   static void release_chr(Object *obj, const char *name, void *opaque)
>   {
>       const Property *prop = opaque;
> @@ -320,6 +332,14 @@ const PropertyInfo qdev_prop_chr = {
>       .release = release_chr,
>   };
>   
> +const PropertyInfo qdev_prop_chr_no_connect = {
> +    .type  = "str",
> +    .description = "ID of a chardev to use as a backend",
> +    .get   = get_chr,
> +    .set   = set_chr_no_connect,
> +    .release = release_chr,
> +};
> +
>   /* --- mac address --- */
>   
>   /*
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 5f8a6df17d..c0d991a19f 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -25,14 +25,19 @@ struct CharFrontend {
>   };
>   
>   /**
> - * qemu_chr_fe_init:
> + * qemu_chr_fe_init(_ex):
>    *
>    * Initializes the frontend @c for the given Chardev backend @s. Call
>    * qemu_chr_fe_deinit() to remove the association and release the backend.
> + * Call qemu_chr_connect(), except for the case when connect=false
> + * parameter set for _ex() version, or when @s == NULL. For the latter,
> + * @connect is ignored.
>    *
>    * Returns: false on error.
>    */
> -bool qemu_chr_fe_init(CharFrontend *c, Chardev *be, Error **errp);
> +bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp);
> +bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,
> +                         Error **errp);
>   
>   /**
>    * qemu_chr_fe_deinit:
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index 45687be005..18ad2e6519 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -7,6 +7,7 @@ bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
>                                          Error **errp);
>   
>   extern const PropertyInfo qdev_prop_chr;
> +extern const PropertyInfo qdev_prop_chr_no_connect;
>   extern const PropertyInfo qdev_prop_macaddr;
>   extern const PropertyInfo qdev_prop_reserved_region;
>   extern const PropertyInfo qdev_prop_multifd_compression;
> @@ -39,6 +40,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
>   
>   #define DEFINE_PROP_CHR(_n, _s, _f)             \
>       DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharFrontend)
> +#define DEFINE_PROP_CHR_NO_CONNECT(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_chr_no_connect, CharFrontend)
>   #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
>       DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
>   #define DEFINE_PROP_DRIVE(_n, _s, _f) \


-- 
Best regards,
Vladimir

