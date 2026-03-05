Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D345BEEF33C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4hR-0006iH-U6; Thu, 05 Mar 2026 04:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vy4hG-0006ZI-EU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vy4hD-0008H2-RO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772701718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bIm3ie9iqdmUsgZEhS41/Xu0h+LsZpWiRb40U9PuFII=;
 b=V6nGXE6MlXiHpmKtMHjVev+GF+rAYXzARKcj+MBYlfPKz86gitRjVncpz7KplfYgQsNoW1
 zDi3dUIjt84P8sYGuClU9ReGgUYbGWcaZlSvZ2osOp0vgKHeaySaXlZE1RzDAYGpFRcZss
 /7rwNmGCdRoHVCXvF6P+1/BfUMOOVaU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-hujzmvGuNO-ZIRmIgm-akA-1; Thu, 05 Mar 2026 04:08:37 -0500
X-MC-Unique: hujzmvGuNO-ZIRmIgm-akA-1
X-Mimecast-MFC-AGG-ID: hujzmvGuNO-ZIRmIgm-akA_1772701716
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439b5511d5aso4234313f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 01:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772701716; x=1773306516; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bIm3ie9iqdmUsgZEhS41/Xu0h+LsZpWiRb40U9PuFII=;
 b=DN+tIDiNqqqVbtPl9+bIYKOMaadX/bOMx5bQnQviDvRAuWP1o3BfGcWBP/0vvRYEJ0
 PC5JQhzJr3tq7nHNoxyTUPYg7PhHbIlHWxM5sT+jMw8bq+I4DoJUadx6jpb1qG52/oKr
 T3MNtEekh2scq6Gsm4p4LhUv+ceTMLlq7mdXYTfRjT0VUNmc9eqcxiuELIR3v6p7ng4z
 FWojCkOBbrSrHlZ6eYzWVBBT1poGDt44xySQPfrM0fETB8ITmQKFae+vBDmG8GSSUXyq
 wvsZqXkJTYu/gEB4DuQQEOiLmrFFCFju3Fx9vhQ3FX36mWIsk1VP18EFBS6WDvD5yZOi
 DPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772701716; x=1773306516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIm3ie9iqdmUsgZEhS41/Xu0h+LsZpWiRb40U9PuFII=;
 b=TNLtGXoeG4b/BjnxnMFdNjKlgB0rbbTAS4JKCSUuI00/dsHiGLbve8IVOa4BnLLVO3
 CF8PYIaiRD6CD9COu0/evyjp2p6KagTaeES9U1fg8XRDlaEEG01jI2TbGz0A/rIQtUmZ
 M/prw9VjX65Q55zqpShLRKn+vg/yo3pXssO5w7lDtSPgpCk13UHZpOBqH0NVYuPAgkdf
 mWDMj/Egviz9XnilUeTMvg9cVH3n8Cs2gqjyfMibheG1It6ohkpDQeB0Yifoc0N9eoBU
 ATdDUXNHKJMm4c1kYGgr+/GceQIu5vWsYenCNimNDB1XlpsSALrnoHpvBpch2bvLLM6k
 kOXg==
X-Gm-Message-State: AOJu0Yzc0YhMQuW/7da2CuEgKyUVI641UXBMVML/L38Snzx/pjWvRM23
 +ENrQeHwEkFQuMqWWZsBEVj2uKSXLuJP61qq+1yYLDkASnCXLLR7/VdsAHL6Xk4bfYa1Cdvh1hw
 b6QV1ddDJ0ZecHMkpoZdMG5ZNxDiSCJ67ddXh67RWuoBMAT62oRx4O5T3
X-Gm-Gg: ATEYQzx+4CS6wDTiaeC7zW2/uPmTkRMS1+YgPu1pHrpmdTVWWRyBjHq7fpMG9wNwnb7
 o0JPl+HTVxBA1XmTCGshnnP0r9v5/EO7TCJ1RUMftlW0whGRnATw0lOfgkwLmp4Ss6HirzjvzRf
 O9qZgoOu9OHMrEI2MpO06DRH9N78vRENiIf5j0buEaawOiSc8oNILXkKZdt88TOIpgswJU7wg3p
 y4AYyrq7igxEsRnWBdiI5gypYXBMgFZ0J9pKAaCzKG8cnn5yRHenhZ03wYlFqBmeABDirXl/wiI
 dTe9xjd3G/ycHKotPeIdSeveuOYAXB+MN3jC5jVOIFT7+DwxQ1Muwnki4bZ+A8qvSSrf0WW0oai
 lUo1i4xxcL/Vkk/wdFPgiFG0ZHWJEkNqnb0jWdcXteAe0qOWmbsA/nWaUy/ReqVulrMtsaJE=
X-Received: by 2002:a05:6000:288f:b0:439:c5ee:cb5b with SMTP id
 ffacd0b85a97d-439c801297cmr8584944f8f.40.1772701715890; 
 Thu, 05 Mar 2026 01:08:35 -0800 (PST)
X-Received: by 2002:a05:6000:288f:b0:439:c5ee:cb5b with SMTP id
 ffacd0b85a97d-439c801297cmr8584882f8f.40.1772701715292; 
 Thu, 05 Mar 2026 01:08:35 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439af926c53sm42128881f8f.8.2026.03.05.01.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 01:08:34 -0800 (PST)
Date: Thu, 5 Mar 2026 10:08:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 osteffen@redhat.com
Subject: Re: [PATCH] igvm: fix build when igvm is not installed in a well
 known path
Message-ID: <aalHT74pe1GtNzsk@sgarzare-redhat>
References: <20260305-master-v1-1-6574442f5ee8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260305-master-v1-1-6574442f5ee8@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Thu, Mar 05, 2026 at 10:02:11AM +0100, Luigi Leonardi wrote:
>`stubs/igvm.c` includes `igvm-internal.h`, that in turn includes the igvm library.
>This is required just for the QIgvm declaration and creates an
>unnecessary dependency on the library.
>
>Since igvm is not listed as a dependency of stubs, this results in build
>failing when the library is not installed in a "well known" path of the
>system.
>
>Add a forward declaration for QIgvm and move the definition of
>`qigvm_directive_madt` to `igvm.h` so that we can drop `igvm-internal.h` from
>`stubs/igvm.c`.
>
>Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
>

Usually we put all the tags back to back without extra new lines.

>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> include/qemu/typedefs.h        | 1 +
> include/system/igvm-internal.h | 5 -----
> include/system/igvm.h          | 5 +++++
> stubs/igvm.c                   | 1 -
> 4 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>index 416a8c9acead659786f22dfa7542f7af93699cec..cbe6f7f4c7c1092017296cbba09cc79b03b45b79 100644
>--- a/include/qemu/typedefs.h
>+++ b/include/qemu/typedefs.h
>@@ -102,6 +102,7 @@ typedef struct QEMUSGList QEMUSGList;
> typedef struct QemuSpin QemuSpin;
> typedef struct QEMUTimer QEMUTimer;
> typedef struct QEMUTimerListGroup QEMUTimerListGroup;
>+typedef struct QIgvm QIgvm;

So, should we remove the same typdef in include/system/igvm-internal.h 
like we already do for `struct IgvmCfg` where the typedef is only here.

Thanks,
Stefano

> typedef struct QList QList;
> typedef struct QNull QNull;
> typedef struct QNum QNum;
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index 38004bd908e773a3ffc2343a9035be86dc6a8ace..1d36519ab082c02e27461e94850a1ccf6b583e66 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -74,9 +74,4 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp);
> QIgvmParameterData*
> qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
>
>-/*
>- *  IGVM parameter handlers
>- */
>-int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
>-
> #endif
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index 5573a6111ae754e2de49ba72a354b36c4b6fe747..f9231f03ec8015928d0968ac59c72a1b6d9f00b9 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -27,4 +27,9 @@ int qigvm_x86_get_mem_map_entry(int index,
> int qigvm_x86_set_vp_context(void *data, int index,
>                              Error **errp);
>
>+/*
>+ *  IGVM parameter handlers
>+ */
>+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
>+
> #endif
>diff --git a/stubs/igvm.c b/stubs/igvm.c
>index 47d5130d9d7488fb1092a0b5389a864d83e8b2f2..9e9f683fc9607bae85baaaa2f269eba594ae0574 100644
>--- a/stubs/igvm.c
>+++ b/stubs/igvm.c
>@@ -12,7 +12,6 @@
> #include "qemu/osdep.h"
>
> #include "system/igvm.h"
>-#include "system/igvm-internal.h"
>
> int qigvm_x86_get_mem_map_entry(int index,
>                                 ConfidentialGuestMemoryMapEntry *entry,
>
>---
>base-commit: 333aaa55f051977cc897fb71e0a9ed52bb00a675
>change-id: 20260305-master-e118b38e314e
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


