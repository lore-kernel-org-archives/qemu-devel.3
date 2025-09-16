Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472D1CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 05:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyO64-0001dA-2m; Tue, 16 Sep 2025 01:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyO5r-0001ca-Lw
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 01:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyO5p-00086J-7q
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 01:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757999941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1mo8cC3A6NJHckzFHcKq2tmfz7TYSsCZxA2jmnWPD0k=;
 b=VTkYIcdyiUgtOqSegjV3v+jB0LvphF4ZaCHU7itt3uFWasbNrn9eyvHh7znq7OwW7sWF+H
 RLHlOJgQH64wok61LmCsQWEN5iIafQC4A5qjXgugMaEObL+zp8tRtkKQb61YzEjlu536yu
 r2oVjPwF0HLXT+6hsafRe835SDszudU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-7oeQdx8OMD-IdCPTEcIrzA-1; Tue, 16 Sep 2025 01:18:58 -0400
X-MC-Unique: 7oeQdx8OMD-IdCPTEcIrzA-1
X-Mimecast-MFC-AGG-ID: 7oeQdx8OMD-IdCPTEcIrzA_1757999938
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd56f0000so32320945e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 22:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757999937; x=1758604737;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mo8cC3A6NJHckzFHcKq2tmfz7TYSsCZxA2jmnWPD0k=;
 b=LdOe46trwtv22NHkK2IABtySx4Z1hH6hrGKYgjRS5VT7Cap1mE96mFMLbh6ZxYTRV4
 OjcJzMFSqiEwlxAREAiGCNKpX2g6V43I8H4keLUR0Otlcc6BLDSPWCwYvJkIxSorSEoS
 5aWNBNfJD90IPjePC31aqbOF1mGXxdy14P52DdoEisz1fPzSkLuhzt3/CCbbsxsQVgXs
 /CxQBZTKoKqFSeO/bMUEUo9AvT+VeCBb5qx+r8FoA1ffqfct1Dhy4SY26Nsap2kMCipu
 04+m2Fcykl+ex54Ypssn1DOHjE8ZmQ+5DVIYt1Ea2MQs+xVwXi8xweEOErrJdM/wSWyI
 swwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJEwXPLChlD8U7teVd6GSi6lQ0AzKYhCFoJZYB5EJyQYOqUdIEWeCvEyCeyYBZnKt0qZzqU0RcE3i@nongnu.org
X-Gm-Message-State: AOJu0Yy69/o8e02S6yTrahGkID2wyVg6z52TcP6D0e8QUsXbtI7drNjQ
 AkLfz4AlWFX1he25HywEKayvdgW+L2v2J/shguHzqgZFTBXNsg1V+PLI1ULy4pGlvc2ZQtW3EnF
 RWjvvFTRLyjRP3ALQ8/xtgPrZEQG2qoqisV37qDx4mYcCw0T5lKWlw8kY
X-Gm-Gg: ASbGncsZMaYmdsJfT47N2HfkBW4eBdWfb3Wa3VgSKMHJwl8kkFoEOew18i/lHPjJ1+H
 uM2q4d3afOUvBvhTJ7pl5bd2K3vxB2L+K5kU0+o+0eE7/NZDaiMwHA9QyW4wiRNGouWXcSk70hv
 HauwWY3bzL/j402B1MMNKlAs67oSjBNc3t/aaHN7VFcTbOafamAj+mnQE54f7kalrDxwTr1Riv4
 u0dKv6vPoTj/SyKuppTlqQZiX3tEDhVZjR7XZZfmHSFmku6Bpw51f9HJzMls37W1Eo/HPZtxUiX
 Kj5Id5InbeJwq6ZY6RwmOan++wh9SZeV3BML33TMWGgw+zYD12tstUrf/jxwy6vB/Z5A5H7H0J2
 67RHKIg==
X-Received: by 2002:a05:600c:630e:b0:45d:d197:fecf with SMTP id
 5b1f17b1804b1-45f2117b46cmr132808205e9.0.1757999937620; 
 Mon, 15 Sep 2025 22:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbK6LtnazPFd/YmaRnrY0yNdjhYbfxysaigScOfZ2ZFsacDfSTesXowy+IellJRfEDo/05MA==
X-Received: by 2002:a05:600c:630e:b0:45d:d197:fecf with SMTP id
 5b1f17b1804b1-45f2117b46cmr132808065e9.0.1757999937267; 
 Mon, 15 Sep 2025 22:18:57 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017bfd14sm204839035e9.21.2025.09.15.22.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 22:18:56 -0700 (PDT)
Message-ID: <8865c3ad-341a-446e-ba29-e4c9f6bab514@redhat.com>
Date: Tue, 16 Sep 2025 07:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250915185509.340022-1-richard.henderson@linaro.org>
 <a6108491-9e0e-45df-9448-45de99e373a0@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a6108491-9e0e-45df-9448-45de99e373a0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/09/2025 03.38, Richard Henderson wrote:
> On 9/15/25 11:55, Richard Henderson wrote:
>> Startup of libgcrypt locks a small pool of pages -- by default 16k.
>> Testing for zero locked pages is isn't correct, while testing for
>> 32k is a decent compromise.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tests/functional/x86_64/test_memlock.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/ 
>> x86_64/test_memlock.py
>> index 2b515ff979..81bce80b0c 100755
>> --- a/tests/functional/x86_64/test_memlock.py
>> +++ b/tests/functional/x86_64/test_memlock.py
>> @@ -37,7 +37,8 @@ def test_memlock_off(self):
>>           status = self.get_process_status_values(self.vm.get_pid())
>> -        self.assertTrue(status['VmLck'] == 0)
>> +        # libgcrypt may mlock a few pages
>> +        self.assertTrue(status['VmLck'] < 32)
>>       def test_memlock_on(self):
>>           self.common_vm_setup_with_memlock('on')
> 
> I wonder if I should have chosen 64k, which might be one 64k page...

It's a x86 test, so we should not have to worry about 64k pages there, I hope?

  Thomas


