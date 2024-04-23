Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 07:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzAYE-0001G2-HT; Tue, 23 Apr 2024 03:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rzAY4-0001FM-8o
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:26:40 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rzAY2-0004Be-Hv
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:26:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a52582ecde4so475892566b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713857195; x=1714461995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JjHsKBL8n2LErvbnpg4RZ8oCNUO69GkcqgjN6JTysII=;
 b=gCU5mdsJqX9E0tjPtObG4g9oDrLU3DAv/5YAmOnePK3VMzK2Tmpxs7JZYS9S25q9me
 zpoQBZKs1eBpFLfS7ly0kt/FghzHda3ahZ0fK6E8mL4oJud8S2mHhRL2W7AJd2eMequw
 LVWPJ0/0BFx/p4udNJqPwYp20WhncD+KPo4GqLZrsljhanfAvl7kuu1OK7qZmkJOGEl3
 UmB1NaBN4sRoVBGWE38LvrHz9Ahs+6DEFnL/sYIK4ikMI0AXSCPP52t/XOnhRnaTkcu1
 ID0lsVp9WuSQBhaIkQXKnHrCUJtbjXYDjO81/B5W56vh9ioKaWNHxgxTnmz7pw1hY/Dr
 MYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713857195; x=1714461995;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjHsKBL8n2LErvbnpg4RZ8oCNUO69GkcqgjN6JTysII=;
 b=gqKuHY6HhHK2bf4Ceq+VkZUi0BlvOs5RKBq3zB0/2LCQisGlXpvEaDIymIhxhavJ9d
 BOdzTXbc7SqW7o7qvYKK3i2kbrsekwYPHfz2h3FHZmxAxhPXBGqYXPzTh6/R1L4Mni7V
 Lh/UozgEq5Tji7QJcP2HiZtGBF7cOSkqUVl0gA4b65aErsy8/7pItCoIYTyRXNoLGBCF
 oWLTdRhNQd9fxlXS6V+qgPC5wlACQJAWJiM2KRzLyOi0vfdk5IYuyue1OKDKeORaMcXO
 JomSFb7sU6F5MdRIl7TvQl/pXnlUdm/KKyxR1FVY85wP/BF1j/QyIQPWolYcb8SV8QYq
 8MUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9LCt7A52d9yMq3Wa4LVWFGR3WcuCOfnFWzkhjIuSP3a8CPi+O07hQv5cxM93ylHzBZztHqREjytkn9PFc8e/kZZwCNN4=
X-Gm-Message-State: AOJu0YzYq8TGpQBDWjCMcuxjgm3AzKwmCbVSNP3ZFEJkAyBumvZkXnWx
 JVLaRP3vGjEB9VR8upR0ihmV705KdcIVojaa0ymgNCPRFxabbShAS+PqoMbwk4A=
X-Google-Smtp-Source: AGHT+IF4Dmw6/Zpg+rReYd3xA0rs/zzDOToIk15bMFTmX4t8i/b6auiBC5s3YO0vOFxLjrz2NEeIyQ==
X-Received: by 2002:a17:906:c105:b0:a55:aeb5:b9da with SMTP id
 do5-20020a170906c10500b00a55aeb5b9damr6347737ejc.20.1713857195630; 
 Tue, 23 Apr 2024 00:26:35 -0700 (PDT)
Received: from [192.168.200.106] (83.11.0.31.ipv4.supernova.orange.pl.
 [83.11.0.31]) by smtp.gmail.com with ESMTPSA id
 18-20020a170906309200b00a523b03a1edsm6632896ejv.20.2024.04.23.00.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 00:26:35 -0700 (PDT)
Message-ID: <fed57e7a-9ad0-400c-9d2a-4b90d09f1941@linaro.org>
Date: Tue, 23 Apr 2024 09:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
 <c84bfac7-5fb5-4fca-90a3-93adb40bcf3c@linaro.org>
 <CAFEAcA_PWyu=ca-S=qwePDdGqjX95k3oQ+BJUZc541YEyV7i2w@mail.gmail.com>
 <fa0465a4-6604-4ec3-af45-2d329ca513fa@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <fa0465a4-6604-4ec3-af45-2d329ca513fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x633.google.com
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

W dniu 22.04.2024 o 17:37, Marcin Juszkiewicz pisze:
>> It also seems to be hardcoded in TF-A's support for the virt
>> board too, annoyingly.
> 
> I looked at it and it seems that TF-A can just read what is in 
> CNTFRQ_EL0 instead of hardcoding the value.
> 
> Submitted patch:
> 
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/28313
> refactor(qemu): do not hardcode counter frequency [NEW]

Change is now merged.

