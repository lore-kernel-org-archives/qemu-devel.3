Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDA3CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9J34-0008Rd-Ty; Thu, 16 Oct 2025 04:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9J33-0008RV-TR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:09:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9J2y-0008Dh-Bx
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:09:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso378666f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760602152; x=1761206952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDJM5CJvLhq/IwhCjx5ruuI3Bi8Z9OWr4WP8JbrbCSk=;
 b=PZIPFjXfvUeO8omTTyBkXG+o1Pt9iNR2/LKrb2S3aj4KfE3gjjSKr/FrOJC3grhom8
 VUPKXSf/eSV9gFmvCqcJRrHLU8fsQMNPHtPmr8zYKI7/3BPM/fFQz/Jjytx8hh0428uG
 VK3zzySA2LKVBifz1mCJqGDjRel7uP0IwM79dW+Anli3aYFItN+EF6wNRxXkMEr4e/gh
 2ABxcIGvmcfQd9+47Qa8XfB8IQI7rSdekZVXaRHb0nz6UNav3ey3ex1Izy3gII7MTG7k
 WgOrt/+gI3uJasWPaXP8JE5yuwcWoO/YRb342rljeTJoS3hA+xv3lIN54W5sJnumg/2r
 9DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760602152; x=1761206952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDJM5CJvLhq/IwhCjx5ruuI3Bi8Z9OWr4WP8JbrbCSk=;
 b=lwgoRmQZrpTTkgls9IGHt2ERuoCsXmEy1sVtddY5ocdDtQFKmN5V2lICvxd4I/WDfo
 TmXrkTrw+4TVhZH5xU+jVDVgrStGrClPvy0LNf62bD7NT9qqZaRyQN5y6wn/YBYDf+ci
 1EWzLRC1dCExxP8leeP5PHEihOGNKb6TFuMtdTaM+jvZf7PjePbl67+Mn72OZcEATVKV
 Wpc0ZC8x3wRbHEjUn+siZwzRrE1jOK3K40MtKUCOXpN8eNQMSmDYLsLN+pm5BpIwiVC/
 hqLo9LZ6Prqw42R8q1ze7icGG7d6o6SoifC6E1TUnM6brvaSVmpm5Urucr2OuznH4exl
 itPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZEXb0aMg3Pc+b1zRRphwkNrThJqfAEBbOa1gZjYUPvsn+Z9FhUkw60aCrW3v1rxhcLpsQ5qnieS2A@nongnu.org
X-Gm-Message-State: AOJu0YzKeMtMJqIUW/NoSkCvumV9Wha6IpKzczLQUIv3Pat4FIvok4Ab
 wS7qpN8c6pqT4uhlUz1+FIJLaB3TI3gdzBSnIkBPGvPtMrD9eyzjgRcIGdpdLwsRB34=
X-Gm-Gg: ASbGncutqjEEBxqplxaLuYE6f5T1EI82i6KgHFSUSd9dRrwtBGDgMSkXIvP1U2CzRfg
 5LxCWZ9vytvyqo7huClqQ/ene+XrQDVkJX2hmZsSIsoalmEj9FkC3OYV3ig3DfqqEtdl8fu1LsC
 XeXVCSANau9Vwm3W4dQDmy9ZD39NH138QWWvpdlco4ycNCtpLKt4jDOfNqaX5Z3ev6Qq8mSKPTH
 KbxoquL0gReYSIqZt9j1Q+YnJZ4NgtUAv1qroUtnW/img0sUGFKHQl+iQOOini+HsBGhzdvcwfC
 fEEbJTLNCYtwHb7C9ZhKdMoWAhHsUIjKQ+Kc4vDZn+nWEsprVD5VxymQnf7u/IrsCEENWB4qLTL
 AMIiR8SUnz04m2F4JMJhxgF/wqLjas1BfGhZuQhg8uEeo0bn+Y+l5wm3rRwDat7hhkSjfReaXXc
 UD9/UwwVUQXR3qFSFVx2KG2fzg0i/MXA/NETiNhV57Ep2uaKK93O6/rkaiww==
X-Google-Smtp-Source: AGHT+IEYOzaD0JkH2I6NPgxZ+qsZmWkCzM5v2fXXjHr/2eKM++GXaDzZ5vYScygbueQrFMuIAr5+lQ==
X-Received: by 2002:a5d:5f08:0:b0:426:d56f:18db with SMTP id
 ffacd0b85a97d-426d56f1b19mr12450647f8f.50.1760602152005; 
 Thu, 16 Oct 2025 01:09:12 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm33456648f8f.37.2025.10.16.01.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 01:09:11 -0700 (PDT)
Message-ID: <da5919bf-2739-4d28-b27e-ab09bdaee97b@linaro.org>
Date: Thu, 16 Oct 2025 10:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net/tap-linux.c: avoid abort when setting invalid fd
Content-Language: en-US
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
References: <20250925023235.1899458-1-hzuo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925023235.1899458-1-hzuo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Nick,

On 25/9/25 04:32, Houqi (Nick) Zuo wrote:
> When QEMU creates a tap device automatically and the tap device is
> manually removed from the host while the guest is running, the tap
> device file descriptor becomes invalid. Later, when the guest executes
> shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
> abort QEMU with a core dump when attempting to use the invalid fd.
> 
> This patch removes many abort() calls in this file. If the fd is found
> to be in a bad state (e.g., EBADFD or ENODEV), the related function
> will print an error message.
> 
> The expected behavior for this negative test case is that QEMU should
> report an error but continue running rather than aborting.


> Fixes: 0caed25cd171c611781589b5402161d27d57229c ("virtio: Call set_features during reset")
> 
> Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
> ---
>   net/tap-linux.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index e832810665..24e63a0b54 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -206,15 +206,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
>       if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
>           fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
>                   strerror(errno));

Remove "Exiting".

While here, can you replace fprintf() -> error_report()?

> -        abort();

If we don't exit anymore, this function should return some value
indicating the failure, and the callers should check it.

>       }
>   }

Regards,

Phil.

