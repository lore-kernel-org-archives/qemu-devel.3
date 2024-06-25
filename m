Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 10:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM3T2-00018w-BH; Tue, 25 Jun 2024 06:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sM3T0-00018T-N1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sM3Sy-0002s8-9j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719311518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pTRN3CCsy0/jz2C1XDFRuO5jH8q19bs2/Ol4SvzUZk=;
 b=NONHludjERdO2bKdE10GJ8rwTjBf9R6fDtynh3IGYy+D7dCbYhnOclD3AAGw+wkAZxa+7H
 3acQR6u7BAwUd/RB5QRyhmBei1sVW/G4MJN3Dw1D//UGzEXS3LL6DuNupFH0Xbd5O+EbYz
 KHcPXrlhIqpZS81lJ2j8NOQLLbstmW0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-A0WWjNToOni-IB41jMjl5A-1; Tue,
 25 Jun 2024 06:31:55 -0400
X-MC-Unique: A0WWjNToOni-IB41jMjl5A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0102B19560B0; Tue, 25 Jun 2024 10:31:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51BD51956087; Tue, 25 Jun 2024 10:31:50 +0000 (UTC)
Date: Tue, 25 Jun 2024 11:31:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roman Kiryanov <rkir@google.com>, Felix Wu <flwu@google.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
Message-ID: <ZnqckibHOALRQWBj@redhat.com>
References: <20240624205647.112034-1-flwu@google.com>
 <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
 <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
 <CABgObfZ6U0pEcvr-J5H3sYjTU0-kOr4NOLjBRh0Vg-vfutRCqQ@mail.gmail.com>
 <0b5ff0ab-9b58-4463-8aeb-d464b3b085dd@linaro.org>
 <CAFEAcA-5RPETso7Z56SUhgDkSekLDWu8hPXmKEo_dhh1kPYpfg@mail.gmail.com>
 <CAFEAcA8pQ_XtitN-Zy63xxGT=6mBEuha7PCeJc-=OJWcvuw=vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8pQ_XtitN-Zy63xxGT=6mBEuha7PCeJc-=OJWcvuw=vg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 11:16:16AM +0100, Peter Maydell wrote:
> On Tue, 25 Jun 2024 at 10:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 25 Jun 2024 at 07:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > >
> > > On 25/6/24 08:05, Paolo Bonzini wrote:
> > > >
> > > >
> > > > Il mar 25 giu 2024, 04:32 Roman Kiryanov <rkir@google.com
> > > > <mailto:rkir@google.com>> ha scritto:
> > > >
> > > >     Hi Philippe, thank you for looking.
> > > >
> > > >     On Mon, Jun 24, 2024 at 7:27 PM Philippe Mathieu-Daudé
> > > >     <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> > > >      > In particular this patch seems contained well enough
> > > >      > to be carried in forks were C++ _is_ used.
> > > >
> > > >     Will you agree to take #ifdef __cplusplus  and #error to the QEMU side
> > > >     in atomic.h and
> > > >     we will keep atomic.hpp on our side? The error message looks better
> > > >     when atomic.hpp
> > > >     is somewhere near.
> > > >
> > > >
> > > > I think we should also move typeof_strip_qual elsewhere; I will take a
> > > > look. I think there are a couple headers that already have #ifdef
> > > > __cplusplus, but I need to check (no source code around right now).
> > >
> > > $ git grep -l __cplusplus
> > > ebpf/rss.bpf.skeleton.h
> > > include/hw/xtensa/xtensa-isa.h
> > > include/qemu/compiler.h
> > > include/qemu/osdep.h
> > > include/standard-headers/drm/drm_fourcc.h
> > > include/sysemu/os-posix.h
> > > include/sysemu/os-win32.h
> > > linux-headers/linux/stddef.h
> > > qga/vss-win32/requester.h
> >
> > We should delete all of those, they're dead code for us now.
> > We dropped some of the extern-C-block handling in
> > commit d76aa73fad1f6 but that didn't get all of them.
> 
> I was wrong about this -- I had forgotten about the Windows
> Guest Agent code that has to be built with the Windows C++
> compiler -- some of the cpp files in qga/vss-win32/ include
> osdep.h. So the files above break down into:
> 
>  * files imported from third-party projects, or generated
>    by third-party tools:
>     + ebpf/rss.bpf.skeleton.h
>     + include/hw/xtensa/xtensa-isa.h
>     + include/standard-headers/drm/drm_fourcc.h
>     + linux-headers/linux/stddef.h
> 
>  * QEMU include files that we need to include directly
>    or indirectly from the vss-win32 files:
>     + include/qemu/compiler.h
>     + include/qemu/osdep.h
>     + include/sysemu/os-win32.h
>     + include/sysemu/os-posix.h
>     + qga/vss-win32/requester.h
> 
> Maybe we could drop the cplusplus handling from os-posix.h,
> but I guess we're keeping it in parallel with os-win32.h.

The vss-win32 code is specialized & self-contained code. Since
it is inherantly Windows only code, it does not need any platform
portability support which is what osdep.h would ordinarily assist
with.

As an example, if you remove osdep.h from the vss-win32 code,
the following changes appear sufficient to solve the resulting
compile issues.

This could let us remove remaining cplusplus usage from the
common QEMU headers:

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index cc72e5ef1b..ed2d8097ee 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include "vss-common.h"
 #include "vss-debug.h"
 #ifdef HAVE_VSS_SDK
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 9884c65e70..e519e6cfd7 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include "vss-common.h"
 #include "vss-debug.h"
 #include "requester.h"
diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index 0e67e7822c..5c6b21ce21 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -16,6 +16,9 @@
 #define __MIDL_user_allocate_free_DEFINED__
 #include <windows.h>
 #include <shlwapi.h>
+#include <glib.h>
+#include <assert.h>
+#include "config-host.h"
 
 /* Reduce warnings to include vss.h */
 
diff --git a/qga/vss-win32/vss-debug.cpp b/qga/vss-win32/vss-debug.cpp
index 820b1c6667..ec4c2b3093 100644
--- a/qga/vss-win32/vss-debug.cpp
+++ b/qga/vss-win32/vss-debug.cpp
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include "vss-debug.h"
 #include "vss-common.h"
 
diff --git a/qga/vss-win32/vss-debug.h b/qga/vss-win32/vss-debug.h
index 7800457392..77fd669698 100644
--- a/qga/vss-win32/vss-debug.h
+++ b/qga/vss-win32/vss-debug.h
@@ -10,8 +10,9 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include <vss-handles.h>
+#include <glib.h>
+#include <stdio.h>
 
 #ifndef VSS_DEBUG_H
 #define VSS_DEBUG_H


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


