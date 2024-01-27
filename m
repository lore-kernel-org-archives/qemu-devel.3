Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD4CC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaHw-0002ed-MJ; Fri, 26 Jan 2024 23:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaHv-0002eV-Od
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:27:27 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaHu-0005qB-82
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:27:27 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-59a1f4b8d94so82868eaf.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329645; x=1706934445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wB2vw6C1w4JH/0jPO6rEeqaXUc98qvnfiTDXOJG5CM=;
 b=HrKPii+CmHNO0aUiD6ypocU6Uh9Pg9DiwggqMtTsnQ5XOU9OHIaKljmuUsPCNR3v16
 4W32B6rHmkPEGEfSJEdZx22DPo9dAgABZ+JnHKA4H6LeG6tdcfD5kelpdQaCVV8Nk/ca
 A9OualRtbpuL9ahj4hipJbcQb3Nn7bfzF6vVdGn69YVwRuRz/4/HE9Itt8FlSGf78ICA
 eU2V0aljbPBoLFgjZl0RkoX1nI+bHIRRsoe2JQ2md4/vtjIhXldFcyGzG/j9QkP0P1aB
 5Y2lst54zGM7g6QnB2g/O59SeRPYksTGnPWRbMdWSOoL2fGPTKwKemKHdbGBU9BFbiKK
 6AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329645; x=1706934445;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1wB2vw6C1w4JH/0jPO6rEeqaXUc98qvnfiTDXOJG5CM=;
 b=uh3KswkByHuRktwuMwGDFPbPehRKBNiMOVDTZao4uR4LuFLbsC6176KmKPA0saMM+e
 S3+ynEig2UHxJp4JNDewb/bfL3DAhUmuEZAkviQW6ZtErUdtu2GD85hlsdL6RMIyLjWx
 KYkZeiURvOIM69boSIxZhT8fh2LbB+qxRak2kRAnuiXJ7qIyAYPN0/e4/MqpFhpboppl
 621rcH5ETO3/4jYgLLxU3lpoERzwMQ3blqIyh39HaTLrIPARQVQi5EnHGQ3x7UR6K9sx
 ietsjfNYCGvRDXNWbic10Pu4h8Eua+C/j8LC9zy3tQ+1z9jx7FoqNS7Yl4ntxiosfwYJ
 Nnkg==
X-Gm-Message-State: AOJu0Yxe89kW4xIKhISU3Zqidsj7DW5EZXe188HVxaQ7Llv1iOXoV7sb
 maCsOYTxo/RW0U5rL/93wJEPXMDPj9LdzOqIrsWWX/ssrJitIF+BjUY6GRc2zMc=
X-Google-Smtp-Source: AGHT+IHvSGtF5FauVL9QGveOZDEHRXhkEz1ZVcdd5NJFrH1qjm+9eLn47M8HnWSzQfeAnEanKKmd3g==
X-Received: by 2002:a05:6358:6f04:b0:176:723b:ec8e with SMTP id
 r4-20020a0563586f0400b00176723bec8emr1089096rwn.41.1706329645044; 
 Fri, 26 Jan 2024 20:27:25 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 gd17-20020a17090b0fd100b0028ffc524085sm4001781pjb.56.2024.01.26.20.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:27:24 -0800 (PST)
Message-ID: <a5e80dc4-2141-48cc-b886-772cab15faec@linaro.org>
Date: Sat, 27 Jan 2024 14:27:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/23] target/cris: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/cris/cpu.c       |  5 +----
>   target/cris/gdbstub.c   |  9 +++------
>   target/cris/helper.c    | 12 ++++--------
>   target/cris/translate.c |  3 +--
>   4 files changed, 9 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

