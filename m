Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C31C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW43S-0007rm-Jw; Mon, 22 Jul 2024 21:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW43R-0007lW-0a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:11:01 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW43P-00012F-Dx
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:11:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc52394c92so1903215ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721697058; x=1722301858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MBTeDaGc4dMe5APyzo+CnhQbmnC84mS6gTDqDcVaWc8=;
 b=JWn9eLZXEFhH9mfQoGez7wS9rcrXGRsXL/Qi0z/dHKzT2udgeMcGgeDJJRgWvFoZU9
 6eec3eVjSGY6rD9OPxQIYsRXcNhrdsrlEasHkbGoOZE7Znb18qRhlLm6QztL1m5F3KTB
 wY7eCJLqC47IK+K/u9QrP0j0AkEULFUTp6AQqyGPqifkzR5zB5QxsWVyUVZVQxn9gOkD
 xzD/ZGBElqIyEG94S1SFvzjEdfRnVOiHxndw4IEPlPt6l/MV3ZjrKg64aDNZpUNWNJoU
 rjuDRZ2XOmQNqtvecp7Vfvpvh1XCMUjLvm4YdvyKjUaq1ojYsVnrjk2Dbfo0mq6n6Hc3
 aZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721697058; x=1722301858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MBTeDaGc4dMe5APyzo+CnhQbmnC84mS6gTDqDcVaWc8=;
 b=CqOI/SsTG687Ry3gxk+2weOYGEgLislmRuf0DjTmsc1GEWCJbkYgfbnsZ0wuTUmTUW
 UoKOtrMMm1zJp8QsnvS35XX9/xAcMucjebac3kecxOWphWYLG5jPGQk7f8BHZZdmVDCw
 LaIX0uMBBPCs9MT5yKTw99CIg9qoUSf1qdI+SPAnX9gc4qd6PjBdTn3tHRPabFU06gAY
 yErk8d6k7ne1tIl1pSgfQMLxQ1d94Ks2CITV1Nm5QneKI325ioP75RjxJzh3ypU+ypha
 eAvXHiyv+Cih90ZE7L3mg4CYoWF1Peg/xXr/bOKt/Ety5Mn2UNxam0Nwrt7cIr3KAJS3
 4JRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3dnlfR5GcHpfsFBj/f86Zc1yf/zc9nbvWoWkpxddt027CfdvfXtv348xIm8VfhX3oZpsgTqqk/AJ+yu9a6g57A/wmuFQ=
X-Gm-Message-State: AOJu0YxotvHAY42hKJfQ6zlVy2rkVUqDylgW89kF5Ly9nhqK5J/to/g0
 bREDYNTTRF60PJR4B2FK9ZQScFsw0H53vyNsa+nPib4OyA9EIKIZFqceh87zOeE=
X-Google-Smtp-Source: AGHT+IFDLKKPE7nyHK1ofeow1OuJP8HfMRM7KK1Zf6ne/bOOice2FyOoEKuf6ky6GQrhHjxzBA2faA==
X-Received: by 2002:a17:902:e54c:b0:1fc:3daa:3a3 with SMTP id
 d9443c01a7336-1fdb5fb1cc5mr13110735ad.39.1721697057572; 
 Mon, 22 Jul 2024 18:10:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f29409esm61526145ad.101.2024.07.22.18.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 18:10:57 -0700 (PDT)
Message-ID: <11297acc-de3d-4e74-9e1c-5f08ed219269@linaro.org>
Date: Tue, 23 Jul 2024 11:10:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] bsd-user: Hard wire aarch64 to be 4k pages only
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-11-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722214313.89503-11-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/23/24 07:43, Warner Losh wrote:
> Only support 4k pages for aarch64 binaries. The variable page size stuff
> isn't working just yet, so put in this lessor-of-evils kludge until that
> is complete.

Hmm.  In what way is it not working?

What if we limit this to bsd-user/main.c instead?

   set_preferred_target_page_bits(TARGET_PAGE_BITS_MIN);


r~


