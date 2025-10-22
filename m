Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72013CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXgN-0006S7-22; Wed, 22 Oct 2025 08:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBXgL-0006Rr-6T
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBXgI-0006ED-8I
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfKk6EKmoL9ozvf83OfBuanaYxQ8B27KRXyonsPJ7Xo=;
 b=bODBMqWBVyVOmI6TT6vPlNSOLIb87ek7JGULuDVtfI7J3UZVLGwJvi4wAMw9bWPgrav9/E
 ZfrI4muSV33KDhBhOnRx1MM8y2XMtbfApuNHfxgJn0fXY4rtM5GLlNWPetfFzazkQGkRbo
 2iaaGm+2pwiv0oPolZyFhyt7JHILiLg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-lMD6jPCaOH2sk0r4XIcPHA-1; Wed, 22 Oct 2025 08:09:51 -0400
X-MC-Unique: lMD6jPCaOH2sk0r4XIcPHA-1
X-Mimecast-MFC-AGG-ID: lMD6jPCaOH2sk0r4XIcPHA_1761134991
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-891504015e5so435309285a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761134991; x=1761739791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfKk6EKmoL9ozvf83OfBuanaYxQ8B27KRXyonsPJ7Xo=;
 b=pMk+nc4GL8vaFAtHI4ym9DB7PzcH4K/MbUPwqQ0pfniNo4pXlpl++we/HMu5GvbgTp
 YjtIuXmxhfVmKVHEFvHVLTCABw925QGdbcncdLZxEOzOTuRA6tJ+A7dRdS5P9h43amBB
 t0CHef9oIZFfa7tNUuiyXDbLKodWvKTqPTK/FKfz+CG8Z2zuRXoL09fbuqwBj1KwOsjR
 NBxC3YiXf9tV5o+fADm3hzczlCg7F9rIUwNNew00j8isbj7/DKW2zEExkce8/JGWt/Cx
 LtPvN8jPJp1HXSuLUbY5QqEvC1xIbx+lFojpQPeeJzOB6219JKSwHZo851YlfvQc4eJg
 CTfA==
X-Gm-Message-State: AOJu0Yy7xEChvhTJiR+8rjbRZZx8k7z1qJClsoHF3QXhoRG9En2yaigi
 PthwApmMyMI/qbR40Ow/+kiMxF2WPx9e5u+QxEPDE5EIYzvdFG8kzEEuKEqlo98K0dUKK/FyAJO
 dxG+DujujxikLRW+rLzT0KTi74Pa6QGu4m/l1Zm2yClCnkiOc18JiL962
X-Gm-Gg: ASbGncv5oloTf93GASxVCRMh/iyMKL2FAR55KzaM8/+PmpuVovvFO8B5/Mzu5kM0qeC
 f1LSk+XaTn6NokfSv0DzSR7wjqlRG1NpWshhceysO2un0i6NtcpFq9BtI1+6PDltL38GNDt0iDo
 3cX856KMTfXCL510MF3Xn5e1wbNkkAdZusMgMyF96uvTPAM1YaPHts0da6t/yk/oYKYa+zlQ+X3
 eUgH+C4T+/s6jMqh6xi7wstGpcjfBrFwNQZxIGzEg7p/c8NtokFhijA5rN0PAgtDO3AY7PIuXkf
 OtOU3mhmVn0o63s3403Xm2IDIwDAG/4/vcKz0MzLtOuKtJD/lC0UMkjlecnmledV98vmInzrsbg
 BJ1w=
X-Received: by 2002:a05:620a:4053:b0:891:a6b0:7cda with SMTP id
 af79cd13be357-891a6b081c2mr2128333785a.81.1761134991364; 
 Wed, 22 Oct 2025 05:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1uDwFA8uNiXwptppDJAOJv4rM7738+GmgsQWAvKtcZTPLxnYWGSGIFF5o399wogo4S4Qtw==
X-Received: by 2002:a05:620a:4053:b0:891:a6b0:7cda with SMTP id
 af79cd13be357-891a6b081c2mr2128329785a.81.1761134990921; 
 Wed, 22 Oct 2025 05:09:50 -0700 (PDT)
Received: from leonardi-redhat ([151.29.47.252])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cefba740sm955129285a.29.2025.10.22.05.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:09:50 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:09:46 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 1/5] igvm: move igvm.h file to include/system
Message-ID: <rxjm52dvlrxpmhmwvs6zp2j5gex7xp3kzefgjh7jx77fihe4l6@65m35qp4nmak>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022084439.242476-2-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 22, 2025 at 10:44:35AM +0200, Gerd Hoffmann wrote:
>Prepare for arch-specific igvm code being added to the code base.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>Reviewed-by: Ani Sinha <anisinha@redhat.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> {backends => include/system}/igvm.h | 0
> backends/igvm-cfg.c                 | 2 +-
> backends/igvm.c                     | 2 +-
> 3 files changed, 2 insertions(+), 2 deletions(-)
> rename {backends => include/system}/igvm.h (100%)
>
>diff --git a/backends/igvm.h b/include/system/igvm.h
>similarity index 100%
>rename from backends/igvm.h
>rename to include/system/igvm.h
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index 45df63e06c1a..d00acf351249 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -12,7 +12,7 @@
> #include "qemu/osdep.h"
>
> #include "system/igvm-cfg.h"
>-#include "igvm.h"
>+#include "system/igvm.h"
> #include "qom/object_interfaces.h"
>
> static char *get_igvm(Object *obj, Error **errp)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 9ad41582ee5e..723d45b755a0 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -11,8 +11,8 @@
>
> #include "qemu/osdep.h"
>
>-#include "igvm.h"
> #include "qapi/error.h"
>+#include "system/igvm.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>-- 
>2.51.0
>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


