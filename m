Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02088E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTigo-00060C-0I; Fri, 03 Jan 2025 09:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTigb-0005yr-H5
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:30:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTigW-0002ty-SU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:29:58 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163dc5155fso168790105ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914595; x=1736519395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kYIPrQZKJqMAC9wUvijh5ry0bWoyMmWYZi56slLSlHw=;
 b=xYJYl+sSlNDjyMC+TId7toT0Q/OtSVMcShzUY7EIctArfsWvOBY5GE3bTCuXHra/zj
 kdcAk0aTDW/892KM1XW1LZoHCsruNFiJP6T4YUmXctNRqqiSVXiV807FTH+kn3Y9BxQR
 mkqJV8NTG+w0ry2kR2f6fZZt33S94RrIS7lQjNENlwlO95aEdz4QipNRsCwwOYAjsL8I
 zB2yGe5CuaoRE8mYWoX23a6xiooPxdxch0ek6lYuWerr/Na2QU36JRetpfZxCy1ZtnlL
 drwu1HCl1hz/obR1Xb7QYGgl+MiXOL4JlhVqaLwMUIzZ/9uqFRfpT/u9DT3WAELnjVFl
 WvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914595; x=1736519395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYIPrQZKJqMAC9wUvijh5ry0bWoyMmWYZi56slLSlHw=;
 b=vcIgipLwCbQQrMUvIl/WKre7CpFRhk6h5Az1GDNh5s1aMFsawUEQXRMTarKC6JMV/B
 ez9aleBnrtVgJUVtheKLbi97YJ9LTJXE+tIXST9l9QgMU/+do4H37B2wYXoaiLFBTTk2
 7FrXQHYIfCL7L6Z5XQepYkx+2173/SJWoiW68I1MxHhWbyFmS3aYWkSJmEJ8x+icdeOK
 Trgt1Hu0eVMSYo3LozKO6xsNs+mdwAQYaB1GH4NpA9Kzs2Ixr8CB+pmYqZw+rKLKrN3f
 q0Lv4+ZWFJG2NMf/eibkfrHlY2WERk4bRT6oVbDWtq9HRqhnLb6urqBQrKsQvxHidMFS
 I1wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOh7xASi4NspsGcmDqOdFzEIlDg9iZSB0QEA4xFDmHjV/jlOy4ODqmj1ZgCwmRRl3XE7kRofH6XLxn@nongnu.org
X-Gm-Message-State: AOJu0Yz3GqFFQRGBbbjO08bTTyksBzHG8tERKhsi/wqsDqucr3i1a5GH
 VKZ5i8X71h8rPcJkfnDSOz8mXc91zLtsB0eqxW+hmZUr7gJgYfmodKWxtkSPZ7w=
X-Gm-Gg: ASbGncsEoPYnWpynZ0Dpr+rTXj2qi+0oGcjp+n+r/rVRpFjmAcOmbyxXRV+ZAaGXdhJ
 QEWsD5aSSnVRFie4j7aTPobEJZDO9wwQBBerOjTDE1xbkMSpRdsRt/jWAKbsOBEr95Pp/alSykN
 uEWoW599YBQMwX1q1kj95DE6dJWAfEbQRAJs0mJaCJut8FTcI52X4d/DyXiNo0oD8I4Hsc4Xp4a
 HdEDvxkznuVvqaKEo+so8dMJGTBTYfQeRsI7R/ucB47BPZmmlY5sOpYKDSKGtX1rs2c0N4=
X-Google-Smtp-Source: AGHT+IGGxLAcy/4GFcdnDfPa2cxnyu4bIt8jmIta/F/+RzSHBJOSenffatpKbk2xAP7dBNLnsLIf1w==
X-Received: by 2002:a17:902:e546:b0:215:9894:5670 with SMTP id
 d9443c01a7336-219e6ea26b3mr589614985ad.16.1735914595447; 
 Fri, 03 Jan 2025 06:29:55 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca01989sm245831735ad.239.2025.01.03.06.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:29:55 -0800 (PST)
Message-ID: <18432183-1254-4f0e-b0db-dd8e9eb45817@linaro.org>
Date: Fri, 3 Jan 2025 06:29:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] qom: Add object_get_container()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> From: Peter Xu<peterx@redhat.com>
> 
> Add a helper to fetch a root container (under object_get_root()).  Sanity
> check on the type of the object.
> 
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
> Signed-off-by: Peter Xu<peterx@redhat.com>
> Message-ID:<20241121192202.4155849-12-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qom/object.h | 10 ++++++++++
>   qom/object.c         | 10 ++++++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

