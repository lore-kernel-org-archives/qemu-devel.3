Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021DDEA8536
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHrx-0002LV-7B; Sun, 08 Mar 2026 13:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzHro-0002Ij-Fj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:24:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzHrk-0003BR-Qh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:24:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so6524606f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772990662; x=1773595462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3OGYPOkfgpqp4Cgw5fadx5Wx3dKeyuSlfERdV0vVJ+g=;
 b=pbvG31rCfzVd6OXwqsf77X3aellMuSDlh8gekyzjNmFOyjII15p9be37fZwWoRprI4
 W3s2tZona1q+dWqBrsO4DXWjGOE0Hf43pkj8+KDr/8u8KuKtMsP0/wKV2iA7W6bpmWEf
 Ewab/YLhfJsGX2S/CwjunDtQCN8McAflR/xCDkquaj+dvZEL0rVE52PQ7LhL5TV+IfV4
 WE4YRBCJIthuPQAkyqWtFlmNjgk1jkr0375kcYxsz8xubT5r/PJBBoYV7WWa9l3ghZBN
 h+K3hlmTdUTs75V4ZyKhN185vNK4rdW+1wi0l3DNW5q2kzHEc9kofPJEXPWhxtCX6wjD
 1tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772990662; x=1773595462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3OGYPOkfgpqp4Cgw5fadx5Wx3dKeyuSlfERdV0vVJ+g=;
 b=fzDOOALw9vwzWobpZYQXzIxC0clckCujMEvz6pnOSjc9iFfD+1cRZUO6XEI/c2YqKM
 tOmYHSzqtuV1tc/Guo/XZQrzvVV/65SBSc2EcrQGga8VCkGHkvDpP08U92v3CYNprGbe
 Q9ngxg/bFxbyWzxJcIrT9KL34LOIvThtya8KITCfiAr3Ikykn8dYB52OfUKfC2T9+GZX
 IRHtppyjnJKAEsUtGHG6HfOfstf+mKB3mGV6EA1ZSENYucWVghgXlAfAdwr7lV7AMw1a
 v+Ag1OoZr/5utVg3qI/juP+a+zQaCzqz6v/IRChc3jiRGnYCSwn++J8nuaFNt79P9DkM
 w23g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjc86nMYy3rD/g7NqORgXL07dOi9om+ofDrPUZQHSy45JWzrdSnwk5GOqyzRhBKKYT312gJEnzhuMY@nongnu.org
X-Gm-Message-State: AOJu0YyX+HCGKRUGr0DaVKwwP+U+RA08ezPR5HzrL27RHlx/YTG1rI85
 d80u5vwUk+b2gnovfRfvWfcTu4j5kdkWKdIwx129rAl10edDrdlEX8CwJ2p1t7oTP0M=
X-Gm-Gg: ATEYQzx0jSlxuIp8JM64LtDox9JqHqkdZ3QRV3478/goGJVnxgykgTW20WjKpl5fmJL
 pGJFspZxATKrxUIkgTNXM8jQIegeznv6Pjkj1vDHAjn+GiUsbnZ0fE4o8Jvl20qqDfEKZQ+VPZG
 gtqkZrMdXXVjd4ap85o5MvOQxNKUnWXQOH+mKPSP1jwaEALHt4yxNb1kn6hVYFpvovWaEseQBET
 aX4qPXn242dsA4a8TV7uQlbY6dwTsyxNbIDsJ1960kJI57sHUEWT1TeEBNSYzlvhGEXBfLYr0Mx
 1nBtWkFT1hNnmncgQ4iazNCVTqeT9jhURkAS5wYrXW9nRBEG+xH2wQ0ksk37lUU15STypz/sx35
 Fv3bXYCVSkrJ1/9kt93rVzBma9o/upxTTGVU/MXr7IViAbYn6t5nJo9Wc3bwk3Q2s+Iy2RmG0Sb
 I7fBC9MLUajc33rECQcOL5Z6i+iHs6EPZLaD2NyMFtMVj+810UYn5ubcDBTqhNiyNQ5Q==
X-Received: by 2002:a5d:64e7:0:b0:439:ac16:bc8 with SMTP id
 ffacd0b85a97d-439da10e339mr14102640f8f.0.1772990661755; 
 Sun, 08 Mar 2026 10:24:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba66sm17368530f8f.20.2026.03.08.10.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 10:24:20 -0700 (PDT)
Message-ID: <28cde2b4-09aa-4c57-b530-bf80c3583e85@linaro.org>
Date: Sun, 8 Mar 2026 18:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] virtio: Add the virtio-msg transport
Content-Language: en-US
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, bill.mills@linaro.org,
 edgar.iglesias@amd.com, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260224155721.612314-1-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260224155721.612314-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc'ing Gustavo

On 24/2/26 16:57, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> This adds virtio-msg, a new virtio transport. Virtio-msg works by
> exchanging messages over a bus and doesn't rely on trapping and emulation
> making it a good fit for a number of applications such as AMP, real-time
> and safety applications.
> 
> Together with the new transport, this series adds a PCI device that
> implements an AMP setup much like it could look if two SoC's would
> use virtio-msg across a PCI link.
> 
> Current gaps and limitations:
> No support for SHM regions yet.
> Temporarily uses PCI Vendor Xilinx / Device 0x9039.
> 
> The virtio-msg draft spec:
> https://github.com/Linaro/virtio-msg-spec/
> 
> QEMU with these patches:
> https://github.com/edgarigl/qemu/tree/edgar/virtio-msg-rfc
> 
> Linux with virtio-msg support:
> https://github.com/edgarigl/linux/tree/edgari/virtio-msg-6.17
> 
> To try it, first build Linux with the following enabled:
> CONFIG_VIRTIO_MSG=y
> CONFIG_VIRTIO_MSG_AMP=y
> CONFIG_VIRTIO_MSG_AMP_PCI=y
> 
> Boot linux on QEMU with a virtio-msg-amp-pci device, in this example
> with a virtio-net device attached to it:
> 
>   -device virtio-msg-amp-pci
>   -device virtio-net-device,netdev=n0
>   -netdev user,id=n0
> 
> If you're running on a QEMU machine that has virtio-mmio enabled, e.g
> ARM virt, you'll need to specify the virtio-bus for the device, otherwise
> QEMU will connect it to virtio-mmio. For ARM virt machines:
> 
>   -device virtio-msg-amp-pci
>   -device virtio-net-device,netdev=n0,bus=/gpex-pcihost/pcie.0/virtio-msg-amp-pci/fifo0/virtio-msg/bus0/virtio-msg-dev
>   -netdev user,id=n0
> 
> Cheers,
> Edgar
> 
> ChangeLog:
> 
> v1 -> v2:
> * Clamp get_features block count.
> * Remove virtio notify_queue in favor of per queue vectors.
> * Enable NOTIFICATION_DATA.
> * Drop unpexpected responses rather than assert.
> * Fix msg handler bounds check.
> * Guard handlers against missing devices.
> * Respond to bus pings.
> * Add BUS_GET_DEVICES.
> * Fix use of uninitialized var in virtio_msg_reset_hold.
> * Fix EVENT_CONFIG message length.
> * amp-pci: Fix fifo offset computation.
> * amp-pci: Don't notify when dropping messages.
> * Document virtio_queue_get_rings.
> * Add virtio-msg-amp-pci.rst to index.rst.
> 
> Edgar E. Iglesias (4):
>    virtio: Add virtio_queue_get_rings
>    virtio: Add the virtio-msg transport
>    hw/misc: Add generic virtio-msg AMP PCI device
>    docs: Describe virtio-msg-amp-pci
> 
>   docs/system/devices/virtio/index.rst          |   1 +
>   .../devices/virtio/virtio-msg-amp-pci.rst     |  92 ++
>   hw/misc/Kconfig                               |   7 +
>   hw/misc/meson.build                           |   1 +
>   hw/misc/virtio-msg-amp-pci.c                  | 361 +++++++
>   hw/virtio/Kconfig                             |   4 +
>   hw/virtio/meson.build                         |   5 +
>   hw/virtio/virtio-msg-bus.c                    |  89 ++
>   hw/virtio/virtio-msg.c                        | 986 ++++++++++++++++++
>   hw/virtio/virtio.c                            |  16 +
>   include/hw/virtio/spsc_queue.h                | 213 ++++
>   include/hw/virtio/virtio-msg-bus.h            |  95 ++
>   include/hw/virtio/virtio-msg-prot.h           | 949 +++++++++++++++++
>   include/hw/virtio/virtio-msg.h                |  56 +
>   include/hw/virtio/virtio.h                    |  14 +
>   15 files changed, 2889 insertions(+)
>   create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst
>   create mode 100644 hw/misc/virtio-msg-amp-pci.c
>   create mode 100644 hw/virtio/virtio-msg-bus.c
>   create mode 100644 hw/virtio/virtio-msg.c
>   create mode 100644 include/hw/virtio/spsc_queue.h
>   create mode 100644 include/hw/virtio/virtio-msg-bus.h
>   create mode 100644 include/hw/virtio/virtio-msg-prot.h
>   create mode 100644 include/hw/virtio/virtio-msg.h
> 


