Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AB4FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMEq-0000jJ-JD; Thu, 30 Apr 2026 03:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIMER-0000eu-1M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIMEO-0008NX-Dv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777535677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iI9YM6eedaHPqJ5PzVHEvplFKMdAkmMS50r3AaQ/KZg=;
 b=dEKT1DE2NbmR/yJ8181Uq1q48jJHuN22M3dDVpB/5K2N3YFhO0kYy0NFdKCVv4GGiwJnuY
 zg93SsETZaXHGV364RexR2dcUVXsr7iliQNFWWjaAEDJw2VBqB1Fycd7NFGtlhGFJiuDjf
 9d5kw5nsw2tu0rxkeWZOphsNTPvu5sw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-zlBN439oPAazxMuzO_Suig-1; Thu,
 30 Apr 2026 03:54:35 -0400
X-MC-Unique: zlBN439oPAazxMuzO_Suig-1
X-Mimecast-MFC-AGG-ID: zlBN439oPAazxMuzO_Suig_1777535674
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71312195604F
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:54:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23AE119560A6; Thu, 30 Apr 2026 07:54:32 +0000 (UTC)
Date: Thu, 30 Apr 2026 08:54:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 9/9] qom: drop user_creatable_add_type method
Message-ID: <afMKtQ12egtJu4Va@redhat.com>
References: <20260429210830.594724-1-berrange@redhat.com>
 <20260429210830.594724-10-berrange@redhat.com>
 <177749881571.809163.14770089192117728910.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177749881571.809163.14770089192117728910.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 30, 2026 at 01:40:15AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 29 Apr 2026 22:08:30 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index e0a3cd8d0f7..7080f85f95f 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -44,75 +44,11 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
> > [ ... skip 14 lines ... ]
> > -        error_append_hint(errp, "Identifiers consist of letters, digits, "
> > -                          "'-', '.', '_', starting with a letter.\n");
> > -        return NULL;
> > -    }
> > -
> > -    klass = module_object_class_by_name(type);
> 
> object_new_with_props*() does not load from module. I don't think it
> matters for now (module objects are not user-creatable?), but is this
> intended?

No, that is an over-sight. This was not supposed to loose any
functionality. We should allow user creatable objects to be
put into modules.

With regards,
Daniel


