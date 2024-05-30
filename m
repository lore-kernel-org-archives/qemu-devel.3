Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E4BC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjpY-00021p-5A; Thu, 30 May 2024 13:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCjpW-00021P-5L
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:44:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCjpU-0001MJ-AW
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:44:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70231ac9093so900435b3a.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717091083; x=1717695883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZ7/RZ01yauRl2rPbl7bbrr7rIBzQwEb38UFMQeZkBI=;
 b=OvVFutij6Fih4sNHublhq00AkAm4OaQ/vvWts6gcO57YrdHTNUFpk8ubbDegTsNV02
 5MG+Sw/lJbZ6qMytwipbOSi5BnXZXZaS9pZbbfYQDLySDuF/wn8HpGAEhY2TpumkJIHL
 GBui9w5V6DL6lld3FjF69g6HGDOwicvg92VtU0Q2EZ4jtp3OExDiV4rBC8B1MsHEi0by
 XEbhTGhQpar1gMpmcyYoJG1cEZCyf3UhpUiPe1SQYq+SJdKf8MCfzLXqP8z71Z3zJs/Y
 0nyi3N0YSSwj1jgyNN77tAnQFABgIrtnfRbEIkueLwuKYB4Bww3AB0yO330ekmhcpqo9
 8BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717091083; x=1717695883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZ7/RZ01yauRl2rPbl7bbrr7rIBzQwEb38UFMQeZkBI=;
 b=rJyteoIhGMpRmVTBSbyMupVJlxZFZYrv4XDw/H/2IRqO3oVILUfvGVUsWXO0NfKqKo
 mI4AMItu9iedBW2GZKykl6bEsbquZBcZ0w23LwySihEkycThtChQQsv2AndrkdXlF4Qf
 fdM3NM/igsq6/EXqwHXg9dl0kGf/RKkj/BN0UFJIXupbaA6Tl9NRhJxm/SWczvLYTjb8
 axG7vRkE2G2jJBypRzvy3H0oMRMJG7PZNIlWUcPyA2GBU+ONnw5jS9PdVn3Q56Dtrg05
 HeM9cfPaNZB+c90j8E6kFDVjmHY9963+VPgB/9hc68avkjgx9xfp1UAmhHvnFhMstK4G
 lgXw==
X-Gm-Message-State: AOJu0Yyg8iWalk/FcK+8Ssnj4W653oJK4xYMuxY3rpF/rciilidTJm/0
 PCUYY45z+hj0T4gvU/FzsB80LUH8lyb81uoOFSDiWNm35Ew0/hkovldaWblV+mryvS5xZrmSysS
 n
X-Google-Smtp-Source: AGHT+IHyQCV8RErnFyfczmQjbmMm/yrMY6bwlNWsgLvCi+JqqGOPnRpvMJP1SNRkLg0gQvojgyfHXA==
X-Received: by 2002:a05:6a20:158c:b0:1af:8fa8:3126 with SMTP id
 adf61e73a8af0-1b2645175a2mr3408449637.6.1717091082735; 
 Thu, 30 May 2024 10:44:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632410859sm484515ad.272.2024.05.30.10.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 10:44:42 -0700 (PDT)
Message-ID: <2c8ffeca-ce1e-48bc-af82-6d2ad452d367@linaro.org>
Date: Thu, 30 May 2024 10:44:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RISU v2 06/13] risugen: Add sparc64 support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-7-richard.henderson@linaro.org>
 <CAFEAcA-5QQjbJN=JS5MQvL9405eJRsuo1myaAXfN_7p9Lemx9g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-5QQjbJN=JS5MQvL9405eJRsuo1myaAXfN_7p9Lemx9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/30/24 06:23, Peter Maydell wrote:
>> +sub open_asm($)
>> +{
>> +    my ($basename) = @_;
>> +    my $fname = $basename . ".s";
>> +    open(ASM, ">", $fname) or die "can't open $fname: $!";
>> +    select ASM;
> 
> I think that using Perl select like this is liable to be
> rather confusing, because it has "action at a distance"
> effects on every other print statement. I would prefer it
> if we passed in the filehandle to the print statements
> explicitly. (We can use a global if handing the filehandle
> around to all the functions is annoying.)

I think I tried that and something didn't work exporting or importing the variable.  My 
perl fu is weak, so I probably made some trivial error.


r~

