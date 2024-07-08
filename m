Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E23EC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 21:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQw02-0002aZ-2R; Mon, 08 Jul 2024 17:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQw00-0002a5-HZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 17:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQvzx-00010u-Qu
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 17:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720474452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m3zbq0I2fGU6Mp+TctXc08cp7pgjlNkl/sQbhNQTsAU=;
 b=SrfI/aXixARcU7/waXZYbSntDLa0IIdQMT8I2Ls5QbFKz5LKl0haUvGYy/wIkcHdn+nlUh
 dJECiPPtUoo2WQ+dRNrRu6aulYgGEgQM8yDk/xcZYAe6RBX0Q3MlJjKUSxzBuLhKc+mw65
 qyFBELx2nai7WPXMTdpbWQWENfjjBGE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-Fj3QLDFaM-upMYBE-i9BdQ-1; Mon, 08 Jul 2024 17:34:09 -0400
X-MC-Unique: Fj3QLDFaM-upMYBE-i9BdQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-447e6ac9852so6077231cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 14:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720474449; x=1721079249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3zbq0I2fGU6Mp+TctXc08cp7pgjlNkl/sQbhNQTsAU=;
 b=AFYYcg3YNSJiBcZYMj1sDFjJIxVR7dfQvi3gwmxnTUSZLaGaBF6TSD46nbbnJbvQqX
 yEb96vws0+fiCbvR1xSMR4nv69sH/gPmt5wTuGncUjgxQFZYhkTtZPqxJLMEWSHw93Li
 DfE5cAqSELyomWhi3jUM1umYODIxQHrhS77lSpAyZF0/Nr45NjZJBD1+o3e97o0F772M
 /KouDMPltFVc4xBMETE+d0fm67um/o6tDjqIHPtrNNbIK5xpC2A0dilEUeuIEIb/QGpu
 4RPj/qTDHGy+9d+MDRSs6YB/xxz6++VvZ58pgyfFMqpEQsF5GdjcUTr6HUMI2wTRbURf
 s+HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVekeGgg9a/Fo3ifJrs6jJDrjmAdhOtVxfZECee8sjGiOUbM5He1262KSegqNPCFJzJE4GyI+UnBG3hpncg1q7iATti1FQ=
X-Gm-Message-State: AOJu0YxJ41uZUR/yjsq5hSvDWccJDjJbD3d9K2xuqc0sOomylo4v7XPK
 AOs/Z7YRgkAkBs8jgfOgwpexEcbiKsytsgUO08NU5+BEwPtilwCQoPpb/c7OwuIylZfk8qpvn3K
 i0dwkErLrH90f2cbSIAbabymAeCH0RkWBAmUnAV+k2hQnAVSUwVLK
X-Received: by 2002:a05:622a:250:b0:446:3c84:e0d3 with SMTP id
 d75a77b69052e-447faa844f6mr7103041cf.5.1720474449024; 
 Mon, 08 Jul 2024 14:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6RYT3hKNl5U9Y9w24WjtAyOXNJo0Abk6LTy1UvtjtwGncBwRyJT/k5cx4lNA7e3jy0GuATA==
X-Received: by 2002:a05:622a:250:b0:446:3c84:e0d3 with SMTP id
 d75a77b69052e-447faa844f6mr7102771cf.5.1720474448491; 
 Mon, 08 Jul 2024 14:34:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9bd2664sm3344371cf.64.2024.07.08.14.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 14:34:08 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:34:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v4 3/4] migration: Introduce 'qatzip' compression method
Message-ID: <ZoxbTT2rcJPkWThC@x1n>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <20240705182901.48948-4-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705182901.48948-4-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 05, 2024 at 11:29:00AM -0700, Yichen Wang wrote:
> From: Bryan Zhang <bryan.zhang@bytedance.com>
> 
> Adds support for 'qatzip' as an option for the multifd compression
> method parameter, and implements using QAT for 'qatzip' compression and
> decompression.
> 
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>

Mostly good to me, I left some nitpicks below here and there.

> ---
>  hw/core/qdev-properties-system.c |   6 +-
>  migration/meson.build            |   1 +
>  migration/multifd-qatzip.c       | 391 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   5 +-
>  qapi/migration.json              |   3 +
>  tests/qtest/meson.build          |   4 +
>  6 files changed, 407 insertions(+), 3 deletions(-)
>  create mode 100644 migration/multifd-qatzip.c
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index f13350b4fb..eb50d6ec5b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>  const PropertyInfo qdev_prop_multifd_compression = {
>      .name = "MultiFDCompression",
>      .description = "multifd_compression values, "
> -                   "none/zlib/zstd/qpl/uadk",
> +                   "none/zlib/zstd/qpl/uadk"
> +#ifdef CONFIG_QATZIP
> +                   "/qatzip"
> +#endif
> +                   ,
>      .enum_table = &MultiFDCompression_lookup,
>      .get = qdev_propinfo_get_enum,
>      .set = qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 5ce2acb41e..c9454c26ae 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
>  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
>  system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
> +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>  
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>                  if_true: files('ram.c',
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> new file mode 100644
> index 0000000000..a1502a5589
> --- /dev/null
> +++ b/migration/multifd-qatzip.c
> @@ -0,0 +1,391 @@
> +/*
> + * Multifd QATzip compression implementation
> + *
> + * Copyright (c) Bytedance
> + *
> + * Authors:
> + *  Bryan Zhang <bryan.zhang@bytedance.com>
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "options.h"
> +#include "multifd.h"
> +#include <qatzip.h>
> +
> +struct qatzip_data {
> +    /*
> +     * Unique session for use with QATzip API
> +     */
> +    QzSession_T sess;
> +
> +    /*
> +     * For compression: Buffer for pages to compress
> +     * For decompression: Buffer for data to decompress
> +     */
> +    uint8_t *in_buf;
> +    uint32_t in_len;
> +
> +    /*
> +     * For compression: Output buffer of compressed data
> +     * For decompression: Output buffer of decompressed data
> +     */
> +    uint8_t *out_buf;
> +    uint32_t out_len;
> +};
> +
> +/**
> + * qatzip_send_setup: Set up QATzip session and private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct qatzip_data *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +    int sw_fallback;
> +
> +    q = g_new0(struct qatzip_data, 1);
> +    p->compress_data = q;
> +    /* We need one extra place for the packet header */
> +    p->iov = g_new0(struct iovec, 2);
> +
> +    sw_fallback = 0;
> +    if (migrate_multifd_qatzip_sw_fallback()) {
> +        sw_fallback = 1;
> +    }
> +
> +    ret = qzInit(&q->sess, sw_fallback);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzInit failed";
> +        goto err_free_q;
> +    }
> +
> +    ret = qzGetDefaultsDeflate(&params);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzGetDefaultsDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
> +
> +    ret = qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzSetupSessionDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* TODO Add support for larger packets. */
> +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {

Is this a real TODO to support packet larger than 4G?

We'll need to double check in the future to increase MULTIFD_PACKET_SIZE
irrelevant of QAT capabilities - multifd already made the container world
unhappy by eating too much cpu resources (so it will cause throttle of vcpu
threads..). Increasing MULTIFD_PACKET_SIZE can definitely make it worse,
probably in the form of OOM kills.

We can drop the comment otherwise, as 4G sounds big enough.

> +        err_msg = "packet size too large for QAT";
> +        goto err_close;
> +    }
> +
> +    q->in_len = MULTIFD_PACKET_SIZE;
> +    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);

I'm not sure what does this imply, but if it means pinning memory I'd
suggest we put that into documentation.  E.g., I think QEMU can boot with
"ulimit -l" == 0, and it might be good to mention these before users start
to use them, or at least know what values should be used when allowing page
pinnings.

In this specific case, it could mention the multifd default packet size for
each pinned buffer, and how many buffers qatzip will need.

> +    if (!q->in_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_close;
> +    }
> +
> +    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
> +    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_free_inbuf;
> +    }
> +
> +    return 0;
> +
> +err_free_inbuf:
> +    qzFree(q->in_buf);
> +err_close:
> +    qzClose(&q->sess);
> +err_free_q:
> +    g_free(q);
> +    g_free(p->iov);
> +    p->iov = NULL;
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_send_cleanup: Tear down QATzip session and release private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     None
> + */
> +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct qatzip_data *q = p->compress_data;
> +    const char *err_msg;
> +    int ret;
> +
> +    ret = qzTeardownSession(&q->sess);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzTeardownSession failed";
> +        goto err;
> +    }
> +
> +    ret = qzClose(&q->sess);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzClose failed";
> +        goto err;
> +    }
> +
> +    qzFree(q->in_buf);
> +    q->in_buf = NULL;
> +    qzFree(q->out_buf);
> +    q->out_buf = NULL;
> +    g_free(p->iov);
> +    p->iov = NULL;
> +    g_free(p->compress_data);
> +    p->compress_data = NULL;
> +    return;
> +
> +err:
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +}
> +
> +/**
> + * qatzip_send_prepare: Compress pages and update IO channel info.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +    struct qatzip_data *q = p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +
> +    if (!multifd_send_prepare_common(p)) {
> +        goto out;
> +    }
> +
> +    /* memcpy all the pages into one buffer. */
> +    for (int i = 0; i < pages->normal_num; i++) {
> +        memcpy(q->in_buf + (i * p->page_size),
> +               p->pages->block->host + pages->offset[i],
> +               p->page_size);
> +    }
> +
> +    in_len = pages->normal_num * p->page_size;
> +    if (in_len > q->in_len) {
> +        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
> +        return -1;
> +    }
> +    out_len = q->out_len;
> +
> +    /*
> +     * Unlike other multifd compression implementations, we use a non-streaming
> +     * API and place all the data into one buffer, rather than sending each page
> +     * to the compression API at a time. Based on initial benchmarks, the
> +     * non-streaming API outperforms the streaming API. Plus, the logic in QEMU
> +     * is friendly to using the non-streaming API anyway. If either of these
> +     * statements becomes no longer true, we can revisit adding a streaming
> +     * implementation.
> +     */

Such comments are helpful, thanks.  Maybe it can be moved upper to where
the page copy happened?  We can also mention that in the docs/ patch.

> +    ret = qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len, 1);
> +    if (ret != QZ_OK) {
> +        error_setg(errp, "multifd %u: QATzip returned %d instead of QZ_OK",
> +                   p->id, ret);
> +        return -1;
> +    }
> +    if (in_len != pages->normal_num * p->page_size) {
> +        error_setg(errp, "multifd %u: QATzip failed to compress all input",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    p->iov[p->iovs_num].iov_base = q->out_buf;
> +    p->iov[p->iovs_num].iov_len = out_len;
> +    p->iovs_num++;
> +    p->next_packet_size = out_len;
> +
> +out:
> +    p->flags |= MULTIFD_FLAG_QATZIP;
> +    multifd_send_fill_packet(p);
> +    return 0;
> +}
> +
> +/**
> + * qatzip_recv_setup: Set up QATzip session and allocate private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    struct qatzip_data *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +    int sw_fallback;
> +
> +    q = g_new0(struct qatzip_data, 1);
> +    p->compress_data = q;
> +
> +    sw_fallback = 0;
> +    if (migrate_multifd_qatzip_sw_fallback()) {
> +        sw_fallback = 1;
> +    }
> +
> +    ret = qzInit(&q->sess, sw_fallback);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzInit failed";
> +        goto err_free_q;
> +    }
> +
> +    ret = qzGetDefaultsDeflate(&params);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzGetDefaultsDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
> +
> +    ret = qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzSetupSessionDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /*
> +     * Mimic multifd-zlib, which reserves extra space for the
> +     * incoming packet.
> +     */
> +    q->in_len = MULTIFD_PACKET_SIZE * 2;
> +    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_close;
> +    }
> +
> +    q->out_len = MULTIFD_PACKET_SIZE;
> +    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_free_inbuf;
> +    }
> +
> +    return 0;
> +
> +err_free_inbuf:
> +    qzFree(q->in_buf);
> +err_close:
> +    qzClose(&q->sess);
> +err_free_q:
> +    g_free(q);
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_recv_cleanup: Tear down QATzip session and release private buffers.
> + *
> + * @param p    Multifd channel params
> + * @return     None
> + */
> +static void qatzip_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    struct qatzip_data *q = p->compress_data;
> +
> +    /* Ignoring return values here due to function signature. */
> +    qzTeardownSession(&q->sess);
> +    qzClose(&q->sess);
> +    qzFree(q->in_buf);
> +    qzFree(q->out_buf);
> +    g_free(p->compress_data);
> +}
> +
> +
> +/**
> + * qatzip_recv: Decompress pages and copy them to the appropriate
> + * locations.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    struct qatzip_data *q = p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +    uint32_t in_size = p->next_packet_size;
> +    uint32_t expected_size = p->normal_num * p->page_size;
> +    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +
> +    if (in_size > q->in_len) {
> +        error_setg(errp, "multifd %u: received unexpectedly large packet",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    if (flags != MULTIFD_FLAG_QATZIP) {
> +        error_setg(errp, "multifd %u: flags received %x flags expected %x",
> +                   p->id, flags, MULTIFD_FLAG_QATZIP);
> +        return -1;
> +    }
> +
> +    ret = qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    in_len = in_size;
> +    out_len = q->out_len;
> +    ret = qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len);
> +    if (ret != QZ_OK) {
> +        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
> +        return -1;
> +    }
> +    if (out_len != expected_size) {
> +        error_setg(errp, "multifd %u: packet size received %u size expected %u",
> +                   p->id, out_len, expected_size);
> +        return -1;
> +    }
> +
> +    /* Copy each page to its appropriate location. */
> +    for (int i = 0; i < p->normal_num; i++) {
> +        memcpy(p->host + p->normal[i],
> +               q->out_buf + p->page_size * i,
> +               p->page_size);
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_qatzip_ops = {
> +    .send_setup = qatzip_send_setup,
> +    .send_cleanup = qatzip_send_cleanup,
> +    .send_prepare = qatzip_send_prepare,
> +    .recv_setup = qatzip_recv_setup,
> +    .recv_cleanup = qatzip_recv_cleanup,
> +    .recv = qatzip_recv
> +};
> +
> +static void multifd_qatzip_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_ops);
> +}
> +
> +migration_init(multifd_qatzip_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 0ecd6f47d7..adceb65050 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  /* Multifd Compression flags */
>  #define MULTIFD_FLAG_SYNC (1 << 0)
>  
> -/* We reserve 4 bits for compression methods */
> -#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
> +/* We reserve 5 bits for compression methods */
> +#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
>  /* we need to be compatible. Before compression value was 0 */
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
>  #define MULTIFD_FLAG_ZLIB (1 << 1)
>  #define MULTIFD_FLAG_ZSTD (2 << 1)
>  #define MULTIFD_FLAG_QPL (4 << 1)
>  #define MULTIFD_FLAG_UADK (8 << 1)
> +#define MULTIFD_FLAG_QATZIP (16 << 1)

This is not a problem of this series alone, but it's sad to see it keeps
eating the flag bits with no good reasons..

Since it will never happen we enable >1 compressor, we should have made it
a type field not bitmask since the start..  We may even avoid having that
at all in packet flags, as migration so far relies on both sides to setup
the same migration parameters, and that already includes compressor
methods, or everything will go chaos.  This flag should so far do mostly
nothing good but waste some cycles on both sides..

Sign..  I think we can keep this for now, as we already have 5 others
anyway.. it's a pity we didn't notice this earlier, definitely not this
series's fault.

>  
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c9f2a8aa7..ea62f983b1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -558,6 +558,8 @@
>  #
>  # @zstd: use zstd compression method.
>  #
> +# @qatzip: use qatzip compression method. (Since 9.1)
> +#
>  # @qpl: use qpl compression method.  Query Processing Library(qpl) is
>  #       based on the deflate compression algorithm and use the Intel
>  #       In-Memory Analytics Accelerator(IAA) accelerated compression
> @@ -570,6 +572,7 @@
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
>              { 'name': 'qpl', 'if': 'CONFIG_QPL' },
>              { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
>  
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 12792948ff..23e46144d7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -324,6 +324,10 @@ if gnutls.found()
>    endif
>  endif
>  
> +if qatzip.found()
> +  migration_files += [qatzip]
> +endif
> +
>  qtests = {
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
>    'cdrom-test': files('boot-sector.c'),
> -- 
> Yichen Wang
> 

-- 
Peter Xu


