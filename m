Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3583BC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wf1-0004X8-GU; Mon, 13 May 2024 10:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wen-0004WV-Bo
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:28:02 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wef-0001gu-7k
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:28:00 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59cf8140d0so1012126666b.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715610471; x=1716215271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nnQ6MHz0QIZF9EA//kFz9Fw/2H6kh09kl6OghDFCmHA=;
 b=nJmJQ4jjCinzExYq2duyQhWn9+A40koHnQhbwYJhvbU+rTMmxNP5eQGwAOpKyXHKyM
 5sNm6T1yCbVCJO4Q99PD2vTYuDJNsX6mmXgRHRqrAIIXzXWHp686pODr7/mx1XihhRMF
 IagIXMYtEOJW2RoZxkjrvDfRJkriay9NBKFYWVhgUg6wAlmaWqx1n7LlHXxrQ7F9GfCG
 tMlC/R3QzDKNNeJ6QOwc+1gP4nY6Z5/mfJfKIfMNeuULSHru8CIzI7kyrPZ/9rIy+f4H
 NWEJMRIy9OpmIcSSVFdPLJKjmDL3Qq/VlMNHJxMzl0lPluHPnfIA8r3sQ6EOxlQM/PqN
 gsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610471; x=1716215271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nnQ6MHz0QIZF9EA//kFz9Fw/2H6kh09kl6OghDFCmHA=;
 b=IJwRDD4uNXWWqhqE+/Kd7+H1gMbLQfeicN+Dd63pgK88FfJ8RI5Qe9u3W2dTM+jsba
 VSY2nkwm90pGNjtBAYCSc/a8IABpln9IClroPSJcuTf/dlXo9EcRuez4dnIuRfpzQ4Z2
 cXimeW0HzRTzsLjnGHEC/dlX9RDyLNgSYb2qHL0srbO+hOGVuZRHNCYyktJbxU44pD6t
 MX9bZ9Qd5fXPeZj0vX2ByXED+mnrwjcHq3OO5Btt5N5SZlDt0zsNE//9cb3Un6h9gluJ
 croF6ePn8Z0Q06ii3P0YpufXZhR5YaCojTHuqOKCRA1RsdoWor7ixEFpetvO9erQk67L
 6oSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuNeBP7cji+YFL2Y/7D2c459n1NX/R//8mYMtjRkJk2NclZs4HQXrxvnOD2TOQkLL863dGmIkdxhRjO85E9N/+i+FF2V4=
X-Gm-Message-State: AOJu0Yww30hXx9G1x7kfrnxkgexCRdA56rxoaCYCC5+E9A+D2hkBjcTi
 q1lDpAGXI0dfMNEbUM4IeBT1ItKuatm+zl7MrJDKi2MAxBCPLl/0bhnNW4+gErE=
X-Google-Smtp-Source: AGHT+IFzhZYBe0Z6YIJxVIJHbvvgG/+WcGHHQGbDn1deSWcqonBEcmN3aX1Cu9bp9YgbfkP5wwP+/A==
X-Received: by 2002:a17:907:1b28:b0:a5a:5f31:7663 with SMTP id
 a640c23a62f3a-a5a5f31777bmr313852966b.56.1715610471499; 
 Mon, 13 May 2024 07:27:51 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7e02sm600535366b.105.2024.05.13.07.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:27:51 -0700 (PDT)
Message-ID: <5ad42c0c-abd0-4fce-8204-9effa4765ab8@linaro.org>
Date: Mon, 13 May 2024 16:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cpus: Improve error messages on memsave, pmemsave
 write error
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-5-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513141703.549874-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 13/5/24 16:17, Markus Armbruster wrote:
> qmp_memsave() and qmp_pmemsave() report fwrite() error as
> 
>      An IO error has occurred
> 
> Improve this to
> 
>      writing memory to '<filename>' failed
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   system/cpus.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/system/cpus.c b/system/cpus.c
> index 68d161d96b..f8fa78f33d 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -813,7 +813,8 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
>               goto exit;
>           }
>           if (fwrite(buf, 1, l, f) != l) {
> -            error_setg(errp, QERR_IO_ERROR);
> +            error_setg(errp, "writing memory to '%s' failed",
> +                       filename);
>               goto exit;
>           }
>           addr += l;
> @@ -843,7 +844,8 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
>               l = size;
>           cpu_physical_memory_read(addr, buf, l);
>           if (fwrite(buf, 1, l, f) != l) {
> -            error_setg(errp, QERR_IO_ERROR);
> +            error_setg(errp, "writing memory to '%s' failed",
> +                       filename);

What about including errno with error_setg_errno()?

>               goto exit;
>           }
>           addr += l;


