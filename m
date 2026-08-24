Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F28C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUCg-0007Kb-EK; Mon, 24 Aug 2026 08:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUCe-0007Js-Rg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUCc-0005Fp-Qg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787576101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxzsloYyRenkWCLBll3xFF8LX9NlcG/cXusr+k3ZNMY=;
 b=NUN0RAetCasvQ96l7HKRNKYEE7fZJpBfov2FyAM8jqxJkKLD+m0J+qOnXkbig1z4q9c3qm
 zpMo6FXrGyjyxwhtkPBs2Ud2cMqnPBUSQqEJreLqgKLw0U6bt9K/g69kXczWxihfrvwhPS
 qGHDflR8rBJQwKGEK8MyJwTiILfQzVY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-XuPkCe_DM2-O5vXk1Hj9dQ-1; Mon,
 24 Aug 2026 08:53:30 -0400
X-MC-Unique: XuPkCe_DM2-O5vXk1Hj9dQ-1
X-Mimecast-MFC-AGG-ID: XuPkCe_DM2-O5vXk1Hj9dQ_1787576009
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE7DB195F178; Mon, 24 Aug 2026 12:53:28 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C55281800605; Mon, 24 Aug 2026 12:53:25 +0000 (UTC)
Date: Mon, 24 Aug 2026 13:53:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 10/16] qom/object.c: add
 object_class_property_add_bool_ptr()
Message-ID: <aow-wlxrMnOS8Vqv@redhat.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-11-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821111550.276011-11-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 21, 2026 at 12:14:22PM +0100, Mark Cave-Ayland wrote:
> This adds a class property that references a bool within the object instance
> and is intended to be used as a replacement for object_class_property_add_bool()
> where possible.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qom/object.h | 18 ++++++++++++++++++
>  qom/object.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 8dead29284..de37016ba8 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2017,6 +2017,24 @@ typedef enum {
>      OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
>  } ObjectPropertyFlags;
>  
> +/**
> + * object_class_property_add_bool_ptr:
> + * @klass: the object class to add a property to
> + * @name: the name of the property
> + * @offset: the offset from the object instance where the bool value is
> + *   stored
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an boolean property in memory.  This function will add a
> + * property of type 'bool'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
> +                                         const char *name,
> +                                         ptrdiff_t offset,
> +                                         ObjectPropertyFlags flags);
> +
>  /**
>   * object_property_add_uint8_ptr:
>   * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index f91764aaa7..635eeeac77 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2750,6 +2750,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
>  #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
>  
>  
> +static void property_class_get_bool_ptr(Object *obj, Visitor *v,
> +                                        const char *name,
> +                                        void *opaque, Error **errp)
> +{
> +    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void property_class_set_bool_ptr(Object *obj, Visitor *v,
> +                                        const char *name,
> +                                        void *opaque, Error **errp)
> +{
> +    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}

Am I missing the reason why we can't use

  DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(bool)

?  If so, could that be mentioned in the commit message.

> +
> +ObjectProperty *
> +object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
> +                                   ptrdiff_t offset,
> +                                   ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_class_get_bool_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_class_set_bool_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "bool",
> +                                     getter, setter, NULL, (void *)offset);
> +}
> +
>  ObjectProperty *
>  object_property_add_uint8_ptr(Object *obj, const char *name,
>                                const uint8_t *v,
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


