Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86B3C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8UH-0006BE-L2; Wed, 30 Apr 2025 10:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA8To-00063W-SL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA8Tj-00082J-Ep
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746023520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w7GsWNIwAd+k5QttBcoCkBmOhUUVedcvwyhtHWoYUeU=;
 b=WmKeQMVA1Jgs810zKgPRDJrAt0BCGA5NRtn48hVmJzs3iEF/BJDb5p7MWb5fChkxhYPZ/T
 MR6OE1DB2hp2HPhbtHS2c1RaVn0EN6Ys3XA132fsPPq3iLAQaG+N5s4Lr1yZhoPoaBxVeN
 z3He0DIM867mTIraf8GEd5grxTF+qlw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-YbJBB9luM9C4gxc66xsxKg-1; Wed, 30 Apr 2025 10:31:59 -0400
X-MC-Unique: YbJBB9luM9C4gxc66xsxKg-1
X-Mimecast-MFC-AGG-ID: YbJBB9luM9C4gxc66xsxKg_1746023518
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so2064166f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023518; x=1746628318;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w7GsWNIwAd+k5QttBcoCkBmOhUUVedcvwyhtHWoYUeU=;
 b=jyXmI0tKVE4AKqI3odWt/SDfN/lxW3DZk0vsz0JkIHIylfoBVQVm3hkXNoLT2hqxzu
 MTGgSRG0TFFZBQVX7zwbPwll3lbSSdtIyvWH/+7oz2uL9zI5Me9xlB0qWKxtyQlKna16
 oov2BmpNvouBOmUgnwnmSU3EmDNX+yr8nBwdOVqDJ21B8RWvyJ2Jj9SMo5bNFUCT+dsC
 CUI9XIzB0noddXeA3LQymMYE9nmVBNp538r2wgaTatAqaJR9Su7hCnjWJisFh3cTbEkS
 RIiY96ZOXzocrP4cC4xh2PbpMIJut+KwCKxDedUAzp4hhUOlMm+f72kCrotBQqufGiQK
 I5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpgm9bj5kRVrQmYwKgU1THCC0dRsZe3oKypU0f735Lk1TwR63vIHJz0udvhMNgs8olF8kiXnUnjBst@nongnu.org
X-Gm-Message-State: AOJu0YzCU7yGRn3zQCXwhC8vL/FMigLZ1rqtwYsdaej8afP2d4lER45c
 BJfcJ/23ZMykEtPQx6Jh4wXifvRREC4Ye0ea2QHRISwmJlmc5T3kgYlymX5hHUxocmqFeyYxN/J
 vo1wWGElsslanffK2nuzx5hfWz3eJB/JemPeXvCKj/htKsWfvkAz8
X-Gm-Gg: ASbGncvK8wgcRlzzK6EWbbmzCeDLof2teAxJzGGQBB0fO5kYgW8dtz1xGQ5imDK33mv
 nLcN4VRstRaDXyOg8qsHnvJkeGqROnIp0OEZ1A1dmQH8wm0+mMin4jyeJctkDsjjIEybXPWQ19A
 OVtopnuyjt9TnXSGK0fXTRWlAY0/6WtT3PcGLLaCpJR+TgLXBD8XMtxIwWDcFopPrHEeWtivqlU
 frQO0MYEvs5wG0CRTDLsgZhzrolEsAb+mKMxpecmvNCg+SrXttzuBNPwcKsl6GxIXGS0no6YbGC
 OaxNWzXKYyErNCt9clxBuSgFW0FIjhc8MNQd25Ph
X-Received: by 2002:a5d:64c7:0:b0:3a0:831c:dff6 with SMTP id
 ffacd0b85a97d-3a08f79e4e5mr2900678f8f.18.1746023517073; 
 Wed, 30 Apr 2025 07:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvPDOIKjTmfljW5dtThGzTyb0inaMjj8mf3CnRg2YnibBuTuV8rTSqwwqnRJCfno2QH6qgUw==
X-Received: by 2002:a5d:64c7:0:b0:3a0:831c:dff6 with SMTP id
 ffacd0b85a97d-3a08f79e4e5mr2900642f8f.18.1746023516725; 
 Wed, 30 Apr 2025 07:31:56 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d52bsm17659611f8f.90.2025.04.30.07.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:31:56 -0700 (PDT)
Message-ID: <bb792162-fd40-43b9-80cc-8b99e65e6f9b@redhat.com>
Date: Wed, 30 Apr 2025 16:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250430132817.610903-1-thuth@redhat.com>
 <d315f4dc-11a6-41a9-9a19-fe96a12b07b8@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d315f4dc-11a6-41a9-9a19-fe96a12b07b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/04/2025 15.50, Philippe Mathieu-Daudé wrote:
> On 30/4/25 15:28, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The logic in the qvirtio_read/write function is rather a headache,
>> involving byte-swapping when the target is big endian, just to
>> maybe involve another byte-swapping  in the qtest_read/write
>> function immediately afterwards (on the QEMU side). Let's do it in
>> a more obvious way here: For virtio 1.0, we know that the values have
>> to be little endian, so let's read/write the bytes in that well known
>> order here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   This also decreases our usage of qtest_big_endian() which might (or
>>   might not) get helpful for the universal binary one day...
>>
>>   v2: Use leXX_to_cpu() / cpu_to_leXX() instead of doing it manually
>>
>>   tests/qtest/libqos/virtio.c | 44 ++++++++++++++++++++++++-------------
>>   1 file changed, 29 insertions(+), 15 deletions(-)
> 
> Thanks!
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I tried this on top:
> 
> -- >8 --
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 930a91dcb7d..5e01c1effc7 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -731,8 +730,0 @@ int64_t qtest_clock_set(QTestState *s, int64_t val);
> -/**
> - * qtest_big_endian:
> - * @s: QTestState instance to operate on.
> - *
> - * Returns: True if the architecture under test has a big endian 
> configuration.
> - */
> -bool qtest_big_endian(QTestState *s);

I think you might be able to get rid of the big_endian stuff there 
completely if we can be sure that all tests run with VIRTIO_1.
As far as I can see, the PCI-based tests should be fine, but the MMIO-based 
tests still seem to run in legacy mode. Maybe this could be fixed by adding 
a "-global virtio-mmio.force-legacy=false" somewhere in the right spot?
Or could we set force-legacy to false by default in the QEMU binary nowadays?

  Thomas


