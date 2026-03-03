Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620A8EDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUDJ-0004xF-P1; Tue, 03 Mar 2026 13:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxUDE-0004rv-AQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:11:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxUDA-00034r-Kx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772561467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=m5DL9G+3vONkGL5QHt4TV01IKevGbsxkT0WPOncx78Y=;
 b=Et5auRQiY9tj6mVaeoMFEUjL7AyjfnvGmJAzy1XzgYB6iaL60vLs5cupIR/P6vOGDr2H17
 fG9ryB2aRvbm29sZFLBv384CGbISmjWShVFiHMtCX+zIBKCu4CFDnfCDZFAxjGCZHK64zh
 EGMleeHMLlyztsueMB/P57ucwAFlD24=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-D8aPlrc2Nfupigc9CJrsaA-1; Tue,
 03 Mar 2026 13:11:02 -0500
X-MC-Unique: D8aPlrc2Nfupigc9CJrsaA-1
X-Mimecast-MFC-AGG-ID: D8aPlrc2Nfupigc9CJrsaA_1772561460
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388D318004BB; Tue,  3 Mar 2026 18:11:00 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3EAA1955F22; Tue,  3 Mar 2026 18:10:56 +0000 (UTC)
Date: Tue, 3 Mar 2026 18:10:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: Re: [PATCH v2] tests/docker: Update hexagon cross toolchain to 22.1.0
Message-ID: <aackLWHOKc4ZgHrU@redhat.com>
References: <20260303175444.1540049-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303175444.1540049-1-brian.cain@oss.qualcomm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Tue, Mar 03, 2026 at 09:54:44AM -0800, Brian Cain wrote:
> Update the hexagon cross-compiler Docker container to use toolchain
> version 22.1.0, replacing the previous 12.Dec.2023 release.  This release
> has valuable compiler and linker bugfixes, but more importantly it will
> enable us to target DSP arches up to v81.
> 
> This requires upgrading the base image from Debian 11 to Debian 12
> because the new toolchain needs glibc >= 2.34. Additional changes
> to accommodate the new base image and toolchain:
> 
> * Use DEB822 format for enabling deb-src
> * Add libc++1, libc++abi1, libunwind-14 runtime deps for the new
> toolchain
> * Add zstd for the new .tar.zst archive format
> * Replace pip3 install tomli with python3-tomli system package
> (Debian 12 enforces PEP 668)
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> index 23152b4918..00d7834506 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -5,10 +5,10 @@
>  # needs to be able to build QEMU itself in CI we include its
>  # build-deps.
>  #
> -FROM docker.io/library/debian:11-slim
> +FROM docker.io/library/debian:12-slim

Can we go straight to 13 please.   We just updated all the non-hand
written docker files to Debian 13, on the basis that 12 is going
end of life in June.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


