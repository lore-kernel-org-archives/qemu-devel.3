Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE92AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s2E-0003Zl-Rg; Tue, 14 May 2024 09:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6s24-0003UW-K8
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6s22-0002Fq-Li
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f72a29f13so7433940e87.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715692644; x=1716297444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5TG9OOFRsD0samoPNFZIB3nd8nEq6R6PHHjOmvYM5vs=;
 b=tYyfxm2HSJr7h/7h67RfCRxapC87tpGLUTeiY6xhaN6H+9IryHNE8UhWMYgv9vui+G
 mdqgxB2VUTZSrhe7Ox8VkxM7EWUHGDTyKECk4Pp8R/3CKff6hOlSCyXuunrXTDebxpuO
 MTBUdIOpaSFMkxluVzaqYPa5Bu1AZ2KYMgg7THK9xiKZuGVI8/uPEgYFuCTG9M4h4GiL
 B1dco3NYbVAvMP2bPRU4v7MBX7vBjUzlZEWkwPGd8qsSSp2T2r3tteOUX0AfnEL5qAsL
 Lfwk81mc4PDiqGvwahaHEvIk8hPbqbkWU5cbQWRWJc1QBLQkA/wHgHPp1yfplFBpQv7e
 vDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715692644; x=1716297444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5TG9OOFRsD0samoPNFZIB3nd8nEq6R6PHHjOmvYM5vs=;
 b=AtUhsZ1wD4lTVm7DsLwsSd2AphSvaVYOtP1Yxddv7hoKhR0KHe9Aix/FgqOdmpncKR
 3tKpLJoewLAB5pbMFwdcugrkw2rNQFr4LsykxUGgfQ9HLBviCSbjNjH77L62+osIYp+E
 mOLwRhMjLV1ivZIJ/nqLxWxHOuL12aixxcqC+f1wc03sr6FSYYfBQFi9m1kntkdxp1lA
 QCLWdNU5gaYbc3VUYbWMXOwC0scOb7ocTdC/r6I4K1RCIewplkM5RhjePH9IBu9FXnZ1
 iVbluyXYHWdI4uhMysfHAtLITyn2n4CcWxcduJIR7wNNIDUUSg5MSnnA8lLs19sjPvvH
 0maQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVopO4DIf5EdClaSg1hem3AXX/rjNBmXvL0Pucqf2gEXpBtQPkWhVOVk0WlXmdS62l/0jgWUYFbvMBYBsg5EEAGXWrFN3M=
X-Gm-Message-State: AOJu0YzTxrI+UfpJ9B51Jvmu/nnPt2fIJt0vv4YMnM2hcYMIlquCmI+s
 H8KEN/o2dA/vWI4GRow0EgtqACFsnD6b4t1ey6eQC/BPJ9SLEHdiexYD1XlAhp8=
X-Google-Smtp-Source: AGHT+IE+f981Z0aSNmCb82dLJ9iTZgVL6sMRjsB2EVYkim3sI74sHkXwSk22DCcaPPeWZuKJGAHi5w==
X-Received: by 2002:a05:6512:32b5:b0:520:76d0:b054 with SMTP id
 2adb3069b0e04-522105845ecmr8525580e87.57.1715692644555; 
 Tue, 14 May 2024 06:17:24 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b895887sm13655282f8f.40.2024.05.14.06.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 06:17:24 -0700 (PDT)
Message-ID: <382f3435-d7a8-4cbd-a537-b7ca82d6df4a@linaro.org>
Date: Tue, 14 May 2024 15:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] qga: Shorten several error messages
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-3-armbru@redhat.com> <874jb03bbw.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <874jb03bbw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 14/5/24 13:02, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Some, but not all error messages are of the form
>>
>>      Guest agent command failed, error was '<actual error message>'
>>
>> For instance, command guest-exec can fail with an error message like
>>
>>      Guest agent command failed, error was 'Failed to execute child process “/bin/invalid-cmd42” (No such file or directory)'
>>
>> Shorten this to just just the actual error message.  The guest-exec
>> example becomes
>>
>>      Failed to execute child process “/bin/invalid-cmd42” (No such file or directory)
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> [...]
> 
> To be squashed into the patch:
> 
> diff --git a/qga/commands.c b/qga/commands.c
> index 27b16313ea..5a5fad31f8 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -15,7 +15,6 @@
>   #include "guest-agent-core.h"
>   #include "qga-qapi-commands.h"
>   #include "qapi/error.h"
> -#include "qapi/qmp/qerror.h"
>   #include "qemu/base64.h"
>   #include "qemu/cutils.h"
>   #include "commands-common.h"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


