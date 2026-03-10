Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7780F4180B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztPh-0003TU-7b; Tue, 10 Mar 2026 05:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vztPg-0003TD-7l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vztPe-0006Fj-G0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773135001;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eTNX7iHpNF6pMIJHi16fRd9tMO7CJgZNeyKLoFcIiA=;
 b=Av/t/AsrFzpHE98QW/eCkILypYYpxt5+bLVsUyEmP44z6g8wm5d/q/b64Do8FA37gX2OqN
 mMFpUeRHFz6bvmcoeKKco6A3Ub9aJuUZYn6gbgbn8XNbpSgMnl/VHleL8unv7W6VHI7TSO
 nOPjajPd7LbU1DJo6QRhR9Xfusv7H3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-N228VauuPoSAhqRcNUGFzA-1; Tue,
 10 Mar 2026 05:29:58 -0400
X-MC-Unique: N228VauuPoSAhqRcNUGFzA-1
X-Mimecast-MFC-AGG-ID: N228VauuPoSAhqRcNUGFzA_1773134996
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D762619560B0; Tue, 10 Mar 2026 09:29:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23F971955D71; Tue, 10 Mar 2026 09:29:50 +0000 (UTC)
Date: Tue, 10 Mar 2026 09:29:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Avi Kivity <avi@scylladb.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 0/4] hw/nvme: make model & firmware version cnofigurable
Message-ID: <aa_ki7qkv4TLB6_N@redhat.com>
References: <20260306165717.3360110-1-berrange@redhat.com>
 <aasJYeR9JRcb83Rb@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aasJYeR9JRcb83Rb@kbusch-mbp>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 06, 2026 at 10:05:37AM -0700, Keith Busch wrote:
> On Fri, Mar 06, 2026 at 04:57:13PM +0000, Daniel P. Berrangé wrote:
> > The pre-existing serial field should also be length checked to
> > detect & report invalid user input instead of silently truncating.
> 
> Generally fine with that, but worried about user regressions from
> unknowingly relying on the truncation behavior. Could these overflow
> conditions just emit a truncation warn_report instead of failing to
> start?

There is always that possibility that someone is unknowingly having
their data truncated, however, we have generally taken the view that
it is fair game to introduce error checking for invalid input in
these kind of cases. As prior art, we introduced error checking to
the SCSI serial to remove truncation:

  commit 75997e182b695f2e3f0a2d649734952af5caf3ee
  Author: Kevin Wolf <kwolf@redhat.com>
  Date:   Tue Jun 4 18:17:55 2024 +0200

    scsi-disk: Don't silently truncate serial number

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


