Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44223C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFXu-0004B9-Ke; Mon, 18 Mar 2024 12:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmFXt-0004Az-3g
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmFXq-0003TR-Nw
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a7SgiUi3gViHT3d0FdZTNSb0HGdDeJGVSeEzrKfPFHs=;
 b=gaRt4OIsC4YZQ9zZ/zk24COf2zpntvhc0CVkw2GyJEwWl/EEpSTZHholIsBDkFU+Au0ZwR
 HsTTjELrIR+oHJki1hy0/zcPSjwM/WNmfdzCydthMlcOKNP60IWU6/j1HBDRLNZqX1XUkM
 N9GhV2/dwO2p1LLlNnq4qgWH7J5O5hw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-z3MiGnv7PRCk4gwpOuYxGA-1; Mon, 18 Mar 2024 12:08:57 -0400
X-MC-Unique: z3MiGnv7PRCk4gwpOuYxGA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34176bb228dso432871f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778136; x=1711382936;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a7SgiUi3gViHT3d0FdZTNSb0HGdDeJGVSeEzrKfPFHs=;
 b=cl0XiUsujI6vwVca0Bggaa2NcwSuIYT9ACCGosWDXCZF3qHCiRYq8SwO6Lzs8Njgbb
 dj4QmVZoTiUkrUDJcRUCC7C8UEJPpN6zBUOt8o7YVnd4R97gMzTk21AJD9zEJH31i1xh
 yVIqHNXPq8VmRJNjQCMRTrM/z1EaLzdrPQ5Yw7oj6ZXA6yWlm1ddpeyW719CyTBUtrsX
 +UMu+QkpaEePGQNWgaRye9KF1cvopjSkQAfCsk9v/xRUgja2HPzoIwqSolIiiXQYq17V
 xhqQtNFtQKQzMCR2Lf7ZC2Mqt8wJa5qq8RMmfJ/O42JeB7w9HEMn5kczpUQamE5luukL
 DvCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJpY9bgdQQZXiEEt/AA2r6/sAO2HSwQJnWH+abGk/fg5y2vSoDXlgGm8c2iAepozHVARiGnCT5aVoyGCahM5qU84WOjl8=
X-Gm-Message-State: AOJu0Yy+EAniCw2f1ya03Mcrr+b1bxpT/R7IgKyYT4+Ivl/XOFOqyFTe
 vhYf3D0atOxXxK9bSsKzTC4NMVJJMd1Pr7qk3DcBx45K3m18i9j/VQZYZ0eSuIBicsaNulyEw+m
 jP06SDkjgdn+woY8hHsi+hl9WYDJIgEUF4oyAVl+bgTFYV1IMF/NQ
X-Received: by 2002:adf:f5d1:0:b0:33e:7650:58b4 with SMTP id
 k17-20020adff5d1000000b0033e765058b4mr8020677wrp.27.1710778136623; 
 Mon, 18 Mar 2024 09:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1tbiWVW8u9OqsOhu85t0PSRrXA6zIOdIaMUD1R7nO8+MzNAgeqwjKiuGup11TbsOR9+k/KQ==
X-Received: by 2002:adf:f5d1:0:b0:33e:7650:58b4 with SMTP id
 k17-20020adff5d1000000b0033e765058b4mr8020661wrp.27.1710778136239; 
 Mon, 18 Mar 2024 09:08:56 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-251.web.vodafone.de.
 [109.43.176.251]) by smtp.gmail.com with ESMTPSA id
 l15-20020a5d410f000000b0033cf4e47496sm10075119wrp.51.2024.03.18.09.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:08:55 -0700 (PDT)
Message-ID: <10a2b1da-2d5c-40e4-90a1-27b7b344669e@redhat.com>
Date: Mon, 18 Mar 2024 17:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Fix error message when C compiler is not
 working
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240308060034.139670-1-thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240308060034.139670-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 08/03/2024 07.00, Thomas Huth wrote:
> If you try to run the configure script on a system without a working
> C compiler, you get a very misleading error message:
> 
>   ERROR: Unrecognized host OS (uname -s reports 'Linux')
> 
> We should rather tell the user that we were not able to use the C
> compiler instead, otherwise they will have a hard time to figure
> out what was going wrong.
> 
> Fixes: 264b803721 ("configure: remove compiler sanity check")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index 3cd736b139..a036923dee 100755
> --- a/configure
> +++ b/configure
> @@ -411,7 +411,7 @@ else
>     # Using uname is really broken, but it is just a fallback for architectures
>     # that are going to use TCI anyway
>     cpu=$(uname -m)
> -  echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
> +  echo "WARNING: could not determine host CPU, proceeding with 'uname -m' output '$cpu'"
>   fi
>   
>   # Normalise host CPU name to the values used by Meson cross files and in source
> @@ -1000,10 +1000,12 @@ if test -z "$ninja"; then
>   fi
>   
>   if test "$host_os" = "bogus"; then
> -    # Now that we know that we're not printing the help and that
> -    # the compiler works (so the results of the check_defines we used
> -    # to identify the OS are reliable), if we didn't recognize the
> -    # host OS we should stop now.
> +    # Now that we know that we're not printing the help, we should stop now
> +    # if we didn't recognize the host OS (or the C compiler is not working).
> +    write_c_skeleton;
> +    if ! compile_object ; then
> +        error_exit "C compiler \"$cc\" is not usable"
> +    fi
>       error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
>   fi
>   

*Ping*

Does anybody got some spare minutes to review this? I think it would be nice 
to fix the error message for the 9.0 release...

  Thanks,
   Thomas


