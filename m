Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5284AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4sx-0000Bw-1o; Wed, 31 Jul 2024 04:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ4sw-0000BR-3r
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:40:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ4su-0003EQ-Mb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:40:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso35549915e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722415235; x=1723020035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58FUqkUuTZXvGCCud9UHy+VtIPb8Gsz6Db3sBkP8SEo=;
 b=VojxNB8dXWt7sLk3/r8kbkhdYQd7CIyt/Ct+9HoxwP4fNQ2Uwh+RoqMhdMRVyTKbQZ
 4lWXDWp7+yPbpniq/Nrh2gbO9Ov2Q/c7qiNlfVFrQYVyHgZMDopjkDEEZ5q64fiEjySy
 bdxm/3dhjdteO4auFiUAW4Lrgg4dgnsVh19S4eEpNXqL5qD2pbPS1gBrhF+4K6lBGqro
 +MvPWHzmoPF85tr8qxceeXLA7ycQ56a/cxjlcM8ZPizICBAJJSXr4l1fJjHlvXuCzgSw
 P/wsMtKYuw4YRy+CHrlPPpwM6J1sPoe2sUxOHzdkfJxWXN+wVm4462h2AQy+oxY1FiO1
 YLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415235; x=1723020035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58FUqkUuTZXvGCCud9UHy+VtIPb8Gsz6Db3sBkP8SEo=;
 b=Pfi55vWmRI2aA3MYeCUnyXT8a7UaW3Ocd63w/GbwpYKZPi4hlk6Yaee5X1v0l5qJk7
 7qnotKCAIytOXsX2llRJiPKXBuL++Sygk1X0aRtaTp54EznhFQpnAwTFwhucfsnstzLB
 3dR73LJ0CLDQy5lOQJWDQZHKhtRiDLOMasAD7hPhv0fhpqMZwhhWxAYW2GrTRFRJjRws
 b6xN9pXpBH2oJKGU/8fNNj5b27nwzjMFDkLnCay6uWje1Cn+Iv7dH7Xu1tgigVpjC7kh
 uAa4A2KBbGuFH13SpvAvr0rN+f/6TuBzx17dkV02MFtBN+GdgK8N+xac/L4msCIPdu0D
 K8mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabovAIAcU4LUfmzhv9FtTJYwDGdu00Id40SAaBgOt4ia5jYDBOHVu2CBYRp74mfR/YSKEvWabVcHF2T6wIk7/MWMhjwA=
X-Gm-Message-State: AOJu0YzaArGh5Qfxk8WRtZCRRynVYpddf3dZvpMVKHQm0Gz6YHhWApvD
 g2SUEGSEND7f/hfF/MTjycLkhGXYMpbfCs5W0SiUp4EuQd8CCd7F8sgk/IfecPY=
X-Google-Smtp-Source: AGHT+IFvW6Qd6mYrwb1MJDU8f5PW5uDb//1z1tOTDrII836edQ72yraiFDqxUev4Jy891RH52FRgDA==
X-Received: by 2002:adf:e748:0:b0:368:87ca:3d8e with SMTP id
 ffacd0b85a97d-36b5cee9d3fmr8107486f8f.4.1722415234669; 
 Wed, 31 Jul 2024 01:40:34 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0889sm16487234f8f.22.2024.07.31.01.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 01:40:34 -0700 (PDT)
Message-ID: <0480fbc8-4108-4060-a5dc-9ef6cbbae33c@linaro.org>
Date: Wed, 31 Jul 2024 10:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: define a v66 CPU
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, sidneym@quicinc.com, quic_mliebel@quicinc.com, 
 ltaylorsimpson@gmail.com
References: <20240731010954.1959253-1-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731010954.1959253-1-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 31/7/24 03:09, Brian Cain wrote:
> For now, v66 behavior is the same as other CPUs.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/cpu-qom.h | 1 +
>   target/hexagon/cpu.c     | 2 ++
>   2 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


