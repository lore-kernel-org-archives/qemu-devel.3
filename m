Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865C0D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRYm-00057Y-US; Mon, 26 Jan 2026 13:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRYZ-00053Y-Se
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:43:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRYV-0003HI-46
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:43:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43590777e22so2930868f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769452993; x=1770057793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSRnr+0jfdm3i9/MQlgeAZIyE0jGA9tauv+qqp9EIfM=;
 b=VmTgcn4eVHud/pFhGzuYMHIhcHLYDfFJxA3iHjvEoUT/LIdxf+c2D4i7pzurD9vgcs
 Paq6lEf+C6QPSM0Zl94pi8hCD4AA8G+OxJgInYiwUZHfHBnaqkKN5P0/s06wPJQwNWV0
 QDsiQwXcdvrNxiRBCZBTKXiiBRvG02TN+bLmsx2HpYIr2yQIz/YwN2UgTL14k06l5sVS
 P5ucEVRLsedDwFx4fnFaPkxWpTWc4zJBC2gu9znwOntauk/yZw96sMF7s9ZM+7EFjpGH
 lHTFpPfdBAPJ0OI30XoW9znDB4obQToWKKIdalqgPuJw0IADcinDBN0/ZVdmVSPgR+iL
 Xe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769452993; x=1770057793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSRnr+0jfdm3i9/MQlgeAZIyE0jGA9tauv+qqp9EIfM=;
 b=eRmelCB3zUjd4e6vlZ8jtpfJwMhB49LRVDkkWt8TtCW0Zwb1t/Um09TcspLkT8G6gb
 7DN6hROB6eAqtOWM+sLRPKb9bAg3Ao8Z1HuNIVn8DTVMbYZ+9l+8yilSNnJkI1hVqUkD
 wwBX5v8NH1mX7CMGPumA/c6LyE8CkAqimjwvt3Kv79mMFqkumBVozB9TtYZ3BSPdjG+s
 NOkkLYjPm4v2oMXs5koyTeAoSXAMC1SabPJckuIJBcz/2DK58C2tf4AaIsem9AynULv3
 s3nMZcgYRICztKHzQPH88tp2pt6cV+ui7k1Qn3PSHmB9EInvCEOJ4IwcKDlSZ9Hi4fqT
 bMvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnwIphmfCkjDejcVq+RGqLXe+oRNWV6ew5XrgqkJTFXGSg27XEQPqhF3SJEWabPQ/tNzxX3+Gi1SJ2@nongnu.org
X-Gm-Message-State: AOJu0Yx52gFa9xEciFwC9QiRmOjtwOXZJnfsUth1w13egr5jnafk4h8/
 2GoyPhMeFDer1tvUTNMjFLm/zhhi+ANitBtuaAvbOSrbZ5XqZ2JX/mgYOr12NDyd4Dw=
X-Gm-Gg: AZuq6aKUfKWjowCX9SxqzAO98EBZWzUFlpJbUGG8ULcFFlJ8BWlB/TOCer5GC5akL9n
 ljaonMzhUO6H1t8Xhjh5QMA7rtY7RruiOnGsXk5La44zViqeXvgSYub2bKZj8jhva5cFVLwQLpO
 aXHarvdtQOALXRemhbf2fRmCPim8oPmZdTL5Ud3lO8WkYRM2O4FJ1pM0Oc+64geNxRLYZQ4EZIc
 RhXjMkhajvG4kYdGxppehwtjyyHfI3rCmEUF61iuSB+WILVrHJOXQ2Xh7dFPhJyA2LZXNoErzdN
 +2FZEMY5ML5EuJpszBEQL49owq6nn5UAHf7GQEfVPCl+TvoMtyXiDJFxNol5Nyw3H5nGpkeelKy
 oAbjStlJaYXLKsZVUoQVm9urNdBHeF/oyTzTzzpshkl2EvG2VMivpVpBrEDW1ibPDUIoV6iW/dd
 +JIur8wZMYrpcVPG21A27vAz1iNzJXU8me7MKIJal0zNCu5QAu84fbRQ==
X-Received: by 2002:a05:6000:3109:b0:430:f58d:40da with SMTP id
 ffacd0b85a97d-435ca0d3e90mr8189441f8f.10.1769452993602; 
 Mon, 26 Jan 2026 10:43:13 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7c8efsm32554018f8f.42.2026.01.26.10.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 10:43:13 -0800 (PST)
Message-ID: <fc9a6837-f479-4b56-b09d-3489ec18587a@linaro.org>
Date: Mon, 26 Jan 2026 19:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/16] MAINTAINERS: update Arm to Supported status
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260123145750.1200879-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/1/26 15:57, Alex Bennée wrote:
> We are involved in lots of areas of the QEMU code base but as I'm sure
> most developers will realise we are actively funded to support the Arm
> ecosystem for both emulation and virtualisation use-cases. Lets make
> that clear in MAINTAINERS to keep parity with the other Supported
> architectures.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

