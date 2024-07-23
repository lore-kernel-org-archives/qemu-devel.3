Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7089FC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 02:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW507-0000La-T6; Mon, 22 Jul 2024 22:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW507-0000L0-3a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 22:11:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW505-00039B-CH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 22:11:38 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so115330a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 19:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721700694; x=1722305494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJZv6DBqFq5QMAMuvHDOvpytGHmIzCn1GBmrP0WUubc=;
 b=PpcF2H0HNEWgEivPSY7DfDoFwYogAJk3gtwMfEMTRBSnfp1n8TvCuwUCvtFzlYE/Bj
 4JffEDU4+j5RFVAiSf/kJxYpNfqvq783k8cc0Vun08MIL35dqXvVbAW8qCUn6olu7Zfs
 jZJlKIaNFMCcayuQsDUWGZrEMyDMKT/ONBjGmlpmAd475Wzmg0v6vZWCm1IdaCnQC99B
 8ksHDB6J3Qvlb4LWDuqIrEG6FBZU6E0bOUVGBfnHITGSk5TUqKQx1/AwHPCVjkDNfsPp
 wvrSw/dk4TDeHdK8+iUJcYc7kiGM4V4WdzU7xyQjf9WHXvli9MVAA/WWUivzjAoDJe+1
 d/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721700694; x=1722305494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJZv6DBqFq5QMAMuvHDOvpytGHmIzCn1GBmrP0WUubc=;
 b=XSWmVM9MiyO4JA25NmSLLBrk9yF4XZQQEH+hJikyKaM7xBhZtUyeB1jFJy/gNntwVa
 MJkCvG0HyU1tm11mYB6VciAiAGPcQN7IgtAwBgYQfxt7UM8Jih9Whw1EniYqddAHClP1
 yjWQMsrnP6r7YwHWuFmFHg8zZ42oHvUYxAe6ePkh6UWz6hV92Az6w9txF2Xfu//+ORAb
 py49YCZhfT6BIXEKAkcqOM0JdRLqO1umigqL7T5DBrV2yScG2V8TP6V94kgZWxroB74J
 FR6eWJGZAl4W/JzkLMhKq6akCeSWlwaicS1/exBGUUA8/npVP1lsju7z/3wdeZKXUEGr
 4Qag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQE9DpLNi4CYunq3TPm+bt/TgAxRE78XYQlF/+1NQZADHwHMw2VC/hFUOjiwT5H733WrJAfLq6Cq/u3lN6Po2d7lGZ7p0=
X-Gm-Message-State: AOJu0YwMplr/UyDD9O8O8rJMdjIGDdIJ35Fpfp5qdznF7nZm3wL7Mj53
 JwwhkCLfj51kTNkP3BTKDiPk++M9ouuiOSecBXqmZhRt1wVm8X10SuZDlIPOAo4=
X-Google-Smtp-Source: AGHT+IEmsG9qNE5M4jKFNN0O+1gdMrzsiVAmP0RMMhavQgkZuZEwPLZc4MoVqJfqJs3Fn8zrwNnJBA==
X-Received: by 2002:a05:6a20:a12c:b0:1c3:a411:dc48 with SMTP id
 adf61e73a8af0-1c42299e229mr9820739637.38.1721700694272; 
 Mon, 22 Jul 2024 19:11:34 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f486861sm62066485ad.283.2024.07.22.19.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 19:11:33 -0700 (PDT)
Message-ID: <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
Date: Tue, 23 Jul 2024 12:11:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 7/23/24 11:30, LIU Zhiwei wrote:
> Both trans_fld/fsd/flw/fsw and gen_load/store will never be a
> translation function for compressed instructions, thus we can
> remove instruction length check for them.
> 
> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

That is both false (trans_fld is used from trans_c_fld), and not the takeaway you should 
have gotten (the operation of "fld" should not depend on the encoding).

Perhaps FLD/FSD should depend on the ISA (RV32 vs RV64), but perhaps not.  I cannot tell 
because I don't see a specification for Zama16b in

   https://wiki.riscv.org/display/HOME/RISC-V+Specification+Status


r~

