Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04F7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQr1-0000ff-EU; Wed, 27 Mar 2024 06:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpQqz-0000aP-VC
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpQqy-0005iJ-Di
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711536595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItORnOPDjDn9Fd5IWsfZLSAJMDnQ7csuLL1Izr3fnEA=;
 b=Ln5kkllql8fPfLgIJNqsxHefFUEyf5Mdk3e9CyHJflp3tBsHD1XPiWY+DRn44LL1NjUoxF
 FshjpzSZxX+r1MozlTjhfJdGe2WKU4noRtCDZr4CzAj8Qtjx/Ab2oTAHHTT6aK/XSqoPrP
 8/dbs5FvHQ7M/3JRKj/7HynnkmitOO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-zxk44sPvN_WWWIEMhkRDgg-1; Wed, 27 Mar 2024 06:49:52 -0400
X-MC-Unique: zxk44sPvN_WWWIEMhkRDgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F4DB8007A1;
 Wed, 27 Mar 2024 10:49:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A85D72024517;
 Wed, 27 Mar 2024 10:49:49 +0000 (UTC)
Date: Wed, 27 Mar 2024 10:49:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, pbonzini@redhat.com,
 devel@lists.libvirt.org, richard.henderson@linaro.org,
 mst@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <ZgP5x3ECYGevla1-@redhat.com>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 05:16:32PM +0100, Igor Mammedov wrote:
> On Tue, 26 Mar 2024 14:29:58 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
> > Hi Igor,
> > 
> > On 26/3/24 14:08, Thomas Huth wrote:
> > > 
> > > s/iaspc/isapc/ in the subject
> > > 
> > > On 26/03/2024 13.51, Igor Mammedov wrote:  
> > >> ISAPC machine was introduced 25 years ago and it's a lot of time since
> > >> such machine was around with real ISA only PC hardware practically 
> > >> defunct.
> > >> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on 
> > >> RHEL9 host
> > >> in only TCG mode, while in KVM mode it hung in the middle of boot)  
> > 
> > I'm quite opposed to this patch. QEMU models various very-old /
> > defunct hardware. I'm pretty sure Bernhard and myself are OK to
> > keep maintaining it, besides we are working in separating it from
> > the i440fx+piix machine. Also, this machine is particularly
> > interesting for my single-binary experiments.
> 
> it would not be fair to ask you or Bernard to deal with every
> case where ISAPC related code gets in a way, nor it's fair to
> ask other contributors to ensure that their patches don't break
> semi-working ISAPC or refactor code that relates to it. 
> 
> [
> for example I'd like to refactor smbios parts in the image
> ACPI table builder, but the I'd have to do it for legacy
> part as well without means to verify that. Sure it can be
> done but at cost of extra time spent to rewrite something
> that would never be used and to find test env to verify
> touched code.
> ]

Is SMBIOS even relevant for isapc ? IIUC, the first SMBIOS spec
is from 1999, while PCI has been around since 1992.

IOW, we shouldn't even be exposing SMBIOS with the isapc
machine type. If we address that, then isapc has no impact
on your ability to refactor SMBIOS code.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


