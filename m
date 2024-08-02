Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED7C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZubT-0007nP-AQ; Fri, 02 Aug 2024 11:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZubR-0007l0-99
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:54:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZubP-0001RP-OD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:54:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso55379355e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722614038; x=1723218838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ulj0JdWeWhPf6NfSKyruNSZydbupVWd9hrcQc6mnthE=;
 b=Nmf003rxwDCtrNFQt+l0qF65qPJkn75Af2VB2xvmdXoQbEPYaHTCiLFJVmdLmICtRv
 qk0n8sDvH2HB7F5oOeyxj3usTjTNFI7qRhINhv6f0Ib4+jsU9ZkJVHy3E9EA9saY3Qgr
 Qs9GuqdTVyXMdsA+xKDACzs6ra99Uq5o1+8OIqiNRdjQOVH+shqzt1niczDPsgIbOxjs
 y4jTu+0ZvWKPL4jgeuq50oJDIb74wgrl6CbmOrVWIRCzm6El4szZCxy0EaGvYtfK3TqX
 WRER40yQN6SnT3mNl4jf17cTCxsB6lGUhOje5nOrU19u2eJg1VAMqzsYCIhkCiZwIIqu
 F17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722614038; x=1723218838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ulj0JdWeWhPf6NfSKyruNSZydbupVWd9hrcQc6mnthE=;
 b=JXBRmuNvTaj1n53U9ZtQdVnudlgRObgWm9NVwVsnoIEIrqqdhraRwk60JnvxLE3WlQ
 fF2GQNT/K0OLZ646dPprQJNiBOcsa8GKL1dqiGyOfABGb7CjdXy2yCWB9K9ZprXn09T/
 3bYVtTKVOum+WlXM88lHnK9WmJEdGCEubMuv3QGAyLbzMVtLWgks17uwIB3nOWCI0wRw
 nEdi4E0H19hKJ8UYCZsxWoY5fnrF2q4jGUKRNzmYvPkSaUfaulgu/ejUAfQkupNFO2Hf
 ApdTAh1pW89unsjNsyLWP+QdQ5yalw5+0EZG5oFYuyqdu1rQIelx0Cm279LZs+yd4XTe
 3Ukw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCJWlzFIssHYciqXjBb0HlJeItACORA8JckvalP+iEpTI1W89QOqUgNLXzQ7bP9cUgIEP8MMYACvnIOZ7SCqJOnMwiyfk=
X-Gm-Message-State: AOJu0YwKkifozjBfxUiMOblwIvb2BJ7nXIobkbqL3lxu244nXcOGCVWc
 gIuJBe167gBaaC2JTjszJ+UihYHpFqtmuANq0lQiJ7MhU9zGV2GB2GPogJk7+P8=
X-Google-Smtp-Source: AGHT+IFOSCP3itk4M40bd+ASNx1LOci7LA/5dgqSepmK9E0zpC/SiSDwa4LJgjbqnnKeU5ejCWqdKw==
X-Received: by 2002:a05:600c:3b27:b0:426:593c:935d with SMTP id
 5b1f17b1804b1-428e6af7aeemr22364925e9.5.1722614037655; 
 Fri, 02 Aug 2024 08:53:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e03c4csm37967395e9.13.2024.08.02.08.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 08:53:57 -0700 (PDT)
Message-ID: <06c4aad6-8c1d-4474-b3b6-4cc9065edc33@linaro.org>
Date: Fri, 2 Aug 2024 17:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: Fix hvf_sysreg_read_cp() call
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Alexander Graf
 <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/8/24 10:37, Akihiko Odaki wrote:
> Commit 05b8d7249109 ("hvf: arm: Do not advance PC when raising an
> exception") changed val from uint64_t to a pointer to uint64_t in
> hvf_sysreg_read(), but didn't change its hvf_sysreg_read_cp() call.
> 
> Fixes: 05b8d7249109 ("hvf: arm: Do not advance PC when raising an exception")

Not 05b8d7249109 but e9e640148c.

Fixes: e9e640148c ("hvf: arm: Raise an exception for sysreg by default")

Updating description:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/arm/hvf/hvf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


