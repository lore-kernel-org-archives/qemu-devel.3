Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF071E98FAF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 04:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAhJh-0000bA-AV; Thu, 09 Apr 2026 00:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAhJZ-0000ZP-Ln
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:48:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAhJY-0003Kr-AN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:48:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so4790045e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775710102; x=1776314902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K2em2HJoNSMypReWmmrKJotGP+z0X4FtLDyx/1r4xGI=;
 b=r6IZS8Pznwba5xOTuTcqbSsT5jDO+ehiumtUtxaIKCh9FI6qGdJilCQWxK6V5xvqtM
 IdbYi/Ydxevse1e+AGk70/3XHNYCBnPOjqKloH7+Njxas5ZWCwoyiF6jvtRgP39P5beI
 /nNpriUkD7/tIgM5D9DCisULkJKbmb50WfmU7duBwvRV4hrdhL37EMWCe1vOSz92vJ8L
 we9KJkVGZFrUS4Xhe7PCwPzrvNNo12mbFq1TnNjbLV8osXqennofqWjCAPfmNKnOvcRR
 rBtVzxkUT/vVoSkFugyRiN5VjwPWqahMYYQaPnlB/+bz8jvjIclZXoNyHmy35cKfItnR
 Zzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775710102; x=1776314902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2em2HJoNSMypReWmmrKJotGP+z0X4FtLDyx/1r4xGI=;
 b=I5AX7HkLRJqk1QHRzPiNU28rCKid0sEs2TJIEjShN6je3KJC2PU3dujP8IjS3miZBR
 +3K7ffyMtJGNrPPu+kU2+wY27J5yXb2xwR/A6DYVobhKiwTz7WGgsMVcX4k8iNXm9u75
 zgoehz51lNzQNqE1GldxPydzdOcg46WCUjyDnQ3l/gClYtvbWlH2M5sMgGyfD/ewv4HD
 ivkVurys91F9e+AfQwm+RlVbPK0zjHGRTlGhGuWSPjgJegr8Qpu2v64QmCBDqunlbIXF
 00o0Zthwe1aw/0+5mCX86+IBAu4xwTACDRrZ6XO0iG4cGTMSj8l3r3kn9YqZ1Srl9jrz
 Tc7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJfiTWubYdHDUWO0oiHEEN4D95PXZT2KGAw/y6sPkT56bW9rvOZwW1ncWJiF/31tkbXivbNptaA3h0@nongnu.org
X-Gm-Message-State: AOJu0YyxnWhzRTbRJrJ7XOm54aCm1/hv3orhnUnqtSDfa1QM6ABYVQjM
 JrdM2FnpC4Omx1fVcMj94h7KFkmccUsic0OOUdZ++EX6RRdPl9VOzqwI0WTw3zTABW0=
X-Gm-Gg: AeBDievomox6jl3GTXnpIvSozadS69SuiXnqWuU9RbjzrStHm4FuWcaWQrPcllsqpED
 uIQ+vrf4h4vAii9FG2PBD48vNhu3nxHdpqpOL3xrzlekr2mePhmGW1xS0GKU7ylpwxmyeS4MqtY
 nM1SV2Jr0w/75wJTSAk0TWsW5O7JEoU+ny4MQuu9Zut2cfOWxgcQh/hPQkCaWijkKnv7j01hSxH
 bZS10nsB2RUQqYUgQpRhRRz2sejNx3H6lWBcJAMJmvOA/AnQy8TXI9ZTMdfFUXyinfwge8xca8P
 VDxH8MsBZtEXEMCxEKQcG3bttBiKbKxg/xksCnkLn/igiakURX1gmP2JIDkjuQp84LyWZ1QYDyZ
 2FCVkc6G39tFRIeCXgYBeQWPASOHDbE/05zFQ/NCih7Igw8ip7yMxyJtJRtHqMadF1se+mQJLcr
 RVYdwTU+7L6fjkIW5x6yGPcSA6filzQP7khker+ljLtGTJ5eTYFuQFK+LbIO4VUgwAkg==
X-Received: by 2002:a05:600c:3546:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-488996e8774mr332515595e9.9.1775710102482; 
 Wed, 08 Apr 2026 21:48:22 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f1esm62059131f8f.2.2026.04.08.21.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 21:48:21 -0700 (PDT)
Message-ID: <b6ecd9cc-ca5e-43bb-b0f4-4128f8b947c0@linaro.org>
Date: Thu, 9 Apr 2026 06:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] linux-user/arm: Restrict regpairs_aligned
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, peter.maydell@linaro.org
References: <20260409035015.132370-1-richard.henderson@linaro.org>
 <20260409035015.132370-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260409035015.132370-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/26 05:50, Richard Henderson wrote:
> The function regpairs_aligned is for extracting a 64-bit
> quantity from a pair of 32-bit registers and does not
> apply to AArch64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-internals.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

