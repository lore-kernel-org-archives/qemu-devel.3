Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BAFCF45DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 00:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfScN-0004n4-Bk; Mon, 12 Jan 2026 19:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfSbt-0004kH-Uq
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 19:50:14 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfSbq-0007Jw-Lv
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 19:50:12 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c47ee987401so2497409a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 16:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768265406; x=1768870206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ql+j8G9WoNkkx5ESL3kVFSv+lM+Kw1jsj1tzzaU8lIg=;
 b=b068AVMZpX8QftdbCzX8Fe6OoCuL2AMu/HJP1xfkWSU2YWF95V3pO/X9DIoQpYB7D2
 jB/pfS+3LRKLbh+wgVL2xDf5KnRQTJnJng5PDPHPGkv2u5xAEBkrEMxVi9yUaSxdxMfc
 Fz8U9sgSUMCDGWNiH3DbCBXKfq5nxeyKD7o3yvP328tNrmWrnEEcP5LfKhdsGqS+I27J
 xxZXN80dtlZXMtn83SL40gKKh1U4LfqYLRJcSXuSeGANVtNfsh+q1XLzpk7PlCZpzpnw
 pY27qt3tF2g1ZX1P2ygtkIiHOxTSWhQbdb+IrvuL4HgTSBTFDKM+0Oh12gods7g1ODl4
 LNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265406; x=1768870206;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ql+j8G9WoNkkx5ESL3kVFSv+lM+Kw1jsj1tzzaU8lIg=;
 b=CathzPLf9n/PBVN7AyWVkJe4wZ/tVo5c/45gl83S9ek1gRjsMpgca3GO7cGDKDQomj
 0EBZo1NN3OfmnXIOknUwFig0ub0X+zE8jWkqD6G8m2e/3SeM7rLkUu1uq4jhXI4RTuRx
 kYaudvq/J4nvsjFlB8BFd/0k0WMSlNV6A24qDtWTs+sLso01Tthfv8TD664bnMQ3HgGH
 7DKzjG5rc19ReJXvB4RYv9jczUMJfIN4yfxeLirz0Wz1QOexnI985N7jgJn+xBm8gKn3
 r93Ei86KGagXQpO/FrU5z/HGXxaAsTq6KCF4F3a74EB1GH3ASLJQWWqYKJ/rfVxjg4xY
 cEPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPZUfZzojJJIp0BEn2OBH0Ta1K1vn9dezVWyOSSEZXiuyefJFHpaH9q9RLtGkx+6LWzEBZ2lx5Q/Lc@nongnu.org
X-Gm-Message-State: AOJu0Yw7vDyPNYnzxifJCk39l5LyNxdqyI2KcfdxTGcsTSs+jjyCKJAH
 +G3GPsa3Uz3/yTZUGpCoJeA/UYQ9P5veDAEmwoJO3uQ6V3qXrFRr33KgvgAhWxPViic=
X-Gm-Gg: AY/fxX7CEnzzhFBUsGUdeOdfCrI9gezo4OqprN+EETlCBSm51E6Tymeeh6sdf0x4k2s
 x9Aci6DbgAnpFZ4YqNxY1UE+FMH01Z4HTHSBxMNdm015JclCU2N/RX406XaiIFZWNZLuUOPej65
 dFNBM1m0wT8DJXrOKdTFr071GZwyyl2u17fRQJlKHMd1/kcj7xO1FYyZLca4gUmO5Isth1GVon3
 YlWLBL035VTc5J/bbOGidD15FKhLigmqe02ODAKZbjwYkZ3pJp0tevOf//936UyyUdg1ZO0Nfw1
 7O0pYEGACc7UoBen8F4QRSV2lNzGZTi7RBR4URX1qzw3yZMPxX1IGib6C3QCAQPasIofjOnduvG
 JXa8UqRQCIy7oXNwUZ7OBAGKekJEvELwf3BfWRvm1JECiytE/ABTg81w03k4AVrR+xMZC0xVGMQ
 ohZxXPXNFH7uDBXQ8381iOznqSTo0=
X-Google-Smtp-Source: AGHT+IEK9LDYcNoBCRXFOgyxTPvuJfKFdEPN9rMf8WUnwEc3Q1NoMZrpqdsXFZDXwzUAUuJt+hiP/Q==
X-Received: by 2002:a05:6a20:6a05:b0:35f:5896:859b with SMTP id
 adf61e73a8af0-38bd9987e14mr1131638637.4.1768265405478; 
 Mon, 12 Jan 2026 16:50:05 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd495dsm186618685ad.96.2026.01.12.16.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 16:50:05 -0800 (PST)
Message-ID: <39581f70-44db-4a35-8f58-0bc8d4f09d6d@linaro.org>
Date: Tue, 13 Jan 2026 11:50:00 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] ppc-for-11.0 queue
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 1/12/26 21:34, Harsh Prateek Bora wrote:
> The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:
> 
>    Merge tag 'pull-riscv-to-apply-20260109' ofhttps://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-20260112
> 
> for you to fetch changes up to f4e34d0fd56c25dd0c90722ed80a83a175160a6c:
> 
>    tests/functional: Add a OS level migration test for pseries (2026-01-12 15:34:04 +0530)
> 
> ----------------------------------------------------------------
> First PPC PR for 11.0
> 
> - Snapshot support for several ppc devices
> - Migration fix and OS level migration test for pseries
> - Minor code cleanups
Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

