Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BFDE65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfvu-0004Zt-4p; Sun, 01 Feb 2026 17:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfvs-0004Zd-Kl
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:28:40 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfvr-0008D9-4X
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:28:40 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327555464cso2672043f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769984918; x=1770589718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kILN9RsY8Bq7CjBLBzJFbI8HbIKDclq9W4GPdi13/A8=;
 b=m8qdycNthi/seJy9cDUUqrBqq5tknevmPk5IEj29lliOKcrTREHj7pYBCGh9YL2KPo
 KD0ZGTRPRrRrXQeP/AYmF2YzYYVyB9uzvUcuZZcf+EpsJU0In72qkOgY0mpK2UyQ76g5
 24QvMwIo7J1nXAZIUCBEIRYBGBvgV/iZZdndSAoeMqHXCNG4Ljj3w9RQsFFjLnuvdrKr
 zj28G1/qO9QLkZhKBljSIhJOYJPD2CSSl4fEgu60LtBZ1/JXh3jPEbN247RIqy/mU++X
 qBNIXoIZ0u8rq/Pgrhrtpg54NTP5J3DSDvkNysWKk87MlwX8E0L4KBf2yi1mF02+F6Hy
 /2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769984918; x=1770589718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kILN9RsY8Bq7CjBLBzJFbI8HbIKDclq9W4GPdi13/A8=;
 b=cfNqdmpzFuwan/oQCka16SEaJ6TELlihNDn9cH9d1Bp26sF8IlqtB0LmT9tMh8Vaw+
 5i14sYEIPvtBu8P4528GF/1SXVFH/P4zEwjEFOBiirDZcxvEcPMswrhH9xktc7g9JKR+
 SfXiA5654GXyKN/xHLC5l00ym9DDdikN5SMBoUfvFGkNCf8tzfaCMOksjN2atMq6KhnG
 NuJVVGnr+4xnm4M4PderZB0nv9amxOoziKzshGkLo3VpYKsj+H8EK1s9AB//e0plSFdw
 1EYyZ9jbS9e6NCs9N1eBKsSWbyPtL7bE8kd5h1KvsudMlk8SgXXJNQBqOeoDaOfb8h8+
 SQ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxmUlkJhVCqhHrnX1ie79/LX+MtrHWayEFZMqBAYfpc5i+JPBQ44py3C5YuDmqQOlVcC4TGC8o4m5Q@nongnu.org
X-Gm-Message-State: AOJu0YyfG2MGQwc5Y/tdE++tOrIym5tooq7vmnSrlX2n5rSUpxt23Fwe
 UAGLJ3+SOhr7WAkITISmHnGLeFXv00Idba6cV/tidwzztXG5j5t60lFdfkMCHI39bt8=
X-Gm-Gg: AZuq6aLLI8UJ0IIsoFE/vDxuCVYs1Jpsw6J6+PCir6n9hvgu37wAR1C8lxtucPrjU+I
 3MIlCaQHhCyBSFG/c6HXzAHmm9Fm/s0/r+Ekr9Jpa2Cu53Ii93LqBaXRssyhuFoZHiH88GiUccI
 A9VpT94Xpf72hXtG1gCLn3ok3srtohd+iAiknqCojGD9flVm6OOAbqlEB1E0akSrlrkVsAn8ZmR
 ycFBkAxTcEvywuxNfoU+RPXwvlfI4WDaNYDeAzYijfPQLgQVS5Fp3/uCaB8lOK7GDCCmxNpaN27
 eyqQv1/Y2Hb0oaUnK/46TaJgMJnGoLvRTb8uHimhV1At96ma+Zj/svyLyHKeSPX3RVkH3lO6IAT
 VxJ9PN4N85tnYcJpyDQ+PMgd3sKAwswO7TByNthhnFxwfDTzHOpfl2V0vuexuj57ZQDECjHVJKP
 ugY09iCn4pP6gsK8qOMtiDKYAdv24L59mJJqCm9gw03BE4kQ+G01QfrZH03bX79kKe
X-Received: by 2002:a05:6000:4023:b0:432:851d:35ef with SMTP id
 ffacd0b85a97d-435f3aaea50mr13813341f8f.42.1769984917685; 
 Sun, 01 Feb 2026 14:28:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322f40sm38259862f8f.34.2026.02.01.14.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 14:28:36 -0800 (PST)
Message-ID: <a3448604-f82f-415f-81a6-b7327f689513@linaro.org>
Date: Sun, 1 Feb 2026 23:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target-info: add target_base_ppc, target_ppc and
 target_ppc64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260131020100.1115203-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/1/26 03:00, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/target-info.h | 21 +++++++++++++++++++++
>   target-info.c              | 21 +++++++++++++++++++++
>   2 files changed, 42 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

