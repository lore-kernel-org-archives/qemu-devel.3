Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9BEDE9BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7gY-0008JV-Ba; Tue, 10 Sep 2024 16:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so7gW-0008IV-TO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:42:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so7gV-0006e9-0Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:42:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2055136b612so73126105ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726000917; x=1726605717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x8ZewR2Ywnw1nVv42A/kluUSpAUJV04mOosckB7VMZo=;
 b=r2kYalc8zXM7ETiA7eNvtj094ZOqD3exJdKfduOGudytKqW1319jIJUCemsACyLzok
 o1sXuOSn4qBrbVOUJrM3sO9kFi+bb+EJlV4kcuRCnr5Lgo+plwOzDCIaKVlv7sGfshJQ
 hbBNntw/I9No6/+UHc2m0WpJ04EOxshFdKRc9ALfI3zOUaqjkEHSjsxjG2lzjJrZ4mpP
 9NdMRQN9y+8wuo5HC3neJXcr/1gyoWczRE3B1ml+yfge1P84rQxdsVfejBDwua014MtZ
 w3gCGHw1E/mVaKBRe9LoZy6GU0DHn3rqwiQgwbKrQ/rYlNeaIcmysEE+21XipA4fA3K9
 Njwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726000917; x=1726605717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x8ZewR2Ywnw1nVv42A/kluUSpAUJV04mOosckB7VMZo=;
 b=JGURqYbb076Lznjh3uMNsZcohfAqhSwwrauQrjDas1vNygC6YI5S9uH1NWUsDcOUd3
 mljvuVlL8n8SHL/6c2+4Sr0Yxln30s0MiVrIMQxScHmqP543G41Jj7nJxwKM2A39iANN
 STU3MhVipCPX2zL+wIUHOv6ftBOhGcVynVyIF66Iha5U59vnBIpSLaHt2rn63H+w8x4w
 rIWz1Gi8nm0nsGJcZWPTl9xdy2NUK+4eF2lJfkqWLa8bttg2n3jsBlyJjyKq1LK3KzV4
 mCrHClLmhdpX9eUJkonEU1L5VqYCXgw0JRtLTFWo3JjEjiCCzomCcbJhV0uwK4R/2EP6
 8dpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUIU53hJTCds+08tePk25NEueMOZGsU9MZLNidzA4Q3aAEH8gzphfz23A7SCeYOmv76ve4vwRMGhpU@nongnu.org
X-Gm-Message-State: AOJu0YzsHN5yCzwLffiAyvvqQ6jWwHjP2FeWxb5g8zCV0bk+6OcwtLud
 MI+Vf0i2SOVvLGNPZwrK4DL5uap2t6BHHvQ2Kr5T3aJXUAkfiDhOrf/RkVwvlXWm5dV8io1OJOa
 i
X-Google-Smtp-Source: AGHT+IEVQ7IcxZhNwncNE/O2GJ3a0fir6mMpEKC/91061cA3gIEfGxAtEyskkW39xfSQ09QQ4l7EOQ==
X-Received: by 2002:a17:903:249:b0:205:4273:7d65 with SMTP id
 d9443c01a7336-2074c5d891dmr31153285ad.21.1726000916941; 
 Tue, 10 Sep 2024 13:41:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e1b04csm52370715ad.23.2024.09.10.13.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 13:41:56 -0700 (PDT)
Message-ID: <f11fe7d8-8575-41af-b8dd-6205a07903b2@linaro.org>
Date: Tue, 10 Sep 2024 13:41:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] tests/docker: remove debian-armel-cross
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
 <20240910173900.4154726-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910173900.4154726-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 9/10/24 10:38, Alex Bennée wrote:
> As debian-11 transitions to LTS we are starting to have problems
> building the image. While we could update to a later Debian building a
> 32 bit QEMU without modern floating point is niche host amongst the
> few remaining 32 bit hosts we regularly build for. For now we still
> have armhf-debian-cross-container which is currently built from the
> more recent debian-12.
> 
> Message-Id:<20240910140733.4007719-2-alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/container-cross.yml              |   6 -
>   .gitlab-ci.d/crossbuilds.yml                  |   7 -
>   .../dockerfiles/debian-armel-cross.docker     | 179 ------------------
>   tests/lcitool/refresh                         |   6 -
>   4 files changed, 198 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

