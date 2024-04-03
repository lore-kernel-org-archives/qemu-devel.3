Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE3CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 00:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rro4L-0004IW-9s; Tue, 02 Apr 2024 20:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rro4J-0004HQ-K8
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 20:01:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rro4H-0001IJ-UA
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 20:01:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e28be94d32so3823185ad.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712102488; x=1712707288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nBHXEYcbUmQ+upSF9E/Gzmxw8a6C7Hdio2+PYmXiGqI=;
 b=YPtJgjZAWGvJI0VSSHMdZGSLP4UoDyVLHRKbsJX+/4w7H908LCFkcCirnLuu+JeoV5
 7Fkz7RcFw2gQxLu3Sf1HtWh6/xRhbecEMPkozFvMQDxo3BHfErei3TIVmYwRmln4wn76
 dHbcqNiH5hyozXtnW+5JyjbolunQEUHYovQIWcYnyUZOSWgSgdZ5QK0UGc0daL5T9Scu
 jPtBx6Erv82I3D9Ue1KLIpqeY/8hJ8qux1fCG5irtAed9vU33FScMqDtrAOuoVBLhy+l
 XLYxUjbRxkFg16R+0oWhR8nfmfJTL7kU/JjgwSCZDXUYlJH5a0/KWmeljt0ZwIDqKU+9
 KdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712102488; x=1712707288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nBHXEYcbUmQ+upSF9E/Gzmxw8a6C7Hdio2+PYmXiGqI=;
 b=uVPHhBAc2HVjwFrUKVUqJgXhn0KGBoJf2ezR+U2yXCUILpIsOfX1xPg60aMD5ggVIC
 3f8HKrY17VjGW127CTj+/zRXAr1NKJUfKAW82096u9rq2y4V4TJFeCjc8JpuC7HUg6rT
 yckTFBrOEohR1O/39jyQq636EoiB+92m8SHM+a/3xjsN5uUzN1eWVgo7tSewCjg2xSVw
 TDV1UJmiIazMk4OZbBuwGfib043ca+y4kuHaz5jcyoovixJoxq4Hv9WHgudml7YW1P5s
 QYszwjc1zvcsN6YCOCqEzY1YjFQLWxZ5JCUuDUTw1eY97gCotK9TuHPLaRjUIwWA6yeW
 4ANQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUd31KWv1VxLijkUSc+R4eDM7YKpyxm9B2B0PtXB+kPijMpIZjcPb1gmqaKv+fDWr0fHDlY87fUsuTZBGdMNIBxtjNRw4=
X-Gm-Message-State: AOJu0Ywf040mWnYvs2y+IfdsfR1gxQDwJr1NRhlp9sdd5scrFx73nFDG
 yfpxDvv9VvAOSIq48yjeMlj6HdDHNP+Lz+1EVN58QViZWZ6j89BpklNJe7EqGrmLpsy6nwmQIj4
 M
X-Google-Smtp-Source: AGHT+IHizzO+eGNbue+Ln0ceppM9bbKS+Jt0p0XCOlEiSkKi4e0KeBOY8m0k9YzBWdD9ALInbPBk2A==
X-Received: by 2002:a17:902:cece:b0:1dc:adad:f54b with SMTP id
 d14-20020a170902cece00b001dcadadf54bmr16506529plg.44.1712102487739; 
 Tue, 02 Apr 2024 17:01:27 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a170902bb8700b001e0573bbbbdsm11667328pls.218.2024.04.02.17.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 17:01:27 -0700 (PDT)
Message-ID: <533cebf3-9abc-4a3e-b8b7-59f1c1c0be0d@linaro.org>
Date: Tue, 2 Apr 2024 14:01:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/syscall: xtensa: fix ipc_perm conversion
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
References: <20240329223318.155572-1-jcmvbkbc@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240329223318.155572-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/29/24 12:33, Max Filippov wrote:
> target_ipc_perm::mode and target_ipc_perm::__seq fields are 32-bit wide
> on xtensa and thus need to use tswap32.
> The issue is spotted by the libc-test http://nsz.repo.hu/git/?p=libc-test
> on big-endian xtensa core.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: a3da8be5126b ("target/xtensa: linux-user: fix sysv IPC structures")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - split into a separate patch
> 
>   linux-user/syscall.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e1424890..d9bfd31c1cad 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3758,12 +3758,13 @@ static inline abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
>       host_ip->gid = tswap32(target_ip->gid);
>       host_ip->cuid = tswap32(target_ip->cuid);
>       host_ip->cgid = tswap32(target_ip->cgid);
> -#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
> +#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
> +    defined(TARGET_XTENSA)
>       host_ip->mode = tswap32(target_ip->mode);
>   #else
>       host_ip->mode = tswap16(target_ip->mode);
>   #endif

Oof.  I think we should rewrite these along the lines of __get_user_e, using 
__builtin_choose_expr and sizeof to choose the correct routine.


r~

