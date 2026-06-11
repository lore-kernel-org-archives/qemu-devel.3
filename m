Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B195CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjm7-0006KX-5W; Thu, 11 Jun 2026 14:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjm5-0006JF-Sl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjm3-0007ac-Sg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781201101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ezN+kAtIQ2A5KGxOj+qFbSPPUbOKbgFZgQc3byGRV8=;
 b=N0/4b/E2tVgdoJy8i92fzB/ln5+IuwPaWel3Q+3A2eShF+fqX5dGSocCeBVkkouYnSkBvo
 bBH7kkn+m38JsjsXDT3ivxcCN8T4nSk0gzLLtyy7Io9XtdSH7H09iqu877axdRDcdEIfe0
 HiRsQ12Ws4hPXUOCngk4nPXSflCydq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-byHPUjESNsW_B5tlKzGxTA-1; Thu,
 11 Jun 2026 14:04:58 -0400
X-MC-Unique: byHPUjESNsW_B5tlKzGxTA-1
X-Mimecast-MFC-AGG-ID: byHPUjESNsW_B5tlKzGxTA_1781201097
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB82A197701D; Thu, 11 Jun 2026 18:04:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F3A819540C5; Thu, 11 Jun 2026 18:04:52 +0000 (UTC)
Date: Thu, 11 Jun 2026 19:04:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 06/35] monitor: add 'chardev' property to Monitor base
 class
Message-ID: <air4wQp7LewEfBMu@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-7-berrange@redhat.com>
 <178112600325.209622.9037016260369859761.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178112600325.209622.9037016260369859761.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, Jun 11, 2026 at 01:13:23AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 10 Jun 2026 13:33:46 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index a497c25c543..1f1f5fe9fe3 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -77,10 +77,30 @@ OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
> > [ ... skip 14 lines ... ]
> > +
> > +static void monitor_set_chardev_id(Object *obj, const char *str, Error **errp)
> > +{
> > +    Monitor *mon = MONITOR(obj);
> > +
> > +    mon->chardev_id = g_strdup(str);
> 
> missing g_free(mon->chardev_id) before.

Yep, will add.

> 
> >
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 5231ed506a5..3a4e2ae0e7a 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -527,7 +527,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
> >      monitor_list_append(&mon->parent_obj);
> >  }
> >  
> > -void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
> > +void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
> >  {
> >      MonitorQMP *mon;
> >      static int counter;
> 
> Add ERRP_GUARD(), like monitor_new_hmp()

Will add.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


