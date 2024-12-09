Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1356DE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgmi-0005s1-NK; Mon, 09 Dec 2024 11:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgmg-0005oN-C6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:38:58 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgme-00051L-D6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:38:58 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so3028799a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733762335; x=1734367135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFpv901v/Sjz/sGZFZZVCQpw75ube2eMnbcreya2Rvw=;
 b=XyNhVmYQwiKNCjoSWWl/QOceG75eBv0YczOYdyJ8YAZNlrxwZHRfqW/J4PUNextJJt
 7bs/xpm68lg+X01+k1U39DhLWKqe/h44I96CZlZIbDa3h1PyPhX7/Cz5huacPcqdT+xO
 NFaNobdAM4xCpe6kXjbkcwry6hSMY0JtX1vbEzMxf0AK/LJA1ZHD/Qj7ULio1FDocy9V
 Zrl1fg9OAwiY4qyjJkyQK4n7+me6lOSB+ghRadcqCaAT7VnHMMhH5lchVtA+p+6rp3fd
 AP+0kYyz7QzyhSTDTCLZhdtVgwRQggVO3fkMFA5TqnawyQ1aBGyv4tWilX8dbJrZeCRQ
 3IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733762335; x=1734367135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFpv901v/Sjz/sGZFZZVCQpw75ube2eMnbcreya2Rvw=;
 b=ZgMm+HscK4EnOtmUnsDTAr8OWiXGt3wuVqeoQc+iDponVU+RbdHaH4KTfyD2xktouu
 cacw/kEwujT1vGO7kueSI9nOGCfXY3OYLUg95kictZA/kNiMmaq4WHZk7ovFwMq3cMs8
 FtBrqD3+1urpyRsPh2iOL1BslflOoz2aplAHt4fW3a6Mos2sJBEPqS0pxAHq5f7MXWp5
 njr7yiZIYGkAaJtuq9hhgXe3zivWFh5dcEJniIshl+/vnKcVKkg/IN9sI6PSsD8W/xyy
 Ro9m5YpoWP9aOLvrdE39L+ehgJ8BluDG+oLrA9+6LlJmvF0bLhOkH/pUQA2sj569qlPl
 OpWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK9mmIiq75HfNEegGeSjjg+yXefszMFrO6IOAtK/qe9M5Y7uZpjYu4khSNPWixtAjtBjsfp45DKned@nongnu.org
X-Gm-Message-State: AOJu0Yyb2HRiGWTt1wgVc1MGHiz6wzV07gQZfTea0zmsJXcbN+ge9Ry2
 kdlOk5UkjAYWeGMUW57eVbqwzMjyStA4scZvRC0dlzaX9YtXrvtXxGcoNm9qjWBWfd1fJViQsdx
 H
X-Gm-Gg: ASbGncvgpe1Nz+GzKFKrDwAC2M3ozK5jC2TjR3pH6HxWlHMHWLUHTCNa+SRd/08udHD
 oVli2K9hEeaUCNlmZy0Tujl127mJxae0O4DZW+sp4U8oiUlUe5g3qsKO4X/OkXebehXTiSFBLuD
 VLZNa3Se8ZnBt5Na3OBXOAkHmMDFSNXyv6Ih99Nth2PZTDVkjQQ+FTq4mqgZaSRBBK0Sb+D856o
 uifl+So3szGVpgt6f5zY9wbMyxDjODxqjBo7Ayrs5Iuwrb0HgBuh2BYX9gm20alNZj47QV/0FJo
 vKY4twKi6gyB90a3UkDLA/yOIyZ6JsfO
X-Google-Smtp-Source: AGHT+IFL2PxvBMqhr9UsDSFyarQu+LAumLDc6NcYzC48j6Ij9k3zCKGP9d7et33rKT21NpkC7TFFHw==
X-Received: by 2002:a05:6a21:6da8:b0:1e1:abd6:ca66 with SMTP id
 adf61e73a8af0-1e1b1b27e68mr1491488637.24.1733762334709; 
 Mon, 09 Dec 2024 08:38:54 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725eeed027csm1955982b3a.131.2024.12.09.08.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:38:54 -0800 (PST)
Message-ID: <f56fe179-0c48-45ac-b85d-6fbbe27de991@linaro.org>
Date: Mon, 9 Dec 2024 17:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: replace 'Edit on GitLab' with 'View page source'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20241209163506.2089961-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209163506.2089961-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x531.google.com
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

On 9/12/24 17:35, Daniel P. Berrangé wrote:
> QEMU takes contributions via the mailing list, so while you can edit a
> file on gitlab and then switch to the terminal to send a patch, the
> wording 'Edit on GitLab' strongly suggests we take merge requests.
> 
> Switching back to "View page source" is a more agnostic term that does
> not imply a particular contribution approach, that we had used in QEMU
> before:
> 
>    commit 73e6aec6522e1edd63f631c52577b49a39bc234f
>    Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>    Date:   Tue Mar 23 15:53:28 2021 +0400
> 
>      sphinx: adopt kernel readthedoc theme
> 

Is this:
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2709
?

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/conf.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index c11a6ead8a..164a8ee8b2 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -186,7 +186,7 @@
>   ]
>   
>   html_context = {
> -    "display_gitlab": True,
> +    "source_url_prefix": "https://gitlab.com/qemu-project/qemu/-/blob/master/docs/",
>       "gitlab_user": "qemu-project",
>       "gitlab_repo": "qemu",
>       "gitlab_version": "master",


