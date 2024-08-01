Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C4DC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 23:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZfAu-0004i0-P5; Thu, 01 Aug 2024 19:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZfAs-0004gi-3y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 19:25:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZfAp-0003yJ-TB
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 19:25:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so19511705ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722554730; x=1723159530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kXM7W3/jhxd5wifpkZ1D9zZCgLojbR5Gopr8jAtYbAA=;
 b=bBYJFQ2cm1seYOHuu/ohHVRsTIQzS5cZwL+usgYMwHRErn+YPgw1hXokzUNtsdfKBi
 i4/yCGGl6+0y+7WvzLJQHuoT7Fr8TZtTgIc60YpdytHdbBNqR2n8hE4RZqTjOxnUPZMK
 LWTennS8O4TZ2lSnf6IwYAVwXhHYUir3mpD0ZCAXwiGZX2QzI3Cpc4Ipkj7Es232Rb54
 TB4UavjiPILQslqFZa8iENspc/jjSDHDWwMpTUYdnpZxUH67hrhDkm3Mz8QC6Pw9fPJY
 zk1r5j1jAIj6GTgwEVojVfUCCi6i0hraux60GArDKaLetbRG+DrwFnJhCbOv8Fx0KGtn
 jKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722554730; x=1723159530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kXM7W3/jhxd5wifpkZ1D9zZCgLojbR5Gopr8jAtYbAA=;
 b=AjLpVcDYf6wrAFZfWv6nPTuwJ9xijSqjSDXYSczIg6q9JPsFGfW1/zSP2dQtXs+O1I
 MsDy37mxN/CFUpM/rcU+RbXOcc4BSzQs85sYQbILpmiB336p/CbMmESBAzbzOO7mHN7Y
 U8my7n6EwGU5VpZZkSv8CRXosr+dUJ5ix2KvD6KXsKS+ACuLH497upzdUlOrR9YW6xrT
 YWMTNK+uhegvkEkm6QcQjfeSRpR+ojVeGRFvGCMuCuz8qbxjlg+j5GDuye3jymX03hx3
 GBgx8WqLIjuNF+A9u2G8+e++Yo/Arfj5+vsPFn51aO/T1LLudl+C/vI7CVmlVojhLZHj
 deGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgL6KJ+wUWKUEP0xNcWjl7h5VlJElFXOsnMzkwkzyc1avwAJa1+hOjpy69IgjyD2iDmXBaLEfUad5uWSst7bQhSnOgWBw=
X-Gm-Message-State: AOJu0YzHYVfMEagpmYhEXAHjrJD2JrCruX1kFhAQGVQmN0entf0lk36w
 6l5tUe0emT89C9CSbNjrmLRVaAnm6ex4NsUPJvomB2G6Egwt+7kR32NP4JZjvbY=
X-Google-Smtp-Source: AGHT+IHiO6t70Gsvaw2CFD+Zf507/IKl4bP4eimyd5SFH8iWClzMQJRmXW4Isd3D4znIAD0irrYZqg==
X-Received: by 2002:a17:903:98d:b0:1fd:6033:f94e with SMTP id
 d9443c01a7336-1ff57edfe1amr26271545ad.27.1722554729137; 
 Thu, 01 Aug 2024 16:25:29 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592981aesm4352875ad.265.2024.08.01.16.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 16:25:28 -0700 (PDT)
Message-ID: <b09d230e-de05-4cf5-84ba-75ded34d674e@linaro.org>
Date: Fri, 2 Aug 2024 09:25:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] docs: more conversions from txt to rst
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240801170131.3977807-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/2/24 03:01, Peter Maydell wrote:
> Peter Maydell (5):
>    docs/specs/rocker.txt: Convert to rST
>    docs/interop/nbd.txt: Convert to rST
>    docs/interop/parallels.txt: Convert to rST
>    docs/interop/prl-xml.txt: Convert to rST
>    docs/interop/prl-xml.rst: Fix minor grammar nits

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

