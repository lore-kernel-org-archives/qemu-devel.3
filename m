Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F05AC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD40w-0004LD-9T; Fri, 31 May 2024 11:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD40t-0004Kj-PZ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:17:51 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD40r-0006kX-VN
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:17:51 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6302bdb54aso268501066b.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717168667; x=1717773467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pflu6rB3hNoWWDoKWHqul0viszTggnCsNgrVgRIuZLg=;
 b=ARfcVibFs3ml/Ia9k92PoATdbmunYfcu2msoFhC0x1bMzmpoloSUbn333FG48e9l7G
 5u25RCqnBXINR+SHZTI2yT7OSwnaqupnLtrHTQxoi7Tn9krVLk5yafXGOevZTGGRWjbI
 8dPeET8aFvDGUbLYazu4iMt68aiya4LAlZXxA4D0RpZWDugDVXsc86wGh8LasGN63RH5
 lNANc9u/KM0JudIRFQQMp7MlX89ZqmGJn8iyDQMXkUyS+Ag1janbhFNLz/2gSbJdzxbf
 XNg4ohu51E1nF++Sttha46+rtDWM5ELLyFIA6Zo0pyX4F5dFpMcM15ZHmnMauHMgqhDE
 0vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717168667; x=1717773467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pflu6rB3hNoWWDoKWHqul0viszTggnCsNgrVgRIuZLg=;
 b=B8qi9de3SUrTLvGR3+unvMnckqq+AIUnjlZHq2D9mBesssjp9w/Ndsvi5bP0dWBoz2
 x5rHmBUpDUP3AJxTeDo1wvk9PJDXcuH44KsFggTwzZxlW8mt9YeMyfJaHrYvnP517FVu
 oo5qMXCijBy6DPKCffGKxMpQ8guaRubB2G9aYIbVzytGH+iu2vCjsrtUpJLyQNCuEu/I
 QqjH7BKVnDhov9D9NYsbwVvX+TNVq1aoCkMzxsAR+mltoU2kZjQQCpaEbO9y9AUi8eSl
 HGKbXwcS/R9zZ6/Qqo6PjG5RfBim6KYe/twVzyjqYf3wN5U099XE6zxXiRwZ4iE/j2WF
 ruWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucP/JQIZz4lDZtpSIaS4q7rI753J19FGfcAuRt8Q8UK0RYp0IF5JZgR8CURDyaNyliwFYh3BSXqfslj3DHP66sM3YGfA=
X-Gm-Message-State: AOJu0Yz9VIpw9aQymKGlPSdtKXHHii3RnYk/t6GTxRxSb1XRONeu4703
 PjOwaEJncfiDXcYwcdw75WI5ZshTBJqlKhoRE0BJEsDQVRm68WhRM9OrYoQuK4c=
X-Google-Smtp-Source: AGHT+IHdTpMxBUQhjBPGAHU2IFgDRjVQLF4d/v30mRoOBHKdR//mdptewpJmN9htR1n3WxQJFmdgVA==
X-Received: by 2002:a17:906:1be2:b0:a62:d348:8df4 with SMTP id
 a640c23a62f3a-a68205176ecmr153988366b.30.1717168667073; 
 Fri, 31 May 2024 08:17:47 -0700 (PDT)
Received: from [192.168.230.175] (109.171.88.92.rev.sfr.net. [92.88.171.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6848423bc9sm73725666b.147.2024.05.31.08.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 08:17:46 -0700 (PDT)
Message-ID: <77a5f792-6caa-4dd9-9de7-e13224573f30@linaro.org>
Date: Fri, 31 May 2024 17:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/coverity-scan/COMPONENTS.md: Update paths to
 match gitlab CI
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240531142145.482361-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531142145.482361-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On 31/5/24 16:21, Peter Maydell wrote:
> Since commit 83aa1baa069c we have been running the build for Coverity
> Scan as a Gitlab CI job, rather than the old setup where it was run
> on a local developer's machine.  This is working well, but the
> absolute paths of files are different for the Gitlab CI job, which
> means that the regexes we use to identify Coverity components no
> longer work. With Gitlab CI builds the file paths are of the form
>   /builds/qemu-project/qemu/accel/kvm/kvm-all.c
> 
> rather than the old
>   /qemu/accel/kvm/kvm-all.c
> 
> and our regexes all don't match.
> 
> Update all the regexes to start with .*/qemu/ . This will hopefully
> avoid the need to change them again in future if the build path
> changes again.
> 
> This change was made with a search-and-replace of (/qemu)?
> to .*/qemu .
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As usual with COMPONENTS.md changes, somebody with Coverity admin
> access needs to make all the changes by hand in the GUI once this
> has gone through code review :-(
> 
> If there are any other changes we want to make to our component
> regexes, now would be a great time to suggest them, because this
> change is going to involve "delete every existing component and
> recreate"...
> ---
>   scripts/coverity-scan/COMPONENTS.md | 104 ++++++++++++++--------------
>   1 file changed, 52 insertions(+), 52 deletions(-)


> diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
> index 1537e49cd5a..98d4bcd6a50 100644
> --- a/scripts/coverity-scan/COMPONENTS.md
> +++ b/scripts/coverity-scan/COMPONENTS.md
> @@ -1,157 +1,157 @@
>   This is the list of currently configured Coverity components:


>   block
> -  ~ (/qemu)?(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
> +  ~ .*/qemu(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)

util/block-helpers.[ch]

I'd put hw/block/ to another bucket that the block subsystem.

>   char
> -  ~ (/qemu)?(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
> +  ~ .*/qemu(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)

Is 'char' the same as 'chardev'?

>   crypto
> -  ~ (/qemu)?((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
> +  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)

Maybe worth covering host/include/*/host/crypto/?

>   disas
> -  ~ (/qemu)?((/include)?/disas.*)
> +  ~ .*/qemu((/include)?/disas.*)

Missing:

target/avr/disas.c
target/loongarch/disas.c
target/openrisc/disas.c
target/rx/disas.c

>   migration
> -  ~ (/qemu)?((/include)?/migration/.*)
> +  ~ .*/qemu((/include)?/migration/.*)

Not sure about:

hw/vfio/migration.c

>   monitor
> -  ~ (/qemu)?(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
> +  ~ .*/qemu(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)

Apparently the pattern is now foo-[hq]mp-cmds.[ch].

Not matched:
hmp-commands-info.hx
hmp-commands.hx
hw/virtio/virtio-qmp.[ch]
include/qapi/qmp-event.h
job-qmp.c
monitor/qemu-config-qmp.c
python/qemu/qmp/events.py
scripts/python_qmp_updater.py
tests/unit/test-qmp-event.c

Not sure about (not covered in testlibs):

tests/qtest/libqmp.c
tests/qtest/libqmp.h

>   trace
> -  ~ (/qemu)?(/.*trace.*\.[ch])
> +  ~ .*/qemu(/.*trace.*\.[ch])

>   user
> -  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/user/.*)
> +  ~ .*/qemu(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/user/.*)

>   xen
> -  ~ (/qemu)?(.*/xen.*)
> +  ~ .*/qemu(.*/xen.*)

We could match .*xen.* like trace (ditto other accelerators).

>   hvf
> -  ~ (/qemu)?(.*/hvf.*)
> +  ~ .*/qemu(.*/hvf.*)
>   
>   kvm
> -  ~ (/qemu)?(.*/kvm.*)
> +  ~ .*/qemu(.*/kvm.*)
>   
>   tcg
> -  ~ (/qemu)?(/accel/tcg|/replay|/tcg)/.*
> +  ~ .*/qemu(/accel/tcg|/replay|/tcg)/.*
>   
>   sysemu
> -  ~ (/qemu)?(/system/.*|/accel/.*)
> +  ~ .*/qemu(/system/.*|/accel/.*)



