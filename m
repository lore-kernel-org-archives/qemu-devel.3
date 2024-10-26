Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A744D10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Yae-0008KX-He; Sat, 26 Oct 2024 00:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yac-0008J9-S5
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:39:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yaa-0000pL-Bc
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:39:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso28832405ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917587; x=1730522387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hvh0+NDIIxNrTt03RW0CfWwHElN89DGa3qT5CiLqnG4=;
 b=QyxyIr7jRKWeieL3MogtxYUkmafYuGh0Uqamz7kXv7dRqDcDxP8ySWnPL9kJdbwP4I
 w0WVuVBkwwb3kcx8+imcNGV69Zu4lTD8Oa9Pjw1RNtuh0Qby4rPU6LI61lSAFRxqVsY7
 lLmQAjilUrWMsAog6Rk97Ve+Zutx/C0WqrEGmWey1yPKhoZubNksjsuDQgk2mkIKPXR4
 K2rUnFAgKm7mjNrW5SZYDWcd0+eHcTowqp5oO3X7Di2aOY4uZLBlMAyG2UQy3ivtlF1G
 MHq+33ODMnNJAuVOrh7WgNWDspw56UuwH0s/xF5bw6ByZCZSLGBggMce8p+ezJbNIZIX
 t14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917587; x=1730522387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hvh0+NDIIxNrTt03RW0CfWwHElN89DGa3qT5CiLqnG4=;
 b=grY90HX0biPfeVOvzPON2AfQDGwdVtXezbIblWEZPV4miLoSGV/kLVbXoTn8zIZWu6
 k6VXQS6BYqKR1+AuR1aTu0j+Z/Ez0YuE7/SpDO7Uf4x+IBAxqB2uVVKhauL6ORH+l0un
 Uc7YaU+5Rf97rEwTu6BAASZnYOiS4/lVI2izkUilS2xtoLJt4GP9l+6bRaIUBZIhAz7V
 BYQ7dTE69YV8Y2Z57FY6LxNythLlnD3JVd5L/xNVNKouR/mvIqo6g1qVqzp7ZCinqoWk
 VbEiUgw+u2ZtVe3r5oYAu0r/sx1Ltfe//S1BAU+TUQAkU8SXNFCBj5NFviTIPXoYWKTo
 YVTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwwNvLvIWim7sbCcKsjnnSEFxz547MrGSBXFC/7J5w86nDWyEdOUNhi4sXIFpbvF7kmYNkldEoKSU9@nongnu.org
X-Gm-Message-State: AOJu0YyR1Myt/wIk2L3f3ZutiOTu6siHgYoQm/AmkoSbJT9y2WjUTSkA
 WiHekWlse/UHCzltRlbxH1/3yFkm14pWFqfomZa2Mq8ccqlBrkBifpyjjwSr1Vw=
X-Google-Smtp-Source: AGHT+IERE2I9p7BYU8mcWHw1Y9HBtji07mvDioX8gLcSgkE2Ih4vfKxRDTW61yw34cHGdRD7Ux5/5Q==
X-Received: by 2002:a17:902:e5d0:b0:1fb:57e7:5bb4 with SMTP id
 d9443c01a7336-210c6c6b978mr15380225ad.37.1729917586966; 
 Fri, 25 Oct 2024 21:39:46 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02eee6sm17342875ad.219.2024.10.25.21.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:39:46 -0700 (PDT)
Message-ID: <33ed109e-5221-43f0-8f1c-e188187c581b@linaro.org>
Date: Sat, 26 Oct 2024 01:39:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/microblaze: Explicitly set 2-NaN propagation
 rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-19-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in the microblaze target.
> 
> This is probably not the architecturally correct behaviour,
> but since this is a no-behaviour-change patch, we leave a
> TODO note to that effect.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c        | 5 +++++
>   fpu/softfloat-specialize.c.inc | 3 ++-
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


