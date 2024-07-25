Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F13CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWx7d-0003b5-AS; Thu, 25 Jul 2024 07:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx7X-00038j-Az
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:58:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx7V-0006Wf-C2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:58:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so5876435e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908731; x=1722513531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NRLR+5V6b6XMBXjA9GnVWntzKIjZB9UfCVpwzPPLvAA=;
 b=qYCt7wX9phi/duZNL6hCbDxt/qRLFu2HAkpFIWU80/GZqB5aq0zvmw3HijDKTVvfD4
 9qRW4OfIGmZaBu0y22Wew+w3mR5qZFC9YRps3qUUVd7wcsVZugjnXR+yg+5M9sByel87
 fruauTq9jmcVCrBqdNHbCBBKVYSM1rP0sybnwtCaFnD/f9P3Ty7rDbPyvtPcSmTbwqv1
 0CUym09qpiQncFlubybbdsFVgNIadJHfe3m+v0qWs6jDjygt+JVVM+TW2visFyAQ4sAs
 n8RGkhofMwZKfnW3IrwxPupmEDn2jfASTnyLe2vA1djNfoO6CozuG/x01J0XLqOeMaKt
 sbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908731; x=1722513531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRLR+5V6b6XMBXjA9GnVWntzKIjZB9UfCVpwzPPLvAA=;
 b=feOv2QQTpBIUsN4jsYskV3HVPpCvXAxA/+uB4x/S3m+F1fhm45nwgvCnQ8ERgd9UkU
 GRO1vXkmyqJ6dRzkH6fbYHpRJS8volH1nbt2TTa2FSQL1HkNccFb+FwSbfP3fBFdw7MK
 xGcmsHXcl4zfq2b8jCj4HHRUpJEVShvqJxjAVSEO5aP82HltHiqE+9XEM+UHPX4XxSCM
 L7AQKxtxAMq+z433RTau9cImH+mS7APFhEd48G9XtBJhvo4foj2X1cTv5hfjHFM8m02B
 CVewhWKrDW3oIQzdUyFH3yCcvlPPKeHv68ILGVsgPq0RoKtrSoRAAm4KScVwmln93yZR
 ry0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDUEIbWHW6DzKewRBncjcJksr0r4W/bVrtKF3MrVjxnbzn7LdQmEc+dKxwr+lfmg0h7mG3hH8QyNym9ZUGGbn7SL5YmDw=
X-Gm-Message-State: AOJu0YzTSxYh96ZDGScyA4RUMtf1eUerTSWlCq9LLj6G+XoO81wchyu7
 vFr3+SxIGJk6nTUnDD0Fe3jycYE6UeleQgsIt0zSliLt7GGnNAxN4XksqWRTD0w=
X-Google-Smtp-Source: AGHT+IEnKrncsvSd4yRNRJ/PdAF8JVmDvTJm/XgeTOdHpP1oy35oDwEMNoXx8IkBUdeuOnyao2T69A==
X-Received: by 2002:a05:600c:46d4:b0:426:6960:34ac with SMTP id
 5b1f17b1804b1-42806bedd4emr11598775e9.36.1721908731139; 
 Thu, 25 Jul 2024 04:58:51 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93592b6sm75950485e9.3.2024.07.25.04.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:58:50 -0700 (PDT)
Message-ID: <5c882618-d977-4531-9f4a-ed1ae7d130df@linaro.org>
Date: Thu, 25 Jul 2024 13:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/23] tests/Makefile.include: Increase the level of
 indentation in the help text
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-4-thuth@redhat.com>
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

On 24/7/24 19:52, Thomas Huth wrote:
> The next patch is going to add some entries that need more space between
> the command and the help text, so let's increase the indentation here
> first.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


