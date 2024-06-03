Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78405C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAAD-0007yW-7z; Mon, 03 Jun 2024 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEAAA-0007xW-Hs
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:03:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEAA6-00081M-MT
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:03:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so39485045e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430626; x=1718035426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTeMr4eeY8fj0ynHQMMfkBwzZ3Vx4ycWTYmNURe5QaY=;
 b=F9z7KYCok0JEZVnUMQPHQKapSyNs6p2nJgu5THfjkmZdZO8ElblvtpJ1OiroVGXKnP
 yXZeOTib/FhSedHc3yP8FWF2vNL2aSZQDCS4Jh/k2dfUZS01Nx+V7Z85SLDRepI7dulC
 K925g7S+u7gmPttUFtb7X0HueXaGEUqhSt+UL4+bVsr30VRh/BxrfKHoj0CWwLohGJN5
 9s/WGyXUvzScDP4kqsNiUTbhzKbhmOkpZvjVokrUwcogXRzOEGz6Isn/093g+F/p3glt
 YN32qEU6/2NcJMIEaRp1OhqdyW+O9IC5zWtoslKyIq8NX/EVGmDn7fjGwi6SZz+cCZjr
 1Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430626; x=1718035426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTeMr4eeY8fj0ynHQMMfkBwzZ3Vx4ycWTYmNURe5QaY=;
 b=eqCoZgcEaUAyZy9gw47kAG+CqWfnUdhmRKvxNBSakBS8TMg/Ww/kpaVz6FDHxHFHFS
 0UqY5a7QSaWi4B93QyfS0i5j3EKNd755Aj5enTPjt2pLz51UP3j4dAVWhIw+KVigpMbb
 85sTLVG8h8puOfzZ1hAYYbUx+MxYkRiJuhewMwV3N0InCUzCB/6cl6zNp99TTGaCe4n7
 L7uWZh0gcHWFReNN8appvipavugRg3sFgMQ2NpWfbvjFpS9h37rK3lIqvb5iaYn2+V6C
 tQhmt8r2rs/tJdq+W5P5FvQ1BXBvgxKVKPon5MYRtUtB5eobGzaQp3dVCT4lV0KPFnPI
 tE8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbC+iX2DUhEhn1gP8ClZAoWHRG6/ylBD5LmhhGG5ESBYiRe0EX2jiUiOqyhbtG/mPQLX5Y/FQMm1CsfQ20D5XrIL4Wd58=
X-Gm-Message-State: AOJu0YytlIvh0MgRxXZzXI2JmOEeM/XVPrEHGyuOm96e3Y+kmLUDWLTj
 ZVMMcCAtVzNnUOSAsT0/BslH+zZ6sj7eWZWMbXotbEvttPubpFnMcVMmwQ+9ZOhsepViz9qGiLZ
 7
X-Google-Smtp-Source: AGHT+IGk09ZwvE4PXglQyJK/Nb7H/KwG0mhB5xgC8OT+bIz/QVKrgAmIDtUBsuciT5R98Og6fWWdKA==
X-Received: by 2002:a05:600c:524d:b0:421:3a4a:478b with SMTP id
 5b1f17b1804b1-4213a4a4d72mr27993845e9.41.1717430626430; 
 Mon, 03 Jun 2024 09:03:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e56669a23sm4262184f8f.83.2024.06.03.09.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 09:03:46 -0700 (PDT)
Message-ID: <aed7e019-771a-4359-bc12-8156c3405d1c@linaro.org>
Date: Mon, 3 Jun 2024 18:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] xen: Support grant mappings
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 Anthony PERARD <anthony@xenproject.org>
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

+Anthony who wasn't Cc'ed.

On 29/5/24 16:07, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Hi,
> 
> Grant mappings are a mechanism in Xen for guests to grant each other
> permissions to map and share pages. These grants can be temporary
> so both map and unmaps must be respected. See here for more info:
> https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt
> 
> Currently, the primary use-case for grants in QEMU, is with VirtIO backends.
> Grant mappings will only work with models that use the address_space_map/unmap
> interfaces, any other access will fail with appropriate error messages.
> 
> In response to feedback we got on v3, later version switch approach
> from adding new MemoryRegion types and map/unmap hooks to instead reusing
> the existing xen_map_cache() hooks (with extensions). Almost all of the
> changes are now contained to the Xen modules.
> 
> This approach also refactors the mapcache to support multiple instances
> (one for existing foreign mappings and another for grant mappings).
> 
> I've only enabled grants for the ARM PVH machine since that is what
> I can currently test on.

Anthony, I don't have an easy way to test patches 7 and 8.

I can merge patches 1-6 to reduce burden on Edgar (Stefano
reviewed this series), but if you are busy I can send a PR
for it.

Regards,

Phil.

