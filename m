Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B28BC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs8H-0006ar-UA; Wed, 21 May 2025 18:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs8G-0006ae-KR
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:41:52 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs86-0006KB-H1
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:41:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30e87549254so8044337a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867299; x=1748472099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7ZBvfSVmhyMJUndcKFaoLkCyALefN6HArdIaNHLZUg=;
 b=ObMZ8EIFk3s5xuWnf7Q9YFdndUVKQ+Xa3Xvg2v9dU/xuRLB4CSSkVxLQ0++g9dkmYK
 FPTG/QuKlFuEZfkoAH8REIouKG07i7YbeWkRx8563/uLi+ZlZ4+51200QkjYy5Qz5GVJ
 iOW6BrVbzx1op5tCxA/xUs5KvtP881uNmfvuWU0dj4UF443QZPLl+EiCMVwbRzGGfbk/
 nkGPC1yy5UATE1HjuPROizzul2B6PfoMEvFA/WYPEUAj69ICQj1aTMlqpJt3ldqeNk33
 xGseN1InlqyjAuBmr/jBUqx8BZC8P1NTafwPmFGENYo0YYPUaaFrC/QmvCvYO6l0pNRM
 GBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867299; x=1748472099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7ZBvfSVmhyMJUndcKFaoLkCyALefN6HArdIaNHLZUg=;
 b=cqgAkggBCL+UdfBuYVf8UuWKz4MZQbhpPZ0Sqpwgonb+7rnwezO5R/cNkUtARJmXwo
 MIpmT93yZ4AH1cBNu2DaqTDFiPfzto08nzAY2LpNrvZcarQrMHZ+GPpKbLd12yIe6Man
 p3y3wm1GbQiYEedqEuqQl23DC3gJR8erX+d2+td2wXy8XwuDPW51Fkwa8iPm4SbJQa+Z
 92U8fzbLI9brSo92mJDEArSxBIhbGOm0pNJvP45Cmi2NUjuvyGyi7sBG3tz9ClSfTt/1
 0yw277X7hqAl0ltgk86IsF5rb+dTKU2d7iatZfL235kFAJeA41UKbiIO8Y4Koi94kk+j
 g14A==
X-Gm-Message-State: AOJu0YzubXkTgCHHf9JcfPS2dJ+l2A7WQ3uxCQWJjVt5XI+ydPx7J1na
 PRR3SAXbsdjEwOnNDwB26yhaUNk8XriE5X3kHqkkWpsGaLPX6k7gV6KBT0S819bw2YV/SrSwwTk
 XyGkm
X-Gm-Gg: ASbGncu5AyTLVHKc3h9yy0j/ux/XhpzdKk97jR1VzZ4xuTv3Y4bjhprNHVkoRfgAch5
 ibUItWX0YHhH+fD2WzJsxqFzbdDL1PAlaEMOFr9K0uUTRK+EmKJCI0FnLdv35JSVSeQiCTJH1Ua
 ezVAKCBlhV/P2FpZcE2mcqI9UgGLaHxijFL4oBu3lKqxa0yMLXeUS5qZGLwQwoQ32hySQRfstFa
 P10h/kHblOePJwpufRWuClcKLcWCnU/e0iXLT9ylkdTk2SDHsr7NIAmhQCapeXp+tYz1jVVMDEE
 X3v9OUNR2DHwxBDtPdkM9YPqgVcecg4khERxtTZiCIGKi9fexkNTk6sdQ1ixAjaVNS/Xr+VozxE
 =
X-Google-Smtp-Source: AGHT+IGapjygG6HkiwQsRuxHaYqeG7CYfmtloLKtXLEmM4CNJoyjw67lxDKW2Ec8KDa3j4Wy+MV32w==
X-Received: by 2002:a17:902:e5d1:b0:224:8bf:6d81 with SMTP id
 d9443c01a7336-231d45ac8ffmr307247135ad.46.1747867299266; 
 Wed, 21 May 2025 15:41:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231e2118abbsm94490005ad.14.2025.05.21.15.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 15:41:38 -0700 (PDT)
Message-ID: <c05c0e6d-2073-4953-9a14-78297338071f@linaro.org>
Date: Wed, 21 May 2025 15:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] qapi: remove all TARGET_* conditionals from the
 schema
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 5/15/25 10:27 AM, Pierrick Bouvier wrote:
> This series exposes all qmp commands for any target unconditionally, allowing to
> compile QAPI generated code without any TARGET conditionals.
> 
> Based on original RFC from Daniel P. Berrangé:
> https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@redhat.com/
> 
> v2
> --
> 
> - rtc-reset-reinjection now returns an error if the command is not applicable
>    for current target (Markus & Daniel)
> 
> v1
> --
> 
> - remove file qapi/misc-target.json (Markus)
> - remove qapi/*-target.json from MAINTAINERS (Markus)
> - remove qapi_specific_outputs from qapi/meson.build (Markus)
> - update comment in rtc-reset-reinjection stub (Markus)
> - build QAPI generated code only once
>

v3 was posted here:
https://lore.kernel.org/qemu-devel/20250521223740.249720-1-pierrick.bouvier@linaro.org

