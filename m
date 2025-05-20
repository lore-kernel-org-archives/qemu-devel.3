Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC87C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQbw-0008No-Rt; Tue, 20 May 2025 13:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQbn-0008Mq-Oi
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:18:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQbg-0003d8-Ol
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:18:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so4657646b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747761503; x=1748366303; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WHRuLt0uKLk3Rne5lNMYRtlHU9xfOLNLxmkhdwAs/4g=;
 b=d52MEZntdN2ylF52JaImdV5H2xQQR13cWCA4VfQho+yKDHFUdHyvCgTtldvUPH7dTj
 nL8rD0hi51sJCgx3GW9MBxWWty6EuRSiiwJeFmbqF7kXOxQqVOU0fyWIs910p0MmDo5a
 1LgECQZiwVw6cLRMPr9hjt5VESLD9Ft9pGJMPYJTF5s12uVLgLoZa+b/KfyrOPLm/G54
 V+LgcyfssSN94HHEGtgxnMdLqi10hLv9GmXEDrND79dJF7VIk8NBm7xytWw0hsfqwsfA
 AQnKZv9SGMSgTYDhdSjs7g3V02wyrl9bNGLLwlEzg8aLCq3hy5amZNuW3vDZh8D9Y8vf
 laWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761503; x=1748366303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHRuLt0uKLk3Rne5lNMYRtlHU9xfOLNLxmkhdwAs/4g=;
 b=aoKl32pzpUU2jRIig3UwKrRWrlUSavh1mTp0/H3bmjjaeF0ChAUcF7OcLFHKSg72q7
 xOuHTIEBPV8mttkpbs7o3zDm+gZUh6XnG+gdZIB1M1fZEFi7fKZWSsFRlA+X3f3MGob0
 l2p0f5nzByyatf6hquPXvej7IV7/mHU4KbPq0QVnRAoKWEJAE5Zj6GSfTu9qrdeay+2Y
 6xnCtLbiWMeF/58OdrAp2A5nuq+7WXHzu+htX7SInkN1vEhycHoxC0KB9OIh83zfjN1u
 WeT8MU4yP4cJswPe/XqEDJlTtnkkbW0/tc1+Y8z3+P22bQyW0tgmD3WRuaQULqirg3Ve
 l0ew==
X-Gm-Message-State: AOJu0Ywuj/xRlCz0ASE4jKsl3SAXJeRMXz8u+rjfcn8dwFWYxEcj8seJ
 exAOmzPoXt9BIXNEUfYX3b3nL1xr2Tq2v2vA9ew2BhpDWECCnayWQXZj
X-Gm-Gg: ASbGnctOw7VUPAh8Pus+eP0apB1CBCtTbqqX4QoUqupzcfapoEfYkdD9ntDP0I0keBE
 Oj6lFHYx5nO+x+lCbVnLy4/aWZR8YuSgjpjEOecel/XPybVxPGh6g4VfwQ6awLmyOPP2elia9tl
 ROi6WOE3QWkJXPU++sC1JSGSz5dIz9p05lSIATj2+m7951Sgafx2qrVUNGFNndK4Vxq/HPjXVPu
 FIMcfZHC+nc76/1a27uu0dgN5pG+73nF1MxDSCRrDJk512ThHOuWfGv5GG/Hgt0c35ypOelZ5bs
 JJtVPTYOioWtuT7/tkZWQ3MMF8jWi+k8V/aVZ/twuQ==
X-Google-Smtp-Source: AGHT+IEctpiI1b8xjCQw29kS9/gOk5u9HHcNs6F4R53OPn52CJSeYZxVBSumexGTOGHE18YzMnuB3w==
X-Received: by 2002:a05:6a00:391a:b0:734:b136:9c39 with SMTP id
 d2e1a72fcca58-742acd509f2mr22687459b3a.19.1747761502653; 
 Tue, 20 May 2025 10:18:22 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b9dsm8159736b3a.88.2025.05.20.10.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:18:22 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 10:18:20 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 08/10] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Message-ID: <aCy5XLlc81t0BdVp@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-9-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-9-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42e.google.com
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

On Thu, May 08, 2025 at 12:01:04AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
> Very similar to previously implemented command 0x4801.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 75 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_opcodes.h |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index fe38a13f71..a897a34ef9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3516,6 +3516,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
> +static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t rsvd[2];
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint16_t host_id;
> +        uint8_t rsvd[2];
> +        uint32_t start_extent_id;
> +        uint32_t extents_returned;
> +        uint32_t total_extents;
> +        uint32_t list_generation_num;
> +        uint8_t rsvd2[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCExtent *ent;
> +    CXLDCExtentRaw *out_rec;
> +    uint16_t record_count = 0, record_done = 0, i = 0;
> +    uint16_t out_pl_len, max_size;
> +
> +    if (in->host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (in->start_extent_id > ct3d->dc.total_extent_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(in->extent_cnt,
> +                       ct3d->dc.total_extent_count - in->start_extent_id);
> +    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
> +    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +
> +    stw_le_p(&out->host_id, in->host_id);
> +    stl_le_p(&out->start_extent_id, in->start_extent_id);
> +    stl_le_p(&out->extents_returned, record_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +    if (record_count > 0) {
> +        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> +            if (i++ < in->start_extent_id) {
> +                continue;
> +            }
> +            out_rec = &out->records[record_done];
> +            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
> +            stq_le_p(&out_rec->len, ent->len);
> +            memcpy(&out_rec->tag, ent->tag, 0x10);
> +            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
> +
> +            record_done++;
> +            if (record_done == record_count) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3649,6 +3722,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>           CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> +    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> +        cmd_fm_get_dc_region_extent_list, 12, 0 },
>  };
>  
>  /*
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index ed4be23b75..ad4e614daa 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -65,5 +65,6 @@ enum {
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
>          #define SET_DC_REGION_CONFIG 0x2
> +        #define GET_DC_REGION_EXTENT_LIST 0x3
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni

