Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EA4CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTAR-0004hC-QM; Fri, 22 Aug 2025 10:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upTAJ-0004cc-AH
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:54:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upTAF-0003w2-Jy
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:54:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd237so16527135e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874481; x=1756479281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWjZWTxNyA+qhiNOJ6EJkD+ucHOkrk8FYbDXp7TDA6Y=;
 b=Tk++fu5kfw0VvORqVIN9lBzTMZP6dkbKlv7ZVN4ltoLxLmUiy8m06P0ZfgxD2e5q3Q
 vJrWHsqKutZ2k4weyThy5a/l7R4gjMeWD/+Ayzd15MzRhhDHxYMf8xQ/nywjjrkQsWcd
 netlG+TV5b7YaSeU073/qRuFe9qY2LWcriXqEgFi2J7AaoRyV0SxnelDbAbcAyivIHao
 /Sx6uKdWnMz4btSxtu7VsIjDiJJg3Wpwan95emKA31QqIzlwA5VP8nJ325ZJYoYkfbAj
 jw/QcPWocKbcc49tj0oN2IA+Hd10il53v4CnQxmE1ilfBy7caIZVP0wn7l4AYJ/ANWlm
 smhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874481; x=1756479281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bWjZWTxNyA+qhiNOJ6EJkD+ucHOkrk8FYbDXp7TDA6Y=;
 b=vY+jAtVeQ+NJl9gcI90JORpXmmWSyJjErI0w7xMPRD9OzGMRmxKWZxMgANncp1cb+c
 sAkBy9gO78tJwFNchvBWUe751RBHcTBe05z0SE+k4cYqlTVbNSVkgTr/tJNSZNo98wjN
 G65qEX0Kuom2wnI82ZajMuG1kh3X1jZCQf8HYNYhazm16oF7UIu7tKDyxuKU+vaSGiTd
 fZJFF8UmrnO85cU85ZaLt8DgBsQKbU5b8KJnMhJZhaciNnQDUVEd22JSzQxfjk61xMMC
 120VgPcrOftUDHjtp17eJ00p/2zrqQKb5t2EPQAXDYjEdap6i8y5QDvXt/bBGIymj2CV
 2aGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFCfxq/rhKasbgCWexMmiHALcPA8QcMuEwO2PbsOfdWt2FMzDxI8HeZcSAbeG7Hnk+z/G6MrFGnb4W@nongnu.org
X-Gm-Message-State: AOJu0YwkLUyu1qJiirj6WAIdwrT80fUGoLqV3DSxB9I7L77CLqKMiLas
 cOHfRM9BpOjY3oD7lQ90YhWlPyEnbovOIU3949XvQ0aklhvEZi78B405CjbuIJSXQM8=
X-Gm-Gg: ASbGncvpCZl8kUgOI5yN1C8Vqc5H/IMUbhlHkJ3QhEpTdyLCT1KtOpQkH+2YfY+GmF0
 3c4IQagYDOXGrJLbrYvKPS5o4+Ue9hCnK9Qg9xaogwz0/EQo9SXfWhOaQboOauHD0/ci4rifVKh
 +NchbJn3PCAg9Tj3Nvx1Fj85lhyYuBf3pDV8oR46cucJVMKRSq8d8ki1r4JrjFL3YRZzO1Ip90P
 TspM6qGNLUrhUJzbl7kLDtXZwRw86LjbqG8U6647Wb8Jwm6abnnaqvZ7AsfoVmxYdKJJHWF2PxC
 GtCbUBFMjyzBEK2QHYjxWkK4roqCVpSlCQ3v5iyu/xtud2NWht1qXxfcoBlpDTzx2I2JYbHoMtB
 FRyPtN5LN/3EXVDXfFIed4W8Ov5gl4tpdJ6eHZXvI3Z2TfrBiUyGmGLG6ya6D1/nwxYBpUyo=
X-Google-Smtp-Source: AGHT+IFblZrW81weoUhrjY/ebuJgbGo7Wf2QuMxCpSxm3qC84LvqyfxwMBh+t+nrHI50/GH6GgvWmg==
X-Received: by 2002:a05:600c:1548:b0:456:fd4:5322 with SMTP id
 5b1f17b1804b1-45b5179e7f3mr28019135e9.11.1755874481332; 
 Fri, 22 Aug 2025 07:54:41 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c6317a6a72sm2508623f8f.11.2025.08.22.07.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:54:40 -0700 (PDT)
Message-ID: <c5f5c2f2-11a9-4904-9fe6-18984b3c4f80@linaro.org>
Date: Fri, 22 Aug 2025 16:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] single-binary: compile some top level files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 31/7/25 00:05, Pierrick Bouvier wrote:
> We still have some files left on top files that are compiled per target. Start
> with the ones included in this series.


> Pierrick Bouvier (3):
>    cpu-target: build compilation unit once for user/system
>    include/exec/target_page.h: move page-target.c to header
>    system/main.c: compile only once

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

