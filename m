Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D894C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBmF-0004Rh-0k; Thu, 05 Jun 2025 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNBmC-0004Qv-EL
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNBm7-0006rD-II
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749134457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJdJobqKICCx+r3roHqY2p2wWYnZWEkrTeUkqT2LdRA=;
 b=dc+LBU+4jceb3TFlc/npJuou15LLR8PbXRAukY9GMg9qR47pC9RNWoXBVDS/WdPbx2a0ym
 8Cj97rxOToq7kwdXBPiIPI3cIOftcCdvL0Sfp/g6HmVUO4Ix+4u5bu2v1oMYbWST+JV6tg
 dhnwS60aUm5iiYO6dv3jFmp+OlcgAgc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-u4v2OS86MPe1zPdXDY1HvA-1; Thu,
 05 Jun 2025 10:40:55 -0400
X-MC-Unique: u4v2OS86MPe1zPdXDY1HvA-1
X-Mimecast-MFC-AGG-ID: u4v2OS86MPe1zPdXDY1HvA_1749134454
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 211B91801A00; Thu,  5 Jun 2025 14:40:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BC8D30002C0; Thu,  5 Jun 2025 14:40:50 +0000 (UTC)
Date: Thu, 5 Jun 2025 15:40:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
Message-ID: <aEGsbkhdT_k5JErg@redhat.com>
References: <20250605030351.2056571-1-shahuang@redhat.com>
 <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
 <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
 <2030db73-4f1e-46ed-98ea-c469e8b0ecea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2030db73-4f1e-46ed-98ea-c469e8b0ecea@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jun 05, 2025 at 04:24:07PM +0200, Cédric Le Goater wrote:
> On 6/5/25 14:21, Gerd Hoffmann wrote:
> >    Hi,
> > 
> > > > Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
> > > > the x86 need the vgabios-ramfb.bin, this can cause that when use the
> > > > release package on arm64 it can't find the vgabios-ramfb.bin.
> > 
> > > Simpler to directly pass the ROM path instead of using a boolean,
> > > so board (or CLI) could pass path to non-x86 rom.
> > 
> > The rom is loaded into a fw_cfg file which only seabios will look at.
> > So this rom logic is x86-specific.
> > 
> > edk2 ships an EFI driver for ramfb, that is how ramfb is used on !x86
> > platforms today, and I don't expect that to change.
> 
> Should we also set the vfio-pci::ramfb-romfile property to false in
> a compat property for ARM machines then ? I don't know for RISC-V and
> PPC.

Sounds like we'd be better setting the property to false by default,
and then special case x86 machine types to set it to true.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


