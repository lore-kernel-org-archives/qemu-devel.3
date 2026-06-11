Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F11CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjtr-0003io-Ff; Thu, 11 Jun 2026 14:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjtq-0003iZ-5o
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjto-0005Hn-HP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781201583;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=813Zs8Dr0xFRLXVK+uxOr9CPEX6aiiy9NAAEj6pmwVQ=;
 b=cdipiwE/AAQS7Do4HxkISHLpoRxDpPof20FMDUlEr3si1ByjPYIXFFfGzesEJtiYMhRYjI
 US1tFjYuCikLqQJrJd2cK3EoqYwUkhmGNIN7s4PBCpIEq20kJ3UTFcjF07xDa143xiq1bE
 8QnIA/k+f82PiZcQYOAjj2KtDZNzUEM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-gWDm1R4LNguiQ7vrGen0lQ-1; Thu,
 11 Jun 2026 14:13:01 -0400
X-MC-Unique: gWDm1R4LNguiQ7vrGen0lQ-1
X-Mimecast-MFC-AGG-ID: gWDm1R4LNguiQ7vrGen0lQ_1781201580
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DCBF180123E; Thu, 11 Jun 2026 18:13:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17FCA1955BC4; Thu, 11 Jun 2026 18:12:56 +0000 (UTC)
Date: Thu, 11 Jun 2026 19:12:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 31/35] qom: add method for getting the "id" of a QOM
 object
Message-ID: <air6paJPVUJt-pkF@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-32-berrange@redhat.com>
 <178112600400.209622.3065709276056576577.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178112600400.209622.3065709276056576577.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 11, 2026 at 01:13:24AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 10 Jun 2026 13:34:11 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 11f55613fcd..c828ac63652 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1759,6 +1759,16 @@ ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
> >  ObjectProperty *object_property_add_child(Object *obj, const char *name,
> >                                            Object *child);
> >  
> > +/**
> > + * object_property_get_child_name:
> > + * @obj: the object that owns the property
> > + * @child: the object referenced by the child property
> > + *
> > + * Return the property name against which @child is registered
> > + * with @obj, or NULL if non is present
> 
> "non" -> "none"

I've decided it'll read better saying

  ", or NULL if @obj is not a parent of @child."


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


