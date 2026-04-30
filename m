Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B38CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMH7-0001bj-Sf; Thu, 30 Apr 2026 03:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIMGj-0001Xg-V4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIMGi-0000bW-D2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777535827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMUHqV3/S1OCEN/Z1Bk3oZqV9TG8An88Wv5LTmQ2pgg=;
 b=cgbegOc/gRkXYvsgw38nmulyJi4SEc6FTU0Wxv1oQK1I0773R7fc5wM0dGhpIzmLNwJvi+
 VMJwMbcnA9QFtC+EelTFQnj2KCYvTXhYdlNx/xww14m3mQ08Lg6Gfb/wiiGymLilpPVrip
 XIaoO4c25vf7E/qacTn+rVrqQFlUMS0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Uoqh6XwYMLqDFwT4Q7l_xg-1; Thu,
 30 Apr 2026 03:57:05 -0400
X-MC-Unique: Uoqh6XwYMLqDFwT4Q7l_xg-1
X-Mimecast-MFC-AGG-ID: Uoqh6XwYMLqDFwT4Q7l_xg_1777535824
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABB8218001FB
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:57:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C7B9300019F; Thu, 30 Apr 2026 07:57:02 +0000 (UTC)
Date: Thu, 30 Apr 2026 08:56:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/9] qom: add trace events for object/property lifecycle
Message-ID: <afMLSxSx6_6qX2hs@redhat.com>
References: <20260429210830.594724-1-berrange@redhat.com>
 <20260429210830.594724-2-berrange@redhat.com>
 <177749881568.809163.3651828558097466353.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177749881568.809163.3651828558097466353.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Apr 30, 2026 at 01:40:15AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 29 Apr 2026 22:08:22 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/qom/object.c b/qom/object.c
> > index f981e270440..b99da7309db 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -714,6 +720,7 @@ static Object *object_new_with_type(Type type)
> >      object_initialize_with_type(obj, size, type);
> >      obj->free = obj_free;
> >  
> > +    trace_object_new(obj, obj ? obj->class->type->name : "(null)");
> 
> It looks like there should be an assert(obj != NULL) after qemu_memalign() instead.

qemu_memalign aborts on OOM.  This "obj ? .. : .." check was a mistake,
copy+pasted from the dynamic cast trace events.

With regards,
Daniel


