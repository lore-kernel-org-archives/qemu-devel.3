Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427ACEE01E7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7iD-0005nj-MR; Tue, 10 Sep 2024 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so7iB-0005iy-WA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:43:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so7i8-0006kH-Qo
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:43:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20551e2f1f8so60193805ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726001019; x=1726605819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gCIipsKGlQj4vWhp7h0RMzFJTjiXKRe5Pj9+sM+XA8o=;
 b=oFY8HBjiBDNLyVMtyT3Zg9y6PRX/M9W5EfSo7NK1JurxUIH9R6G/6XtDivkaY++3oJ
 l46zzVQeegX7O1QRVet6YmEmJTLGQONh5Cv1rbRoou3HNFwNuUFNIIMoq5TqnKnET7fJ
 dnGkQ9SVRz904YmrlYITIediV6UwgyTR140jiFL3pizYCX211ygt5RUuwsGte+rAQu44
 Lqz14JHIIXKxjdnylnsb2fVZqp64zdjacUkJAO+feAGL0kX1VTPZyW8MuzNPIbZN0niF
 m3CXTQ05Vi3Ox36glnOuyv9xc+i7xzFEWDaBW6obxil8f7HeHemiOqsvWsAcV6WD+8sM
 TUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726001019; x=1726605819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCIipsKGlQj4vWhp7h0RMzFJTjiXKRe5Pj9+sM+XA8o=;
 b=Yz2v5onjalCCwkonw4bZUB/QyH24A2hyRvwNJhgOlvcUl+AtZaAsHjs1OEP200eQfs
 4sARDSvOFZBa23/x0Mret47RdcDX6BLc+5DoXJWa0pPl1MpeBXq27uUuOfUjh5j83s0J
 50DwIWy009d1UgXC0WaeEFS/iUMqcTc11BzddEV5yszUcy1jNDN8OaNtKMR7WAZueq4s
 wF4YdKELCJ/9yVf8fQf0e2FuhycRycPDZ0jC55GyXVhGi2jXp+rqTxPczT86kIxn20Av
 G29r+crB3nMeHLCoG1ri4kYa8MTOItIrmkHSFOgNT0ZSRGw4Pl1RMN9Vv6tjs4054xIN
 5fsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWbqYndpgSMr8R22RnUessOM7497BB4mr6E31+SrkcDQYXmHDeYkrkLIMUDvjEKiYFIq+HFPl5fBpP@nongnu.org
X-Gm-Message-State: AOJu0YxTv2Rg9AcH6JpwhES8SD+PNR0dRczXOPpy7zWMGaMKj3Zro/Xn
 +zAmf4egW+bX7VNEE325muusTIY7cI4S0NdY5XKiEee2wYZ3yBPxmBkTe1jX200=
X-Google-Smtp-Source: AGHT+IGCa/9T3cK16Xc8/dg3EOzyXOBXkOYf9TwbgnJbcJVwJwXtZ3tGyVcdQ9soxh5PFl8RnO5KAQ==
X-Received: by 2002:a17:903:32c4:b0:1fb:57e7:5bb4 with SMTP id
 d9443c01a7336-2074c70eaadmr25872975ad.37.1726001018951; 
 Tue, 10 Sep 2024 13:43:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f20bddsm52464125ad.232.2024.09.10.13.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 13:43:38 -0700 (PDT)
Message-ID: <8a2c78d0-d5e8-466c-9c93-eabfcc5944b6@linaro.org>
Date: Tue, 10 Sep 2024 13:43:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] tests/docker: use debian-all-test-cross for
 mips64el tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
 <20240910173900.4154726-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910173900.4154726-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 9/10/24 10:38, Alex Bennée wrote:
> While the mips64el cross compilation environment is busted in Debian
> we can use the debian-all-test-cross image for building TCG tests like
> we do in the CI.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

