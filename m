Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932CCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIUD-0008A6-Dw; Mon, 15 Apr 2024 05:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIU9-00086m-Iy
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:18:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIU7-00007I-NO
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:18:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41551500a7eso16117065e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713172722; x=1713777522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/sWnmp4FkUli99PNJKLFFyFsybZNiyLNtAWC/jLEZk=;
 b=xn7rv2O3aRm8HqmVXLYosChbVJqTd9Xi4FBtTN7LaKG5ohc6IGr0YyGwFefazZQRRt
 kitVhxoWlAdBp6uV871n1ChzI61tHoaty2YcLtyXJ7QLxSgw0FPxWeS/CtAcKHuSWqKE
 Nto/iB4bkhQ4JBTHinbNNZDHe0BKPJzW+aRmQ0fi0bXnKxaAW7Yw6uoIgex8JYdK/5zz
 /xa4UK4yEAuJGSRPTkDh5f7/fgt2HzglyabLutGZvyyNV6PKDZKsnHdOD97JHrzDfAo4
 MaSaHe12PFeimJyD2pxzR2z7GMOrNMLntQXUH/6TLm1IXfP6tKcAkf2WdReESFWCRYLt
 0spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713172722; x=1713777522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/sWnmp4FkUli99PNJKLFFyFsybZNiyLNtAWC/jLEZk=;
 b=N/X7WJCncNXXdk4UzrptXSXab+aAhMHGY1MAm1XeuVjxswo0ufYX3GHULTiDwWGtWR
 3jlpZhYP/fKID1Rs3bjxS1/NsgYItAIkxFAdxVZYvkQYtaeJwqTcqtwHWRcJEouhG0oy
 vSxzET0X2l5rN7554H+mHfSH8X7O/qnyF5PTxUxoY0rvVxIqr3WDDGkBZuYa0wuohi3U
 u+VQsPZVeppIxlzDAnnoMUuSfHwJMg6K9RTxp5qxVO3nGqO0Cilh0CbXe9a2Jgdfs7/m
 OH+UUIPEdxcO0XMXeFK02Jx9ZN0bMjoJUWmarw0ML7e4wIHEb8MwL+vrLfdsxFkg3TkN
 nuqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWLg9LQX3gJONFlHaCMwhWNt/AYdPgNZka5WKexv37IkbVrrY6uFoZRYLFIXGW0zr8TuV07Ig4YjvE0x4snwDaDq+/O34=
X-Gm-Message-State: AOJu0YwAVdz7l8UgX0htGqHHddKeK7JJuFota0SZQdx6R8pej5HMN9GJ
 mg6j1HWszc/VnIQeH7li2SllzrxRjar5ARXvwhe3+uU8Nd4K4O+Bk5E/2D73URQ=
X-Google-Smtp-Source: AGHT+IELmyk/yBC/FAlP9mj863wsc7Sa7CzueEr9eagDUeRVG96QiaNFHEWSmGv6gdyqYF+xP+9KsQ==
X-Received: by 2002:a05:600c:4591:b0:416:fdb2:fa75 with SMTP id
 r17-20020a05600c459100b00416fdb2fa75mr5901736wmo.9.1713172721893; 
 Mon, 15 Apr 2024 02:18:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 h5-20020adff4c5000000b003437a76565asm11530595wrp.25.2024.04.15.02.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:18:41 -0700 (PDT)
Message-ID: <3203dcc8-294c-439d-a38b-b71ba1dbfc5c@linaro.org>
Date: Mon, 15 Apr 2024 11:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408081230.1030078-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Zhenzhong,

On 8/4/24 10:12, Zhenzhong Duan wrote:
> Introduce HostIOMMUDevice as an abstraction of host IOMMU device.
> 
> get_host_iommu_info() is used to get host IOMMU info, different
> backends can have different implementations and result format.
> 
> Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
> for VFIO, and VDPA in the future.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS                        |  2 ++
>   include/sysemu/host_iommu_device.h | 19 +++++++++++++++++++
>   backends/host_iommu_device.c       | 19 +++++++++++++++++++
>   backends/Kconfig                   |  5 +++++
>   backends/meson.build               |  1 +
>   5 files changed, 46 insertions(+)
>   create mode 100644 include/sysemu/host_iommu_device.h
>   create mode 100644 backends/host_iommu_device.c


> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> new file mode 100644
> index 0000000000..22ccbe3a5d
> --- /dev/null
> +++ b/include/sysemu/host_iommu_device.h
> @@ -0,0 +1,19 @@
> +#ifndef HOST_IOMMU_DEVICE_H
> +#define HOST_IOMMU_DEVICE_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> +OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
> +
> +struct HostIOMMUDevice {
> +    Object parent;
> +};
> +
> +struct HostIOMMUDeviceClass {
> +    ObjectClass parent_class;
> +
> +    int (*get_host_iommu_info)(HostIOMMUDevice *hiod, void *data, uint32_t len,
> +                               Error **errp);

Please document this new method (in particular return value and @data).

Since @len is sizeof(data), can we use the size_t type?

Thanks,

Phil.

> +};
> +#endif


