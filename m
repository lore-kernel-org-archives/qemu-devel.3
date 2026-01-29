Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EFBD73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZoV-0005ra-61; Thu, 29 Jan 2026 16:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlZoU-0005rB-D9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:44:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlZoS-0002kJ-Ig
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:44:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso12324135e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 13:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769723066; x=1770327866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mqLeK4m2H6qJ3W011XKVt8raqkPS9kqFZ/660tF2y8U=;
 b=tLW+FtXZ/kxS/i+1YlpZmCYY6GuwT76P/XLZ8ER8JZWFI7H4hQU7tXUYCk0o1hetD7
 mCABzrIQs3COmW2YTIYQFIPRrMhVA1KXbK3svkL3QsKW5ZekNZZPyElmlOOvU6bGV+uY
 jmyxgqsnYWMjMS3q0TM+c8zzevLcYG1foiG12prj+/w1+AwAXeM9J7IXqn+rJMZIac73
 +/k6/ZBaq0N2V9CobY6XSDJaT75ZIr4vx4PBikyhnHy+Wz4/++sb4DpVS+KgUnZA2jmv
 Z+8hGybHT7g+QnEWbEX/stY+AuiEZj8Jmx0QLP8QNa8/4Ocs9wP1JSTdF4o37NKj1jNM
 HqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769723066; x=1770327866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqLeK4m2H6qJ3W011XKVt8raqkPS9kqFZ/660tF2y8U=;
 b=nurnmAftXal0/7z+UONutWIzfvwyqhkvvPhyjRGqZdufrnJN7f2g4ARns2Sa0uFd71
 MIiBr+JDgX7/ZSGT+zv/kSs4y4mEfhs27VVWqcy8tBPje4twK5YoNL8BlKciEg+z/HNv
 X+AziLUO5vpbqWaKovB2BOGO2krhAcTEOXOXCEMC1zVGXeoow1GixpcIy25FiTrT1K8o
 BttKk++meP93Gnq69i2yZO1M/iw+Te78YOHkenvhYm1iqPu41JT2GW3smthccjhR+h7F
 f3fUi08HjOhpXhiObCUL5UgB0/H9kJk0cBC0i+i08SXaP9Gy+ITQvBIAV1JaIMX7NGQA
 2egQ==
X-Gm-Message-State: AOJu0Yzpx1XnTx2O5/JCJ0ykEmAGVVq/BnUdwJZ4LdK/Ni9jWcqU36yB
 Q8zIIdX5SnrAzFA0B3e4TKYlXUcHAOjs2VH9cRDMiJ0Z5aag3pswju+Q3KI4QgISSWs=
X-Gm-Gg: AZuq6aIwg77F/gkoM7qeRtcGJocBboQcDmsxaNtpZwcfKm7fmUnmy0oxDZKwFtsvrQB
 6sFNlWRQEosIZ9oe0rizDVQVSQraaNhtp3c2vvOPWpM4TTmW5Mq28fYJ4Co0gdjmx7eM50bqjB2
 FtPz+el38NdEKJgkK41mXZ/ZbICnkYOMqo/FzACKnRh7qGVivUVE2dbL3vH+Kml3/ytPXEHEkVp
 jUd+SzUFYiHYU2ifHUn2jY0wi69DJhKuWK4P2217LsGoOSL/vJ0rwS9jpJWXMRY4BUrHkivFMb5
 FKRala3oQEQ//lLmIgMvGBvfUWovxDGTf2GQJcccdeqiNJVRQhKceomecJW92U8BRkUwUBaYAGZ
 NcJCsAZsxpnOIsViQbXICdBV009Ky2mjld2QCLdfBFJp5Vc1OIS9Usembnh93MXUTgOWGMtcocG
 WJgZ68BbSotisI56q6DWH4w9DgGOv1cNRUd3RnUmytJlJiSTwTT03OfUQ9PiJBXj/r
X-Received: by 2002:a05:600c:a00e:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-482db4bda8dmr7130165e9.16.1769723066282; 
 Thu, 29 Jan 2026 13:44:26 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482daf1c6bfsm4609325e9.15.2026.01.29.13.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 13:44:25 -0800 (PST)
Message-ID: <0954062c-c032-42be-ad0d-df2559360963@linaro.org>
Date: Thu, 29 Jan 2026 22:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Roman Kiryanov <rkir@google.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 mjt@tls.msk.ru, whollins@google.com, jansene@google.com,
 jpcottin@google.com, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
 <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

(+Paolo / Eric)

On 29/1/26 21:31, Peter Maydell wrote:
> On Thu, 29 Jan 2026 at 20:26, Roman Kiryanov <rkir@google.com> wrote:
>>
>> Hi Philippe, thank you for looking into my patch.
>>
>> On Thu, Jan 29, 2026 at 11:23 AM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 29/1/26 20:04, Roman Kiryanov wrote:
>>>> This patch fixes the C++ compilation error:
>>>>
>>>> ISO C++ forbids forward references to 'enum' types
>>>>
>>>> -typedef enum QKbdModifier QKbdModifier;
>>>> -
>>>> -enum QKbdModifier {
>>>> +typedef enum QKbdModifier {
>>>> -};
>>>> +} QKbdModifier;
>>>
>>> Yes but:
>>>
>>> $ git grep -E 'typedef enum.*;'
>>> include/hw/misc/auxbus.h:32:typedef enum AUXCommand AUXCommand;
>>
>> I also grepped through the QEMU source code and saw other examples. I
>> limited this patch to ui/kbd-state.h because it is the specific header
>> causing C++ compilation errors in our project. I hesitated to touch
>> the others to keep the diff minimal and avoid changes in files we
>> aren't currently using.
>>
>> Currently, QEMU has a mix of incompatible and compatible (e.g.
>> block/block-common.h, BlockZoneOp) enum definitions. I think,
>> everything outside the include/ directory should be implementation
>> details.
>>
>> How would you prefer I proceed?
>>
>> 1) Keep this patch focused: Limit the change to kbd-state.h to fix the
>> active build breakage.
>> 2) Fix public headers: I can send a v2 that fixes this pattern for all
>> files in include/.
>> 3) Tree-wide cleanup: I can attempt to fix every instance found by
>> grep, though this touches private headers as well.
> 
> There is also option 4:
> 
> 4) Don't change this, because QEMU is not a C++ project
> and it's not a goal for our headers to be compilable
> with C++, with some minor exceptions.
> 
> What are we trying to achieve here, and why does it benefit
> us as an upstream project ?
> 
> cf previous email thread from 2024
> https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/
> about "drip-feeding" of this kind of patch with no clear take
> on what the end state is or how much churn it's going to induce.

I clearly know QEMU is not a C++ project. Now I don't see why we should
be reluctant to have headers being usable by a C++ compiler, as long as
it doesn't make our project worst to maintain.

See for example non-invasive commit 7246c4cc470 ("exec: don't use void*
in pointer arithmetic in headers"):

-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
@@ -2767 +2767 @@ struct MemoryRegionCache {
-    void *ptr;
+    uint8_t *ptr;
---

or commit 17c7df806b3 ("exec: avoid using C++ keywords in function
parameters"):

-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
@@ -928 +928 @@ struct MemoryListener {
-                      int old, int new);
+                      int old_val, int new_val);
@@ -947 +947 @@ struct MemoryListener {
-                     int old, int new);
+                     int old_val, int new_val);
---


In this particular case, I always have been confused about what would be
the size of forward-declared enums. The C99 standard chapter §6.7.2.2
point 4 mentions:

   Each enumerated type shall be compatible with char, a signed
   integer type, or an unsigned integer type. The choice of type
   is implementation-defined, but shall be capable of representing
   the values of all the members of the enumeration.

When compiling this file with -Werror=pedantic we get:

In file included from ../../ui/kbd-state.c:10:
include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 
'enum' types [-Werror,-Wpedantic]
    12 | typedef enum QKbdModifier QKbdModifier;
       |              ^

So arguably this could be fixed for C.


On another perspective, having more contributors should keep our project
healthy, and would potentially bring us more reviewers (maintainers?).


If we don't object to take such patches, my only request is to have a
CI job for non-C++ developers to not breaking the headers over time.


My 2 cents :)

Regards,

Phil.

