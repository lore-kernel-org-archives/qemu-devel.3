Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C437CCFA05
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 14:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFCSx-0002bZ-5M; Sat, 01 Nov 2025 10:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vFCSv-0002ae-Gi
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 10:20:25 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vFCSs-0004tp-6g
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 10:20:25 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-594259bc5f1so229908e87.2
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762006818; x=1762611618; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K9zp/U5Qb5Pam2E1qPmLEw9uZeK37F56N8y4Jvvc2mc=;
 b=f416JIr9nPNds2Bg42OgmTtGKGN/a22G/yyynXEX/IPZUHpU+B42WB0bFVXY2Vfy48
 W6x/swTcnGINz9F4M/FKPDOUYKHwJ6TxdOvAtsnSOYJv4c0CwxmFy4R0y5JVehnGGUxD
 4kyY4UaAdeCeHAlsNg9DWOivUFx104JUkfyXM+3a18kOqWBQz02KvzAfVF1ukriFmPl9
 6xnMAIFPoY23LoFRoC3vltTalpDswynjKIhl4dN22ZyNlPIZVZukIyqBrtl9XdpofX/z
 5mchmYjFI5nfTexFb2ZAc9SjOkowiRqOmV6dH1I9T+Lo45cnITnFtSmgtocxORJO8GB/
 p58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762006818; x=1762611618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9zp/U5Qb5Pam2E1qPmLEw9uZeK37F56N8y4Jvvc2mc=;
 b=oxKnPr3BCyk8iom40BQsZMJ9AjyprEKY124UP4Bnm0KbGuYxhawPgUvPlv1ghHDb2y
 SqRXySso8EP+74gi3qXsOukr1R1azys5+oQ0d5PsjEgmGBgTsbqHhX6XVp6HSOVVbxFU
 okws6nPOWL1fUtnEtvCoM2h5+on7+1dO7iBZPOk6HTyOGdeIDJ7eVRLoW3sBw6em4PIq
 CqLsy7kpqk9HNp7OirGQbIZZxQMc/FpnVQhFdhFzwv3K6cdwU/ZfenWMnaOPx6nQm+65
 njlQSBLTvITGGio36M1eNHApG5F+2sGuA0eTxiF23dQ8wlSWV8UsMOs1uBw/Yjj93DJp
 EQVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsQf/Z/3ezKAH6mUmUCnjfGHdFTZftSF2Ogz+gH5Cc+KHBhAQSD/m7rY98w7UvcmXKgMSYbXiTODaJ@nongnu.org
X-Gm-Message-State: AOJu0Yz1VwUu1sDYmVMJvuTak8+r3G5VnVGA6pE1MjGaTJ6d//8IbWLg
 o3yfxp0WDZ9E+c2haJlrgxjZ1lPqj3tRse8QL+K7C6yFBP1Wkold8D9xwU6uzlxcsSzKlCbTj60
 H6tC0bEsgfbBrCHPQVtNnz9vdXcJkcG3hmQ0ohuOMsQ==
X-Gm-Gg: ASbGncsjb7dLaMOUR/XCxVZXjVR1jAS1aqhVDc0J4gTd6K0xfnL5QEOxJQAvCONPPot
 aIPJJqD1NQW0qVIa/+iusYCbS9uOpv6PyH233e1XNvY4EYR8ZTRxfjWCh8ps7o4785EG2er3dnd
 JWtUqWDS+Za2FFPyKYFCW63+9MkmSMvskE8K9HZIZaFEI1VP52Yq5Q+ROLCRuhEAPDVxRt1J+SU
 o3RzrGswpZiiddSqvSkTW009TsLrslo+N+JqXk9GpzMru4FN4K+Mb53yTgeK0sS7ZK3sC8o26in
 Y8WGIg==
X-Google-Smtp-Source: AGHT+IHWvCHGbVSzhFiCjoqPpq8hGci3kps+8MblsGxKlECurt4gqLtGs5kLWlDl5dZWhPcP//udpWdxIEohI6mNhCI=
X-Received: by 2002:ac2:4e12:0:b0:592:fcad:4a11 with SMTP id
 2adb3069b0e04-5941d50cdcemr2641210e87.7.1762006818452; Sat, 01 Nov 2025
 07:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-20-skolothumtho@nvidia.com>
In-Reply-To: <20251031105005.24618-20-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 1 Nov 2025 22:20:05 +0800
X-Gm-Features: AWmQ_blFoW5ky7o3CKhmLVd0KWalRzH9RYdbqvefwV6SQl2F4QPzrmUXu4LKQu4
Message-ID: <CABQgh9ENUvSJ5UiPGDbdQ_VPm5PtdFVmEM_27Z9QEb4O29cKwQ@mail.gmail.com>
Subject: Re: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com, 
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, yi.l.liu@intel.com, 
 kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, Shameer

On Fri, 31 Oct 2025 at 18:54, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
> features are compatible with the host SMMUv3.
>
> Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
> Only the following fields can be used:
>
>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
>   - IDR1: SIDSIZE, SSIDSIZE
>   - IDR3: BBML, RIL
>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
>
> For now, the check is to make sure the features are in sync to enable
> basic accelerated SMMUv3 support.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 100 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index a2deda3c32..8b9f88dd8e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -28,6 +28,98 @@ MemoryRegion root;
>  MemoryRegion sysmem;
>  static AddressSpace *shared_as_sysmem;
>
> +static bool
> +smmuv3_accel_check_hw_compatible(SMMUv3State *s,
> +                                 struct iommu_hw_info_arm_smmuv3 *info,
> +                                 Error **errp)
> +{

> +    /* QEMU SMMUv3 supports architecture version 3.1 */
> +    if (info->aidr < s->aidr) {
> +        error_setg(errp, "Host SMMUv3 architecture version not compatible");
> +        return false;
> +    }

Why has this requirement?
We have SMMUv3 version 3.0 and info->aidr = 0.
and qemu fails to boot here.

Thanks

