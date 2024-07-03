Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856DAC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvca-0006GT-HZ; Wed, 03 Jul 2024 04:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvcZ-0006GG-Hs
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:45:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvcX-0004bR-Qw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:45:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-425814992aeso21214215e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996344; x=1720601144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iQDG0C/zSXz5HIZc1f5kVnfrQXGPz2M/eGfPOYJf+6M=;
 b=Ctjc9YbJw/09hv13zXo0t6mLJK3dGdnV6mexCrsmZpUuKMebU8GxkWxxGH8U5FkRvg
 q+tkXxr6X6QynQsSXOB2e4PC69s1PMVBxuHYXRXnJOmnX5WupFIRkvAy2ofMRSYU95ql
 JMdvO5uOLHf1v0/R2+qAuir5UxJ2KkmHl6887K745DtkSktHPa4kG4yZmtuZyUuvCwUM
 F0rTDIDt7TK9btSjGmasOsK82FJjkpcsp+4Bvt0EjPAspnHM81m4P3m9Pjp3qSpJqVRN
 7I8l8jtoMGYJOaZ0CHCx4q9BbiKn4Qw/YrF5vjNrtWan6meXK9WOGdIWY1/3m5GNVFSo
 hz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996344; x=1720601144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iQDG0C/zSXz5HIZc1f5kVnfrQXGPz2M/eGfPOYJf+6M=;
 b=sCjcoGJegiTDOYBcizMR55ze6gA6GAI+UCBE1GGKZZYyz/fUZQ+eh4EQYxiWvmnOjM
 IVgdl7ZCOVFPjsdYHYK1vYY7JYxYbIvKOGOn9dVuJ4UTSn24zPY2HACeZPxsgIZpbyD8
 6wSxBv9BoLA7PzZi6aCLwAj07UqpL5oRjvHU0QA2ujZ7H66+GN4ZU8Vy1SfyNoNh/OD2
 pI2EyDFSyGRYd+AV0K33qS6NYzfpkQpSJAtzsm7pUb0bCQoyIP/Ly+K85nspdunddKun
 n7zHkDHoXYdfzGsyn2XBr+S1Nk+Nh3kAnFAa7QGfuXuMnm6yy4MkJ7kRL477+WxceoMu
 gOLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ0fb/m6WgLNR0vV/6OUj+dOiJChSftC4JABkQQgEc1MCTnDQJEKI7TvLHQ4wLANwOaUxpcR+rchBDl+62jRVp25PcjCU=
X-Gm-Message-State: AOJu0Yxbve/0L9/QNY6h+M+fMGlhydBPFSdrYLWcoquKoMzd6qmjIZZW
 3BB1R8yhF5P2DewNiGwyjOXLASGM9BEQGZDblyBZOD3knse4OcumQqj5Z56wW0E=
X-Google-Smtp-Source: AGHT+IF+/Yej9XaUkU4S09XcgpUsz59hCU42gvfvLoDQMqBQEeoqLsYZhRpu+OJe4EOi620HNa1l2A==
X-Received: by 2002:a05:600c:19cb:b0:425:6f96:8bcd with SMTP id
 5b1f17b1804b1-42579fd0d25mr86883685e9.0.1719996344140; 
 Wed, 03 Jul 2024 01:45:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d9c7f18sm143293645e9.40.2024.07.03.01.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:45:43 -0700 (PDT)
Message-ID: <66ffcc88-11c2-4afe-a78c-9a62138084bb@linaro.org>
Date: Wed, 3 Jul 2024 10:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] qga: move linux vcpu command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613150127.1361931-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 13/6/24 17:01, Daniel P. Berrangé wrote:
> The qmp_guest_set_vcpus and qmp_guest_get_vcpus command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-linux.c | 141 +++++++++++++++++++++++++++++++++++++++++++
>   qga/commands-posix.c | 139 ------------------------------------------
>   2 files changed, 141 insertions(+), 139 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


