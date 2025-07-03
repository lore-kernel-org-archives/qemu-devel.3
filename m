Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B66AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMjh-00018u-TJ; Thu, 03 Jul 2025 12:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXMje-00012S-PJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:24:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXMjX-0006q4-Fs
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:24:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23636167b30so1436595ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751559862; x=1752164662; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aTwGKwFQ62Eqawv1d7F6pjBSbRdUA0VSPj456ky5A3k=;
 b=BAP5/FRVMtO7PgDrQUVbRGkJ9hZbE6IZYoqXXyglTkUAVdeYU31COa/MOLJA36GfYA
 hjq+93mdY/pnjOG1sdeFESJDPbLUov3q4peEn9NQcxKToUiMdv0udKw42npTS31KlOO5
 h0PHyQeFyPcWunnKkHHm6yTxFwB61cMSJZiaAXK+qdnuJTI4LwnbqUkbbPvH33zTPGRQ
 idWLlY6m5LVk0W4TmeiBCQJzlsixwJL52xUle30E8n6f59V1zoyAh2aK6dWlHoblJw3n
 zoKvo8McnTXH5/FaUwx/eqLZPMz+Ah7IwF4slRIocrQ21WmLm872BDOD74bEoPPLLNDv
 xUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559862; x=1752164662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTwGKwFQ62Eqawv1d7F6pjBSbRdUA0VSPj456ky5A3k=;
 b=tS2gthvOGDyrawmEty542Ze1IU3ZqYdROOtNeiNpH6npQ7A+V9GWzN95vCAogrxedI
 u/X0E3sf4/ppBXNyJeOdGwi+hN0z3oFj1Z7zGv69hijAEBTBPHGVngGPd34ZVU7ISNN3
 jnYNHmMfwPzNbpH40b82jScVx6YkFaVGhA8IJDZ+wXVcOqCY1mK8jf1xxys5S5EABnnF
 xcPU2GTwxtNepbNeN3VBU3OiqPc9/tUHu0IVLBZtgxaCZb1dXFI+zvVOylN6eclryhIF
 iA/k1sWp7/bdjIazsvbaZmpxvpZMpvKfdznV9KgKQwU/EUbJN+CD1t+/fM3Qq/2ku8cI
 i8mg==
X-Gm-Message-State: AOJu0Yxd/fkFtPaUtgb9zzXPa49pMnQjw6U8mOmg5a43zcIzSFL09pB0
 hOb1HjT1+kbDrtaKSPf4I3+HvP3KfUKrXSp7j/QoMIRK4q5TcNp/Vlft
X-Gm-Gg: ASbGncsp3AreMGRGy51FuWmTgXuddCQLQaJv9ax15GkVkBUTsWXKQyy63kigJqSGiKo
 r/egROMoEzQoVMr2AuIGnJzYgrdTY3I6XYGMUIthNxnF3pkUqcc7c5xBTuHmI14C3HuiSHc9Cpg
 f6AEV0BAbAQ+kEMOUHgWHROtKNyAYu311jm1ovFP8EmS1EIiX/Hj0DI3KP1nwhFumQswVC6nRSR
 ufYZ7KmXz0W3PcPjZTMV4kCACwTEzkBiQfaxdn3oINaB4g1j1XUn/y6B8YkyTy8Kg1i86RO9+UO
 txa0glNP/TXDL1Rho80/ir1yIKTth1eou2A/E7O4EM95bCVuZTXxYcuVzpRTVx1h7g==
X-Google-Smtp-Source: AGHT+IG93Mc4+t846eF2fY9hnaaPDxJ5/oVc2LiDUopjjqffI4wdH9UnPwFeO5/FleUMiQ/IVtnJ4w==
X-Received: by 2002:a17:903:3510:b0:235:225d:30a2 with SMTP id
 d9443c01a7336-23c797d1470mr56513715ad.48.1751559861721; 
 Thu, 03 Jul 2025 09:24:21 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3adeeasm165134555ad.156.2025.07.03.09.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:24:21 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 16:24:19 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 11/11] hw/cxl: mailbox-utils: 0x5605 - FMAPI
 Initiate DC Release
Message-ID: <aGausxNbtyEyT8GG@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-12-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160219.989731-12-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62d.google.com
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

On Wed, Jul 02, 2025 at 05:02:17PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 88 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5ea0d07808..43a0d503aa 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
>          #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3644,6 +3645,86 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      }
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
> +#define CXL_FORCED_REMOVAL_MASK (1 << 4)
> +/*
> + * CXL r3.2 Section 7.6.7.6.6:
> + * Initiate Dynamic Capacity Release (Opcode 5605h)
> + */
> +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t flags;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int i, rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
> +            CXLDCExtentList updated_list;
> +            uint32_t updated_list_size;
> +            g_autofree CXLUpdateDCExtentListInPl *list =
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            /*
> +             * Fail with Invalid PA if an extent is pending and Forced Removal
> +             * flag not set.
> +             */
> +            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CXLDCExtentRaw ext = in->extents[i];
> +                    /*
> +                     * Check requested extents don't overlap with pending
> +                     * extents.
> +                     */
> +                    if (cxl_extent_groups_overlaps_dpa_range(
> +                            &ct3d->dc.extents_pending,
> +                            ext.start_dpa,
> +                            ext.len)) {
> +                        return CXL_MBOX_INVALID_PA;
> +                    }
> +                }
> +            }
> +
> +            rc = cxl_dc_extent_release_dry_run(ct3d,
> +                                               list,
> +                                               &updated_list,
> +                                               &updated_list_size);
> +            if (rc) {
> +                return rc;
> +            }
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_RELEASE_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                "CXL extent removal policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3778,6 +3859,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> +        cmd_fm_initiate_dc_release, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)

