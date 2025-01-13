Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868D4E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 08:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFg0-0001L5-P4; Mon, 13 Jan 2025 03:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXFg0-0001Ki-0n
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXFfx-0001Ft-6D
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736756395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9uTPnB23u0vSpnYQaj/XlGi+XzVH42Zzj+5iSIf//38=;
 b=g6UbV/jVJBQPBanElMvK6hjHSpdnqRV9nKlQU5QLIsk7tW0vYLWFtvuFsZqBJllABY0/qG
 zsrORvJxKhxHgn6/IvqDQpyYxhU79Vx4mR8qqB1anlM22IvesQzvV7AK9zm082exylwBLe
 408onDYK0etgtFMFV1n6tE7zi6vT3XU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-LvhrS6JZMYe1d-J2U9OKXQ-1; Mon, 13 Jan 2025 03:19:53 -0500
X-MC-Unique: LvhrS6JZMYe1d-J2U9OKXQ-1
X-Mimecast-MFC-AGG-ID: LvhrS6JZMYe1d-J2U9OKXQ
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d43ec75bc4so3641288a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 00:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736756392; x=1737361192;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uTPnB23u0vSpnYQaj/XlGi+XzVH42Zzj+5iSIf//38=;
 b=QWbiNmIv401ienkfBynaYldYg0nfhvmPZDMx+JDZtVssUThwJhhTd58KCZXkpC6o6Q
 9VXXz5vBjPx/ogqzXHR3WM3TApk8wPDepXQOl5oqXaGW+bTjKaKj3LSNDdN2u/iThVg6
 6s6wgY89/739kGcxoQnN6PKpGX1Avrg+tCcctCgEtPU8knTb20i1pkr1VrOXAkbBbMy8
 BAbQH2KVH4XMYfFA7zc4HXAXoqsFB++IZjn4jAE94NNA7SiCj0emBvHEm9yPwhblta2k
 bMc7Huxr6mgRcOaPSmVXQgxTu/pQNzVIl7F/PnnYKulcXIfn0ho+ihqUEROCSAP8DDTW
 xaYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAt636h66JMnzCy/tlp1A2S9AxYtjWM4NhwJouWYfJJFJKjIvWYCg8dx2Kw3Qjje6jsKTVGluH7q2n@nongnu.org
X-Gm-Message-State: AOJu0Yzokw734CKCs1e0xsMe7lnS51j1udmRir3BYkLp+RiGqqjNxCm+
 P7Du8RzubAJlbsieqQwckT7D83Nmt/ZyLCeTsGf2V5WVtdhyKBsruh7/5WXoRVciq9PR2ffoS9x
 NX3L2ah6IdbFSLhGekmQdqGv9/BbFYCY64Sl2RpzVzs7g+KPxw4ET
X-Gm-Gg: ASbGncskEePscO0h7CDxTcEm20Y9/piJxmwNXFYUFkP4XAlptLQzN+MUM4mu5xhXQqr
 kKAk78itxm3YWWiPFE0Hc6U75n1vhSq2yXfVZ/YmU5lHqS/AktQ34m/RVUJv8Cq4FVycGUBJVJP
 R75WRrN/03yyiTpZM9XZQ5MvHHdpdrhqTcHNE9kRZalaA2PQVacMk6h6Gwsoh0nyuJ6w1ohvZCA
 qNaiX957dYmnKhxR+znQccyX5NXoUmMWs05SQhlNSeVyKw03SgL1wAThCWkmn3adEz8Yk/Br05m
 26ewZ5H8EQ==
X-Received: by 2002:a17:906:c102:b0:aa6:7f99:81aa with SMTP id
 a640c23a62f3a-ab2ab676541mr1617269666b.6.1736756391868; 
 Mon, 13 Jan 2025 00:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9F3UPro2EREhzMbPEetmGOLqu51otB7aZqnueeJShAOz2V4iOV7QJ/IA9H9zN6CCTatrK2w==
X-Received: by 2002:a17:906:c102:b0:aa6:7f99:81aa with SMTP id
 a640c23a62f3a-ab2ab676541mr1617268166b.6.1736756391438; 
 Mon, 13 Jan 2025 00:19:51 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-16.web.vodafone.de. [109.42.48.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c912f165sm466074666b.83.2025.01.13.00.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 00:19:51 -0800 (PST)
Message-ID: <a54d8f52-c11e-4eab-bdb7-c3ac1f353f3e@redhat.com>
Date: Mon, 13 Jan 2025 09:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] migration: Fix parsing of s390 stream
To: Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250109185249.23952-1-farosas@suse.de>
 <20250109185249.23952-4-farosas@suse.de>
 <35911935-6f5c-40a3-aa73-3586dfdf3268@tls.msk.ru>
 <de853776-69cc-4605-9f9b-e3a60964c3b6@tls.msk.ru>
 <3cc941b1-b09d-4076-9234-9a385c762d3f@redhat.com>
 <fcc69fae-9c5a-4c7b-a6e3-cf445afc205d@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <fcc69fae-9c5a-4c7b-a6e3-cf445afc205d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/01/2025 08.51, Michael Tokarev wrote:
> 13.01.2025 09:39, Thomas Huth wrote:
>> On 12/01/2025 15.29, Michael Tokarev wrote:
> 
>>> # starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/ 
>>> qtest-1137270.sock -qtest-log /dev/null -chardev socket,path=/tmp/ 
>>> qtest-1137270.qmp,id=char0 -mon chardev=char0,mode=control -display none 
>>> - audio none -accel kvm -accel tcg -machine s390-ccw-virtio-9.2, -name 
>>> target,debug-threads=on -m 128M -serial file:/tmp/migration-test-T987Z2/ 
>>> dest_serial -incoming tcp:127.0.0.1:0 -bios /tmp/migration-test-T987Z2/ 
>>> bootsect     -accel qtest
>>> Traceback (most recent call last):
>>>    File "/tmp/q/scripts/analyze-migration.py", line 704, in <module>
>>>      dump.read(dump_memory = args.memory)
>>>    File "/tmp/q/scripts/analyze-migration.py", line 641, in read
>>>      section.read()
>>>    File "/tmp/q/scripts/analyze-migration.py", line 477, in read
>>>      field['data'] = reader(field, self.file)
>>>                      ^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/tmp/q/scripts/analyze-migration.py", line 450, in __init__
>>>      for field in self.desc['struct']['fields']:
>>>                   ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>>> KeyError: 'fields'
>>> # Failed to analyze the migration stream
>>
>> I think you need to backport patch 1/7, too?
> 
> Picked up:
> 
>   1/7 migration: Add more error handling to analyze-migration.py
>   3/7 migration: Fix parsing of s390 stream
>   7/7 s390x: Fix CSS migration
> 
> but still getting the same error:
> 
>   https://gitlab.com/mjt0k/qemu/-/jobs/8832218999 (9.2 branch)
>   https://gitlab.com/mjt0k/qemu/-/jobs/8832224338 (9.1 branch)

Blindly guessing: You need now patch 4/7 and 5/7, too? ... hopefully Fabiano 
could reply and point you to the exact set of patches that you need...

  Thomas


