Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C0CC87FC5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueBh1-0000AA-7E; Tue, 22 Jul 2025 08:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1ueBgx-0008TA-0P; Tue, 22 Jul 2025 08:01:55 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1ueBgu-0001Jy-NZ; Tue, 22 Jul 2025 08:01:54 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-41c3addd37cso3884732b6e.3; 
 Tue, 22 Jul 2025 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753185709; x=1753790509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3q701GQ5S2/FouldVkR2J2tFp6MtkjJcfxhr3YewVeE=;
 b=LVWf+ghbQ6QOCBVaPuWBLpe2GKjWBKVGBSAc4vu/THT6vavWZ3ftoKbfeBQikbooTg
 MDAyN3Zb1+B0nDeSsszQElImWokLuECdIg42mGkwDKoDQ+Ic+LXo4/+6eIHGv8pmhm2v
 yIG/491pfhFpi1KivD2847cd5IZ5BAxJXpnv1Tj8YPoY9TxbBHVYD9DByDpbQmRWjK/U
 7S15Ipk1ubl8iIvsl24HKqLHU2yDw97IVoBdjcKbsBo20Esl9Zal40+kSjCjqjTxmSMn
 nnK/+UzzDI0dBuf88NYGgb1uCsfBwCmPTmMdhXiUuHtv+ikAylpM4D61DsOE/LP42X95
 4SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185709; x=1753790509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3q701GQ5S2/FouldVkR2J2tFp6MtkjJcfxhr3YewVeE=;
 b=hrkBPHiKg8iv0apk4Qnxasa3XAHwEdGlG7UrKKO2OuwH1PW0Cm/cPJMiUuRMY0urry
 A8NZ1Mrj4E+i7bg375q9Zv+h2h+dBRgZN5Kl9TxXB0PgMY+g6VRHaoOBZvGKi7MPT5jK
 EYNvFgFmXp+GC6shjfvovz+1E0Biq5Kw740bFRQc+4FZ1QBlouo2G/Ag5GNyp0drMKlY
 ormjVwo8JxfHsf7rgv6Y9/1z3Hao6kXXTcN0PW7TLOizaSSJbggTMVGzWLIObVRrIjHu
 hMOBhG+z9KoWe0plW7zoae78LCXn2QCiAbrGTjFBtjzmxUC39ZxEGlgfHz0hF7nT/t74
 5dTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJT5lC8kFFYpJlQo9ip14KnuTeJrpVXhAKOjdX6+3AcQIqFVFSmjrgIZEqZq44idXlMcbruXx1a1o4@nongnu.org
X-Gm-Message-State: AOJu0Ywwi2VkNQhbIxRHwJneEXzO93AYdJsAfROfpjCc/siuH9isJwep
 VzvCAEaEzaM8HKkB17EdsxTbHi0KJWZl+PRLC9FDxV9evZ4UF5h4Xo+fIef5SGQnif69VKebDVs
 /AZ1QKGTEVsvfrbKyRuUnv6DGA9WpXv4=
X-Gm-Gg: ASbGncsX8E7Gw+RPl/TRQf0w+ZiB4wU0cjoSo/xJhpiqxSQIfKkT3NVA19o3ZXVwqU3
 sLOIK6wJPCo7gMrpaIDCuVULHzAfYBafI+d6GznSGd/IHOX3xiA0O9Ex9fsZ7GS3Zs+hM3b83sa
 D2yGlwOyp4P/nDMDMvUOehY7JZjQ6BSsi9RqE7M7ZxzV7WUWeubLk08vHEiX+lXFSOBCGgXf6S1
 0MtrQ==
X-Google-Smtp-Source: AGHT+IEgEVQNk9IvMaydQIMrOhBa9qsoYLoiXb0NHK5s3LuelnZngTIF88qlHQLZP6tifYwTTJcTBXwy2/txXnQ7ujU=
X-Received: by 2002:a05:6808:8883:b0:41d:8847:5466 with SMTP id
 5614622812f47-41d88475c4amr17412158b6e.16.1753185708728; Tue, 22 Jul 2025
 05:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com> <87seivnyk8.fsf@pond.sub.org>
In-Reply-To: <87seivnyk8.fsf@pond.sub.org>
From: Brian Song <hibriansong@gmail.com>
Date: Tue, 22 Jul 2025 08:00:00 -0400
X-Gm-Features: Ac12FXy0XwB2xH2zwqIzdEGzUFMX2B38wqQGdqTjlIeHAFhWlEz16nonYVOJ0_A
Message-ID: <CAKWCU7XyL1KLMzxefSCF4yDGGn8aNi53gk=T=pEj2LhWC7Ttrg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, bschubert@ddn.com, 
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=hibriansong@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 7/17/25 2:03 AM, Markus Armbruster wrote:
> Brian Song <hibriansong@gmail.com> writes:
>
>> This work provides an initial implementation of fuse-over-io_uring
>> support for QEMU export. According to the fuse-over-io_uring protocol
>> specification, the userspace side must create the same number of queues
>> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
>> queue contains only a single SQE entry, which is used to validate the
>> correctness of the fuse-over-io_uring functionality.
>>
>> All FUSE read and write operations interact with the kernel via io
>> vectors embedded in the SQE entry during submission and CQE fetching.
>> The req_header and op_payload members of each entry are included as
>> parts of the io vector: req_header carries the FUSE operation header,
>> and op_payload carries the data payload, such as file attributes in a
>> getattr reply, file content in a read reply, or file content being
>> written to the FUSE client in a write operation.
>>
>> At present, multi-threading support is still incomplete. In addition,
>> handling connection termination and managing the "drained" state of a
>> FUSE block export in QEMU remain as pending work.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>
> [...]
>
>> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
>> index 35ab2d7807..4ec0648e95 100644
>> --- a/docs/tools/qemu-storage-daemon.rst
>> +++ b/docs/tools/qemu-storage-daemon.rst
>> @@ -78,7 +78,7 @@ Standard options:
>>   .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
>>     --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
>>     --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
>> -  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
>> +  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,uring=on|off]
>>     --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]
>>
>>     is a block export definition. ``node-name`` is the block node that should be
>> @@ -111,7 +111,13 @@ Standard options:
>>     that enabling this option as a non-root user requires enabling the
>>     user_allow_other option in the global fuse.conf configuration file.  Setting
>>     ``allow-other`` to auto (the default) will try enabling this option, and on
>> -  error fall back to disabling it.
>> +  error fall back to disabling it. Once ``uring`` is enabled
>> +  (off by default), the initialization of FUSE-over-io_uring-related settings
>> +  will be performed in the FUSE_INIT request handler. This setup bypasses
>> +  the traditional /dev/fuse communication mechanism and instead uses io_uring
>> +  for handling FUSE operations.
>> +
>> +
>
> Drop the additional blank lines, please.
>
> This is user-facing documentation.  Do users care about "the FUSE_INIT
> request handler"?
>
>>
>>     The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
>>     to create the VDUSE device.
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index 9ae703ad01..7d14f3f1ba 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -184,12 +184,16 @@
>>   #     mount the export with allow_other, and if that fails, try again
>>   #     without.  (since 6.1; default: auto)
>>   #
>> +# @uring: If we enable uring option, it will enable FUSE over io_uring
>> +#         feature for QEMU FUSE export.  (default: false)
>> +#
>
> Missing (since 10.2).
>
> Please format just like everywhere else:
>
>     # @uring: If we enable uring option, it will enable FUSE over
>     #     io_uring feature for QEMU FUSE export.  (default: false)
>
>
> Kernel documentation calls the thing "FUSE-over-io-uring":
> https://docs.kernel.org/filesystems/fuse-io-uring.html
>
> The text feels awkward.  Here's my attempt:
>
>     # @uring: Use FUSE-over-io-uring.  (since 10.2; default: false)
>

Thanks for pointing them out! I've fixed them. :)

