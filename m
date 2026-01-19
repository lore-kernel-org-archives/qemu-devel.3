Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29F3CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhmbr-0000IP-8B; Mon, 19 Jan 2026 05:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhmbp-0000Da-UE
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhmbo-0002VC-F0
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768818943;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuTrtHrqr5IdpFGXb4OELiRYYZ28MgQwcjKddcB5ugg=;
 b=H3TQ8GYaURqzjFZNZxttS1rFu9V132T939fFFUPTX77rx/MtVsReBICoHZFcDwFcXJlsfq
 PdUh30E3qchtJbM43BdIXqRzEIwhyuOGc6jtAEA9BIuWH/ZrkNFDEyRDZ5Vg7XaTnxNhW0
 OIHknz66g2bqEzc5cQ2CPL2h1wwVcfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-unDUVeJbPwePUl9Hr1BU5w-1; Mon,
 19 Jan 2026 05:35:41 -0500
X-MC-Unique: unDUVeJbPwePUl9Hr1BU5w-1
X-Mimecast-MFC-AGG-ID: unDUVeJbPwePUl9Hr1BU5w_1768818941
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D739A19560A7
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:35:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB6E91800577; Mon, 19 Jan 2026 10:35:39 +0000 (UTC)
Date: Mon, 19 Jan 2026 10:35:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] Clean up ill-advised or unusual header guards
Message-ID: <aW4I94zunQpxbXVN@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
 <20260119100537.463312-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119100537.463312-4-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 19, 2026 at 11:05:35AM +0100, Markus Armbruster wrote:
> Leading underscores are ill-advised because such identifiers are
> reserved.  Trailing underscores are merely ugly.  Strip both.
> 
> Our header guards commonly end in _H.  Normalize the exceptions.
> 
> Macros should be ALL_CAPS.  Normalize the exception.
> 
> Done with scripts/clean-header-guards.pl.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/tpm/tpm_ioctl.h             | 7 ++++---
>  bsd-user/bsd-proc.h                  | 6 +++---
>  hw/net/igb_regs.h                    | 4 ++--
>  include/exec/target_long.h           | 6 +++---
>  include/exec/tb-flush.h              | 7 ++++---
>  include/gdbstub/helpers.h            | 6 +++---
>  include/gdbstub/syscalls.h           | 6 +++---
>  include/hw/arm/raspberrypi-fw-defs.h | 7 +++----
>  include/hw/arm/stm32l4x5_soc.h       | 4 ++--
>  include/hw/gpio/pcf8574.h            | 6 +++---
>  include/hw/virtio/vhost-user-gpio.h  | 6 +++---
>  include/hw/virtio/vhost-user-scmi.h  | 6 +++---
>  include/hw/xen/xen-pvh-common.h      | 4 ++--
>  include/tcg/insn-start-words.h       | 6 +++---
>  qga/cutils.h                         | 6 +++---
>  15 files changed, 44 insertions(+), 43 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


