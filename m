Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5344AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxk6G-00015c-Pk; Fri, 19 Apr 2024 05:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxk6C-00013q-Oz
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:00:01 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxk6A-00013x-Tt
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:00:00 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so2105905e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713517197; x=1714121997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MPxQjJovGEeaH5jw9xR5fgdvdZ8dPd3Q6lvUVJ/TSf0=;
 b=A3mVFz6DXCpmcI9FaOAV4D+a1vWrEBRmVvRTYHBI/uHpNQYBhAIhzj9GC3upw67TDF
 gvB+T+FNea4IhPqtOF8Ekx0dKCh1wuU7Ke0rG0qmyoCZehg0Uss66zfdCXbxGuBM1hH1
 Ww+6Z0beZIkOyv9LlD7LYJlxbApE1AJ8ZGS8HsEIy3HVGIPGepYv4S5pRqbqx73xXMhr
 ZqCuoEWa+qBphrix2VOxI7pZCyk/He0gbgRAmV0zudlYbQsGLHMjxx+fL2t15v5fOyt4
 ZIspgtps4pixiDOWKskeypFdNwLivmZ1QTUv2Y3+9nf0fq6XZvhOLmmsLr1ZT0CXRZ6H
 9UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713517197; x=1714121997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPxQjJovGEeaH5jw9xR5fgdvdZ8dPd3Q6lvUVJ/TSf0=;
 b=CwLKW1DTf6/Z+sh0HQ5CdKbfWFsQ1lB6te7Fh76mYDjBHrw/89Oa9kGEaLZO78rhkM
 QeAZZVdD+FhIs0MCGv3QT+3Wz1+8m++Rtof/N0eCCWju9r1zqEeesuhBoD7YKX1UKgXD
 fjegXRCHGxTNw8U8p+tQwvEIQLt0zopstAGhaa993Hnv7DPMwIu4plKyoHCA9EpDqgPA
 7L64Q6WhTYx+lCdFwrTyedZ6B5p7UGM0IXyMAYqzACwK+29Yhu2RPQ5ky01KrEI+ix2x
 hC4ENlTk8Zu9vw3b8DUCFfdqGcEWEiJlhdaMl+QSh3sGV+NEsz3WOaf5FmUB2zlrS14q
 /Z1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCs22N9GW2EJ4f3ndRYjsItCeU/II2HXXNO57jIroRXdrvJu7AhoiJ/wSJyfQr+4GpBziyYwNfu83QKxNNLNYCyoHXu6U=
X-Gm-Message-State: AOJu0Yx0FNtA3gu/T5cyqQ6+ms902dv9fnG7gj0FakCboatIfUgzEnD4
 a2YMs7xlrsjb+96RPtneXYxuINevEKRyt7SOKiNbcwLk/1kiWS2EZuikrv4EUxg=
X-Google-Smtp-Source: AGHT+IEhhwXKufSqxS7JFyOBMhmGPik/7Vl+rTTfHBd3LuYnz0NFsE1bgtj4Urho2VUCeMCncwzUyA==
X-Received: by 2002:a19:e041:0:b0:51a:c3f2:69a8 with SMTP id
 g1-20020a19e041000000b0051ac3f269a8mr537141lfj.53.1713517197094; 
 Fri, 19 Apr 2024 01:59:57 -0700 (PDT)
Received: from [192.168.235.175] ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 m6-20020ac24246000000b00516c8826719sm608275lfl.197.2024.04.19.01.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 01:59:56 -0700 (PDT)
Message-ID: <6be5d4b2-443c-4a51-9910-c4862c33501e@linaro.org>
Date: Fri, 19 Apr 2024 10:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] docs/about: Deprecate the old "UltraSparc" CPU
 names that contain a "+"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
 <20240419084812.504779-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240419084812.504779-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 19/4/24 10:48, Thomas Huth wrote:
> For consistency we should drop the names with a "+" in it in the
> long run.
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


