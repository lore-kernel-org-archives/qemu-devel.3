Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A202CF857B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2KN-00066g-BR; Thu, 20 Nov 2025 05:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2KL-000666-Os
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:55:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2KK-0005cF-7q
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:55:49 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso5466115e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763636147; x=1764240947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O1KAMSQnJQjPeO+xTAIghG23S7NGEeSSyvoKzxvc6kU=;
 b=hKsT93+4JC3mNbZb0h+wGWsX/eHCCjcSDRiHgs6igLCyD6Rj44hWapOcOYThuc6MaG
 pG/bG8JpWxPDUWZRJcgvCGt5DhK2Lj3sguD4b6ZwBe3H11aFFClZSzrd2xBY7kMOEFlB
 uhVDxJFSUomNwLADke0WzhVe8Tho2UR+vtDJo3FCNoZOPwLOKSGHJ14C0VjpTO5dMXI1
 shfBZzYvuXgZjPA6/Gxqh2ersfWZVuiN0F42Y/6OH54VWjqyPdleaMBDVOR2wcL1LeF+
 bl+9bPUh3+Ahn3h9FUBqtuF9P84o1bJR/4z2SIEiUr/Hyn3iuA+3FOldGp8lSsTsuC99
 agqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763636147; x=1764240947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O1KAMSQnJQjPeO+xTAIghG23S7NGEeSSyvoKzxvc6kU=;
 b=ruRW5ULtu5gSMJ0uEJOI1+ejsDd2g7UosNTe/mIJr5jV4+lTVY0A03nYPVp7hFY3eH
 HZAP1KZUXT3BIAqWyP5vYb+MVUPz+VdiaVfuwWc6sK7IO8GYtxQwt8rHY23pVLv+cKle
 YIf0jXIq+cLxrYionSZ0FD9Yv1Ah5wgyHYSH/uHbJjfu5YUj1gQyt9cdxbLDjqdWrmce
 O54zvC6rwYJh3VTkXMud7da+dx7v/sCxA2Mf8zpmcDqXMHhl5e5SGOf5WpfyXEDO8z7L
 EHJR9Dl46LhI4uzIjHKQVsIoUpnDQJ/R/ZTYDHM58hrr2kQ6Ce8jEUornKfhPjtK6NLX
 C/Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAt0iTlkd9L61stnX3hg6N6Qd1CG97d5XmiLhw9HE1mdW6Tl8H2bVflPmQKMTPWPaNCgmGskVEx/H2@nongnu.org
X-Gm-Message-State: AOJu0YxbE+zcFrkNHhoqJ5w9t4f2GcCWkXLK90hRcGx5Blf9iF3qznNc
 uoGah0BsKXJk2TYxFY8KByhP/kUzhIIaXeKBVkGjw5dFPWso4gbStDp6x0z2RXqRO1BF472h2fp
 wivZuFdI9oQ==
X-Gm-Gg: ASbGncsb8yvprIXV3JCtBr2AoILN0KbOWzET71+ChZyKV+lqZM2RCOrExIz+GFDh5ik
 gLX+CWVlnj15wme3Nna93aAoQfEuoiVD9hnfYyNlJ9MaTEptCeul1n2bfWFQ+47wa++jTZqcBn7
 Fn343I3zwCKfoO0isdyKapU6+w7q60rqQk9OXzl8nEB+OzsZevvY3sHNttHa3PjQaQa7DQcF/PX
 DPvNceHBl99leitDh+yQ6ErJIpQC79E+LWOamJNtFoWYdoLx02EOcy5pOUQQ4MqaqnGC6a1mt17
 BhtOpY+dXGJIZLwT06BDmHCLxkdGOVPfkwRdf1Ph0lUBo+bhbPCbwKekeE8UPmylLoQyBNae3yO
 0tGRW8Ah7pgCX7UwuQXcJV2QR97+GegdsjLfqeVdktJ5/r3PtPzeO1llPUwtpG7lN731X9KCTB0
 iMe1iCO2jL/1yjHEPJchGL6BAWG9636c1hhQUbuBNCzt7EHCuVhSRzkA==
X-Google-Smtp-Source: AGHT+IGsjdQGgLM7aqhSthFhm0TajKZLWKBM4xN2nAAXcxZXRPMXsp7+WvY3tjkvoIFZKVlLO5JVVg==
X-Received: by 2002:a05:600c:1c02:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-477b9e377cemr22322615e9.23.1763636146596; 
 Thu, 20 Nov 2025 02:55:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9ddef38sm63073465e9.3.2025.11.20.02.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 02:55:46 -0800 (PST)
Message-ID: <9c6433ab-9cad-4934-aad0-87cdbffc2d5b@linaro.org>
Date: Thu, 20 Nov 2025 11:55:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 10/15] tests/functional/ppc/test_ppe42: Fix style
 issues reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-11-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119082636.43286-11-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 19/11/25 09:26, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint suggests to write some parts of the code in a slightly different
> way ... thus rework the code to make the linter happy.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/ppc/test_ppe42.py | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


