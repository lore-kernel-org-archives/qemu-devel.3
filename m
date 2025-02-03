Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6F6C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezm1-0004Qc-EP; Mon, 03 Feb 2025 11:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tezly-0004QJ-ES
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tezlw-0001Fm-5k
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738601887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GF8ESsPP+Y/vGPeQZWgi7K8pyyFlCuq7opYR0iP4aOU=;
 b=MR5k53nZaW/1NBzCUSO5hgXTPddlBVr7LVfqRCGLACZgNaqKeZlAd7gYA2NKGp3z7GINlN
 2ezU4FP/nL8TWVGczekD2VWaqap9bPmc0TVNGYqFzPjVd2QRG0YjreSZOIGGDCAvixA6CD
 hgWaNkkAPbXvT0S5tOqyPRMoorj9mh8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-7vv_Ngm8MX-1QhX0_XGPTg-1; Mon, 03 Feb 2025 11:58:05 -0500
X-MC-Unique: 7vv_Ngm8MX-1QhX0_XGPTg-1
X-Mimecast-MFC-AGG-ID: 7vv_Ngm8MX-1QhX0_XGPTg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46dd301a429so98781561cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601885; x=1739206685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF8ESsPP+Y/vGPeQZWgi7K8pyyFlCuq7opYR0iP4aOU=;
 b=UypGWozm3LO4OLAFnQWnZZw5NDftQPhig+TRuKScqOjihQRNqY7tb/YmpQJcJuKrfb
 9J7XR18eBiDDluUu5xJlEwICacK8jnNIrFnKceJDVAg6eQddeHao7DpTJAjjcUFLHNGV
 40QLgi1F5KptF/onDnIjCvvBySzs4ZDaihxbzeWFwbpUXC1FVST6oU/a0lqk9Lcn9Db2
 Fu7DmNgMmWDlMzJkLb/LSFOOTprWWgm274aXEOhp1ArBMCzmm9Iu1rtxo9hiFY7gtPKs
 QsTAvtmtKsi85fpX5M9eVSMT+tlG/1e7o7WTbxGwBaOWYsmf9Ox19kl9af/Owh9W2HAF
 xrkA==
X-Gm-Message-State: AOJu0Yw7O/q2BbJ2oeNU+iz3SboXURatFxGGxr08RRwft4R7E1CmALqm
 TetHs0NDLIDdjqEbA8qGcajF08rQIQvZKcL9ikAYPO93wOTq3Kiog7igiPXZNKPI4qydYZSNVEP
 ZUBePjbNLmhFVyxIDyPqFG/RpBhqAHUS9M7A+AQML1Y2VlLSuUv8s
X-Gm-Gg: ASbGnctmEZdkxW/8YWEaRdmiupzvWlk0Yr+yDH8nEb4erSpSUbEijuqnvHYKyEL7N3S
 r7aMnBRh1QhLJpKQvTIVaUpGsfQIlETYUv7lHJKkpi/SZJm/G75KwOKLqbUJ74n+u6RS6hrrOEN
 NERZBFN4RkYJseLqly7jej4lCVYPcNaWrYfiCiicjjPlbvVRd5tM+cqT9eQopjLpVQ+tnWIFGna
 4lgsyatCecYQK6SRkmcS+DvLU4/VrdBjuezD/pQhu5OQyuJIpZp6RSQy2IALx5QTPTnWM6qUGFK
 WpFP+1yD0Z5U9XRvEazwiSNOiYjKbKo8gFkvtXUc0Fwr9k++
X-Received: by 2002:ac8:7d92:0:b0:45d:8513:f29a with SMTP id
 d75a77b69052e-46fd09e25c1mr217889011cf.9.1738601885408; 
 Mon, 03 Feb 2025 08:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo2FstP/7OXmlEis6ImXcqfO7gaULyUROlBuYtR0RK6kDfzFq4vION+d84TA57Wb1Q+z+btw==
X-Received: by 2002:ac8:7d92:0:b0:45d:8513:f29a with SMTP id
 d75a77b69052e-46fd09e25c1mr217888781cf.9.1738601885057; 
 Mon, 03 Feb 2025 08:58:05 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0ac4sm50541801cf.39.2025.02.03.08.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:58:04 -0800 (PST)
Date: Mon, 3 Feb 2025 11:58:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V1 02/26] migration: lower handler priority
Message-ID: <Z6D1m_jZ8hb0jBHL@x1.local>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1738161802-172631-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 29, 2025 at 06:42:58AM -0800, Steve Sistare wrote:
> Define a vmstate priority that is lower than the default, so its handlers
> run after all default priority handlers.  Since 0 is no longer the default
> priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.
> 
> CPR for vfio will use this to install handlers for containers that run
> after handlers for the devices that they contain.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/vmstate.h | 3 ++-
>  migration/savevm.c          | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index a1dfab4..3055a46 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -155,7 +155,8 @@ enum VMStateFlags {
>  };
>  
>  typedef enum {
> -    MIG_PRI_DEFAULT = 0,

Shall we still keep a defintion for 0?  Or at least add a comment link to
save_state_priority() - it might be helpful for whoever jumps to this enum
defintion when reading.. and get confused how a default value is non-zero.

Or define it as something like:

       MIG_PRI_UNINITIALIZED = 0,  /* Most devices don't set a priority, it will
                                    * be routed to MIG_PRI_DEFAULT */

> +    MIG_PRI_LOW = 1,            /* Must happen after default */
> +    MIG_PRI_DEFAULT,
>      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
>      MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
>      MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 264bc06..5dd2dc4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -232,7 +232,7 @@ typedef struct SaveState {
>  
>  static SaveState savevm_state = {
>      .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
> -    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
> +    .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
>      .global_section_id = 0,
>  };
>  
> @@ -704,7 +704,7 @@ static int calculate_compat_instance_id(const char *idstr)
>  
>  static inline MigrationPriority save_state_priority(SaveStateEntry *se)
>  {
> -    if (se->vmsd) {
> +    if (se->vmsd && se->vmsd->priority) {
>          return se->vmsd->priority;
>      }
>      return MIG_PRI_DEFAULT;
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


