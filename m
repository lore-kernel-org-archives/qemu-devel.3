Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD02FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqb-0004av-QQ; Fri, 06 Mar 2026 11:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXqZ-0004Xu-Jo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:15 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXqX-0007GF-FG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:15 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-899f8c33c11so54731186d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772813772; x=1773418572; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bvRZrc7EOUXxD2Z4fbQiIHK1+CDY8o7YpCfx/pbxVns=;
 b=BRZVnnr6bkLPn3xSAx+qtOTfF0DMqpeIwV8SmQAH9yNsZ3f4VONeUf5bj9+xBdNAFG
 AufR2Nzp/06eFcV2KToE5FeDLRUSuCjtx0WCWgxSe3CksTOZu1jpLNr116dFQ3esd6n/
 a1aVv/V1u7S50WIV4xOTWLCyq9q0NQnk9oNLwyg3iMo6kniRVW6iLaTW0zNN9a+G2Zh/
 2cpHHwJduxvdjl3Taw8DZ9D1eZFkruZHw6yoYvLPz1ri94+BRhPznMje4A4qOpeA2wbw
 B9AR7zGBzF8EstOLDjjxmkOoZJcWCnk+Cjcluc63o3It+NE9ItCvhUXYLCJyH33TP3fl
 BmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813772; x=1773418572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvRZrc7EOUXxD2Z4fbQiIHK1+CDY8o7YpCfx/pbxVns=;
 b=JGDS6KqE2qM02HWbQZ8Lrp5ACHf5NcAJGF9bnwvsvNd4bkavtg9bYo6+ckNirr6A8l
 +jDFYOAzWeN1Mf3qTcmpVXDbE70X/zc+rfLv1y98IFaQdeX3FQVzW59N9M+0B7d0F9GF
 q3TH2pOJfhoi9c5GLe8EFpvcYKgt57f7zP/ajy6Qe7vThfV5lMc1bD0Cv8ETb8Sr5xuP
 TsD8rJ092hmgoMB3oAlgO1OBDBIRCHO437Nril8HDmYAOQUxNrC6Nr/U7rIc4AQmGuNM
 1LF9E+Sn7p1uYkQWLXxFU/2CX5/QQdJUvxjZsPtCw5+o5EYOmgwyHbeFXe9LYmCqVPDj
 4xwQ==
X-Gm-Message-State: AOJu0Yxp+2rRiE+tITtrhxMT/oEsvYuwOHnn1lgKTvMH/5IWqStlGvze
 m7xfuZn4tEPiT0gypbVuj//iAQIjZ/IKrt/lLS0HS+EzIZmAYNoYApuVaLgZ2X3BNs0=
X-Gm-Gg: ATEYQzwQ0a/gPx1lY6FwMn8F8hqTMisHDgazuQesUYwPRbepmY41oQl9gZeqELjDZTO
 kMrQQBn3W5jdMvE6JrimFX9Bkftsg/2y0ZmXacvmjbL1UQ+iTJy9o4r3/eoP/glf1TQhu2ucmSi
 N5NEdyktly4hEVjLdT5Pjx0+tlW5zM2x8TNgEF1SIGSyvWfsqcl9017mGc1h0emX2xBqQ+PiNwA
 +68X7kKHWL/hwLTjjzlwH7NNHQU6gnebNQ1N5ELPF7cIRPuMNO9eVAVN7YJ3h/9BgquBRsN/2Tx
 68x6tCRiIY+fDs1B5R+wmAbv4SE3PjjlMVtYQqfPpkvGnTjdupjEk6G9NIa5dXamxk+m3qIZsLt
 yiNRljPE3GhRcDISH+C2lrT6f/ARpSE71HmKRSfNhWOLbXQu8dbbL9/CnRyfeHJm73g54sm7EOS
 WI7eXv3yIZhuPhnGtCXY1gt6JYeCPw9na1rlc3bj4pKzhJYmkJIE2TYLIB2vNykUR3pFwxU/vBt
 oYL1ET235jv/lNw3wbG
X-Received: by 2002:a05:6214:5096:b0:89a:9f9:246e with SMTP id
 6a1803df08f44-89a30af16d8mr34738806d6.45.1772813772036; 
 Fri, 06 Mar 2026 08:16:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a31719574sm17315506d6.48.2026.03.06.08.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:16:11 -0800 (PST)
Date: Fri, 6 Mar 2026 11:16:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, anisa.su887@gmail.com,
 armbru@redhat.com, david@kernel.org, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v7 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <aar9yZvjOkNQlnEC@gourry-fedora-PF4VCD3F>
References: <20260306121151.883-1-alireza.sanaee@huawei.com>
 <20260306121151.883-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306121151.883-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 06, 2026 at 12:11:51PM +0000, Alireza Sanaee wrote:
> The CXL address to device decoding logic is complex because of the need to
> correctly decode fine grained interleave. The current implementation
> prevents use with KVM where executed instructions may reside in that memory
> and gives very slow performance even in TCG.
> 
> In many real cases non interleaved memory configurations are useful and for
> those we can use a more conventional memory region alias allowing similar
> performance to other memory in the system.
> 
> Whether this fast path is applicable can be established once the full set
> of HDM decoders has been committed (in whatever order the guest decides to
> commit them). As such a check is performed on each commit/uncommit of HDM
> decoder to establish if the alias should be added or removed.
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>

> ---
> Thanks to Gregory, and Li Zhijian for their feedback.
> v6->v7:
>           - Fixed a div by zero situation in the code for interleaved_ways_dec func.
>           - Changed the signature of cfmws_update_non_interleaved function to void.
> 
>  hw/cxl/cxl-component-utils.c |   6 ++
>  hw/cxl/cxl-host.c            | 197 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   4 +
>  include/hw/cxl/cxl.h         |   1 +
>  include/hw/cxl/cxl_device.h  |   4 +
>  5 files changed, 212 insertions(+)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 07aabe331c..a624357978 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -143,6 +143,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
>          value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
>      }
>      stl_le_p((uint8_t *)cache_mem + offset, value);
> +
> +    if (should_commit) {
> +        cfmws_update_non_interleaved(true);
> +    } else if (should_uncommit) {
> +        cfmws_update_non_interleaved(false);
> +    }
>  }
>  
>  static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 2dc9f77007..079b27133b 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -264,6 +264,203 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
>      return d;
>  }
>  
> +typedef struct CXLDirectPTState {
> +    CXLType3Dev *ct3d;
> +    hwaddr decoder_base;
> +    hwaddr decoder_size;
> +    hwaddr dpa_base;
> +    unsigned int hdm_decoder_idx;
> +} CXLDirectPTState;
> +
> +static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
> +                                              CXLFixedWindow *fw)
> +{
> +    CXLType3Dev *ct3d = state->ct3d;
> +    MemoryRegion *mr = NULL;
> +    uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
> +    MemoryRegion *direct_mr;
> +    g_autofree char *direct_mr_name;
> +    unsigned int idx = state->hdm_decoder_idx;
> +
> +    if (ct3d->hostvmem) {
> +        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +
> +        vmr_size = memory_region_size(vmr);
> +        if (state->dpa_base < vmr_size) {
> +            mr = vmr;
> +            offset = state->dpa_base;
> +        }
> +    }
> +    if (!mr && ct3d->hostpmem) {
> +        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +
> +        pmr_size = memory_region_size(pmr);
> +        if (state->dpa_base - vmr_size < pmr_size) {
> +            mr = pmr;
> +            offset = state->dpa_base - vmr_size;
> +        }
> +    }
> +    if (!mr) {
> +        return;
> +    }
> +
> +    if (ct3d->direct_mr_fw[idx]) {
> +        return;
> +    }
> +
> +    direct_mr = &ct3d->direct_mr[idx];
> +    direct_mr_name = g_strdup_printf("cxl-direct-mapping-alias-%u", idx);
> +    if (!direct_mr_name) {
> +        return;
> +    }
> +
> +    memory_region_init_alias(direct_mr, OBJECT(ct3d), direct_mr_name, mr,
> +                             offset, state->decoder_size);
> +    memory_region_add_subregion(&fw->mr,
> +                                state->decoder_base - fw->base, direct_mr);
> +    ct3d->direct_mr_fw[idx] = fw;
> +}
> +
> +static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
> +                                               uint64_t decoder_base,
> +                                               unsigned int idx)
> +{
> +    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
> +    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
> +
> +    if (!owner_fw) {
> +        return;
> +    }
> +
> +    if (!memory_region_is_mapped(direct_mr)) {
> +        return;
> +    }
> +
> +    if (cxl_cfmws_find_device(owner_fw, decoder_base, false)) {
> +        return;
> +    }
> +
> +    memory_region_del_subregion(&owner_fw->mr, direct_mr);
> +    object_unparent(OBJECT(direct_mr));
> +    ct3d->direct_mr_fw[idx] = NULL;
> +}
> +
> +static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
> +{
> +    CXLDirectPTState *state = opaque;
> +    CXLFixedWindow *fw;
> +
> +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> +        return 0;
> +    }
> +
> +    fw = CXL_FMW(obj);
> +
> +    /* Verify not interleaved */
> +    if (!cxl_cfmws_find_device(fw, state->decoder_base, false)) {
> +        return 0;
> +    }
> +
> +    cxl_fmws_direct_passthrough_setup(state, fw);
> +
> +    return 0;
> +}
> +
> +static int update_non_interleaved(Object *obj, void *opaque)
> +{
> +    const int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> +    bool commit = *(bool *)opaque;
> +    CXLType3Dev *ct3d;
> +    uint32_t *cache_mem;
> +    unsigned int hdm_count, i;
> +    int interleave_ways_dec;
> +    uint32_t cap;
> +    uint64_t dpa_base = 0;
> +
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        return 0;
> +    }
> +
> +    ct3d = CXL_TYPE3(obj);
> +    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
> +                                                 CXL_HDM_DECODER_CAPABILITY,
> +                                                 DECODER_COUNT));
> +    for (i = 0; i < hdm_count; i++) {
> +        uint64_t decoder_base, decoder_size, skip;
> +        uint32_t hdm_ctrl, low, high;
> +        int iw, committed;
> +
> +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
> +        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
> +
> +        /*
> +         * Optimization: Looking for a fully committed path; if the type 3 HDM
> +         * decoder is not commmitted, it cannot lie on such a path.
> +         */
> +        if (commit && !committed) {
> +            return 0;
> +        }
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> +                       i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> +                        i * hdm_inc);
> +        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        dpa_base += skip;
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
> +        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
> +        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +
> +        if (iw == 0) {
> +            if (!commit) {
> +                cxl_fmws_direct_passthrough_remove(ct3d, decoder_base, i);
> +            } else {
> +                CXLDirectPTState state = {
> +                    .ct3d = ct3d,
> +                    .decoder_base = decoder_base,
> +                    .decoder_size = decoder_size,
> +                    .dpa_base = dpa_base,
> +                    .hdm_decoder_idx = i,
> +                };
> +
> +                object_child_foreach_recursive(object_get_root(),
> +                                               cxl_fmws_direct_passthrough,
> +                                               &state);
> +            }
> +        }
> +
> +        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
> +        if (interleave_ways_dec == 0) {
> +            return 0;
> +        }
> +
> +        dpa_base += decoder_size / interleave_ways_dec;
> +    }
> +
> +    return 0;
> +}
> +
> +void cfmws_update_non_interleaved(bool commit)
> +{
> +    /*
> +     * Walk endpoints to find both committed and uncommitted decoders,
> +     * then check if they are not interleaved (but the path is fully set up).
> +     */
> +    object_child_foreach_recursive(object_get_root(),
> +                                   update_non_interleaved, &commit);
> +
> +    return;
> +}
> +
>  static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
>                                    unsigned size, MemTxAttrs attrs)
>  {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4739239da3..d9fc0bec8f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -427,6 +427,8 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>  
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
> +
> +    cfmws_update_non_interleaved(true);
>  }
>  
>  static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
> @@ -442,6 +444,8 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
>  
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
> +
> +    cfmws_update_non_interleaved(false);
>  }
>  
>  static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 998f495a98..d8cd8359d2 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -71,4 +71,5 @@ CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
>  typedef struct CXLDownstreamPort CXLDownstreamPort;
>  DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
>  
> +void cfmws_update_non_interleaved(bool commit);
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 393f312217..ba551fa5f9 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -685,6 +685,8 @@ typedef struct CXLSetFeatureInfo {
>      size_t data_size;
>  } CXLSetFeatureInfo;
>  
> +typedef struct CXLFixedWindow CXLFixedWindow;
> +
>  struct CXLSanitizeInfo;
>  
>  typedef struct CXLAlertConfig {
> @@ -712,6 +714,8 @@ struct CXLType3Dev {
>      uint64_t sn;
>  
>      /* State */
> +    MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
> +    CXLFixedWindow *direct_mr_fw[CXL_HDM_DECODER_COUNT];
>      AddressSpace hostvmem_as;
>      AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
> -- 
> 2.43.0
> 

