Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA3C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wm0-0001OM-OU; Mon, 06 May 2024 07:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3wlw-0001NO-Qb
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:44:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3wls-0001q6-Jl
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:44:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41b9dff6be8so11628725e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714995876; x=1715600676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bUk6sZWSg9CNXZsq5ah5PkHoX97J9I57NZqTtlqNVBA=;
 b=P72JWf3E76cJ8IZY/hcBVfu53iwOKsuUb7TXlugxmAgI93xSZYhp26Lbo1euCEeUX/
 vauG24BsY3voZ5+RghpHgyLmW+oG7N3uAJ0nNa+sJ4kZ4VE+DuT6WDUIH7p4JOMssRTr
 mxEE1gBLHFFBp8RHuyukPXFXv6rwIVpAV9274Ydx/ItatIm4rP0052vOi+aeMiqxWQNJ
 7JoAssCHcTOUvMbdqkyjq6O0QY8s7Uj6BumYYdEddKK8QS0LklJY5/nRcGrCilv6mw5S
 fS28d95yy2e0CbKTMr2Bxz8STdd1B3yPS5SvT6CDw1d0mOTLJ26U6h3PkVlFf8jWleyQ
 Kv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714995876; x=1715600676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bUk6sZWSg9CNXZsq5ah5PkHoX97J9I57NZqTtlqNVBA=;
 b=HNsvc+fH31I/ZbQumKRsILyHBBb2DfSBz5zUybstk2fimK/7Wz8ACL/vYKbGD6dQoP
 EJpcKBleH2DEii0PCLiL+oKeb5o2uHfbW68qXMFDvXn9v25TTxEBnB0kt+kLw+ppcrNI
 1Ibh7MZ31ikK9nG5JlozaT7H0nSBXNw77lKrB1Lkjltamc4KTiC+mFIfUgrL72z9EOa9
 zpUutXlQOd47ZGQPIY/BaiqaCJQ5J6sC3OGOWzSNL33Zph7Cd3O7S4SWpHQpz3SStp7E
 PWzXPpigl76tXl8HlTKAzgCyxV0i6iJSfEn4FkCJmyO1Z7o3BrWmhQidexq/eFNrHtiq
 P1Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxBvZDgue/nzmxByfciXCJiJTHbnwaoOyulEcOzqDtoaK45fxQ3VPn0+93K+HnDUA4DTs5Mxys3fG4YP62r2LmnRss90c=
X-Gm-Message-State: AOJu0YwWox0jxN3qUEfPdjIe8EIi7x3r+599tS7qdTWj9gIL2R/FbvE/
 OxiZ5PhC7uhaOvCIiokk1gHfQ5kwNWxVSXo86fzqjrl/sp4e5HHQ6XXUDdUCjaWrW6v2iDAW54V
 R
X-Google-Smtp-Source: AGHT+IG+ZbvlQaoWGP+GPBflM1p6dUTpXNUkhfaFJ+Wo2P6urrzvO8+S0tgDk6hoCjMTuUuL0ymirw==
X-Received: by 2002:a05:600c:154c:b0:41a:5958:d6ac with SMTP id
 f12-20020a05600c154c00b0041a5958d6acmr7130861wmg.21.1714995876630; 
 Mon, 06 May 2024 04:44:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a5d64a1000000b0034edd6d5bbdsm4711630wrp.7.2024.05.06.04.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 04:44:36 -0700 (PDT)
Message-ID: <73ae70ff-0e20-437a-b5d9-72de6a948264@linaro.org>
Date: Mon, 6 May 2024 13:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qapi: make since sections special WIP
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240506110254.3965097-1-armbru@redhat.com>
 <20240506110254.3965097-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506110254.3965097-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/5/24 13:02, Markus Armbruster wrote:
> since moves to end in generated output
> ---
>   docs/sphinx/qapidoc.py         | 22 +++++++++++++++++-----
>   scripts/qapi/parser.py         |  5 +++--
>   tests/qapi-schema/test-qapi.py |  2 ++
>   3 files changed, 22 insertions(+), 7 deletions(-)

Alternatively use git-publish to send pull requests :)

$ git publish --pull-request --sign-pull

https://github.com/stefanha/git-publish/blob/master/git-publish.pod

