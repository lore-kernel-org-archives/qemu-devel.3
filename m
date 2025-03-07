Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11492C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWzf-0004oY-BZ; Fri, 07 Mar 2025 07:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWzB-0004gh-1j
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWz8-0001Ak-QX
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741351165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3cOi1xB9O+Ym6x1JMwENVrcebEHG0oRcEVtqOcNHyz4=;
 b=UPEgNQT3nkwH/2AwBFD9yw9+D8zaBdUy5BneVKyTd2yKNVLx8n43qcB+UsUo8lQir+cWWp
 RB/btoEX//9zSyah5dRVTCJ5uesIlq/O8HLeqgPNMJFHHKm+7uv3DprT2K/LnewHJ89GYq
 kFeGAeem8IWCNTwibNyiUOnAQ9OA+B8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-TP2rYkMyM86WWilU9OhZ9A-1; Fri, 07 Mar 2025 07:39:21 -0500
X-MC-Unique: TP2rYkMyM86WWilU9OhZ9A-1
X-Mimecast-MFC-AGG-ID: TP2rYkMyM86WWilU9OhZ9A_1741351160
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912fe32b08so725810f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741351160; x=1741955960;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cOi1xB9O+Ym6x1JMwENVrcebEHG0oRcEVtqOcNHyz4=;
 b=CNwcZ63kWW6xUf/l3G+ftV91vTcPMurdJ9CgizwkA8E00Q81LbgRu9MTapYAmprTBX
 clJ7WyMiYgIGrJs9TqeblvMe6pF+3ntNeIyhdx81i/+g3gFIEjf80rfsixoJiJojVQI2
 iIhJHlHBg8Cz1p2Nb5y5qZbUOmiPB/u8S7pfPDPQmErY1lEawy8tFvXHuRhH0XMBcxkH
 rG1wDpPe1yP6+M5J27s13DBPJ4fGcHTJ4cLxeHp6aj4h94uq1qSIZvYCMtr9UzRLeUOf
 rLAyWKJuEyt+0k71eePgAXsIMJxHi0KzitEJYGKpWdWzUtgKzf+yhMHl4AVQSsi3AE6h
 KhIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURQdfZpBfwj7OsUw1aFLFQIvFMYcR/jgsP3e2etoZICRyTz0DTtqhAGN/PN3vMBqyb7apL/sQzzGWT@nongnu.org
X-Gm-Message-State: AOJu0Yxe93zrAUP00q1gqX6UxHDwDXikT+Kug5YkrZUb0sKCgH63+rdF
 CySvbTohj62616in0sOWcJOlBUlSAWV0aPmVN4IewjSBGqcRROwTYE1Om50tylOjq6JvaMLIB2K
 bdzJXVCyaSlmtOAO/ufGFXy9xXP7DfKEWdDAvISl+x4fZrNFqegsh
X-Gm-Gg: ASbGncv7xk68y+gmrkDytBDJzwxhvwwZ/1d6cRgyrncdbtcEHvRXeqOcbBJSuzpt/2z
 kY/UtjDCMRYP1JtiNDK/SKHmdlAlyDWwa36pJhVx2xG2DZTuA5oI8QB9/qINuYcylq5q6l1KzCA
 4SanPurCOUAA0E1NN7IXshrf+PI9Wr4J2J/qUoFEJQYV59S6Sei6OSP2RCvl1sAJWhd8ENTCctf
 odQe+J0YjkC3YEtWI/+VldnEQoW20D2n4ZLdJmniH6SE4GVcmqDc2gJdAd1YX7QfB+VtW3s5A29
 jmRfMttCbvlq56/O9uwfyZIb6sVYOEsleJQXLwmxoko+krc=
X-Received: by 2002:a05:6000:2ac:b0:390:f9a5:bd79 with SMTP id
 ffacd0b85a97d-39132d3b11emr2040435f8f.26.1741351159991; 
 Fri, 07 Mar 2025 04:39:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFensp5jsVXvHN1y3J0mB8XvHKw2bOFzn/cysJEApGPE45epC2ue0uH6tcURSIDo+HGIEb/OQ==
X-Received: by 2002:a05:6000:2ac:b0:390:f9a5:bd79 with SMTP id
 ffacd0b85a97d-39132d3b11emr2040427f8f.26.1741351159681; 
 Fri, 07 Mar 2025 04:39:19 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfe2bsm5224524f8f.24.2025.03.07.04.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:39:19 -0800 (PST)
Message-ID: <1d1756d1-e16c-474d-b220-05829a2a8ab3@redhat.com>
Date: Fri, 7 Mar 2025 13:39:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/15] tests/functional: fix race in virtio balloon test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
 <20250307115314.1096373-11-thuth@redhat.com>
 <69bc17ce-de05-4b4f-88c2-57866c6409c4@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <69bc17ce-de05-4b4f-88c2-57866c6409c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/03/2025 13.34, Philippe Mathieu-Daudé wrote:
> Hi Thomas, Daniel,
> 
> On 7/3/25 12:53, Thomas Huth wrote:
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> There are two race conditions in the recently added virtio balloon
>> test
>>
>>   * The /dev/vda device node is not ready
>>   * The virtio-balloon driver has not issued the first stats refresh
>>
>> To fix the former, monitor dmesg for a line about 'vda'.
>>
>> To fix the latter, retry the stats query until seeing fresh data.
>>
>> Adding 'quiet' to the kernel command line reduces serial output
>> which otherwise slows boot, making it less likely to hit the former
>> race too.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Message-ID: <20250304183340.3749797-1-berrange@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> [thuth: Break long line to avoid checkpatch error]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/test_virtio_balloon.py | 26 ++++++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> This fix isn't really working, and is more of band-aid IIUC.
> 
> With the following patch restricting to KVM accel, do we still want it merged?

Yes, I think it still makes this test more robust.

  Thomas


