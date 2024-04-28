Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C978AC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s191r-0003nK-Fs; Sun, 28 Apr 2024 14:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s191p-0003mt-OM
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:13:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s191n-0007It-IM
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:13:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e5aa82d1f6so30577865ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328009; x=1714932809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KOT+UsQnEy0rl+ABQTEkkh7LShBLf1NAoWBreoVEwXM=;
 b=RUoPi3q9ug3IfU5e/MRnf4dbLMu6DO07o7dLxVysiQx5u7+MgOiIdOVhXAwhTP5vUb
 gjqtL/qUV5GpBdFA6q8fbZgnh5VNZRmxWU24s/rv4estYQBg41uJt3PV04+WfGlPdvJY
 KciXZyfiKZAeoL7zZ4fAAp690qC1vZs3O+qfRAPdyih/eknViXNGNLnMbOzBH7vCCywb
 xBv6/oX5p313IwhZIwTjufW3GtOiRqoS4XS2uJGluVrQdOwNWI+OsAdYXbHCOfVU8MiU
 MOGKc6zbpFDucSBHIfCPIZCLGpHGs1vQRl9KVu2rjovyjSfKCjgJsM6iho+FkDLNG9ds
 oalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328009; x=1714932809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KOT+UsQnEy0rl+ABQTEkkh7LShBLf1NAoWBreoVEwXM=;
 b=wVeP6j+m8TG420UntnGY1eTCMyktDHQER0IPOvjkoz1t+99r+VXOrO0N0RwtVyyDIg
 3VUkzYjOUBwETGl7hLnkW14luP5KmUhHWpWBkkjCXdivZiVShwI+2hJMSG+sGwr/Wd5r
 /dKT3Q/4XtXWxpiictpwHRZ1CNdSQbvL+5Yz126XF3/mUvTwB5KANezYF0I9Rt9oW6PO
 +otsRXruxqxwvJHsD3VPGnrcBcoUxKMWzEecqb5R/++9LkOoVPSkS/pRPJgoBD/v7r2+
 CdmLAHH703WKdK+ObgYqgeJ+HxTc9Zr1UDS4fu+fPgDbD1yA3TX74i4MXAJk0EBF5PTQ
 mKTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfaZXlqnwgpkgyiZlQCB8dE3Jh9nh5eoWJXf7G8KzS6ObWAHkBDtseYwJvOk454dAp/4bzrwMjUEgbaegQjndupJjArxc=
X-Gm-Message-State: AOJu0YxCSS1jdA6ZA9e2SQ2/BLTJW6HtGVgs2RDjzMmedSfhNMB1nnh0
 eBH1w+FLLvO4zpGIBFi62N+JZ0zkqZpc5ngo4nb/xHn1Bdy6Q49VzMMljRlfzwCqwWc5KxXzPmb
 p
X-Google-Smtp-Source: AGHT+IEBvpMvAy5RLExtb0jD6P+Ea0wz0sFFfQd1YyKAV4XgJv6xf5rDQLn6Dy2FwYzsLqlVjbKCNw==
X-Received: by 2002:a17:90b:1652:b0:2a1:64a:bb63 with SMTP id
 il18-20020a17090b165200b002a1064abb63mr10669174pjb.2.1714328009532; 
 Sun, 28 Apr 2024 11:13:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a17090ae00700b002b18b97c8ebsm976719pjy.30.2024.04.28.11.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:13:29 -0700 (PDT)
Message-ID: <1ca57deb-0c35-411b-a09c-ed0914cdb8c0@linaro.org>
Date: Sun, 28 Apr 2024 11:13:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] plugins: Update stale comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> "plugin_mask" was renamed as "event_mask" in commit c006147122
> ("plugins: create CPUPluginState and migrate plugin_mask").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   plugins/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

