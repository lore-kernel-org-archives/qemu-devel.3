Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70189C3DA62
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgLg-0003Ii-V5; Tue, 16 Jul 2024 07:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTgLV-0002na-5G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:49 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTgLR-0003m1-U7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70368b53cc0so2749403a34.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721129264; x=1721734064;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bPVucKPJWt4W6yJCP3srg8CWMuE+MlMZIZcqQhpW4Rg=;
 b=1GD79LIbTVxyxfFDmKfxRsHivmzJs32eu8StoDowVAP9aGvLPK2FjQOLbN3sDvCWip
 2xWbP5Kc8UvZR6D73NSe+5CGkZYBOWFCPPZLkgF0PbSiJA279l1JLMA3adyfwPCsW4a6
 oQgZfE1ZMPxDrzFWAuDfHQqeu8P2mHmFoFoHGuxlw6qxwcrugPOtHzpqDXV5HMTUPPJm
 vHQmUcx5z0Jeam4gCuyMNMM+8FPEJ9nTzfAOYQh6kKurti+ZAlYuaZm4K7YFiYXb/t3Z
 HrxaX2nqUVymbuOotR7uUjXg+D6xw206rrYCYKkA5ahPzKQGV0TCZjFjxG9T6JjmewSB
 jb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721129264; x=1721734064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPVucKPJWt4W6yJCP3srg8CWMuE+MlMZIZcqQhpW4Rg=;
 b=nfsTRtFJbnz6f26WxVxDVJTtrbgpdh/rYrLnHc6mJEVTFun/UmonO1R9YzqoPhKb7X
 7i93Wu3MjsQ4Y6g/x8wNVDRWnG7MP3JqwxI//xT0YQM9EWPBy2/JNhoyABopkpFB459N
 xMiqB+vh+cmJaqTznkPfVXWd4X7LAsnRGwIwslDKZR/FxLMJWwAiEsaRAnQQuSlsCkNz
 6DIdq89V6FeIToAFUkr7yRv1KJfen1P8vOR+gh0S5RLdtwEWVB4pJ7x0Yb4bTibUArXg
 p2ucTSWSRdi2A9PZITn0F1bGnkO9k/f86Zbc5myzl8vf1muKSVA/Yax+zp8wGnLCGW+y
 JaJw==
X-Gm-Message-State: AOJu0YxjQir5ZWXe9i73nmoXiL3wXbsWgWzxQpZugWQruZmAf37i7G8j
 6v3z4ujgCGHKrz3MvNPQRxc0VddMdYFP5ZtwKhWsHrM1MtyF9lSUOsrArZYzMtY=
X-Google-Smtp-Source: AGHT+IEN7GIHwCeTtc3AYf9mmChN4qoeVpb8ZYeLLHe+WbF8H2+zTtuTV9eiuD8P4JxSdHnEcGmmpA==
X-Received: by 2002:a05:6870:9694:b0:25d:f8fa:b538 with SMTP id
 586e51a60fabf-260bdddbb0dmr1309185fac.29.1721129263807; 
 Tue, 16 Jul 2024 04:27:43 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecabadasm6010338b3a.181.2024.07.16.04.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 04:27:43 -0700 (PDT)
Message-ID: <7bee9c26-d75e-4d83-bc2a-c97b06416080@daynix.com>
Date: Tue, 16 Jul 2024 20:27:39 +0900
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
 <087e1eee-e7e3-4147-9c8c-882d458c1abd@daynix.com>
 <ZpZRYyW74wfqR6Zr@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZpZRYyW74wfqR6Zr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x329.google.com
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

On 2024/07/16 19:54, Daniel P. Berrangé wrote:
> On Tue, Jul 16, 2024 at 07:52:00PM +0900, Akihiko Odaki wrote:
>> On 2024/07/16 18:53, Daniel P. Berrangé wrote:
>>> On Tue, Jul 16, 2024 at 04:27:31PM +0900, Akihiko Odaki wrote:
>>>> qemu_get_runtime_dir() returns a dynamically allocated directory path
>>>> that is appropriate for storing runtime files. It corresponds to "run"
>>>> directory in Unix.
>>>>
>>>> With a tree-wide search, it was found that there are several cases
>>>> where such a functionality is implemented so let's have one as a common
>>>> utlity function.
>>>>
>>>> A notable feature of qemu_get_runtime_dir() is that it uses
>>>> $XDG_RUNTIME_DIR if available. While the function is often called by
>>>> executables which requires root privileges, it is still possible that
>>>> they are called from a user without privilege to write the system
>>>> runtime directory. In fact, I decided to write this patch when I ran
>>>> virtiofsd in a Linux namespace created by a normal user and realized
>>>> it tries to write the system runtime directory, not writable in this
>>>> case. $XDG_RUNTIME_DIR should provide a writable directory in such
>>>> cases.
>>>>
>>>> This function does not use qemu_get_local_state_dir() or its logic
>>>> for Windows. Actually the implementation of qemu_get_local_state_dir()
>>>> for Windows seems not right as it calls g_get_system_data_dirs(),
>>>> which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
>>>> "/usr/share", not "/var", which qemu_get_local_state_dir() is intended
>>>> to provide. Instead, this function try to use the following in order:
>>>> - $XDG_RUNTIME_DIR
>>>> - LocalAppData folder
>>>> - get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
>>>>
>>>> This function does not use g_get_user_runtime_dir() either as it
>>>> falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
>>>> available. In the case, we rather use:
>>>> get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Message-Id: <20230921075425.16738-2-akihiko.odaki@daynix.com>
>>>> ---
>>>>    include/qemu/osdep.h | 12 ++++++++++++
>>>>    util/oslib-posix.c   | 11 +++++++++++
>>>>    util/oslib-win32.c   | 26 ++++++++++++++++++++++++++
>>>>    3 files changed, 49 insertions(+)
>>>>
>>>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>>> index 191916f38e6d..fe8609fc1375 100644
>>>> --- a/include/qemu/osdep.h
>>>> +++ b/include/qemu/osdep.h
>>>> @@ -670,6 +670,18 @@ void qemu_set_cloexec(int fd);
>>>>     */
>>>>    char *qemu_get_local_state_dir(void);
>>>> +/**
>>>> + * qemu_get_runtime_dir:
>>>> + *
>>>> + * Return a dynamically allocated directory path that is appropriate for storing
>>>> + * runtime files. It corresponds to "run" directory in Unix, and uses
>>>> + * $XDG_RUNTIME_DIR if available.
>>>> + *
>>>> + * The caller is responsible for releasing the value returned with g_free()
>>>> + * after use.
>>>> + */
>>>> +char *qemu_get_runtime_dir(void);
>>>> +
>>>>    /**
>>>>     * qemu_getauxval:
>>>>     * @type: the auxiliary vector key to lookup
>>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>>> index e76441695bdc..9599509a9aa7 100644
>>>> --- a/util/oslib-posix.c
>>>> +++ b/util/oslib-posix.c
>>>> @@ -278,6 +278,17 @@ qemu_get_local_state_dir(void)
>>>>        return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
>>>>    }
>>>> +char *
>>>> +qemu_get_runtime_dir(void)
>>>> +{
>>>> +    char *env = getenv("XDG_RUNTIME_DIR");
>>>> +    if (env) {
>>>> +        return g_strdup(env);
>>>> +    }
>>>> +
>>>> +    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
>>>> +}
>>>
>>> I'm not convinced this is the correct logic to be following.
>>>
>>> In the cover letter you mention not using g_get_user_runtime_dir()
>>> because it falls back to XDG_CACHE_HOME, and we need to fallback
>>> to LOCALSTATEDIR/run. This is not right for normal users though,
>>> where falling back to LOCALSTATEDIR/run is always wrong, as it
>>> won't be writable - the g_get_user_runtime_dir() fallback is
>>> desirable for non-root users.
>>
>> It also checks LocalAppData, which should be usually available.
>>
>> g_get_user_runtime_dir() is not a proper fallback in case neither of
>> XDG_RUNTIME_DIR and LocalAppData are available. g_get_user_cache_dir(),
>> which gets called by g_get_user_runtime_dir(), internally uses:
>> - XDG_CACHE_HOME or
>> - FOLDERID_InternetCache
>>
>> g_get_user_cache_dir() just returns NULL if neither of them is available.
>>
>> We can't expect XDG_CACHE_HOME is present when XDG_RUNTIME_DIR is missing.
>> FOLDERID_InternetCache points to %LOCALAPPDATA%\Microsoft\Windows\Temporary
>> Internet Files, according to:
>> https://learn.microsoft.com/en-us/windows/win32/shell/knownfolderid
>>
>> So we can't expect FOLDERID_InternetCache is available when LocalAppData is
>> missing.
> 
> XDG_CACHE_HOME isn't required to be present. Glib will use a fallback
> location if XDG_CACHE_HOME isn't set, and it will mkdir() the location
> if it doesn't exist.

The fallback location is FOLDERID_InternetCache, which is not better 
than looking at LocalAppData.

Regards,
Akihiko Odaki

