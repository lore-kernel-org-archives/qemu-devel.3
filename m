Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B12C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9iLI-0004cG-Jz; Wed, 22 May 2024 05:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9iLG-0004bt-3r
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9iLE-0006Hm-Hb
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716370379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFC+rGw9C6TjmmITW33E/J08sm2nDJ8T+NeZr6iC1Ac=;
 b=dLKhlnysTnC/nOXsvYIUw8t28EkbI99vrzWmeKUizDYFbGbwnvDG29KC7mtGIWCt1K5lum
 Q6WDx5pP1HkEBfmGvKw8ES0kRFFxeAeCgcG2uUeCyoq5AIdV/vdIE2hzi0xNmcjGZhUHFT
 QH8Te3w3SS9c1453UbuJAKCPc6JHOiw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-XKUhUVEPN2me0f6l36Y8xw-1; Wed, 22 May 2024 05:32:57 -0400
X-MC-Unique: XKUhUVEPN2me0f6l36Y8xw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-61bea0c36bbso269424437b3.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 02:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716370377; x=1716975177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFC+rGw9C6TjmmITW33E/J08sm2nDJ8T+NeZr6iC1Ac=;
 b=PN297T8cRjFU+qdPrxaLy8LI9/kK8td4GtwMVxZVCQXt7ixJpt/Ea+gfXQ09Ife5dA
 YgdipMjtfSWJNQCoT6DUizt6tPABGYlsENp4h6izX3tnv0CqAZdkVRXjNyMfIoDq2nHD
 FW0LFgAVLX8JsGZOx4XpSPb2a96CS+R0a98rhSrn6RWuhQA9Hvhg5yYxXEwoNZ85rxdq
 shMJ9QyM6TP2/z3XPtTZ0KdGNNsKcXEFyExYzVVpsi1afilAKOYp3fEefySbaCNMVDt2
 GOLCtYwLyx7Wkloq7cWVh1wdRcbIiZz6TfnNhXNLKzSYBphXA07SDG8PjcmEw/ASScvu
 jNQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeyJS6IGp2GF4Wpv5Y4wOWewtdS3US9XbbAhSOl1xU422pmilFONf3hO3sRI1gXYzQ5xaEOxWg4947tR7wxAw15VtXA1M=
X-Gm-Message-State: AOJu0YwmmyBYHP1tFr9N6UDI4ic9MFyv3h0wf7BPo/aMpmaZ5tW2DAHd
 1m/5HQ/fO3a1S+Ci0VlTlF6AhXcSRp0cnYVd7mJH+h//uNX4FL67PVMss4BIrRmwFwvRjOLZGGe
 ETn/gIJviH1wmJ8PCPDC1PSBLpVVw3Ny70M5tsal1ndBjYzboumBe
X-Received: by 2002:a81:a055:0:b0:61b:2b7:27d8 with SMTP id
 00721157ae682-627e46ecdc3mr14873777b3.23.1716370377226; 
 Wed, 22 May 2024 02:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjLSiW9X6vIZM1rX4e05yv4r8TuKgUhjEjZxPkBrN3GbtoUUkMTxY1lUiEi0LO6cdfABA6Wg==
X-Received: by 2002:a81:a055:0:b0:61b:2b7:27d8 with SMTP id
 00721157ae682-627e46ecdc3mr14873647b3.23.1716370376903; 
 Wed, 22 May 2024 02:32:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cddd9sm131890486d6.75.2024.05.22.02.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 02:32:56 -0700 (PDT)
Message-ID: <23b96ed4-21a5-4783-89f7-7bad38a5c4bf@redhat.com>
Date: Wed, 22 May 2024 11:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] VFIO: misc cleanups part2
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/22/24 06:39, Zhenzhong Duan wrote:
> Hi
> 
> This is the last round of cleanup series to change functions in hw/vfio/
> to return bool when the error is passed through errp parameter.
> 
> The first round is at
> https://lists.gnu.org/archive/html/qemu-devel/2024-05/msg01147.html
> 
> I see Cédric is also working on some migration stuff cleanup,
> so didn't touch migration.c, but all other files in hw/vfio/ are cleanup now.
> 
> Patch1 and patch20 are fix patch, all others are cleanup patches.
> 
> Test done on x86 platform:
> vfio device hotplug/unplug with different backend
> reboot
> 
> This series is rebased to https://github.com/legoater/qemu/tree/vfio-next

Patches 01-18 applied to vfio-next.

Thanks,

C.




