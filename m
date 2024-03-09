Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345CC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 00:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rikm6-00065G-8n; Fri, 08 Mar 2024 19:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rikm4-00064t-HX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:41:16 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rikm2-0006t8-V1
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:41:16 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e55731af5cso1045499b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 16:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709944873; x=1710549673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KuFGcA/xTm1dlxVgIdYclszG76MxWdYhs0aNZ16Ec3k=;
 b=Hz80Jo69EvIVt9vAvamec8Nr0KytvhvWvzz1o7hnnAl+IuhJHQuLNHceHPEqn8JYtU
 IHdNzT75+CiEFuqXZNrpOy3ibcjW9njm6vxm3zeUNkUrIobl254lbaXG8uk/J96dVgIx
 MWJMJjf2FOQfaPplFCaLWRm+RIrTro/RoMlHVdWG5q0JzlohHFu3OwmOF99AA2IzvAp7
 pfaQNox4kPESt09aQtDYm46I4/ilODD9ZPUHXXm2LFLx2Z+BV8GKOl0ZkiXeaVx8hX3Q
 XywgBc0qHbeoPgGxP7HGH7/dGPgrpcUM6zzLiufobW250pcSLcGxwAL/YszajkD5QNPH
 PdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709944873; x=1710549673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuFGcA/xTm1dlxVgIdYclszG76MxWdYhs0aNZ16Ec3k=;
 b=UQajwe6krb52bn5XTGoUrcRp690Q2BZR5r9MaC3WUGwXZ7FCC3FI4D4BnqlM4txQXe
 knvLFjPg3V6o5CuVvf7HXuB5XMBXqOwcGybDyMopV0HxtCEolBfqRM3OPaLMD0gDKMO9
 wKTMQ73L5sd/4U9KQQmSVupfuQT9i1q06Cuo9iIcLyJHqnC4A1ZGqMlXuRAMONjTq7pg
 Ic1gI4vtIfq/egQgR3w2h7KlzAwoyTzNS7aM3SMFB3ZxCeh1aiWeepJpPFixOeOPpm28
 m4RpLWiQQqnIQAKwzkMFKfDAwbijU+ZaZd7AM+Vq0CqI06yYIyc/LhcDweoZkSlQjwhr
 FDdg==
X-Gm-Message-State: AOJu0Yy4MwWFDDHXff+1/Y+6x49/yUVgmJQYjvpzPph0zrKUe1GLo1Aq
 7FIMCNR/Zu1SzWPzHYPjsUEl3WM3deI2R1A5Tuj/0BGKoEnQoLuXjEIfsoxDfww=
X-Google-Smtp-Source: AGHT+IET+csUit91QeKu9hs+77sucSSR2hGZ+w6u4ZNUSLBNBWlyvuBVwvKv38bq22Kgg9gRbzW7Ww==
X-Received: by 2002:a05:6a00:995:b0:6e6:38b8:a1e6 with SMTP id
 u21-20020a056a00099500b006e638b8a1e6mr638075pfg.10.1709944872616; 
 Fri, 08 Mar 2024 16:41:12 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 v66-20020a626145000000b006e6450ccac5sm294660pfb.126.2024.03.08.16.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 16:41:11 -0800 (PST)
Message-ID: <bb7823f4-2c8f-4b0e-b76f-19de1b22c0b4@linaro.org>
Date: Fri, 8 Mar 2024 14:41:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
 <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
 <87y1atu0y8.fsf@draig.linaro.org>
 <9fea440d-f0c5-0a7c-a60e-b75e4dcf73c3@linaro.org>
 <87h6hgttjq.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87h6hgttjq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/8/24 09:25, Alex Bennée wrote:
>    make vm-build-[open|net|free]bsd
> 
> see make vm-help for details.

That won't build freebsd user.
Something I've mentioned to you before...


r~

