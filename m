Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 19:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv0O8-0007aq-Jo; Thu, 11 Apr 2024 15:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0O7-0007a4-6p
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:47:11 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0O4-0003Qu-Di
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:47:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecee1f325bso206512b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712864824; x=1713469624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S46kT4t7NiJqb2sOUbszK1wdb9x9qW18XR0HsqAIj4o=;
 b=F/UB+gOIMkLw22wS4df0mfgkJzoym/LuIujmipBkk71x7MWkPo9j4xE6xYeYsspE15
 AKca0leEsOUVolyDPfDaufRM3OZySyrhbONz2Xg5pfeH1kMuFHgSPZcHnNOezNv3/VAc
 SXcESV8aSsgT9QPmrvh5dy+OGlob0pYdh9fSPRuDPI4IyLvC2tD7Lg9E15PnwT4m4tIh
 lrGtm5gP/i1klCd1DwHHdsAOMiZ1UIYQPFFFuF6p1Q7zcZ6f1aI8tSCIObIo262oMD+R
 Q6loHi+E9V52l+SzbHJaq3I47QufKeOztQOMvpgdlFhDMyBuEgTrFX56mMoeqxtEtFGt
 ck/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712864824; x=1713469624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S46kT4t7NiJqb2sOUbszK1wdb9x9qW18XR0HsqAIj4o=;
 b=iw2CnK4VxL96gyQyOFwyJOSS/ZqMepWAB8xycxlrBFYQJKkL9XBHIpmdU6bkim5wqA
 ziTAr6cuHNdDtKEX80IDtaSNmIiX7B22HhWbmsVcauqIzOjW0zfb3F9CKSF2BqC5Utfm
 k8kRTZ+T9hBAWyfbTxy1jjXVHB1j4rNfJ7de6Hu049tum7RPq1VtxMSrjfFP3CvKNrs/
 WukzGmO30CxWgNKpMj0BXAYe+RHrhVpRsME+63jYiDiOwo3iBAhafXE2ZggtpOOj4jBX
 uzGT5hwze1y+PzWZKErEQg3jqp5uOzKquxRFBXudF5XBOowH8r2kfzIdu0h2VyKeAXIa
 RA2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq9mm6KaLetMiRhx2lG/fVbblFwGOS/6o29wNMmiHACEGYh1ws0PmO2iIJS3rjgekLrBZkWTA8/zoxJV+Ml2movlBN5iM=
X-Gm-Message-State: AOJu0YzluV/2bjB5EQj059BzfRLIFA6rF23c1r+4W+WwsBlpqWQVQTso
 7mbONeJLVxooxeZBWqtC2/Rnc0Jgcw/nhNqCnwCdGG2V8f+tvvuSf5emzHNoAHNXF8mWIyiOglL
 g
X-Google-Smtp-Source: AGHT+IHcbCXhaHpRQADpktIwvxlW2I3KjP96lK5gOWWoB3mHAB+2s8WZUXFrPDSqM2KcHtlRx9/5xw==
X-Received: by 2002:a05:6a21:606:b0:1a3:af3e:1c87 with SMTP id
 ll6-20020a056a21060600b001a3af3e1c87mr965926pzb.11.1712864824576; 
 Thu, 11 Apr 2024 12:47:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056a00084200b006ead124ff9fsm1543636pfk.136.2024.04.11.12.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 12:47:04 -0700 (PDT)
Message-ID: <694e45fd-e2bf-4fd9-8dba-13490225afc4@linaro.org>
Date: Thu, 11 Apr 2024 12:47:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] hw/ppc/spapr: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
> 
> Replace sprintf() by snprintf() in order to avoid:
> 
>    hw/ppc/spapr.c:385:5: warning: 'sprintf' is deprecated:
>      This function is provided for compatibility reasons only.
>      Due to security concerns inherent in the design of sprintf(3),
>      it is highly recommended that you use snprintf(3) instead.
>      [-Wdeprecated-declarations]
>        sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
>        ^
>    1 warning generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/spapr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

