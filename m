Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63703C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0wD-00066u-K8; Mon, 17 Feb 2025 08:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tk0w2-00064T-FC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tk0vz-00064L-Sb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739797995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vu27oeaNtRXeUmurY1gbWdovJB6GwFsj2ieju83i+Pg=;
 b=Eu4mtMzGVzSFe0Z9oL+Ivj8eErmWMfM7E7AfJq1Y8+MjlLsRaVBv/VeyBayOk8pWEY6pUN
 rDAYvZ72oS1t79eaWMADOt0N4sebQaFvrOhiv+IoBn1Rjsq/5+Q4XrOu0x7ijIz5FLs1ya
 uCGxPCLAFdBK5F1Guk6lgYygO4d+u4E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-nQpZJNglO2Sd0PNFpmo1Nw-1; Mon,
 17 Feb 2025 08:13:13 -0500
X-MC-Unique: nQpZJNglO2Sd0PNFpmo1Nw-1
X-Mimecast-MFC-AGG-ID: nQpZJNglO2Sd0PNFpmo1Nw_1739797993
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFDA918D95EE
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 13:13:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDB731956048; Mon, 17 Feb 2025 13:13:10 +0000 (UTC)
Date: Mon, 17 Feb 2025 13:13:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v4 00/11]
Message-ID: <Z7M14rif3RGFOXbM@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 14, 2025 at 09:29:33PM +0100, Victor Toso wrote:
> Hi again,
> 
> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.
> 
> Previous version (10 Jan 2025)
>     https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg01530.html
> 
> The generated code was mostly tested using existing examples in the QAPI
> documentation, 192 instances that might have multiple QMP messages each.

snip

> 1. Daniel wrote a demo on top of v3 and proposed changes that would
>    result in more interesting module to build on top:
>    https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg03052.html
>    
>    I've implemented all the suggestions that are relevant for this
>    introductory series, they are:
> 
>   a. New struct type Message, that shall be used for a 1st level
>      unmarshalling of the JSON message.
>   b. Removal of Marshal/Unmarshal code in both Events and Comands,
>      together with utility code that is not relevant anymore.
>   c. Declaration of 3 new interfaces:
>     i.   Events
>     ii.  Commands
>     iii. CommandsAsync
> 
> 2. I've moved the code to a new folder: scripts/qapi/golang. This
>    allowed me to move templates out of golang.py, keeping go related
>    code self-contained in the new directory.

When I think about the code generator and how this will all
evolve over time, I have a strong feeling that none of this
should be in qemu.git.

Taking those three interfaces in (1)(c), when we come to actually
generate implementations of them, the generated code is going to
be intimately tied to the client/server API framework we need to
plumb into.

IMHO qemu.git should not have any knowledge of this, as it will
create a bidirectional dependency betweeen qemu.git and the
qemu-go.git repo, requiring them to evolve in lockstep.

We'll need 3 releases of the Go code per year, to match the
introduction the new QAPI schema versions, but outside that I
think there ought to be the freedom to have other Go releases
independently.

The need for this to be part of qemu.git is fairly narrow. It
provides a new hook into the QAPI generator code, and the QAPI
generator is not installed by 'make install', it is in-tree
only.

Can we solve this linkage ? We would need to be able to:

 * Have a mechanism for the QAPI code generator to load
   new genrator backends
 * Have a mechanism to tell the QAPI code generator to
   only run a single backend.
 * Have a mechanism to consume the QAPI code genrfator
   from outside qemu.git

The first point there could be addressable using the python "entry-points"
concept

  https://packaging.python.org/en/latest/specifications/entry-points/
  https://setuptools.pypa.io/en/latest/pkg_resources.html#entry-points

Or, alternatively by passing the name of a python module on the CLI.

The second point is just a bit of glue code to wire up a new CLI arg

The third point either involves having 'make install' put the QAPI
code generator into /usr/share/qemu, or /usr/lib/python3.x. The
latter would be if QAPI code generator were a formally release python
module on pypi. The former would be if we're just trying a QAPI code
generator as a local tool, not for pypi. A fallback would be to
consume qemu.git as a git submodule from qapi-go.git. The gitmodule
commit would not have to match the version of the QAPI schema we are
generating code for.

The least effort approach would be making QAPI code genrator accept
a python module name, and call it via a git submodule. This would
avoid declaring a long term support policy for the QAPI code gen
python APIs as a blocker.

> 
> 3. As mentioned in (2), created protocol.go and utils.go that are 100%
>    hand generated Go code. Message mentioned in (1a) is under
>    protocol.go
> 
> 4. Defined license using SPDX-License-Identifier.
>   a. Every Go source code written by hand is 100% MIT-0
>   b. Every Go source code generated is dual licensed as MIT-0 and
>      GPL-2.0-or-later
>   c. The binary code is expected to be MIT-0 only but not really
>      relevant for this series.
> 
>   If you want more information, please check the thread:
>   https://lists.gnu.org/archive/html/qemu-devel/2024-11/msg01621.html
> 
> 5. I've renamed the generated files.
>   a. Any type related file is now prefixed with "gen_type_"
>   b. Any interface related file is prefixed as "gen_iface_"
> 
> 6. Relevant changes were made to the doc but it is not complete. I plan
>    that follow-up proposals would add to the documentation.
> 
> 7. Improvements to the generator were made to.
> 
> 8. Also worth to mention that resulting generated code does not have any
>    diff with gofmt and goimport tools, as requested in the past.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


