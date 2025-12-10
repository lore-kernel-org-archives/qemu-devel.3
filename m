Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC125D2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 08:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTFPq-0004xY-93; Wed, 10 Dec 2025 03:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTFPp-0004x7-3W
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 03:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTFPn-0006Z6-Eh
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 03:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765354754;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7c4O1CFz6Da9sMbw+OuGreQFXF89EzxMwuXqC8efuQ=;
 b=Vw10/OGQZxqattKAvKgLP2w/vrmQs6qurMj4glPU+NtGQjZRrxCSoaPj8tS9BCtK/nvRVp
 HBdfVoDJ/vaO69yra9KSYir/IdGLBkFm0GsgmhO7DybIbrpmHQdM9dpSSa/6GsRyvLzCKD
 ON5qLkWhV4pge3NiTtjTHxB270rbQPc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-bktURn_dN6qFn9J4OQSkNA-1; Wed, 10 Dec 2025 03:19:13 -0500
X-MC-Unique: bktURn_dN6qFn9J4OQSkNA-1
X-Mimecast-MFC-AGG-ID: bktURn_dN6qFn9J4OQSkNA_1765354752
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-299d221b749so124730935ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 00:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765354752; x=1765959552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7c4O1CFz6Da9sMbw+OuGreQFXF89EzxMwuXqC8efuQ=;
 b=tBCOlm1hqH0o0YmVJQ7YPDJJPttf2AQVooi6sfDrEZh45EGSsvhN38xGM2nIm7npyi
 1UHUn/lArHOeZyIlZJX6RdLcifXJM8TomYzgHD4CQXlkeKxowmb5Z5oPTfWlfE24b9Mi
 nIZN9FRnskDVWKJ8r/s4LEU4A7f1jzUnyFY58pVirq4/sLtwi3sfwa7FEJfVuOMmP4Ab
 BwZAf+s5Jrtp3Dp95oZKrXYv4mjnvRDN6jhPU3QWIGd/kFKqzDAFnr7/WosNpYWTdGl4
 Lyj/Xp0HRUsPBbjPC8tbL+f2T+2FaKzXmUU1nJ4+nOjo4l+tISUUNMq3JzUlrzE7nKNk
 kHFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWvJu5paQhOUwB9KKJ2OuDKmbpESaekAa7lm8MoOb572biYjyxGolBBOk7DU6ctczUei9Pc3CWoZLG@nongnu.org
X-Gm-Message-State: AOJu0YwFeD+VVfbZhVhtlOa6oa6CAc4xCzFRwsHIFUwxxWuOirvmTQ51
 wbCXwkUGawilth0R+pDBjLgoL7ezZSVx71Cp+XpAV0pFKHjpNuubu68PQ4JinUysPdyqNJDGDms
 XmebwkM9VhEeitJ4hc+Zuclbd0HonNSG7jF4iBRR4EuChKd6HUdkHnUSz
X-Gm-Gg: ASbGncs8W24CcesenLGz6TJUpFkv4CEXj63OijXZeo3O3+WYlKKGTabyz9sjfXKmSUl
 lKkHANXwe9yvsxvguGIxS/TAzzCqZwPiVcngNUD+YH3Ib//ujZWX/+QQfhJeu7+9YVjhDqTMU5f
 8ctUlhLEC0sMaAjPmO9LqV0oljj4O42ujKDbWQLHRWP6IEW9Tve9SYec9H1ufeRAA1ikJQmmjdb
 5qTqoY29mjm4Sh9A5iIafu/H/7HSJjbT/UHLkeybdtRomBRivCke9QyvVpuLaMCansnqoieOr8w
 8isxVm0AugeK4bLYd/GRXSEH/aL4Ge3EjYVSOptGBQyrRHsVNA6EnCl+iOrRnox+COgXS92vq9Z
 mLPmneyCn7sDwvBT4XYhBVZ6raMR4pIGQqtS4zVIrjc2W9m9xu0mxvRwbkg==
X-Received: by 2002:a05:7022:327:b0:119:e569:f262 with SMTP id
 a92af1059eb24-11f2967ddc2mr1369289c88.11.1765354751734; 
 Wed, 10 Dec 2025 00:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3fDm+erqLghjvkd9uLSUvTgrGwTLac/g1o9r7eQslpRr4k+VELFU7XpRXt6SDhU+WkRxtzA==
X-Received: by 2002:a05:7022:327:b0:119:e569:f262 with SMTP id
 a92af1059eb24-11f2967ddc2mr1369264c88.11.1765354751176; 
 Wed, 10 Dec 2025 00:19:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11df76e2f3csm73807930c88.5.2025.12.10.00.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 00:19:10 -0800 (PST)
Message-ID: <0bdf282e-97b7-4942-966e-c8d8a394012b@redhat.com>
Date: Wed, 10 Dec 2025 09:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
 <20251204092245.5157-5-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251204092245.5157-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 12/4/25 10:22 AM, Shameer Kolothum wrote:
> Install an event handler on the vEVENTQ fd to read and propagate host
> generated vIOMMU events to the guest.
>
> The handler runs in QEMU’s main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
is it future proof to do that in the main loop?
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  2 ++
>  2 files changed, 60 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 74f0be3731..d320c62b04 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -378,6 +378,58 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
>                     sizeof(Cmd), &entry_num, cmd, errp);
>  }
>  
> +static void smmuv3_accel_event_read(void *opaque)
So if I understand correctly this handler is called for every
header/data. There cannot be several of them to be consumed in the queue?
> +{
> +    SMMUv3State *s = opaque;
> +    SMMUv3AccelState *accel = s->s_accel;
> +    struct {
> +        struct iommufd_vevent_header hdr;
> +        struct iommu_vevent_arm_smmuv3 vevent;
> +    } buf;
> +    ssize_t readsz = sizeof(buf);
> +    uint32_t last_seq = accel->last_event_seq;
> +    ssize_t bytes;
> +
> +    bytes = read(accel->veventq->veventq_fd, &buf, readsz);
> +    if (bytes <= 0) {
> +        if (errno == EAGAIN || errno == EINTR) {
> +            return;
> +        }
> +        error_report("vEVENTQ: read failed (%s)", strerror(errno));
nit you can use %m directly
> +        return;
> +    }
> +
> +    if (bytes < readsz) {
> +        error_report("vEVENTQ: incomplete read (%zd/%zd bytes)", bytes, readsz);
> +        return;
> +    }
> +
> +    if (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
> +        error_report("vEVENTQ has lost events");
once you get a lost_event, don't you need to reset the last_event_seq,
event_start to be able to consume again? 
> +        return;
> +    }
> +
> +    /* Check sequence in hdr for lost events if any */
> +    if (accel->event_start) {
> +        uint32_t expected = (last_seq == INT_MAX) ? 0 : last_seq + 1;
> +
> +        if (buf.hdr.sequence != expected) {
> +            uint32_t delta;
> +
> +            if (buf.hdr.sequence >= last_seq) {
> +                delta = buf.hdr.sequence - last_seq;
> +            } else {
> +                /* Handle wraparound from INT_MAX */
> +                delta = (INT_MAX - last_seq) + buf.hdr.sequence + 1;
> +            }
> +            error_report("vEVENTQ: detected lost %u event(s)", delta - 1);
do we want to report all losses or just warn once?
> +        }
> +    }
> +    accel->last_event_seq = buf.hdr.sequence;
> +    accel->event_start = true;
> +    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
> +}
> +
>  static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>  {
>      IOMMUFDVeventq *veventq = accel->veventq;
> @@ -385,6 +437,8 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>      if (!veventq) {
>          return;
>      }
> +    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
> +    close(veventq->veventq_fd);
>      iommufd_backend_free_id(accel->viommu.iommufd, veventq->veventq_id);
>      g_free(veventq);
>      accel->veventq = NULL;
> @@ -427,6 +481,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>      veventq->veventq_fd = veventq_fd;
>      veventq->viommu = &accel->viommu;
>      accel->veventq = veventq;
> +
> +    /* Set up event handler for veventq fd */
> +    fcntl(veventq_fd, F_SETFL, O_NONBLOCK);
> +    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
>      return true;
>  }
>  
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 7b0f585769..2c7c30d6a0 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -21,6 +21,8 @@
>  typedef struct SMMUv3AccelState {
>      IOMMUFDViommu viommu;
>      IOMMUFDVeventq *veventq;
> +    uint32_t last_event_seq;
> +    bool event_start;
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
Thanks

Eric


