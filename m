Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C33DC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s0y-00034P-Sw; Tue, 14 May 2024 09:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6s0r-00033R-KJ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:16:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6s0o-0001rf-Pt
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:16:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34dc129accaso4164487f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715692566; x=1716297366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WeXEwRUjiS6plqhWQPVpjW5hZZRYujgYnfUDqCZ/zj4=;
 b=SrLO2sF0Y182f7kpzoi9JBzycP61rBvVQ0rfTwkgz71hTZKbP4o+kLYwPfEDh9oLns
 K2y906hvUiXt5/Iu1rjTAHcAqB2ed9iEF8OxznQdnaRtl4Ed6q33FMTIa6zCImc2jgGt
 dkX6+aKE3DO4ZDOcaE6sQt64869aRtXPbdJ27XuAc6Oruh9MSbbOVd2toW0oZjj6OHUA
 eyC8MjU57A2E1pK/DRy6Akqjsk0u1gcItWo/z2P93QUK78P3DsBzXSf8hsjedj3G1twF
 iZpBwQXGq6WCaa9x1CSlpx+xckl5GgPNaPmAKzImr7vnVNH3DP4mHZyuJvkb0mpNbGrZ
 w+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715692566; x=1716297366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeXEwRUjiS6plqhWQPVpjW5hZZRYujgYnfUDqCZ/zj4=;
 b=PHmWOxwq+HqvP9C2sCktgbfRwlnKFkIC4mI3peNcfPKXIwJSRl7KHuuorMuWPPDQJS
 AxTdnuNTJ8dY9I/curKQBx+MAEPTUhUjFnMRznOQRQ2PXVl44SXSoZ+M5AUle6nV/76v
 jKMnBm1L/FKKiDiER23q92kTa5FI4x4ZNn9O+glMV5/PY0gFUnuKKwALVZ36dGt30hNQ
 LqKPI/pc/ekuk6klNF4lQNLhZ/rP9uvp9jBg3pXQSUOcrymJm99+B0KUlIGtqlpvAgGF
 w94gZMHFOJh9qEIaswtNwJzgPlxGUgFjC8rEHxw2hsShYXDEm3ejRp0qOrWGbB7HJjaz
 jylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgtZ5nkPD+HxvhYkpcrMCNIHSRLGLFNu0nQP0SSFSnNzjVIvAuvd7P/ZWlYzoHRvLoYSEg2wBGe5AFMgWI3X18gPATRxg=
X-Gm-Message-State: AOJu0YzUKX2zd8U7Y8kfFXivnawkWzc80BhxMitiWP3oUQCeEuHqMG9G
 hoxYE9Wzdtm0kFUsLaPmrVfyluIDopYI0g3Pqd7s6s4oX7s2Xy/qjQlUb0qW5tg=
X-Google-Smtp-Source: AGHT+IHKoHygPOYIqV0/EAUFeg9C6390hm0Qx3phOQ1WML92gbqwRCpUQ5MKEmpHJUi2aF9sJQvfnA==
X-Received: by 2002:a5d:526b:0:b0:34f:5d07:ebd1 with SMTP id
 ffacd0b85a97d-3504a96a716mr8604968f8f.56.1715692566215; 
 Tue, 14 May 2024 06:16:06 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8969fbsm13611472f8f.37.2024.05.14.06.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 06:16:05 -0700 (PDT)
Message-ID: <1bd87f96-6f92-4552-8be2-2a3a6f6e6a4c@linaro.org>
Date: Tue, 14 May 2024 15:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qga-win32: Improve guest-set-user-password,
 guest-file-open errors
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-2-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240514105829.729342-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 14/5/24 12:58, Markus Armbruster wrote:
> When guest-set-user-password's argument @password can't be converted
> from UTF-8 to UTF-16, we report something like
> 
>      Guest agent command failed, error was 'Invalid sequence in conversion input'
> 
> Improve this to
> 
>      can't convert 'password' to UTF-16: Invalid sequence in conversion input
> 
> Likewise for argument @username, and guest-file-open argument @path,
> even though I'm not sure you can actually get invalid input past the
> QMP core there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands-win32.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


