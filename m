Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3B8C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BFf-00047f-1t; Wed, 15 May 2024 05:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7BFa-0003l8-30
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:48:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7BFY-0003ad-Fd
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:48:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34ddc9fe497so4138106f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766519; x=1716371319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bwDmf06pcSMv31kgM5n8pjeZgLxFisSiDJ6rGX6CzQo=;
 b=qnQb58ylWe9OsTizUFOLZOmdmNWtY8ZlAN1DTiP3WJ/mmfj1oTI5jZsOem7JXGNJYs
 UVahguyYnyvXnMIefsWVP0KzTZmR4g5KAJSQ7Fhp7ly1qrJbsgx+tHg8XhvTkGFEEctc
 E/zgEZYmepQvhmqtt5Y8CUgb1lY4LPRD0tFWAtX/K0oqEMwqKIIpsYrzI6iAll5WV4MJ
 gVN9MUM37FblAY98JJbiOqWW0nYm/HCnHkbf4Uee8DnmIcOWgkN+WZJ60BE+x8j19/Kk
 XONKy7FRK34gjXYyD56OW4ApkfYPNa3XpGs7yaLSGFC5s4J2JtvpCeeyR73RS6SBbi46
 sefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766519; x=1716371319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bwDmf06pcSMv31kgM5n8pjeZgLxFisSiDJ6rGX6CzQo=;
 b=LrNqA9Qe6RpRaga7dS0e3U37+JgcglT7iVcqiEP+4Dav4J/MP8oUPhyzGgjNzJjS4e
 wzcAF7Q4xUpK6Nct+ZPbUyjXXDlbBMxBWVD8e9cDSq+ohzkxkbXtpzZAcOtjfBNm1CBM
 srDEP1l8i6MBY1GtcYZ2kninZxOM4A1UxVW47PBG6ql+SUozlGTPP+S2HKA8PWj4Z+jZ
 ViSY5fZoO9QL+EazttTOEIcj/CF2C1LIPNlpqhsZd5jJZNTVkHQZwRdA5taHTV9flth0
 vZi/oX+uv3Yx+n83ScLFK5wAYpL+rGSEnDDpXf7yk9mRczK7BXzLqGoD2+JlT+6YQxXS
 xQDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZvC8ZMS6JMvWoRtCPNvHPjVVUzTNwE9xQMANx/ZzQcmkuP2gD0KPt81rWmQ4GE13PHNxTszaO1klf08Pu1JOZnX0WOss=
X-Gm-Message-State: AOJu0Yzu9j3/bsClgeFI06wcAkRXeBF0X2XSzBbkGqoc3OKLmEQGiRzW
 3yZKmfvsdqAWM0I01YNp5zXVZ+Ll2lDpxCOFMIvMdDtRGna5e3B+1ccRRKWq28E=
X-Google-Smtp-Source: AGHT+IHUFiRL2zN9WIajlZRibYWfE+iDbmrGCNyaJ8tAJxvMeXjlh6cpqSxFreT20ELYQG+1tMHy+A==
X-Received: by 2002:a5d:6952:0:b0:34d:b40e:e65d with SMTP id
 ffacd0b85a97d-3504a739495mr14907190f8f.42.1715766519081; 
 Wed, 15 May 2024 02:48:39 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbff7sm15966916f8f.101.2024.05.15.02.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:48:38 -0700 (PDT)
Message-ID: <e7b9ebdd-cdc4-4d5f-b7f7-2c6e6073e0ff@linaro.org>
Date: Wed, 15 May 2024 11:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] plugins: add new inline op STORE_U64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
 <20240514174253.694591-6-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240514174253.694591-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 14/5/24 19:42, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> This new operation can store an immediate u64 value to a given
> scoreboard.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240502211522.346467-4-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/plugin.h      |  1 +
>   include/qemu/qemu-plugin.h |  4 ++--
>   accel/tcg/plugin-gen.c     | 13 +++++++++++++
>   plugins/core.c             |  6 ++++++
>   4 files changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


