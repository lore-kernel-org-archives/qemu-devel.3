Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB4FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 16:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlAaN-0007uG-Pa; Fri, 15 Mar 2024 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rlAaK-0007u0-Fe
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 12:39:08 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rlAaI-0006YJ-Q6
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 12:39:08 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513d4559fb4so2359059e87.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710520744; x=1711125544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GwoUDi1aTR9nFS2lil41K52D7zbkSG3+6SKMvfX0p90=;
 b=tbeIpAwzP1y6I5wSpouBpWzNgWOUNJr08T1Oi4NO+DRYLe039Vdo8xBJUz5LtlfXII
 b/qVw47MEiYhgM5g9rsp/6mgdYpWbKMPS3aywSusojGtZkA3/QOhPWbkNSp6VDka2ZFc
 W7m50ofX14swOtdDbj9wd2eS6Cal73DzoK9GSiAY5x8mZ38gayPXSHYNVyBxad7/2cDV
 DHqF29s4loEret3jbdJxaquKkZ+disirR3QLnqMSh41MXZxcPppgM15ClN2zuEmTMD80
 FB1UVyprxLVZTgU8xq4H5nS8O6w0RUss9l7V7vVJsqcTPSI0aPpE12FK6B8oDkJwj+3m
 3Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710520744; x=1711125544;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwoUDi1aTR9nFS2lil41K52D7zbkSG3+6SKMvfX0p90=;
 b=KNgTQt02WhxIqO2LUz8o9MUalC4AWlmh4XDQjRvQBgCmkLQSPfJNI96KNC0CctdsBV
 KrqJ35glIHRuBCfD9OdtyoBq+pyThd2OtIiMJXKDp8GeabuSW1MEjV9peiAbFx/p88ye
 9sY4yKIuVMxoa8qdMkdCQV3AmfW7w4uBidwJx72NqTNz8Hi13agbEmtSXLs12kbXtn7O
 VTFU54xSbugc8NxqrWWBOOR0sMlXamBHCGgp2BbsQKVC+Q0c/6Ie2Or1h9KqKS1FoDEv
 0OEg6ckGz+J9Cc3B4A5RcpwsTPC3KQbWO8v3CHkEwAKJMCwoU+y4MbwGKAofCkrQzl9t
 jQgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxnZpghrSmYDcIlqVyAJV2xYd3KDB3taAyAT6oRrHSTapVrrQWH5jumOZFv/39wG1prZfZECLC/q3rTqbRnFzMG9XiRvw=
X-Gm-Message-State: AOJu0YzO3V1c4+Lr+ukgPPVWWNMNmg4fVlgElypKH5gUlwlpjijdeLnc
 rBdz1YimcQ4zBtnpF5jRJLk62YX5ZqY62ldrAa7W5r61IQX5w51UHWAXTZ2GZV8=
X-Google-Smtp-Source: AGHT+IGvLc82wW7kv8oiguzyo1zSAkhKDNpDy8ifHwqKtMJHvfdWfZ/yV7CbYwU46APFrDgSl32cAQ==
X-Received: by 2002:ac2:4425:0:b0:513:b040:707b with SMTP id
 w5-20020ac24425000000b00513b040707bmr3924609lfl.51.1710520744002; 
 Fri, 15 Mar 2024 09:39:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 p6-20020adfcc86000000b0033ec072a491sm3550828wrj.35.2024.03.15.09.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 09:39:03 -0700 (PDT)
Message-ID: <06c7f2c3-b773-4ce0-91ba-eb4249b8ce8a@linaro.org>
Date: Fri, 15 Mar 2024 17:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/25] qapi: Tighten check whether implicit object type
 already exists
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, michael.roth@amd.com
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-25-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240315152301.3621858-25-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 15/3/24 16:23, Markus Armbruster wrote:
> Entities with names starting with q_obj_ are implicit object types.
> Therefore, QAPISchema._make_implicit_object_type()'s .lookup_entity()
> can only return a QAPISchemaObjectType.  Assert that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/schema.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



