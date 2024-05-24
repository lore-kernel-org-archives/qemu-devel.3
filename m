Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7505C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 07:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAP9i-0003RZ-5h; Fri, 24 May 2024 03:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAP9T-0003Dd-Nd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 03:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAP9R-0005x4-4E
 for qemu-devel@nongnu.org; Fri, 24 May 2024 03:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716534938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hXDyrnOnXfFMjYkLVVqZS3ce7HoJM/pun2q0jK+FFNY=;
 b=PUBOQNQ2c8FTQEwwgfqloRyI0GwjmQdfr2PEmnQKULddBUWb0zvmFkouYcv/ApEnH3VE80
 fnFw2LQ67vCX95bBKidOjbUQEgLO1QQAXvyAJCmxJIy1uOmor9Zqhc2yN1pLGlFr6PcNSd
 +3YDM4FjG+EFGKJmJXAzcIyB5l4CKWI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-dcrJhBUAN4C-X8Jv1TBfFw-1; Fri, 24 May 2024 03:15:36 -0400
X-MC-Unique: dcrJhBUAN4C-X8Jv1TBfFw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-578286494a6so1581239a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 00:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716534935; x=1717139735;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hXDyrnOnXfFMjYkLVVqZS3ce7HoJM/pun2q0jK+FFNY=;
 b=AekA65cy34loqVVS1XMfvFeTHnmHKwSFlvjr68l00Q5oy6sQo6O6hrsTUoAM0gIhX1
 qOxuSuNbZmTN9Iiyi1CVVDvv+rpNHmyX4/7ZN56G3wM7AGoS7+9/OGoXsPcDxEG+V1nM
 dL6Ttgsoj3cp+qBmBg+IWjEWEVWVrOla3WG3fgcJD2kHcBkcLID3XXBnySG9HVCynvwH
 tkEOtg+5jYgqqXAuhiJegjvYvwaemUZhWa5rhcK3WasvWCdgQGIdPUh3PlH8tlbm6fkw
 FHK+n703vPO7NuzIDK6sJ/JXBiOpmeSQTSeex5x+guc6BZHA7krbwjd9qqdUywhLIm8T
 V7yg==
X-Gm-Message-State: AOJu0YxSL0rbmd5dRZmwNFURnJc4pKxdCW7K3Kq5CkcmD03MHn9zzigK
 qx9EiT9MK5VTx3uVha2F1JgNJ88FVmjlk/UjcAHHcYBqFEzHXCucMKhe1LIBY32rsPQNPN9jUhd
 qr4fbuFXMniuflVXyVYu8wB5oE6KoxDLZ2kNzi0aB4NUwQzG8Biqw
X-Received: by 2002:a50:cc88:0:b0:570:38a:57ea with SMTP id
 4fb4d7f45d1cf-578519a2126mr814061a12.33.1716534935066; 
 Fri, 24 May 2024 00:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMTntXrsugrLBhGn+ZpF758+SXBBIeH0V68OiHnPAPWNWQB9FoH01AJOgu63Z6DLg/zMNDpA==
X-Received: by 2002:a50:cc88:0:b0:570:38a:57ea with SMTP id
 4fb4d7f45d1cf-578519a2126mr814047a12.33.1716534934642; 
 Fri, 24 May 2024 00:15:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.155.52])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57852410ee7sm1127498a12.52.2024.05.24.00.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 00:15:34 -0700 (PDT)
Message-ID: <0543dd13-7fc7-4d9a-b19d-d850da79d5bb@redhat.com>
Date: Fri, 24 May 2024 09:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson.build: add -mcx16 flag for x86_64 host
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
 <Zk8CQ0uORPtlJI8v@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zk8CQ0uORPtlJI8v@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/23/24 10:45, Daniel P. Berrangé wrote:
> On Thu, May 23, 2024 at 08:11:18AM +0300, Artyom Kunakovsky wrote:
>> Fix linker error if the project was configured by the './configure --cpu=unknown --target-list=riscv64-softmmu' command
> 
> As with v1, why are you intentionally passing a bogus CPU target
> name to the --cpu arg ?  QEMU already correctly sets '-mcx16' if
> you omit --cpu, or pass a correct "x86_64" target name to --cpu.

The patch has a point though, in that right above we have another test
to add -march=i486.  It's just that we do that one conditionally,
because most of the time the compiler will already apply the less-
restrictive -march=i686.

The point of CPU_CFLAGS is really just to select the appropriate
multilib, for example for library linking tests, and -mcx16 is not
needed for that purpose.  And -mcx16 is not applied to cross-compiled
x86_64 code too, so why is it even in configure.

This is not to say that passing --cpu=unknown is a good idea; the
reason that Artyom gives is not really compelling.  But I think
I am going to apply it as a cleanup together with the matching
change to configure:

--------------- 8< -----------------
From: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Subject: [PATCH] configure: move -mcx16 flag out of CPU_CFLAGS

The point of CPU_CFLAGS is really just to select the appropriate multilib,
for example for library linking tests, and -mcx16 is not needed for
that purpose.

Furthermore, if -mcx16 is part of QEMU's choice of a basic x86_64
instruction set, it should be applied to cross-compiled x86_64 code too;
it is plausible that tests/tcg would want to cover cmpxchg16b as well,
for example.  In the end this makes just as much sense as a per sub-build
tweak, so move the flag to meson.build and cross_cc_cflags_x86_64.

This leaves out contrib/plugins, which would fail when attempting to use
__sync_val_compare_and_swap_16 (note it does not do yet); while minor,
this *is* a disadvantage of this change.  But building contrib/plugins
with a Makefile instead of meson.build is something self-inflicted just
for the sake of showing that it can be done, and if this kind of papercut
started becoming a problem we could make the directory part of the meson
build.  Until then, we can live with the limitation.

Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Message-ID: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
[rewrite commit message, remove from configure. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/configure b/configure
index 38ee2577013..4d01a42ba65 100755
--- a/configure
+++ b/configure
@@ -512,10 +512,7 @@ case "$cpu" in
      cpu="x86_64"
      host_arch=x86_64
      linux_arch=x86
-    # ??? Only extremely old AMD cpus do not have cmpxchg16b.
-    # If we truly care, we should simply detect this case at
-    # runtime and generate the fallback to serial emulation.
-    CPU_CFLAGS="-m64 -mcx16"
+    CPU_CFLAGS="-m64"
      ;;
  esac
  
@@ -1203,7 +1200,7 @@ fi
  : ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
  : ${cross_cc_sparc="$cross_cc_sparc64"}
  : ${cross_cc_cflags_sparc="-m32 -mcpu=supersparc"}
-: ${cross_cc_cflags_x86_64="-m64"}
+: ${cross_cc_cflags_x86_64="-m64 -mcx16"}
  
  compute_target_variable() {
    eval "$2="
diff --git a/meson.build b/meson.build
index a9de71d4506..7fd82b5f48c 100644
--- a/meson.build
+++ b/meson.build
@@ -336,6 +336,13 @@ if host_arch == 'i386' and not cc.links('''
    qemu_common_flags = ['-march=i486'] + qemu_common_flags
  endif
  
+# ??? Only extremely old AMD cpus do not have cmpxchg16b.
+# If we truly care, we should simply detect this case at
+# runtime and generate the fallback to serial emulation.
+if host_arch == 'x86_64'
+  qemu_common_flags = ['-mcx16'] + qemu_common_flags
+endif
+
  if get_option('prefer_static')
    qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
  endif


>>
>> Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
>> ---
>>   meson.build | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index a9de71d450..e68fbfc662 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -336,6 +336,12 @@ if host_arch == 'i386' and not cc.links('''
>>     qemu_common_flags = ['-march=i486'] + qemu_common_flags
>>   endif
>>   
>> +
>> +if host_arch == 'x86_64'
>> +  qemu_common_flags = ['-mcx16'] + qemu_common_flags
>> +endif
>> +
>> +
>>   if get_option('prefer_static')
>>     qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
>>   endif
>> -- 
>> 2.25.1
>>
>>
> 
> With regards,
> Daniel


