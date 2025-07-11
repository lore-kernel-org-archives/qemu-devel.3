Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D60C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua8Du-0002TB-1L; Fri, 11 Jul 2025 03:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua8DV-0002JA-OD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua8DP-0001OT-R7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752219036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aK8AERd/wRVSIHUVQaxfyjHDF+GmReUQAR+oK0rKwCM=;
 b=L5LI6FPlFjs27Ipfl4fQPph/POHeUQmOJcB3C4UMpelj/LeF17fhTt3CHAnOjugQxYqMsg
 zqJFZpZFIVBHXQJLOi2/uzkgOHSLftZEewry2EG9iRC36ESKja7nLFfnRCKgHw5chg7c1e
 mKMrwFVdw0DuWSMMLh8t/iBWMRUFoq0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-e328OT1HPbeSM-GZJo03Ww-1; Fri, 11 Jul 2025 03:30:35 -0400
X-MC-Unique: e328OT1HPbeSM-GZJo03Ww-1
X-Mimecast-MFC-AGG-ID: e328OT1HPbeSM-GZJo03Ww_1752219034
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so775888f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 00:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752219034; x=1752823834;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aK8AERd/wRVSIHUVQaxfyjHDF+GmReUQAR+oK0rKwCM=;
 b=k6f5XXF0wtvYxjAd6kRU9pm1FDGDLzbT44kaALM7cBmpAsmwmVOOTC7kcb/T06PurA
 lCOiIo8hD4TBFKhPb61vrLHu0uMMSHNetNCZ8WefKh9mdEaSx6guw1S6aMG+QVmlLr/O
 FSl0NAdx1dcFmNi+jhdSE4Ib56irGft9GqnzdwXtCtJOe+Z7WKH/OSx7eYvvsFD8/2k7
 JF/2TrSFRE+f6bVwAluyZlFtpcw8CZq293uyrqvi/0rfprt3WKsuOZ5w3tHPKsMpOmxM
 KMpRQPSKu5w91yHGR0X3q8StOFWuSnfbtrtcnG2ufepifr0fjivnG3xUimOR7Ypji0RZ
 pZGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdktRJU3fyTDcB9J9d9Qg68XJr1cZCB+ZKYTxHCS4gcjB+D0JWQV+kY5vPmIAEeBSkSSqpr1Pf+Y6L@nongnu.org
X-Gm-Message-State: AOJu0Yxbm651Brxs0F5YZs8F6zdjpearHHCdEjFXGd/Eo/WJ4yJl4aQZ
 GdVm1W1iVE8bwVLOytMwQJPRhCoQcvIbR6h2aCpzqYGMXzZpvQiP1bmTtMTxFmsz0VLQER5y/9x
 FQoBYFTgMkbONBsvAloIZSXLaSyLVQabk8vkh11wTv/zod3W9NP5PyTyq
X-Gm-Gg: ASbGncuyl5aYrsqzip/cF1wCPfw0z/fdP/O2vaBN3A3i7j6jMRNnf0KlgA5g6TTbBC6
 y06mfE89lN9ayhnl90QH5naSEq3V5jdSnhIhe7mB9/PG2TgkVGC/tFTP17aGfUBFE+1w2DCQhP3
 CIN7QkI8yHq1BHwsEopKHcrikf13gA17ViozrOOR1X2AehgpbQHlulUShTC3tohi8I6OyI0kG0m
 GSYyDHoyj0c/zLb5vj5WqK4zaEpumg2r98P5rSbcTlL+TZyp0dDlKfBLc6MBSk1zRKVysvnmqMk
 Wl+8GsG0CCXui5oNuzeURmPfRvf7+umd7lwtZOnoqIb4cYNDU1aOzxHv8OLhU0jOwP/dHx6U3Ey
 Eh+f9
X-Received: by 2002:adf:ffcb:0:b0:3a6:d7ec:c701 with SMTP id
 ffacd0b85a97d-3b5f18cec8cmr1809070f8f.30.1752219033861; 
 Fri, 11 Jul 2025 00:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEInosx1NUtmujKEENECzFwxwdRpMoseYFsMQQLipZ5MXP+akaIr5tSe+127bF3ZARQdnK3zQ==
X-Received: by 2002:adf:ffcb:0:b0:3a6:d7ec:c701 with SMTP id
 ffacd0b85a97d-3b5f18cec8cmr1809050f8f.30.1752219033401; 
 Fri, 11 Jul 2025 00:30:33 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd47543asm38915615e9.15.2025.07.11.00.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 00:30:33 -0700 (PDT)
Message-ID: <ce7ab3ed-3555-40e7-a9f4-31ec8a308f0d@redhat.com>
Date: Fri, 11 Jul 2025 09:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Add a test for the MAX78000 arm
 machine
To: Jackson Donaldson <jackson88044@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250711020338.586222-1-jcksn@duck.com>
 <20250711020338.586222-3-jcksn@duck.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250711020338.586222-3-jcksn@duck.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/07/2025 04.03, Jackson Donaldson wrote:
> Runs a binary from the max78000test repo used in
> developing the qemu implementation of the max78000
> to verify that the machine and implemented devices
> generally still work.
> 
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>   tests/functional/meson.build              |  1 +
>   tests/functional/test_arm_max78000fthr.py | 48 +++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
>   create mode 100755 tests/functional/test_arm_max78000fthr.py

Reviewed-by: Thomas Huth <thuth@redhat.com>


