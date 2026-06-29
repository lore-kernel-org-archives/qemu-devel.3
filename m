Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD82C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weE2o-0002IY-4i; Mon, 29 Jun 2026 11:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weE2m-0002I2-LV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weE2k-0003jl-Su
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782747424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96P7sWiBXvqCybKWs7pC6QjIF/AECR0/ZQDCXMbZHX4=;
 b=SBm98PfSn8rP2+/k1PycMHiDv33hcHA34nqH9gkvG8U8SCDSE9Nt3hs7s95fEsRWeg/zrn
 P07s8BSG7mqk5ePQgtC7J9o12+FxGY3jlAE0rCTvNM2UM/poxLg/cd75XG6iWu7kFUb/CX
 mvP5Xq6va/RRLwvinYCwY00obFWSenw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-TRm_7iUTMta3hz7m--YTaA-1; Mon, 29 Jun 2026 11:36:58 -0400
X-MC-Unique: TRm_7iUTMta3hz7m--YTaA-1
X-Mimecast-MFC-AGG-ID: TRm_7iUTMta3hz7m--YTaA_1782747416
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493b54823bdso3959165e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782747416; x=1783352216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96P7sWiBXvqCybKWs7pC6QjIF/AECR0/ZQDCXMbZHX4=;
 b=jFmZZreWkCfjxUwSBukX1SEZMuhyG8RxUe/yCfKKIbplrMz20De9oQjK0dQBRXuqsX
 UmR9yrVGPIId8OXUVFB4r+8KQnBsKgvfvJmhXrA5RGKlsbwwkvXD6jpoOJobUkiCNPWH
 XFS57nCUO0w1eQG54nDV1m05Lr0eq2+JMUOjU8uCYhh5Rs4Uw3sEf2ui6Wg+oeBqtUe5
 mQQ6GsNPcTS8I4WKPLIlTSlG7Dw4KbtKdhRAWeLzHQ/77LiYMsw/M/noVCgWC6PmDXEr
 PQqYF/MDOdrephQo+S20VfdBrOSj82WOQCThZLqZYJlHLEYBYCJTwRm0eZa4ad5wd1WY
 V9UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pN6nt7rypnWf6KAxUDHXjzu2+DpVYEdzIpamnj4rHnVTvYItkj27YtwFx4bG2emktDTLpWCueFMFi@nongnu.org
X-Gm-Message-State: AOJu0Ywly0Xc4dq3GltWz8+8Cq/thdBQYYHv+x1OA5E36LeZNYsC1s9P
 F40xNAtn1yZO/jDaogDv5gqlG6odJZGlz3RyzXUJJB9tg5zJq01L+KMwngzI6VkecPYHVcopTDo
 7BZYCvRmk+gZ+/gj9LMXgO0Y9kyQoVRzz3XvFB/NMUqemMDWVl7Ix9j1V
X-Gm-Gg: AfdE7ck5/T5kZrDJB3Y/kfMrJqqM66mE3q+yP+Nro5DcUiWkXHMqaKEFgKyFaM9dV5o
 4G6ykEsDdE7RQ0mDFbJjd69jjehAtJs0EnJv9P6/7OgtmioEFwp0AXecKK5Z7XbAzksFLsVSSXx
 hOOy8FvyrCr/p/PORs042mqiB57Yr0McvGS9vlNutq87ui8VwD95+kFNT+vgznld57ZoyALWD0S
 gzNSU1evRYljZCay5X1MQ2aeP9FpWakt0UTdVGK0Q6Mj4mdbcuWL3uqjzXdhWHSZkI4K6lOyMd/
 pWbWK+0ow9H+3B8v25JWldPTmNdOx2tSbvSKoo9fgxH7ZLr1Y03r7q8QZa8yc5oJPtj7Q8NeOoy
 cJ/+ZgFyJeepKTqiiGHICnLtfVnILiAZw2HCnTKIMsUq66gcDEUFDjvQn0D8=
X-Received: by 2002:a05:600c:a00f:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-492663e185dmr243865815e9.5.1782747415877; 
 Mon, 29 Jun 2026 08:36:55 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-492663e185dmr243865385e9.5.1782747415393; 
 Mon, 29 Jun 2026 08:36:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ae96c85fsm79978915e9.5.2026.06.29.08.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:36:54 -0700 (PDT)
Message-ID: <8cc759e8-99b7-489c-84b7-30a6a7031b34@redhat.com>
Date: Mon, 29 Jun 2026 17:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/smmuv3-accel: Fix veventq read returning true
 on EAGAIN/EINTR
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com
References: <20260625122843.107584-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260625122843.107584-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/25/26 2:28 PM, Shameer Kolothum wrote:
> smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
> no data has been read into the buffer. Callers treat true as success and
> proceed to use the uninitialized buffer.
>
> Change the return type to int with three distinct states:
>   0  — success, buf is populated and valid
>   1  — EAGAIN/EINTR, no data available
>  -1  — error, @errp set
>
> Resolves: Coverity CID 1660057
> Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for veventq read")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  v1 --> v2:
>  -Changed helper ret type based on discussion here:
>   https://lore.kernel.org/qemu-devel/20260623075101.17770-1-skolothumtho@nvidia.com/
>
> Thanks
> ---
>  hw/arm/smmuv3-accel.h       |  4 ++--
>  hw/arm/smmuv3-accel-stubs.c |  6 +++---
>  hw/arm/smmuv3-accel.c       | 30 ++++++++++++++++++++----------
>  hw/arm/tegra241-cmdqv.c     | 11 ++++++++---
>  4 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index dd755c394d..ea11d513cc 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -97,8 +97,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                  Error **errp);
>  void smmuv3_accel_idr_override(SMMUv3State *s);
>  bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
> -bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> -                                      void *buf, size_t size, Error **errp);
> +int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                     void *buf, size_t size, Error **errp);
>  void smmuv3_accel_reset(SMMUv3State *s);
>  SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
>  
> diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
> index 147ae06163..b8dd7e7b89 100644
> --- a/hw/arm/smmuv3-accel-stubs.c
> +++ b/hw/arm/smmuv3-accel-stubs.c
> @@ -47,10 +47,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>      return true;
>  }
>  
> -bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> -                                      void *buf, size_t size, Error **errp)
> +int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                     void *buf, size_t size, Error **errp)
>  {
> -    return true;
> +    return 0;
>  }
>  
>  
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 80900c2521..6df19f0e0e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -440,8 +440,13 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
>                     sizeof(Cmd), &entry_num, cmd, errp);
>  }
>  
> -bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> -                                      void *buf, size_t size, Error **errp)
> +/*
> + * Returns  0 on success (buf is populated and valid).
> + * Returns  1 if the read should be retried (EAGAIN/EINTR).
> + * Returns -1 on error with @errp set.
> + */
> +int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                     void *buf, size_t size, Error **errp)
>  {
>      uint32_t last_seq = veventq->last_event_seq;
>      uint32_t id = veventq->veventq_id;
> @@ -451,22 +456,22 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>      bytes = read(veventq->veventq_fd, buf, size);
>      if (bytes <= 0) {
>          if (errno == EAGAIN || errno == EINTR) {
> -            return true;
> +            return 1;
>          }
>          error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
> -        return false;
> +        return -1;
>      }
>      hdr = (struct iommufd_vevent_header *)buf;
>      if (bytes == sizeof(*hdr) &&
>          (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
>          error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
>          veventq->event_start = false;
> -        return false;
> +        return -1;
>      }
>      if (bytes < size) {
>          error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
>                            type, id, bytes, size);
> -        return false;
> +        return -1;
>      }
>      /* Check sequence in hdr for lost events if any */
>      if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
> @@ -475,7 +480,7 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>      }
>      veventq->last_event_seq = hdr->sequence;
>      veventq->event_start = true;
> -    return true;
> +    return 0;
>  }
>  
>  static void smmuv3_accel_event_read(void *opaque)
> @@ -487,13 +492,18 @@ static void smmuv3_accel_event_read(void *opaque)
>          struct iommu_vevent_arm_smmuv3 vevent;
>      } buf;
>      Error *local_err = NULL;
> +    int ret;
>  
> -    if (!smmuv3_accel_event_read_validate(veventq,
> -                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
> -                                          sizeof(buf), &local_err)) {
> +    ret = smmuv3_accel_event_read_validate(veventq,
> +                                           IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
> +                                           sizeof(buf), &local_err);
> +    if (ret < 0) {
>          warn_report_err_once(local_err);
>          return;
>      }
> +    if (ret > 0) {
> +        return; /* EAGAIN/EINTR */
> +    }
>      smmuv3_propagate_event(s, (Evt *)&buf.vevent);
>  }
>  
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 29c488e0e4..7223aa9d1d 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -841,13 +841,18 @@ static void tegra241_cmdqv_event_read(void *opaque)
>          struct iommu_vevent_tegra241_cmdqv vevent;
>      } buf;
>      Error *local_err = NULL;
> +    int ret;
>  
> -    if (!smmuv3_accel_event_read_validate(veventq,
> -                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> -                                          &buf, sizeof(buf), &local_err)) {
> +    ret = smmuv3_accel_event_read_validate(veventq,
> +                                           IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> +                                           &buf, sizeof(buf), &local_err);
> +    if (ret < 0) {
>          warn_report_err_once(local_err);
>          return;
>      }
> +    if (ret > 0) {
> +        return; /* EAGAIN/EINTR */
> +    }
>  
>      if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
>          cmdqv->vintf_cmdq_err_map[0] =


