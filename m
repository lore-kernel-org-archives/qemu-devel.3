Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0E4CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uVm-0007yj-1Q; Thu, 09 Oct 2025 13:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uVi-0007yQ-9v
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:33:02 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uVc-0003x5-Uv
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:33:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-781251eec51so1066549b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031173; x=1760635973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xY8AJkpKwMfvauojjAvaPbeT+UpUuZhhIJKZH0UlrGQ=;
 b=A0l0f5tv6F0P+iS/CiNMwn0qLRSh7pw+tNA3CVwCICP61OttNfN2tt+VduwauJRFKI
 PtJnnmESkR+QnLLAmy+WksveZ575vjbVsQ9AubToNvK/mUABKCoYU5udt3xNqcrLkiCU
 J6Q+YONFc4FyUHQNxY+67a9d3IFjDSsahlLC/b1wlShHAY/zuP9JlFdXwZYVYYaE2n0o
 Xy1//AxmoI7V8qmrVI5+69kt37tyPTWT5NVHjSOefN2+4IcaO6EVTok+rNg+hwFpej8A
 +wWkjNElfuN2MQ2GQqzZVJNMo+SXOUvfhEdE/60UzjHBK4eu5u3501Yag/SztKO2cxcY
 8xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031173; x=1760635973;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xY8AJkpKwMfvauojjAvaPbeT+UpUuZhhIJKZH0UlrGQ=;
 b=QFg2pV6dmFxwIayO7BQiHZqiy6y/VOZLPQsTey7sURAhUHdPzYwZobgHuymntJRxtR
 WMe6R+2wM2gZyPgoUcMws3FRk/6XcfxrSYzps3kKpHS3zonSH1winkh5VkVo6Bq8MxcL
 aWFqhXp3XuRobv5BqJLrwjmT66Q3Fm61ZmZNMhajcLtiw/Zlnzs1exMhkEbi+UIrU36a
 00LW+ELDYT3wK4ndh7yyhRRnb7ZHdGMi63Vor732svSLVbJJFcF9eQa09IuYh56nXwwC
 GgMw/huaIYPwdB2dQ/QpaJFBrSmUVDW0N27/s5vgVCYmqV/cCFb0BWYVcHxQgizGgRCU
 LIEg==
X-Gm-Message-State: AOJu0Ywhi6OSfXBevD0Z5+Pufs4RPDxhV4mc0tuY5HNZuT+dV+13j1yi
 zwqOYX3S2v+Z6lBD6E7z0ZmQ0fTc6ErGBajV1CiisvAAbHSwpk0RHlbBo93RrfHWkEpSdVGKTGv
 FB5eJRPo=
X-Gm-Gg: ASbGncsANUO+5EKE/W0X4MDmWU5C/SRknOddVilJM/pyQQX8+4MvV/iVxz38qZWH9z7
 gJyhfQlSTRgpWTgJpwLewB0aihdllvcuRqI5s89T0TezoXtP1ZxN1REVvkeL64hA+MftOoRxUh0
 Cpq4StkDFbPscCq1ut5I5R5Wp5jqz/DEz8brp8KspBkrDrUXe6lV2G/oV0UDwqWzGpECdfOXAhR
 U8seympAwyojvU4BW/m6RBwr+dNP/ET8Hq8qdTkmy3WnYYB1FqgYRwuVjWI2jFtZC9Vvlrf6fZC
 N9sf02hkULw0cEfYWBVGYrLCXV4Qf0N3JhXpSI5NADkXmKjezFO5JDLVII0ReMnccL5zkGScsn6
 2GzRG6zePtNQ1GVzfDkhaOc3ywy9wlcQlvfV76cN6jyullyyeRKUZ7ljEuwPMYyq/vn4OfMfuov
 k=
X-Google-Smtp-Source: AGHT+IGFNKK21Iw477x1IUCpHIZIhv2oVochNIMjCrF8VuVq8hnkiy23YdhjfdDCMzH0UnusvHcl2g==
X-Received: by 2002:a05:6a20:3c8e:b0:2ea:f131:e25e with SMTP id
 adf61e73a8af0-32da83e54b6mr10749709637.47.1760031172974; 
 Thu, 09 Oct 2025 10:32:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626ec2f9sm102217a91.25.2025.10.09.10.32.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:32:52 -0700 (PDT)
Message-ID: <102501da-0837-475c-968c-7a2016e3bc50@linaro.org>
Date: Thu, 9 Oct 2025 10:32:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/rx: Propagate DisasContext to push() / pop()
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/translate.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

