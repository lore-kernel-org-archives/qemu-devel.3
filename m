Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B2DC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttCfz-0001ol-Qk; Fri, 14 Mar 2025 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttCfy-0001oV-A6
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:34:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttCft-0003ly-6z
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:34:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225e3002dffso15665015ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741988075; x=1742592875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pkyiCkSz3Hbv17sQubB+87KnetoH+LGwIOBbxyEUqE4=;
 b=Q2de2HuDK4/7zA93Dr5U6VtCOZnlN54y+qn8n3rHvd8jQVyN6EWGQpz52klmyhFt1p
 9Bkumw83eHGsDA9uoHnrJep+HVnr7JA14nD7gV0A3llml0Ll6LSurlsV/hCIsfMjW4wQ
 f4nNbcR8eWRjO+FqD8CfDgzCLDvakXXmWHH6tJVtm1JKesn7/Wv/TZAWnXz7sViWL1i0
 gqBbXlM0r8ObeorbslxhM1S1eBUG6fh6AFqYLOxxggP9n6WgipsE+yQ2uTGoZxtBR1Fn
 qZugjGyUVdkEmv0Xs8BcGxjwnggkQOESCzM6iWY40/elyFViZuJY/lzO/jJBfSs72ZJb
 DQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741988075; x=1742592875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkyiCkSz3Hbv17sQubB+87KnetoH+LGwIOBbxyEUqE4=;
 b=TUdIJtkw1cWWIqcVj72TX1pT7FC/nBk3TX1TEqK9udW1xceIXk9pOLM7dj/PRL6XVU
 yQPVc7jbtvPHnH75w+51w8UsFk6gJOn98k9V6MEv8zoTgrKIUE6+XqrD1wz/1A5F8FHs
 nJU0Dog4Sl65VQHWu5BVMwzEZXJOMmVjMjTeXa69WvsdFwfF70z4m7o2VCN3GQR9AWP8
 x0aB4XzPDLi6sQ73SzkXpYAgfThJM9ehz9hokDgL1iio7q2sB+qDBvxjas3qKV29g7c+
 jGuz5kMTMyLT4j6rUHvTCjXER/z/LCPmB555K7vgzik4qVtssUVV7arGgB0a0NkNUjS6
 0sLA==
X-Gm-Message-State: AOJu0YyIyIxmSU0gRgWcjVZGUiX/rv6288dLWfOuP4/LxErDlclUSSOi
 3bJQ2MrxvvKZIv+WHUgABCvZxpVMO5Ecn06iVGfRBdjKm1gKEdHxCVkf5KvE9vJr4vxRDnLmP3X
 U
X-Gm-Gg: ASbGncucrk3dTe7TnMyS3lszS2axQgDAVzB/XRA9kA+nndlJVOos5AE1JV8aOveckBD
 Mb84HkL04rWStRgNrZ94TvDhcpZpGWcxlqTV4YXlSVQW98x/Ba1tUIaNM3pV3CAJR1CteciRpww
 uk8hJvZG38wO314oKo0GDIvNFuM41Mt4f+mzHeCKNekFSAz+1aa9p7WYqUG99vYfpEeaaZRqycE
 0nB/nQOwyYVet5IaoshBynkhTENIL7oWIldxRBpI0mxg8H1ORF+FKzgcF8W6an9XbApAFxMf/JZ
 jTuJfHv/sjEJLswA9BcYlB3VMtDF3wCofFbTo6DIa950O8Z0ymUVpImwzXi8bCmQu6m585A38md
 +8lc2TDQp
X-Google-Smtp-Source: AGHT+IH0dV43pHzbqaF6bWfW+7/e/Nlh4TP4ahfCNTDjn5qAOQSPazOTZ0JYGFif1YENJ2wip4CsUg==
X-Received: by 2002:a17:902:e74c:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-225e0a40bb3mr61265035ad.12.1741988075252; 
 Fri, 14 Mar 2025 14:34:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd5d97sm33124155ad.259.2025.03.14.14.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 14:34:34 -0700 (PDT)
Message-ID: <7b279eda-b079-429c-9aef-a6a9c4ec00fc@linaro.org>
Date: Fri, 14 Mar 2025 14:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
To: qemu-devel@nongnu.org
References: <20250314153824.65303-1-pbonzini@redhat.com>
 <44fc2b85-ab20-401a-9c71-54240bb1e503@linaro.org>
 <87ldt7gvr8.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87ldt7gvr8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/14/25 14:14, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 3/14/25 08:38, Paolo Bonzini wrote:
>>> -gsplit-dwarf is reported to produce broken binaries on Windows.
>>> The linker produces warnings but exits successfully:
>>> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
>>> qga/qemu-ga.exe:/4: section below image base
>>> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
>>> qga/qemu-ga.exe:/24: section below image base
>>> and as a result qemu-ga.exe fails to start.
>>> On top of this, also disable -gsplit-dwarf unless building from git.
>>> Similar to -Werror, split debug info is probably not the best choice
>>> for people that want to build for installing.
>>> (Random thoughts: there is a tension here between adding an option
>>> that is useful for QEMU developers, and messing things up for everyone
>>> else by doing something decidedly non-standard.  For example, distros
>>> are starting to create a fake git repository just so that they can
>>> use "git am" to apply patches; while some of them, for example Fedora,
>>> are wise, or paranoid, enough to pass --disable-XXX for everything and
>>> then turn back on what they want, it cannot be expected that everyone
>>> does this.  It may be safer to make --enable-split-debug default off
>>> for everybody and add it somewhere in docs/.  For now I am keeping it
>>> enabled but we could consider doing something different during the hard
>>> freeze period).
>>> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    configure         | 4 ++++
>>>    meson_options.txt | 2 +-
>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>> diff --git a/configure b/configure
>>> index 02f1dd2311f..9aece67ed08 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1864,6 +1864,10 @@ if test "$skip_meson" = no; then
>>>          { test "$host_os" = linux || test "$host_os" = "windows"; }; then
>>>          echo 'werror = true' >> $cross
>>>      fi
>>> +  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
>>> +      echo 'split_debug = true' >> $cross
>>> +  fi
>>> +
>>>      echo "[project options]" >> $cross
>>>      if test "$SMBD" != ''; then
>>>        echo "smbd = $(meson_quote "$SMBD")" >> $cross
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 3432123fee2..f3546b9abc1 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -362,7 +362,7 @@ option('debug_mutex', type: 'boolean', value: false,
>>>           description: 'mutex debugging support')
>>>    option('debug_stack_usage', type: 'boolean', value: false,
>>>           description: 'measure coroutine stack usage')
>>> -option('split_debug', type: 'boolean', value: true,
>>> +option('split_debug', type: 'boolean', value: false,
>>>           description: 'split debug info from object files')
>>>    option('qom_cast_debug', type: 'boolean', value: true,
>>>           description: 'cast debugging support')
>>
>> Unfortunate coincidence, this appears at the same time MSYS2 fixed
>> some issue triggering a segfault [1]. So I didn't investigate further
>> the current issue, thinking something else have been changed I don't
>> know where.
>>
>> Would be better to revert it completely indeed, creating another build
>> configuration is not worth the (cheap) disk storage saved.
> 
> Well we should disable debug info on the CI builds then. Nothing is free
> and our CI is pretty damned heavy and the builds all add up when debug
> info is on by default.

I think it's best reverted, since it isn't implemented properly in gcc for 
cross-compilers.  Add it to --extra-cflags for particular builds if you must.


r~

