Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F6FC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgRN-0006Fc-Hq; Mon, 10 Mar 2025 12:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trgRJ-00068f-VK
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trgRH-0006UG-W7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741625833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NnQd6GXKdZCsxGCbhqxlgR8PSdZP8cTUAbiIYh/a6uE=;
 b=BBEQ6M1a2Gh1wSwSqnReJ4/jEhpuASLMDa7spEDok/yykhUDo8Rq3hMKtszKsCaRK5RGFo
 bAwnpIcigiXd8X2OYUdM+l+cV3J7gN3WN8y15vMx29j5QUGmoABaRrn0UQ4y4oR7wzlDLR
 YNZcAvZHuUMPIyQkqPvxKZLds2+/Rjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-1_vSo77vPYaFRXh0eMfVlQ-1; Mon, 10 Mar 2025 12:57:11 -0400
X-MC-Unique: 1_vSo77vPYaFRXh0eMfVlQ-1
X-Mimecast-MFC-AGG-ID: 1_vSo77vPYaFRXh0eMfVlQ_1741625830
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cebfa08ccso13495365e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741625830; x=1742230630;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnQd6GXKdZCsxGCbhqxlgR8PSdZP8cTUAbiIYh/a6uE=;
 b=b0gYbvCfcgf4m7Tyb13bb9E5zWVkgKHrApViqFhzN3Q+3Zuzm6rFlwT3Zgrb1uLogm
 NCJzKGMnVzBAxSbMu2DSgVgWUVyhA+yX5f4dlkwPWsV6C1rQeAbDAThqd8hcH3IMdy7u
 kfAxFlhPBax1yNng9Ea/rU7HxVVvpoT+Mdr4RxgCLKoEyDJxsT5o+P42sTaQUy+ox8MI
 cIVQaDrEiDuhWVvB7dSmYWlZUvKCVMLax6OkPOdan+L0QIZSE3fg9q6DwqQPCIDREDqt
 M759LNKMDRjSVIe6xBs/lbydDJPUoX4b0SrAyBPFaHhfxhHhHp3rHYrw+iN+BdbXYVCt
 p39w==
X-Gm-Message-State: AOJu0Yy1I3kZNX+uLQNtjHs1OBIfEDL4RJHu5mGQUc+NDKmVJRvgry9R
 8y9WeadLkqmlrR+Z521sey9/QmkMJ3BEeyQkDhDo001YbttGZdscywviox2cjjUXbv7gIhpUx5l
 AQkm66DeUeS3xi76E1gDCwvSX2ZIMHeX4uL3LN4RDfxVK42wMd5t3
X-Gm-Gg: ASbGncsGyO0pE6T5jgdihbBmz+xXxL3nr5nR+jARQDHtFNzscAhtW+L0P1E/p0OJFyR
 AnlBP6wnxTWNESovK4Nq2zZ3aaGHGkmWyRW6IOuv8/LKY6gpVOLwQCIWgEms7g9ipoPGt96kHwH
 PaNXaxDnt4slGaeCgd5u+X0GZTXbZVUJbnE9zJbliO4uzimiOMuUD6i3h7aBD9WX72o1Z/f18sR
 Esiyj7KWtSE0Z7nZVPdYccIKHKolK29xxRN973j4eihbMEdeaxqCkDaY97P3p7gW70ErX3Dbwny
 BclwKH68ociDxOhT2khaoeSglboeABGhqrLu18YrvHHMWow=
X-Received: by 2002:a05:600c:5129:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-43cf6898affmr37532655e9.20.1741625829941; 
 Mon, 10 Mar 2025 09:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0VoyRENnFGpdECPD03BAyc3yN21ELbFzOq7YAAhJqWkTmskQAtMb1mRzx8NeVYbtAwGj7ZQ==
X-Received: by 2002:a05:600c:5129:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-43cf6898affmr37532405e9.20.1741625829573; 
 Mon, 10 Mar 2025 09:57:09 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce5d2808dsm92667295e9.13.2025.03.10.09.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:57:09 -0700 (PDT)
Message-ID: <1cd5fa82-50db-418c-bd9e-ce6fda3c6ee4@redhat.com>
Date: Mon, 10 Mar 2025 17:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal for a QEMU video subsystem for cameras and webcams
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Milosevic <david.milosevic@9elements.com>
Cc: qemu-devel@nongnu.org,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 pizhenwei@bytedance.com
References: <CAFUY6-d5GZSrDzD0vUEF6P4YnstMjx=G3Q77iFGLt3eBUf5WUA@mail.gmail.com>
 <87senk7rro.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87senk7rro.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/03/2025 17.51, Alex Bennée wrote:
> David Milosevic <david.milosevic@9elements.com> writes:
> 
>> Dear QEMU Developers,
>>
>> I would like to propose the development of a video subsystem in QEMU, with the initial
>> implementation focusing on UVC video device emulation and support for multiple
>> backends, including V4L2, GStreamer, and libcamera.
>>
>> This work is already in progress at 9elements, and we would like to upstream it.
>>
>> == Motivation
>>
>> Currently, USB pass-through is the only way to make video devices available to guests, which
>>
>>      - excludes non-USB cameras (e.g., MIPI)
>>      - performs poorly with high-resolution cameras
>>      - does not work with USB 3.0 video devices (Issue #1613)
>>
>> == Proposal
>>
>> We aim to introduce a video subsystem in QEMU that allows for the implementation of various
>> video devices, similar to how QEMU handles audio. The first device implementation will be
>> UVC (USB Video Class) device emulation, with support for multiple backends. Future extensions
>> could include virtio-video or other PCI-based video devices.
> 
> Are you aware of virtio-media? It was an alternative proposal to
> virtio-video which effectively becomes an encapsulation of v4l to the
> guest.

... but USB video would also be nice, wouldn't it? That could enable guests 
to use webcams without needing additional virtio drivers for it, I think?

>> Supported backends:
>>
>>      - Video4Linux (V4L2)
>>      - GStreamer
>>      - libcamera
>>
>> == Example: V4L2 Backend
>>
>> Once implemented, a typical QEMU command line for using a V4L2 backend would look like this
>>
>>      ./build/qemu-system-x86_64 \
>>          -device qemu-xhci \
>>          -videodev v4l2,id=cam0,device=/dev/video0 \

Just a quick comment here: QEMU tries often to avoid to introduce new 
top-level command line switches nowadays. Would it be possible to use 
"-object" for this instead, like it is e.g. done with the memory backends or 
rng backends?

  Thomas


>>          -device usb-video,videodev=cam0
>>
>> This sets up a UVC emulated device in the guest, using /dev/video0 from the
>> host via the V4L2 backend.
>>
>> == Next Steps
>>
>> We welcome feedback on design considerations and integration approaches. Let us know
>> if there are existing discussions or preferred directions for this work.
>>
>> Best regards,
>>
>> David Milosevic
>> Firmware Developer
>> 9elements
> 


