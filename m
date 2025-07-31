Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB23EC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbWJ-0006W0-AZ; Thu, 31 Jul 2025 18:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbIK-0002z8-AI
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:58:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbIH-00041g-BP
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:58:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-240418cbb8bso9937285ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999104; x=1754603904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EEfNB9rkJDmKIjXsLS317fO1mbJkxKYEn9an3dTtzwA=;
 b=wxt8fCVILx2EAMyReWtWBR4kmIA4zctPvgP/I+JAIrat9Q4va7h3052gCx5a+R02Yd
 2e1JxCslAZ+RxeP2v9kmGsme6jzZqphJ+wBHMj+JE2MbjKQqhLUc1vac9fS0UmXjPgVF
 xC5Tgh1sqMFFdVDPZpE8Dj4Yw2LwMtHTNyNgj0ImNY1eJDl/9Zmwn8WGqaTGyzQj/1Mr
 nCRIgQXxKNyeoIpwtwGhG974UijLXs+SqneiWZvSxrV+V6kCizZcDt3CXgEUIuep5Rhd
 pwPJkmlUztD8awTlj+xiXwOozEzo2t7Q5vHjQvp/nGXOJN9AuVKwmQv8dBzCTAcmaG86
 f7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999104; x=1754603904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EEfNB9rkJDmKIjXsLS317fO1mbJkxKYEn9an3dTtzwA=;
 b=T5oaeupRpfT8+JY4xNtKiFGFV6dojtz8E2dPXUTJ1vj33JEIvWZyXsTyvSw040XZV2
 SWuBS4qYtz40QOSiCCvYOE5BJuwf69b8wpQyU9+O+mi26PEyqufPZ6PLnFyGeHKcfIng
 aZItiMfHhr4//NtBWSIdqeOGsBLKt/lt64yXJm3YN+jT/eH1PryjPT35xV8ytE8ImaMo
 wDq58PzhGjRG2K6j/8gdUXQRXoDjWl7cPEvDMwqPDkrXATsjg5ROpHYe3v8dpkPR45+n
 1Y47m5+I8896+O4DqDFBqIHMbYXt/Z3z037L7c/zRZYrrygDoGl5A2VV8PAjZn5YbLE4
 FeiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj3POJf6YVK057Cn0a7Q+oV50py/OhCdzaKDPvxxdfsHDpcJPpJgxhmmIjzSTAN1h0KQ9WcodOUmi1@nongnu.org
X-Gm-Message-State: AOJu0Yz4+5r/ZUd5lttQCxcWvQoPB4hU4I8FGx6NUKgK193LFci4NvQk
 EDrZicCt2XMSQhYtDJELW0LNVWItYngdqf2SbLhDYMqQOEuKyfaaB/Y6pQUpsSddMPfPvbJcC0L
 RX7Yh
X-Gm-Gg: ASbGncttMSZbRJ1Ay2e25ta0mvnk8zYk3z8p4yy7iv1LPtI8dhJlgQqOk2kMmFDRe29
 D8W1usN5+kmwF2xmMWFWASPRIZn1Uug9WGi3YXzP0+4lHhLT/Iwi+Dt3XcAZLG65/PkS5Z7mKuS
 w4HvPWgN4sMTHRiEzKsJjpcBkAlWIW63Q5AxgfYB7d3kL0NFN8564Bc2b04+5K4wDN8NQe8sNZt
 BL/0VTeHiCsJ+fnbLPAJ6q886CGgbzAVxCibknbpleUfHylI1t822BEoV8+L0PBDeseITadiTky
 7Ci5wUqaFU3joN4X4F9Xg4WnP6E8mMwhL5QODFqjwXcd2nbmil1lIhpmQqpGxkqIBt2j0svnAgB
 fGSmd+BLhQyb5DO8AleTFZTSokjdAALV+KsM=
X-Google-Smtp-Source: AGHT+IHatI8XIrGbkTbn93A1P5O/QxrzfKetwVwJMZ5MMd38yAbqjr/sl1iz1SsorrKFM+YbMBmX4Q==
X-Received: by 2002:a17:902:dac8:b0:240:bf59:26bb with SMTP id
 d9443c01a7336-240bf59292dmr77809235ad.19.1753999103728; 
 Thu, 31 Jul 2025 14:58:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63dc1688sm5695629a91.9.2025.07.31.14.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:58:23 -0700 (PDT)
Message-ID: <eeaaabaa-1d58-4404-a0bd-70ac92b079b2@linaro.org>
Date: Thu, 31 Jul 2025 14:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 79/82] linux-user/aarch64: Enable GCS in HWCAP
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-80-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-80-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


