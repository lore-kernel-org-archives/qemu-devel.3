Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19804C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThWL-0007Nh-FR; Tue, 16 Jul 2024 08:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sThWH-0007M7-7z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:43:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sThWE-0003Cx-7G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:43:00 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so3345583a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721133776; x=1721738576; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBKhieTfpFAHTsjnbaFrzTTNSVsaLXvtM3nLXTw8r7Y=;
 b=mZh5IYmlBkChxiWPg0jdPb5+8Mkd9ed0PIc2ZSPxL1tP1uNvvzzHpAZu7X82rpsYr6
 j/bOXPRBma8Dr5F6n8otFh6jC3eUM8EZhyyhkRmAKP6nFJ2Fy+TCJc/25e731jzKIxUd
 u2b5OM6cc7aNF8AWIjSBfn0VZOZ01mJJjkOKlxibdV7qATWenzzmrRlv1Tj2WBdv0MMY
 TDAFHn9WOE69IWhMA7hJ61MceDR38vb5B7o8bsodMD7G6dxjkhlbo/bd0eaY+rr6uwP8
 E7B5WIZdq30WUJhVWyVcHuNZJul23IthZSkO5aF3+/nlGuAg+LVfuFdEaf9g5pLeN4v4
 /d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721133776; x=1721738576;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBKhieTfpFAHTsjnbaFrzTTNSVsaLXvtM3nLXTw8r7Y=;
 b=YOASGz2b0tUqLgmu/sxqVdYcSxaRG8l6W56oPuwK4Bbebywfy9QyI9mugQ7EZlXivC
 Zv8LDKAy1KPcYONXYqprOsx8/x06E5RebZlsoDK3i8ir1Aa3B2mqGLy+t0LtjorbOdrq
 rbxHtm7+5NoCRSxV5u62bwuWxaCRvZtND+/7VmqlAsXP67HVf1uVVrQh2gn6Jj/qmo9w
 kGoCar9DXIG7Al3YbaIodQkHa+J120qRIwyyXZmkuwzeSSJpGQ/Y9ybGDJVaTP/hbcrT
 +6MeKJrCOtpiBvqwU6ayjVE1BMsJTYJ9FeG1o6uChf7EZ1ZLyYz/d/VO6fF4vBa0q8Cl
 uTrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoagOJa1iMjGd60JPVwo7OkQ+W8xf76gVm4Cli4tnF7tI+QoKF9wW/usILhhWWkTbtPRQEFmLsMhOlw0Pf3XOtojgeBa0=
X-Gm-Message-State: AOJu0YwDpTN3Xr/x/ubnY1BfEA0xBkzwsZlwh9Vzk1zgLnH4zD/Yjn2c
 vJKdMlSdaHSlIxo1KvNHfdMNHaI6swyTO+kmwuO32DdBWt6mP15c+LTPlL1UN7E=
X-Google-Smtp-Source: AGHT+IFNB5QEj84aXPWCUWFi+7nkU9tR4WTy8SVIIZUMRcrtlZHmDEwkNIlWWDLleO/20pChjxuDuA==
X-Received: by 2002:a05:6a20:7286:b0:1b5:d063:339e with SMTP id
 adf61e73a8af0-1c3f123a5cdmr2225247637.23.1721133776047; 
 Tue, 16 Jul 2024 05:42:56 -0700 (PDT)
Received: from [192.168.0.102] (201-1-50-128.dsl.telesp.net.br. [201.1.50.128])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc2634fsm57506685ad.127.2024.07.16.05.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:42:55 -0700 (PDT)
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20240716114229.329355-1-alex.bennee@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <b9690162-170e-1f74-f148-0642a8503002@linaro.org>
Date: Tue, 16 Jul 2024 09:42:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240716114229.329355-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.356,
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

Hi Alex,

On 7/16/24 8:42 AM, Alex Bennée wrote:
> Coverity reported a memory leak (CID 1549757) in this code and its
> admittedly rather clumsy handling of extending the command table.
> Instead of handing over a full array of the commands lets use the
> lighter weight GPtrArray and simply test for the presence of each
> entry as we go. This avoids complications of transferring ownership of
> arrays and keeps the final command entries as static entries in the
> target code.
How did you run Coverity to find the leak? I'm wondering what's the
quickest way to check it next time.


> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

