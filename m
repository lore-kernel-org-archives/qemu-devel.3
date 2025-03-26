Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE58C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNUF-0007eF-6G; Wed, 26 Mar 2025 05:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txNTy-0007K6-U8
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txNTt-00062N-8r
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742982928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42CQDZeqsUqKp7GhtKl4tuwgyv6N5VY1y9sNBusciXI=;
 b=U2Mh0v/GL/UnXtwaUs8f5vvqbuA2gpd+9cx+Z4RFossrH8ILSLyEdBaQIt3MXxZJ1s1Pm2
 evN4GMkYDunjrmtXIQojZSz5GILd+m1K0XL7BLs1h2ghwuNouPCG8uTr4pvVKTWh9GzSfx
 o7ofO/PD4HhBNw+tOOSbKsOnUJYmJNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-FmFffFfEM5eX1gulRabuIg-1; Wed, 26 Mar 2025 05:55:27 -0400
X-MC-Unique: FmFffFfEM5eX1gulRabuIg-1
X-Mimecast-MFC-AGG-ID: FmFffFfEM5eX1gulRabuIg_1742982926
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-399744f742bso1620566f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742982926; x=1743587726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=42CQDZeqsUqKp7GhtKl4tuwgyv6N5VY1y9sNBusciXI=;
 b=C68t1wykXDmrM1QP4yetkHATcKbZ0OX2l4K32xbbDMit8rz12ydeJMXuNFSjczRUSj
 ykAktZGgTvPzruzBXTzCoH+NZZs+YqyEvfE7jLuM7SoME8dGtNUbOu9YVUK9O+t7x8cy
 bIrXf+SsIEWrB5ZTRyvsVtIOiDKb33O828+fbVpgnQFw514SwWvD15hR/PVh53XmWXjD
 4glyog50LRmtGROheNjkx0oLj9eML4SIVlU18JvbR0x5lB+gE2oTe9EtWsn83qPoGM1P
 ZlxeS1/jCUHbd28eCokirobxDx0yHuByAQE5LjT/I2ALollIGUt5hVv/1e1bXvnX0pl7
 dBfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2dTsZaRcSJD7eEKwK7Z7M9Wh/SOD4KjWxARWOFE/DY8i4B186paDCTCg1VUARuM6eotl2VDGLSKPq@nongnu.org
X-Gm-Message-State: AOJu0Yyyc2I1AqeaIQ9/PBvMOOL9e658Y/lMMZj9bEICzmW+Tr+2oO6z
 HWtSg+mLx+gMdHH10BFgLraomkjFVew8gcpJqsT2SNOyP33pbNUTyzEo2FjKOCb2Gt4ogMT3UGf
 PoHTVnnQoRN4JzfYsqpDuEeteRQPYJMnx7E4PuNKSgMfgmlNaREiK
X-Gm-Gg: ASbGncvasj1End+7EFAG3Fb48AGlwh24zWMmQLHby/pXe0kIbbaFGn/NaEjtgVi40xj
 /dmFgkwLebJACddtd8NXcQbnBU6wkjX+sw780Wz8SJUiAoSzvITIyAnCDo8ynOPzrhRSWNdiVrk
 yc02eIsrA/B6DKfKA5jsVxcbDPODpQ5yjUp7z92Qd2QwTIq6SndTR7Ew7nOq+fxT0TeMmpQ+iix
 BbpvLs7DJVHNfDZ4iqoNcpJvA2RAxzQ6L39eMQSS5c1U3DUlHyEmRkzvIFw+IFsxxLu39g4KGOg
 I/GcUnv7z8ECy8a0buOmB//DNtER14/IhWfj5VsnosF2IiHrPfneeDYopzKpwA+bMs7VxJ9V/Js
 McxR80BooulE+BNPYoFPV76U3+z4+If9s2CXJ8kizmYe/
X-Received: by 2002:a5d:5847:0:b0:39a:cc34:2f9b with SMTP id
 ffacd0b85a97d-39acc3432dfmr2879996f8f.16.1742982925845; 
 Wed, 26 Mar 2025 02:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOrCQ660xy/giLWNVvz0zhKKecHYN/Jc32mJkUwef03jm1K+Q7Oo5y+31eAR8cAHaX9HKQlg==
X-Received: by 2002:a5d:5847:0:b0:39a:cc34:2f9b with SMTP id
 ffacd0b85a97d-39acc3432dfmr2879959f8f.16.1742982925436; 
 Wed, 26 Mar 2025 02:55:25 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d8b:cdca:4048:2991:54ce?
 (p200300cfd74f9d8bcdca4048299154ce.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d8b:cdca:4048:2991:54ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995766sm16113464f8f.1.2025.03.26.02.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 02:55:24 -0700 (PDT)
Message-ID: <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
Date: Wed, 26 Mar 2025 10:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com> <87sen0fj1j.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87sen0fj1j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26.03.25 06:38, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>
>> We can use this to implement multi-threading.
>>
>> Note that the interface presented here differs from the multi-queue
>> interface of virtio-blk: The latter maps virtqueues to iothreads, which
>> allows processing multiple virtqueues in a single iothread.  The
>> equivalent (processing multiple FDs in a single iothread) would not make
>> sense for FUSE because those FDs are used in a round-robin fashion by
>> the FUSE kernel driver.  Putting two of them into a single iothread will
>> just create a bottleneck.
>>
>> Therefore, all we need is an array of iothreads, and we will create one
>> "queue" (FD) per thread.
> [...]
>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/block-export.json |   8 +-
>>   block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>>   2 files changed, 179 insertions(+), 43 deletions(-)
>>
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index c783e01a53..0bdd5992eb 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -179,12 +179,18 @@
>>   #     mount the export with allow_other, and if that fails, try again
>>   #     without.  (since 6.1; default: auto)
>>   #
>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>> +#     given iothreads (instead of the block device's iothread, or the
>> +#     export's "main" iothread).
> When does "the block device's iothread" apply, and when "the export's
> main iothread"?

Depends on where you set the iothread option.

> Is this something the QMP user needs to know?

I think so, because e.g. if you set iothread on the device and the 
export, you’ll get a conflict.  But if you set it there and set this 
option, you won’t.  This option will just override the device/export option.

>
>
>> +#                                 For this, the FUSE FD is duplicated so
>> +#     there is one FD per iothread.  (since 10.1)
> Is the file descriptor duplication something the QMP user needs to know?

I found this technical detail interesting, i.e. how multiqueue is 
implemented for FUSE.  Compare virtio devices, for which we make it 
clear that virtqueues are mapped to I/O threads (not just in 
documentation, but actually in option naming).  Is it something they 
must not know?

Hanna

>
>> +#
>>   # Since: 6.0
>>   ##
>>   { 'struct': 'BlockExportOptionsFuse',
>>     'data': { 'mountpoint': 'str',
>>               '*growable': 'bool',
>> -            '*allow-other': 'FuseExportAllowOther' },
>> +            '*allow-other': 'FuseExportAllowOther',
>> +            '*iothreads': ['str'] },
>>     'if': 'CONFIG_FUSE' }
>>   
>>   ##
> [...]
>


