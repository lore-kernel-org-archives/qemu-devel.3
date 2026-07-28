Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FF7C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodBd-0004MI-9S; Tue, 28 Jul 2026 04:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wodBb-0004Jr-Og
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wodBa-0000MP-8H
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785227353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jD6btBnKGK/P42lG+kohR8dGnOR7xnaYd7a1tYVKqs=;
 b=bwsYAzDFG9C/57pT/avFq6PzR8jhL0+tmtyNHpb/fdij53oAFQ7fxRpbxUxDE8QgWAptvR
 wYlPA1L7rOl6VDjE+1glNdkoRMnx4cGCiUsYbv65yJj8ABk8TpbGbG/Bq2MFtgii3vSyFr
 0bpBaep3asdTcWYCc63DRzjWiOFw960=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-56jJtLCHPxqJujL3qRQZ8g-1; Tue,
 28 Jul 2026 04:29:09 -0400
X-MC-Unique: 56jJtLCHPxqJujL3qRQZ8g-1
X-Mimecast-MFC-AGG-ID: 56jJtLCHPxqJujL3qRQZ8g_1785227348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D0F719560B2; Tue, 28 Jul 2026 08:29:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF03D180044F; Tue, 28 Jul 2026 08:29:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B747218000A2; Tue, 28 Jul 2026 10:29:06 +0200 (CEST)
Date: Tue, 28 Jul 2026 10:29:06 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 7/9] tests/qtest: Add small igvm files for testing
 purpose
Message-ID: <amhm-yvRhhZqOlhq@sirius.home.kraxel.org>
References: <20260714024557.204578-1-anisinha@redhat.com>
 <20260714024557.204578-8-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024557.204578-8-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 08:15:26AM +0530, Ani Sinha wrote:
> Needed by launchupdate-test.c. README file is added with explanation on how
> to build these IGVM files.

> +Small IGVM file bundles required for tesing vm-launch-update device
> +===================================================================
> +
> +This directory contains IGVM files required for launchupdate-test.c.
> +These IGVM bundles can be built from the following repository:
> +https://gitlab.com/anisinha/virt-firmware-rs

> +Just type "make" in the top of the repository. The built IGVM files
> +can be found in the target/x86_64-unknown-none/debug directory.

There is also a smaller hello version written in C instead of rust in
the bios-32 directory.  I've updated that recently in my repo to provide
three versions so it is possible to pick the behavior you want (reset,
poweroff, hlt loop).

Binaries are available from https://kraxel.gitlab.io/virt-firmware-rs/

HTH & take care,
  Gerd


