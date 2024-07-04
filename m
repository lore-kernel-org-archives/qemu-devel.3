Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00304C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 22:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPUuw-0001Wy-IQ; Thu, 04 Jul 2024 18:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPUuv-0001Wf-0g
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 18:27:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPUup-00039W-Vp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 18:27:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb3037b47dso7022235ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720132018; x=1720736818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aWV57/fSO5zv3XlPU0kL0AzcF2Bp2fhBSQ6va1qMya4=;
 b=yVl/Hvr4T2mjXwpO/6Pb+PdnNhhmrn7lNsraX36xkYU12e/dSiheg4xwa6+RMO6JKQ
 ui2UIMuXA4IV7SoehiE16D3gMN2RMhbMK+P8Sz8NOSzTvcJmatTO+ce65vx12MVBArdD
 lJhcMW2MCDYWh5Bu9uyRpjfYw5CzdbVUOywixAXmMif80DVFpL7o9hkfsPeVZPROPxxM
 CGhhbkWz30pzBME5T2bH4L1sFDHqwS8p9AIInxnlaOcN1yyvQWnrrM+nTzpOMCDYUkhY
 2Np4pVbCx5fyl+X10WiutjERy31xr+EdH8KCNwe7qZ4jCUkZ676m159XyKZGbKxP/zU9
 FTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720132018; x=1720736818;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWV57/fSO5zv3XlPU0kL0AzcF2Bp2fhBSQ6va1qMya4=;
 b=EKK3il62IbNe2bsbrHmXt9tQklioiAqkxTtKYzHcYWI25XIATW1/tQCoQd8XANdmIt
 newMxOHEoO01gNGqZyZVjzKEzx6H/4PaHp8XHQyGQ7wkleqBghsTsZhPB91rHTV1xTDk
 X5Zb1v428XCEv9akeOILgzwTyylzdjwsvLaIRWFo3mBiWfuIDtxlPzYaeUEuj7votLyf
 kfYx5Rdq8oPNmEcU/iaoKK8Gh2WKdCFZNTnbyHuz5hcHYIwgr5fHR+4+OLNPc0YcFL/w
 7Kj+xkrQH4a8i5l1yu+2fw3fMsRlQRf2fNIBgY2nfY+SWBS8Lhm0ujovdwI1jaOxsYSo
 FMCg==
X-Gm-Message-State: AOJu0Yy0xQX++pu9434EP250myNzTFG0GcPuTQ3pvhVA6fynq7uF7ec8
 YQxS+4JDYK4yqnlCFIoTp54oUwgqbg2qAWtbvQOO+8ZMpzrmjHUgR/zW0HGVOkzpgY5BTmXVEDK
 b
X-Google-Smtp-Source: AGHT+IHE/UvhYObUcETqGK7/2UVNb9fVGxB4EZhsVTcMhbZ+EanmRK68geJq67XPNRfaUTMbdtrp8g==
X-Received: by 2002:a17:902:e841:b0:1f9:e95b:5810 with SMTP id
 d9443c01a7336-1fb33f0b105mr26065055ad.53.1720132018253; 
 Thu, 04 Jul 2024 15:26:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c8af8sm127716705ad.34.2024.07.04.15.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 15:26:57 -0700 (PDT)
Message-ID: <06705a65-a478-4a55-9da5-17adde12a26c@linaro.org>
Date: Thu, 4 Jul 2024 15:26:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] target/s390x: pc-relative translation
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20240605215739.4758-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Ping.  It rebases onto master just fine.

r~

On 6/5/24 14:57, Richard Henderson wrote:
> v1: 20220906101747.344559-1-richard.henderson@linaro.org
> 
> A lot has changed in the 20 months since, including generic
> cleanups and splitting out the PER fixes.
> 
> 
> r~
> 
> 
> Richard Henderson (10):
>    target/s390x: Change help_goto_direct to work on displacements
>    target/s390x: Introduce gen_psw_addr_disp
>    target/s390x: Remove pc argument to pc_to_link_into
>    target/s390x: Use gen_psw_addr_disp in pc_to_link_info
>    target/s390x: Use gen_psw_addr_disp in save_link_info
>    target/s390x: Use deposit in save_link_info
>    target/s390x: Use gen_psw_addr_disp in op_sam
>    target/s390x: Use ilen instead in branches
>    target/s390x: Assert masking of psw.addr in cpu_get_tb_cpu_state
>    target/s390x: Enable CF_PCREL
> 
>   target/s390x/cpu.c           |  23 +++++
>   target/s390x/tcg/translate.c | 190 +++++++++++++++++++++--------------
>   2 files changed, 138 insertions(+), 75 deletions(-)
> 


