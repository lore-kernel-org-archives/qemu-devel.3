Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EBDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAfO-0000RV-3K; Thu, 07 Mar 2024 05:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAfM-0000RN-Aa
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:07:56 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAfK-0002Yr-Pw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:07:56 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso330937266b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709806073; x=1710410873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQV9oR9WMwgyMv/1jgKaPN+OkaTb33u0PUxVu25avJ0=;
 b=x8PlF56k3C0GkwElIBdzHN+uSmRIhrMS4ZBUFgIDkiWtIFfG8FsaVdXkgQ+MaVvoSt
 NlIt7f1ruMw7SFBPtd+/dcPw5aPVHp253ktOUOZBfFbI9i97061Eagwwg7r0p/t6EqnC
 vdKtS3KoRr3ddNDbr6+I2QiGecJ5CikQ4wURKaUVslJ2q3O00j+YdTP7cjg8eCsF6pgQ
 G8TYQSMsjf1r2J+jxG9rMFk5rjOmiQTbpezFFZdQu15CCfCNaKqUkiPIfUAK0OImGIlX
 3zY5fBKFm6CIlHV5T+yOV37+YlKbOww+gfOVtEh6gRi43I8EO1GkMr+lt0h8tJ8vMtEK
 GeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806073; x=1710410873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQV9oR9WMwgyMv/1jgKaPN+OkaTb33u0PUxVu25avJ0=;
 b=amMvuFH10Pz0lxQO67OVfFXFNWxEoYIOX7aB9aPxfLEq0eElPDtS3OsdlRNqBOzD8Z
 dmzMIdi+2QsQaqj2cnZ/DMYNayL4rfvT7YZNmOY/GswzfzYRei35TQYfn5CsFC2oOOch
 uK9RFCAycZw0Sb27qLoHbUtjHnbrLK6gRk6omH+6xZ+mBvq4iTKPD0J2pFOIiZ+YGyyu
 CkkgwKdg6I+VH4tu00V0uHHuNKAHniQYCDQKm6yG7GgNs89GV+GKOfWbs+YkBxbKY+VO
 Cj9qX8ziahxGtySGIzOAXbBn3Ddinf/5KhE6HM9PV62AFVDh0lbZXJXt16o+kxE/Zgj5
 I9SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKvs16AueObaAoLmCchAEQ0+4HnzWwSjfS89p1O36r73EMdWv737O/0bbQehuEGHD20ggNaO+VvOngtIC3aWgRb4N6wDI=
X-Gm-Message-State: AOJu0YxCPevWB8SXoRx6to1ziAO/6YYQCnAo3Xy45OQpA91Aab3C8r1X
 6VQSblwuyJsgS3alMK6pn14fLtfwK98jNSKLB1uGQRjfE8dSaU6wH23Ec8goJ/k=
X-Google-Smtp-Source: AGHT+IHhIa2PaspXYtVa+gOA6zYocngpC8/JkhQlqwf1qfmCgZQe/jmx1cqk2b6HSWYPBRNxC+qVnw==
X-Received: by 2002:a17:906:1859:b0:a45:af17:6e39 with SMTP id
 w25-20020a170906185900b00a45af176e39mr920938eje.1.1709806073150; 
 Thu, 07 Mar 2024 02:07:53 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 re8-20020a170906d8c800b00a43815bf5edsm7974189ejb.133.2024.03.07.02.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:07:52 -0800 (PST)
Message-ID: <b9b3656c-c138-4b10-bb6a-06409dad9921@linaro.org>
Date: Thu, 7 Mar 2024 11:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] Hexagon (target/hexagon) Remove gen_shortcode.py
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-9-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307032327.4799-9-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 7/3/24 04:23, Taylor Simpson wrote:
> This data structure is not used
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/opcodes.c        |  7 ----
>   target/hexagon/README           |  1 -
>   target/hexagon/gen_shortcode.py | 63 ---------------------------------
>   target/hexagon/meson.build      | 10 ------
>   4 files changed, 81 deletions(-)
>   delete mode 100755 target/hexagon/gen_shortcode.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


