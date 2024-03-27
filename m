Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B7AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTLY-0003WG-7m; Wed, 27 Mar 2024 09:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpTLT-0003RT-TW
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpTLS-0005tl-AP
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711546173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1R2fhnB6WSz93d8jDJMNiZ3/P8mtlL0m04nl8sywi7c=;
 b=D4ciQZL0tmXq5/NdIhhYSS3LYNpz3OVB2KINVFX7XrSbfVlpwF0evttOgbhaSvezwoHf3U
 OAl7PkJGbmf/gSSKi4929fZel8/VGBw6hglguQUpuUgagarq7TzSvKdyFE87GwNfJl+PlX
 8yKb0PSOMsz61dE4hiSxfCcvPD44+KE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-OXBsQmNnMUKnlZMPxr-TEQ-1; Wed,
 27 Mar 2024 09:29:30 -0400
X-MC-Unique: OXBsQmNnMUKnlZMPxr-TEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAD431C2CDE0;
 Wed, 27 Mar 2024 13:29:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5235D200A384;
 Wed, 27 Mar 2024 13:29:28 +0000 (UTC)
Date: Wed, 27 Mar 2024 13:29:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, pbonzini@redhat.com,
 devel@lists.libvirt.org, richard.henderson@linaro.org,
 mst@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <ZgQfMq2gJuWurl3K@redhat.com>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
 <ZgP5x3ECYGevla1-@redhat.com>
 <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
 <ZgQdjX_G9FzpOx6n@redhat.com>
 <CAFEAcA-K30KZndNK-sfUKjsE7ATMNpNUgpPZY-5YEpxL3BoeLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-K30KZndNK-sfUKjsE7ATMNpNUgpPZY-5YEpxL3BoeLA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Wed, Mar 27, 2024 at 01:27:58PM +0000, Peter Maydell wrote:
> On Wed, 27 Mar 2024 at 13:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 02:09:17PM +0100, Igor Mammedov wrote:
> > > On Wed, 27 Mar 2024 10:49:43 +0000
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > It's question of whether we are willing to do unthinkable,
> > > i.e. to break QEMU <-> guest ABI for isapc case by removing
> > > corresponding fwcfg entries.
> >
> > There has never been any ABI stability requirement for 'isapc'
> > as it is not a versioned machine type.
> >
> > > With migration ignored it shouldn't be a problem.
> > > Question is: does anyone care about migration with isapc?
> > > If not, I'd gladly axe smbios legacy parts in 9.1
> >
> > Migration is irrelevant unless someone steps forward to
> > commit to long term versioning of the machine type.
> 
> But migration is also how we implement savevm/loadvm,
> which are useful even when the machine type is not versioned.
> So please don't put in migration blockers or similar that would
> break that.

Yep, that's valid use case within the scope of a single QEMU release.
We just can't guarantee it across versions. Often it'll probably work
but it is liable to break at times.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


