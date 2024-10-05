Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305CECF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtMt-00051n-VS; Fri, 04 Oct 2024 21:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtMr-0004z5-UX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:13:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtMp-0004es-B4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:13:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b5fb2e89dso21557095ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728090834; x=1728695634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sJ1Dh7z63OftbtZfM6eo6IFEN+hFT/W9OWq+72G4btU=;
 b=q7Gdt9wonMRWX6LHKv+/cAkl1M+q9trr+be13filmZy0e+EsFyi9XTsXHYGTu+jT/2
 gMndVjcN6DUAcdhvUKkv0jdcKZc4ye1JQNFoPIq+J5AhREbmmVsLEUIglyBvp7PBZjcU
 imUToxrDNslsBYVtgdoxLTUKz/dldNb7nkD6p8oL5VG1kF5xZKIwdTsb5k0TpNfaCyqL
 EqcIDJyHEt55LbdR45byawrUEtKuZ6f/OuhweJUlY+ImkjVVvpZn6FaKGtVonZWRppeX
 iZVmy/h+nmdc5Ujxo5PmY0208Rms8WK9/S2avaIyaq/8XG5yELh2PBK2uMXvQpu843Yk
 14Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728090834; x=1728695634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sJ1Dh7z63OftbtZfM6eo6IFEN+hFT/W9OWq+72G4btU=;
 b=DsFLD0BnK5m208SvGRgVkGPPT+YlCdJSSizr02KcPXZ3euG0kZiUhKwp+hlDW9Q7OV
 /fs8GtQRrYg3JTW42L5PWRcbBiICpV6UVnB97SwbgHJQTKvxZPRiRUwZ1XjPS80u22iq
 VHTBpl3NwWR4Fdjy9YJYkY3XM1/hg/Moptw67kxmH1oArhOdufU6XNT6B0C3ngxqYfcF
 SBXToaWoXrC54+cpVQptzqpF5SnP4N8fVrxV2m4kUJmdy6zAYQV7pg1CaGqxlHH6bfUN
 5zUUAGnEdPJD+5KJ17lPmLEmUADZKpyrVLYT6AbfmPRy3pZd/kQ9wX6T5DiMP3GkLBuc
 ofEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIkjMmUD9bIs1FemcqcuPQjUL52vY/8reb6IAtcjf+cx8ZsA7tWZl8iqdQ5EWgkIbyiPIkOmuju9r4@nongnu.org
X-Gm-Message-State: AOJu0YzMUA+4Jec96GPJro1KJMEKyCqx4l6Y0HDRpYLAFZ0jBcF/WhYQ
 hlx7b8C232sLNgWOa8vSJd1Gx8/XUYlZq3hB9NP8EJPXul5GkLgRlEqlgUHriW0=
X-Google-Smtp-Source: AGHT+IF+5UKk8aH1WkybHm3dvfp0flgGhSOeV0uXQetvScXqhaLMyhZf/Fm1Df2uu7pxz2gB/Pbyjw==
X-Received: by 2002:a17:903:40c4:b0:20b:920e:8fd3 with SMTP id
 d9443c01a7336-20bff041298mr51764205ad.35.1728090833991; 
 Fri, 04 Oct 2024 18:13:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13989814sm4328735ad.269.2024.10.04.18.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:13:53 -0700 (PDT)
Message-ID: <db2e0c31-bfc6-46a4-a01f-20d78838906e@linaro.org>
Date: Fri, 4 Oct 2024 18:13:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] target/alpha: Use explicit little-endian LD/ST
 API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The Alpha architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/alpha/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/alpha/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

