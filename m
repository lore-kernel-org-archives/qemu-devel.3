Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1921CFB44C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqir-0008N3-2q; Mon, 07 Oct 2024 12:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqio-0008Md-St
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqin-0000SZ-Ar
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728318991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yV/vmXewCSa/0YZ/uGjSrTlYwYs/YpIyYd7Dur602Xs=;
 b=JVU3aXdBA5dmgrqUhrIKPAOWVevt786csoHh4aIKbKy7zLzU3Xr10MLcVwG4BRY1fDHjv3
 3QZWdNjuigRTjrQmlUFdUKWLbboGfejrtL6N3TKnAoIH1fkwg8zH+EFNv/aLse78rhev39
 0UeKCbkCU2vtfRE5rDHtgZPr5VBbjW0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-xcVQlUveMLe--L03H7ElLA-1; Mon, 07 Oct 2024 12:36:30 -0400
X-MC-Unique: xcVQlUveMLe--L03H7ElLA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-8324396d0abso409384339f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728318989; x=1728923789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yV/vmXewCSa/0YZ/uGjSrTlYwYs/YpIyYd7Dur602Xs=;
 b=rLbQbfT6ZAM2Ci0Z7VQg3jmbeT5UrgQgH6fXN+EpxjsbCjzyguC9BE++PiLR3SHM6E
 R5srAM8qVFs/kSTVb28ZN44ifHRjWqFY+JPJNTSVGg34gWjFlHmbsoUlPpcGVYhTxP4j
 jXvriAp3KNTReTs5NOQeIXKRuzyboBxD6GGmz9g5JH7CfantMxNV8wrXUrUYiWN0APvk
 MgSmk7wEuaaT+c+3HF5pC+rS9077kH3Lnxiu1BkcEj75QohjN8qaiRGL7qiPof5bo0DK
 mFnR9gnSzYDyDAYtt+t4/c4tYNF/7gFdfAM+StD9pPvok4pa413WqVnloXZmyDCzA6bN
 ynXA==
X-Gm-Message-State: AOJu0YxZqlLw47V1AIzIeES6eNbFQxPKjHTnwlMquuU4hD3SdmzVF1SG
 zfd2O5ayKDGFUyMRJ7P4fwjzpkuGGGuAhLpdxqPPksiY8lxQEUxt3tE/rqqBwGsG2crRHSi8qV9
 +nXXfYHWaRpwnDQkwQydJNknd8D/Rb0g6Py6cwWmAlXYVabriKEzT
X-Received: by 2002:a05:6602:1694:b0:82a:1f14:997f with SMTP id
 ca18e2360f4ac-834f7c73b46mr1310930839f.4.1728318989507; 
 Mon, 07 Oct 2024 09:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa83r7hKnal9H/Bx5xI/iDUV2C/L8gZRMfl8R1msGUIC66tdTBc+WtfbMQYuvMdqYWOyGGxg==
X-Received: by 2002:a05:6602:1694:b0:82a:1f14:997f with SMTP id
 ca18e2360f4ac-834f7c73b46mr1310928239f.4.1728318989130; 
 Mon, 07 Oct 2024 09:36:29 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503a74e97sm132754839f.2.2024.10.07.09.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:36:28 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:36:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 08/13] migration: VMSTATE_FD
Message-ID: <ZwQOChgaKst9uCZn@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-9-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-9-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Mon, Sep 30, 2024 at 12:40:39PM -0700, Steve Sistare wrote:
> Define VMSTATE_FD for declaring a file descriptor field in a
> VMStateDescription.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/vmstate.h |  9 +++++++++
>  migration/vmstate-types.c   | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f313f2f..a1dfab4 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -230,6 +230,7 @@ extern const VMStateInfo vmstate_info_uint8;
>  extern const VMStateInfo vmstate_info_uint16;
>  extern const VMStateInfo vmstate_info_uint32;
>  extern const VMStateInfo vmstate_info_uint64;
> +extern const VMStateInfo vmstate_info_fd;
>  
>  /** Put this in the stream when migrating a null pointer.*/
>  #define VMS_NULLPTR_MARKER (0x30U) /* '0' */
> @@ -902,6 +903,9 @@ extern const VMStateInfo vmstate_info_qlist;
>  #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
>      VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
>  
> +#define VMSTATE_FD_V(_f, _s, _v)                                  \
> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_fd, int32_t)
> +
>  #ifdef CONFIG_LINUX
>  
>  #define VMSTATE_U8_V(_f, _s, _v)                                   \
> @@ -936,6 +940,9 @@ extern const VMStateInfo vmstate_info_qlist;
>  #define VMSTATE_UINT64(_f, _s)                                        \
>      VMSTATE_UINT64_V(_f, _s, 0)
>  
> +#define VMSTATE_FD(_f, _s)                                            \
> +    VMSTATE_FD_V(_f, _s, 0)
> +
>  #ifdef CONFIG_LINUX
>  
>  #define VMSTATE_U8(_f, _s)                                         \
> @@ -1009,6 +1016,8 @@ extern const VMStateInfo vmstate_info_qlist;
>  #define VMSTATE_UINT64_TEST(_f, _s, _t)                                  \
>      VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_uint64, uint64_t)
>  
> +#define VMSTATE_FD_TEST(_f, _s, _t)                                            \
> +    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_fd, int32_t)
>  
>  #define VMSTATE_TIMER_PTR_TEST(_f, _s, _test)                             \
>      VMSTATE_POINTER_TEST(_f, _s, _test, vmstate_info_timer, QEMUTimer *)
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index e83bfcc..6e45a4a 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -314,6 +314,38 @@ const VMStateInfo vmstate_info_uint64 = {
>      .put  = put_uint64,
>  };
>  
> +/* File descriptor communicated via SCM_RIGHTS */
> +
> +static int get_fd(QEMUFile *f, void *pv, size_t size,
> +                  const VMStateField *field)
> +{
> +    int32_t *v = pv;
> +    qemu_get_sbe32s(f, v);

Why we need to send/recv the fd integer alone?  Can't that change anyway
across migration?  What happens if we drop this (and the put side)?

> +    if (*v < 0) {
> +        return 0;
> +    }
> +    *v = qemu_file_get_fd(f);
> +    return 0;
> +}
> +
> +static int put_fd(QEMUFile *f, void *pv, size_t size,
> +                  const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    int32_t *v = pv;
> +
> +    qemu_put_sbe32s(f, v);
> +    if (*v < 0) {
> +        return 0;
> +    }
> +    return qemu_file_put_fd(f, *v);
> +}
> +
> +const VMStateInfo vmstate_info_fd = {
> +    .name = "fd",
> +    .get  = get_fd,
> +    .put  = put_fd,
> +};
> +
>  static int get_nullptr(QEMUFile *f, void *pv, size_t size,
>                         const VMStateField *field)
>  
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


