Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0038ED3C935
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wBe-00089M-Sp; Mon, 21 Oct 2024 13:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wBc-00088p-CT
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:27:20 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wBa-0003fB-ER
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:27:20 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a3a3075af2so18818805ab.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729531637; x=1730136437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c3IS+X8h/ozkvRZAsKBeqDO187tvvQaB/SjIKwzNJsI=;
 b=u4XAkx6xhKFbGrga3laJmUB3embX4zWoxsnwjwwEp0gcsYAkjdF6g546rSJAAUEKuc
 TsuVY6D16T0okUR1imv+DwkgeQwH/7rQlmHwlb4phYkPALk0fIpdJ9cvvK/zzNpvTW49
 SFXzQOMbv+upZccycgS5u+z4K4tFWLgzFDeNFJFMy/eV4rj3h8fkx4l2M6PjGKvH8D+G
 1YvPCfEQ4AT1sY25J+lurQJjcswH0XuFjJ+NHANILbgyvUXK+n2xuHDQdDfGhaYJTcZS
 QL0FHQBF3Rbfmv3cwerDi56bEPnmThzwjSmagM8XBiEnmNxHRyhLBdterVBtQN4F8pGb
 Ynwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531637; x=1730136437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c3IS+X8h/ozkvRZAsKBeqDO187tvvQaB/SjIKwzNJsI=;
 b=Fq+pjhX/yj3/6IedC5f8x1mAHznTEZtqCIMOmeqQwsqcGyYZ1VI77AoRPzHUIqUrku
 jsuM7ybweWd4Hcn0dbHnYt7w6UgQedABj35jPpTnQe+oLuP5yqFwWvYEaN08mOicEffo
 ++Ym5f1QS9ChCKnLniYG2FDkETXuOxt9616oxlHiblHa/8WQYwNO5J/P4e38mX2UjDGE
 RR/IOv4g2SWHt6A3RfR6UD3lyfWA8mnfmATWoHzSxsYl8b1hUH8vIlgSnsaQMvsdXyYc
 vLDBUqCp3EzxCXTYVrR2TiQRp/mbNXhmv4S3HrtwNTOG0p+HNzSZbt7YSyDgBcvcykud
 fshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX87wq68NMEaIfFTvV+CbH4YU7mmMvhQmk1B4rztEzU9HyKoed9u0VxT278zx6H6d5VlMb2hAuRSlw9@nongnu.org
X-Gm-Message-State: AOJu0Yy7PbiwlKf5yCrfqxCGWlBJuy3MIcdOG34hw4miL5x37QeEap31
 ofiR/I1duPUuHveqvXt4unXmuYvPW4yVHA20Ezkh8l+pasj1wYR4YwD69kTHN2A=
X-Google-Smtp-Source: AGHT+IH34qZAeM8waCtrMRxYsT/OR8cpljbNq1iEyL1WAiSxxj9jrddGih97hU2qbv+fWA+hiy+0tQ==
X-Received: by 2002:a05:6e02:13ac:b0:3a3:e58d:cfe3 with SMTP id
 e9e14a558f8ab-3a3f40545f0mr96157675ab.8.1729531636738; 
 Mon, 21 Oct 2024 10:27:16 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab3d0ffsm3410503a12.38.2024.10.21.10.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 10:27:16 -0700 (PDT)
Message-ID: <5135e8bb-945a-4385-88c0-1b79208e8d2b@linaro.org>
Date: Mon, 21 Oct 2024 10:27:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Christophe Lyon <christophe.lyon@linaro.org>
References: <20241018130852.931509-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241018130852.931509-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x12b.google.com
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

On 10/18/24 06:08, Peter Maydell wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> must be parsed with shlex.split().  Otherwise the script will fail if
> the build directory has a character like "~" in it.
> 
> Note: this fix cannot be backported directly to any stable branch
> that doesn't require Meson version 1.4.0 or better; otherwise it will
> work OK on Linux but will break on Windows hosts.
> 
> (Unfortunately, Meson prior to version 1.4.0 was inconsistent between
> host OSes about how it quoted arguments, and used a different quoting
> process on Windows hosts.  Our current git trunk already requires
> 1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
> the stable branches are still on older Meson.)
> 
> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> [PMM: Updated commit message to give all the detail about the
> Meson version compability requirements.]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is essentially back to version 1 of Akihiko's patch, now we
> have a new enough Meson; I just updated the commit message.
>   https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/
> (I have dropped the various reviewed-by and tested-by headers because
> I figured the passage of time was enough to make them moot.)
> 
>   scripts/symlink-install-tree.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
> index 8ed97e3c943..b72563895c5 100644
> --- a/scripts/symlink-install-tree.py
> +++ b/scripts/symlink-install-tree.py
> @@ -4,6 +4,7 @@
>   import errno
>   import json
>   import os
> +import shlex
>   import subprocess
>   import sys
>   
> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
>   
>   introspect = os.environ.get('MESONINTROSPECT')
> -out = subprocess.run([*introspect.split(' '), '--installed'],
> +out = subprocess.run([*shlex.split(introspect), '--installed'],
>                        stdout=subprocess.PIPE, check=True).stdout
>   for source, dest in json.loads(out).items():
>       bundle_dest = destdir_join('qemu-bundle', dest)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I confirm this fixes the error when the path to qemu src tree contains '~'.

