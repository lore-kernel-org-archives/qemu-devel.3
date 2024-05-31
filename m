Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F0FC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwx4-0002p0-Mj; Fri, 31 May 2024 03:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCwx1-0002eb-Oa
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:45:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCwwp-0005pv-95
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:45:23 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so1538471f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717141507; x=1717746307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VMSjG2KrosW7Bl84CH6Ud+h2Csr7QHwDtrF6XM4024=;
 b=GSb7310P4yYX5HvESwrZ86K9m8FWjM9jXsGLuwpNz0ouZgoDxlO6p+sO5voBDlfE/4
 teUNM0Tg1S00Acd19bOkvME/qSfRCr3SeFbMQBjH8sP3lst0uqXXlIAtUUoU0qK+Gntz
 mZZI+z8hx1eKoTQzoRp9BpE2M1wa5wNQe2l601sezihdmOKGwCisQXvbJoQHMKUQtKe8
 ZILhgT4P+XiabsDDOx8E+XK39o/3TBkgWSpovg9p6q9jmJz8f/jlf8YLr+zEe99kqp5g
 jQwChwzf8+sL/kbq7I0LORfa6V6cKovR2tSt9WVWXD+uYwjsFylvDV/8795yZ4WKbvKX
 oo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717141507; x=1717746307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VMSjG2KrosW7Bl84CH6Ud+h2Csr7QHwDtrF6XM4024=;
 b=B1s0Exg4hIlpJ9Rol87LamfJZj2scdaoDoErmCaSWfUTBRRTMFANjxOrRFk5ia7L+j
 Ak/xbqxapBkOyhwB9tDwHi4lSbvwNBL6fw3a278/GMUGEeVjyWnwPojicyd9q49mkBW1
 eCb6vt9cYEVETDz0lC+FhnI+phnydiWX/x+YGr473rshnbTOKjkgF0e9g3vZAV10vPfQ
 f+eVbvEr8mpuF7mvGCO0qmkKuVc675z00qSVo35BwelRuBW8qLF45IRHl0DCoVSIto0M
 HqES36r+RqjwE+bIEvrPIYdSaOQpgBN5HwM65+4KxOH92CWnUWBDdZLuE777Xex/Gqvj
 4TBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXY4tElEYxjcnqdrK5W0Yv1sMiojp3LgIgMSzXwPOtmXtm62Dj+01lcYdwMAJsfFDcs6A3fRxzni5ec+ChTY1sKztlP2o=
X-Gm-Message-State: AOJu0Yx8WKmkSm52JmzyXbnfesFMZDm4G6OVW48PckYZ/3zMV8T2gVao
 769ZB6DCob/yJC972GO7M7yOgUelZCwH6PEBXDB6QFr4vztbuad6Euun1vUKQ2c=
X-Google-Smtp-Source: AGHT+IGJezQA9zsQf9Eg8q+TNRTOcPGUrGnjtJbFdu/FphUBJ2uBo4d8oy9j3MrGluQnQqJjkwFugg==
X-Received: by 2002:adf:ef11:0:b0:357:39e7:33a2 with SMTP id
 ffacd0b85a97d-35e0f27276emr722227f8f.21.1717141507245; 
 Fri, 31 May 2024 00:45:07 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0a26sm1239619f8f.21.2024.05.31.00.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:45:06 -0700 (PDT)
Message-ID: <70f28f96-9158-4995-bc43-9e00192b86dd@linaro.org>
Date: Fri, 31 May 2024 09:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] qtest: move qtest_{get, set}_virtual_clock to
 accel/qtest/qtest.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
 <20240530220610.1245424-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530220610.1245424-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 31/5/24 00:06, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/sysemu/qtest.h |  3 ---
>   accel/qtest/qtest.c    | 12 ++++++++++++
>   system/qtest.c         | 12 ------------
>   3 files changed, 12 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


