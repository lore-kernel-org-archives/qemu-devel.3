Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A167D3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lJR-0006Ac-Rz; Mon, 21 Oct 2024 01:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2lJP-00063K-Hd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:50:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2lJO-0004dD-3d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:50:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so3336453a12.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 22:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729489836; x=1730094636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89yvduAgFXEI95io3pCt/pfpcBAvNwlWh4IzNpQRpTU=;
 b=ezZk81JB/UWbBcBk5596B3Tg4PNs7zN5DKflYwn48BYdfk8NclQ60L2voMaiLMlxSz
 bU3fnBw3xWcAxYGG2GXoPOsEiKeFFNfBifZ0/f1By3jLhoEheLDxqHQG+BFxMRpXvG/6
 KJ01KkPV/8MRe+m6mbCz7N7tnt83nIhvrV4+igUIBUppBBwm/O2f0+g4jE4mJe+3VxE2
 s12U2VIMRx87cspp0PkHrqlDSE8J9+MvchuxDDQhRrO/LudZMxSBNlnFyjCCUJQMKXC6
 Fyxp73dEltv+TF6jXx5QpWsirX+JxfWlLVhezEnvMFVE68wzglxmM2xYv5u0DowoWBrx
 rEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729489836; x=1730094636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89yvduAgFXEI95io3pCt/pfpcBAvNwlWh4IzNpQRpTU=;
 b=F9t5B3olUTC0ppn8zZ+1jDSwGHqL70x3KRzC+0jyS3nsZF8htPYqpn2WKWeIqZfMAW
 bRRiwFVCcj0DOtCEclI6JgqRjMzA1SJ5Qx2S+NnR0jySIc+cpzTKCcLNU7q86jPz05Af
 6DvRHDT0yVzoc5QuBZ6zb9QhaV8SFhQDbZg3S8Re7eLdRcOcLrV7JopDXMHi/cQvwnr/
 kIsF5H/H2a1crh/xGDS8CgWFo5WIEXTvXWvI1bFvV8YjPm3QGUl6PLx19ZlHkt7Si8Yb
 5SQ+Gr+NI3i3Ov66XOvz1tQSOmNSIZ/kW8CG7n/sgf2o3XFNKt7kFMrdq54E6sxpuJC7
 wRkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe7+ZOhQ6wn+2iHmTE/HIOcWHOLo5H/2qTLNWP94ycvV+dNgi3vx5uXZpYUeOXAcpvAToBan7VKPRH@nongnu.org
X-Gm-Message-State: AOJu0YyeZXllNMht1YlhjRV0mORfrHRDtZDx6crWUEo7uGDvPzkqkOQ8
 f8ITEpgdn+4oM6qHlsNYzWtI7CipRkeXQ0PeTfXUVl6Ix7nqU3GbH70IhBx+wPc=
X-Google-Smtp-Source: AGHT+IG5kOKUbp0utW56xK1InUv8M3+BCED/6fZxtzYQb28sUqheSu1xUo318jm7odouTAAV6GaXVA==
X-Received: by 2002:a05:6a20:e605:b0:1d9:ce8:35aa with SMTP id
 adf61e73a8af0-1d92c590f39mr14393225637.49.1729489836444; 
 Sun, 20 Oct 2024 22:50:36 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1356b8asm2094538b3a.92.2024.10.20.22.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 22:50:36 -0700 (PDT)
Message-ID: <02d57577-147c-4eb8-9eeb-3c291d769a2e@linaro.org>
Date: Mon, 21 Oct 2024 02:50:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] qapi: rename 'special_features' to 'features'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241018101724.1221152-1-berrange@redhat.com>
 <20241018101724.1221152-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241018101724.1221152-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
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

On 18/10/24 07:17, Daniel P. Berrangé wrote:
> This updates the QAPI code generation to refer to 'features' instead
> of 'special_features', in preparation for generalizing their exposure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/qapi/commands.py |  4 ++--
>   scripts/qapi/gen.py      |  6 +++---
>   scripts/qapi/types.py    | 10 +++++-----
>   scripts/qapi/visit.py    | 14 +++++++-------
>   4 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


