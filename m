Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C82C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApQ8-0005aY-7W; Fri, 02 May 2025 08:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uApQ1-0005a8-Dw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uApPz-0007l1-2m
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746188582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nMWHOnmlG4NZZ5NV1Onry3x+iwz9lEgkp11sFH67eik=;
 b=XzwkkC9E0Mh2Pcj2/iW1ZE+cHxPkbAM0BVkIWBN14ATGePDCEHgjTcWa2wGFgNh3OaUAIF
 8QGk2UyWbwS3OGOlytne515KxVmDUOJ5w1QSJLXyQ9xXs2C4Ci7J4hNt0ov3doTdk2xeYR
 QcG9zppy2y51k0/upuJn9IH+6a0IHOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-TruXIPhON12cJ319wS5Ghw-1; Fri, 02 May 2025 08:23:01 -0400
X-MC-Unique: TruXIPhON12cJ319wS5Ghw-1
X-Mimecast-MFC-AGG-ID: TruXIPhON12cJ319wS5Ghw_1746188580
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so846806f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746188580; x=1746793380;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nMWHOnmlG4NZZ5NV1Onry3x+iwz9lEgkp11sFH67eik=;
 b=bdjcnJLLbPqGWC7bj8hEzq+7OysNEYDNSLldndD5xjXWGp599o8FQYn4HwKtNwD1A5
 4ZEcdINRzolpmL/ZHBh5ytFEE9l1snslXAp0raA6l+0hb7YW+j+OT/nJBNLYCjT+s0GJ
 Mf0QNgUsNg94zzu7qre7zlDVDUqzuVYNjwoxAUQR8fP5c4r4VhTOyWyX4qkmROO/ADgS
 XyWXX+9KQXg1Ral5WO1N20GH6qXztEK+do1ZfXlZFjRM2ObBNARSTj4getwndBZSWRCk
 0Zd6wwHsDLMcC/yna50pXwgrc7Xn4ZCRTsuHkf1ttjwrBeuUQmDQCTSx1zLT6qDpGsn+
 Q3JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCr+Awi4wzk/+NNnQlE2EsF3t5DnLY+NbP5zKghaOFNwPREeivksH+c5pGOXrkorro/MsBCR/wtKTY@nongnu.org
X-Gm-Message-State: AOJu0YyBJpkf6DhuNoqihPxNa3OObO1DxwxD1vZYAay3vRT1TWhCtwBa
 LiadvvYebXoM5oHP6wumQpbpHlMEYq3qBxkOSHSpjfq+prUf+TMak90Ic93I1Hy+UZe8gIKORBO
 RB1IGY12l66IHULFl09lWE6dZVXzjJDmj5Urx1oqeIdHxo4LcheIk
X-Gm-Gg: ASbGnctl6lzIfJoSiApw2aB7ZoMrCK6qVXBktiMfEgwmw23U6BREKgvHxgNvMsnwJjz
 prkn80w9WuuGNo7DhTCUSrsM1eb0Jq6W5t5++SFNMXwC/CHJy+kdjMpq2D8dBmpP7RO9kdzcDB0
 82gH2He0lg9Q2H2FPBTlZoHnKRSuHCDctBH+E+3IVSUO5luZEynUTVbMOn4QTEQwdPg5gagKeDH
 ZyjE3Qpr9USqQgx3Ipqpco53b7DmmruoMzJGCnqe6HYWPi3J3GNvgNggNv+WGSjNEwCEqUm8TMO
 a6z5dEJlk5ripcg=
X-Received: by 2002:a05:6000:438a:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a094058b54mr4836346f8f.19.1746188579889; 
 Fri, 02 May 2025 05:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi49Gdq0YlXsw2+5R+5UupV/OXyNDabv9TTQlPDsNiJ0IIHMU3dEUkILf+B33Nh2JJsWk8FQ==
X-Received: by 2002:a05:6000:438a:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a094058b54mr4836327f8f.19.1746188579543; 
 Fri, 02 May 2025 05:22:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad784asm88312805e9.7.2025.05.02.05.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 05:22:59 -0700 (PDT)
Message-ID: <efc7ef30-002f-4fe7-84dd-1daeedbafaa5@redhat.com>
Date: Fri, 2 May 2025 14:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] rust: use MaybeUninit::zeroed() in const context
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-6-pbonzini@redhat.com>
 <svms9i.274a4or3m08g3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <svms9i.274a4or3m08g3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On 5/2/25 13:01, Manos Pitsidianakis wrote:
> On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> docs/devel/rust.rst              |   4 --
>> rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
>> rust/qemu-api/src/zeroable.rs    | 104 +++++--------------------------
>> 3 files changed, 18 insertions(+), 96 deletions(-)
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> BTW There's this TODO in qom.rs, ObjectImpl trait
> 
>>    /// `&mut T`.  TODO: add a bound of
>>    //[`Zeroable`](crate::zeroable::Zeroable)
>>    /// to T; this is more easily done once Zeroable does not require a manual
>>    /// implementation (Rust 1.75.0).
>>    const CLASS_INIT: fn(&mut Self::Class);

Yes, good point.  When I wrote the TODO, my idea here was to have some 
kind of

	#[derive(Zeroable)]

macro so that the compiler can "confirm" the safety of implementing 
Zeroable by hand.

However, most of the time the class will be just a C-defined class 
(DeviceClass or SysBusDeviceClass), and then it's not even possible to 
add the derive attribute to the declaration.  So adding the bound to 
ObjectType::Class is feasible now that one can just add

     unsafe impl Zeroable for bindings::ObjectClass {}
     unsafe impl Zeroable for bindings::DeviceClass {}
     unsafe impl Zeroable for bindings::SysBusDeviceClass {}
     unsafe impl Zeroable for bindings::ResettableClass {}

etc.; in fact it was already possible when Zhao added the impl_zeroed! 
macro in commit aaf3778baaa ("rust/zeroable: Implement Zeroable with 
const_zero macro", 2025-01-28).

Paolo


