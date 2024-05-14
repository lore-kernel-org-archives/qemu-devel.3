Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E626C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s2H-0003gp-Ih; Tue, 14 May 2024 09:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6s2E-0003av-W7
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6s2C-0002Gb-Ai
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so14417275e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715692654; x=1716297454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e9DIDPZwUVzKEY+m7KYOpCRl6fAIUqwRQbi2OZO9XGM=;
 b=hz5hDezj1pUZ6o2+aFHBfIMFTM3xGvTbU2M2+WDHHX9OgNU2NczPEJuM0+bXnI8RPB
 /9HpfOEPL9nEWwhs29vG9CkAyRQVM/Vzk3jdxg6QVJILh+SCKjZ0PYchs7sRjJralsrR
 hepwbdmqkMG0uTLuWAhl0DINMIz5WuSw6DXc3uOaXMX218lpLhohbRVuSsCAZRF53RLj
 Bcuuvh2BMngYKCgxVyZqOd1B1qwyhAljd8uY1bgINmhePEQPuRu5fxFujCX2MCBNfRnX
 +Y2/4mPZv6rck19AUJTjk7cAOYJddKP0UWHGsg/FQylf7o+OI5K5Al0vFtuo2v5Q/QSX
 r5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715692654; x=1716297454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e9DIDPZwUVzKEY+m7KYOpCRl6fAIUqwRQbi2OZO9XGM=;
 b=gh0dVJGaqjiuW83T39XlWGM0+7Kd3bll5peirVrVwC9D96ch0qJ9czEjdK9eDcNClN
 0tDLS457GYPoSvKRXVkqhz0Ma6Yw40nseOKFQs75a5bxmi55gczt0PKKvP9+jv9QMRj6
 vuCuMJSS7kQSyvI5/SUbgew6r5ff5MOtImoFXxPzoQ3r8T1ssB39xHypjqsE1CNHXPQr
 Mnf1tFkcAJjsEdSM6HIBt0y9eb1pHhh5RpBIoH/GqUnkL+zz3LYvksWDuYwTIEcU9vQv
 1l2oFVbJiRLQ01xoHDdHP/d/JF3AyRf3E64QkI+WIQnhHYSIDOg92U9eZFEf0yEo4Hlv
 oONQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlCNJUGm8RQKiPMF6xopUWox6qOHTNeLgYKeCK69IwOt4ton3SgjVIVm3GF2wpWE0zQmU+PL7wDnZYJBMwtqp6blre2Lw=
X-Gm-Message-State: AOJu0YyTYPm+2yQJXGhjwQtrpOaTOhlk5lugvpbJX9KUwUWc7SyuANA3
 YfuwoTn/DG1zHp8JgFauTpN7M/0EPnfjznSg0pmkR0kv6UFG5HzgHyPmyjijF9k=
X-Google-Smtp-Source: AGHT+IERdeMMg3lKrAcQHA1RGUYfk5ltXg+OSZLjr+P8dOunoxbbHrVTUMmPLUJvVVqs+ki43/O1eg==
X-Received: by 2002:a05:600c:3d06:b0:420:11c1:b240 with SMTP id
 5b1f17b1804b1-42011c1b30amr57720575e9.24.1715692654539; 
 Tue, 14 May 2024 06:17:34 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c235b4sm228411405e9.11.2024.05.14.06.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 06:17:34 -0700 (PDT)
Message-ID: <b29bdac0-894d-4281-b26d-b4ced6df1d57@linaro.org>
Date: Tue, 14 May 2024 15:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] qerror: QERR_QGA_COMMAND_FAILED is no longer used,
 drop
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-4-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240514105829.729342-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 14/5/24 12:58, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qerror.h | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



