Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B54ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGu0M-00040v-3J; Wed, 14 Oct 2026 04:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGu0K-00040e-FG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGu0I-0000Fa-HY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791965184;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKoxGrxnOtx4Cgd1bSgg6WEvU9lIq6c47EHTMKne4hE=;
 b=TPvNZ0oJIyh++Xfs/3iY17fGBXY2GpCkcOQkm7HmDWO+6lDbdcqqlHG13VuJTT6BCSHCfV
 7kGtt5/bmUPUXP48/5Xi2qo916s0dqF/z5fDw2hIPzsCjmrmF42PRgeESLeDhT+1bcYC5O
 AEZbcZCxhqs97e698inys9bCShY3yA0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-dTm_niYsNe67m1lOVbqBuQ-1; Wed,
 14 Oct 2026 08:06:20 +0000
X-MC-Unique: dTm_niYsNe67m1lOVbqBuQ-1
X-Mimecast-MFC-AGG-ID: dTm_niYsNe67m1lOVbqBuQ_1791965179
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A3FC19560BA; Wed, 14 Oct 2026 08:06:18 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E90F195608A; Wed, 14 Oct 2026 08:06:15 +0000 (UTC)
Date: Wed, 14 Oct 2026 09:06:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v4 27/27] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Message-ID: <as839M8VjrWh4r2-@redhat.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-28-bin.meng@processmission.com>
 <72240455-9409-491e-84fe-f29efb7187a6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72240455-9409-491e-84fe-f29efb7187a6@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Wed, Oct 14, 2026 at 06:16:27AM +0200, Philippe Mathieu-Daudé wrote:
> On 14/10/26 03:23, Bin Meng wrote:
> > Conor asked not to be listed as a maintainer, since that could imply
> > that Microchip sponsors his work on the platform.
> 
> Hmm we hit a limitation of MAINTAINERS format.

I guess they're concerned about "Supported" vs "Maintained" as
the subsystem status

   Supported:   Someone is actually paid to look after this.
   Maintained:  Someone actually looks after it.

Technically that language means you should not assume that
all listed M: are paid - only that at least 1 M: is a paid
maintainer.  IMHO since Conor uses a non-corporate email
address there's even less reason to assume they're doing it
in a paid maintainer role, as opposed to volunteer.


> If so, the Sebastian is in the same situation.
> 
> (we had a similar case with PIIX3:hobbyist / PIIX4:cloud in the past)
> 
> > 
> > Keep him listed as a reviewer so he continues to receive relevant
> > patches without suggesting an active maintenance commitment.
> > 
> > Suggested-by: Conor Dooley <conor@kernel.org>
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > Acked-by: Conor Dooley <conor@kernel.org>
> > 
> > 
> > ---
> > 
> > (no changes since v2)
> > 
> > Changes in v2:
> > - New
> > 
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0edc7385fd..40232cb65e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1794,8 +1794,8 @@ F: tests/tcg/riscv64/test-crc32.S
> >   Microchip PolarFire SoC Icicle Kit
> >   M: Bin Meng <bin.meng@processmission.com>
> > -M: Conor Dooley <conor@kernel.org>
> >   M: Sebastian Huber <sebastian.huber@embedded-brains.de>
> > +R: Conor Dooley <conor@kernel.org>
> >   L: qemu-riscv@nongnu.org
> >   S: Supported
> >   F: docs/system/riscv/microchip-icicle-kit.rst
> 
> Is tooling confused when we define the same section twice?
> 
> Microchip PolarFire SoC Icicle Kit
> M: Bin Meng <bin.meng@processmission.com>
> S: Supported
> F: docs/system/riscv/microchip-icicle-kit.rst
> F: hw/riscv/microchip_pfsoc.c
> F: hw/char/mchp_pfsoc_mmuart.c
> F: hw/misc/mchp_pfsoc_dmc.c
> F: hw/misc/mchp_pfsoc_ioscb.c
> F: hw/misc/mchp_pfsoc_sysreg.c
> F: include/hw/riscv/microchip_pfsoc.h
> F: include/hw/char/mchp_pfsoc_mmuart.h
> F: include/hw/misc/mchp_pfsoc_dmc.h
> F: include/hw/misc/mchp_pfsoc_ioscb.h
> F: include/hw/misc/mchp_pfsoc_sysreg.h
> 
> Microchip PolarFire SoC Icicle Kit
> M: Conor Dooley <conor@kernel.org>
> M: Sebastian Huber <sebastian.huber@embedded-brains.de>
> S: Odd Fixes
> F: docs/system/riscv/microchip-icicle-kit.rst
> F: hw/riscv/microchip_pfsoc.c
> F: hw/char/mchp_pfsoc_mmuart.c
> F: hw/misc/mchp_pfsoc_dmc.c
> F: hw/misc/mchp_pfsoc_ioscb.c
> F: hw/misc/mchp_pfsoc_sysreg.c
> F: include/hw/riscv/microchip_pfsoc.h
> F: include/hw/char/mchp_pfsoc_mmuart.h
> F: include/hw/misc/mchp_pfsoc_dmc.h
> F: include/hw/misc/mchp_pfsoc_ioscb.h
> F: include/hw/misc/mchp_pfsoc_sysreg.h
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


