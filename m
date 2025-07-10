Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDEBC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 13:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZrFT-0005kP-9u; Thu, 10 Jul 2025 09:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZrFS-0005jn-62
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:23:38 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZrFO-0006ru-Vh
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:23:37 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-710bbd7a9e2so9822767b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752153813; x=1752758613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s6z7C65qwFjanp+WcXfAI65NKJWVNo2kQYZJAA47Yu0=;
 b=rXZJeJrUQZMcPx3EzTyY311SKgaoQCoEwEdkre0tc9m/joocT+PG4wUCmHGqZywF02
 QS/zCfmGC/LogiHyj6uh31ERVYalTEis/Ni05Edutb/Dcp6g7ScptQHQCo79QwBV3tpm
 kzv0qOzXA24I03qV2rj7nas50kMF+3I8YOBvYj/GUFxEaBXJcLVZQZsn7xqmbcMQcoAS
 vYIjbhaZ3ssZM8Ce0eerCGN7bjaan/3RAnMEL3y+pQrCWMvqte7oDDre5v48Y1E3gw1R
 xLwSZC+GyadG+6slV2KqHYELdfPORijhsnbmnwCs7gfe5DDkPowMn3FWSrnQGAWvFv/R
 /DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752153813; x=1752758613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s6z7C65qwFjanp+WcXfAI65NKJWVNo2kQYZJAA47Yu0=;
 b=qNE1BaeCn7DKLwLo/gfDlFWkBqKlVidrNiBEYNRVTwWiLI4i6vhG/psZUYr3lVKULg
 zGCvw0ti8mlIvwIQ2Xg5Zf4F5YdREbzHjGRADBmtpsMJ1L0DZg48FoNApqEBX6K/FfTX
 3wSjvy0VPbT/PSi6uRKqItPwV6X3274byWNRDYb9EBdTauH1xwqjAZPsOcka5RmcHle+
 QWqfguhT8KY0he7TD3pMYAH114OK/hgFTSf5xXtXeK/9it+VPhnI+Epp+o4O3w7X2qgD
 X//U4d4jzrtB9CHhSsjO8X74oAVutNAihRmAnM57G1fqgXi4usiuETjPyvkJiAj3OzKG
 crag==
X-Gm-Message-State: AOJu0YxCYVm6QWNlogGmufT8tm/20KDhgPLbd/5lh57FpqeX1jytkwyp
 /ywhwXqkkAPkMuWaWy/uDGqAGGYRMAh1cx3825yjJfZNXqR+/tExke/sSRPZ5rCioBMrvJPpfuS
 4j/54FrLgGVfoWmIRNEO7npbQPz0N0wnPGnjxb//iqQ==
X-Gm-Gg: ASbGncvh6ZVVf/XW6r0QiTg1qYvZYRZbXQhru8BeFNcmVUSUUfVLXbGmmPrr59jA45Z
 rlVqbVuhPY2inClUxFiRDsNtyqXU2fBGJJqV+dPYysOMVij3kxTIrXCEcs6ChLbxwyV1+hchbL1
 ptuuWRjn8dfst3cYWH6GNP7mRyOuvR7h8W/Oiwh34pXa05WZkZalkc5x0=
X-Google-Smtp-Source: AGHT+IGjBa6pXuwwD3/iY1qakHcfO7WMIzcg58EkAYO8CttaWHegMrIEvuHhQNkd26APhmb339H9NsKnKs9ksqYEI70=
X-Received: by 2002:a05:690c:6804:b0:709:1b68:9f5c with SMTP id
 00721157ae682-717c46885e3mr41339407b3.16.1752153812914; Thu, 10 Jul 2025
 06:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747223385.git.mst@redhat.com>
 <40ab4ed107757e1c5bdccc906e8a44cb4e2cb7a4.1747223385.git.mst@redhat.com>
In-Reply-To: <40ab4ed107757e1c5bdccc906e8a44cb4e2cb7a4.1747223385.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 14:23:21 +0100
X-Gm-Features: Ac12FXw71FkePhuYbsNUYBgJS-eKcaFDjTkvFvv_F7y1j2t_SHsmgrenvqSloFY
Message-ID: <CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com>
Subject: Re: [PULL 05/27] hw/cxl/cxl-mailbox-utils: Media operations Sanitize
 and Write Zeros commands CXL r3.2(8.2.10.9.5.3)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Vinayak Holikatti <vinayak.kh@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 14 May 2025 at 12:50, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Vinayak Holikatti <vinayak.kh@samsung.com>
>
> CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
> CXL devices supports media operations Sanitize and Write zero command.
>
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Message-Id: <20250305092501.191929-6-Jonathan.Cameron@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

> +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
> +                             size_t length)
> +{
> +    uint64_t vmr_size, pmr_size, dc_size;
> +
> +    if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
> +        (length % CXL_CACHE_LINE_SIZE)  ||
> +        (length <= 0)) {
> +        return -EINVAL;
> +    }
> +
> +    vmr_size = get_vmr_size(ct3d, NULL);
> +    pmr_size = get_pmr_size(ct3d, NULL);
> +    dc_size = get_dc_size(ct3d, NULL);
> +
> +    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {

Hi; Coverity flagged up a potential issue in this function (CID 1610093)
Partly it is a false positive (it thinks vmr_size etc can
be -1, but they won't I assume ever be memory regions of that
size), but it did make me notice that this address/length
check looks wrong. If the guest can pass us a (dpa_addr, length)
combination that overflows a 64-bit integer then we can
incorrectly pass this length test.

> +        return -EINVAL;
> +    }
> +
> +    if (dpa_addr > vmr_size + pmr_size) {
> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> +            return -ENODEV;
> +        }
> +    }
> +
> +    return 0;
> +}



> +static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            uint8_t fill_value,
> +                                            CXLCCI *cci)
> +{
> +    struct media_operations_sanitize {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +        struct dpa_range_list_entry dpa_range_list[];
> +    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
> +    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;

This looks dubious -- a packed struct presumably from the
guest, with a 32-bit value, that we are reading without
doing any handling of host endianness ?

thanks
-- PMM

