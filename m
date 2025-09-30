Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A192CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ux5-0004j9-Rh; Tue, 30 Sep 2025 03:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Uwx-0004ih-VP
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:39:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Uwr-0002lf-WB
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:39:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so3168962f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759217932; x=1759822732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qE2E68kg55lkWKGNUPUbXEU5stTPqSQmthsm27d4faI=;
 b=QV7VR+IVZwyrwBCBqwWdb1hO9pWxk95sMiMDn61VwUYscWPXLEorqNxKvk8m+yNs41
 vDCByPOu6UV3T27ZqSJTcdyNRmLld/ebvFe1aQrOtdQXa3Vi50bIPehKkoPigDfq4ehv
 spSbheZKlJCKP6EVOOVNeEZVk3C4j1dLhE4rfOvxnfXk0LgZu1EzzvAZQ6XnRLYSf0dk
 ja+GojgsgKMaZKu7O1xnQvVdJUuU12JbpLpFWvnlrSxGUJboepemd99P6GA7QiEfO8qf
 i3cWu+diO2ijB/jb+5+eFQ3SGhWR7Jl0+kq5eqPFxdnIdWKsw9kPbUFr68V14Vwrro44
 pyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759217932; x=1759822732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qE2E68kg55lkWKGNUPUbXEU5stTPqSQmthsm27d4faI=;
 b=k2AIv7WE2Dw1AiKulDMJOFJDHneSPOc1iOMy0n5yIUQwT4btuG/DfDN3b++qoWdtbI
 ChgfMlg9JXjtIvrfYZ9JvpuSRubXFlZ0E3lltoP0NJB4mRKqvT2Z5UjrFwsJOTo/J8eo
 Ob0BoqEUhcCEr5uwM5ol/AHddv364nvcl4WsgV/nrF5zkHxCu3Szcg3eo3tJ93XAm237
 wz3rrwi6dkzs+1N15a+FNCbTeX716ei2pHjrHou9P9O4PR/MQSXAcSsB5dtV2TZuj7na
 nVHqEGM5v441REnun8E25c4tSrrp/AlEtUFG6i5CPU9duOpjvQ851XH/Mgnl5NbhBcCy
 NZIg==
X-Gm-Message-State: AOJu0Yyre5fMuVvhVCik7UcdCh5pWXABezgfqkSZ3sARa/yASG+4JdJD
 pemQfsw2tUHEs4RiAnkZ0TE00ltx9zJcT5GVwbiUmiA+qGvf1Ul6lPSrNQ9ivMgglo0v8KR/gi7
 IZrefaLm0lw==
X-Gm-Gg: ASbGncs6fcZDOS8C1fc4pDAPnnHyubK5zgBY3gMKwzXK881iZ2Fco/F+Z/Sf6EF7mxZ
 Vko+oFWArC5TGDvvIHjbiBrcUmmJU55JmwrJ65oScBJEq6yfEnrPIsjoXZLv1uPhin7cgPxDa51
 V0v23OFOlhlkDh+YVmj+prNQURZApdnCAWEJS4VkZrgt6NlcU6S6plYPz5wdKUdTrjFR2sx4PMZ
 Scb1r9AU5rQ0hTRNUurxZbU3BWqm82Ab9CrYXgim6t8YgYZamVZnDWWZG9iih1U6+GJS68QqQ0E
 E2WnLxs+nfH2PgjqqXJoJ7gTg23RThsNw6nGLnhODGeDlHFVAU+n9xHpwqZ9EH/APqiAQsOtKlE
 Nz2A2RFhM/aI1ulfzdYJNDXJ3F0MLPXx8mQOEoTWAkDoDswCrV5ssFC2y6O7dCEGGH0hRU6TscE
 NDkH/w54jBMJ3TLEm9da4i+EPd
X-Google-Smtp-Source: AGHT+IE+CAzuCcPF3rL8oHgsDWK0spr1fitX6ekcCdqYoQO8jnWYejdEAIaIwc3jMgWkxQsuV9mqBA==
X-Received: by 2002:a05:6000:2f87:b0:3e9:2fea:6795 with SMTP id
 ffacd0b85a97d-40e4b389223mr19891217f8f.53.1759217931688; 
 Tue, 30 Sep 2025 00:38:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602efdsm22464734f8f.34.2025.09.30.00.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 00:38:51 -0700 (PDT)
Message-ID: <b06323d4-96e8-41c2-b437-ea27b2952e7a@linaro.org>
Date: Tue, 30 Sep 2025 09:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20250930041326.6448-1-philmd@linaro.org>
 <20250930041326.6448-17-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250930041326.6448-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 30/9/25 06:13, Philippe Mathieu-Daudé wrote:
> Use VirtIODevice::dma_as address space to convert the legacy
> cpu_physical_memory_[un]map() calls to address_space_[un]map().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/vhost.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6557c58d12a..890d2bac585 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -27,6 +27,7 @@
>   #include "migration/blocker.h"
>   #include "migration/qemu-file-types.h"
>   #include "system/dma.h"
> +#include "system/memory.h"
>   #include "trace.h"
>   
>   /* enabled until disconnected backend stabilizes */
> @@ -455,7 +456,8 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
>                                 hwaddr *plen, bool is_write)
>   {
>       if (!vhost_dev_has_iommu(dev)) {
> -        return cpu_physical_memory_map(addr, plen, is_write);
> +        return address_space_map(vdev->dma_as, addr, plen, is_write,
> +                                 MEMTXATTRS_UNSPECIFIED);
>       } else {
>           return (void *)(uintptr_t)addr;
>       }
> @@ -466,7 +468,7 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>                                  hwaddr access_len)
>   {
>       if (!vhost_dev_has_iommu(dev)) {
> -        cpu_physical_memory_unmap(buffer, len, is_write, access_len);
> +        address_space_unmap(vdev->dma_as, buffer, len, is_write, access_len);
>       }
>   }
>   

Forgot to squash:

-- >8 --
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 890d2bac585..acd359bdb3f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -456,7 +456,7 @@ static void *vhost_memory_map(struct vhost_dev *dev, 
hwaddr addr,
                                hwaddr *plen, bool is_write)
  {
      if (!vhost_dev_has_iommu(dev)) {
-        return address_space_map(vdev->dma_as, addr, plen, is_write,
+        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
                                   MEMTXATTRS_UNSPECIFIED);
      } else {
          return (void *)(uintptr_t)addr;
(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? y
@@ -468,7 +468,8 @@ static void vhost_memory_unmap(struct vhost_dev 
*dev, void *buffer,
                                 hwaddr access_len)
  {
      if (!vhost_dev_has_iommu(dev)) {
-        address_space_unmap(vdev->dma_as, buffer, len, is_write, 
access_len);
+        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
+                            access_len);
      }
  }

---

