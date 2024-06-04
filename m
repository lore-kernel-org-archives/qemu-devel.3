Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE886C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 18:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZ05-0002nE-IT; Tue, 04 Jun 2024 14:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEZ04-0002mx-9p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEZ01-0005wB-LR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717526107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gNAlOrCN33wzhrrCFbiUysg83Y+7Maz6v4eyHFMOI70=;
 b=bf3HXhi+NlexD8uFP3tcXnE5+ixhXg8UCt1pUbU7vu2GohUlzhiAD1MrTgAylcD0OFlcgT
 a0zPfVlr519I6oIXQqYKhhLZ/LyMgUpaaobURaapEBjg0oZEJzuqHFXNaTkNR1kqg4dRGt
 tAmAmJpkFf21pn78uVKGcjqFFPoXXY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-XGXW6-GPOdCu9ClF4oiQLA-1; Tue, 04 Jun 2024 14:35:05 -0400
X-MC-Unique: XGXW6-GPOdCu9ClF4oiQLA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42120e033e2so31340465e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 11:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717526104; x=1718130904;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gNAlOrCN33wzhrrCFbiUysg83Y+7Maz6v4eyHFMOI70=;
 b=nPPA1qe23YmedUrXwYAuXWzqhwA/z5CKmfCSWBLulG3+h8p187VNRkqQH9Fa7Es4LK
 3Wukrb756rtkiREQn8Dy0ebNvc34r8f8pUZhzfWYdhAJe8S78NYQ5m9HqGfJ+xSoej03
 QXlfOM2Tw0Syk7iSM93voxYa/W9QoISiK9NCDI4udZhAVKTuJK4FvZ/ADXWGiTBvNxqD
 J+exRVgmWktMa0ylZemrHhr2spyUIm40RIscMtOqwqylfATvKxxcHTSAHOxbvgxp1gpA
 yXymr4FqPmnS61QiaSDKAAJ0FTRCzsizsVu479akoNRSLhVr0mGSY12fXozPJ7t8SzWC
 4pCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfx1DhxCsUOYGMlotIFtnO+KCSJUNKW/+WEnTglFv8OCflGEku8YrrWkAR2hDDAvWptd3wSnzcpW5rrT03ykDxlKReWEs=
X-Gm-Message-State: AOJu0YyWU9UKLCCDAebxY47xmujvoOKGJSjBlY0Jh2O7tuFfU3Fl/h3z
 3yVTcs9wcnHNwe9EyL2xN1CWGZpBd22X+mMFxp/BcwHLk+CCTwxbwNIfMeFi6JiGjSwUdZmxXg1
 2IU3QQ3IILdHVXIlx/IdttFMp3paITgCbHzUwyc2ZK4uYOHw5PicQ
X-Received: by 2002:a05:600c:a03:b0:421:1d8:add4 with SMTP id
 5b1f17b1804b1-4215634e602mr3195065e9.35.1717526104263; 
 Tue, 04 Jun 2024 11:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZPhJKH4KbLyG3SD7g42h5tHd4TaPuoT7tVnIz+eTewFzXWEUNTC3p6ARWcKNdiUxsr38mZA==
X-Received: by 2002:a05:600c:a03:b0:421:1d8:add4 with SMTP id
 5b1f17b1804b1-4215634e602mr3194895e9.35.1717526103844; 
 Tue, 04 Jun 2024 11:35:03 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-97.web.vodafone.de.
 [109.43.178.97]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42135511679sm134050905e9.36.2024.06.04.11.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 11:35:03 -0700 (PDT)
Message-ID: <7a6160da-e3fb-42a8-9173-55d3b2c7903d@redhat.com>
Date: Tue, 4 Jun 2024 20:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390x: Add Full Boot Order Support
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240529154311.734548-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> This patch set primarily adds support for the specification of multiple boot
> devices, allowing for the guest to automatically use an alternative device on
> a failed boot without needing to be reconfigured. It additionally provides the
> ability to define the loadparm attribute on a per-device bases, which allows
> boot devices to use different loadparm values if needed.
> 
> In brief, an IPLB is generated for each designated boot device (up to a maximum
> of 8) and stored in guest memory immediately before BIOS. If a device fails to
> boot, the next IPLB is retrieved and we jump back to the start of BIOS.
> 
> Devices can be specified using the standard qemu device tag "bootindex" as with
> other architectures. Lower number indices are tried first, with "bootindex=0"
> indicating the first device to try.
> 
> A subsequent Libvirt patch will be necessary to allow assignment of per-device
> loadparms in the guest XML
> 
> Jared Rossi (5):
>    Create include files for s390x IPL definitions
>    Add loadparm to CcwDevice
>    Build IPLB chain for multiple boot devices
>    Add boot device fallback infrastructure
>    Enable and document boot device fallback on panic
> 
>   docs/system/bootindex.rst         |   7 +-
>   docs/system/s390x/bootdevices.rst |   9 +-
>   hw/s390x/ccw-device.h             |   2 +
>   hw/s390x/ipl.h                    | 117 +-------------------
>   include/hw/s390x/ipl/qipl.h       | 128 ++++++++++++++++++++++
>   pc-bios/s390-ccw/bootmap.h        |   5 +
>   pc-bios/s390-ccw/iplb.h           | 108 +++++--------------
>   pc-bios/s390-ccw/s390-ccw.h       |   6 ++
>   hw/s390x/ccw-device.c             |  49 +++++++++
>   hw/s390x/ipl.c                    | 170 ++++++++++++++++++++++--------
>   hw/s390x/s390-virtio-ccw.c        |  18 +---
>   hw/s390x/sclp.c                   |   3 +-
>   pc-bios/s390-ccw/bootmap.c        |  41 ++++---
>   pc-bios/s390-ccw/main.c           |  25 +++--
>   pc-bios/s390-ccw/netmain.c        |   4 +
>   pc-bios/s390-ccw/Makefile         |   2 +-

  Hi Jared!

For v2, could you please add at least two tests: one that check booting from 
the second disk and one that checks booting from the last boot disk when the 
previous ones are invalid?

I could think of two easy ways for adding such tests, up to you what you prefer:

- Extend the tests/qtest/cdrom-test.c - see add_s390x_tests() there

- Add an avocado test - see "grep -l s390 tests/avocado/*.py" for examples.

  Thomas


