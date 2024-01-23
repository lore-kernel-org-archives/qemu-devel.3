Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E74C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQbi-0002za-Bi; Tue, 23 Jan 2024 18:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQbf-0002zN-TZ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:55:04 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQbe-0005z4-Dk
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:55:03 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6dd82bfa998so995026b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706054101; x=1706658901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/fWQcBZCwJrwGdSn60qxlAV24JhiMU/j17JiiD8U7RI=;
 b=zBzX185mrXA4Fagc/RmjTdSOtNOziKLZS5VGaV5Uc+AYuZUS/dwOxQyYq8a/Sgr2L1
 SSBjo8lAmtoyPyh7EY0xKXsaNlcqhmLdSmD0eF0ezHkw0dwNW4ahfp1RTm97ok6NkvOL
 sRJk2agM/VTAohI9DRP/S8L57X2Q53HV975oQCihw1RC39a31Y5f9dFZ3NJFEoyo62yy
 38qGQX0//nOWxKnTXojh/cdF3/e0A+AfPrvpcgdff4Dw5UETcZFzWMK9qPvQXPyTgSrs
 4nzgz0vo3EpztzBybRtmMuEWoLOomlJg/1RpxxTj/dRmjT2l3a1vpCg0iMa2H8wirJMN
 oyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706054101; x=1706658901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/fWQcBZCwJrwGdSn60qxlAV24JhiMU/j17JiiD8U7RI=;
 b=BbzOCYApRWB8umruqTqLVjHZEoD2vpkTurLoHmeXD9DP+51m3wC7oDVCjPGIcn1Cg8
 Cgv4ChfeYEPsYr/dqiZHB8nA25nemqnAkbEuk0DcezPveMEX79PUwz6ONSaXpVu+8jXY
 Vme4SrZG23bNqj5hEDIv2ysU8fJa5tTMmZ9ItYzKJhsUFB0I91llhLe6+/ZJtnWqCAaM
 EKgWZrIZPQxeTLpfRBSZn7yp4xX0pRdHr9tifzizbItK6QV9rhKXIvrx4IrBUXb1Wla1
 2u/zR/r/uf8aTuOXcFKbbFgVEH6iAG5/aaPuZoaayQg7TvcZJGP//q3C/wqRKDL/w2Y0
 zsRw==
X-Gm-Message-State: AOJu0YwlpMrvOerEJ1ihrH9mGE+cGvTKmq1rTX/uj4878FzBPsUfaz8X
 NorH+NbluyL9QZtL3aFnc+4PkTtrtfMd/jJNZDRwy8vWvB+v2FcFjMvB6fwIK8g=
X-Google-Smtp-Source: AGHT+IHrtmWawTF26K3HNoOQr747VDWiQMjGcXt55VqORuoXq+p8N1HtYHyZXOMSh6pTVfLl0YAUCg==
X-Received: by 2002:aa7:8891:0:b0:6dc:c49e:a7b6 with SMTP id
 z17-20020aa78891000000b006dcc49ea7b6mr2934408pfe.65.1706054100557; 
 Tue, 23 Jan 2024 15:55:00 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 r13-20020aa7844d000000b006dbd18ad865sm6441913pfn.55.2024.01.23.15.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:55:00 -0800 (PST)
Message-ID: <92ed19b0-b86f-4c5d-9b74-bcf1cdd7f3cf@linaro.org>
Date: Wed, 24 Jan 2024 09:54:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/34] exec: [CPUTLB] Move PAGE_* macros to common
 header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-15-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-15-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> These don't vary across targets and are used in soon-to-be common code
> (cputlb.c).
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-all.h    | 24 ------------------------
>   include/exec/cpu-common.h | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

