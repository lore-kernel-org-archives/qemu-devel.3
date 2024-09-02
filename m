Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E30C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 01:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skw02-0005I6-Ox; Sun, 01 Sep 2024 21:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skw00-0005Gd-T3
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:36:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skvzz-0003gK-1n
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:36:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cd8afc9ff3so3177106a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725241013; x=1725845813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ef3Pk/lFxIuWixJzToifaC31rWhfFAF4rJdzGm9ThcA=;
 b=OYENIaBRVURE1kXrGel2jdGJD7gvJUdxRM/eC3Xke0pRYaWr2gioLn6qQy7gtzMwWi
 VySNq2oaGZIvcB0fVswe9LbiMDS0TBiQQJZc4BLQ5oYBrv/AoZosn0T2Vf/8CmMZle5R
 wKFub4OITNzCNJnPs7+NwMjK6kmzMKatp10jnFQ9fmC/kQ4H1uJvqAR4bApdYYIQMKI8
 8gfGh3KvwDl3mhA8DMh9NqG9v+k+3rpXO2zdSnYuqCqpsn5EcjS68dFgqRltVb1M/vWT
 SaeUWuOgV7o49x/kP6ceZ0iomU7L1kcDmHKNqKg3dUbqcsnHxAbftba7s6wQNJYjZWNu
 ga2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725241013; x=1725845813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ef3Pk/lFxIuWixJzToifaC31rWhfFAF4rJdzGm9ThcA=;
 b=AbixElk/metq/wU6jJRMawrKBanWDxg5ywOBzryQC3+uy/xhA3NpGSzL39Z64X0eDL
 9XqawKecyntQSctDEiB7u1aYMdVdgNnFXZ1O/t/85Wz6xOcB5sPEYOWqouhGkvC2L+ZH
 d3pOPrPbT6UHoXpp2Xv73UN4muQEbQqFs+P/qxOc/xby3Uqo9qum4jBrPuGqXL71UAF4
 Tvq/nZy1GvcNFKzbk1fFOfLQ8lP1AlSmSOzDikRLw0RkgvQSffezItzwzfWjY1L4vSjr
 bd/e9e//lsVj/bxkRV/MfvaKQpusmAWrBULbTW8Ux0EsVKHgOawCU9koNH7EEy2poclW
 IUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFGVAnHeGF7ZsUwBsOHTvgOCSLlvUcLpDfG/vIgwI7IAjFKaVAMBwXTE0bVUiE8Uuc1UdlQHBbAahD@nongnu.org
X-Gm-Message-State: AOJu0YwDE7O3/lDYReHj2C4FvIkoc9bogRbswSeEEaiAtibK5pdpG9w9
 U/CHOcF2dk+vQgdJ1YGiLJ4Zx3gJ8/c2q/eceXWXNUNw7zGb4ADZAmMe8Xt4I7w=
X-Google-Smtp-Source: AGHT+IGgm+6gNarQbanACYPzaSC6+pwL0JrSwsockfZTJGztT+4HZbCA1g5vsg8TL/UEcWkt0rCpGA==
X-Received: by 2002:a17:903:32d1:b0:205:7998:3deb with SMTP id
 d9443c01a7336-20579984038mr25033805ad.19.1725241012833; 
 Sun, 01 Sep 2024 18:36:52 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205345089aesm38875295ad.149.2024.09.01.18.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 18:36:52 -0700 (PDT)
Message-ID: <5330a89e-9036-4c27-b85b-4bdda4f3fdbf@linaro.org>
Date: Mon, 2 Sep 2024 11:36:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] tcg/riscv: Implement vector mov/dup{m/i}
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-7-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-7-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/30/24 16:15, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 54 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

