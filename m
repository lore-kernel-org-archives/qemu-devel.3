Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C8C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZql-0005PE-Q7; Wed, 27 Mar 2024 16:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpZqk-0005Or-5U
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:26:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpZqi-0001I7-He
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:26:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dfff641d10so2102315ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711571175; x=1712175975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJ4krMIICQOX1rez7cEITr0hEaaoqGumshJfNPhG8tM=;
 b=H3OdDRSxJs7R7X8mZ5uLd4jVt4fpdb3DAXoktVWpy5WuWHDREpMVIoaFPx70wis+sK
 RB2Ap9cMdqgIAYn36sOVtPbpw3jDi0YVvOgW0ORGPECHkZBd4YOe7kCp5SSoi18g2hYh
 qjUk9vlyAHsYHvXipucYS1fvArQan31DlywlGNxoOLI56kwJVcXP4INm0pg/lT27FodT
 1P1Z/4Lky1fNg8kGiBwCFexDEf9U09OfB8pVLRXt0n07BA5milSAdYgHX1KCapQAYVKe
 p2Q84kvJCN2/iHT3kFehqw2RzvNFOklud0Bdqc8DKujrC3EBv+8XPFp7vhuYxqZRxGuE
 WbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711571175; x=1712175975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJ4krMIICQOX1rez7cEITr0hEaaoqGumshJfNPhG8tM=;
 b=sxutuKER5MQ75XF49rKpxvKwA13XergGjEIvOi0XfOB4FE/kHgxyAADJH52QdneDz0
 cA+CgF6ehwDu/5IDzLBzgzArd1x+dITfn/I7Wo4iY0BWYb0dJrtqre6Q7wqE4mNygbmC
 URE82n0pVuKycC8ZyMXPbfYBSi5Myjqm6ZVFNqE7ytBHshpCGpVsbzrSfgeBK+Ay8SXi
 cigynb37mf4RqowmakDQSA42s0EuCnrH/8ovZrxH7GBGdZSyFA9T+g83XlYZYgXZlFB+
 P4jz7SZmIT7JGGQ5RPGT8d6UZgFDBkYK0c5pTeqHfq5l7Pf8kBPcnn/5+leQRZeuZiC/
 Zimw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQqRxRi5h4MWKdwQSDedwbMeGfM/ck/FDcvJosc7YHab4faQWX6j6myxILn5Fz+YiTx3JCCDMMlHMr5O9gYBvAjmKUAs=
X-Gm-Message-State: AOJu0Yz+LEnE53jYzijz5353xILQapalUxudI8/StdrwPmGBqHf1JEj/
 w1aYJPtggzQ8S2G6c3Z8VB6AQ2v8koxXdC9i0xNkm8wGtMytHEPELgdqnQ+DaY1Q4FJO+voSbPw
 O
X-Google-Smtp-Source: AGHT+IE1Qd/m48zHvnKfEjPlwSMSiI+XPUGGSUpf6u0PEtWSRtgZWS3uWjXdF/QNvorDiC+wveH7JA==
X-Received: by 2002:a17:902:d489:b0:1e0:119e:f935 with SMTP id
 c9-20020a170902d48900b001e0119ef935mr793459plg.15.1711571174661; 
 Wed, 27 Mar 2024 13:26:14 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001e09322cd1esm9508322plb.150.2024.03.27.13.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 13:26:14 -0700 (PDT)
Message-ID: <a956b839-63b2-473a-a671-e4c15ee589d1@linaro.org>
Date: Wed, 27 Mar 2024 10:26:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] target/nios2: Remove the deprecated Nios
 II target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240327144806.11319-1-philmd@linaro.org>
 <20240327144806.11319-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240327144806.11319-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/27/24 04:48, Philippe Mathieu-Daudé wrote:
> The Nios II target is deprecated since v8.2 in commit 9997771bc1
> ("target/nios2: Deprecate the Nios II architecture").
> 
> Remove:
> - Buildsys / CI infra
> - User emulation
> - System emulation (10m50-ghrd & nios2-generic-nommu machines)
> - Tests
> 
> Cc: Marek Vasut<marex@denx.de>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

