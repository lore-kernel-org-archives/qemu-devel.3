Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8BACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUhmB-0004mU-33; Wed, 03 Jun 2026 05:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUhm9-0004mJ-3J
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUhm7-00059J-JV
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780478434;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vJkS/WQSHXpBBxfFQmedWtX+EEJluh8gbx1c3DtuRc=;
 b=YuEdzRYh8V+KM4N2921+9jMXmqBtLSk+pp9FmBoHVfXzcA3+1fQ31U3IcRv19h9EfSuTft
 UKlnSGcfm+sb0LEo6D73CYwhjZrG2iLdx4MMKmIQlcC9LSK0JcrL6S9SGpttRVGVAqXTwZ
 BSJ19Qmut0UqqgkpmuRhqlShPvOEBqg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Xr2NFxiPP5SfiD7CkCmZkw-1; Wed,
 03 Jun 2026 05:20:30 -0400
X-MC-Unique: Xr2NFxiPP5SfiD7CkCmZkw-1
X-Mimecast-MFC-AGG-ID: Xr2NFxiPP5SfiD7CkCmZkw_1780478429
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCE621800350; Wed,  3 Jun 2026 09:20:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83B56180049F; Wed,  3 Jun 2026 09:20:27 +0000 (UTC)
Date: Wed, 3 Jun 2026 10:20:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Transfer FW schema specs section to
 Daniel
Message-ID: <ah_x1_qZmHSvuh0-@redhat.com>
References: <20260519173014.98967-1-philmd@linaro.org>
 <20260519173014.98967-2-philmd@linaro.org>
 <4a1446f7-4867-46fe-ab80-6dbca9d4956d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a1446f7-4867-46fe-ab80-6dbca9d4956d@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 02:09:17PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> Could you Ack this change?

Acked-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> On 19/5/26 19:30, Philippe Mathieu-Daudé wrote:
> > Pass the torch to Daniel, but demote the 'Firmware schema
> > specifications' section from 'Maintained' to 'Odd fixes'.
> > 
> > Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   MAINTAINERS | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 85651cf2a18..0ba6391dea6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4004,10 +4004,9 @@ F: docs/specs/fsi.rst
> >   F: tests/qtest/aspeed_fsi-test.c
> >   Firmware schema specifications
> > -M: Philippe Mathieu-Daudé <philmd@linaro.org>
> > -R: Daniel P. Berrange <berrange@redhat.com>
> > +M: Daniel P. Berrange <berrange@redhat.com>
> >   R: Kashyap Chamarthy <kchamart@redhat.com>
> > -S: Maintained
> > +S: Odd fixes
> >   F: docs/interop/firmware.json
> >   EDK2 Firmware
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


