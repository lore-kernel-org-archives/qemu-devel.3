Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F1606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hMA2jnyj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A1KWEP9W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJv1i-0003zf-Da; Thu, 22 Oct 2026 11:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJv1g-0003yS-O6
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJv1f-0001zw-5C
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792684097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmscsZv8B8vYCpMt2SWBh6jcG79yTGj0leNmKhRAmLw=;
 b=hMA2jnyjRFq32YV3NrsL3xoZFy9f/sTVx9LVmktgdEnRrhWureZPmIs2Vx+HNLnr/3ZYuP
 JH+q7HrA9w82d+TFnMJOU14bfGUzTcloLgRCmsRb+UNVXfZg3XGjHmkmC/HvPgsVOOc79j
 tpB+HKsAwVU6OvkkwkXcv/i/7gQEBjQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-DF8Heq1kOpqGDc66zQ5sCQ-1; Thu, 22 Oct 2026 11:48:16 -0400
X-MC-Unique: DF8Heq1kOpqGDc66zQ5sCQ-1
X-Mimecast-MFC-AGG-ID: DF8Heq1kOpqGDc66zQ5sCQ_1792684095
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b02d63407so1309566f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792684095; x=1793288895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fmscsZv8B8vYCpMt2SWBh6jcG79yTGj0leNmKhRAmLw=;
 b=A1KWEP9WrecF+hgMWklGah5mabN9h+p+8HX9NeemU6UJIU2xSeM6/PxWRMkjDD34mU
 t1k3jXu+/Jnn2SvgWfk9mHpNMVhm6ye2rc69tRt+bXR+3e+6G7d3uQMqbSzn0lH/uAqn
 iynFEClhePhIJDksQo+Hvj5G8Yz8oykXkiWiNJtzqA9ZtRfG3rGTx6Kzgw3J/2DbKU6y
 d6opkMfjpf6FElJIQzCXOojuJ7K4JY98VZ4KUJlKayuSLEgotrZOtpcDvfMP8vFGKXbJ
 1SNu/pjPGjxQrsjuE5TAbYUvErhZBV92+Y+UVINZTkwdV4OdyjDWQ9LGvLHeJ/SBVeNj
 8ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684095; x=1793288895;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fmscsZv8B8vYCpMt2SWBh6jcG79yTGj0leNmKhRAmLw=;
 b=dHSZWBkzFOQ1kUI9VjT5vcT46yPQlPcqTid8+W+SfK98abWkuMLV25kf59Cv20tiA3
 8yWes+pKvs+Zb/eQRytRWjz7Dqq71uCGytdaVN8vdwJ0U0c/tJeO2a81cvNfzG0DPvhE
 exKf5r8NVL2j/Ts9wl2ENVQrCyGKSp1TayRwLMd0QRYFiBLaqJ36TLf1S8dar7eKGyaf
 RTVpUVowldxZwo9WxnluoidAVwn938wyeSrhcXwKHxo6F3M4xDcKuTPPdSNtlLdqh88z
 KQ7kxaGpRdwLkoLbNylUppX8hcq+dEXC7LsaSdGGZ+HjQB0gd+y7C1H1RvGTUh77rHDy
 X3vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwq2Z2Z8kSxPRTJKwUMWhZsD4KA89jkS/KVlWd+5hHvaHpIvu2lvJwZOF3iDgE12REnaC/ahIvIfduY@nongnu.org
X-Gm-Message-State: AFq9FYKfV3XtG+zB7jT4xQtRtv7fSAg1Xo+/WYS9fdA1hpbuEn+VZR2u
 Snwp/Gi/sHQvds1JJEz8PUH/Qe6WVem0NAPB88sJjXYB7cDX3liVR2xE7fESnyUs55kzQXMPzO4
 ZqAv+gke/t+qeha6EjSChKYUd7/XN+PRBb/aHC3VSaq2F6p1QPZY+PLh3
X-Gm-Gg: AYBFou2ujH6T6hnuMwF6oyfJGTEvLG0l3ycVY/RlyCldJOFf3NkOeUMxr4jlSKhzmR/
 /Yqvytfq9fPpyh7TlzsN9TeWVjWPlsBK6sstU9JJLcJg9MUK48ESoOoVoq3RXrlNu1la12s92R1
 HmaQY8gK7Ssvg83K/cxgQ+DALsSjvLY5tmPmVF2y1+zQaxyP63uIPoGTpFN2BkE/RacugGr9ML2
 O+aMlY8s3cSisUoHNcgKH/GEFstCwXCx3a81jXTaRAvqXq3xks70Ap2bur/o0qZX9cjOYp0y+Hr
 18y/YFU2CMrwYGV95yN4EmXUioLoeBg2XFxvLd9M7XIzu//ZcSKvKlCs51rOVEvc8X71RDLLza8
 FvITXii9EQS/jzbMgRrD9Z23l59y3s1leiA==
X-Received: by 2002:a5d:4573:0:b0:48d:ef7a:e59f with SMTP id
 ffacd0b85a97d-48e264ab28amr9526096f8f.17.1792684095197; 
 Thu, 22 Oct 2026 08:48:15 -0700 (PDT)
X-Received: by 2002:a5d:4573:0:b0:48d:ef7a:e59f with SMTP id
 ffacd0b85a97d-48e264ab28amr9526080f8f.17.1792684094780; 
 Thu, 22 Oct 2026 08:48:14 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828caesm12336340f8f.29.2026.10.22.08.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 08:48:13 -0700 (PDT)
Message-ID: <a29d0076-15ad-49d8-b1a4-0991a07bcaa4@redhat.com>
Date: Thu, 22 Oct 2026 17:48:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] qapi/block: Add IoAccountingOperation enum
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-3-hreitz@redhat.com> <87y0bssyie.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87y0bssyie.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.10.26 07:59, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> This enum gives more information than IoOperationType (which is used for
>> the rerror/werror distinction) to identify operation types for block
>> accounting.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/block.json | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 0a88d405a26..8f4a71733c1 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -629,3 +629,23 @@
>>               'command': 'str' },
>>     'features': [ 'unstable' ],
>>     'allow-preconfig': true }
>> +
>> +##
>> +# @IoAccountingOperation:
>> +#
>> +# I/O operation types as they are tracked by block accounting.
> Can we have a link to suitable docs on block accounting?

Which do you have in mind?

Also, I’m not sure whether these are suitable, because they are the 
operation types used by block accounting, but for now, accounting 
cookies (block/accounting.c) use their own non-QAPI enum (enum 
BlockAcctType).

Hanna

>> +#
>> +# @read: Reading data
>> +#
>> +# @write: Writing data
>> +#
>> +# @flush: Flushing data to disk
>> +#
>> +# @zone-append: Appending data to a zone of a zoned block device
>> +#
>> +# @unmap: Discarding a block of data
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'enum': 'IoAccountingOperation',
>> +  'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }


