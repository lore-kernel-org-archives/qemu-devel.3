Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7545C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 11:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH005-0006ou-Gq; Tue, 11 Jun 2024 07:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH004-0006ol-AM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:49:16 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH002-0000Kj-Oq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:49:16 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f253a06caso101215966b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718106552; x=1718711352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mGuogEaBOKdKHZR7bUW3PsSBmnv0v7zdZ5YLYkfH9AA=;
 b=RrGKeuEH9fJ3aFtg4NwYNqMoF/LiqjBqIVvTqt1IYBB3TSSh03d/DO8wPQ51YtS87W
 cfx3kw/HIjhGGnfVum4pcmp6zErDSCLxjSN6VFWBP7kvs7JM/AHSu2fZzyu8SM0KOimP
 Kk2r9kfI1ZBTBhlbi+HVLQ+Tk3jTF9MvRJqC7nOy8+AwvFEhkal5p+UXXx53DcY2Qf87
 aIF3SOdmLH46xvhrnQn52JFPifNz7QUAV44B9IWbmGnvW4qW9LlVTpOx8Pm/MPNeupPe
 uf6925moktJBlCakdlMspxi2h05eJpCJojMwvmuFFtPyDH/mpI9K3Z3oJc04JAq+BPv4
 2mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718106552; x=1718711352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mGuogEaBOKdKHZR7bUW3PsSBmnv0v7zdZ5YLYkfH9AA=;
 b=wqJEdFnlH32GBSfUcWAznIa+ZCAzVyXyeQhXkLH0y42c2ZchFJkJ/b7fEVRf3m7+By
 /Gd+Yhq8DaZDOXjBXuo1aLRElrPsVaV4LVchzsKGHMwUiQkUQT5JAHa8dAEX0VUEEb1g
 BKK65wDftRH7qfGh7SmtcTwjjv6ny0NFj6TztXwHDCQxuAKt09CtyPjFiHuQeee76Ob6
 cNOqz9GntY6oWP7IiHcaybCrFyc7pFQKXs25lRWuKN2Buk2sjPRzSykh5DWpE19HIGdP
 +NTEMaLCB2/BAP3NcjyTgiwHsBPiuKhq+xCLxh+LUrw3vhdbvHIGAUaIshd+qgIzfRlp
 0vNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3BI29UnviXroRsTK3JRWPhpgVHzLkGY+E8ywko+F++il/oLoesrVLX3cz9JWQk75GvlBO2AD3nvOBUwrCdSZJusE6oc=
X-Gm-Message-State: AOJu0YyVmMnpj1Ey0vvuRKsKraIXQlUZmnodi+90wMooDoZbQ9yiOZAr
 oqyCdEjINr6/A+mfpG3VcZZOsIbs55WrhYmHDFiP5NrZpuwkT2F2UzTk42yVT/E=
X-Google-Smtp-Source: AGHT+IGnLNvnLVRSb8G27QxO/fHX5Pm52ANFYGPoc9FbNJi/qSreIhxo31UlTTCKaY1OsKyA7HqKNQ==
X-Received: by 2002:a17:907:7d93:b0:a6f:1c3d:656 with SMTP id
 a640c23a62f3a-a6f1c3d0718mr583853266b.55.1718106552152; 
 Tue, 11 Jun 2024 04:49:12 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f15095318sm342426366b.131.2024.06.11.04.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 04:49:11 -0700 (PDT)
Message-ID: <7701a256-cbbd-40f7-823b-d578279a4422@linaro.org>
Date: Tue, 11 Jun 2024 13:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] meson: Remove libibumad dependence
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com
References: <20240611105427.61395-1-pizhenwei@bytedance.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611105427.61395-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 11/6/24 12:54, zhenwei pi wrote:

> Zhenwei Pi (2):
>    meson: Remove libibumad dependence
>    test: Remove libibumad dependence

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

