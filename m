Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E797FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIM7v-000846-H3; Thu, 30 Apr 2026 03:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIM7t-00083v-NK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIM7s-0006mF-9g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777535278;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Jn1LWrJbwruOzLCOT4G83sXyuup+rnmCL4txDE4+SmY=;
 b=hNUf202sy7nqg7dFe08Xco2Yu2Q46WUqB/in3Ili4NQ1dnK8ud2+VvV5jIvhxoFf3J7xNT
 oyFxH/gzVhdgfQWdPJq3gVCU1nE6Dw2ByPlV6uNfkjakWEwqZ0P0MRVvNKrzsDYi93GDAo
 LZeLA06aO1ak2t/DgQHqTr6+c1YLLHE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-8a_-l293Nm6oL_O4OPTTnA-1; Thu,
 30 Apr 2026 03:47:57 -0400
X-MC-Unique: 8a_-l293Nm6oL_O4OPTTnA-1
X-Mimecast-MFC-AGG-ID: 8a_-l293Nm6oL_O4OPTTnA_1777535276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68E9918005B6; Thu, 30 Apr 2026 07:47:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85DF81955D84; Thu, 30 Apr 2026 07:47:51 +0000 (UTC)
Date: Thu, 30 Apr 2026 08:47:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 5/7] system/vl: register target info types first in qom
Message-ID: <afMBbYSwZcobHaUY@redhat.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-6-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430035626.3511676-6-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 29, 2026 at 08:56:24PM -0700, Pierrick Bouvier wrote:
> We will introduce detection of target from QOM, so we need to make sure
> those types are registered. As well, it ensure no other types are
> registered yet, so we can safely call object_class_get_list.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/qemu/module.h           |  1 +
>  include/qemu/target-info-init.h | 17 +++++++++++++----
>  system/vl.c                     |  3 +++
>  target-info-qom.c               | 18 +++++++++++-------
>  4 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 9885ac9afb3..fccf017bf9e 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -43,6 +43,7 @@ typedef enum {
>      MODULE_INIT_MIGRATION,
>      MODULE_INIT_BLOCK,
>      MODULE_INIT_OPTS,
> +    MODULE_INIT_TARGET_INFO,

Please introduce a MODULE_INIT_QOM_EARLY as requested in v1. As well
as being needed for the base classes in an earlier patch, it is
inevitable that we will find module scenarios needing early init
over time. 

>      MODULE_INIT_QOM,
>      MODULE_INIT_TRACE,
>      MODULE_INIT_XEN_BACKEND,


