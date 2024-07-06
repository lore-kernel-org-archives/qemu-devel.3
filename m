Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F454C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 14:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ6fK-0007yd-De; Sat, 06 Jul 2024 10:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6fI-0007rS-NM
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6fH-0003fN-6X
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720277125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4tvMObqlL1U6xxTy8ydc44Gi7WeEEijdbo+Zb+UT1k=;
 b=bLb91WHaateEf2EzRHaDOgvbhmzjycIF9Kw2LDNpgXJDLk3T2tLdsjqsuaDTWgW09MAyXt
 53zeYROrMMhQuhmNgg5p/Mbw8je44VFVSFckNjfRqTuUita3vHVNKjBJkQ/5IlSKg742uo
 jAb0YjOzO2276NpNcNb32wCOeyO6RW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-BAaUBGp1NFSTe1i_aSBlNg-1; Sat, 06 Jul 2024 10:45:22 -0400
X-MC-Unique: BAaUBGp1NFSTe1i_aSBlNg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4265d010266so6108515e9.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 07:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720277121; x=1720881921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4tvMObqlL1U6xxTy8ydc44Gi7WeEEijdbo+Zb+UT1k=;
 b=orKVlByBXA98dNFGLnCxdYJ4uraa3VB5b6r85B/jfY32uUv1I6pE2aEIQ8hDgUzVW7
 AoSbszCsTeRHb/OAR2iywM3rVROSRYJtJn8lZzO4wV6DfeD1jQsMXrixVI2udtQ9jO/X
 hxU2TJvDfHSpp6c6ALFtSyXRyG3QBP/qP96H+aZZ16YBDzOkJEjyOnvh3uZCAdcxnV0J
 nJjuKCg9mmQ8chYHAUktsjg5eNdXvz28dAygYqV1xgm4w9rb9enUcVhymly+fum7dEly
 rgKhqjOhBL/KSKRrQgtSo4O46artsroczokV1WB0yEei/e3QG4P2UsZGfDOGI098bWA1
 29lg==
X-Gm-Message-State: AOJu0Yx2MtQBhZmhuq5/0hNjIoxv84TbDXXmaNmOW7WmEyETZGAAOpMe
 IHwSSTXR3pKWEdoGfK7wELx7SaH+vzlDJQnxme4KQdkw8mI54FUnfK+rR/PFdJs/qbp5MNCnTUM
 8cD3bHhKnu2XsRZfZcQ00CMxkSA2c6uMx5yJFCUqnAvg8nS0CK4WB
X-Received: by 2002:a05:600c:6d06:b0:425:1331:9b3e with SMTP id
 5b1f17b1804b1-4264a456fe9mr45483475e9.41.1720277121588; 
 Sat, 06 Jul 2024 07:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGn4NGNZQbK3dS4mTye+xsEVetS2g8N3AB1e6aqT3DuGxZB6RJSfwcBLiWfE2JP3UkOSaCAg==
X-Received: by 2002:a05:600c:6d06:b0:425:1331:9b3e with SMTP id
 5b1f17b1804b1-4264a456fe9mr45483355e9.41.1720277121206; 
 Sat, 06 Jul 2024 07:45:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2519a4sm97675175e9.35.2024.07.06.07.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 07:45:20 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:45:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
Message-ID: <20240706164519.06c53d77@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-9-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-9-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 7 Jun 2024 12:56:49 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
> and non-hotplug events like system power down event. Each of these can be
> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
> the CPU hotplug event.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>

suggest to squash this into the patch that introduces this bit [3/8]


> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> index 0bd3f9399f..3acd6fcd8b 100644
> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
>         0: Memory hotplug event
>         1: System power down event
>         2: NVDIMM hotplug event
> -    3-31: Reserved
> +       3: CPU hotplug event
> +    4-31: Reserved
>  
>  **write_access:**
>  

:


