Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE16C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9lF-0007m3-M0; Mon, 17 Jun 2024 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ9lD-0007lq-Qn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:38:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ9lB-0002iA-Uy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:38:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so33789605e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718620728; x=1719225528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CVVO/1598h8Z2p3HhSIIrqk5+1c5V6kWItLt96BvEy4=;
 b=qWZKAD7I6LZEUzOP7dXIFkhFvGgC61c0GLMgEAt36f1yPbS04yXzOVP13D4OJo9U1M
 m58xjEcBpOP0RHCp5KaDn5BRgTjMFuhdF2lk7fPSqCl5Uvs29uchdL3cb+72/WVX/um2
 Ui5mRCql4u9PpnEAl0f76xYrPl3EMjw3BxhDhHn40Fwh/hTbvFFEiZ54M3NmU/IDHpVm
 Y4zA4oAr/cI7pBhmEyUN/aLQxzCzG6L01+7AbtYZvWoHx0fmVD0eiJoVHfLYmLxiKjJp
 fQUdRwgMr1xZp+8xzdQQmsd4S1GomuGHoE8wQtmtn09ud32htUYruS7qlpeejUnvsYEr
 GhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718620728; x=1719225528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVVO/1598h8Z2p3HhSIIrqk5+1c5V6kWItLt96BvEy4=;
 b=Zrs7wkHiwiXIoivskJAiWs9mbocUOUuxXrby6rD+YihbY92kFsoT5vvgXzKhLhJJnq
 e9x5iEsH2/aUXFV0M8/kDgeCMuSdsO0BPv4txSgsLsloEkFdvmF0YQJvEoNssnuKQnih
 wJ/zoMptI+AYubsn+iE/3D9DQzDQ1cNAfSBZWoUtHT4lR/3qfd2+MyXCOpTUzUzt6ATA
 JLb2AtttnkaIEgwcT6Bs8UqKU1YQevZZyvjN8MLCPBBJr86bkn0atlzwhSl1KaNBVPLu
 Mgc1Liz4gzJrMr/JqLvMBXvYvpxol5wfZK2f/zq6471jgHi9IZfv8HTTNAQ6o7TNMUA5
 llLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhnMgvtZ1DM+NiLSNP1XGOlpBb7fuy9paPlm6UeuN1Xw1/c2YeIOHfu9JJaEjJaJFpgOHLKe96hmHEpYJl4o4fqFOJzrA=
X-Gm-Message-State: AOJu0Yy8ewJpiqEpW5WBURdvXg9W6+rUI65gfGxKnCiC2cAbGfTdIftd
 4BW2zfRIiReKjHRq8mOxW4jpnqdT8g1J44JWpnNEiSSS82fCQMykoaBUCf8I0I8=
X-Google-Smtp-Source: AGHT+IGg4cyYNk8vdYbIuLzBE45XuZL2/KD+cYXzXmS7VWZ8KglSI/Ew+x7cfDcJRVR/BkFu65UT2g==
X-Received: by 2002:a05:600c:5251:b0:421:c211:a57e with SMTP id
 5b1f17b1804b1-4230485a5c6mr74161415e9.35.1718620728091; 
 Mon, 17 Jun 2024 03:38:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33c38sm157023065e9.9.2024.06.17.03.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 03:38:47 -0700 (PDT)
Message-ID: <d68aeb35-3e31-48f1-81df-d85ed8d8381c@linaro.org>
Date: Mon, 17 Jun 2024 12:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-pci: Fix the use of an uninitialized irqfd.
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240617095529.115046-1-lulu@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240617095529.115046-1-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cindy,

On 17/6/24 11:55, Cindy Lu wrote:
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
> 
> The root cause is the function virtio_pci_set_guest_notifiers() was not called
> in the virtio_input device.So the vector_irqfd was not initialized
> 
> So the fix is to add the check for vector_irqfd.
> 
> This fix is verified in vyatta,MacOS,NixOS,fedora system.
> 
> The bt tree for this bug is:
> Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> 817	    if (irqfd->users == 0) {
> (gdb) thread apply all bt
> ...
> Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:893
> 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0/system/memory.c:497
> 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/system/memory.c:573
> 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0/system/memory.c:1528
> 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qemu-9.0.0/system/physmem.c:2713
> 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/system/physmem.c:2743
> 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/physmem.c:2894
> 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/physmem.c:2904
> 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
> 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-thread-posix.c:541
> 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> 
> Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> Cc: qemu-stable@nongnu.org
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   hw/virtio/virtio-pci.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index b1d02f4b3d..502aad28b2 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1442,7 +1442,9 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
>        * Otherwise just need to set the new vector on the device.
>        */
>       if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
> -        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> +        if (proxy->vector_irqfd) {

Shouldn't this go into called virtio_pci_get_notifier()?

> +            kvm_virtio_pci_vector_release_one(proxy, queue_no);

We ignore this function return value, is it safe/expected?

> +        }
>       }



