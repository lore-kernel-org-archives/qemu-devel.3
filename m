Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94112CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNNi-0007zc-Hx; Fri, 08 May 2026 11:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLNNh-0007zE-2l
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLNNf-0003ho-9E
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778255085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRvHiugCcD6cin9qKL+sq3NuLP+Gh97ZFQQzbTjK4ao=;
 b=KgtwTF4yRkebOH32GTwq4iEPmBGF4+lVQp9I5ta7sVAPe/IWXTVSvM8jMABWgy5kdK70TT
 Um76c436z6XY+iPMy6i10huesVYg7386d6VokGDQK0w5++LlkgTGP/IT70Xpj7wMrw9BRj
 1Riu7i4px4dUIdxMQMgIIiDr6THdpwM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-0Aoe1NWcNFqw7qoE5UI2Fg-1; Fri,
 08 May 2026 11:44:42 -0400
X-MC-Unique: 0Aoe1NWcNFqw7qoE5UI2Fg-1
X-Mimecast-MFC-AGG-ID: 0Aoe1NWcNFqw7qoE5UI2Fg_1778255081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D5AE1956089; Fri,  8 May 2026 15:44:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4779F1800347; Fri,  8 May 2026 15:44:38 +0000 (UTC)
Date: Fri, 8 May 2026 16:44:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 10/10] qom: drop user_creatable_add_type method
Message-ID: <af4E41PGQ9bks82q@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-11-berrange@redhat.com>
 <177825350910.389613.10759707468624591000.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177825350910.389613.10759707468624591000.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 08, 2026 at 07:18:29PM +0400, marcandre.lureau@redhat.com wrote:
> On Fri, 08 May 2026 12:24:29 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index e0a3cd8d0f7..7080f85f95f 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -44,75 +44,11 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
> > [ ... skip 25 lines ... ]
> > -    if (!object_class_dynamic_cast(klass, TYPE_USER_CREATABLE)) {
> > -        error_setg(errp, "object type '%s' isn't supported by object-add",
> > -                   type);
> > -        return NULL;
> > -    }
> > -
> 
> It's worth to mention in the commit message that -object and object-add
> go through QAPI ObjectOptions list, and thus don't need the
> now gone TYPE_USER_CREATABLE check.

Actually I hadn't taken that into account as it doesn't matter what
the caller does in this case.

In this user_creatable_add_type method, we needed a TYPE_USER_CREATABLE
check because the method later calls 'user_creatable_complete'
unconditionally.

In the new object_new_with_prop* methods, user_creatable_complete
is conditionally called only if a cast to TYPE_USER_CREATABLE
succeeds.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


