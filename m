Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D70CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 06:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sljNe-00064z-8g; Wed, 04 Sep 2024 02:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sljNS-0005So-6E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 02:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sljNO-00005B-P8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 02:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725430817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FidyWpsVQpxK5btuZPks2IXNNPiAalWPAjV39AYCG1o=;
 b=FCMrX74MQKWo0ALjF2CQgWese2ahm6OjZR5yoC+vUHtLBSQP5qCQd384Yfxnj+RFaNM/y8
 Iv2wBVjNHjTR04v60f7zntBoZqf+Phqudze9Wo0pGyrcvA9j2nP6mnUn2KU6FV9c/tbA5D
 cDfeRrUQuPJv+zHuGOXsmZ050Z2XrYM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-8D9JV2xrNRu9LuP5gUJ8fw-1; Wed, 04 Sep 2024 02:20:15 -0400
X-MC-Unique: 8D9JV2xrNRu9LuP5gUJ8fw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a868403dbdeso470463366b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 23:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725430814; x=1726035614;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FidyWpsVQpxK5btuZPks2IXNNPiAalWPAjV39AYCG1o=;
 b=vLLoFD1XKYHGD4RfdKReWlwIjPhQ1LSUI1yfL/3z9dNI1ReusV1RMJW/L6SWzAkurI
 vKZ6fUP6G6MFrY2XYYeBWr6RUhHJqZwMZIurcuMyu+UDL5haGU/VDa6z3CFgRuo5T7pl
 P8sle8XPZK5Ne0UKHKQ0ezWyfDR/BKCeJFy46BH7dBGS1vekTWly8wBC+P2jpOuomtvV
 zclOQGnrcQUKz44qmR6Y/ydundT5+Jbistff/cneiffeLBA9mlbNpQz+Zed0juynAYAY
 4VdioKlZp3pQJbUhDL8PBlHZiVm/goo2eZe3KLf2H6ZlOSJOqhhH9Wl0NGSbojOGicQF
 VVtg==
X-Gm-Message-State: AOJu0Yy9/VgGdvLPdq87/1TW7ZvKPfwMNM8VZZvwkKZH+V19nUGTDlTM
 m/9poIGJzKbkBqio+odWlLHDjW6nAbA351A9SALWOKcgNlyo0RNo+p92U96OSE0NpvIB5zBJ1cx
 cZw9yCJVDsNg0aqdEJj7MBy8tQKH/rjs3mUnpx2uo5Z/r1JswLAvp
X-Received: by 2002:a17:907:7203:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a897f920068mr1536289066b.32.1725430814341; 
 Tue, 03 Sep 2024 23:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX08+F0G71yOvNsw6xeNSpLNSoj4iiyYrjLR5Rf65GdcT8Wg5RqLIqcc/jul+7+ghxM4vX3Q==
X-Received: by 2002:a17:907:7203:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a897f920068mr1536286666b.32.1725430813820; 
 Tue, 03 Sep 2024 23:20:13 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-181.web.vodafone.de.
 [109.43.176.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a3e78a386sm52731566b.158.2024.09.03.23.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 23:20:13 -0700 (PDT)
Message-ID: <73ba8035-9fa6-440e-9ca9-0b6934525489@redhat.com>
Date: Wed, 4 Sep 2024 08:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_vnc: Reduce raciness in
 find_free_ports()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240903143553.16877-1-philmd@linaro.org>
 <ZtciHTFGPtUlMKM_@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZtciHTFGPtUlMKM_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 03/09/2024 16.50, Daniel P. Berrangé wrote:
> On Tue, Sep 03, 2024 at 04:35:53PM +0200, Philippe Mathieu-Daudé wrote:
>> Pass the port range as argument. In order to reduce races
>> when looking for free ports, use a per-target per-process
>> base port (based on the target built-in hash).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20240830133841.142644-33-thuth@redhat.com>
>> ---
>>   tests/functional/test_vnc.py | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
>> index b769d3b268..508db0709d 100755
>> --- a/tests/functional/test_vnc.py
>> +++ b/tests/functional/test_vnc.py
>> @@ -10,6 +10,7 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2 or
>>   # later.  See the COPYING file in the top-level directory.
>>   
>> +import os
>>   import socket
>>   from typing import List
>>   
>> @@ -18,7 +19,6 @@
>>   
>>   VNC_ADDR = '127.0.0.1'
>>   VNC_PORT_START = 32768
>> -VNC_PORT_END = VNC_PORT_START + 1024
>>   
>>   
>>   def check_bind(port: int) -> bool:
>> @@ -41,9 +41,10 @@ def check_connect(port: int) -> bool:
>>       return True
>>   
>>   
>> -def find_free_ports(count: int) -> List[int]:
>> +# warning, racy function
>> +def find_free_ports(portrange, count: int) -> List[int]:
>>       result = []
>> -    for port in range(VNC_PORT_START, VNC_PORT_END):
>> +    for port in portrange:
>>           if check_bind(port):
>>               result.append(port)
>>               if len(result) >= count:
>> @@ -91,7 +92,10 @@ def test_change_password(self):
>>                       password='new_password')
>>   
>>       def test_change_listen(self):
>> -        a, b, c = find_free_ports(3)
>> +        per_arch_port_base = abs((os.getpid() + hash(self.arch)) % (10 ** 4))
>> +        port_start = VNC_PORT_START + per_arch_port_base
>> +        port_stop = port_start + 100
>> +        a, b, c = find_free_ports(range(port_start, port_stop), 3)
>>           self.assertFalse(check_connect(a))
>>           self.assertFalse(check_connect(b))
>>           self.assertFalse(check_connect(c))
> 
> As your comment says, this is still racey, and its also not too
> nice to read & understand this logic. How about we just make
> test_vnc.py be serialized wrt itself ?

We'll likely have more tests that need a free port in the future... 
tests/avocado/migration.py and tests/avocado/reverse_debugging.py use 
find_free_ports(), too, so we should maybe think of a logic that avoids 
clashes between different tests, too.

  Thomas



