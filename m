Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E3606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRM1ZKnn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKCm-00078h-Jm; Tue, 17 Nov 2026 09:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gsh517025@gmail.com>)
 id 1xTKCT-000775-6y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:30:29 -0500
Received: from mail-pj2-x06.google.com ([2607:f8b0:4864:39::6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gsh517025@gmail.com>)
 id 1xTKCQ-0000fA-PP
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:30:20 -0500
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3ad211ad92bso1199973a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794925816; x=1795530616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8TrxQ9y6PiuGeVg2mDLtK4G+dV0PTcHXkS/q9Wg3jcA=;
 b=YRM1ZKnni13yTHqMGyIDytihjh8gompH5EWgNDt48SpeAgwoS4PtdoF4qGpo6udPSH
 P7bnkjG4m45HzhUt2N7jeS8XXvHBBHjnGHTOKsJQlKfO3CYoVuO6xE9LTdukF9UeVQuk
 +c8/TBUsfDFicbmNcrhhKx2d50/YOrfTtkQQZtsq0H2KvurjRpnUNHqmJ021FpUmkv8m
 RDKz9tChYrleySGigP/EU3txYn4KhjZtYPOD22qoVTnqpnWZjXMS7TI7ygK0w4/1t6Tn
 D30GSY9+XOD2a6srq2dfYdIsEXYGw2CPtc104SInMdaqlcVYPzv7Rbt7Vf5q8dss5ttl
 dm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925816; x=1795530616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8TrxQ9y6PiuGeVg2mDLtK4G+dV0PTcHXkS/q9Wg3jcA=;
 b=fXCHutXLaH7VUOJpGEDOhn8xrUu8H0sLFpF3xDvszzFRGM4IZE2TBPiCXFdwXPXN6J
 GwcJi/UoTXqNUM38U4YYFSFg3+LalsZsAd8icNw+b1EXnbzR93Ssrd+DZN0v1Rk3cNCm
 n7b48HkLN9UO4Z7uhqMVRobnTSz5RR+1NW481b/rRa92rE3fJlPJ4OgMK0vXvupWdVZ3
 e231n1koSgA30b9ga5n7A898RmYGMzMcurvSFJqvNPujlSJOMGVSmUl5eXQF/9NmYaTY
 yVcefDA2BAkWUOF17+BYCC9t3r/76eCH/BMhZk/YHhtpL38NKtD9Bu+XVVEtc0LZbAQe
 sQBA==
X-Forwarded-Encrypted: i=1;
 AL+hErGCeV2IIjwFzz7KU43Q7kstzRkYCBvaun5L3LNX99vWAfjIfbjBsFU/tvEFkTDdqqZ/8zYJL+9egCxs@nongnu.org
X-Gm-Message-State: APuU4Z/tdiiEZTACKmXcF0w/T4kIByA4jI1QhqOZfbgxx5yxlA0yUApk
 YUY0V99lh1FCkYIJB8slq7YmYqM6OQy0PHLspIg6QNbEFaMFHp8dYOir
X-Gm-Gg: AZFdTZeQTCrKkRVQUwYKjDZrBY/UW4bu+jdfMY62wGkumS88tMQOnIudgb77tyZKvg6
 9iF8owucZ6+vXwnx8WpD4v6TypEIBUT/vUZdP6JZAngYv+cSnsxvHwowtn9oNHd82H+9iLdq/bO
 jPXYNf4bhtpId/02sc7BZOFD4yoStK8MRo3b+MNAvMkdvjVNOz9tODEEt3iYs1YxOtVYy7HbXRo
 8jUzZHY8+KY79sO12w34Oy0AGOzC/cnp3AGCNd6S8znyo/2plLmqfYJY2snZGbjcnQBuqZGoGXd
 auO86ZyFrGR8rPK8BJTavZ4b/lMLraybbU0zcmLzqTbcY0Hh18jSu60mL5Bq6K5evwz2+T72WHB
 UdbV1LrmkNbJAEw0cUn26X0+QUEopZmYHBu1FDLmvaC3R969WyFI02pWN6ynzwuR6TN37TKmXrq
 jAr/zOychX0WMSg3ey3jFEhBiDghzjTQ0hE+HADkkbeIGE28Vsx8JlztAnr7H7FrU48M3UfirkI
 JUiZGF/PiopXWbNvQuU1d8lRYRreLfW+9X8dEPdLerPCIk38InaPWxQdrTj20Iwk00c+4sBDm9t
 fwNhCFhoTPXPO4iEm96JU6+zPOsh2KQoFfnrtws=
X-Received: by 2002:a17:90a:d010:b0:3ac:1c76:61c3 with SMTP id
 98e67ed59e1d1-3b1b0a26a0emr13233581a91.27.1794925816345; 
 Tue, 17 Nov 2026 06:30:16 -0800 (PST)
Received: from localhost.localdomain ([114.252.97.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abebf1aesm4631394a91.16.2026.11.17.06.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:30:15 -0800 (PST)
From: Gong Shuai <gsh517025@gmail.com>
To: tanchi25@mails.ucas.ac.cn
Cc: alistair.francis@wdc.com, chao.liu@processmission.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 nutty.liu@hotmail.com, palmer@dabbelt.com,
 pierrick.bouvier@oss.qualcomm.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 gong.shuai@sanechips.com.cn
Subject: Re: [PATCH v2 0/3] hw/riscv: iommu: Support automatic PTE A/D updates
Date: Tue, 17 Nov 2026 22:30:09 +0800
Message-ID: <20261117143010.1286497-1-gsh517025@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113151251.30618-1-tanchi25@mails.ucas.ac.cn>
References: <20261113151251.30618-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::6;
 envelope-from=gsh517025@gmail.com; helo=mail-pj2-x06.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This series adds support for automatic updates of page-table accessed
> (A) and dirty (D) bits in the RISC-V IOMMU, as specified by the RISC-V
> IOMMU architecture. The feature is advertised through the AMO_HWAD
> capability and controlled by the SADE and GADE bits in device contexts.
> 
> The first two patches fix implicit G-stage page-table access handling
> and IOATC permission checks. The third patch implements atomic A/D bit
> updates using CAS, with page-table walk retries on concurrent
> modifications and G-stage permission checks for implicit writes during
> nested translation.
> 
> The implementation has been validated with QTests, Linux DMA tests under
> KVM and TCG, and concurrency tests covering CAS retries, PTE
> modifications, and G-stage mapping changes.
> 
> ---
> Changes in v2:
> - Set iotval2 to zero for S-stage page faults, as suggested by
>   Daniel Henrique Barboza.
> - Avoid duplicate implicit_read calculations, as suggested by Nutty Liu.
> - Document the new amo-hwad device property.
> 
> v1: https://lore.kernel.org/qemu-devel/20261108143934.129923-1-tanchi25@mails.ucas.ac.cn/
> 
> Tan Chi (3):
>   hw/riscv: iommu: Fix implicit G-stage page-table accesses
>   hw/riscv: iommu: Check permissions on IOATC hits
>   hw/riscv: iommu: Support automatic PTE A/D updates

Hi Tan Chi,

Thanks for your work.

I have tested this series on my nested IOMMU setup.

- Outer QEMU: this series on top of master, -M virt,...,iommu-sys=on,
              -global riscv-iommu.amo-hwad=on, emulated NVMe
- Inner QEMU: needs accel=on support for riscv-iommu-pci, and
              vfio-pci with iommufd
- Outer Linux host: needs hardware dirty tracking and nested IOMMU
              support

Test flow:

1. Boot host and guest, do NVMe I/O
2. Clear host S2 D bits and trigger GVMA inval in the inner QEMU monitor,
   use command: calc_dirty_rate -b 1
3. Back to guest shell and do another NVMe I/O

It completed without a guest hang or I/O error. With temporary local
debug prints I could see en_s=1/en_g=1 and implicit G-stage page-table
walks.

One host-side workaround is that on the host I need
echo never > /sys/kernel/mm/transparent_hugepage/enabled
to avoid an hang with THP; otherwise calc_dirty_rate -b can leave the
guest stuck.

This is only a limited positive test. A Linux guest is not suitable for
constructing negative cases so I would not claim full Tested-by coverage.

Thanks,
Shuai

> 
>  docs/specs/riscv-iommu.rst |   2 +
>  hw/riscv/riscv-iommu.c     | 254 +++++++++++++++++++++++++++++++++----
>  hw/riscv/riscv-iommu.h     |   1 +
>  3 files changed, 232 insertions(+), 25 deletions(-)
> 
> -- 
> 2.53.0
> 

