Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44B606A880
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SKO1xSaJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsff-00085m-Pl; Fri, 13 Nov 2026 09:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRsfX-00081Q-14
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRsfU-0003Yy-P6
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794581658;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BztaKPPht5dMgXzP3CnjcBZkDdZ7hkgbsX5Mer/RBNM=;
 b=SKO1xSaJ37cqtIoBMkVxO/71lzLSxjWhyijd6dVIMhgJfNbUl5/X+/lSh4u+6a+DYgAk3G
 WbA+Y719xSDap+WUwyGz2W35V5IjQWkrFsbEwqxm1PMcbpvUKaRS0htKrZ5EH6k/GfglB+
 V9a8TFn6+rTjXcl0FCWcYkyStESvveE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-goTN4xErPqSam4tGggSKfw-1; Fri,
 13 Nov 2026 09:54:14 -0500
X-MC-Unique: goTN4xErPqSam4tGggSKfw-1
X-Mimecast-MFC-AGG-ID: goTN4xErPqSam4tGggSKfw_1794581653
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FD691955F7C; Fri, 13 Nov 2026 14:54:13 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E1441955DB9; Fri, 13 Nov 2026 14:54:11 +0000 (UTC)
Date: Fri, 13 Nov 2026 14:54:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH] python/qemu: fix accelerator detection with annotated
 -accel help
Message-ID: <avckkcvjIoopEuQq@redhat.com>
References: <20261112112956.361209-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112112956.361209-2-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 03:29:56PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> QEMU annotates the accelerator names in "-accel help" with their
> security status, eg "kvm (secure)". kvm_available() compares the
> entries with the plain accelerator name, so the check fails and
> functional tests using require_accelerator('kvm') are silently
> skipped.
> 
> Keep only the accelerator name of each line.
> 
> fwiw, I am surprised we don't seem to have a CI that exercice functional
> kvm tests, or compare against a baseline to avoid this kind of
> regression.

We've intentionally designed our test suite to quietly skip
test with features are detected, so it is hard to detect
when the feature detection itself is not right, as that is
indistinguishable from the feature not being present.

We would need a way to instruct it to abort if the expected
feature is not present, and declare what features each CI
test expects upfront.

> 
> Fixes: d3b770fc6342 ("system: report acclerator security status in help output")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  python/qemu/utils/accel.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



> 
> diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
> index f915b646692e..7e3f43d6b489 100644
> --- a/python/qemu/utils/accel.py
> +++ b/python/qemu/utils/accel.py
> @@ -47,8 +47,9 @@ def list_accel(qemu_bin: str) -> List[str]:
>      except:
>          LOG.debug("Failed to get the list of accelerators in %s", qemu_bin)
>          raise
> -    # Skip the first line which is the header.
> -    return [acc.strip() for acc in out.splitlines()[1:]]
> +    # Skip the first line which is the header, and drop annotations
> +    # such as " (secure)" from the accelerator names.
> +    return [acc.split(' ')[0] for acc in out.splitlines()[1:]]
>  
>  
>  def kvm_available(target_arch: Optional[str] = None,
> -- 
> 2.56.0.116.g6de20f6092dc
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


