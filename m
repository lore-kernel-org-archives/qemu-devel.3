Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D46C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 11:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGdXS-0003JE-FT; Mon, 10 Jun 2024 07:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGdXQ-0003Iz-S8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:50:12 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGdXO-00074N-L1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:50:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6f09eaf420so182607366b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718020207; x=1718625007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YHAT1ohGXrpTAM/VgOJp+5WxOzGLI2xd/kWshDv/pv0=;
 b=hJkXK54VFx7+KulcaCbbjaAWBO+NzL8a55vkjL2kscfWTlYwSpJ+zNGbiayxa404nP
 gwYiaUI6BhamcQSvvjVJYa2/m/XTufS9g8OwUYa3DTphWoae6OZa2VZczdVfPQD6abKb
 RSyYfzfZuDq9VkQAu4vsYiIhB2n6tBhwe7CTQomQB7BHDpxVaxBwhmZTXlr0VSaNMllG
 uxHLPwV/Vfl+x6QXWUOTaKTDDo5okqhCzvkxz9s0EHhntqA6cs4o/MOMrQvz19+aoC9k
 r2uPTy2z6ntXotM4oyJc4axkXHB6CDh4YtGXzBwj5kt/yN/sMKNw1W7KgfiqoDxV4Rjq
 AqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718020207; x=1718625007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YHAT1ohGXrpTAM/VgOJp+5WxOzGLI2xd/kWshDv/pv0=;
 b=IswYLmRroEsBs5Uc2p5nE9ayTtBShDTBJ4kbR97EDXRy6oaP5msO+k4uuWUMtOPZfU
 P6hXmyIcC2CqjTZsn3bDK19ZOJ5Mnkikg5g+0SHDhZa9ptk0ylJm/ZZl7QG5ZhhyNg+N
 YOffLzV7lBv3+c8CX+u8T5O53Qttx29lOwi1lfJ2Ku7MhSoWeQNDsZHqAlLOBmuOBJoN
 2iQ258E6Sp95GKR6v7CmlkGB+e4pyhUc+AdX3xBGYap+B7EMPa1yqdnYAUZQxWZqMIKF
 adJO1AapyOc1mzRKW1prtV54Yc+IvELw0F0sgDWpcHuj8qR3QWzEqtYLklsBbfmGDUV4
 1yJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwHl6iPxheKtCZd8u1hEt9bpczeYLAW+fAvhfQkV2uxVo+8gKW1wFat7tC5gbivdw2qq0eyHdUfAnDMXqAl3kYS6qp29s=
X-Gm-Message-State: AOJu0YypzTun6qNcJ6wZXeUwFkr+A8Pd0Lgx34hoF6PhuOBnpYz2Afk2
 np8oe34iZEjYiRmyOadk/5Kx+OVlHySM9ex/HG5/QrOyfRHIgxfNqrPEQPWb/YTtbygWXD8Tbnp
 q
X-Google-Smtp-Source: AGHT+IEYH8m6E2zJkKSbDaLroiPB9mCJNA/+P3DwGhH5rYX9jf4KMy2pXIQhJ6biayhC3U90oWDywA==
X-Received: by 2002:a17:906:f5a8:b0:a6f:21cd:9a91 with SMTP id
 a640c23a62f3a-a6f21cda3f4mr139302666b.69.1718020206908; 
 Mon, 10 Jun 2024 04:50:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6dff0247a4sm474105466b.147.2024.06.10.04.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 04:50:06 -0700 (PDT)
Message-ID: <d912659f-af55-48dd-961a-64ee40bbdfac@linaro.org>
Date: Mon, 10 Jun 2024 13:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: avoid leak of ctx when bad cipher mode is
 given
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240610094049.851127-1-berrange@redhat.com>
 <20240610094049.851127-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610094049.851127-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 10/6/24 11:40, Daniel P. Berrangé wrote:
> This fixes Coverity CID-1546884
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/cipher-nettle.c.inc | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


