Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E57C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 06:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2mgD-00065r-6R; Fri, 03 May 2024 02:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2mfw-00064a-0E
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2mfu-0003Xu-44
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714718739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I/GE0N5VVYivTvZwfJAccEioqsvNvBQA7s9yMrgl4gg=;
 b=WPNm3jpPwqxHpXmQEv9Igd7hOghmoyk8ebuNoFQ8PfhkJkQgxPGIaPxDAPAi2mEuEDP3ui
 4iecHrljUISTpgneN12TLBqec/sMPmC2Joo25fabM6R2JwmNW64QcFWUp7AyFBF2YgwOqT
 u4UtvWyLq/aT5WiFGIKHN3yMUarOeeg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-9rTFgvvbN1Ou6LD8rGOahA-1; Fri, 03 May 2024 02:45:38 -0400
X-MC-Unique: 9rTFgvvbN1Ou6LD8rGOahA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-790f62cb748so540799285a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 23:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714718738; x=1715323538;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/GE0N5VVYivTvZwfJAccEioqsvNvBQA7s9yMrgl4gg=;
 b=P43y65WeMxkhPZXRpgbqGcabkCegItwavg+vdjzVEkgtDrE1/tvQ98HJKXbWvxBqF0
 xFvLD0Nhst6rmOntEcb8jbojUVj1/cC8fiMIMasuAYH3/xu868fEHisvrke2fEfjgek/
 8ohz0/HMCIOYoxcw7o/DiH/jRJVHb4t0SUpxIoBaq9viGLiue7Xvvylp80OP3ONN+iKB
 fJWUqJKw/w3WWT7PJkbwI7WOYkxoouZu1iGuK/oY9Xwi5mCMPIJSpv3nP52J+I1TssBv
 WR2D0pTWv4jL3ITOuxlLczLIoJHV3bfT0duoMTs8wVo9vVhMmsrqSpE8zooXah7iu4aA
 YQRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViddg9QSAxBFv0UF5UXEvGPKI7rRasmii2FSVXH+B3+whzHlqd7ansqcqUkCWW4A0liwSOB3d7OHprnr5lGZWqEFekc7Y=
X-Gm-Message-State: AOJu0YzcX9ECvpeE8tMfJZ6h3sRfOA2SVb7e2RAwSe+eeMEn6tPGhcNE
 cImxZgWUFmHk3Q1y2UYRGcJXnn5PfWxKERDPjG1ltgixMyxkBRVNBrwTvl3NM4VXprvrYd2AVZe
 1bOyCyxXeHBZX+qgI01YWjPbCPsKVqgI3AM41brXftPbmVDjiRCwG
X-Received: by 2002:a05:620a:2790:b0:792:7f5d:46c6 with SMTP id
 g16-20020a05620a279000b007927f5d46c6mr965846qkp.16.1714718738005; 
 Thu, 02 May 2024 23:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJsIcKxkzoBo7AXEcxFC33fxX56MGXmqZd6aJCzcgr+BOC726RE1ZSDVS8tBrbNiD3xsW3Hg==
X-Received: by 2002:a05:620a:2790:b0:792:7f5d:46c6 with SMTP id
 g16-20020a05620a279000b007927f5d46c6mr965829qkp.16.1714718737559; 
 Thu, 02 May 2024 23:45:37 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 g3-20020a05620a218300b0078ebe12976dsm987183qka.19.2024.05.02.23.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 23:45:37 -0700 (PDT)
Message-ID: <0ea35d63-c6fa-4ad6-b1af-5c0dca2a3e80@redhat.com>
Date: Fri, 3 May 2024 08:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 7/9] qga/commands-posix: qmp_guest_set_user_password: use
 ga_run_command helper
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20240501074340.19641-1-kkostiuk@redhat.com>
 <20240501074340.19641-8-kkostiuk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240501074340.19641-8-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/05/2024 09.43, Konstantin Kostiuk wrote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> There's no need to check for the existence of the "chpasswd", "pw"
> executables, as the exec() call will do that for us.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Link: https://lore.kernel.org/r/20240320161648.158226-8-andrey.drobyshev@virtuozzo.com
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/commands-posix.c | 96 ++++++--------------------------------------
>   1 file changed, 13 insertions(+), 83 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 9910957ff5..7a065c4085 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2151,14 +2151,8 @@ void qmp_guest_set_user_password(const char *username,
>                                    Error **errp)
>   {
>       Error *local_err = NULL;
> -    char *passwd_path = NULL;
> -    pid_t pid;
> -    int status;
> -    int datafd[2] = { -1, -1 };
> -    char *rawpasswddata = NULL;
> +    g_autofree char *rawpasswddata = NULL;
>       size_t rawpasswdlen;
> -    char *chpasswddata = NULL;
> -    size_t chpasswdlen;
>   
>       rawpasswddata = (char *)qbase64_decode(password, -1, &rawpasswdlen, errp);
>       if (!rawpasswddata) {
> @@ -2169,95 +2163,31 @@ void qmp_guest_set_user_password(const char *username,
>   
>       if (strchr(rawpasswddata, '\n')) {
>           error_setg(errp, "forbidden characters in raw password");
> -        goto out;
> +        return;
>       }
>   
>       if (strchr(username, '\n') ||
>           strchr(username, ':')) {
>           error_setg(errp, "forbidden characters in username");
> -        goto out;
> +        return;
>       }
>   
>   #ifdef __FreeBSD__
> -    chpasswddata = g_strdup(rawpasswddata);
> -    passwd_path = g_find_program_in_path("pw");
> +    g_autofree char *chpasswdata = g_strdup(rawpasswddata);

  Hi!

This broke compilation on FreeBSD:

  https://gitlab.com/qemu-project/qemu/-/jobs/6760232764#L7125

Looks like a typo in the variable name?

  Thomas


