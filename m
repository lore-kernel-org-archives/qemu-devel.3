Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EDDD7830E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4n5-0001Uy-0c; Mon, 02 Dec 2024 06:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4n2-0001Um-Hs
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4mz-0006Jx-Nw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733139627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ix5g4PP5EDdqqFBdP+fm22lo8iayGxaWEfOknyGbg7U=;
 b=dcX0BXDJArqnmQAeMr4F6t745+fypNRLtgRP1pncpXjuGrCXI3B7gLsJzR4opbE089V2F1
 bPnUPB8YZnky9xyvNx/RRUlgCHr7dfy38ResbJ+XcqNv5a2mJs3CpQnzu2Rd26yzuXef8j
 jvl92+fBHsxKLte0TyrE84W+/F8sZG8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-_8lYidxGO0OZLUSJ2ClRpQ-1; Mon,
 02 Dec 2024 06:40:26 -0500
X-MC-Unique: _8lYidxGO0OZLUSJ2ClRpQ-1
X-Mimecast-MFC-AGG-ID: _8lYidxGO0OZLUSJ2ClRpQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A86B41955F65; Mon,  2 Dec 2024 11:40:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB5211955D45; Mon,  2 Dec 2024 11:40:23 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:40:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 03/22] tests/functional: remove duplicated 'qemu_test'
 import statements
Message-ID: <Z02cpK4BUSPS2fV9@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-4-berrange@redhat.com>
 <c9dd8d50-734e-4322-8ad4-c77544705916@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9dd8d50-734e-4322-8ad4-c77544705916@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 30, 2024 at 11:09:48AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > Group all imports that originate in the 'qemu_test' package into
> > one statement.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/tuxruntest.py         |  9 +++++----
> >   tests/functional/test_aarch64_raspi4.py          |  4 ++--
> >   tests/functional/test_aarch64_sbsaref.py         |  5 ++---
> >   tests/functional/test_aarch64_sbsaref_alpine.py  |  5 ++---
> >   tests/functional/test_aarch64_sbsaref_freebsd.py |  5 ++---
> >   tests/functional/test_aarch64_virt.py            |  6 ++----
> >   tests/functional/test_arm_aspeed.py              |  7 +++----
> >   tests/functional/test_arm_bflt.py                |  3 +--
> >   tests/functional/test_arm_bpim2u.py              |  8 ++++----
> >   tests/functional/test_arm_canona1100.py          |  3 +--
> >   tests/functional/test_arm_integratorcp.py        |  3 +--
> >   tests/functional/test_arm_orangepi.py            | 10 +++++-----
> >   tests/functional/test_arm_raspi2.py              |  4 ++--
> >   tests/functional/test_loongarch64_virt.py        |  6 +++---
> >   tests/functional/test_microblaze_s3adsp1800.py   |  5 ++---
> >   tests/functional/test_microblazeel_s3adsp1800.py |  5 ++---
> >   tests/functional/test_mips64el_fuloong2e.py      |  7 ++++---
> >   tests/functional/test_mips64el_loongson3v.py     |  3 +--
> >   tests/functional/test_mips64el_malta.py          |  4 ++--
> >   tests/functional/test_mipsel_malta.py            |  6 +++---
> >   tests/functional/test_multiprocess.py            |  4 ++--
> >   tests/functional/test_netdev_ethtool.py          |  3 +--
> >   tests/functional/test_ppc64_hv.py                |  4 ++--
> >   tests/functional/test_ppc64_powernv.py           |  3 +--
> >   tests/functional/test_ppc64_pseries.py           |  3 +--
> >   tests/functional/test_ppc_405.py                 |  6 +++---
> >   tests/functional/test_ppc_40p.py                 |  3 +--
> >   tests/functional/test_ppc_74xx.py                |  3 +--
> >   tests/functional/test_ppc_amiga.py               |  3 +--
> >   tests/functional/test_ppc_bamboo.py              |  6 +++---
> >   tests/functional/test_ppc_mpc8544ds.py           |  3 +--
> >   tests/functional/test_ppc_virtex_ml507.py        |  3 +--
> >   tests/functional/test_riscv_opensbi.py           |  4 ++--
> >   tests/functional/test_rx_gdbsim.py               |  6 +++---
> >   tests/functional/test_s390x_ccw_virtio.py        |  6 +++---
> >   tests/functional/test_s390x_topology.py          |  7 +++----
> >   tests/functional/test_sh4eb_r2d.py               |  4 ++--
> >   tests/functional/test_sparc64_sun4u.py           |  3 +--
> >   tests/functional/test_virtio_gpu.py              | 10 ++++------
> >   39 files changed, 85 insertions(+), 107 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
> > index ab3b27da43..7c0456923e 100644
> > --- a/tests/functional/qemu_test/tuxruntest.py
> > +++ b/tests/functional/qemu_test/tuxruntest.py
> > @@ -13,10 +13,11 @@
> >   import stat
> >   import time
> > -from qemu_test import QemuSystemTest
> > -from qemu_test import exec_command, exec_command_and_wait_for_pattern
> > -from qemu_test import wait_for_console_pattern
> > -from qemu_test import has_cmd, run_cmd, get_qemu_img
> > +from qemu_test import (QemuSystemTest, exec_command,
> > +                       exec_command_and_wait_for_pattern,
> > +                       wait_for_console_pattern,
> > +                       has_cmd, run_cmd, get_qemu_img)
> 
> Is there a real advantage in writing it this way? For most files, this not
> seem to reduce the lines of code, so at a quick glance, it rather looks like
> unnecessary code churn to me...?

I guess I just didn't like the wall of repeated imports, but i'm not that
fussed either way. So I'll drop this.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


