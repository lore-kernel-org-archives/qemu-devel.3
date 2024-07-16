Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD14FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfn3-0003nH-OU; Tue, 16 Jul 2024 06:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTfmz-0003kn-5X
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:52:09 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTfmw-0004HC-PX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:52:08 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70211abf4cbso3619360a34.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721127125; x=1721731925;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ii84E40ke4EeP+xXzYDBaA7V3jaCkKB2VhGLqcFZKi8=;
 b=mO6joOU7I4CDtrsoAptbEgfUqkywGrxM93rRhPMEP5Rq6EhCpvJt9XflizJLzO5LnV
 Fi539xVPqtUjlBQpYouTmM7TwFZ6qSC8y5i6/XJANiHc6o5OJLY6LdDMzZvgcYuR7BYr
 t22WPHrNbDMXvRhY8afYS6k3oZyfPzLegCyyaEFmXWwWfqwykrTn7zIggAoBV4ehtE9+
 NSNiGtFNm+IJhlei1EQPBQka0HoI+vQVfK1J1K62QWecsdx4rxvNQY1TZ+m0diarJrYc
 qT2ECJJ45H5/xPNFA5zS2n48UBma9u4dAfuNEyFNfvLVAM+JXbl/A4HOAHzb/gZf/0Ty
 Zalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721127125; x=1721731925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ii84E40ke4EeP+xXzYDBaA7V3jaCkKB2VhGLqcFZKi8=;
 b=eKk+Dln9b0VxRlMV32ISY2tK8oJdTXz1SgQKyGeIpnVu+DJdmuVlI0/94eyI02vatI
 moDaUMYAt4vx35Hx1609G3NgG9ENx3BuqaYK33R226NqEEqq37HVDfa0ApC+yDs7oI7U
 wrahRyY/Ga2dCooEcPTBU2yxfFE/DKv5oQDGaIGfgvXwq60gDGGNMVmlyj3AsbAJaaGH
 8UkHhvassEOanEWaAgjm0o35lMKowh7qHXb+0XehwtTRRSpDr72C35JAtmOzM6tmKBDs
 KTKaSUInxkv5J/SzyVtyJu/Po+65ucU7ipulPzVC5FPFKj3jVINyot7/fzavY5j9TORt
 MH/w==
X-Gm-Message-State: AOJu0YyHtzyDgFAP0gHDJDfUyVrEIQlTSIcWZMAsyZGTo+PKqCGegs+i
 rVUvVmNi2FMlrFL5pdsh96vV7wNIcpoEMZDY4advn+2SksOOt97Jxpn6fFRSAv4=
X-Google-Smtp-Source: AGHT+IH/9PuJhO8xiPBVwEeA44XEGiA9WG/+ohjMh4FRAqp8OnNexooJEtQVggA92lKq9V0/7bLfjA==
X-Received: by 2002:a05:6830:3988:b0:707:8b7d:b924 with SMTP id
 46e09a7af769-708d9942fc9mr2031344a34.10.1721127125411; 
 Tue, 16 Jul 2024 03:52:05 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-78e33bbb4bbsm4654630a12.27.2024.07.16.03.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 03:52:05 -0700 (PDT)
Message-ID: <087e1eee-e7e3-4147-9c8c-882d458c1abd@daynix.com>
Date: Tue, 16 Jul 2024 19:52:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] util: Introduce qemu_get_runtime_dir()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <20240716-run-v4-1-5f7a29631168@daynix.com> <ZpZC8AaUJH9WW6uF@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZpZC8AaUJH9WW6uF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/16 18:53, Daniel P. Berrangé wrote:
> On Tue, Jul 16, 2024 at 04:27:31PM +0900, Akihiko Odaki wrote:
>> qemu_get_runtime_dir() returns a dynamically allocated directory path
>> that is appropriate for storing runtime files. It corresponds to "run"
>> directory in Unix.
>>
>> With a tree-wide search, it was found that there are several cases
>> where such a functionality is implemented so let's have one as a common
>> utlity function.
>>
>> A notable feature of qemu_get_runtime_dir() is that it uses
>> $XDG_RUNTIME_DIR if available. While the function is often called by
>> executables which requires root privileges, it is still possible that
>> they are called from a user without privilege to write the system
>> runtime directory. In fact, I decided to write this patch when I ran
>> virtiofsd in a Linux namespace created by a normal user and realized
>> it tries to write the system runtime directory, not writable in this
>> case. $XDG_RUNTIME_DIR should provide a writable directory in such
>> cases.
>>
>> This function does not use qemu_get_local_state_dir() or its logic
>> for Windows. Actually the implementation of qemu_get_local_state_dir()
>> for Windows seems not right as it calls g_get_system_data_dirs(),
>> which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
>> "/usr/share", not "/var", which qemu_get_local_state_dir() is intended
>> to provide. Instead, this function try to use the following in order:
>> - $XDG_RUNTIME_DIR
>> - LocalAppData folder
>> - get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
>>
>> This function does not use g_get_user_runtime_dir() either as it
>> falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
>> available. In the case, we rather use:
>> get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20230921075425.16738-2-akihiko.odaki@daynix.com>
>> ---
>>   include/qemu/osdep.h | 12 ++++++++++++
>>   util/oslib-posix.c   | 11 +++++++++++
>>   util/oslib-win32.c   | 26 ++++++++++++++++++++++++++
>>   3 files changed, 49 insertions(+)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 191916f38e6d..fe8609fc1375 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -670,6 +670,18 @@ void qemu_set_cloexec(int fd);
>>    */
>>   char *qemu_get_local_state_dir(void);
>>   
>> +/**
>> + * qemu_get_runtime_dir:
>> + *
>> + * Return a dynamically allocated directory path that is appropriate for storing
>> + * runtime files. It corresponds to "run" directory in Unix, and uses
>> + * $XDG_RUNTIME_DIR if available.
>> + *
>> + * The caller is responsible for releasing the value returned with g_free()
>> + * after use.
>> + */
>> +char *qemu_get_runtime_dir(void);
>> +
>>   /**
>>    * qemu_getauxval:
>>    * @type: the auxiliary vector key to lookup
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index e76441695bdc..9599509a9aa7 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -278,6 +278,17 @@ qemu_get_local_state_dir(void)
>>       return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
>>   }
>>   
>> +char *
>> +qemu_get_runtime_dir(void)
>> +{
>> +    char *env = getenv("XDG_RUNTIME_DIR");
>> +    if (env) {
>> +        return g_strdup(env);
>> +    }
>> +
>> +    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
>> +}
> 
> I'm not convinced this is the correct logic to be following.
> 
> In the cover letter you mention not using g_get_user_runtime_dir()
> because it falls back to XDG_CACHE_HOME, and we need to fallback
> to LOCALSTATEDIR/run. This is not right for normal users though,
> where falling back to LOCALSTATEDIR/run is always wrong, as it
> won't be writable - the g_get_user_runtime_dir() fallback is
> desirable for non-root users.

It also checks LocalAppData, which should be usually available.

g_get_user_runtime_dir() is not a proper fallback in case neither of 
XDG_RUNTIME_DIR and LocalAppData are available. g_get_user_cache_dir(), 
which gets called by g_get_user_runtime_dir(), internally uses:
- XDG_CACHE_HOME or
- FOLDERID_InternetCache

g_get_user_cache_dir() just returns NULL if neither of them is available.

We can't expect XDG_CACHE_HOME is present when XDG_RUNTIME_DIR is 
missing. FOLDERID_InternetCache points to 
%LOCALAPPDATA%\Microsoft\Windows\Temporary Internet Files, according to:
https://learn.microsoft.com/en-us/windows/win32/shell/knownfolderid

So we can't expect FOLDERID_InternetCache is available when LocalAppData 
is missing.

Regards,
Akihiko Odaki

