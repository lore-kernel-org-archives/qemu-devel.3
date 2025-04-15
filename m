Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B29C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 03:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4WsT-0000U3-Ss; Mon, 14 Apr 2025 23:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4WsN-0000TT-I5
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 23:22:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4WsL-0000Kx-W2
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 23:22:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2241053582dso69356345ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744687336; x=1745292136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YU98qFybmneg+IJTspfUdamUclhupkujnepDI5DGYO4=;
 b=wv75zWunJ9+mAqFsB8TXoYKeAeD1Hd25SqRG4/yHaYxeQ2T6sNyZfQtp6+3uG2LFH6
 IIjJwK8PAeD7RI/2HKEYhe+fbEJjzI17SjxKq9PloQhivLMvdW2Zz88Mp9KQlJTMlYaq
 Te/8sZkDbc7tMs0xKbZhP/l/BW3L0KNgTLsnqFWXkmDzkzDBIBGSBgNF7F2cPfMRO1rw
 HSIRBuiB0SsulTUEk49aTJdb9vXV2VOmgThoGAOUhPEOdpwvs9GDnFoG+C3E1AOJMjcz
 An6+hG6+wEQggNmrHX5pKPnjVtwl9LLTLwwZ64XnGYns6iqDQlwMbaS8dMNLG8exR1UU
 VaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744687336; x=1745292136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YU98qFybmneg+IJTspfUdamUclhupkujnepDI5DGYO4=;
 b=wOsJcc4DSDnVr/yrqtgALnhYwc3JzREULNXGs4+E2I4VHo263WRkGqqELriAEqK9vj
 PiBUkKgrFOQf3cBAnPcmaDCUTtbEKz/l1gRzwbopjMCuZvP3TziWQZtymZHi3chIFb6b
 1NqUXYjb6/UPfr3xipg0nsU5kp5feWCNLe/ffLYmq9Ig4EJWzT7MNsUaN2n7WYhzOBBh
 XoAaC8w8PE3+++NrM9vGRbraeQ/fyA5mdyylv06C95NiFEw3lmSxOH5fnVVyzM1vONWX
 +Ag8pRWb5gC2iuHlsEXutr5B1ljON7WrLGc1QvKwYDzqXH2O7kKHFbLQzxbuXnEwmQCh
 DSpw==
X-Gm-Message-State: AOJu0YzI+AvB379kWU/BhFmqRoKm86ACai0eQ82MLPiiaa8ikAYWVLs5
 +Cq9MY6/ZeEQRxvVqU9cLRHmHAiODmwJF9wKqbiHkBdXiRrvVKj7vyQ7h34mYdpRwWTFgp1w0b8
 P
X-Gm-Gg: ASbGncvjZNp4+u+fShtSAwyWKAUaoaUVo3n61eX5VhD7FHVui8fssSATaswVzPfBjy3
 p1y/AS4xICU6dV8IEWgI0ChEAKc+ZD6EE3qbW08XEvFzRIZRDL2MzZsSOrvAaejCpsyCDenRm2u
 NZOi679O1y5/T50xekRIz3VpAWRm0iE7WF/Lbmxt13iCVNLRfFr2NY3+U5mZNS7LzuXqCmXzFH9
 +tqem7ExqkhZ5SrqXqwXppIMF6N8YqtHfS6lGQpgJfovbbRE9H+jPkEedAUbzNg7xv+2/y5gmvb
 9paw2iHrEoog7VIuxEGgVGTYGzduWmu07girtGLGHktjgrn6Hm76eg0DhEu9uRS19Ged6Y4GZRY
 40XuNbJHwt5TK1aApQw==
X-Google-Smtp-Source: AGHT+IEYvRgH2nyid8hJs8JW9/MfPv6genzZE5krFg5fUN0F/11INszTj8saKxmPGvQaFMMxfeTqjA==
X-Received: by 2002:a17:902:fc4d:b0:224:1ce1:a3f4 with SMTP id
 d9443c01a7336-22bea4a1e8bmr225877985ad.1.1744687336435; 
 Mon, 14 Apr 2025 20:22:16 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbc66sm107394805ad.240.2025.04.14.20.22.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 20:22:16 -0700 (PDT)
Message-ID: <7bdcc291-0dda-47d8-bc6d-0867302080a6@linaro.org>
Date: Mon, 14 Apr 2025 20:22:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/loongarch: Move header file helper.h to
 directory tcg
To: qemu-devel@nongnu.org
References: <20250414012528.4075447-1-maobibo@loongson.cn>
 <20250414012528.4075447-2-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250414012528.4075447-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/13/25 18:25, Bibo Mao wrote:
> +#ifdef CONFIG_TCG
> +#include "tcg/helper.h"
>   #endif

You don't need the ifdef.
This header is only used for tcg.


r~

