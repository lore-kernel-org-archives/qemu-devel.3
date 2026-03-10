Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CD0EB1060
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzz36-0001aD-OK; Tue, 10 Mar 2026 11:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzz2t-0001UB-W8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:30:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzz2r-0005An-BB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:30:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso21471155e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773156649; x=1773761449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOUbUvKw9rUBdkf5MYN70J4wl1FNzo77ifUxMf+0les=;
 b=hmULES99nt6/kmwh75Q4huxOk2bNQfsZ+VSFw3u5CToyYY1dWhukbeyg3NrfDWDSkC
 vDR7I35rb9RfffuZ+39e5ncaACGyvZyNBOu7icvVd1zi64QLz9Gd5UHa2lNJarZS2F//
 3ESHvZ+97rOblnrG/W0FQ7dn/nVvpob0XEBIeM1Hs0Ys9mAqdYBsDOBC1x0X021Sl8sE
 +8nHTg0AThJc1pM7GJMn/MFogyzrlM2dgbzhWXnzAyTwKaN5wDkJO++E9UQ6REBo7niM
 8uprlplM8SsFwErbZS09kwG4bVRI+3rFCAdeO/FrMMmMmabar5zl6pS5famRypUjgji0
 uSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156649; x=1773761449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOUbUvKw9rUBdkf5MYN70J4wl1FNzo77ifUxMf+0les=;
 b=c5+Jg+FGW1Gh6vuzEvBk1PB2EHYP5VMYD0eD0ggAzVqVH5BKWG90ijX5xcd9ihSmed
 MjBYZYx0YLc4h6x4FAtn4bjERmxUdi+eXLyI8IAWiNpZ+hcT+wuMcUUV+EivnseJVXnj
 Wv74BlAemEdIG3psn20iDNAIo2js+uoscJ1+bkNtmkLFzkG07e11l+6R4kbsR0XowmZD
 +vtxggZ0IQlQjjdrsalm35cMZuh7de327gIk9Z5ZuW5zzCzZENfiHt5tTpzozVeuJbqj
 7O1LoPWKk+MI91hKi3PexWcESzsY28iPjA//rScofjc9rhX7ghnf79uShhfjYHQRncA6
 DsGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWICpE/cOHToVXQU/kepYCDZIa95/z1GQo+xcWKmW2QFqPI0qjQ3rEtXgNcXoNrHU9XinK05jw5wB8g@nongnu.org
X-Gm-Message-State: AOJu0YzQO27eJttcGtZnvHBDDfdjyJHDiUJa3R2zPMuYmZr9i+QfqVgs
 M7juYrP8Fl4WxuNgwPx03XmDd1sIi+njOLpoEZ2eZPbjqynr3AOkMV7cQbtz8p/CBdQ=
X-Gm-Gg: ATEYQzzgN5iUxIMxiTLcsBYP9XRW1YZWmYr9r/Z8zWpQx5T/yZMwCy4wt0CpaSNTkLB
 W4fnNzW54LfeeeQzkmokrInKVFpkY4+ifqWgWJa0MU4Sa+Rl/BKGopoBfvkOXiquD0Ir92G6e0d
 iJ9fJJj4I8QmtS0DAaw6tCOs04z8MNKf1OTRMMtggMWLeozKeYppZ4mdfKyHXjb4SsNShISbBwj
 mlGI9y4SLGqj8ox8duBPEcvGS8eccpAD6NoVrsCccmumH82Kr87dWGqXEzZDK2Nb0Inj1TZStko
 XPe1MRN3z1CJPjvW/QWNFZLwXAmAs0uxsC4EGDrMoP8NIp4OF4zifpsTwQjKkbjTpz0fxY//rWS
 +GVHNWJzIPr9hY7ZDIOdPiO01cQuES9vKCse29PIu9tHipWN5JQp898Ri3luZhtQ90Kvi+jOhmn
 bLlpyOHOqjMbEZHrfjSlaTjK7TVIoKwPGCx55hakhVHf9zl+YNe6saPvqIXQ74O/oUog==
X-Received: by 2002:a05:600c:a12:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-485269648fcmr238705985e9.23.1773156648803; 
 Tue, 10 Mar 2026 08:30:48 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73dasm196592165e9.2.2026.03.10.08.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 08:30:48 -0700 (PDT)
Message-ID: <26eb1310-4a84-4987-8a0e-1d798827e512@linaro.org>
Date: Tue, 10 Mar 2026 16:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest/arm-cpu-features: Use g_strdup_printf()
 instead of char arrays
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260310151507.2973843-1-peter.maydell@linaro.org>
 <20260310151507.2973843-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260310151507.2973843-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/3/26 16:15, Peter Maydell wrote:
> Older versions of gcc with -Wformat-overflow=2 don't like the usage of
> fixed size char arrays in this test; gcc 7.5.0 (SUSE Linux) says:
> 
> ../tests/qtest/arm-cpu-features.c: In function ‘test_query_cpu_model_expansion_kvm’:
> ../tests/qtest/arm-cpu-features.c:578:35: error: ‘%u’ directive writing
> between 1 and 10 bytes into a region of size 5
> [-Werror=format-overflow=]
> 
> These can't actually happen because of the limited size of the values
> being substituted in.  However rather than require readers to check
> whether the arrays really have been declared large enough, we prefer
> to use g_strdup_printf() for this kind of string work.
> 
> Reported-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/arm-cpu-features.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

