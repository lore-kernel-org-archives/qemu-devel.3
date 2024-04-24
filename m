Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97270C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZOC-0006Zs-LE; Wed, 24 Apr 2024 05:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZOA-0006Yj-WC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:58:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZO9-00086p-Dl
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:58:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-417f5268b12so70990445e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713952683; x=1714557483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EYcl/rLwxzPXVTRBwcXX3670RbHFPvK9LRH6dhYzJtY=;
 b=BdaztytP2p/jcCABEHWS0pdpW34VUBb892wQYpv7b+Vu2xHqYXPQBZSLUyeyk6Jacp
 EHxEPXhVduMcikyDQns4O4BQZurCAv+ne/6WIHm2wlVW0VZ73GtmukPQNgDI5soeAvcF
 kLNiq1w9NcS3xeDUBPhHvd8y4iJVE3dNYyKVP3oZqL3ELeHT0ZMWTbOKrAmXWDEs0M0z
 lBk5Ab1mXocw6r8kSlBtlIuzBIE5qL/4fPrGOpXNsene9gV+YbwzQcKSFPWcjL6T+i4S
 VYbFqJQp8cDwFst4ctVy5NnjNGIN0yfp/IYRnWT+v1qQYI0zLMHiHuUtiW0akrQD/ebs
 r7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952683; x=1714557483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EYcl/rLwxzPXVTRBwcXX3670RbHFPvK9LRH6dhYzJtY=;
 b=GbnGbmN1zVAaOvHwJucTe0FmoL1hrNvJX8UBS2krYo+yBHtkHmX7605MJ+6tC4fHtm
 XM0qADZA0pJTUsviWRy9rsWiqjgmAEIdxl9VXEO7btDAJBBfHIKMzn45sfqIQ7U0Yel1
 t8oA3aJVmv46TCvmmQF+nxSbpWs31/jiI7AJOOSdD1c2q93lID4tvkLBYGk+FuVuNMQk
 YKojag5dJZFyd22lafp3cW56aCAxTgCHNJ629mIirjHwar0kJLuW/pITxSY26JpM6095
 367zZtSuEKqazrvFClIQQLxRkL+x/cJU43G2IQoMUWTbry3UxD7LBvs9GGsNUWAFYBHw
 qjeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgxQKmZ5sMte3+W9fIi1Yf+FmTvSu6fCy6wV+nAJ03Pl2FPOtF3npEkrVuZoyHATHydni1nj/erGgQBFh/fD6B/ZxkzXw=
X-Gm-Message-State: AOJu0YxOnJ86ERrWxtaqTJe/e9supgQzAGJrsMnUi7EAso1kpd8bUgV5
 pk+c231q/GlzKNxLt7OAmKe1uBrmX/HwH3bN8ocRUdTnqXwIDuO9gQ9UvyFSX+Q=
X-Google-Smtp-Source: AGHT+IG9Z5kaqAiVIfcKDzRadlnSiX1VTQ3Hp+e5mgS7rGIN4nYx7s9t1ENPln2/jon2PBARvf63oQ==
X-Received: by 2002:a05:600c:4709:b0:41a:2c91:6352 with SMTP id
 v9-20020a05600c470900b0041a2c916352mr2021113wmo.36.1713952682819; 
 Wed, 24 Apr 2024 02:58:02 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 bg11-20020a05600c3c8b00b0041a9c3444a6sm6826010wmb.28.2024.04.24.02.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 02:58:02 -0700 (PDT)
Message-ID: <dfe3a9d6-72ef-4fa8-b4f3-bf410a566c69@linaro.org>
Date: Wed, 24 Apr 2024 11:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv,kvm: remove another strerrorname_np()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, mjt@tls.msk.ru,
 ajones@ventanamicro.com
References: <20240424094700.453356-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424094700.453356-1-dbarboza@ventanamicro.com>
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

On 24/4/24 11:46, Daniel Henrique Barboza wrote:

> Daniel Henrique Barboza (2):
>    target/riscv/kvm: remove sneaky strerrorname_np() instance
>    checkpatch.pl: forbid strerrorname_np()

Modulo my nitpicking comments, series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


