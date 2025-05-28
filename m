Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868B0C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 17:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKKkU-0006aX-SN; Wed, 28 May 2025 13:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uKKkT-0006aM-8V
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:39:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uKKkQ-0007nI-2b
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:39:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so3347150b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748453963; x=1749058763; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3CUMqKkExl5Yqm2d32QXyDSBLqA1Cfd73PkgxPB7vY=;
 b=ik1O7NudMbSR0pGSveHHtWyd+WhaRB2Jitj71xpBYASzzROGrUJiHXbqjXjTF1H/+u
 xHHGgLT0JCG4n/ab8s2UIlWrB43c+D0Tm6y923PONJux6+6r6KduoAw6hYDGkGIrTHUS
 pKyWtsaJEE/qyM2GUN5bdfRDYGVkowhVaoT3BdyJQQ/TKpz9TOYp2skU4qQIl5yjl9g+
 jenW67rA+xjarFgF31nQJK+UkrL+Ljo9axpxTSxUEk1CqnSfvslVUedbCkg7/x0/tc3z
 VoHDmz1xCqUtkX4U3DpcxZ1/o8wJVnVaNBAZjcQS/rOmX5BXLmZLuKXN66/6sCNCFNNO
 Cifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748453963; x=1749058763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3CUMqKkExl5Yqm2d32QXyDSBLqA1Cfd73PkgxPB7vY=;
 b=qgbky4hzbxUiVCwhSOpQHT3BWNt1EHgy9J0FprTfRby0Wb4HTs7fn+Aowe2gmtWHkO
 M2i0f6aB6tQJkW2xLcXAa28ewH+I1OpB3/CqyXhkP2E1gNrKLdamG1KfR/d0SUEE0+WO
 qeODEDngpvRvaq7WoW5FIjWoNynPW3Uybrmn0cqbi7zXJANyj2S1U/oRgM21eJ/Ib/z/
 3H106kZL7m021DdUAFQFjSNSdavq8lXa3MnuB51SoGXCd+wRFFp+SZ839vT2qoaLaKYH
 /cyewyC79ND2w8fDRSQ2YHunztwK5tN9QA30ZviGWOLz+a854zWzGXSZJVwIX3a7x/hm
 ZtZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf6Jyc9zGcrjlb7h2mUaskz9r5VLkLdc0crxuHLwE/Vv24tRzgbpFyuK6vrRu5mcm1psoVXqvnvz8Y@nongnu.org
X-Gm-Message-State: AOJu0Yx5GSa5ZgU7q/5VTgT3o7dpN41FPP8q350aFUVl4zUirUJeNP6c
 lJV3iwasp3XlYwKmGLgAFsT1HgrHqpVbM58zxvU4IRT2ITrNcJh+REpZ
X-Gm-Gg: ASbGnctwKleVFa1+ZgvsJuMHHVYpmTBuz34QACMLrzbvlruq9zT5CmNIUQmXij53YJM
 rtLlTF3DktqnI/mmNjENyt5KWkRCUbRlSzNUJdac33YJl6UYQyDPZuDj2n4a8Wkma96uxx7CFZh
 xzF5W2uxb7ftUAj8w204dqA7jUto+6CPVT4DTOrMxrFL0I39OMGcdDU1dET0r50GP6kmQ+V9FLD
 8HMSDSqPSe6wQ8SKwS3sFws6NMwCyCpO//ze/4OPg/ExLQq0S3MaJQz1nxkXkP1H2blE/ybl1Ep
 4x8v4l8p9jfQL6gDyl+zvAj7jhK89+WQv3f46jkQz5hNBTNqhfkQr/Y=
X-Google-Smtp-Source: AGHT+IFfrHY8StlI1EtMqUvTKr+winERQk33CEfPSAoE1icRvErrxpuZfwfiSeoysqnF14o4j70zgQ==
X-Received: by 2002:a05:6a00:140f:b0:740:3830:4119 with SMTP id
 d2e1a72fcca58-745fe035cc9mr28850379b3a.18.1748453962793; 
 Wed, 28 May 2025 10:39:22 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-746e345e842sm1492123b3a.168.2025.05.28.10.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 10:39:22 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 28 May 2025 17:39:20 +0000
To: nifan.cxl@gmail.com
Cc: jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, anisa.su887@gmail.com,
 gourry@gourry.net
Subject: Re: [PATCH] hw/cxl: fix DC extent capacity tracking
Message-ID: <aDdJj0gBtFQKt8VA@smc-140338-bm01>
References: <20250520195741.789841-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520195741.789841-1-nifan.cxl@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 12:56:43PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
> extents in different states including added, pending, etc.
> 
> Before the change, for the in-device extent number tracking purpose, we only
> have "total_extent_count" defined, which only tracks the number of
> extents accepted. However, we need to track number of extents in other
> states also, for now it is extents pending-to-add.
> 
> To fix that, we introduce a new counter for dynamic capacity
> "nr_extents_accepted" which explicitly tracks number of the extents
> accepted by the hosts, and fix "total_extent_count" to include
> both accepted and pending extents counting.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Ping ...

Hi Jonathan,

The FM DCD management mailbox patches needs to be on top of this fix.

Fan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h |  3 ++-
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 299f232f26..0b615ea37a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      uint16_t out_pl_len, size;
>      CXLDCExtent *ent;
>  
> -    if (start_extent_id > ct3d->dc.total_extent_count) {
> +    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> @@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
>  
>      stl_le_p(&out->count, record_count);
> -    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
>      stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
>  
>      if (record_count > 0) {
> @@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
>      QTAILQ_INSERT_TAIL(list, group, node);
>  }
>  
> -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
>  {
>      CXLDCExtent *ent, *ent_next;
>      CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> +    uint32_t extents_deleted = 0;
>  
>      QTAILQ_REMOVE(list, group, node);
>      QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
>          cxl_remove_extent_from_extent_list(&group->list, ent);
> +        extents_deleted++;
>      }
>      g_free(group);
> +
> +    return extents_deleted;
>  }
>  
>  /*
> @@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> -    uint32_t i;
> +    uint32_t i, num;
>      uint64_t dpa, len;
>      CXLRetCode ret;
>  
> @@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      }
>  
>      if (in->num_entries_updated == 0) {
> -        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +        ct3d->dc.total_extent_count -= num;
>          return CXL_MBOX_SUCCESS;
>      }
>  
> @@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>  
>          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
>          ct3d->dc.total_extent_count += 1;
> +        ct3d->dc.nr_extents_accepted += 1;
>          ct3_set_region_block_backed(ct3d, dpa, len);
>      }
>      /* Remove the first extent group in the pending list */
> -    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +    ct3d->dc.total_extent_count -= num;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -3160,7 +3167,7 @@ free_and_exit:
>          }
>          *updated_list_size = 0;
>      } else {
> -        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
> +        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
>      }
>  
>      return ret;
> @@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>          ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
>          cxl_remove_extent_from_extent_list(&updated_list, ent);
>      }
> -    ct3d->dc.total_extent_count = updated_list_size;
> +    ct3d->dc.total_extent_count += (updated_list_size -
> +                                    ct3d->dc.nr_extents_accepted);
> +
> +    ct3d->dc.nr_extents_accepted = updated_list_size;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 94e7274912..f283178d88 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      }
>      if (group) {
>          cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> +        dcd->dc.total_extent_count += num_extents;
>      }
>  
>      /*
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed6cd50c67..a151e19da8 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -618,6 +618,7 @@ struct CXLType3Dev {
>          CXLDCExtentList extents;
>          CXLDCExtentGroupList extents_pending;
>          uint32_t total_extent_count;
> +        uint32_t nr_extents_accepted;
>          uint32_t ext_list_gen_seq;
>  
>          uint8_t num_regions; /* 0-8 regions */
> @@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
>                                                      uint16_t shared_seq);
>  void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
>                                         CXLDCExtentGroup *group);
> -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
>  void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                   uint64_t len);
>  void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> -- 
> 2.47.2
> 

-- 
Fan Ni (From gmail)

