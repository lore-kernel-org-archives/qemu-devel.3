Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE2DC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRub-0000Ac-90; Tue, 20 Feb 2024 10:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRuY-00005n-1P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRuW-00063E-9E
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708442395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FAeSpnACY0BBpwDWb9ZwOi/bG/9/ucCiAUzYVO97g0=;
 b=JOwAY3BZhxm3UScX3oBwTQnRXOEOrDwEpldJf2qUnOklzCmwHLYa1U1fdH9WeHe5qlrxqU
 x3cl8aKucoks+z0Ks+NSmEXEU/dUAQNJQ6+uw5EolRaerZVv684UZeWl5zgGd8MllPJcZT
 OxtxSqjYPPVVJASLfAYfJigFATnopGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-4Xrtl4fvOHq2MtPGRgDIWw-1; Tue, 20 Feb 2024 10:19:53 -0500
X-MC-Unique: 4Xrtl4fvOHq2MtPGRgDIWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6C8D9423C7;
 Tue, 20 Feb 2024 15:19:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFEFA401A77B;
 Tue, 20 Feb 2024 15:19:48 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:19:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com,
 eblake@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH 10/16] qapi: Require descriptions and tagged sections to
 be indented
Message-ID: <ZdTDEm2zfA9emT5U@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
 <20240216145841.2099240-11-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216145841.2099240-11-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 03:58:34PM +0100, Markus Armbruster wrote:
> By convention, we indent the second and subsequent lines of
> descriptions and tagged sections, except for examples.
> 
> Turn this into a hard rule, and apply it to examples, too.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst    |  15 +-
>  qapi/acpi.json                  |  20 +-
>  qapi/block-core.json            | 868 ++++++++++++++++----------------
>  qapi/block.json                 | 274 +++++-----
>  qapi/char.json                  | 172 +++----
>  qapi/control.json               |  54 +-
>  qapi/dump.json                  |  26 +-
>  qapi/machine-target.json        |   6 +-
>  qapi/machine.json               | 302 +++++------
>  qapi/migration.json             | 690 ++++++++++++-------------
>  qapi/misc-target.json           | 110 ++--
>  qapi/misc.json                  | 172 +++----
>  qapi/net.json                   | 118 ++---
>  qapi/pci.json                   | 252 +++++-----
>  qapi/qdev.json                  |  38 +-
>  qapi/qom.json                   |  54 +-
>  qapi/rdma.json                  |  14 +-
>  qapi/replay.json                |  16 +-
>  qapi/rocker.json                |  66 +--
>  qapi/run-state.json             |  84 ++--
>  qapi/tpm.json                   |  36 +-
>  qapi/trace.json                 |  12 +-
>  qapi/transaction.json           |  36 +-
>  qapi/ui.json                    | 324 ++++++------
>  qapi/virtio.json                | 778 ++++++++++++++--------------
>  qapi/yank.json                  |  24 +-
>  scripts/qapi/parser.py          |   3 +
>  tests/qapi-schema/doc-good.json |  12 +-
>  28 files changed, 2289 insertions(+), 2287 deletions(-)
> 

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


