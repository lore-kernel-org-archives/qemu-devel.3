Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDE6C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WfT-00052y-FO; Mon, 13 May 2024 10:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WfO-0004z2-MU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:28:38 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WfN-0001kl-3m
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:28:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so1143397066b.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715610516; x=1716215316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LJ39PRoLaa/csDYpSELX4LdZVipjV77ybqt6C6rULCw=;
 b=aS7/7Iv1Yzi9fVi5cUIYEFIDLhKHkv7Nnrn9iuFmOImcOyM4O9cRgSknTKFObQLz6Y
 Gka9mscCY6PraEenyZqa++x9mF8sVytB5c9K44FkMJwjYsd+QqNOM9J8V755jU2kr+/a
 ZtqxEwXFZOWYV3Q/AhvzI+z/RGiZq5CY4+suvo7AUO9wQdqeXx2F273kY7Lnzk6El/qN
 glhry4JmU2o1wlsyjI5D7ew3f09C8Tx4zXbJrvOmfUrNieMre0fun+XrryIVvVaOCBv9
 jVTw9ye2TQSBY58A408VSGOCsQn9cVLQlcVF/gqEJ6O9mlAHSo4zZGeYS7QZF+YO0yLn
 tdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610516; x=1716215316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJ39PRoLaa/csDYpSELX4LdZVipjV77ybqt6C6rULCw=;
 b=NhQdbJSS/VWJBPnIkIU7pYOj5Sy6o902kSNsYFNTMfSHPHq3F7EJZd6lOXQE0Vu2kS
 14LiJ8MI5sYKLMem3rwfgb4tDskqLqDZxBC2CyriEJFC6QRbD48UI8esMbsKvfH5v6a4
 FS4/g5r9IdGfhNzaII1GPp7WIN2KYiqOwhRrJHHVmENqllmVrBP5ivV5fP0T4JV40dCy
 haVWL3WmcZGgDQEZJc6ydgKcq7y+NQBM037AKMfuRwVv8i7QHGjCpWzaTeripDFto0pE
 PcIKQAL7Z1Lpa2RXUot5p40YR6mqmUrpozlxWF11iL3tkBfDqCJ+v1yuM/a3SkqNl632
 kCIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw1SRT2WnNCmWZUJukeJoUsUGEjtWLZL3rWx+s68D22Lb1LteehV7EyQ5ksYhUKpUv7OGPbTqSYl+k56+woePerxazmzU=
X-Gm-Message-State: AOJu0Yzmn/S0Iab+gUOzxbWzSh+8/OZT3v94csWQ4du7n4+uQDNN+PMZ
 PMdGaWu2RdYa0YIQN0nxf5f3dp9C6pzs42re078LcofeY2gGlgUecJ3iYCslXeQ=
X-Google-Smtp-Source: AGHT+IG3JFoJEcijdDDNvGtm0mcvdVqRPGmJT1jLJm9Z3Ip3VnOJlCiVOcuBoHa26ev5UdMGtBj/Gg==
X-Received: by 2002:a17:906:17c5:b0:a59:c9ad:bd26 with SMTP id
 a640c23a62f3a-a5a2d54c601mr634760466b.12.1715610515725; 
 Mon, 13 May 2024 07:28:35 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7f32sm607349466b.106.2024.05.13.07.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:28:35 -0700 (PDT)
Message-ID: <99342f96-1a9c-414b-8cf4-fe2d3830464d@linaro.org>
Date: Mon, 13 May 2024 16:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] qerror: QERR_IO_ERROR is no longer used, drop
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-7-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513141703.549874-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 13/5/24 16:17, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qerror.h | 3 ---
>   1 file changed, 3 deletions(-)

One less!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



