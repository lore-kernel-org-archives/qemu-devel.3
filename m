Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2495606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pipo.sk header.i=@pipo.sk header.a=rsa-sha256 header.s=dkim header.b=pJ+8rYuN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWa6I-00078N-8O; Thu, 26 Nov 2026 09:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pipo@pipo.sk>) id 1xWWqG-0007my-RD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:36:41 -0500
Received: from mail.pipo.sk ([116.202.55.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pipo@pipo.sk>) id 1xWWqE-0007Hc-GW
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:36:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0226E14B90C1; Thu, 26 Nov 2026 11:36:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pipo.sk; s=dkim;
 t=1795689390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=LXmI0Ex9iFCM/IqN7dIcGXQVSPBMhbstmXFIZsCYZjM=;
 b=pJ+8rYuNSz6Ugso7PJmQY/GBUhWuAfFK9i2lSpG4WWt0KOf3VvDwljutT4QxKB14NVBD9O
 rkWqPZMm+tuRput+nHtlR+QnJGsw5FP3mA8HYPq5ODYGGcJpVDNfG7tTSJYRlva1lMhim+
 SFhEL/mwiTB/NYBZjSluT0fxv8c+ZwkAlt/hg4RWNiTLphj8808LowfnebgwYn7yBFCWJu
 w4F2K1PLIVSnZB005ATIcdu6OK+DBA/cYhbPt+pUgWRbCb20PG/wGJ49asQCYEIn85iNG0
 Tb6wEy3C1GG48Nw5AXIbN8whRuFG7w9UBa5p98AX59SpzVZzK9BzY84FMWutOg==
Date: Thu, 26 Nov 2026 11:36:28 +0100
From: Peter Krempa <pipo@pipo.sk>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: Re: [PATCH 16/16] qom: Deprecate ObjectPropertyInfo,
 ObjectPropertyValue member @type
Message-ID: <awgLrGyWeIsnSBiO@speedmetal.pipo.sk>
References: <20261126100139.3557890-1-armbru@redhat.com>
 <20261126100139.3557890-17-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126100139.3557890-17-armbru@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Last-TLS-Session-Version: TLSv1.3
Received-SPF: pass client-ip=116.202.55.83; envelope-from=pipo@pipo.sk;
 helo=mail.pipo.sk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Nov 2026 09:05:23 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 11:01:39 +0100, Markus Armbruster via Devel wrote:
> Use members @kind, @qapi-type, and @qom-type instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/about/deprecated.rst |  5 +++++
>  qapi/qom.json             | 14 ++++++++------
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 5ab329705b6..bcae9c0afbc 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -190,6 +190,11 @@ so the concept of an 'unavailable' trace event no longer exists.
>  The ``ignore-unavailable`` parameter in ``trace-event-set-state``
>  thus has no effect and should no longer be used.
>  
> +``qom-list``, ``qom-list-property``, ``qom-list-get`` return value member @type  (since 12.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Use members @kind, @qapi-type, and @qom-type instead.

libvirt proper doesn't currently look at the 'type' property at all.
We're only interested in the name of the property and internally assume
the type.

(Said that I'll be looking into using 'qapi-type' as source of data for
validating properties of -device we generate when I'll have time to
look at it. I had already some code where I tried to synthetize the
data but this oguth to be much simpler and already present in our
queries)

The only code in the libvirt repo which looks at @type is the
scripts/qemu-replies-tool script when the --dump-all mode is used, which
I use to generate diffs of capabilities of qemu, but that is used only
manually so I'll address that after this will be comitted.

On behalf of libvirt:

ACKed-by: Peter Krempa <pipo@pipo.sk>

