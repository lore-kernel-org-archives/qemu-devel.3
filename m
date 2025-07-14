Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA9FC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQop-0003QT-H5; Mon, 14 Jul 2025 17:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPE2-0002tu-8w
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:52:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPDz-0003rw-V3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:52:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so19519455e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752522750; x=1753127550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/RcW7EIoBOytWEXfeYSUscLX9FhhdTE2iWNSY1t6fNE=;
 b=nMNu7aiymNOKwNVaRaeuM0UkqONSagTfZw/qwyt096uEI1YfESxQm+hJiR7MgF0ivH
 wv/3pf1NwPqpS/30CmrvDPpZWZv+BU/IEEjFiGSo4r/zJ1wj3O2sOdcN6iQSCn4Z16Ol
 9bi9bCJgHc7359rq7Gwc85CGv61+UVZyR7XOzPoGCLAwx/31P/02HvNb0IGKlTP83/2f
 4RgIq6QS8pLPkfdQRvTpNl07zfsV5GTd8K8S0TbTvRrXHs4w6T4PfOT89PxPr4Mb9Qmm
 aTdYUU/hzvzRxOi7mHimb415nxzdG3COt/OMyC2vMnHImOcqHZmo1nenuiGS1ai09yaQ
 b5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752522750; x=1753127550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/RcW7EIoBOytWEXfeYSUscLX9FhhdTE2iWNSY1t6fNE=;
 b=ZBKv67Oop38ghcF3NdXX6FeMoVkehJe22OxGW4hhCmMRBl/tnp7dyp+XJPDDpMZeqd
 Sg5ZC3a59KtXzbb8sjWYXw8IiZit69oQvOPn9ql5I//mm0hd8Oittb1s4SIRpkGZ39pI
 z9Fhs7iKEUm2BSMMc3c5CLNhdQoK2FKac7FdCYfQpESiI9e3fIw4lRzuw4b+fERR3xVC
 euTT67TWdLswWs9+42DowpN7uOJK3C27xa0xbFaouQdgKV4+ZnZkyFivaC5io1zuU/BL
 Hsry9FcmeG3hJuJWlcP48b/GeiWF5WPM3rgb0tUEVmtzFU6PGTQqjPhw/Lk+lJY7flUc
 85mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCFW9/e20YpdaCn9iUlkELEVR4Wu5T+7Lc/G1je/pLVdXWXR9Vom0nThPA0BQWeOZBhNwhsysU2qHx@nongnu.org
X-Gm-Message-State: AOJu0YwA+4DFQymNxw+FL6XKsja55VPapVh0bKpoAiJjliSSkbF1oI2F
 EIXiTdSAbtGk2BTdZz3bWgf2ev2d+lm78De5kUFrSUJDogENqJvguPVcbG4fQ75EHKSM6wx4BXD
 V/zAp
X-Gm-Gg: ASbGnctXCw63sAm2i+8tgzL/TG9To1YMe1GIa0TMNSz7IYEaGMVdK8ZJyQWUoQDww4T
 j+H/gcQ29jPplg3+q+pnxy2ulz67k7W1bx7VftmpOTc864ta6BorkDRgBSfSfOoZigEhzHLbSWn
 LczjBDxaxxhHDq5ESUPaJ5G6HNi87Sf/eOlQze+uVMn8+YPynUb8imByDyRmrTAzi6DMtyYmnIk
 3GcWXqj4ABdkHiNtURgiQ8bqq2dBDRpzHscx1s7RRM5AOfa9PbSgbglhVNJI/034B/2Rv55qe8w
 iAWH6Hp1Rt7c297qXRCPC9tSZUWitXeWVhk8yOqaRZyeWO6wn7+f3nYHXixNZ6qh11I9k0MpYIy
 YGcLshN2yGtyuPOBHCYYJGN1eiTivjUJEC/yp6mPI0mWhv3D4WzjQDDLYWSwTknumig==
X-Google-Smtp-Source: AGHT+IHiBnIX3XwYwoo5idnxheW5YrYzaDLngAlbTGtD7HEjNDk/8qqNs+g0B+e/AU/bfZRPPh9geA==
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id
 ffacd0b85a97d-3b5f18dc957mr10400880f8f.46.1752522749841; 
 Mon, 14 Jul 2025 12:52:29 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm13037652f8f.76.2025.07.14.12.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 12:52:29 -0700 (PDT)
Message-ID: <2b9a18a9-239d-40cc-bd65-225bad2706d3@linaro.org>
Date: Mon, 14 Jul 2025 21:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host-utils: Drop workaround for buggy Apple Clang
 __builtin_subcll()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20250714145033.1908788-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250714145033.1908788-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 14/7/25 16:50, Peter Maydell wrote:
> In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
> buggy versions of Apple Clang") we added a workaround for a bug in
> Apple Clang 14 where its __builtin_subcll() implementation was wrong.
> This bug was only present in Apple Clang 14, not in upstream clang,
> and is not present in Apple Clang versions 15 and newer.
> 
> Since commit 4e035201 we have required at least Apple Clang 15, so we
> no longer build with the buggy versions.  We can therefore drop the
> workaround. This is effectively a revert of b0438861efe.
> 
> This should not be backported to stable branches, which may still
> need to support Apple Clang 14.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3030
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/compiler.h   | 13 -------------
>   include/qemu/host-utils.h |  2 +-
>   2 files changed, 1 insertion(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


