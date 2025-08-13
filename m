Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A5CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 00:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulzVD-0000of-9L; Tue, 12 Aug 2025 20:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1ulzV8-0000na-Rx
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 20:37:59 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1ulzV1-0000YB-MV
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 20:37:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 438785C5B82;
 Wed, 13 Aug 2025 00:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17669C4CEF0;
 Wed, 13 Aug 2025 00:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755045454;
 bh=voc944dZi3/cVYFMpCgCr3K9WlBxgWTIehbZk/dV7Bw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j5dlsuaYg/5idKN+HZuBkXktYWUqAmtyGG069OvbJEwEb9Q5vSzmdbNHAeWMhsJkI
 STPcST/ssuUqrGR2vQY59WVZG8qfZzVaGtkvVQBYFWN3PTsqYXDm37ZVQH3kgvut+D
 2ZU5+LqlFyf/UU17hVvWNKZUR99EqOS+5LfyMA/KJaQrlmnsvrwMEh5/IW0Y4WM825
 7cZyZcOxHEsU8uKNqZJu36c7AyU55T8t4kfoAjYc0oS4BOcPMbIMZItb3syBrV6ssa
 IH6Eo9Wh6FrzGSaddIG6bHE36BzP8UTT9Ze3HhP7fSnSqUSSyW38qbEqHFgEFTXPcc
 gNDPHgJkjsb3g==
Date: Wed, 13 Aug 2025 00:37:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, prapal@linux.microsoft.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 26/26] qapi/accel: Allow to query mshv capabilities
Message-ID: <aJveTB0fc--hG_zR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-27-magnuskulke@linux.microsoft.com>
 <aJT87brzXBy89lfV@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJT87brzXBy89lfV@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=wei.liu@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 07:22:21PM +0000, Wei Liu wrote:
> On Thu, Aug 07, 2025 at 04:39:51PM +0200, Magnus Kulke wrote:
> > From: Praveen K Paladugu <prapal@microsoft.com>
> > 
> > Allow to query mshv capabilities via query-mshv QMP command.
> > 
> > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> >  hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
> >  qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> > 
> > diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> > index 6aca1a626e..024ddb8d2d 100644
> > --- a/hw/core/machine-qmp-cmds.c
> > +++ b/hw/core/machine-qmp-cmds.c
> > @@ -28,6 +28,20 @@
> >  #include "system/runstate.h"
> >  #include "system/system.h"
> >  #include "hw/s390x/storage-keys.h"
> > +#include <sys/stat.h>
> > +
> > +/*
> > + * QMP query for MSHV
> > + */
> > +MshvInfo *qmp_query_mshv(Error **errp)
> > +{
> > +    MshvInfo *info = g_malloc0(sizeof(*info));
> > +    struct stat st;
> > +
> > +    info->present = accel_find("mshv");
> > +    info->enabled = (stat("/dev/mshv", &st) == 0);
> 
> I don't think this is the right way to check if MSHV is _enabled_. The
> device node being around doesn't necessarily mean that QEMU is using it.
> 
> You can refer to kvm_enabled() to see how it is implemented.
> 
> Some functions that are of interest:
>    do_configure_accelerator
>    accel_init_machine

This is likely as simple as squashing in the following diff.

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 024ddb8d2d7c..1b520599972a 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -39,7 +39,7 @@ MshvInfo *qmp_query_mshv(Error **errp)
     struct stat st;

     info->present = accel_find("mshv");
-    info->enabled = (stat("/dev/mshv", &st) == 0);
+    info->enabled = mshv_enabled();
     return info;
 }

