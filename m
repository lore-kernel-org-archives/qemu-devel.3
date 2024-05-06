Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A65FC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44Uo-00005z-5G; Mon, 06 May 2024 15:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44Um-0008U1-VT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:59:33 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44Uk-0005cv-OI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:59:32 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-60585faa69fso1476680a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715025569; x=1715630369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JpwtX5jleJe9oSIGu9mhU7JzVc+37+eDFq6qiF9/f4A=;
 b=bap9g0n0moBPpF4xlMq3cvxolypZbBkpHtBwkjH4s8hxG7kfMjoDFYs20RrvU1q5oz
 lRJw3EGQDgjmupj6PaaZAWDGGIiUTSn3ahpwVwn3ri5j7ZLwgtv4QrF6pzDUQUeXIfBy
 kB4/iwBQu6shVOrrSFryawixsfctpc35ZnxcRkNJUvNEVcCyo3feZ3nOM4h/poFKIRB9
 EeeJhHy2sxdDna11bTyTmzuHoKYDpRAhs2ctW81BmWvr8yhr5HGP8IxO1miLQYG+iXHS
 Lqr8u8Yi9O9RG3R1GJnObGBiuaIVsZK1GA1/GaQWyK/0axMkLKh5GLbVzOBrjyYTjynN
 FBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715025569; x=1715630369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpwtX5jleJe9oSIGu9mhU7JzVc+37+eDFq6qiF9/f4A=;
 b=ER3H6DFdbpCvHB5Rxe4s+6s+/0kxeVa6jcwDWozWg7pVPQOJdC81jeJxNt4o6aLgqx
 WwG17HKs3ODzv617jq7gDjsM3XAMVZsw+Kg/4qe3DUXyIYgQAXM9ru5YZSwznjz6pNJI
 k65FYre0L/JKIjPZm50pdhVnwYTVLntrNPzsEcPOZdzB/5jxaiDEADHVCcjybn73DVD4
 l/0HAhAA3wN6JbRQ6IrB8o37a6Uw/oT6Syr7BOSXtdcy9lfYygbDAB9kz/+pEpYJV1Rd
 nNbp9ffDVhwanr4Gq/N/esW1NmH9SduGOYbC4k+k28z/ry6u/S92gZxA+8HJqY63jPdg
 A0sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6qu4JVs3Kqg6HoJftqjFJhm+Hbx2JhZi4V+Xjl+HlXYqigHvT2BkpjGhxJ/wCLTX/PRYkiqhNVkoAzp8rywPKvcRAfcY=
X-Gm-Message-State: AOJu0Yy6c/EJUnCEXNMJ0bLnHQrQXGg0ponaE9RsnrRRrf3y5lfflTQI
 MVosNe7jxRPAHsDM+Wrl1tIKnXY2M2JtuPgrYGyW/c9FXD12NwZNroE0N4ZR2OrkPRxj53x5OaB
 5
X-Google-Smtp-Source: AGHT+IEKgQzkd4MTU+F+y+ji+ZrNQQvFycnUbl/zFWr+GKkLgASEYEh/y97sGeF1N4vEtVJC2ywtiw==
X-Received: by 2002:a17:903:41cb:b0:1ec:25d3:7335 with SMTP id
 u11-20020a17090341cb00b001ec25d37335mr885736ple.26.1715025569175; 
 Mon, 06 May 2024 12:59:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm2155004plb.98.2024.05.06.12.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 12:59:28 -0700 (PDT)
Message-ID: <1f6d49fd-a142-4c82-a91e-e72c579d8211@linaro.org>
Date: Mon, 6 May 2024 12:59:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] qemu-sparc queue 20240506
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/6/24 04:44, Mark Cave-Ayland wrote:
> The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:
> 
>    Merge tag 'pull-axp-20240504' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-04 08:39:46 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git  tags/qemu-sparc-20240506
> 
> for you to fetch changes up to d6f898cf85c92389182d22f0bcc3a11d7194fc94:
> 
>    target/sparc: Split out do_ms16b (2024-05-05 21:02:48 +0100)
> 
> ----------------------------------------------------------------
> qemu-sparc queue
> - Default to modern virtio with iommu_platform enabled for sun4u
> - Fixes for various VIS instructions from Richard
> - CPU name updates from Thomas

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


