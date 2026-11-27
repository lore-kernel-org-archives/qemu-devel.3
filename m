Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED610606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=g8C5gSUq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwkU-00031P-DT; Fri, 27 Nov 2026 09:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1xWwkO-0002yN-3w
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:16:25 -0500
Received: from sender6-op-o11.zoho.com ([165.173.180.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1xWwkM-0007v8-2H
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1795788966; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HZUoxuVMF420hFssUO5EME5BKk+9Nuqy+t5Y+YlCfiOxIwnXcfiZOF+P6X+oSJxjmQKElu1k1+TkjDJd2Fi5Izp1Zx0F95oeUtgJS0hfNYgymayiipHAzC5A9IRvEfI6BiSiM/NqaR5TlCawcp6D3nehzdzfy+VrDWRstg7RG58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795788966;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=v6X1wInHC/W21ivwoJdm1kWmhPxIh0wDIFxIh/tVlgc=; 
 b=kVQ7OJXZXnPZRFh02atFjUgClogNUt+tHSE4lzG1TTabPpJ7+7XFgPjtMvWSkwtQR/O7V6u+7cgnPKITrEJlnThcHUIuX6zbFNcy5JZO66BK8doZm8uuiEyFhEbnH0Cr1wxbAlsZjVguorJkEOamLKV59dHPEG9d027jzYDwFgs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=g8C5gSUq6jcxxX3aRT/281APvX2b+4s2gDsAH+t/Av/CMOiNc3rE1q3ZMSmix1mkxXhmOCS/au09kN/rRffn80cPqIWAsCzUk3CR+528r/4MjLt/7uX6EgaUts8wUHzgGxfhLqXXw1EGseCYgbfCTUQQXBLlpuqYKEAeQ9nxwM8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=v6X1wInHC/W21ivwoJdm1kWmhPxIh0wDIFxIh/tVlgc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795788963202819.6288518416217;
 Fri, 27 Nov 2026 06:16:03 -0800 (PST)
Message-ID: <a91ca449-9ad0-43fd-a091-71c920c4ecdc@collabora.com>
Date: Fri, 27 Nov 2026 17:15:59 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 3/5] virtio-gpu: remove the artificial IOV mapping
 limit
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Ray.Huang@amd.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20261106082711.813336-1-honghuan@amd.com>
 <20261106082711.813336-4-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082711.813336-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=165.173.180.11;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender6-op-o11.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:27, Honglei Huang wrote:
> Userptr-backed blobs can require a very large number of
> virtio_gpu_mem_entry elements when their pages are not contiguous. The
> guest virtio-gpu frontend forwards that entry count and does not impose
> the 16384-entry cap previously enforced by
> virtio_gpu_create_mapping_iov().
> 
> Drop that QEMU-only limit so these larger userptr iovecs can be mapped.
> Keep the existing allocation, copy-size, and DMA mapping checks.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   hw/display/virtio-gpu.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5d43ffb9918..3df7e3507f4 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -990,13 +990,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>       size_t esize, s;
>       int e, v;
>   
> -    if (nr_entries > 16384) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: nr_entries is too big (%d > 16384)\n",
> -                      __func__, nr_entries);
> -        return -1;
> -    }
> -
>       esize = sizeof(*ents) * nr_entries;
>       ents = g_try_malloc(esize);
>       if (!ents && esize) {

The nr_entries needs to be validates, that it won't result in int 
overflows on 32bit arches.

-- 
Best regards,
Dmitry

