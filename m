Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCA4C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPTH-0002F2-G9; Tue, 20 May 2025 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHPTC-0002De-O9
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:05:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHPTB-00067O-1I
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:05:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso46093935ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747757130; x=1748361930; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/6sMJeL+6+CmWHLAjXbC2hLM8VOcfQ7nl6fo+PeHtvQ=;
 b=XOIcdUp2SpzS0qkF2M0Ys8JPI+3YWur3fLNGmk760mryqwvPNz/OFHMGewuUeqh/sd
 FHbtwxrumu6znQf7Iurx1nmpKhtPRyiumBsjSglUYFIRD0x48H3keUXdusVyK8VOrabI
 wTr4Qlstd41sQjqVaagcrlq5iAvXNBzJHs+ExQw/zdnveAyOw3iZMRnoIr1ky6FKsPi3
 QseOjEet/ZzOn4E/+qolQLkw6/OSK6ibTtqk1buoXQBBTyNNvfRvXXuvhmKDKkrgMlw1
 eBKQlFAfVBvI5sS2wXKqSI8EVENGMIkXNI/8Oo0H/Om87f4WgqUB89nbW+hsQa3//EIL
 zvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747757130; x=1748361930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6sMJeL+6+CmWHLAjXbC2hLM8VOcfQ7nl6fo+PeHtvQ=;
 b=XK3QTioMVTd+gJCxwDvUSksZo4nsZoFXbaCJPT5Eg+YeKeb1TxgRpA1rJXPlMMe/rA
 mCkVNysQlcmn1YeLqaJDAuQCQhHhh8xjxlRbgBl7VOcyMiD2kAWiCFlyqZRp0OKF82qi
 Oi2BXwmsT6tFgj90SEPIjgsrEEQJoBTkQEyILaa3doUoNLY6fT8ZEu9Y5t3S2MrVrlBD
 XUBQu09pFxv7umxk5qtcMvcmopdloHaN2qHqJfMCA4EIa6gXoZ/1l9fYoi7hGQhGhjPC
 lpzlvgCx4giC9E/YUr/UU/YnwacPS8/g/R/xYXMFEcEbuk//m81yai7NTk5YA4cvpxTS
 oYEw==
X-Gm-Message-State: AOJu0YzX8DAz3qzv5peZYVH+wXcFTax5PPhK2bmX/LTyajtXn2RRyYx1
 arPqu0EDXlAp7mhg704kbArATWpljMuUm/aPdEuEtUnWUaJCBrWbtjYq
X-Gm-Gg: ASbGnct6cQi68qw/xMjSvhBoYvSHNlEQpCHhJcslITD6cPfl7Tc6NlvGgJ8s7AH0L4v
 AeISovtC7m8c6m1oxk1sv/93SgO/jOjRU6eQBmldEH7lxSzC5dDB1U7JsCcNqBPystJ6whRUgGF
 1TaFWJQKbhmwdxVQY8vu0K/xGxdHwTllFBMOD6tBbzjgoQJJ3oRRgWvIPrhp7efXkohgzzbGEMt
 R+VpyxSgcMV+EPC3GVFv4I24em2F+BI29Ict0AIt1AYLLRsp9oa5obb2iXM2bGBK+iOVjV15h60
 nXbby6XtsHsZ2UzyC/ITfQr4n35FLMPqVKrxVucavA==
X-Google-Smtp-Source: AGHT+IHHmn5fYi+4RFwBN/1ksj4IBFBleWBF5S9SwFaREwh2uZNh4psYALQqkfpFPqcA3yxmklAAcQ==
X-Received: by 2002:a17:903:11c3:b0:223:47b4:aaf8 with SMTP id
 d9443c01a7336-231d45eeeb0mr217773035ad.52.1747757125779; 
 Tue, 20 May 2025 09:05:25 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e98018sm78925215ad.155.2025.05.20.09.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 09:05:25 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:05:15 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 03/10] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <aCyoO3FuMb-Hqe8i@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-4-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-4-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x629.google.com
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

On Thu, May 08, 2025 at 12:00:59AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Add booleans to DC Region struct to represent dsmas flags (defined in CDAT)
> in preparation for the next command, which returns the flags in the

s/next command/mailbox command 0x5601h/, otherwise
Reviewed-by: Fan Ni <fan.ni@samsung.com>

> response.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>


> ---
>  hw/mem/cxl_type3.c          |  8 +++++++-
>  include/hw/cxl/cxl_device.h | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 7129da0940..05d4c861f1 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -232,10 +232,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>           * future.
>           */
>          for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            ct3d->dc.regions[i].nonvolatile = false;
> +            ct3d->dc.regions[i].sharable = false;
> +            ct3d->dc.regions[i].hw_managed_coherency = false;
> +            ct3d->dc.regions[i].ic_specific_dc_management = false;
> +            ct3d->dc.regions[i].rdonly = false;
>              ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
>                                            dsmad_handle++,
>                                            ct3d->dc.regions[i].len,
> -                                          false, true, region_base);
> +                                          ct3d->dc.regions[i].nonvolatile,
> +                                          true, region_base);
>              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
>  
>              cur_ent += CT3_CDAT_NUM_ENTRIES;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index bebed04085..cbcc1bc9f5 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -177,6 +177,15 @@ typedef enum {
>      MAX_LOG_TYPE
>  } CXLLogType;
>  
> +/* DSMAS Flags Bits */
> +typedef enum {
> +    CXL_DSMAS_FLAGS_NONVOLATILE = 2,
> +    CXL_DSMAS_FLAGS_SHARABLE = 3,
> +    CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY = 4,
> +    CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT = 5,
> +    CXL_DSMAS_FLAGS_RDONLY = 6,
> +} CXLDSMASFlags;
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
> @@ -609,6 +618,12 @@ typedef struct CXLDCRegion {
>      uint8_t flags;
>      unsigned long *blk_bitmap;
>      uint64_t supported_blk_size_bitmask;
> +    /* Following bools make up dsmas flags, as defined in the CDAT */
> +    bool nonvolatile;
> +    bool sharable;
> +    bool hw_managed_coherency;
> +    bool ic_specific_dc_management;
> +    bool rdonly;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {
> -- 
> 2.47.2
> 

-- 
Fan Ni

