Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDCBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VPf-0002tY-0E; Tue, 30 Sep 2025 04:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3VPd-0002sR-9i
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3VPY-0004JJ-S3
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759219712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8qSx7+ZzzZP8fWOz/hxAVCcPbe1k8lKlExsvrZBqM1I=;
 b=CtJmFcmWsp4li+cmMyyst5V5CwT+sTR5mOPmeCiNbygkYpnth+0Ik2xEfFo88N/SCiwJVR
 Dm9QWVNZJg0pBIN7KhgZe24IOjxYavmyk+htYZ8K3CBHxpFgoNgXfGBKCYoN9CeATGDv8Y
 1V1M/sKgnQYmTbu5/Exg2yEjDtNWVnQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-mcYFq2I0P6Wsgj9WUFi69A-1; Tue,
 30 Sep 2025 04:08:29 -0400
X-MC-Unique: mcYFq2I0P6Wsgj9WUFi69A-1
X-Mimecast-MFC-AGG-ID: mcYFq2I0P6Wsgj9WUFi69A_1759219708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FBBE1800372; Tue, 30 Sep 2025 08:08:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9877230003BA; Tue, 30 Sep 2025 08:08:26 +0000 (UTC)
Date: Tue, 30 Sep 2025 09:08:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] subprojects: Update .gitignore for syn
Message-ID: <aNuP98uhOzOd5glp@redhat.com>
References: <20250930075351.1853721-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250930075351.1853721-1-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 03:53:51PM +0800, Zhao Liu wrote:
> The commit a530a8d4ac39 missed to update syn version, this is because
> the code base of its v2 patch has fixed syn version, so that the fix for
> syn were lost during the rebase from v1 to v2.
> 
> To rectify this mistake, update the syn version.
> 
> Fixes: a530a8d4ac39 ("subprojects: Update .gitignore for proc-macro2 and syn")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  subprojects/.gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> index 58a29f012044..136e30cd99ad 100644
> --- a/subprojects/.gitignore
> +++ b/subprojects/.gitignore
> @@ -19,7 +19,7 @@
>  /proc-macro-error-attr-1.0.4
>  /proc-macro2-1.0.95
>  /quote-1.0.36
> -/syn-2.0.66
> +/syn-2.0.104
>  /unicode-ident-1.0.12

IMHO we should get rid of all the version numbers, and use wildcard
matches instead, to eliminate the bug scenario entirely, as people
will repeatedly forgot to change these versions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


