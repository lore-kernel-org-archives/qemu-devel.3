Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63808C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 23:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhHuE-0000c7-D4; Mon, 04 Mar 2024 18:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhHuB-0000b6-2m
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 18:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhHu9-0000hz-9m
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 18:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709595572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2wAQK/IWD+07r8iQ2sWomvQr6iC0KVSkeyxgsYKZFoQ=;
 b=TgYOfh+ceGvQrGYJW0pCEfCB4rt9EP5SdX17+XZx/GdbuMw8g7uastdRBDzAkfQ1GI61Dy
 tK7GFGeVfXzC1eOonRalOxM91mKhELHGV+rcpMRLPEfsPtDBI20HUwkETgYlx/neJ5HW1o
 sU9KQNFm5k93z/IiEKhv54NCBgzOBpk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-zpykGwSbPJWGpinx909R0Q-1; Mon, 04 Mar 2024 18:39:31 -0500
X-MC-Unique: zpykGwSbPJWGpinx909R0Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso684505e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 15:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595570; x=1710200370;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wAQK/IWD+07r8iQ2sWomvQr6iC0KVSkeyxgsYKZFoQ=;
 b=kM41iLqRX2RWNxwFG8CakRkT+fdF9pQ1QjEAKZ6NyYMPOHr/eL9CdmiNQvBrdh8j8Y
 DkHIVmtBXdGhHz8HzXgHqKK4Aghhm99blJ/xoKy0v7Di+3ZWzljZttl0/SM6xKrx83XH
 4xHRLbkcBkQRhWCSQlz4yu/hjNQoAWMwHeDClXk9LUm0QljOgyB/7olmNHqzPSUOamkt
 KB0ed1rPALyTX9SoHi0onGKcHQdDMZM67w6zqwZOcAubsv3YfD/qAZzQkDJ7en2wiXBu
 fjGUKhWjSe7b8Lf7mwYNDmxKszh7RXukXRYisn6eyDBCnIrzIdy7HW6WT1bWA+VmloGL
 NW3w==
X-Gm-Message-State: AOJu0YwhCOY75irMFIek8C+J3inrYK9oxOYoG5/OmFQOC1ooERt8Atf1
 w3BsAI4Ee2hrpAifv/KJOIAYjWJU5PDQdXTnEaqWx2jJDUD56pCx6DzMtgGnGyyk514czWU+3Ic
 2qCyG5Gn/QMbyrSpNGJBb1s4hIxPUQEb45ZTnIbQ6/rWfHcSfj5Bz
X-Received: by 2002:a05:6000:4c7:b0:33e:8fd:1173 with SMTP id
 h7-20020a05600004c700b0033e08fd1173mr8612164wri.60.1709595569938; 
 Mon, 04 Mar 2024 15:39:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7OproRb1U90V197v1ESVvV7A39c/dXtAJLhYhq1T0Tv4SkgUlHDgucUxKm6u4unAT6lbhWg==
X-Received: by 2002:a05:6000:4c7:b0:33e:8fd:1173 with SMTP id
 h7-20020a05600004c700b0033e08fd1173mr8612155wri.60.1709595569609; 
 Mon, 04 Mar 2024 15:39:29 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020adfb648000000b0033e0ed396bdsm13244118wre.106.2024.03.04.15.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 15:39:29 -0800 (PST)
Message-ID: <51e57a7c-c8a1-4a18-a08b-d2c8fd5b35b3@redhat.com>
Date: Tue, 5 Mar 2024 00:39:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does the vmovdqu works for passthrough device but crashes for
 emulated device with "illegal operand" error (in x86_64 QEMU,
 -accel = kvm) ?
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, Xu Liu <liuxu@meta.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <39E9DB13-5FA3-4D1A-A573-7D58BA83B35C@fb.com>
 <20240304145932.4e685a38.alex.williamson@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240304145932.4e685a38.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/4/24 22:59, Alex Williamson wrote:
> Since you're not seeing a KVM_EXIT_MMIO I'd guess this is more of a KVM
> issue than QEMU (Cc kvm list).  Possibly KVM doesn't emulate vmovdqu
> relative to an MMIO access, but honestly I'm not positive that AVX
> instructions are meant to work on MMIO space.  I'll let x86 KVM experts
> more familiar with specific opcode semantics weigh in on that.

Indeed, KVM's instruction emulator supports some SSE MOV instructions 
but not the corresponding AVX instructions.

Vector instructions however do work on MMIO space, and they are used 
occasionally especially in combination with write-combining memory.  SSE 
support was added to KVM because some operating systems used SSE 
instructions to read and write to VRAM.  However, so far we've never 
received any reports of OSes using AVX instructions on devices that QEMU 
can emulate (as opposed to, for example, GPU VRAM that is passed through).

Thanks,

Paolo

> Is your "program" just doing a memcpy() with an mmap() of the PCI BAR
> acquired through pci-sysfs or a userspace vfio-pci driver within the
> guest?
> 
> In QEMU 4a2e242bbb30 ("memory: Don't use memcpy for ram_device
> regions") we resolved an issue[1] where QEMU itself was doing a memcpy()
> to assigned device MMIO space resulting in breaking functionality of
> the device.  IIRC memcpy() was using an SSE instruction that didn't
> fault, but didn't work correctly relative to MMIO space either.
> 
> So I also wouldn't rule out that the program isn't inherently
> misbehaving by using memcpy() and thereby ignoring the nature of the
> device MMIO access semantics.  Thanks,
> 
> Alex
> 
> [1]https://bugs.launchpad.net/qemu/+bug/1384892
> 
> 
> 


