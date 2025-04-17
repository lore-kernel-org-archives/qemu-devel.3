Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DE2C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TBp-0000fY-L7; Thu, 17 Apr 2025 13:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TBb-0000c4-Pb
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:38:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TBZ-0002Mz-Nx
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:38:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c33e5013aso14723145ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911480; x=1745516280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z71Jt1Wb1Iptp6DqUNl19162dtHzRlF7r0OyMfFjRdg=;
 b=G1qyQnPlDwNt8FGjLXypYZ/+1aK2jW7G6Eb1OLvTYXD3i382lGIGjo9MYg+lOs8kmO
 Xgvl2kTTjy39HnXdwSliV8QUxxC88A8C2X4h0saCcybeqA4OIeJiJeLetojqjK+VzG0d
 8XKAucqeNds126/pEYPdcRvWgReUxaw7rQKhIj511+a1rtp1ngti9V36vduTBMFyNA1b
 cdP2ywVn7rBaCircG+GB30r1yjvzGrXTg4dVxihCqYPzHSTwFMwAi+E8Q3i6e/Jcvl0D
 8qWxRcnbrWtL+3SsHG+OEJktnnglBh7ScTez1BvUIpltlV8+68InX63cKUdz1GGEzwiG
 jJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911480; x=1745516280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z71Jt1Wb1Iptp6DqUNl19162dtHzRlF7r0OyMfFjRdg=;
 b=KNQv9W4sf71wp+owDOvPEXg1ciQEEk5qOKoIZkTY0e0D/j6vqTo4KoK3u/VGJaHXch
 yGmilSUIb12ZJLYttxQp/WGG+ud65wcBFuofZdlwTxSR3AsSBTbdCxmz9N4RfQ9jOkL5
 rQcPNjKgTYUBq0w6KDnkqFZvnQsYz4OlVOEevtkVCAHgKLyJenXGe8Iwn9vVY9qcpsyk
 Yv8VKd4W6qBKhrNJ7aso1+Lyt6Yr3q50z4D2eb266GEp/ZZ8vsiU+3wsn36h99deqnXH
 6BzHdU02j6kBysbWP8u5PZJWBXVwJNecUWycDdIIJ/pkSOvHggbo8Q4Wb53IANbqJBOg
 +Jag==
X-Gm-Message-State: AOJu0Yw27KcjzIEvZyEeVZFtyvS291qQKomExFSMwEsxnv0s+CxnWoqC
 ZrWdya8Q+rpWHSUZbmSAVgEECgzgHW3umxdOEeD0V4RTpLDJT7Z792SetfaGX3M=
X-Gm-Gg: ASbGncsGnvvJZP/GlhwguXPTfOF45/xZ+X+KD/O7sBPLuioB3eJDcoEVfWG/VzYftsV
 Nu2QGJVsDx+RbgrKaOG1wQ6k6FaoRO4A2idyZzAnZWytsy2FLuWkI1uzBDb3SccQtH2iR4GY8Wb
 XsN97bjWwfnhhfs1XY46C1Tin0TnLBw0dCu0Qrcu5pwVyxdgNnCRAQudl9sMlJcXtI3C/LbmL6P
 1eUGXUHDGpm0egf5wiW4Hx/mg9EEk6WzR0B61xAKraZQ70EuwRTco4PtEUzSd1xi9Pskvv3OOl2
 HjMFXFzJaW85d6jgVUC/7NiVe6z87mMpypCQjmS6Iaol0yDa5vlf
X-Google-Smtp-Source: AGHT+IGy8vw8ZSknHcV7cIXiGXOtW+ijiGD1zysl40IM0PFhfGC/buPfQ14mSLLCeoG3TGYQd7jrfg==
X-Received: by 2002:a17:902:f305:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22c3591227amr82432165ad.25.1744911480191; 
 Thu, 17 Apr 2025 10:38:00 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4a46sm2629845ad.147.2025.04.17.10.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:37:59 -0700 (PDT)
Message-ID: <ea2f9a9c-a2ee-4175-83bc-d83540777b0b@linaro.org>
Date: Thu, 17 Apr 2025 14:37:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 13/13] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
To: Annie Li <annie.li@oracle.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204517.3043-1-annie.li@oracle.com> <875xj71cg1.fsf@pond.sub.org>
 <d2b18212-495a-469f-8c6b-50f0cf54dc96@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <d2b18212-495a-469f-8c6b-50f0cf54dc96@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Annie,

On 4/14/25 11:14, Annie Li wrote:
> 
> On 4/14/2025 2:31 AM, Markus Armbruster wrote:
>> Annie Li <annie.li@oracle.com> writes:
>>
>>> Followng hmp/qmp commands are implemented for pressing virtual
>>> sleep button,

nit: Following


Cheers,
Gustavo

>>> hmp: system_sleep
>>> qmp: { "execute": "system_sleep" }
>>>
>>> These commands put the guest into suspend or other power states
>>> depending on the power settings inside the guest.
>>>
>>> These hmp/qmp command are in '*_*' format, it is intended to do
>>> so to align to existing 'system_*' commands.
>>>
>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> [...]
>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index a6b8795b09..0965e78f4e 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -361,6 +361,26 @@
>>>   ##
>>>   { 'command': 'system_reset' }
>>> +##
>>> +# @system_sleep:
>>> +#
>>> +# Requests that the guest perform a ACPI sleep transition by pushing
>>> +# the virtual sleep button.
>>> +#
>>> +# Since:10.0
>>> +#
>>> +# .. note:: A guest may or may not respond to this command. This
>> Two spaces between sentences for consistency, please.
> 
> Didn't notice this, thanks for pointing it out.
> 
> Will fix it.
> 
> Thanks
> 
> Annie
> 
>>
>>> +#        command returning does not indicate that a guest has
>>> +#        accepted the request or that it has gone to sleep.
>>> +#
>>> +# .. qmp-example::
>>> +#
>>> +# -> { "execute": "system_sleep" }
>>> +# <- { "return": {} }
>>> +#
>>> +##
>>> +{ 'command': 'system_sleep' }
>>> +
>>>   ##
>>>   # @system_powerdown:
>>>   #
>>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>>> index 023a2ef7bc..285ce82e9b 100644
>>> --- a/qapi/pragma.json
>>> +++ b/qapi/pragma.json
>>> @@ -23,6 +23,7 @@
>>>           'set_password',
>>>           'system_powerdown',
>>>           'system_reset',
>>> +        'system_sleep',
>> Additions here are always sad, but inconsistency with the other
>> system_FOO commands would be worse.
>>
>>>           'system_wakeup' ],
>>>       # Commands allowed to return a non-dictionary
>>>       'command-returns-exceptions': [
>> With the spacing nit touched up:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>
> 


