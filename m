Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12230C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkheX-0007lo-Vx; Fri, 17 Jul 2026 08:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkheW-0007lg-Pp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkheU-0007hF-SX
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784291209;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DU5qruqQQOFhkusDS3qUu/Cd0ORu7Lfg5fhf+h24+ZA=;
 b=cNAsBHmS4OR/QXfJ+QvMkHUlP6/d8V3xVoL5kKRbkHigj/466gf3wIOQk0WLac24emRtzU
 Qsxm9NYi2+V70xCrfp+pifAcxE0PBWcdLwPkijkT42ORuLSVKYP8EnTL5fofnfQkeEj7q6
 TYE00KDgBu3sqFvg2KG0FQcFawMKBbA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-6Co3EqFZO3e85GNmjfSq3w-1; Fri,
 17 Jul 2026 08:26:48 -0400
X-MC-Unique: 6Co3EqFZO3e85GNmjfSq3w-1
X-Mimecast-MFC-AGG-ID: 6Co3EqFZO3e85GNmjfSq3w_1784291206
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 995161955E9C; Fri, 17 Jul 2026 12:26:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 384651956049; Fri, 17 Jul 2026 12:26:41 +0000 (UTC)
Date: Fri, 17 Jul 2026 13:26:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] qom/object.h: add missing documentation for
 object_class_* property functions
Message-ID: <aloffnKdpvj_2XzU@redhat.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
 <20260717112022.444367-5-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717112022.444367-5-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 17, 2026 at 12:19:11PM +0100, Mark Cave-Ayland wrote:
> This is so that the object_class_* property functions appear in the generated
> QOM documentation at devel/qom-api.html.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/qom/object.h | 140 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fc..95fdf01e30 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1818,6 +1818,37 @@ ObjectProperty *object_property_add_link(Object *obj, const char *name,
>                                              Object *val, Error **errp),
>                                ObjectPropertyLinkFlags flags);
>  
> +/**
> + * object_class_property_add_link:
> + * @oc: the object class to add a property to
> + * @name: the name of the property
> + * @type: the qobj type of the link
> + * @offset: the offset from the object instance where the link object reference
> + *   is stored
> + * @check: callback to veto setting or NULL if the property is read-only
> + * @flags: additional options for the link
> + *
> + * Links establish relationships between objects.  Links are unidirectional
> + * although two links can be combined to form a bidirectional relationship
> + * between objects.
> + *
> + * Links form the graph in the object model.
> + *
> + * The @check() callback is invoked when object_property_set_link() is called
> + * and can raise an error to prevent the link being set. If @check is NULL, the
> + * property is read-only and cannot be set. Care must be taken to handle NULL
> + * values for @val.
> + *
> + * Ownership of the pointer that @child points to is transferred to the
> + * link property.  The reference count for *@child is
> + * managed by the property from after the function returns till the
> + * property is deleted with object_property_del().  If the
> + * @flags %OBJ_PROP_LINK_STRONG bit is set,
> + * the reference count is decremented when the property is deleted or
> + * modified.

Copy+paste mistake I presume - object_class_property_add_link does not
have a @child property, as this is only declaring the property on the
class, not setting the link's value on the object.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


