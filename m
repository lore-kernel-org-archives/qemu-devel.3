Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6349AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YDP-0007qx-Du; Thu, 02 May 2024 11:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YDM-0007qd-7l
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YDK-0003uz-Hd
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714663153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sqbDBKR/YDZ6MADddlZkZTj2qtUjc24cEoHGGHvuRk4=;
 b=M3t/b5V9IdnZsWYznvc6YydRfdAl2EsDRGZF4FADQktEWtRk089NRpTegC0E9CZI6xVe4f
 2ag6awV2legrGvZ9D1/3c3Jw4WQfqiIOOde2O9f43yyJAwFr/qYatgEOYUEpGgl6XPE6+w
 EggZOow1NSCHwB9V7cjKPBwy0gc+FrA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-8-_92wN6MW-qxEjCdka8kg-1; Thu, 02 May 2024 11:19:12 -0400
X-MC-Unique: 8-_92wN6MW-qxEjCdka8kg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51e7af9e815so2501087e87.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714663150; x=1715267950;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqbDBKR/YDZ6MADddlZkZTj2qtUjc24cEoHGGHvuRk4=;
 b=HQSGZue1jdZrIjhON5NX2gaYtegolozA0zqbeSXenlmZj73r2Ynrx7F6rhoW/1EHqZ
 xdKACr+7HzzJrIlorVv78+pBm5uaQpQBkBYSmATbG+ZHqXc2DlFovOYb/ER3KuBF6y+v
 P5rx20YdY1wmAjzhrm772LgZ7ZdP/+/VTS8K1lAXJqQAe9rWPdQTE7O6KjW9iDkYpndc
 aBxbcakgNN954kAK2kmtbWBxeAsVF1qAzx7kdx0QvdJD52xvWMSlcuAR2wTnlv3XY/Gj
 18EseI/O5oJuNCr5WlBi4DiTLtjj09ZgwkdzZbcSfuklhxXgotfaV4/E08ekQGfPQdAd
 XwAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL1Oj0un9Y+OhBQwNa4lhJV7HxXLXc9fwSKp5idGejLyLyOxXo1brBKo9Ea782usNjVuPtVQlUSvKbhHU0arOBP8XQ1Eo=
X-Gm-Message-State: AOJu0Yw+pZppuVGtFyO+AFbFs9w1ODuFkIuP0LcyuFHuXvEtJOS9cqlC
 s47222//ins3TRoeEpUcjrLulfBExXDOWHp8w78KmwCFw4Q2xC2cgyk+2nw/MfIclhhhpLr+dm3
 chp+wL9J+A7+ju/nuWPN9VvduCnkPAOk7Yq6ebNkQOCv7ZUTACfI7
X-Received: by 2002:a05:6512:20c6:b0:518:a89f:bfa5 with SMTP id
 u6-20020a05651220c600b00518a89fbfa5mr97059lfr.30.1714663150459; 
 Thu, 02 May 2024 08:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1u6U+cWaPXlS6kZnt/xZMUdF+GZge5ITl6SDfIthQ+vAKm4T7/hJfqr2zD+MJVXU2dT9aYQ==
X-Received: by 2002:a05:6512:20c6:b0:518:a89f:bfa5 with SMTP id
 u6-20020a05651220c600b00518a89fbfa5mr97036lfr.30.1714663149913; 
 Thu, 02 May 2024 08:19:09 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
 by smtp.googlemail.com with ESMTPSA id
 mr7-20020a170907828700b00a5976d455efsm233001ejc.163.2024.05.02.08.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 08:19:09 -0700 (PDT)
Message-ID: <4ead608e-7ab6-44b6-8712-fcf2e7ce6f51@redhat.com>
Date: Thu, 2 May 2024 17:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU headers in C++
To: Roman Kiryanov <rkir@google.com>, Daniel Berrange <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>
References: <a href="raw"> </a>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: </a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/24 10:02, Daniel P. Berrangé wrote:
>> Hi QEMU,
>> 
>> I work in Android Studio Emulator and we would like to develop devices
>> in C++. Unfortunately, QEMU headers cannot be used with C++ as is
>> (e.g. they use C++ keywords as variable names or implicitly cast void*
>> to T*).
> 
> NB, in recent past QEMU explicitly eliminated almost[1] all C++ code from
> the tree, because the consensus was to be exlcusively a C project. 
> 
>> Will QEMU be open to accept patches from us to make QEMU headers C++
>> compatible?
> 
> Personally I think that'd be a retrograde step. Any downstream development
> fork that made use of that facility would be not be able to feed changes
> / additions back into upstream QEMU codebase at a later date, without QEMU
> accepting C++ code once again.

That would have to depend on what the C++ code would do.  For example, 
if there is a specific library that we find useful and is written in 
C++, it may be useful to accept C++ code in order to share code with 
other open source projects.  I agree that the chances would be small though.

Anyway, just out of curiosity I tried to see what it would take to 
compile edu.c as C++ code, which I think lets us give a more informed 
answer.

There were a bunch of conflicts with C++ keyword, especially "new", 
"class" and "typename".  Given how common "klass" is already in the QEMU 
code, it would be acceptable to replace "class" with "klass" and 
"typename" with "type_name" or "qom_typename".

"new" is common in .c files but rare in headers; there is one occurrence 
in include/hw/pci/pci.h, and some in include/qemu/atomic.h which is a 
problem anyway (see below).  In my opinion, changing

-bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
+bool pci_intx_route_changed(PCIINTxRoute *from, PCIINTxRoute *to);

would not be a huge deal.

In some cases, some of the changes would be good to have anyway, for 
example replacing g_try_malloc0 with g_try_new0 (which, as a side 
effect, eliminates a C++ error for casting void *) as you have in 
include/qemu/bitmap.h.  This is a patch that I would accept right away 
(and I have just sent it to qemu-trivial in fact).

The big things that are left are:

- uses of typeof, _Generic, __builtin_types_compatible_p and 
__builtin_choose_expr, for example in typeof_strip_qual() and 
QEMU_MAKE_LOCKABLE

- QemuLockable also has issues due to compound literals, IIRC

Both of these are really a problem only because thread.h and lockable.h 
are included almost everywhere (e.g. via ratelimit.h -> blockjob.h -> 
block-common.h, or coroutine.h -> block-io.h).  Patches to reduce these 
"rebuild everything" includes would be acceptable and an improvement. 
There is no reason for block-common.h to include blockjob.h, for example.

(For lockable.h, Android Simulator could just wrap most of 
it---everything except struct QemuLockable, probably?---in #ifndef 
__cplusplus.  That patch would not be accepted by QEMU but it would be 
very small and localized).

So my answer is that we can't guarantee that QEMU is compilable as C++, 
but some of the changes are an improvement in general and some are a 
wash.  I think accepting the latter is a small price for Google working 
on upstreaming the changes and contributing the former.

Paolo

> We'll never control what forks can do, and many will never feed back code
> regardless, but IMHO we should be steering external developers in a way
> that keeps open the door for their changes to be merged back upstream.


