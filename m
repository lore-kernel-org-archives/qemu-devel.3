Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1059606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ul6/XysC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AJotGo+q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJvCD-0006Ow-3j; Thu, 22 Oct 2026 11:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJvCB-0006OF-Jc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJvC9-0002oT-TP
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792684748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1I7DuUCMPUgfhJ4Rrc21VPSenXrQWouZRCayfBtld6Q=;
 b=Ul6/XysCbuMW885tUPu242lJS7G61oDJ87oHuHEtIh6ioTZtKTEsF59R2uPlixuzIQtANb
 2jNho/aXvAe/9s1S/7yOUIvhVBaKibj0pifrvu8Ia621burUxqzIlVd+R8te0Bih+MVm8B
 +RoVjX6m9zsSpW17rr3tSoM0WOTWvvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-wp10a5UPNOeN-QrqTHTL9g-1; Thu, 22 Oct 2026 11:59:05 -0400
X-MC-Unique: wp10a5UPNOeN-QrqTHTL9g-1
X-Mimecast-MFC-AGG-ID: wp10a5UPNOeN-QrqTHTL9g_1792684744
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48dfa054f26so1536042f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792684744; x=1793289544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1I7DuUCMPUgfhJ4Rrc21VPSenXrQWouZRCayfBtld6Q=;
 b=AJotGo+qsR9IJ3ExsBqD5q8PlGk9107F5UDKHKolKkr/TZVPOKmeTFW6Bwjry1Fi3/
 BxnScv/0Yslpiv1aBAIwIckjMaTAiKxmQbfojMzCg5obOVYAtrGB+n6AmLXCcMUMUJcu
 fJHqg01juyehsjsLz1py2wVv1MQDtAyZpvrW5tjoKveWuPCL2w4i/xhFkp/049SXzJ7W
 jOsJOxC4ENPG5Uj2IDPzBWoAfGwTKj2DAaIRaMrNLV5aL75b9lfpr48QmbzgIljUJeIr
 LslFglcPISLo3tsj6MisdexhWDYHSyiJNHPplMv2AtgXkhpW8lgJe6zfOPQ8BXmEi1Be
 XM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684744; x=1793289544;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1I7DuUCMPUgfhJ4Rrc21VPSenXrQWouZRCayfBtld6Q=;
 b=D7YC87uNi1n6PZSTR1LvM2pWdk5D1QZyZrq2vCXqa8uJHdncMfL4thSQO/m7gqvYq0
 y4n709HGiplUSG6d55RvzakqIvpMUB0/dp/hbBfBCkJ2oZkhflsKiNw/JJFcQMiECgF3
 KMqlvY3Mrm0IsuTD+yySixGndY3Dsy78CtrHrgosQUp6vd43louYxcLBwfhK+t9ffMrh
 7QL0+aaxjsxjvDJO/K4mMnSWaTY+va4mDlBTJI06EaWf9zCizkayFYFp+PAQ8pYillXe
 nSMlYQciP3MQDI/VeUhHB0m/yR63WxzBDYvGWQy9QO7CZoYMLBLvxwNYjs6dD9FpNz6z
 fn+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2fG53keK0IfUsMR3K/3GvynX9uWHqcQVfWswt0ekBq4CX3xYOWPVCB6bJah6K8WbxGRpgGG+0/Mvu@nongnu.org
X-Gm-Message-State: AFq9FYLSfxfUu1CJAyBHNJPxSajz0IU6mdIVH3LYr+3X8Dvr210oUSB2
 MfnBEfBkMuXNOLC3vldbZ3rGJiBBe9CpRG73AFuRwfy8U+MmrS1/I7ItvxAWVkV36l5hv/OUONZ
 PZqj/Pfe9XPXPNdIFxCAOkQh/WWJZrmQHVv7wD7mW2XmX5zFE3OUVyG4j
X-Gm-Gg: AYBFou0piuqYodyBFjyygyK9Ovewxub08uW/cTQt1EUjICFWrcTkbxkBTiQ2VRAFafJ
 X5su80QCALUVoP8xGSaF5UuTy+GSXO3CSFn6VfRejRroVhncIwKjzBJZzo4vuYAHhdTXvFLWl/R
 C4RH6+weLQDQB2ebROxPjtCo/5LMbY48NpKsYPcXAf1k2ArWVzwKFpJYWo/zkOO66eRYBBy8EcF
 q2nq9k9JKOaGKVND0IYZueoJx3LGPkfnmA3AP+HzbnGrpr5HjNjLAGVXInU87alT7q9sWXcXPBS
 njOby3Nor15chst77CsNxNPnZYLzh6/EY7PRfFyDdDphw7IaFFjCsriFA/fxzuWmJNII6PlfIu6
 +L4aqL/yBVlWSsRC82XcNKLDTOY0EN+53kg==
X-Received: by 2002:a05:6000:29d4:b0:48d:ee35:b3fe with SMTP id
 ffacd0b85a97d-48e2b698ca4mr5016614f8f.8.1792684743947; 
 Thu, 22 Oct 2026 08:59:03 -0700 (PDT)
X-Received: by 2002:a05:6000:29d4:b0:48d:ee35:b3fe with SMTP id
 ffacd0b85a97d-48e2b698ca4mr5016591f8f.8.1792684743582; 
 Thu, 22 Oct 2026 08:59:03 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835b1dsm14307438f8f.40.2026.10.22.08.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 08:59:03 -0700 (PDT)
Message-ID: <e89f7bfb-8da2-495d-b9a4-0adf3fe58f80@redhat.com>
Date: Thu, 22 Oct 2026 17:59:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] qapi/block: Add BLOCK_IO_DONE event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-8-hreitz@redhat.com> <871p9ksvx5.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <871p9ksvx5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20.10.26 08:55, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> This event is emitted when an operation completes, for which a
>> BLOCK_IO_DELAY event has previously been emitted.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/block.json | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 5f9f5c28050..38f293dd32d 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -660,6 +660,9 @@
>>   # Note that delays deliberately incurred by throttling do count
>>   # towards the operation duration.
>>   #
>> +# This event will only be emitted once per request and action.  When
>> +# the operation does finish, a `BLOCK_IO_DONE` event is emitted.
> I think the first sentence answers a question I had on the previous
> patch.  Move it there?

Sure.

>> +#
>>   # @qom-path: path to the block device object in the QOM tree
>>   #
>>   # @operation: I/O operation
>> @@ -686,3 +689,33 @@
>>         'action': 'BlockErrorAction',
>>         '*offset': 'uint64',
>>         'bytes': 'uint64' } }
>> +
>> +##
>> +# @BLOCK_IO_DONE:
>> +#
>> +# Emitted on completion for disk operations that previously emitted a
>> +# `BLOCK_IO_DELAY` event.
> Can we have multiple operations in flight that previously emitted
> BLOCK_IO_DELAY?
>
> If yes, might a management application need to connect the BLOCK_IO_DONE
> back to the BLOCK_IO_DELAY?
>
> If yes, how could it do that?

Well, the combination of device, operation, offset, bytes.

Do you think there should be an ID like a u64 counter per BlockBackend?

> Please use the revised syntax for introductions:
>
>     ##
>     # @BLOCK_IO_DONE: Emitted on completion for disk operations that
>     #     previously emitted a `BLOCK_IO_DELAY` event.

Sure.

>> +#
>> +# @qom-path: path to the block device object in the QOM tree
>> +#
>> +# @operation: I/O operation
>> +#
>> +# @latency-ns: Full duration of the operation (in nanoseconds)
>> +#
>> +# @offset: Request offset in the guest disk (in bytes), if available
> Out of curiosity: when could @offset be unavailable?

For flushes.

>> +#
>> +# @bytes: Request length
>> +#
>> +# @failed: If true, this request failed for any reason.  If false, the
> Suggest "for some reason".

Sure!

Hanna

>> +#     request succeeded.
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'event': 'BLOCK_IO_DONE',
>> +  'data': {
>> +      'qom-path': 'str',
>> +      'operation': 'IoAccountingOperation',
>> +      'latency-ns': 'uint64',
>> +      '*offset': 'uint64',
>> +      'bytes': 'uint64',
>> +      'failed': 'bool' } }


