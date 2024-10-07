Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6869CFB456
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtl2-0001md-Ec; Mon, 07 Oct 2024 15:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtkz-0001lL-EL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:51:01 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtkx-0007wm-Jq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:51:00 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e3937ef498so2597695b6e.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728330658; x=1728935458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z8TV8fYpF9eRG/D4gP+z3UnjvyTtJ/hBE8IkNgFDQB8=;
 b=PhsJ4DFp8q0rYLg4mnxfbQgmqigSYl1SThFfiCWffLSf7sTePjm8tfBBvzsxQYNVWP
 jqzvOMFM1UGwdeLchjGO45JV0S+gAnWMVgEtMI+XfC5hMrT4q1C49+dATvhqy7m/iTPP
 K5VPIek4KoiSzhNbU6oggvJW5zCi7v6u+toYluwkKMSkzrCK/4VSMaetiu0LLQ1woqMe
 Pd6keD7jND0/OvMEzVa09c1j11WlbFhHcxHrj7b3CHY0GMPkFFFD8NY/7QBf0nX5amaj
 KzJSXAK4DvbPa25zBLM63OCXJersqs08YnMZ3kk0hrCJbWrzlftMIu50Ag/7EJfZsAPp
 topA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728330658; x=1728935458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8TV8fYpF9eRG/D4gP+z3UnjvyTtJ/hBE8IkNgFDQB8=;
 b=kauQ289XB+MQTEwGbMsT5kBgpP4MX0SPvF+ofoYi0elbLawlTvuqqMpFKwSmfAgyiJ
 yt22jdJeA8Ufcyrz5dypApsSLsWcst0QYorQCnmyyoEG5M1bM6q2FgmBicqLNCkwpxD6
 6HtFSPURX/UIZgYZpcGb7LFnWXyfw87AWsnuIPanVoS1q+1k8wRCIIjy9PQk2IA60SOE
 EpMMEh6t48+6uMkZYDsQX9Ce494ATNzuWXfh1kNd81t6uU9pKce1XLPvLIdcfD5PtiXv
 pnwENFxL+GYRr0MCWXHJeznnTAE7nk7wtImvX2CaQF/LTdEDfO63vDiFQuWqrmtzootV
 kmug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4V2cj9mnn7z9LgTnwzdRWiKwGKrG7XJCYAcImrS528iBMVuZJ0KCvZY23lOFTTVvSASTDShaNpdfj@nongnu.org
X-Gm-Message-State: AOJu0YzpzyQ0Vz+K7G0hg0pY/YK2VmueUH1btqIGYNYVES/pW467xR3b
 XCk49loOtmtiTjbonDSRO9YmUBooU7o/FkIKDetx4FhqigwSgfCEVfbYJpbHU7k=
X-Google-Smtp-Source: AGHT+IFycNog1j3UBj6b3w1bJOhoI111/pUDnd5pUDMugLXE35Q/lZ8qeboZw3NlJXRH/sGowQ4VWQ==
X-Received: by 2002:a05:6808:1b8c:b0:3e2:a1fe:f0c6 with SMTP id
 5614622812f47-3e3c131703bmr11385332b6e.6.1728330658252; 
 Mon, 07 Oct 2024 12:50:58 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f680c3a9sm5359598a12.7.2024.10.07.12.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 12:50:57 -0700 (PDT)
Message-ID: <858e948e-a1df-44bc-afd8-48df3d0d6d3e@linaro.org>
Date: Mon, 7 Oct 2024 16:50:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] linux-user: Correct print_sockaddr() format
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
 <20241005233343.503426-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005233343.503426-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-oi1-x232.google.com
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

On 5/10/24 20:33, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> When the %addr argument can not be accessed, a double comma
> is logged (the final qemu_log call prepend a comma).  Move
> the comma from the final qemu_log to the preceeding switch
> cases that had omitted it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20240807124306.52903-2-philmd@linaro.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> [rth: Move comma into the various switch cases.]

Thanks!

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/strace.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


