Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3418606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQhl2GkD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLs9d-0001ZD-I2; Tue, 27 Oct 2026 21:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1xLs9Y-0001Wk-5J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 21:08:33 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1xLs9U-0000EN-Ip
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 21:08:31 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so767304c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793149707; x=1793754507; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FpR5vVi8uAfWfF2ulvEpP4ok4aRKEHsd8aW1c5L0HNI=;
 b=yQhl2GkDnVoigXaj3OROxASO7g++yi/0CdQU11mo3VlJE4z4hPWHIFGwZ1hlplLFxm
 IojWvctc8iFiDSDW4KsEKfWKAkVFREUQR3rxvLgRpn+OregKiJu34fBK9fdszpp8Bv2R
 3+qQj2MOGMzFwXsNXObZ+w0t0UKQPQmtgdw7q6QH51RY+Gf4twdT3JGFBmddKyRtI/sJ
 hQ7MpHDGPLm4gqAITJ6zIPD3P9tS9OdGdZbwmFNZpLRW92Ahr6RwHuF16rKMSbRRf+2l
 H51SkvdQd2RH+76zbSjQrgvR82exd+cx0tKiaWvDHEho6EG99eTywmmjN5XOAD2gQG9u
 kBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793149707; x=1793754507;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FpR5vVi8uAfWfF2ulvEpP4ok4aRKEHsd8aW1c5L0HNI=;
 b=KcIVAIz1xHU0lt7Jia6y/Eq42ClrhzfIhzeAekrPS2K/JlubrixqF5qLm51YfKrgZu
 4w7U5IK9Xao66bJOpD6EI25uIS1UbImmCo1gyBCnSxeCIOsPPAPuBaeZ0LFuQaMPajKg
 40NzQ2/XTJiget2s6j/4WjzlAY2WHmJqjJqAPXNE3aKsL8zDUF7DVopSThJ20L7XILDM
 Dq1wmyf39wFqYomk8P3EeUDGqSyhi28x5XEruo/pK0E2uFaOtCfbIlLeYHTifN5msKMi
 eNhA4ma/EMYCKu3EMFlxMLWqZktzM3TMkiAFN1EtNzrQa+0UY3hWPyJjO3yXRU46AWtD
 +c9g==
X-Gm-Message-State: AFq9FYJPmKxm4ARbW11O5/48+OGdKKEpeJbAu50j8F161aBqomuY5wJQ
 /OrRwGsRgseJI79JAPu+gL8Bp081H1YWreoZtFqbIeOIau5yCKpNtGDm
X-Gm-Gg: AYBFou3zkaCV2fzUpCJWwO7LIMvG6fC1WD3Ea/0srOfE0dhIqbH286Mb+KmaBNetm6b
 nwp1FH8k0iXdRLBfnpQ6+n1u2Ma83njWkKblIwvp4OxecF8h8U+aK+ICPMATeGECadUKu9f0CZn
 nL8EoSOa8WVpRVtKldgGrtvfXTMBn1K6NmLhMwNQ0XtwM/3KDml7Y37Fg0Tdw7DgHqjuP8mQtEB
 VbPwaF1h6cSZdZU4ohAxMtL7xiaJ4pkHKZD55FPjgQWPrYWp+pZed2WUuKqG+xI+H6XnOWcgqO+
 UszgXu8tXoJkDz9en3yJHSRY92ny2rJeOGbEoPsL1zwG0zmrj36xFET7nb2lbd5QvEX/+5SQo/b
 YmMyNW9OxhDq30REJ3uy12makBXm/vA29DQxuQl1Q96eISbcQ3WbbL3gIAWWrBBtYL6U1vf+61V
 pObg5Rueb5T//QO/Im7yh/ROu+ZFPUFwNmiXyzq9SGbvG1EQ5CL37gvl4sLBph/4Yl++r1WBXTQ
 /qCdXoT0d7lclcyUIj/q2rsbFhGMiR6/c0s02mdxMj0VIK5ey9r0+0t5irGczDUN64V0AmXL4wx
 qRune5IIhHMRfYWKVzwJr481
X-Received: by 2002:a05:7022:32b:b0:19b:1202:77f8 with SMTP id
 a92af1059eb24-1a6ce2ff0b1mr1423872c88.32.1793149706626; 
 Tue, 27 Oct 2026 18:08:26 -0700 (PDT)
Received: from cxlqual ([220.120.90.131]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a64fe0fsm835463c88.1.2026.10.27.18.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 18:08:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 28 Oct 2026 10:09:54 +0900
To: Yukiya Takaki <fj2110jc@fujitsu.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>, linux-cxl@vger.kernel.org,
 "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
 y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: Re: [PATCH RFC 3/7] QEMU: hw/cxl: add helper to get HPA range for
 CXL Type 3
Message-ID: <auFLYiiwDiuXaHfZ@cxlqual>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
 <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=anisa.su887@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 07:03:24PM +0900, Yukiya Takaki wrote:
> The previously added `hpa_offset` on CXLType3Dev records the offset of a
> device within its CFMW window, but there is no simple helper to obtain the
> full host physical address (HPA) range for a given Type 3 device.
> 
> This patch adds `ct3_type3_get_hpm_range()`, which returns the HPA base and
> size for a CXLType3Dev by combining the CFMW base, the per‑device offset
> and the device size. The helper is declared in the header so that other
> code can use it when building tables and regions.
> 
> Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c          | 40 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  2 files changed, 41 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d08a4255c9..811f8e247d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1358,6 +1358,46 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>      return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
>  
> +static uint64_t c3t_addr_size(DeviceState *dev)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(dev);
> +    MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +
I think the reason program-hdm-decoder=true fails on CXL PMEM
topologies as you mentioned in the cover letter is because this function only
calculates size from ct3d->hostvmem, which will pass NULL to
memory_region_size() here.

RAM and PMEM size is already calculated in cxl_setup_memory() in
ct3d->cxl_dstate.static_mem_size

I think this helper can be deleted by directly using static_mem_size in 
ct3_type3_get_hpm_range().

Or if you prefer not to support PMEM for this feature at all, you can
reject it in patch 2:

static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp) {
...
if (ct3d->program_hdm_decoder &&
        (!ct3d->hostvmem || ct3d->hostpmem || ct3d->dc.num_regions)) {
        error_setg(errp, "program-hdm-decoder requires volatile-memdev "
                         "and no persistent or dynamic capacity");
        return false;
    }

}
> +    return memory_region_size(vmr);
> +}
> +
> +static uint64_t c3t_hpa_base(DeviceState *dev)
> +{
> +    GSList *cfmws_list, *iter;
> +
> +    cfmws_list = cxl_fmws_get_all_sorted();
> +    for (iter = cfmws_list; iter; iter = iter->next) {
> +        struct CXLFixedWindow *fw;
> +
> +        if (!object_dynamic_cast(iter->data, TYPE_CXL_FMW)) {
> +            continue;
> +        }
> +        fw = CXL_FMW(iter->data);
> +
> +        PXBCXLDev *pxb = fw->target_hbs[0];
> +        if (ct3d_to_cxl_pxb(dev) != pxb->cxl_host_bridge) {
> +            continue;
> +        }
> +
> +        g_slist_free(cfmws_list);
> +        return fw->base;
> +    }
> +    g_slist_free(cfmws_list);
> +
> +    return 0;
> +}
> +
> +void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size)
> +{
> +    *base = c3t_hpa_base(DEVICE(dev)) + dev->hpa_offset;
> +    *size = c3t_addr_size(DEVICE(dev));
	*size = dev->cxl_dstate.static_mem_size;

Thanks,
Anisa

> +}
> +
>  static void ct3d_reset(DeviceState *dev)
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(dev);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index c3a729f8c5..07654f4b62 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -878,6 +878,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size);
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp,
> -- 
> 2.52.0
> 

