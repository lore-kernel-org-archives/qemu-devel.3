Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34759C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaE8-0000Sb-JN; Fri, 26 Jan 2024 23:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaE6-0000S8-P8
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:23:30 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaE5-0004qk-Bq
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:23:30 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-783045e88a6so119212685a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329408; x=1706934208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzY5yOTt6XS1uC0voPy/X1AB0IvdnucmA0r1jSD8bXY=;
 b=o+qcwZeZQc5GalnFaunLX/w4xF1C1+Z8CoY8gPYZKeSSHyk9mOghFEYUUxzi2GmycG
 mFnafX3s5gfollZD0Bv6kzYv1QIiESzKUVUJb5LdZgAn77rFvJJz0jXC4QIAojQxYHWK
 OJa382dGAaUDdPlf6qzDaWVfIq00xpoXM2WQMmOS+1+ADNZiVWn/AEu1ZIsvVCzuNuMi
 josOmpLiuHNM13Q/Z/WRDzTDEz6svo2niObY5T5IaIO5aLW671b1cd+ZV9ihKTTKZ1pv
 CmHcYF/2xuYEq1He5llsAPUx5giMlnsBWKc6DU4+wF5eQ9HNCPVdTNPYkPztYgNUj+6d
 mHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329408; x=1706934208;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wzY5yOTt6XS1uC0voPy/X1AB0IvdnucmA0r1jSD8bXY=;
 b=thkxmRyRw7jCKOHfJhikz4cO2wW3BnSqORBs8xWWFXTaraghr2ErS7aq8Ob9DTVFRD
 Of1KB71cbG7WfgcyyAAvwP+hMIkKyX0qCRW5Uvao+q3Q7PANa5prKN+jC3dwXZvnJrEw
 MlMm9CB6ddrMI9AewiYhN/4GFKk1zC2K5mOfp9v3MUBi6DDW2bS/ndS/ucqtDGKhiw3D
 snCz6v5hFqJzwQr/Zu5pBPNgbCodLGUOss7lk4X1AUvZ42eFiLuF6anrxcICWST1GZXr
 lJ3eWkalBw9W1PoXmeASsYOqZQwBnuKCUhi2ken30cLL+a18/MeIxX9rlx+vxHa0E9gA
 t+dw==
X-Gm-Message-State: AOJu0YwBspWD1jMwStUadZtuYtSJtbNJ1J95rgcwjLCD+Z45rnNlAkHE
 nqYT2nhbb4fieGYBSrRW4WIkbFoY157F1XIwmUaxGs99HMvaNVeMcwZBAlnuWpk=
X-Google-Smtp-Source: AGHT+IH4kKvgW6ilC6ooYEBc2QUa8RuKaMlohslYxgSikN6DvRrL2BGwqyzTEAY2vwbEUXBZcGAJ7w==
X-Received: by 2002:a05:620a:3183:b0:783:e164:5b3a with SMTP id
 bi3-20020a05620a318300b00783e1645b3amr991191qkb.1.1706329408277; 
 Fri, 26 Jan 2024 20:23:28 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 gd17-20020a17090b0fd100b0028ffc524085sm4001781pjb.56.2024.01.26.20.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:23:27 -0800 (PST)
Message-ID: <ec5ce185-db9c-4012-9d47-ecf688a50521@linaro.org>
Date: Sat, 27 Jan 2024 14:23:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/23] target/alpha: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72d.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/alpha/cpu.c        | 31 +++++++------------------------
>   target/alpha/gdbstub.c    |  6 ++----
>   target/alpha/helper.c     | 12 ++++--------
>   target/alpha/mem_helper.c | 11 +++--------
>   4 files changed, 16 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

