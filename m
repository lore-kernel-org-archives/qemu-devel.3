Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5C2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO5z-0004qf-SW; Sat, 30 Aug 2025 12:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urklA-0005xq-VD
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:06:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkl8-0003w2-0W
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:06:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3cf48bde952so179580f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418775; x=1757023575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQERPfGXdIzlO77ltl62NC78xJe8fEdI0otSa33hJaY=;
 b=xeJ5AcJ7ifBjyRTVax6vyq0QMiSctboQMX8aSnZ89q7Pizc6S1yF60l1pWCjCHRh+u
 1EfwXvYU9YgtaWEZb9rFZ39QUuytfPKzzCRjjHhUYcdwNvbXy8wSAG3rZsM7ew/yUoxy
 IwFZB3sDSnus/yOwWjKFL8t/M2w9kYvw+po9aped8O1CF2LomTPjPJGDDjMaWsvYLmct
 gEDgEmpb3+6W8vjJxa+hmRUsloqugzuNd7mhAddFY/4GUrYhF590RhBeiCmQTAIdrsks
 xL/i5uLu4kJJXyVcWSDiG4aGalUodSWveKpctS8b6XNicULUy9LV15fgGyhLUfMh2SYW
 I84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418775; x=1757023575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQERPfGXdIzlO77ltl62NC78xJe8fEdI0otSa33hJaY=;
 b=m+kNE3P4SvbRdHlVhsz2D2kEUOUtQlg5GgCZRlrgNvTMQ6drg7RjqJIbd9pdn6tRRS
 NcsqAe82Cz5VbQ57jf/UtMrZ+G4p1CirUyBNo0PoKghRAbVvSeHyPyi9SIXPfDdtqGzZ
 JjmefXsvDN78B07jneg3jbiXnrAoNqBYM9Gz4Lw0XOSg3IQR5ccdn2AFZI5C3DjZHhpt
 KVYYXz9JrFF+XhIsRykd7humOxrNol44WwBFQNyE4C9f0NXWufrL/sCsYDXmXzTLcM6G
 54L1taqf+leGfU05RDu5Mne090N8DNTk7Vkl0f0cwDZGarBypt6vk2fIzQrOzu3OkKQY
 D4Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+PuzFAgKCmXuUx6ssgLza1KuDPC0c86WD5jIjiXTMd/ImMvv6W+2fk1tMju/+nU9TnAwl6UN+hK7@nongnu.org
X-Gm-Message-State: AOJu0YxtvGD2c32fxS+g9hOeuZLEdqKPCYW+GAEX/VWLM5zfdNamr6Ej
 NOdOTjNZkJSMUsscVb97DtHHMwykAz93AM7rPfOGWY+Trp7micHthJ59ktBQILpu4Ng=
X-Gm-Gg: ASbGncv0kG90jFU5vyIX+IPstlc2nl/f680/UuJtgTBQNw9CUVRUZJH1awRBccPws/s
 RKUi/W5t6HvuhyBIXSX8/1kjiYbstOlxbwADOMy73t86kXk9bHszx1pc5wFQl6M4gJgTehdBcBk
 F0+4QSnF1Uoqa7S8+B9p+9bix994t9R8wLk6+24fiLdCpJYXRu/1ZmR8wGnQXZoi6QzqTZQU6l6
 xb5J9sKTLKjK8EQsTQZ+ovMYw4yB1434iIoLE/eL/PwRl+RgGM6T05uDk460tUH4dJxnf0beWp6
 MsIZQ4JrwTPo/Lv4iKwbOUszkJ2vQCBFUlCDI1MzZzVe6YHeco4Qy3FTP2e8NiZ0LjEdFVP1DnL
 JJO5ldRT6IDkKBMnWlHfGYITeTUEP+Q2eiCArVJaqFpbQ0vytjjVJ6gv5ffIGwugdWNA3rsRc3j
 aIPleZ06KyAaA=
X-Google-Smtp-Source: AGHT+IG4E7Re26hFZMAwIrLsBg9A7pMvaMPOZfPCWWp1+RqUkTHy9qcE5RJ0uqQjeKlq7DDk8R8XJQ==
X-Received: by 2002:a5d:5f8e:0:b0:3cd:cf31:d760 with SMTP id
 ffacd0b85a97d-3cdcf31d9e1mr3446500f8f.36.1756418775113; 
 Thu, 28 Aug 2025 15:06:15 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add294sm832386f8f.29.2025.08.28.15.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:06:14 -0700 (PDT)
Message-ID: <28aa3b22-e6a5-4aaf-8301-6adb066cee57@linaro.org>
Date: Fri, 29 Aug 2025 00:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 37/47] hw/arm/xlnx-versal: add a per_cluster_gic switch
 to VersalCpuClusterMap
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-38-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-38-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 22/8/25 17:16, Luc Michel wrote:
> Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
> When set, this indicates that a GIC instance should by created
> per-cluster instead of globally for the whole RPU or APU. This is in
> preparation for versal2.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   hw/arm/xlnx-versal.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


