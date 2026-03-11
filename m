Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBC71125855
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MpK-00080S-Pr; Wed, 11 Mar 2026 12:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w0MpJ-0007zy-55
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w0MpG-0006T9-Jp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773248063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lho0lIkY17uk1ObMm9n5PAumyRBV6AJ97Kc4KYwnEMI=;
 b=idXloMn6w9SHlX9wcn9m3QYIV8u5ysRWI7j5NWSMw9NoyyPFC9ZWZhA3gpvMvljOE+B6eJ
 qkswd3nRZCEA/quapg+j+pw8vJDmZ9FO5tgoc97tq257KeT/4640R4IkgGORWQ7CjDVSxe
 qDnIqEv08w15rU00vXFY9/xmo0LEuDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-4jvN2FtlOVGo2UKwCxjlsA-1; Wed, 11 Mar 2026 12:54:22 -0400
X-MC-Unique: 4jvN2FtlOVGo2UKwCxjlsA-1
X-Mimecast-MFC-AGG-ID: 4jvN2FtlOVGo2UKwCxjlsA_1773248061
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853b5b0fafso749055e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773248061; x=1773852861; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lho0lIkY17uk1ObMm9n5PAumyRBV6AJ97Kc4KYwnEMI=;
 b=BdC/h68O10sfK/MjV/MxrlBmuYslnv59Avo6XLxH/v9Jp2Ukjl45VD30prwAwHLMLU
 TAvBy4Umqf6XgTehytzhTwCSXi4fmhVYRhUMSCQF80UoFwtHqrLsSiydNxf11Zfl41Ec
 Jn0a7T/JBawSA2MxOriguzigUilML08qOhtuSPjYytv2WIyjAIhYTJ29OD5aglQn2dJo
 pEey6/hzuRm4cCPXnCa9UUXR9tTzj8aOC8TJ2JdBkaXGKZq62S+d/qBp+NkH+Tf88Luq
 Bq2jozUsNhMjC9+VpDTwkRi9vASP7uK4l5fKbUF7GP40Q7pqrb4GraBsKxEGfzZMbGpt
 s1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248061; x=1773852861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lho0lIkY17uk1ObMm9n5PAumyRBV6AJ97Kc4KYwnEMI=;
 b=wN8JbrRs2SZ1W36RpvKwy6Y8AElvEt0iouxo5z6eRQcoPokj4dc7EFvZC2i7jCV1n7
 NkPfi9qcqZT1TIuGoNUEGChapKAayorxzTkuctBq6zWHr1aiu6RW/NxCSQQ9qW7LL4AU
 nfldIq6qnEZ5PSuZ0hvCHPy7OufHmdKtlAUeiE5QOgMMlA1q5xQI6VHBKkxz0z5qZ565
 Vl+dOGTcda8rUrp9EdwXbg4n2KTHM2y/UhDXv2QDmcHHosLzYE8jEiyCP4XvNscv9B2Z
 FFuG4BqIcqRwPT/Nj0qZ9TKBy7X22HB1LZBr3c6CfDfHqNbvYIU/ibnP1fk2unNfDRQ+
 sjSg==
X-Gm-Message-State: AOJu0Yzx7wMtiasCfL6iBo4UERC0Nro4+jWY6AjPx+ded9rSEFPAPRh3
 I7Tg95kTZD55OLcJK8sVbf/HRzZOzTAr4XXBogVNfcS9mbz/NR8/A5MpfCnJLaG92D0x0hfRTiv
 vO9n+N+zKVyxq2ngBw5fOyj/Js03Cvr1bXdGiVX14Wo1rD4H9CKVcE43Z
X-Gm-Gg: ATEYQzwbR0jKAPgrB5tv4ApXcW5zdbK95bBHp6LMXiw+GtTKtScvPpq5MOFOTfaUOmA
 RJzmuw0kv/UQL+bU0vgml1xV4FhDirz7VbLZ31mRcJEJwQ4CJDUXNK7pVvIkxyzSFe8ABqixvO0
 N0pJzb+2/KtF2BXM/s3HXFetMtpzBxE6/joULpUgOLfARS5xTfGbo1QTpJ91jQFrCS9tz+v6/s+
 /rV/iT7C2fgO9pSh1Y8LPJ1OoEjs/bC7xI6HddX3ZqGOmQMz4284Gv38XVW1KkHT+njwndoGipc
 i4bv3qCqDvxEYhbebYUgTPs0yKBiCVOEF8g0jVCWWotbrDKv5jTgdsEaSwISViE+DyzzdCAzm8/
 Nv0YyZG6ylxURxySsyTWnhujwzoc=
X-Received: by 2002:a05:600c:1e88:b0:485:3ff1:d5c3 with SMTP id
 5b1f17b1804b1-4854b0cb356mr54943015e9.5.1773248061307; 
 Wed, 11 Mar 2026 09:54:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1e88:b0:485:3ff1:d5c3 with SMTP id
 5b1f17b1804b1-4854b0cb356mr54942635e9.5.1773248060841; 
 Wed, 11 Mar 2026 09:54:20 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm181718875e9.5.2026.03.11.09.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:54:20 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:54:18 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] typedefs: move QIgvm out of typedefs.h
Message-ID: <abGdQciQmo2pWFj_@leonardi-redhat>
References: <20260311162045.563301-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260311162045.563301-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On Wed, Mar 11, 2026 at 05:20:45PM +0100, Paolo Bonzini wrote:
>Typedefs.h should only be used for really core types; QIgvm is
>just an opaque struct that is defined in system/igvm-internal.h,
>and the typedef itself can be placed simply in system/igvm.h.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> include/qemu/typedefs.h | 1 -
> include/system/igvm.h   | 3 ++-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>index cbe6f7f4c7c..416a8c9acea 100644
>--- a/include/qemu/typedefs.h
>+++ b/include/qemu/typedefs.h
>@@ -102,7 +102,6 @@ typedef struct QEMUSGList QEMUSGList;
> typedef struct QemuSpin QemuSpin;
> typedef struct QEMUTimer QEMUTimer;
> typedef struct QEMUTimerListGroup QEMUTimerListGroup;
>-typedef struct QIgvm QIgvm;
> typedef struct QList QList;
> typedef struct QNull QNull;
> typedef struct QNum QNum;
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index f9231f03ec8..64d3542311a 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -13,10 +13,11 @@
> #define BACKENDS_IGVM_H
>
> #include "hw/core/boards.h"
>-#include "qemu/typedefs.h"
> #include "system/confidential-guest-support.h"
> #include "qapi/error.h"
>
>+typedef struct QIgvm QIgvm;
>+
> int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
>                        bool onlyVpContext, Error **errp);
>
>-- 
>2.53.0

oops :) Thanks Paolo!

I wonder if we should move IgvmCfg as well?

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


