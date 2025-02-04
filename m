Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478E9C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIYa-0001j3-2s; Tue, 04 Feb 2025 08:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfIYI-0001cU-0D
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfIYE-0004sy-5e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738674071;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCMzk6K9ok6u+iGaB5Dlm0fr7hDIoGpmYq7P/OjM+Bk=;
 b=Mt48p2NdN3W0j8aoRD6kUw1B4iUt/RZGBW7hwvVt4ICd35cDrSfw8kI+0x7WtnLprUWj5/
 Gs4iobrYru+lAgBcwzmJEFgXcBmFrZdVB3KQiMGICZOvB8WZQpooN6lDuqfU1vTIAEKLxt
 Vl6Of0ikN3oeIo6WFd4IrMdueCNG5RA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-ASaKM-APMZ-VisEQPW6Dww-1; Tue,
 04 Feb 2025 08:01:08 -0500
X-MC-Unique: ASaKM-APMZ-VisEQPW6Dww-1
X-Mimecast-MFC-AGG-ID: ASaKM-APMZ-VisEQPW6Dww
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8EA11955DDD; Tue,  4 Feb 2025 13:01:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89CAA1800268; Tue,  4 Feb 2025 13:01:04 +0000 (UTC)
Date: Tue, 4 Feb 2025 13:01:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options: Deprecate -old-param command line option
Message-ID: <Z6IPjKFsUCWFhBk5@redhat.com>
References: <20250127123113.2947620-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127123113.2947620-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 27, 2025 at 12:31:13PM +0000, Peter Maydell wrote:
> The '-old-param' command line option is specific to Arm targets; it
> is very briefly documented as "old param mode".  What this option
> actually does is change the behaviour when directly booting a guest
> kernel, so that command line arguments are passed to the kernel using
> the extremely old "param_struct" ABI, rather than the newer ATAGS or
> even newer DTB mechanisms.
> 
> This support was added back in 2007 to support an old vendor kernel
> on the akita/terrier board types:
>  https://mail.gnu.org/archive/html/qemu-devel/2007-07/msg00344.html
> Even then, it was an out-of-date mechanism from the kernel's
> point of view -- the kernel has had a comment since 2001 marking
> it as deprecated. As of mid-2024, the kernel only retained
> param_struct support for the RiscPC and Footbridge platforms:
>  https://lore.kernel.org/linux-arm-kernel/2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com/
> 
> None of the board types QEMU supports need param_struct support;
> mark this option as deprecated.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/about/deprecated.rst | 13 +++++++++++++
>  system/vl.c               |  1 +
>  2 files changed, 14 insertions(+)

I think it is reasonable to remove this extreme special case given
the history around it

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 29de49351d1..a4c7d642236 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -68,6 +68,19 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
>  marked deprecated since 9.0, users have to ensure that all the topology members
>  described with -smp are supported by the target machine.
>  
> +``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``-old-param`` command line option is specific to Arm targets:
> +it is used when directly booting a guest kernel to pass it the
> +command line and other information via the old ``param_struct`` ABI,
> +rather than the newer ATAGS or DTB mechanisms. This option was only
> +ever needed to support ancient kernels on some old board types
> +like the ``akita`` or ``terrier``; it has been deprecated in the
> +kernel since 2001. None of the board types QEMU supports need
> +``param_struct`` support, so this option has been deprecated and will
> +be removed in a future QEMU version.
> +
>  User-mode emulator command line arguments
>  -----------------------------------------
>  
> diff --git a/system/vl.c b/system/vl.c
> index c5678267182..32ee1ce7041 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3438,6 +3438,7 @@ void qemu_init(int argc, char **argv)
>                  nb_prom_envs++;
>                  break;
>              case QEMU_OPTION_old_param:
> +                warn_report("-old-param is deprecated");
>                  old_param = 1;
>                  break;
>              case QEMU_OPTION_rtc:
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


