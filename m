Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678EAC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfrz-0003Ch-B5; Thu, 30 May 2024 09:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCfrw-0003Bk-KL
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:31:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCfru-0002Cx-WC
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:31:00 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4202ca70318so9073685e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075857; x=1717680657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JfS4yySerTFEASVa3xnzBxXSq9l7E03E5ymkL7bNaLk=;
 b=hDaX46LAmYT9yhD3gdv3VtxdljQF2ouwIRFDAJZC1asFEe44CaB1TdpacuL2W2D03z
 jadF5ycUbcS7CYYXxvQUGqnM+kXCD7xIxp8UppkFjow9AuF572frHKEVUrJqnGwlIqDt
 dP5CtWohOowZn8YJnPQgYLvLo1hXGvS/dc+P6D6FSqWylkxqlMDsUiQtr5XOQ+T3Z13e
 UYB0Wllgkab9eJ3sW/+92puIoxGM19VjBwE+LzNpEuU7o8beznuPbmWE1s3fcVY6wTu8
 wXsHm+CRiTxosfZLS3wX1euLolJQbfePqmkeoAHtUKuHfyBYI4gMVe5IPv87+b6124aR
 Xb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075857; x=1717680657;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfS4yySerTFEASVa3xnzBxXSq9l7E03E5ymkL7bNaLk=;
 b=t2fVaayPFJJiNJ+xrqFFYYm0LYKx1xgYnEDEdVr6P/9BYOY/aUC0g+vlZMJg2dbkR5
 MJu4utM8GzO7t22UmrSiKGZmWAgR1zO3SouOsN8JH8NlMURFcmnTfdVwvkfDSXJcO2Lp
 bWmF67O0mGVWdGadO1J+I3nuv9ZxKH38Q7WF0uvMIQ4KqSwzQwSqvd5DCNGrTeev/hLl
 aVOx+vIqcv0IlhMpbnm07/8mux7PFHNQzotgsScElKwX6udqR2Wd1rDq5iwHbbiXM9jM
 fJucLttGH/DRuPQzBJLPksyEuELy9xOZKtQTnlBLvACOXea+jlwawjRvDIRmFaKPT/GF
 6xMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXomow21d5ZPMjaC+xZ/Y3dwbdh86SJd/9IM4uUpP2oyNHf1lM6rV2DMkMaoPVwv6P+h7U9O+DRVlRWATYipIi9srbJIKE=
X-Gm-Message-State: AOJu0Yyx8qLD7oliqfKpzmmZrTPiGz2UtN824Iw8w1y0JZmftcaXIrmu
 dRIRaTxI2O6Ixnuf87r4TQIEBDrmMwOr3JI2MuBwycTWPPyyaKW6pU8cU1mrapA=
X-Google-Smtp-Source: AGHT+IEpBkiiK7XYBHgaD9u4HZCzbGwhpkUvRy56LP7mSl2oGBoAHUrnTYeFZ9sqY9jwtf56WNivwQ==
X-Received: by 2002:a05:600c:15cb:b0:421:21d2:abf5 with SMTP id
 5b1f17b1804b1-42127925c30mr26180745e9.31.1717075857215; 
 Thu, 30 May 2024 06:30:57 -0700 (PDT)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7db23sm17877598f8f.23.2024.05.30.06.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 06:30:56 -0700 (PDT)
Message-ID: <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
Date: Thu, 30 May 2024 15:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
To: Itaru Kitayama <itaru.kitayama@linux.dev>, qemu-devel@nongnu.org
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
Content-Language: en-US
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Cc'ing more developers

On 30/5/24 06:30, Itaru Kitayama wrote:
> Hi,
> 
> When I see a Realm VM creation fails with:
> 
> Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159:
> qemu-system-aarch64: RME: failed to configure SVE: Invalid argument
> test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 -M 'virt,acpi=off,gic-version=3' -cpu host -enable-kvm -smp 2 -m 512M -overcommit 'mem-lock=on' -M 'confidential-guest-support=rme0' -object 'rme-guest,id=rme0,measurement-algo=sha512,num-pmu-counters=6,sve-vector-length=256' -kernel Image -initrd rootfs.cpio -append 'earycon console=ttyAMA0 rdinit=/sbin/init' -nographic -net none
> 
> do I need to suspect first the VMM, QEMU, or the Image? The kernel is built with LLVM, does it matter?
> 
> Thanks,
> Itaru.


