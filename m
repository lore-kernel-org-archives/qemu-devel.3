Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5CDC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBexi-0000WB-Cy; Mon, 27 May 2024 14:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBexh-0000Vj-Jk
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBexg-0007NL-2w
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716834043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiQ5SAW7MzgSMgVxF5Dijk1dxHGt//ev/81U+kF+zFQ=;
 b=bBKNDnfw5rkiVqeqolpLlEJUkgjJx9ynuEB32QED4jxrVawRNdui9mprXAaPk/2r6/D9Qo
 k7MVBIdO6PbmU4VM1cTWB/b5P01l3cOK+kiYDoPSDvOBhJMGFoZsPjX8k9RQraacAjr2o0
 IaGf3+/LqoETAZpwCA0Hddn8rv8qsso=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-JAv9VLcaPj2ZV7rx_5Hi8g-1; Mon, 27 May 2024 14:20:41 -0400
X-MC-Unique: JAv9VLcaPj2ZV7rx_5Hi8g-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5b970b125fcso3760eaf.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716834041; x=1717438841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiQ5SAW7MzgSMgVxF5Dijk1dxHGt//ev/81U+kF+zFQ=;
 b=c73ag6lqJ1BG3VGS5bd6wX5tNCnuf0uR9jJ+X3y6uHhbInfKuYK/gMqMu2SryKPDg9
 O8lh9o29Lfft0/2tuDjbKkilB583r78IloGOArTsO/kk0pZai9An0wlhph9Af0d2VEqh
 MzEg5Qqs3ht2cl0ORkgp0WsMZv7hWJJm9thxjxQaca8Dmaq4ZWYzGWTRtNul1jpv8hnx
 xftsRXdE72I5yR7aVj149cKk4T0C1uBZtXYgFeAwPkiOIbNUruydgX8Zw9zG8ysGfToo
 T0kVnq6OElVI/v9c1hKrGVfZs/L0k9w5EY9o4HlQSOSEBTlovnqcWLrssKsgR61l4XiQ
 9SLg==
X-Gm-Message-State: AOJu0Ywveg/CNN0B1MZgXu3wR90zIpr2lZfDOofiB0GebR2ThP8xxLN2
 xVDaSNO2JG4wSAYVJzcRJH3SNoONxwtzOQbFBGTSjlUgshH9fPvu45LUqoFl67Uv9D71ItMLIAn
 cm70vtg6o4Lqv4E5Lv2QyLJ/+L0lLFKId7w64H7/lF4rbZpEg0Kj/
X-Received: by 2002:a05:6870:89a5:b0:24f:cc8a:b407 with SMTP id
 586e51a60fabf-24fcc8ac55bmr8182150fac.3.1716834040656; 
 Mon, 27 May 2024 11:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD1Dd0skwd/0jj41lbJ0MXWoWL3U4jqLaHIp7ZpyhtGt/0cp+NRj76Mn8DAcf/a1HmurFN8w==
X-Received: by 2002:a05:6870:89a5:b0:24f:cc8a:b407 with SMTP id
 586e51a60fabf-24fcc8ac55bmr8182120fac.3.1716834040132; 
 Mon, 27 May 2024 11:20:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb17c8a6bsm35523741cf.21.2024.05.27.11.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 11:20:39 -0700 (PDT)
Date: Mon, 27 May 2024 14:20:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 07/26] migration: VMStateId
Message-ID: <ZlTO9fVYG50r3XL9@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Apr 29, 2024 at 08:55:16AM -0700, Steve Sistare wrote:
> Define a type for the 256 byte id string to guarantee the same length is
> used and enforced everywhere.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/exec/ramblock.h     | 3 ++-
>  include/migration/vmstate.h | 2 ++
>  migration/savevm.c          | 8 ++++----
>  migration/vmstate.c         | 3 ++-
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 0babd10..61deefe 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -23,6 +23,7 @@
>  #include "cpu-common.h"
>  #include "qemu/rcu.h"
>  #include "exec/ramlist.h"
> +#include "migration/vmstate.h"
>  
>  struct RAMBlock {
>      struct rcu_head rcu;
> @@ -35,7 +36,7 @@ struct RAMBlock {
>      void (*resized)(const char*, uint64_t length, void *host);
>      uint32_t flags;
>      /* Protected by the BQL.  */
> -    char idstr[256];
> +    VMStateId idstr;
>      /* RCU-enabled, writes protected by the ramlist lock */
>      QLIST_ENTRY(RAMBlock) next;
>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;

Hmm.. Don't look like a good idea to include a migration header in
ramblock.h?  Is this ramblock change needed for this work?

-- 
Peter Xu


