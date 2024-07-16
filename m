Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiLn-0006aL-2j; Tue, 16 Jul 2024 09:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiLl-0006Pz-5T
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiLj-0005XV-E1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721136970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dAs6vX5R7gv6WXf30bGcHaQtI9bWGigmsRPGk5oOKU=;
 b=BrarXT15rzNx1TAkXeJUlfJgJfr9Z4UVO0fLI1Gnkp8V7gnCDt2JrlJ9jaa5E9/4tMtKVh
 R7uiOqRrHuN0vWVscqN4s/ej4IhyBCzHv/LF1tbpNZCr03xT2zO1uXp9vnljE+VfhY9ikJ
 6KiWUAqfwG4yV60d8HFL6G1T5BXKVyU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-frwgv-_tNyCQYscIF28WVg-1; Tue, 16 Jul 2024 09:36:07 -0400
X-MC-Unique: frwgv-_tNyCQYscIF28WVg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426679bc120so40278205e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136966; x=1721741766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0dAs6vX5R7gv6WXf30bGcHaQtI9bWGigmsRPGk5oOKU=;
 b=uDaMoTkkY88t4vp4l9fatwD6ghK3Ql1BdX+yBuUfS5P79gZSduHHXar7XQcv6aVIC9
 fLJ0tqldnR+ciCLLQC9nWi9ot6MDTBgELNU8HWV5Q4Q3mUpCXqpqw2OXPSA/c1/UzLtg
 q1feOSEhsTofuyvSYUomn1/snhC+eB0EOMweZoBGLK/BCE9ND1cXtP8Ct0V43hxOSzVB
 0FKPWRz2ZVVp8ssnyPCVL9WjACm7Y60zB7v/zSRiB5CG28fvAJG85GJ7Tz6xf7+SBem8
 d9Emzl1jNmiFRKfw0PNmECXBIwSiStaqQOMnr6rcHS28aqYLhjyJJm5KL+1/V2R/gM5u
 n0MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbHgU0+80uH/vu7t2l7OAxCem3EKwlTQegbNggQEHvD5/gcTkRQtBoMLISN6W/tlEotz+FHKPy2YarJVYIOAZpEkmeX98=
X-Gm-Message-State: AOJu0YyPRak7HKV8QsX/gtYmAG0XlzNw63tnER8JZ7FKRt9zIqwURh9c
 D4qTervLiDLYNswBNIuzwsTjzzg9j3OzOW+UxXrejE9PNzHT2d1rbRfliBCNuUsnIrJinAewfLb
 4dzprtepYmz5Lw6Yx2csl2LRK6Z+mXXplqg2B2fDzgNZNl/xMRspf
X-Received: by 2002:a05:600c:2218:b0:427:985b:178b with SMTP id
 5b1f17b1804b1-427ba690fc1mr14714825e9.16.1721136965851; 
 Tue, 16 Jul 2024 06:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmK7vMX7gqFAbgq2HJfv4srAS4p1jfcpCLvNcq6t+78miWp0rmDLJDCPivpZntk85N/0sylg==
X-Received: by 2002:a05:600c:2218:b0:427:985b:178b with SMTP id
 5b1f17b1804b1-427ba690fc1mr14714525e9.16.1721136965410; 
 Tue, 16 Jul 2024 06:36:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3f13sm9156345f8f.4.2024.07.16.06.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:36:04 -0700 (PDT)
Message-ID: <3a0a7c2c-b46e-4b85-834c-232a8f9e4996@redhat.com>
Date: Tue, 16 Jul 2024 15:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-4-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240716094619.1713905-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/16/24 11:45, Eric Auger wrote:
> We are currently missing the deallocation of the [host_]resv_regions
> in case of hot unplug. Also to make things more simple let's rule
> out the case where multiple HostIOMMUDevices would be aliased and
> attached to the same IOMMUDevice. This allows to remove the handling
> of conflicting Host reserved regions. Anyway this is not properly
> supported at guest kernel level. On hotunplug the reserved regions
> are reset to the ones set by virtio-iommu property.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


