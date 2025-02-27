Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F32EC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaFp-0002ek-7J; Thu, 27 Feb 2025 04:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnaF3-00016X-NS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnaEx-0008PO-Jv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740648694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89v9hZYABJ+wAUFxJNmQ17f7WR0uDK72i3erFGo9da0=;
 b=E5SJY5eGoaCV9xNUS9VgdjxBuMzyAAgcQRsXbw/x/V2f1774PxetJgBH5ds/dImxK7xESd
 rHUwBRCXLpBDfPvU0CjrKE5coCe1thLvL/W9t0aYsBhZksM7H72jNt/ofIuhqQOOAmS+jR
 x/udlyY+CbibioADLHx9WuYR0ZAixQs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-Aa0EKx0uOGO9WyZ7zykygw-1; Thu,
 27 Feb 2025 04:31:30 -0500
X-MC-Unique: Aa0EKx0uOGO9WyZ7zykygw-1
X-Mimecast-MFC-AGG-ID: Aa0EKx0uOGO9WyZ7zykygw_1740648689
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 595F2180087B; Thu, 27 Feb 2025 09:31:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89193180035F; Thu, 27 Feb 2025 09:31:26 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:31:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 6/6] qdev: Improve a few more PropertyInfo
 @description members
Message-ID: <Z8Aw6wcsEiU_D7nB@redhat.com>
References: <20250227085601.4140852-1-armbru@redhat.com>
 <20250227085601.4140852-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227085601.4140852-7-armbru@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 27, 2025 at 09:56:01AM +0100, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/xen-block.c             | 2 +-
>  hw/core/qdev-properties-system.c | 2 +-
>  hw/core/qdev-properties.c        | 1 +
>  hw/s390x/ccw-device.c            | 4 ++--
>  target/sparc/cpu.c               | 1 +
>  5 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5a801057db..c04df3b337 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -247,6 +247,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
>  
>  const PropertyInfo qdev_prop_bool = {
>      .type  = "bool",
> +    .description = "on/off",

Awkward as on/off for QemuOpts, but JSON true/false  for QMP, but I
guess clarifying this is beyond the scope of the .description field.

>      .get   = get_bool,
>      .set   = set_bool,
>      .set_default_value = set_default_value_bool,


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


