Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CCC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vTK-0001Dg-Hv; Mon, 06 May 2024 06:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3vTA-0001CU-Rx
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:21:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3vT9-0007PO-9j
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:21:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34db6a299b2so1596442f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714990873; x=1715595673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zRWhy3FvEBWh75I4fZPH9hqvwRcqSer8jaFzZFu5XCA=;
 b=E0WTFAuOdsxBek511v8ysZayY07CNCTYDQ0NA+odxPcvYWPg4ioR2w+q++we7yv8ZD
 sHCAsax+vhsCG0SN2kGxkpqP/Q47LLKEZAFnfNa42m9ZGtrbFEedfXs9rzwTVLcxEuiy
 eh5xLKxcE9pKy3zlLiXbqOobWPv7PSGTFnwdrtSywbUm1SnTR8NDkzux+x0RHhGtmbVS
 BP+Pvuc24Mhcy7jlHwD8hWNFju5i2s3L+5Qb1pEoNTKaPF8ftFZ8BqAy/uPj4mrJhtV7
 kN77Hdzl/diKVBbEf5UQNse4R3pi1w++NLDExwmOpQo0KF56ixUv89rXhVLNFlcJXBLA
 nW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714990873; x=1715595673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zRWhy3FvEBWh75I4fZPH9hqvwRcqSer8jaFzZFu5XCA=;
 b=rcOP+MDpOg6Gc3H0xKLHgsEjk63/hMNgeePhvB7WCz4G/vA+pfJGOTQnX+ggyI1k2W
 reXT+BzzJhbOEAHRdll+CsxgY7cAn4Fgq7s5Xr3g7J//c0OTeErLUAwAPCYwa3vwKKgM
 BZXiTnM7YXw1OE9V4rpD7ngmh3k41NHFjbqCQEzJ/vF3V/autOGgOPqrAY4wp7l3ebW+
 6JVdiJfO2g4U8ytxbWFDbmVJV22v+9vjVrAwd0LKrBtac3de2jwLVKlO8baovklwQGYR
 B/WQY1L+1Ddt5P1mYlXFI3neouTT2xwFLD+3No6pBDBrZdK2/Y7kKQSg1X9SpkSMG21u
 iO9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDbNdK2bKJt5YuKr2wvZ0u0//2whNuIshEh8IuSAjRvkRwoLtiQCY9tE3XfVCpMpdECWKr2bpuT+ar5aF/BCzV6q2tPQo=
X-Gm-Message-State: AOJu0YwOQljqDx7N3TSNWXTgC9smXOUQU5u4o9Bwb+9+9+wSdOP82dL6
 GNO+WGtJ7htJlivYvUyQL0zKRbaUelb2MiAN9IeXhGZ0mxULobtAjyOtgm7Paow=
X-Google-Smtp-Source: AGHT+IGt5MWUOqpRv+5GL6b8+MuIpkcuA5UrQZ8tXaEGWG6Fd1RBPPz/jWQxP3k8yGeKShKeyH9v4A==
X-Received: by 2002:a5d:6449:0:b0:34c:97e7:af6c with SMTP id
 d9-20020a5d6449000000b0034c97e7af6cmr6958400wrw.59.1714990873099; 
 Mon, 06 May 2024 03:21:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adff4cc000000b0034dc2f96ed9sm10310991wrp.89.2024.05.06.03.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:21:12 -0700 (PDT)
Message-ID: <43dbec7b-1a84-4d7d-a151-65a348277961@linaro.org>
Date: Mon, 6 May 2024 12:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] xen: mapcache: Break out
 xen_invalidate_map_cache_single()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-10-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-10-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Break out xen_invalidate_map_cache_single().
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


