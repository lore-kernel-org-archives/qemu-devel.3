Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EC9C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOtc-0003Ti-CW; Tue, 04 Mar 2025 04:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpOta-0003SE-Dq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 04:49:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpOtY-00025J-Fp
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 04:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741081739;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KGgSBcKw/ORrecChmPUqIwizr5y5vMFqUrqsyH1QYQ=;
 b=gk6jw9QAug6E89pNOtJ5DjAdHxLNmwOpbdmFH6OrFJT60Z5i4MniY5mn5ctBYRrEn3sU/n
 WHdKsEXpu8hHfXHy+N8v50HSPJU34WdrORv37CbQrNI0doPsTkFiFiqv55eRUFWjHxf6dw
 22MAPMrLlwIsQ5gYQ5Xup5pykBCUOL4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Nns0qJp9OXyighTirEvyTw-1; Tue,
 04 Mar 2025 04:48:57 -0500
X-MC-Unique: Nns0qJp9OXyighTirEvyTw-1
X-Mimecast-MFC-AGG-ID: Nns0qJp9OXyighTirEvyTw_1741081736
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A24261800268; Tue,  4 Mar 2025 09:48:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB61B1800366; Tue,  4 Mar 2025 09:48:53 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:48:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] scripts/checkpatch: Fix a typo
Message-ID: <Z8bMgmWWtML2F9S9@redhat.com>
References: <20250303172508.93234-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303172508.93234-1-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Mar 03, 2025 at 06:25:08PM +0100, Philippe Mathieu-Daudé wrote:
> When running checkpatch.pl on a commit adding a file without
> SPDX tag we get:
> 
>   Undefined subroutine &main::WARNING called at ./scripts/checkpatch.pl line 1694.
> 
> The WARNING level is reported by the WARN() method. Fix the typo.
> 
> Fixes: fa4d79c64da ("scripts: mandate that new files have SPDX-License-Identifier")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Possible candidate to apply on /master as buildfix
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Urgh, sorry about that, thanks for fixing my messup.

> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 83b59fb4436..6ae9d7febee 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1691,8 +1691,8 @@ sub process {
>  				  "'SPDX-License-Identifer'");
>  			} else {
>  			    # Other files MAY have SPDX license if appropriate
> -			    WARNING("Does new file '$expect_spdx_file' need " .
> -				    "'SPDX-License-Identifer'?");
> +			    WARN("Does new file '$expect_spdx_file' need " .
> +				 "'SPDX-License-Identifer'?");
>  			}
>  		    }
>  		    $expect_spdx = 1;
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


