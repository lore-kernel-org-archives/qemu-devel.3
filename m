Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A209FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 11:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sckRT-00048j-F4; Sat, 10 Aug 2024 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sckRP-0003xp-8t
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 07:39:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sckRN-0006Lu-GY
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 07:39:22 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc4fcbb131so22157415ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723289960; x=1723894760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97gdUpKL57nW9OdBVqnM5Q8FJLj7PRyyq0Kl78FnOSc=;
 b=TFGh08+MYSlQU1yrf9vBbbgNQgrIwY1oscV0FHJGKGO4BOdydOg4FCMojAlzmhEY7F
 Tz/zUVPRS7T6Askjv671a/hqssl3qxbhxUdVC9l911wvzr/JSAljWJHTn79Mja++ZA4b
 /uU6M3UeGPZWqENkg0DUn1vdcCsGTZ/lAnlDKHNZkKF0cZgh9wolCvtmn5aXmPz9g7Ip
 6EEf6vk0o5OpHoQoPEIktz/WAMD4dVpgYhcAQzGRS38ry1/kUN9RFt+Fx1mibXmlB4mB
 KiwBnE2GAxF96SYtE2EWzE7ljaIMj4iivPduelSfX5oB9MZHdYCzFK5C1TJTI2veXQzF
 UUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723289960; x=1723894760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97gdUpKL57nW9OdBVqnM5Q8FJLj7PRyyq0Kl78FnOSc=;
 b=MKC1Ymw+/DvRU5W0MMfbew//gVB2hFqN/Av6nNI7FsCt9thOfRHDzlcImL2ttBY2ZY
 QGY3Y0MJ7qCBP/qqgasDud3VTBrOQpq0n9wrRLB8TUK7E4NxptYtsm+fOO3YL6dCZ+XO
 /Thx1OP6vAkz/B5GiSHWdrj7/hTXcEWyHzNDPtzBt5q+fdnapN9Lm/NssV+LIr9qesAn
 zB2UOOdhmJzxgD1wRJja+wgl4f3FHDdfArQ7xXt9oFvV0yCaf9kvDFH/4f4+U5DD4SLZ
 36dhmuakoyOYKXgOFDxN4J7owifeEfxycEuSr2CwiVWtuOYtmYnhlfPerosBQN+AsaMg
 DZOg==
X-Gm-Message-State: AOJu0YzYp1JlYYq8WaGCtM1SlJdB3HHmvQWU9XopXBYU2pM34bzpZ6zw
 nA0GaXgKNPX9IiUeMXdSWJ0vYyQS5vUSi84qrxwFR1VLvCYaXVTo9Kkc3sSAem7sWf0rWNOZbIa
 bVWc=
X-Google-Smtp-Source: AGHT+IGeyoDHwnPOnQXZ+Rwf1lhPMGOso2dSkUjKGexwRwfwlAVanYUEA4cFbAZBEoz6Cqi70VwTCQ==
X-Received: by 2002:a17:902:ec85:b0:1fb:715d:df83 with SMTP id
 d9443c01a7336-200ae4b1983mr59898595ad.13.1723289959823; 
 Sat, 10 Aug 2024 04:39:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bbb3ba29sm10378805ad.250.2024.08.10.04.39.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 04:39:18 -0700 (PDT)
Message-ID: <a25d9b40-78c2-4936-9203-1137a48bb63a@linaro.org>
Date: Sat, 10 Aug 2024 21:39:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] NBD: fix CVE-2024-7409 for 9.1
To: qemu-devel@nongnu.org
References: <20240808215529.1065336-7-eblake@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240808215529.1065336-7-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/9/24 07:53, Eric Blake wrote:
> The following changes since commit 75c7f574035622798e9361a942bdfbb0af930f0e:
> 
>    Merge tag 'pull-hex-20240807' ofhttps://github.com/quic/qemu into staging (2024-08-08 16:08:18 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-08-08
> 
> for you to fetch changes up to 3e7ef738c8462c45043a1d39f702a0990406a3b3:
> 
>    nbd/server: CVE-2024-7409: Close stray clients at server-stop (2024-08-08 16:34:04 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2024-08-08
> 
> - plug CVE-2024-7409, a DoS attack exploiting nbd-server-stop

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

