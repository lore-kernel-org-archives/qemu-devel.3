Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA587C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 12:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIoRO-0003if-1E; Sat, 24 May 2025 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoRI-0003dE-8f
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:57:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoRG-0004M0-EI
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:57:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so5226335e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748091436; x=1748696236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fATkiHxnCgwwWf8Tj9469zyzQR2gluXIfOLqguTXpE=;
 b=yFQ/cpLOFW3qBoDD6R4ULafLsZk0YR8vTB2nZ8I7ASLoJC9bS0sE/u6H+2hMz2lFsF
 oz7kvY3RFlHDjjoMyDY/8uEskXS7+C+gRUHkfaD7vv8HYO5O64isdJB0YKyE04TqcPNa
 hvG14jdzPxauzGbYyeZ6whi5boKoBZ86iGeAPBcQ7wabDLuaMA0sLX+0JACJ2Bba4F+z
 V6U/KpUSRvC3AXzHb3eIvivEh6eYJ10q3njh6l8U3Q7J4lZxatqalSvc0vP92lvSBSyY
 ve6hVdj+EEyS34QJiRfMKMqtVhKqlk77P1eeZL2TVT4X90f3U8xOU5LcX0eUBiOcotsL
 WFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748091436; x=1748696236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4fATkiHxnCgwwWf8Tj9469zyzQR2gluXIfOLqguTXpE=;
 b=Ee37yxIvuR6Q6enGor3tZwDS6t4kZSeULqYLTos9ynfFIkowTYzpwaqaNsSkoZuTBn
 WWkskwbCsyNbniK58vkpR7rpWXrozxig7UM0J0cbJpZkUO1ZGy3uqKLWM6LNBK4LY6Bi
 5J1fSHf7H6/ut8HZGH2OqOCy6hHQ1FklPL3yJQxXW2zs1BEUWVU0JTuXbvOd+kfe6xN/
 dPw/BIw4X1xjnuHd5DLwDGOeKHL9dPTaP3z4PdYOtHV4bmNifkYctbOb1xzK3H1neEmT
 lkSkZfSYHWUG8MLXOH+spwwfQfyrmJUih++6dmmb6Smo7HVLTUa3qOD2ableAvMMWK5T
 NjuA==
X-Gm-Message-State: AOJu0YwulBEhNEsaiWHZ6qeT+cFtN6CffJ4FkMpRYmdDbknaMKn5EaPN
 gmP0f4RX0BBuwEGGLBhn+DGrawCTWrzzH00iwo2bPsNfA6SXHC8lDB7sI2SHI/ffJal/0IRtlIZ
 QfsQApUYuGQ==
X-Gm-Gg: ASbGncv9nghODOQATF7HLovp/jt4wiLqukCfp/nNJ/msZHXhpUi4NNWsYolbUpV2oRf
 tLuWTpSP9rhukDQpKqxUS9rQfDVn67nFPFPcm7hG/X+XDOmqqMDEWzJsM6cCRwa3bjjlM1FMYW4
 BgPjiUWe9tuHqXePoPaNbSD3PiUUUVFN2vhX01IWBzGatBFcbsE51YoTG3ygXzalMfapp2OFGhJ
 zTx4a+bCbqQdn/V9T1t/7risA6VzVhbJNT3YdyP/0UGBjER1sQdGG8CIBn26Vx2qvZ4c6ifUbuc
 ROjyhj7YJ+Eb0b+iKD6fHFl6G2+xMimzQOF0O5GJ5CypLo/eXfLWA+t9+iJ3YgKTaQzeat1v1zU
 c
X-Google-Smtp-Source: AGHT+IFKmpuYdtbWAJnE54Crt+9fM5H5VoDZQo8DHQG/HQ/Y0R86olpr2Mcn6PLntewmjXpAkMopUg==
X-Received: by 2002:a05:600c:6303:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-44c7c185313mr27418535e9.14.1748091436304; 
 Sat, 24 May 2025 05:57:16 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d25b8sm183341375e9.17.2025.05.24.05.57.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 05:57:15 -0700 (PDT)
Message-ID: <166b7801-e230-43be-8bd8-3a08847c6d19@linaro.org>
Date: Sat, 24 May 2025 13:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] docs: Deprecate the qemu-system-microblazeel binary
To: qemu-devel@nongnu.org
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-5-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250515132019.569365-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/15/25 14:20, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The (former big-endian only) binary qemu-system-microblaze can
> handle both endiannesses nowadays, so we don't need the separate
> qemu-system-microblazeel binary for little endian anymore. Let's
> deprecate it to avoid unnecessary compilation and test time in
> the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

