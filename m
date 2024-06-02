Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A704CC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDzyR-0007qY-JM; Mon, 03 Jun 2024 01:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sDzyP-0007pz-JN
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:11:09 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sDpHQ-0005Rx-7W
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 13:46:07 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c9cc681ee0so1937049b6e.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717350362; x=1717955162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vf8avGYPfK1pjp+iUujkpgOjYtQ17Y7vKM7SLuav6rk=;
 b=DnqzTWhQ/4l53WXLPEASQY+GAJXDd/QcfOWCz9vzq5xSKB0OY/WrusF7JLpnLdeB8B
 BCuaaAyMJBjQVTsC3spWXC1e8Trp16wrY7rwqxyjtLhJl3pRWc53bJcuJKlWIiB2r1VT
 RldTtFDtlYsv47N2JC6BSBe5AEF4qlqMH8yOPEEJT3eSY9OzZMxWHFELZ+eUb2NHWIFP
 WYeuPEo+2xD8zmtXve0r6O3qqmKOZsUPkLEQdI/FbePKID7y2XSlOonJNtf40IYRQVSs
 Qx8KA9oXsWK9QVLsrFRf6lmyMoj5pbpJAFB2Bd8S1DGyB1hHxzsoPUN/J/td/VVUgRda
 YGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717350362; x=1717955162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vf8avGYPfK1pjp+iUujkpgOjYtQ17Y7vKM7SLuav6rk=;
 b=xSV397v0mOhDmKtbQOCEzM8K29rk2WK0Lq+7xwE2a2vchOwsyBgj3e98WmdspNBYdY
 wSNprmvVFlW9+Pohu+Rh2S9mIaTK4txQg0Qu+HddvoY3C2gUiI3PTCP5ZNEA2knrRwuF
 g6644U7KwCb307FMXgQvrv+JaWkgfsh1mwUHEW/lDwYedqAG2Db1OD5lg6+s3rcvH9V6
 YjqJm1cAIvj+ggf9wXSKhCShtBlhv+kzikqxlKMyItCbH+YLAvWl96M1+CK/ejk9Qf2y
 YY+B/POQ4X3Nu+Ykh1FmhWOS1o+9Lc6ARksTU3Aiu/j9nwwsvOjRjGR0qPQYAdBxgrbw
 gO2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUewc6i34tRfHN73YXO1nlZhf+kpNDRzLo+ahlngGfEd0V+XJI1kd6LxpRy9ZsMhh4YhYw8fFQUy1j6XCMDnNxff5uV7qA=
X-Gm-Message-State: AOJu0YzcOrruKvV2tYy52G0yOF8YVFGRSJC9sm780HwwlcEipIsc0Ydb
 EUj4gWCYo3ZuAF7LrGyqF981AKbRpDn+BpH+q8fjgYbm+jpFYeosjhoAhVaEVHM=
X-Google-Smtp-Source: AGHT+IEkaximBPlWK0TigvaEZPMiQxcud6+feW69n1PHprIXapAyvKsNqyoXSOp6LzmUFjFX0Gd/HQ==
X-Received: by 2002:a05:6808:1591:b0:3d1:e1df:364d with SMTP id
 5614622812f47-3d1e35b9c63mr9483008b6e.44.1717350362353; 
 Sun, 02 Jun 2024 10:46:02 -0700 (PDT)
Received: from ?IPV6:2601:2c6:8480:9270:9cca:35bf:cded:133b?
 ([2601:2c6:8480:9270:9cca:35bf:cded:133b])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d1e1a4637esm999105b6e.36.2024.06.02.10.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 10:46:01 -0700 (PDT)
Message-ID: <1016c817-d1e0-4dbd-8fd9-921bcdc23a0a@linaro.org>
Date: Sun, 2 Jun 2024 12:45:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/6] target/riscv: rvv: Optimize v[l|s]e8.v with
 limitations
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240531174504.281461-1-max.chou@sifive.com>
 <20240531174504.281461-6-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240531174504.281461-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/31/24 12:44, Max Chou wrote:
> The vector unit-stride load/store instructions (e.g. vle8.v/vse8.v)
> perform continuous load/store. We can replace the corresponding helper
> functions by TCG ops to copy more data at a time with following
> assumptions:
> 
> * Perform virtual address resolution once for entire vector at beginning
> * Without mask
> * Without tail agnostic
> * Both host and target are little endian
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>

Why are you generating all of this inline?  This expansion is very large.  I would expect 
you to get better performance with a helper function.

AGAIN, please see the Arm implementation.


r~

