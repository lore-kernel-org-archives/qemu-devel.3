Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726DFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 17:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2wfP-0005fD-Sf; Fri, 03 May 2024 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2wfO-0005ev-Pu
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2wfM-0006ve-FB
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714757147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NGggQ8UEacDGN4fT2pSNWr3zF+dUd9fYTfIMBEppCaE=;
 b=Kw+XCsS1FmmEEmepoi2b2XOBzNXD6WgYPxXWOKhw3nmS4WuXfDFEWNWjk55LchbZZqvpVE
 po89e200jD8jIetK7iIfuBRBHzcWbgxAtSHzFU7oVCTypfICg06YKNHrPgNCKSsr4OFESq
 64na1K8vnlgv22J9tlDbWh6Cyk4OoXY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-KnqR_ymANZeCxiagfk8H_g-1; Fri, 03 May 2024 13:25:45 -0400
X-MC-Unique: KnqR_ymANZeCxiagfk8H_g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0ff9833afso41840726d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 10:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714757145; x=1715361945;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGggQ8UEacDGN4fT2pSNWr3zF+dUd9fYTfIMBEppCaE=;
 b=qR6gibEGL6p21KjlV3m8pmRG1EEBP9ccC4KMRwNEVl2MijZ/MjjDK0vBf3Ut+xuTsT
 frZjEDJSMPC9nMX/OL0Hp0RcwzmduroU30XrNhJfwVf0yhYMGollOxlggAaLGoM7be0q
 JSLHFrYB24V5RuyAUlTjz/STsqBltNwXhkVdLneHhR5GuF3GSjLjeA4tyLwdD14UQGGI
 HeQb/9iwqYT1GwlF6m8zdxNOcpW2XZgYEaVUYIVnWqy9wEGAlAQBvgVjgdWmnTIEN3NX
 RzKeZOlHv+VkkYuRhDwrUw6wHn+ZmspgxOS24PpSzkgndb/id+tbUoge4/67yJ0cj1Z3
 6b1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPo1Vl6V96DhObdaVtds7OEK2qQYboy3fhufLXzSnlsHW4tLqByWVWJGnLc9vGkhyAVtptELWv9LQ4lESgisuPyz3JIps=
X-Gm-Message-State: AOJu0YzMsGndeVJSj01uD2zixnlW1U1LKBhVs3MmBgAbQPhIGCG2R5rG
 8HGgkSSj2pIQCFxiPuTlrCMoBuTjQPS2wjWAVE4bZZ+5akyp54wVuxopfboofEGZZDJEXnaWgUl
 X+77yhuOeto8lmCqTl+n6fEC5uyvwBcomkTNTSKtfM/i6aFhHcjdV
X-Received: by 2002:a05:6214:c83:b0:6a0:b3ec:9032 with SMTP id
 r3-20020a0562140c8300b006a0b3ec9032mr6161594qvr.12.1714757145119; 
 Fri, 03 May 2024 10:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG26UzKKHBWixuS7gxAUy3Tc1WDQNOA42TnpChg+aVt1vdUontq2IyXMraUqKyf7U0Zi2vFtw==
X-Received: by 2002:a05:6214:c83:b0:6a0:b3ec:9032 with SMTP id
 r3-20020a0562140c8300b006a0b3ec9032mr6161539qvr.12.1714757144736; 
 Fri, 03 May 2024 10:25:44 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 e17-20020a056214111100b006a0d0c6ed22sm1383773qvs.98.2024.05.03.10.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 10:25:44 -0700 (PDT)
Message-ID: <7934395b-3e86-4dbd-898f-ff667681c8fe@redhat.com>
Date: Fri, 3 May 2024 19:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga/commands-posix: fix typo in
 qmp_guest_set_user_password
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20240503171333.241463-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240503171333.241463-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 03/05/2024 19.13, Paolo Bonzini wrote:
> qga/commands-posix.c does not compile on FreeBSD due to a confusion
> between "chpasswdata" (wrong) and "chpasswddata" (used in the #else
> branch).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   qga/commands-posix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7a065c4085c..7f05996495a 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2173,7 +2173,7 @@ void qmp_guest_set_user_password(const char *username,
>       }
>   
>   #ifdef __FreeBSD__
> -    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
> +    g_autofree char *chpasswddata = g_strdup(rawpasswddata);
>       const char *crypt_flag = crypted ? "-H" : "-h";
>       const char *argv[] = {"pw", "usermod", "-n", username,
>                             crypt_flag, "0", NULL};

Fixes: 0e5b75a390 ("qga/commands-posix: qmp_guest_set_user_password: use 
ga_run_command helper")
Reviewed-by: Thomas Huth <thuth@redhat.com>


