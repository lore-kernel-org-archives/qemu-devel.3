Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8C5D1D882
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 16:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0k4Z-0008D7-Cg; Tue, 15 Oct 2024 12:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0k4I-0008CE-Ce
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0k4F-0003pc-3S
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729008397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gK6xoO0U8OgwkwERg1fRthXuoEip1CP9vLdL7OWRgf0=;
 b=RTBvDIrs1Zaa6F843uR/HFWud31ZjGa7uboVTgUk2kTVQ9xfTR9rd1dwp6W+If/YBIRMiB
 LzGCQsDLYKOpJdEo0SVxoKYs25K0d1Co30t0UbgHgrosgwWHWo2JNyCFfm983788WA0aJZ
 d8+TRioYSDDgRvIPrZ50pUuJl/NVAyQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-n-KDRVmxMcmO0H6b75ptEg-1; Tue, 15 Oct 2024 12:06:35 -0400
X-MC-Unique: n-KDRVmxMcmO0H6b75ptEg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbe4a123fdso94119816d6.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 09:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729008394; x=1729613194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gK6xoO0U8OgwkwERg1fRthXuoEip1CP9vLdL7OWRgf0=;
 b=ByNin6IkX0gJgMPhZfv+qmSSpMNwi14gXajlOWCjwB0qrGDZdueLFHCfnvmQsKKnvZ
 28ouQhCJ2RKKj+ZGn8ic2bduMZAnBCJwFQweEYbvdCTmW0UHp5R/qD+D7pVlpghvMyK7
 0PpcsWqt1VFue3gbGn0NQkuJVlo6VkdpZGwK/kLWXD2oS3CZ/ZM4mTyX9CHEH/4qeuzk
 Z47wa5Ss0JSCTlyK1BthKdqZlIZcr2LeK/ITDkkZ0LxYQ6PHGWsCfKy6nm463iVUVCgZ
 V3vhmv0e5MpOUtGYDcfTwN+JYDnenJggvyxiGDCZ+sI2GG+HdCe4CmdICHnFZwm3tIQU
 i3WQ==
X-Gm-Message-State: AOJu0YxttVBblP4R0bbN8c9I48yth/++SImyld7iyxL6JjN8Gt1F7mEA
 NaC7cDNuiCF50sOmALHim7ws1N1lUtLRtioUxztRjY3fhqgBlOdcLIaU2NeqKRXUWhqNe6rgFEN
 qTdw9Nr1MRQ175TKp0sNJZFoYIfZY/LTEHqVt9/0WtchyohvsZkTN
X-Received: by 2002:a05:6214:5785:b0:6cb:eb66:c37a with SMTP id
 6a1803df08f44-6cbf00ec482mr175711336d6.53.1729008394486; 
 Tue, 15 Oct 2024 09:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH69Lr6GqKclEz9wOIaXncCNmgjG3A+t+i8UcJQdMUqqpiqYIeDlin7v1GrbMXBSjD9q3ztHQ==
X-Received: by 2002:a05:6214:5785:b0:6cb:eb66:c37a with SMTP id
 6a1803df08f44-6cbf00ec482mr175710956d6.53.1729008393909; 
 Tue, 15 Oct 2024 09:06:33 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22921b34sm8246126d6.46.2024.10.15.09.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 09:06:33 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:06:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] migration: Ensure vmstate_save() sets errp
Message-ID: <Zw6TBx0HPf1OhXD7@x1n>
References: <20241015141515.150754-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015141515.150754-1-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 15, 2024 at 04:15:15PM +0200, Hanna Czenczek wrote:
> migration/savevm.c contains some calls to vmstate_save() that are
> followed by migrate_set_error() if the integer return value indicates an
> error.  migrate_set_error() requires that the `Error *` object passed to
> it is set.  Therefore, vmstate_save() is assumed to always set *errp on
> error.
> 
> Right now, that assumption is not met: vmstate_save_state_v() (called
> internally by vmstate_save()) will not set *errp if
> vmstate_subsection_save() or vmsd->post_save() fail.  Fix that by adding
> an *errp parameter to vmstate_subsection_save(), and by generating a
> generic error in case post_save() fails (as is already done for
> pre_save()).
> 
> Without this patch, qemu will crash after vmstate_subsection_save() or
> post_save() have failed inside of a vmstate_save() call (unless
> migrate_set_error() then happen to discard the new error because
> s->error is already set).  This happens e.g. when receiving the state
> from a virtio-fs back-end (virtiofsd) fails.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  migration/vmstate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index ff5d589a6d..13532f2807 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -22,7 +22,8 @@
>  #include "trace.h"
>  
>  static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
> -                                   void *opaque, JSONWriter *vmdesc);
> +                                   void *opaque, JSONWriter *vmdesc,
> +                                   Error **errp);
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>                                     void *opaque);
>  
> @@ -441,12 +442,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>          json_writer_end_array(vmdesc);
>      }
>  
> -    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc);
> +    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>  
>      if (vmsd->post_save) {
>          int ps_ret = vmsd->post_save(opaque);
>          if (!ret) {

Perhaps here it needs to be "if (!ret && ps_ret)" now, otherwise the error
will be attached even if no error for both retvals?

Other than that it looks good.

Thanks,

>              ret = ps_ret;
> +            error_setg(errp, "post-save failed: %s", vmsd->name);
>          }
>      }
>      return ret;
> @@ -518,7 +520,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>  }
>  
>  static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
> -                                   void *opaque, JSONWriter *vmdesc)
> +                                   void *opaque, JSONWriter *vmdesc,
> +                                   Error **errp)
>  {
>      const VMStateDescription * const *sub = vmsd->subsections;
>      bool vmdesc_has_subsections = false;
> @@ -546,7 +549,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>              qemu_put_byte(f, len);
>              qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
>              qemu_put_be32(f, vmsdsub->version_id);
> -            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
> +            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
>              if (ret) {
>                  return ret;
>              }
> -- 
> 2.45.2
> 

-- 
Peter Xu


