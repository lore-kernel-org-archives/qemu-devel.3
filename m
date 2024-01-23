Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9B2C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQ6h-0001Sg-Tr; Tue, 23 Jan 2024 18:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQ6f-0001SS-Ti
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:23:02 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQ6d-0001EH-Ia
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:23:01 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d72f71f222so18313785ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706052178; x=1706656978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6+uvILft0/f0YO6LyYjgnK5d0Jdms3RFOfsFnucysco=;
 b=JsXYjOlgG67RFgaAEq9Bh+1yXRrivLivfuj7iNGJ7mSSH+ZvtSMutw0dvZfrRQlASK
 99liNWcbTMAQRDh+FQvWl7cHcb5bG8CXaMv74FGctKdrxTqIoWHTqnPY/KXCpi/jERls
 9geCcUoKW13oCWBb6eQ6q/xFPACHKiSivy8SuXTKWXGGWBPX6JpDa+JlSeWkRUaS1etu
 FwasRDs5ncCGHDQg0YU+Qe5bzEMxc8zprFdmAY0gELnfrD6Qa294NnTJOVB3fm6bw8ZM
 QLZMoJGN398ah6Yfqs/NmPpctuX8o90EpeEnNgUUM2cg2GzzNcLB6e0bMjypNNQNv/yx
 toLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706052178; x=1706656978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6+uvILft0/f0YO6LyYjgnK5d0Jdms3RFOfsFnucysco=;
 b=NctOBVUmbyjk5QfrOsdefS2Upo58NN1rqwKjRN6yB5N45xysHLrXG1IB4hITKKNLk/
 nCj7FlKC0mudISSQsxQ8G+yXzccX3paOnXsXdfdQcyT0ARFOsuqqELa093ECxoCzy9Cj
 02FTIHkbJJTkfD6vP28NGyX19PcVMOCPd4Vl0kBXY47nIsVtFSB6gog65WX4Q1mQa/Ff
 Oeu+b1Z83lZBNu+QLwaL7J4umO64ZpJJJhNuYGerYdXLk46QKMlXaPXzmZ3qyhkytZr/
 NSlBQriqUH81V7JQM/a5bA9cT8uJd7B5PH6T46UB5SUa5Yog9Fos7jtQQH8kzbQCUYly
 5CsQ==
X-Gm-Message-State: AOJu0YzbfWNoiXkVOxiC4mMSZ3oTDlTwXveDhMchiUdZqv/kWhHsRtS1
 dgDvpdTroWnItkSHEVGPYBWzR1CGH6q8XMJLEe8+SIIaHVbOAu/weU+q3MOd+4LKkREaAV23LNX
 z
X-Google-Smtp-Source: AGHT+IHU7R/DMboUIqfcwfdQ+04Pz8cyfG3FZBcPsqhbnvMPYvIF3ihTi+UaOpp8vFGZsLfLHrX0DA==
X-Received: by 2002:a17:902:70cc:b0:1d5:5984:df52 with SMTP id
 l12-20020a17090270cc00b001d55984df52mr3934986plt.60.1706052177748; 
 Tue, 23 Jan 2024 15:22:57 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170902b18200b001d72ba7cac3sm6023730plr.213.2024.01.23.15.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:22:57 -0800 (PST)
Message-ID: <603c1aca-44f8-4ec0-a3dd-7b08b2dba2b3@linaro.org>
Date: Wed, 24 Jan 2024 09:22:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/34] exec: [VADDR] Use vaddr in DisasContextBase for
 virtual addresses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-10-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-10-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> Updates target/ QEMU_LOG macros to use VADDR_PRIx for printing updated
> DisasContextBase fields.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/translator.h   |  6 +++---
>   target/mips/tcg/translate.h |  3 ++-
>   target/hexagon/translate.c  |  3 ++-
>   target/m68k/translate.c     |  2 +-
>   target/mips/tcg/translate.c | 12 ++++++------
>   5 files changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

