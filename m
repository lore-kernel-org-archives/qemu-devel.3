Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F00FCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbhF-0004ct-JY; Wed, 06 May 2026 08:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKbhD-0004cI-Tb
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKbhC-0006eE-2d
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778071785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKK+8xeHmWK8j0e8XBFbmARtqKIf5WMBbUeUSi3fkLI=;
 b=aPjyw8Fbhj99/XYZl1sc953gFUazahAEchFWjXr2YJ+n0w39VnToQJw/gWJv/U+ABVkbbX
 Td7rEGrw43dpyHgDzpCEGrRdotRhdzKzg/d1O6Xvuu+2zXzUA047KxXXuU386MPpGCd1ka
 W8FHmDQm+ABhkp0HoVu8xzfZPVbuGsU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-3VL9k_qhPwuyw48WeKYbDQ-1; Wed, 06 May 2026 08:49:42 -0400
X-MC-Unique: 3VL9k_qhPwuyw48WeKYbDQ-1
X-Mimecast-MFC-AGG-ID: 3VL9k_qhPwuyw48WeKYbDQ_1778071781
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a5fb71a84so5758685e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071781; x=1778676581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKK+8xeHmWK8j0e8XBFbmARtqKIf5WMBbUeUSi3fkLI=;
 b=QKV+HMhC84vyrIzmvg7eKQCKtbodvdo4jhFe6Dq24KcMTUWCGgMzN1+GHlfA7EmauI
 9Cx9vwCxiWTiJ1E9cuT7eiZVMmPvxCo7vGtdZCoQY1Ca3pdnodTjfVTidxnb3P7Fj19H
 GnAG4FV6scxUwsQ+u6F5QTY0X5LW95GiqLAlhBA6ajPTvCbd9EDeGkOGunx/dYo029ge
 zIYbmXeBkoT/nkQD8ajnlsTLqjR2xtjjZ28YKAPx/f3EHH/i5cs03lCVQKAesJcbUY3E
 NzcE9OzPqoKLOS6kuU+x6HIzGYrIiNbdrgsnTa8LbuUh4r4fW8tbKxdD5Hs3MIANSmt+
 n/hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f1xBhSJ0og6w+9xrH3BNgsfS/23qJPTdDRg4K+ZT8awQmYbCviU13mqDqjz0rBqju2jfaLbXeBsG5@nongnu.org
X-Gm-Message-State: AOJu0Yw6oIqc4WOk+XGX3AyKfsel0nz+ZnesKIkWDSMXAe3ju+7DrrGN
 Lgs+NawDVbr1rN/7FEizcOx32UvPcsOXGc4pAD9udvH9q6hXBcYJDRk1n//NPbrpyQSEjRHYAo7
 YYVXLmrlhyJJF/wC7ko3TjBzFHgb1L/JHFPJu8ONCHCL2qWQc3DEEZK68
X-Gm-Gg: AeBDiev6eDB/zCdVEG/uGZAP2gF9oiheFnCC5WM9C7zZhVYtDSGs2zUQVnBVRE89Koo
 6CDjF8Tiu5dGhFWfR1OIG6aliNfDi5IQGlJmeu8RFL7NC9bCTMOOKFuwgR51InB/xAzCPdHTJrR
 edJ+72c5bJJho2UY4MlkvqiJbTAvoc09Xjqmaf+2JtUIYoRiKvY5YPT/lljSkhk/FYduXjeJR2j
 9saDtVj+Lz/NdAO9PRsvFwLRHwc+GHejfFzPsnYJze4YG/1DhxAJ6eL51bwpyPsXP0pTiz3lnHv
 7LApNNTyEQiR41pyQ69vTJ0qbl6e7y1jJxKgBUIb14/YQhkiWhyUCxAhS8PZm6T4YmVsnrZq04G
 xcs7FM6rBmMdAU+Y3aecmKLewV5No4+gB3tfKiJ/ivCPt6e5KXPD/9SiUnVu3OC0auYrkOd35e9
 0IkK2w
X-Received: by 2002:a05:600c:8908:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-48e522b8577mr32425645e9.11.1778071781008; 
 Wed, 06 May 2026 05:49:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8908:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-48e522b8577mr32425375e9.11.1778071780630; 
 Wed, 06 May 2026 05:49:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e59b74277sm8141125e9.3.2026.05.06.05.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:49:40 -0700 (PDT)
Message-ID: <123b3178-8fb9-495f-b4f7-9af40f7a1a99@redhat.com>
Date: Wed, 6 May 2026 14:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/31] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-24-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-24-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> Move the vEVENTQ read and validation logic into a common helper
> smmuv3_accel_event_read_validate(). The helper performs the read(),
> checks for overflow and short reads, validates the sequence number,
> and updates the sequence state.
>
> This helper can be reused for Tegra241 CMDQV vEVENTQ support in a
> subsequent patch.
>
> Error handling is slightly adjusted: instead of reporting errors
> directly in the read handler, the helper now returns errors via
> Error **. Sequence gaps are reported as warnings.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.h       |  2 ++
>  hw/arm/smmuv3-accel-stubs.c | 11 ++++++
>  hw/arm/smmuv3-accel.c       | 67 ++++++++++++++++++++++---------------
>  3 files changed, 53 insertions(+), 27 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 28bceca061..448f47c0ca 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -71,6 +71,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                  Error **errp);
>  void smmuv3_accel_idr_override(SMMUv3State *s);
>  bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
> +bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                      void *buf, size_t size, Error **errp);
>  void smmuv3_accel_reset(SMMUv3State *s);
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
> index c08caa6fa4..e8f08dc833 100644
> --- a/hw/arm/smmuv3-accel-stubs.c
> +++ b/hw/arm/smmuv3-accel-stubs.c
> @@ -41,6 +41,17 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>  {
>  }
>  
> +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
> +{
> +    return true;
> +}
> +
> +bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                      void *buf, size_t size, Error **errp)
> +{
> +    return true;
> +}
> +
>  void smmuv3_accel_reset(SMMUv3State *s)
>  {
>  }
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9068e65e2b..230f608f03 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -436,47 +436,60 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
>                     sizeof(Cmd), &entry_num, cmd, errp);
>  }
>  
> -static void smmuv3_accel_event_read(void *opaque)
> +bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                      void *buf, size_t size, Error **errp)
>  {
> -    SMMUv3State *s = opaque;
> -    IOMMUFDVeventq *veventq = s->s_accel->veventq;
> -    struct {
> -        struct iommufd_vevent_header hdr;
> -        struct iommu_vevent_arm_smmuv3 vevent;
> -    } buf;
> -    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
> -    uint32_t id = veventq->veventq_id;
>      uint32_t last_seq = veventq->last_event_seq;
> +    uint32_t id = veventq->veventq_id;
> +    struct iommufd_vevent_header *hdr;
>      ssize_t bytes;
>  
> -    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
> +    bytes = read(veventq->veventq_fd, buf, size);
>      if (bytes <= 0) {
>          if (errno == EAGAIN || errno == EINTR) {
> -            return;
> +            return true;
>          }
> -        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);
> -        return;
> +        error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
> +        return false;
>      }
> -
> -    if (bytes == sizeof(buf.hdr) &&
> -        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> -        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
> +    hdr = (struct iommufd_vevent_header *)buf;
> +    if (bytes == sizeof(*hdr) &&
> +        (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> +        error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
>          veventq->event_start = false;
> -        return;
> +        return false;
>      }
> -    if (bytes < sizeof(buf)) {
> -        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
> -                          type, id, bytes, sizeof(buf));
> -        return;
> +    if (bytes < size) {
> +        error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
> +                          type, id, bytes, size);
> +        return false;
>      }
> -
>      /* Check sequence in hdr for lost events if any */
> -    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
> -        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
> -                          type, id, buf.hdr.sequence - last_seq - 1);
> +    if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
> +        warn_report("vEVENTQ(type %u id %u): lost %u event(s)",
> +                    type, id, hdr->sequence - last_seq - 1);
>      }
> -    veventq->last_event_seq = buf.hdr.sequence;
> +    veventq->last_event_seq = hdr->sequence;
>      veventq->event_start = true;
> +    return true;
> +}
> +
> +static void smmuv3_accel_event_read(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +    IOMMUFDVeventq *veventq = s->s_accel->veventq;
> +    struct {
> +        struct iommufd_vevent_header hdr;
> +        struct iommu_vevent_arm_smmuv3 vevent;
> +    } buf;
> +    Error *local_err = NULL;
> +
> +    if (!smmuv3_accel_event_read_validate(veventq,
> +                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
> +                                          sizeof(buf), &local_err)) {
> +        warn_report_err_once(local_err);
> +        return;
> +    }
>      smmuv3_propagate_event(s, (Evt *)&buf.vevent);
>  }
>  


