Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF92D4899A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj4K-0008H1-Qs; Fri, 16 Jan 2026 07:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgj3T-00085R-9a
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgj3R-0003z1-7u
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768566951;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MxHPyNr8RGPpOoO6uRu8LEpTsn9JVEirCrQP9JQAHDE=;
 b=LtoWzdCm7p1Tq8Fo1ldQNeUzybmZ8wZfJEb+7iOJT5CB3WAxOGCkqI4nMQ4bpqLeEwdWVL
 o2S+Jo+gyYHl3z/14JQO1WXMwohuV45oKJELTIESpHDueoNb3f0OmCsWE3ApZ4M7/cdK3p
 YG7Tl/J/Y9g/14mniXD4l4/NCAgPnfA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-au4ywnOMPq2PRu_TLBJYfA-1; Fri,
 16 Jan 2026 07:35:49 -0500
X-MC-Unique: au4ywnOMPq2PRu_TLBJYfA-1
X-Mimecast-MFC-AGG-ID: au4ywnOMPq2PRu_TLBJYfA_1768566948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A93519560A3; Fri, 16 Jan 2026 12:35:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0E8A1800665; Fri, 16 Jan 2026 12:35:45 +0000 (UTC)
Date: Fri, 16 Jan 2026 12:35:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/11] plugins: enable C++ plugins
Message-ID: <aWownlTDHCx10w9I@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 02, 2026 at 01:47:13PM -0800, Pierrick Bouvier wrote:
> Writing plugins in C can be sometimes tedious, especially when using Glib to
> keep track of execution state. We can directly use the same C API but write our
> plugin in C++, benefiting from its great standard library offering strings,
> smart pointers, data structures and synchronization mechanisms.
> 
> It's common for downstream QEMU forks to provide C++ for plugins, like this:
> - https://github.com/panda-re/panda/tree/dev/panda/plugins
> - https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin
> 
> Hopefully this will help more people to use upstream QEMU, and as a benefit, get
> their contribution back and help to develop plugins ecosystem upstream directly.
> 
> This series first cleans up build system for plugins, factorizing details
> between contrib/plugins and tests/tcg/plugins folders.
> Then, we perform codebase cleanups to fix conflicts between existing headers
> and C++ headers.
> After that, we can update the C++ standard used by QEMU, to benefit fully
> from latest updates of the language.
> Finally, we define an empty C++ plugin, making sure we can keep track of
> possible regression in qemu-plugin header.
> 
> Note: This series is *not* a trojan horse to bring C++ in QEMU
> codebase, nor to define an alternative C++ API for plugins. It's just enabling
> more users to get the most out of existing C plugin API.

That's somewhat misleading, because as the diffstat below shows,
this is indeed bringing new C++ source files into QEMU:

   contrib/plugins/cpp.cpp                     | 119 ++++++++++++++++++++

and the description above talks about bringing more C++ plugins in
from external forks, and the meson.build files are modified to
deal with C++.

We've had a handful of C++ files historically we've worked to
reduce, with the eventual goal of not using a C++ toolchain for
any part of QEMU build. Given that IMHO qemu.git should not be
adding new C++ sources files, even if in the plugins dir.

Since the qemu-plugin.h file should be entirely self-contained,
do we actually need to be bundling all the plugins into qemu.git ?

Should we in fact have a sepate gitlab.com/qemu/qemu-plugins repository
where we keep plugins ?

Since the qemu-plugin.h file is defining a somewhat stable API, plugins
in that separate repo ought to be able to build against multiple QEMU
releases, and could thus benefit from not being bundled together and
don't need to be on the same release cycle.

The main qemu.git CI jobs could trigger testing of a separate
qemu-plugins.git repo, so we still validate no regressions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


