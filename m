Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABAEC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHd04-0000Sy-H0; Thu, 13 Jun 2024 01:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHd01-0000Sc-5Z
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:27:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHczz-0005gv-A9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:27:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4217136a74dso6416065e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718256465; x=1718861265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y+Ppn+o1km+Qt8HL7bf7KmBVxf3Eg+FMtpXRVaV5WFY=;
 b=aWQMS964VeKO/wCdW/Gj/tusi3YlDZgETm5vHbWmF4VA4BfHEhjDaXy5UXFbfZSDQ+
 C3x7FTQj8KA7+HrkxK8cFMYsXqk0baKaFSUmx2NEsvDlSjx7Nh/UUjBIG/IYWHNkmN1I
 Q8yccXw4XIu7ZtvabT5IkWody0bP1TBJyOs3T0qkZOm423+3fcrcgviCeq/f8ePIF6H9
 yhdBiXINGqhTCDI0YXkmoZdC3KQlvA6fWtblQOZkm7ike8oGGfgAzht/yJ6EAAVsGqnq
 QOH9dDaM0Dmar6gybo5z45Qz0uc4bWtBtcPnpQSh5oKwwNF9Yt8lspFZGNyAdxwf9GMg
 ePWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718256465; x=1718861265;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+Ppn+o1km+Qt8HL7bf7KmBVxf3Eg+FMtpXRVaV5WFY=;
 b=s0ritk7pZPx0nJE+CDezDNNwWTNUO7Kyb6ythwdl5rgYoyXxbbycUuB0gBoQQhzI0h
 jtykN2xPrtL8bWZfslfRff/9RoM1JPs43UC/M5dAVcyR4B7oaN2t2PQLvM3PTzke5x4v
 3JGMjIruboFjf4EJ51M+gjdTeuZAGnvU2lqV6fVfLkJai8WjRNysHYJQF5rVdL7AWkRT
 aKqDIwjGFeqfnaXa0csmmJgJObqBUwwUD5Qj34/oXzfvYG8MWy01zfnDA1usdPTu92jq
 RVqtnhMf6Iw3TUIPrTcJMaYHwbyGdeg+wcXrdhhUgfdYcg4jFtPUm0nsNBnoz9MxyGPa
 xX7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1rFs5NOlzfwN7rM6hza+TKbnhDdgvv+MDC9k5S2B4B2v8cBZ9aCj4b233n3EL+bl3MKcQ+CsN2xWLUCYCC2fqKm66ds0=
X-Gm-Message-State: AOJu0YyZBxo84polFlnCkqgqZjOWK4YLOA82vFN0cpLTUZq9essdbmJ2
 Tq3IejacdwpNhdMk+Ozb9vQNZ+7faX/mcuObmN06d6Edd12sRKCv5YZ9mAj6wxU=
X-Google-Smtp-Source: AGHT+IGjyJm4Wdse4tk3sFBTvSxjPcy4oObUqk3t7Rs0ZBV9zLFt8O3xVpgT/H8W1kMk0hUGYpbGSg==
X-Received: by 2002:a05:600c:348f:b0:421:a575:99c9 with SMTP id
 5b1f17b1804b1-422863b5c2dmr36255925e9.20.1718256465336; 
 Wed, 12 Jun 2024 22:27:45 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e7469sm48634155e9.46.2024.06.12.22.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 22:27:45 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:27:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v1] virtio-iommu: add error check before assert
User-Agent: meli 0.8.6
References: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
 <5cc8bab3-4edc-4657-882b-5e8291fba29d@linaro.org>
 <CAAjaMXZb+9h+eMOE67k-tGNRSObFqD5-_wUT1PaOHWSE86b2Aw@mail.gmail.com>
 <87sexiy1wy.fsf@draig.linaro.org>
In-Reply-To: <87sexiy1wy.fsf@draig.linaro.org>
Message-ID: <f0767.gh8rubg21h07@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Wed, 12 Jun 2024 11:56, Alex Bennée <alex.bennee@linaro.org> wrote:
>Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> On Tue, 11 Jun 2024 at 18:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> On 11/6/24 14:23, Manos Pitsidianakis wrote:
>>> > A fuzzer case discovered by Zheyu Ma causes an assert failure.
>>> >
>>> > Add a check before the assert, and respond with an error before moving
>>> > on to the next queue element.
>>> >
>>> > To reproduce the failure:
>>> >
>>> > cat << EOF | \
>>> > qemu-system-x86_64 \
>>> > -display none -machine accel=qtest -m 512M -machine q35 -nodefaults \
>>> > -device virtio-iommu -qtest stdio
>>> > outl 0xcf8 0x80000804
>>> > outw 0xcfc 0x06
>>> > outl 0xcf8 0x80000820
>>> > outl 0xcfc 0xe0004000
>>> > write 0x10000e 0x1 0x01
>>> > write 0xe0004020 0x4 0x00001000
>>> > write 0xe0004028 0x4 0x00101000
>>> > write 0xe000401c 0x1 0x01
>>> > write 0x106000 0x1 0x05
>>> > write 0x100001 0x1 0x60
>>> > write 0x100002 0x1 0x10
>>> > write 0x100009 0x1 0x04
>>> > write 0x10000c 0x1 0x01
>>> > write 0x100018 0x1 0x04
>>> > write 0x10001c 0x1 0x02
>>> > write 0x101003 0x1 0x01
>>> > write 0xe0007001 0x1 0x00
>>> > EOF
>>> >
>>> > Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
>>> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> > ---
>>> >   hw/virtio/virtio-iommu.c | 12 ++++++++++++
>>> >   1 file changed, 12 insertions(+)
>>> >
>>> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> > index 1326c6ec41..9b99def39f 100644
>>> > --- a/hw/virtio/virtio-iommu.c
>>> > +++ b/hw/virtio/virtio-iommu.c
>>> > @@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>> >   out:
>>> >           sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>>> >                             buf ? buf : &tail, output_size);
>>> > +        if (unlikely(sz != output_size)) {
>>>
>>> Is this a normal guest behavior? Should we log it as GUEST_ERROR?
>>
>> It's not, it'd be a virtio spec (implementation) mis-use by the guest.
>> the Internal device error (VIRTIO_IOMMU_S_DEVERR) would be logged by
>> the kernel; should we log it as well?
>
>Yes logging guest errors are useful when attempting to work out if
>guests are buggy or QEMU is in the future.

Thanks Philippe and Alex, will send a v2 with a log print.

