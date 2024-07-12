Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC04C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 00:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS4Ld-00047i-Je; Thu, 11 Jul 2024 20:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS4La-00046P-Nh
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 20:41:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS4LZ-0006BI-3R
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 20:41:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fb19ca5273so10219305ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 17:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720744871; x=1721349671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z7aruy/f607XYYCLbjSrVItFAzgsiG/fdkVXJDzRihk=;
 b=XpQfih3RR0tXlqLelaChpI9dm/4cet09sV6GatA0P6lLV4BAozMWrzRsAxQaKpDoTq
 QRxJcGNoicr7g/DjOKrYeKXutKl1VsBPDA3sIxENQI0AS+Nf4RDUW3+ph7x+a7HjHq6u
 HRpdlnvCEKt2saxzq7C74CRodC0nHvGfXH+0/g51wYR3AfhiiuYLhvDYrRTjBoTfufmd
 SkfP8gpD6ZjqvVuGfPPwSXTYuCzx+vt+/blCjf01tIFk7GLXRyZ/+UkAKooCDvaASECb
 zlpLc/BlU16rnmoy5K6lg5YZsjBKBaZlKqULC2seJKbdztweUVmuRxkPvw18wsl6Y0Nj
 GAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720744871; x=1721349671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7aruy/f607XYYCLbjSrVItFAzgsiG/fdkVXJDzRihk=;
 b=Yt0d918J7rz4GOGsIEMmTMcZIcsuubXKzmQHXIsGqppa/rC6XvkK1X3jdwRU8hoyOk
 rfB7z3iVDHMkCmDg451+UGfsCpU3tdko6FO3Rs5UIQffb+OVRcXmfyfuDMNFqRsu1xt0
 +T2Bzir+Kou8RXqKqF1/SmVA+MCffXinjVCow8C+jMRKIY6ACGilsBzlOhbMH2nVTloE
 z0/4k2Km8Ip4x+uRoaR8III+xk7t3f9InwgurAS+0v1S94UVdmZzPDKhySbgJBaa1SQj
 z2cUFAZw/Zs5AX6bsgW7FgxGBBWc/MfV5dAmHHvRhDX/IECW30S0tm+ib5oY8jwo8BsI
 X1xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMcI/Nki7P5RXYJkZgP9KQ97bPhU5jbQ9ZsOPS3ApnRulMN6lE3DLYrz4jTYE2wROROmdl2g8TQ1cEJy8Gr8v5b08NgKI=
X-Gm-Message-State: AOJu0YyP+eoHn2+n4PM8E0Y4fBBJT8ewRs8QV3l6vhe6Smu262SaYJsb
 GGgEOVeiW4lTFlkDyybaSgj3/8/EPScf84IluZqG+uoI337qlq8M3nmw1BgC+z8=
X-Google-Smtp-Source: AGHT+IFX1wXHclUxASaLSPWNRsbFBE/qpKrvqD30CZXmiUxCSLGS5M0TTbe2Bsg9tVaJipI7+1k0UQ==
X-Received: by 2002:a17:902:f54f:b0:1fb:7e03:42ce with SMTP id
 d9443c01a7336-1fbb6d3c8f4mr79930095ad.18.1720744871420; 
 Thu, 11 Jul 2024 17:41:11 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ab7d2dsm56080425ad.180.2024.07.11.17.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 17:41:10 -0700 (PDT)
Message-ID: <ea778555-9973-4234-a66b-0a4ca6b8828f@linaro.org>
Date: Thu, 11 Jul 2024 17:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] tests/tcg/x86_64: add test for plugin memory access
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-8-pierrick.bouvier@linaro.org>
 <94961afc-f229-4e0d-be62-9e1cdb886e28@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <94961afc-f229-4e0d-be62-9e1cdb886e28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/7/24 11:25, Richard Henderson wrote:
> On 7/6/24 12:13, Pierrick Bouvier wrote:
>> +++ b/tests/tcg/x86_64/test-plugin-mem-access.c
>> @@ -0,0 +1,89 @@
>> +#include <emmintrin.h>
>> +#include <pthread.h>
> 
> All new files should have license boilerplate and description.
> You can use spdx to limit to just a couple of lines.
> 

Added this.

> 
> r~
> 
> 

