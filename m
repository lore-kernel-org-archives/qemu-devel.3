Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D758C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0Dc-0000e8-7c; Fri, 28 Feb 2025 08:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1to0DU-0000aK-6T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1to0DS-0000xC-84
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740748544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6JMaj9j2O86uhiFdC6ppo04X+t7JhWgnnd+RqtcVto=;
 b=ay77okmOCHIYJSpgaGNjrgUrz6nNkdilm1GfCg6ndo9PUdE8fsgVGIUlxoS8cxYSsbTVBh
 fVeQg9pu/ijqnWxUlu3FLthycHQFwTW4N5GAARaJCmSboeW4JU90vg7ZuZUjp22KBqcTH0
 RpshFnEt82sotIXsM0hdheOjRbSyHVs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-sqqHH1bxP-Skgls4R3pG_A-1; Fri,
 28 Feb 2025 08:15:38 -0500
X-MC-Unique: sqqHH1bxP-Skgls4R3pG_A-1
X-Mimecast-MFC-AGG-ID: sqqHH1bxP-Skgls4R3pG_A_1740748537
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 300A21918165; Fri, 28 Feb 2025 13:15:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.2.18.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B738300019E; Fri, 28 Feb 2025 13:15:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0C84418000A3; Fri, 28 Feb 2025 14:15:33 +0100 (CET)
Date: Fri, 28 Feb 2025 14:15:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Joerg Roedel <jroedel@suse.com>
Subject: Re: [PATCH v7 11/16] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Message-ID: <r6fcgeskptvajnedlzlggmxrrmvhrw3fbu7lj2sogdtnjbmcgl@aq3p5z3u5746>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <61dd66de.AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2@mailjet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61dd66de.AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2@mailjet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 27, 2025 at 02:29:29PM +0000, Roy Hopkins wrote:
> Create an enum entry within FirmwareDevice for 'igvm' to describe that
> an IGVM file can be used to map firmware into memory as an alternative
> to pre-existing firmware devices.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

This should Cc'ed to the libvirt list because libvirt consumes
these files.

take care,
  Gerd


