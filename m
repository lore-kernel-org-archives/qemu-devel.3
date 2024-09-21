Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C1CCF9C6E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 04:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srs1R-0005Rj-Ca; Sat, 21 Sep 2024 00:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srs1P-0005RB-PN
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 00:47:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srs1O-0005Pz-BM
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 00:47:03 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so3420724a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726894020; x=1727498820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TTFkXvWSJaeQbvLo9U2hTwWbAmZF8twhja48HK0eWeI=;
 b=pQnUDkzLiz1jhscoy7JhhF+y/nj14gbFLHpMzqsxfLHn2JDLLyT4IbxoDS4P219ytf
 kFORgWFHBWCx5SgkxIuUW74S3mSHgMPjXILtMlkPLS2C+RTSvuPcQvqQ9743j1t3kbdu
 Rmq48bAybfvvUZgfNBij4ATbVq3clh6hLQ1pJ4N5fH4rgMdkCXUlWsXKwAAS+PnZ0TwO
 TmRI94VZ4Xd/EHC7Xavb4w01SXDf1HXtQZ9/VMFDKZ25ReJ+BNzS3mRqJl0ilwTsXxeJ
 QS/9hSyg4MCH1N/ccQuGuwRQ3VsaBoo+YJPfqRPKgui2nDrBxS0/Sg1YPbAmC4eX2LNa
 /FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726894020; x=1727498820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TTFkXvWSJaeQbvLo9U2hTwWbAmZF8twhja48HK0eWeI=;
 b=v0UYF/sZ5zmux99ihgdYKr+nGm9ngeq4l0x8ERNVXXSHRZKW+itBBWfiUKBOKzilvd
 NVBCXAlYZHDq3nkq4B/LcIqRFHYgq8pjhk/S7TH4M0W9hnhagTx+sMtZfrcVMYf3A9Br
 f8jezzzYu2SaNRzodtCp3MgNxTO+sy5skoIreKz66ZGxdVEqfIzoSVDhBDGmuh9qW6wM
 VPHozx0eVwvuPxOtZnq0RY65Ij+MGQjuXt9pwJpJJh1UrrA2AJSTvGOYbUjToKI0X1Kr
 HtXkOv+/D817BUoPy0yh/YzRLoj3Bx72iBXN/l+l5qgTq401+YmkOGAP8ggTlDDHpGx3
 WihA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZq/wop5MAKKofja8NpYvPAFsrL0D6dC6Ha7/uU1ZVboOWdMRBYA6FX1vkUqhtEh9/NaYMCxoDxSWp@nongnu.org
X-Gm-Message-State: AOJu0Yz1LlhfZ+fn8t1lrU9aWBWx1JA1evQMAfMUI3llgCqRoPLtbVmr
 63DNsjrlVLHbBRh+cchGuTa2sCd62yYsB4fv5vVu6Fe6nP/9T1CYrDxI266tJlc=
X-Google-Smtp-Source: AGHT+IGsx8ecZvYhWGv8/ZYSnanWBBoVeFSXRZzM6wynG2BFdsczGYOHzr1tXz+Hg+MxaTWK30D7CQ==
X-Received: by 2002:a05:6402:3548:b0:5c4:4e15:872b with SMTP id
 4fb4d7f45d1cf-5c464a584bemr3185475a12.28.1726894019785; 
 Fri, 20 Sep 2024 21:46:59 -0700 (PDT)
Received: from [172.28.10.56] ([83.68.137.68])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb4c125sm7854454a12.17.2024.09.20.21.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 21:46:59 -0700 (PDT)
Message-ID: <af6c1d40-2a6c-41b2-b0f1-4a8de2b31628@linaro.org>
Date: Sat, 21 Sep 2024 06:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target-i386: Walk NPT in guest real mode
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Jan Kiszka <jan.kiszka@siemens.com>,
 Eduard Vlad <evlad@amazon.de>
References: <20240920161009.35834-1-graf@amazon.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240920161009.35834-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

On 9/20/24 18:10, Alexander Graf wrote:
> +        /* No paging (real mode), let's assemble a fake 1:1 1GiB PTE */

Comment is out of date.  :-)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

