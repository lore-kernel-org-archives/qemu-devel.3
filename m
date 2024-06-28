Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8610C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEKo-00073I-Ib; Fri, 28 Jun 2024 12:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNEKi-0006mX-8S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:20:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNEKf-0004Zb-J2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:20:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42573d3f7e4so3061925e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719591616; x=1720196416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l00+1lk0qft4qhC6I1fAqhgwfmI6+/6v66NeNG2ndo0=;
 b=iLPDilLeEnRL5oYzt7JXg+qHGjHC/AAzwv2U+c5QW19vzbEENaYF/on4cUipFvwp2T
 tyhPIBmGu5sNh6tVNLTGZX9B09Sx0kbU5Kg6SHVtS9Tn7rqbSmeOHQK2KQRtZzsrtH2I
 0kxceFKIHOBw8iM09hEMOGv7ywHWu7NvP61Mmyywxeea+c2kG3ALBQ7d8WN+p8Hu9E9i
 2qg34JKxzS0joZ9LLzgARwvULrS/l781M91vUNzst2y8Z/qGCvcOb9Sr+cmrKeZtEt21
 glB+XNG9c0xVYarIdU4wsdqm0oz5adPh8LdobOY/7Cz8BhXLulwcLKOec6iAnjsYbe7P
 VFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719591616; x=1720196416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l00+1lk0qft4qhC6I1fAqhgwfmI6+/6v66NeNG2ndo0=;
 b=eWWV+DsQh6W1cFPVES+33aNqqcPLv06ja5SCjeTh51vyNFMAdU7u2SyxYwbMUJqWQC
 wizb74hVI2qDKZYkq8bNf+YbPquVr25t/c+9PGM9YRftcJ2qQQNl/9k4br7hifYMa8/8
 O+yv+r3QOwSN3LmWR5JjDXRVW6lIGX/UMcccijKa7wX5DazfeZH2HlUUjDe+75HGqp/V
 Ccpihkkk208/WzRl+GI8dqOasfPu+Z124he8dCY7+IG8A08603u/nJUWXb9CQ4YK9b5m
 kjM0ALkVX2oNifG+geXyomLS3T+K6EJ71yV+wxYZ1BjhYaTEEAYYk9cupQFNtDs4A9ZZ
 0AKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe2g/QQ+SVS1kAEaEK5GrGmTEXZKlKEi03kf3Qhs1OUvDYYthtJ4pXwZ+SfbrwV1EWRraRbnGAeD/AWjwecG3/D+rtOwc=
X-Gm-Message-State: AOJu0Yw0yFuDKEAvsc19VBR7GjQ+DkACJrEQQa4fhlW6y3KCt7hlFF1j
 aICAg7v3aYHlXlw+VhSg7CmZe1vYZHIxUiOa+zHLMnTrs7uCmFPODx9jq6vJZfA=
X-Google-Smtp-Source: AGHT+IElnIBgVBXgRcwalTOcaXV+bFhTgFZ5jxJ/crKri8LLxGNxe+W5Of78VkGF819p6wCqcgRxyQ==
X-Received: by 2002:a05:600c:3798:b0:424:a59c:1050 with SMTP id
 5b1f17b1804b1-424a59c118bmr73969125e9.29.1719591616008; 
 Fri, 28 Jun 2024 09:20:16 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55e61sm42366385e9.20.2024.06.28.09.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:20:15 -0700 (PDT)
Message-ID: <44039c00-01c1-4a6e-856a-c3259ae0ca67@linaro.org>
Date: Fri, 28 Jun 2024 18:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/macio.c: switch from using qemu_allocate_irq()
 to qdev input GPIOs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, akihiko.odaki@daynix.com
References: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
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

On 28/6/24 18:03, Mark Cave-Ayland wrote:
> This prevents the IRQs from being leaked when the macio IDE device is used.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ide/macio.c                | 10 ++++++----
>   include/hw/misc/macio/macio.h |  7 +++++--
>   2 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


