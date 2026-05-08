Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A303ECD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNUn-0001N6-Jq; Fri, 08 May 2026 11:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLNUl-0001Mj-9U
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLNUj-0006j3-SH
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778255524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C58C/P1BozxEi3Psf04mIm4m4RDcY5Ql9Iee4XI1/tk=;
 b=XYnjTTXQd6I/+L1tu1aXVTF5t/yF9lBaJyMd0XmWGeATa7ALo3diwp+X+TZwXwdDRoQq0x
 9rymWf+Sf0OqOc5E9SD6RK8yce4fy/Eh4xhF3joGBM36IKgW0pcKIEZ83egSwnIHClZ/Pn
 7W5wxrpwblerP9SCAUcfYGvzM1HIm3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-on6BqGVPNN-dwX4VJCCQFQ-1; Fri,
 08 May 2026 11:52:02 -0400
X-MC-Unique: on6BqGVPNN-dwX4VJCCQFQ-1
X-Mimecast-MFC-AGG-ID: on6BqGVPNN-dwX4VJCCQFQ_1778255522
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC9B8195609F; Fri,  8 May 2026 15:52:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 374E33002D2F; Fri,  8 May 2026 15:51:59 +0000 (UTC)
Date: Fri, 8 May 2026 16:51:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 07/10] qom: add object_new_with_props_from_qdict
Message-ID: <af4GnFmd6Utll2DY@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-8-berrange@redhat.com>
 <177825350909.389613.8952282324650958656.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177825350909.389613.8952282324650958656.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Fri, May 08, 2026 at 07:18:29PM +0400, marcandre.lureau@redhat.com wrote:
> On Fri, 08 May 2026 12:24:26 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 1b2b2702fc9..cd59f1f1718 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -700,6 +700,25 @@ Object *object_new_with_propv(const char *typename,
> > [ ... skip 13 lines ... ]
> > + * properties in a QDict.
> > + */
> > +Object *object_new_with_props_from_qdict(const char *typename,
> > +                                         Object *parent,
> > +                                         const char *id,
> > +                                         QDict *props,
> 
> This should take a const QDict, same for the _parentless added later.

Ah yes, that would match the existing object_set_props_from_qdict
signature.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


