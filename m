Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85D3C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 10:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um9B6-00043K-RK; Wed, 13 Aug 2025 06:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um9Ay-000427-8o
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um9Ao-0002hW-8R
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755082650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/A/QgvrztwOTUsO9Ag5wUMJa/QW0F0K/CETQ14E5Y4=;
 b=LsgPK54dS1fWTwPk80qVsY5WY8w3z0VWotH8Gc2M4oVGgUQG8ZAcxvb9PUpcauqgVNE7s1
 uKHPiZb281VSXVJyMkItZedLTk1a4aca/x8wHbMEQp73PbomWX2KX7TjBM0HIm51i6AXjl
 QDVCviKtozc7R0cQmV54sD5tyRCNLuc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-p6gErTwHM9Gb2DQKL7ZDxw-1; Wed, 13 Aug 2025 06:57:29 -0400
X-MC-Unique: p6gErTwHM9Gb2DQKL7ZDxw-1
X-Mimecast-MFC-AGG-ID: p6gErTwHM9Gb2DQKL7ZDxw_1755082648
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b8d5fc4f94so978853f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 03:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755082648; x=1755687448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T/A/QgvrztwOTUsO9Ag5wUMJa/QW0F0K/CETQ14E5Y4=;
 b=rw1SXf+r7z5k/9bhMC1o90G6sKJBxmHU7GQ9iBIfqL1j5AJLYyG+X5ExtiZVlKKand
 J3XHt9uEFhv0TofBt4RnWNwxyc425UXVwRZcr2UbtXDWCtaqPHH30k5pD5v3StYqvG1+
 CwRfgw+HZT7PVRBPc7zjWWXUiYB8Si7cUsS/7YwwAJH4ptfklqrE6pBA6jSUHzaxNG7i
 lkqmRM39a+1asV3dkvDukhVcXE7bkOuS4y4zaYHot260vcReuia6mYvUp7AdQ2uHWU4I
 cjgW3Tw7Ge4Rbv+mzRhFzEsHjRMxLfRz0zPsb1cnHG880vmtOblXjJP75behqv5YQrTi
 Z02g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPT719GrzJ2oLePmZJHBppYJJms1GT0yU0W7Orj3ha/SKpN3abGXBZfqeA6IhHO8MFzA8fuPW3O34r@nongnu.org
X-Gm-Message-State: AOJu0YwfLVDn5f9Vm9l4AP1KZSYZ9R60KgAYLXfodmInc3JAFEuJSP+Y
 c8mjFllEoqCaTfHJLRStBhw2zD93PjBnyn1Hup9OtumkeX8a2MVtJMekeNKny9RV/xVmXQrdZLx
 qqv7XvnbD5h4B+0M1ttjECBUreWZRLnLuWWxckzyZ5+52vNNQ5ZvF0ZISBCinf6MY
X-Gm-Gg: ASbGnctaRwHXrNW06UoXxvmrUOESqMS2a0aCZKaKC8vLB3t5UvGF3ypJ0Vmzn+BONMb
 RaUJSCs2Ez8XL1oeLWmYy688q8M/oX0zcsfc3+RLi/em1k127mHCVpUBzaF11X9o+aBPRMqbiYd
 kl0pNbAY/mLZgjttCiBbpQtQERYEBNb68B9ngk7/RLPPUq9lOZ4OniaNe7oJr/P+fz0KhKymhmV
 sz7X2s8EiOwSICZVV2x5/9VCY6zF2qKib+mx1kIme7e6VJGLq7kkBAZ3YKApsqIo5vTzdAioK5U
 P2RUW2oB55dhKDNsk9b+8HUpw9AKrs7/D3uGH1bYWg==
X-Received: by 2002:a05:600c:310d:b0:456:475b:7af6 with SMTP id
 5b1f17b1804b1-45a16596597mr21722315e9.7.1755082648170; 
 Wed, 13 Aug 2025 03:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1zL3lQmo6HLgIk6087r2TLb4G8fO8EgySxSMNYrDPkrL9ajXPsEtuBJ8Xp4Ds3+6vbalQeQ==
X-Received: by 2002:a05:600c:310d:b0:456:475b:7af6 with SMTP id
 5b1f17b1804b1-45a16596597mr21722115e9.7.1755082647768; 
 Wed, 13 Aug 2025 03:57:27 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530a8sm47134842f8f.38.2025.08.13.03.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 03:57:27 -0700 (PDT)
Message-ID: <2321eb08-2910-4bcd-9324-2ef291f90a28@redhat.com>
Date: Wed, 13 Aug 2025 12:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: bundle all offloads in a single struct
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>
References: <9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com>
 <bc3dbf6d-7d31-4210-8a00-60e59f161899@tls.msk.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bc3dbf6d-7d31-4210-8a00-60e59f161899@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 8/13/25 12:34 PM, Michael Tokarev wrote:
> On 13.08.2025 13:26, Paolo Abeni wrote:
> 
>> +typedef struct NetOffloads {
>> +    bool csum;
>> +    bool tso4;
>> +    bool tso6;
>> +    bool ecn;
>> +    bool ufo;
>> +    bool uso4;
>> +    bool uso6;
>> +} NetOffloads;
> 
> BTW, can't this be a bitmask (single integer) or a bitfield?

Yes, it could. It has been discussed here:

https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg02998.html

I prefer to avoid the (virtio-define-based) bitmask as personal preference.

> Dunno how well it'll work, but it feels like this construct:
> 
>     NetOffloads ol = {.csum = cso_state };
> 
> and similar should do a large(ish) memzero() which kind
> of defeats the purpose of an offload (for speed).

Note that this is the "control path" any minimal (if measurable at all):
overhead will not impact the actual data transfer.

Cheers,

Paolo


