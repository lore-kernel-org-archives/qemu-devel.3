Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D613DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 20:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIGI-0004cK-2G; Thu, 06 Mar 2025 15:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIGC-0004ZX-Ra
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 15:56:06 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIG5-0007Yk-Rm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 15:56:04 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c08fc20194so195522685a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741294554; x=1741899354; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ce78uTw4XydzmwR8Qs9IGggWm8NijvyiiHpS7HO3EiI=;
 b=lSMPdOLW6iYHsrEtURiGuTx27Um8s46qZXQmI1bF7oD2cUKQbO+rjx0uNcxl79E9Bx
 L4SyfSkI/Anh5ldSc/BY/t4Y9b6QPbq/RVibI84fdYb4MTMqslPFWvAZtPjlOwZqEJ/1
 8p+T/JIhBpxuZm8r1y6LshGLbPxHCv49+uHKmPU9lOGQbAWQ32EKwfz95wXaOduVN8Vr
 6Voy2HRAHmF/jPYXxpWvWP7lEMJNtvB5K5v/m+apBzta6qyZwAlw6siEbS/R2fvBgEoU
 OA90ZerCRr/nW4g8QTvUpU3TiuT9I7tdFsCJsGKHHpMC70721SCvpkpBEJp33wBY+diC
 VkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741294554; x=1741899354;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ce78uTw4XydzmwR8Qs9IGggWm8NijvyiiHpS7HO3EiI=;
 b=K5mVWQJ7EZEJE+T41YMn8b2KJQGdormZevln5DePJrLTrIcRmJmYUeysj35oQ/6ZCb
 RTok/rPLphXCYChivrsrQvPJBQDdUNxS1XgNpANCt0HYaehGuCG7wzMl4NRNzqIm75jS
 8ghn+4U4ZZKmgeWzEw0s8goXcqwQqwXJC5BDFY35pNm5mzP3HKXMlCXJTsVlts42yBJK
 eGNDTc9LY6uKoByMVVW2LAzgjHvC0THW9XMczesTPfRgwsBGq232fK2KELoLRaIle/i0
 23CBYcpLwRyQsOd/AZSQd4oGYbI4BvYnflUU5Fds3wQTgPSYUzMdaLlvdhPzgwtLWvce
 akUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2fRgCw2xj/VNlpIa+P4bCcCi9IpdxrEeZ0C9vOSxpoHoUf6tnkJvHy861cEmZ00jJLHITYFZFVwoP@nongnu.org
X-Gm-Message-State: AOJu0YwdWzRR4URjq5MZVcM3IzDIJJ2j9DsWPvVZRRdb3eMFoZgkEiW8
 kwIPZ/j8VznRidQL6/ptsPYxRFoBIfsng2kjXQx0n253icXrj9do
X-Gm-Gg: ASbGnctPkL93qbDxprcG/pbsevBRerE3NP6l2FRhnT1n3hmWWuass8Rs9++B+u2P0JP
 yVRTMbVX0D2GXPLk7eXmh28CHDs05W1jOP+In+uSWPaw1CcZezJeVAqngCgWewd8pz35YTnIP7M
 Gxvksja1tIwK7rbVjtNWtYB4solltq4JbH6W0OWwxeWbpJl5vB4vcirHNPArZTfC0zgEkZULyHa
 jHAr8DObsWjBVnhhmRSTZFiiKe0tVqaSNvUkZCjz8ObXUdutqIKHztBnhjbrnSw5iPSWQkv7IIf
 TnhOoaICys6kYRptM1Um75iQnM1qn8c7YO66yOKShrMaxNG4hHOeBajWmYrFmjM=
X-Google-Smtp-Source: AGHT+IH7GGFUXGqtnFWw9s6eDEN9nNvWYurhasf8L4slUWB77avTBKvZL4CIe2aMimggSi5sslAfKw==
X-Received: by 2002:a05:620a:6a87:b0:7c3:ccc8:991d with SMTP id
 af79cd13be357-7c4e168ca63mr96052885a.22.1741294554484; 
 Thu, 06 Mar 2025 12:55:54 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e5339b83sm136739085a.1.2025.03.06.12.55.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 12:55:54 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-5-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 04/38] target/hexagon: Make gen_exception_end_tb non-static
Date: Thu, 6 Mar 2025 14:55:52 -0600
Message-ID: <022a01db8eda$26d21b00$74765100$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgISzbNvtOpdqBA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 04/38] target/hexagon: Make gen_exception_end_tb non-
> static
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



