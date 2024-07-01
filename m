Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E72CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONeD-0007rx-Gk; Mon, 01 Jul 2024 16:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONeB-0007qN-B2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONe8-0008W5-Gz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719865747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6jO0Mxxa71x6NAV8LJIiHCaOcCbF3PZ/JQzUSIEHNM=;
 b=Q0wHjYjEqphcRH5Q0Dm6Oh4wTcIRCMmW88HJmH3VhlZKRt30Ii1ZthrKgjahBBJ+11ZwUf
 XVpyA5Or6OVptNyM6NL8vMWxgsypLu0u9Nwy+fmjSsjao2IHjYunGFu4hNxS4+xv3ir3eY
 JQVbRJbxacXWwVnygZ+t8AG3m/mH3bg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-8WKomSsnMyCcanCAjFdT-A-1; Mon, 01 Jul 2024 16:29:05 -0400
X-MC-Unique: 8WKomSsnMyCcanCAjFdT-A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-363542774e1so3631319f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719865745; x=1720470545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6jO0Mxxa71x6NAV8LJIiHCaOcCbF3PZ/JQzUSIEHNM=;
 b=naRioMF1qznyg5Imede/GEwZ2Ls2wbLyFjqQPo3dDNzA61IcXsXAme+T+wDTJ0MOtT
 7FiSIutzizTUt78wly/uGFbWkTBsb2tj2eRgJid6UdAod2i4NB0EvHMVvvPqm3aCxC8O
 DIVN26jdPBjrSAybF5YCMD8lKhRV4HxSDzNedO5ahxB50wYlOHIkdgwRb7ycPm7DOagf
 W9sdjooKoCdQL3Kg+SbnaIopDlZP5rwqTyGv1Az2gAwct9VCgmHj7GOK2l+FsMaEPNzc
 XHa0+lzQZz7ZmlBfwbrYCh1Fbz4YBipfsRKUC3dMXYFDtnZt+DhBVT3kb5sNgo3AVNxZ
 4tdg==
X-Gm-Message-State: AOJu0Yz+Otku7620pWuz3Azl7dsI/S4K0TBXEq6AAqonctbTrtSKtI/i
 oNeuUsUSCi8jgh2LU4DgTmvR2VD/jk5oTpr5H96dGp+IN8Nv3J9xWKM3DcloJs2lVzUCYPd3hcs
 5TCwk+pZqlTlYNLQpKV3L6ZUuddX/DI2cu3jsALuwVzX1BPDsdIxs
X-Received: by 2002:adf:e785:0:b0:366:eb00:9ddf with SMTP id
 ffacd0b85a97d-3677569961bmr5370944f8f.3.1719865744799; 
 Mon, 01 Jul 2024 13:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHAXiXs/gYPQwQDDM6DI2X8mAJkoo7zg7p4yH/Ry5fbbuNtObrfIEfSW+his9vIwbEglsk4Q==
X-Received: by 2002:adf:e785:0:b0:366:eb00:9ddf with SMTP id
 ffacd0b85a97d-3677569961bmr5370933f8f.3.1719865744215; 
 Mon, 01 Jul 2024 13:29:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd562sm11044063f8f.15.2024.07.01.13.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:29:03 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:28:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 00/13] qapi: convert "Note" and "Example" sections to rST
Message-ID: <20240701162842-mutt-send-email-mst@kernel.org>
References: <20240619003012.1753577-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619003012.1753577-1-jsnow@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 18, 2024 at 08:29:59PM -0400, John Snow wrote:
> This series focuses primarily on converting our existing QAPI/QMP
> documentation to remove special "Note" and "Example" sections in favor
> of rST markup for the same.
> 
> This is being done primarily to reduce the number of specially parsed
> QAPI sections we have in favor of allowing fully arbitrary rST markup
> for greater flexibility and freedom in styling the rendered HTML
> documentation.
> 
> (A tangible side benefit is that the new qapidoc generator has fewer
> sections to reason about when it splices inherited documentation
> together for the QMP reference manual; docs largely preserve the order
> of documentation "as written" instead of needing to splice multiple
> separate sections together. A goal of the new generator is to eventually
> remove all tagged sections except for "members" and "features".)
> 
> Known issues:
> 
> - The caption syntax for QMP examples is a little ugly in rendered HTML
>   output; My CSS intern wasn't available before publication time to fix
>   it ;) -- Will fix with an amendment patch at next opportunity.
> 
> Any feedback not implemented should be interpreted as evidence of a
> forgetful (rather than a spiteful) mind. Please remind me where
> appropriate.
> 
> --js

virtio things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> John Snow (13):
>   [DO-NOT-MERGE]: Add some ad-hoc linting helpers.
>   qapi: linter fixups
>   docs/qapidoc: delint a tiny portion of the module
>   qapi/parser: preserve indentation in QAPIDoc sections
>   qapi/parser: fix comment parsing immediately following a doc block
>   docs/qapidoc: fix nested parsing under untagged sections
>   qapi: fix non-compliant JSON examples
>   qapi: ensure all errors sections are uniformly typset
>   qapi: convert "Note" sections to plain rST
>   qapi: update prose in note blocks
>   qapi: add markup to note blocks
>   qapi/parser: don't parse rST markup as section headers
>   qapi: convert "Example" sections to rST
> 
>  docs/devel/qapi-code-gen.rst                  |  25 +--
>  docs/sphinx/qapidoc.py                        | 103 ++++++++----
>  qapi/acpi.json                                |   6 +-
>  qapi/block-core.json                          | 148 +++++++++-------
>  qapi/block.json                               |  62 ++++---
>  qapi/char.json                                |  48 ++++--
>  qapi/control.json                             |  32 ++--
>  qapi/dump.json                                |  14 +-
>  qapi/introspect.json                          |   6 +-
>  qapi/machine-target.json                      |  29 ++--
>  qapi/machine.json                             | 125 ++++++++------
>  qapi/migration.json                           | 159 ++++++++++++------
>  qapi/misc-target.json                         |  33 ++--
>  qapi/misc.json                                | 139 ++++++++-------
>  qapi/net.json                                 |  42 +++--
>  qapi/pci.json                                 |  11 +-
>  qapi/qapi-schema.json                         |   6 +-
>  qapi/qdev.json                                |  45 ++---
>  qapi/qom.json                                 |  39 +++--
>  qapi/replay.json                              |  12 +-
>  qapi/rocker.json                              |  30 ++--
>  qapi/run-state.json                           |  63 ++++---
>  qapi/sockets.json                             |  10 +-
>  qapi/stats.json                               |  22 +--
>  qapi/tpm.json                                 |   9 +-
>  qapi/trace.json                               |   6 +-
>  qapi/transaction.json                         |  13 +-
>  qapi/ui.json                                  |  93 +++++-----
>  qapi/vfio.json                                |   3 +-
>  qapi/virtio.json                              |  50 +++---
>  qapi/yank.json                                |   6 +-
>  qga/qapi-schema.json                          |  48 +++---
>  scripts/qapi-lint.sh                          |  59 +++++++
>  scripts/qapi/Makefile                         |   5 +
>  scripts/qapi/introspect.py                    |   8 +-
>  scripts/qapi/parser.py                        |  40 ++++-
>  scripts/qapi/schema.py                        |   6 +-
>  scripts/qapi/visit.py                         |   5 +-
>  tests/qapi-schema/doc-empty-section.err       |   2 +-
>  tests/qapi-schema/doc-empty-section.json      |   2 +-
>  tests/qapi-schema/doc-good.json               |  21 ++-
>  tests/qapi-schema/doc-good.out                |  62 ++++---
>  tests/qapi-schema/doc-good.txt                |  31 ++--
>  .../qapi-schema/doc-interleaved-section.json  |   2 +-
>  44 files changed, 1036 insertions(+), 644 deletions(-)
>  create mode 100755 scripts/qapi-lint.sh
>  create mode 100644 scripts/qapi/Makefile
> 
> -- 
> 2.44.0
> 


