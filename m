Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7944C79FBC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkJX-0001N3-0O; Fri, 16 Jan 2026 08:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgkJV-0001FB-9Q
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgkJT-0002na-Fc
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768571786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDgsnbCjZSjeVu1hpP6d6FhdLzhsZjFvvfTvLOOf90g=;
 b=gRDJXTA2vup9y7IBP8V8oGSyHKSs4+Eglsf9/fNcdwNRuZ47iv2WeS+nEYaLk/3K1UX1yn
 NahAXCFOsWbfZebxvoq3DXWPiXPjddTxxNUEREdKlNCskMarFZ+t+sgGqC0y6Rmoqa1jUI
 Z6ZvnhhbmU5fSOVqgRjzKGf6a3LOHGk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-xBcenYFgPfCypc0e9jCNWQ-1; Fri, 16 Jan 2026 08:56:25 -0500
X-MC-Unique: xBcenYFgPfCypc0e9jCNWQ-1
X-Mimecast-MFC-AGG-ID: xBcenYFgPfCypc0e9jCNWQ_1768571784
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34cc88eca7eso1736871a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768571784; x=1769176584; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uDgsnbCjZSjeVu1hpP6d6FhdLzhsZjFvvfTvLOOf90g=;
 b=HwrpWLWgFROmKH3ZjAXTMpZ6At3kuwpEUblphofcg5GS9v0u6sk52mC7BFKA6ENrf3
 USikO46yRT5Bd4FGlGDaRJ4o2DM98f09HMo6BdT6VyksBDSu+4Xd+Dmk0ZzvTnbCVqTP
 /ok7CsQwrxWiN0ER/y6kruSubp+0yB/Drz/lBaWn7YoehY7Lq5j8Pv0y/UFiXgk1/ps2
 rH7EkLZYp+MtI9Lbj1sU/AutMirj97qjS0oPoQjV+ESaNWRWqr69lI6XyUv3j1tN8WDf
 BMyEL1tU3wiwTttJaQDXdWnAdOrGyBHbpGLwduWol/R0ZIJ0gj6dCMSht9qiasdJGizz
 xtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768571784; x=1769176584;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDgsnbCjZSjeVu1hpP6d6FhdLzhsZjFvvfTvLOOf90g=;
 b=p/tbutif2WhPYSWezn+7L+JybBvuj66ooHV76qy1vzz5Fy1iTFPYtJUVZ/OKpWjPVc
 P882v1Ef32T1pPpFCJ7PnvzxvbAERP7fo5+7adkfyyIJr9EO6jI4IRSKzcqtN2tSpQkc
 lCII8NJIcfOSHiwbUnrkETTq9r86CJ5hosU9JAkGldVMc2Hvx28yRruw5thuM2cUSDZb
 NpTRfAlZaIGJ5xaRRwRJrOJh2ToTcYQ+q+UmDm7cRtw6xDwnxsdepBBvHWHCrn9sPp7+
 T4QwrQpz6EpWFr0WQFw8BShFLN4AI69Dw6thDJz0qDoANjaKzSfOHRkyrXb1unovjL0+
 jMyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmPHbmBpNpTcbbOV3Axhj4QqBAe9Pl2UhBG7BUt9Ndsk1rnAypO7d/rhDuWh7Rp76SKrIYUO63O/pQ@nongnu.org
X-Gm-Message-State: AOJu0Yz7DNGUYYoXswAWbZExJ/1Ngj/KoYOHlHIZiNfO/mxveJV3c2qF
 FCCw/JXokj410dUM0NKJpwGWiU31NV7NqBfXL/ni8+Ef+VADwZ+hpcdn7R4xNkjFS79LOS0Bxec
 w3jmVLLJjtZBe4kcqsxahGn/VpA7cIe5/yZkRNxxKWP765u9GXyLNbmK+
X-Gm-Gg: AY/fxX79VHCWPVu36SJTtbqTwX9cTS6YRW/m1zcoDTKkb4kTPmOt5zTpO+necQ1B4At
 caD/piz7gchhDzi/oMQLauRtim5aUCd5lfT2nJtLVrkspIyiI0PkrhYg2Li+RjL8p94vtpfTsse
 T3dqx4aDFvYM2VFYtNj3iRyofaZ4P07dfJdUUVHOZMk4QbocagrABoGOKg5E1QtJo3r2VGJaehD
 j8bJBvQyOs86qcRT2ph8MUeWpb+4oNIWaaH2sXAZXp0iWK7saFOdq+vtKPn1Os1wGN8f4irgza/
 3Iuu8C/TmVVMDo+E3+DwgLNQFy7V1fw8uiUAYHSarMVgOmCbJtVrPG7WKuREHPA7+xhfS/BcCDD
 UDJ4=
X-Received: by 2002:a17:90b:4e87:b0:349:8116:a2d8 with SMTP id
 98e67ed59e1d1-35272ef87fcmr2618939a91.7.1768571784211; 
 Fri, 16 Jan 2026 05:56:24 -0800 (PST)
X-Received: by 2002:a17:90b:4e87:b0:349:8116:a2d8 with SMTP id
 98e67ed59e1d1-35272ef87fcmr2618917a91.7.1768571783758; 
 Fri, 16 Jan 2026 05:56:23 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35273470a6fsm843347a91.3.2026.01.16.05.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 05:56:23 -0800 (PST)
Date: Fri, 16 Jan 2026 08:56:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWpDfUNbt_V-ipQo@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWoJAz_GLXzqs_oH@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWoJAz_GLXzqs_oH@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 16, 2026 at 09:46:43AM +0000, Daniel P. Berrangé wrote:
> On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > > Nack.
> > > > 
> > > > This code has users, as explained in my other email:
> > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> > > 
> > > Please then rework that series and consider include the following (I
> > > believe I pointed out a long time ago somewhere..):
> > > 
> > 
> > > - Some form of justification of why multifd needs to be enabled for COLO.
> > >   For example, in your cluster deployment, using multifd can improve XXX
> > >   by YYY.  Please describe the use case and improvements.
> > 
> > That one is pretty easy; since COLO is regularly taking snapshots, the faster
> > the snapshoting the less overhead there is.
> 
> Also if we ever want to be able to deprecate the non-multifd migration,
> then we need to ensure multifd migration has the super-set of functionality.

IIUC there's still long way to go for that, and I'm not yet sure if it will
happen..

To achieve it, we'll need to first remove/deprecate multifd capability,
because as long as it's there people can still set it to OFF..

But before that, we'll need to figure out how to do with features
non-trivial to be supported, at least RDMA (it turns out we decided to keep
RDMA, prior to this COLO discussion), and "fd:" URIs.

I still don't know if we can justify nobody will be using some handy
streaming tooling with QEMU migration, in that case it'll never work with
multifd because multifd (even if channels=1) requires two sessions; there's
always the main channel.

So I'd put that aside when considering what we'd do with COLO.  In that
case IIUC COLO is the easy part if we really want to always use multifd.

Thanks,

-- 
Peter Xu


