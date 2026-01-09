Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A974D26D8C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veHCc-00030U-FU; Fri, 09 Jan 2026 13:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veHCP-0002zO-3v
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veHCM-0004xd-Ad
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767983217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mgJaePqAmaPjZASouB0iezHnamsQ7IJ1GvoIifrdwJo=;
 b=S/KmNDLYX+7A5QSa7ELU4QDWwi124aDTXwVKiTQDqJVVjHU+DusP9kBgbF39k3AbrelibR
 LAE56EwV3P0VFZnWuuQGxKIjD95QezLYgRHvhjyrz8elw64RI0D4Rz8FQZIqjQJu5kUMTK
 8d+2ncY/j/4pHh0lyoI6ElYA36fxsGo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6v55umKvMFeGCgc6sxZDCg-1; Fri, 09 Jan 2026 13:26:53 -0500
X-MC-Unique: 6v55umKvMFeGCgc6sxZDCg-1
X-Mimecast-MFC-AGG-ID: 6v55umKvMFeGCgc6sxZDCg_1767983213
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8395cae8c8so342523666b.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767983212; x=1768588012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mgJaePqAmaPjZASouB0iezHnamsQ7IJ1GvoIifrdwJo=;
 b=mfvbNsXVpmvgZ6iItciEv0v82KJQpeE0seqZQTQVYe9y3jEiKZG+oHh2Zz3Ed89j5n
 L7C6G2MaWha8f0vYOHuzC8LBJqJcalZT811XjMSPmImT26838Ds5DFQOIEnlgB5P29UZ
 6eJRv6rQ/paOzFsLsoGmLc7hTHQWPQV+U8EqJJqVP/KE5XeVcwp0Sat76zP3p2qeLLnO
 xjs0vOILhejtNRHLLlXBNVy/cW12etZhGLoNmlBpO5rMSaxjwGyUPYjTJ7zPw7e5s/19
 vA/6Q7hfvZXHU/Jygt9IJB8xTjbaqZotMfLMcjavL1Jcmo4dPxXZF5/c9V0239UT8/E5
 OckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983212; x=1768588012;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgJaePqAmaPjZASouB0iezHnamsQ7IJ1GvoIifrdwJo=;
 b=ioYcPOP2egSudulg+W02ANT3QYyEY40cNhnrCkFviSeBrn2V+yVOyUJNmU1t1IO5fm
 V81s3SedPV6NK/+R/PNId2rQXASt/erAkUeMWAqwSrX8PH/aETvK+wRTT4HWrNOvwNVU
 Z44nZk17UWRSVIPqpSM80Tl/WVO4WYvlihpMKPRZDuPiVhxWl+fZovHkkV7eldayfAfY
 w4NQ+x7EVYd5tr7xtHsw+mx+N1JYCqkJfKkySDWyuuuURmIDGwiAIqjGEC2qSKonnxg4
 YuLBGIrAJyWEQTdJ7Tnt1sVLYwKm/Kc4OyBksJiqiOh0NFVBKlbm2V/LSt7HqbfF4Y6E
 gH0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpVNgIErlVYUF/a/B/J2plmO+/UAl6p5kB0qFUseeElfPuJlOglgavUwPCg3jmMOSbOrD7dS5RFtgm@nongnu.org
X-Gm-Message-State: AOJu0YwA7Ar5FP5vZCiRzMQ5QMx5U8Hh3qUgG3ldh2efUWGeGfXyxveQ
 5fJgMueGI5DVFFLL12eapXX+dk1Qfxt7ZkXmOT52Et6MT2ezvoGBrnfONJSWxoUaXXlFkC/jwKX
 5Aa4cp/cN/PsyUlhCvdLU2rUKw341k1Bk0oqeSS2j1HW/82Lruu7QoFne
X-Gm-Gg: AY/fxX691IixinWN/48xm4IffZwwSRMxV2xDVQa7MmoM59bQlknt56SCtjt+3xWsR2e
 WF9Dixkh1vZ73ZIYoniclRpdjrk9k7b1y+BnbzjhYaWVwvPrMXjdkg1suDt56c7uHF56AsE0O30
 s+PLKZ1HDT0swf68dV/VjzaVnoOWETiXYkgDUF8jneJmHlWwtnkTFFgvPU2zbwIssfbsxKur3xB
 gKD/F9MXM97UkmNfRHMRqscjtF5lNhDI9UL6i6IDYqO0aJ+TjXMpOCGr1gdWd8jJUp95B7gPjoQ
 cHKjCruKTX/SkEIIsEcqEUdfP3sVeNIkvt88wKCC9c2aT6pgffyGLwzboPSzgFWKn40lEOq1d6n
 KVW5+p38=
X-Received: by 2002:a17:907:3c86:b0:b7c:fe7c:e383 with SMTP id
 a640c23a62f3a-b8444f2399cmr1098703566b.22.1767983212611; 
 Fri, 09 Jan 2026 10:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn+2pkPGjCCgAXyKF1IvhdiPt14uLaAZ8UTEE/3xgukEeOvxqMn+y8k8P1aGV5hPeAhfKsTw==
X-Received: by 2002:a17:907:3c86:b0:b7c:fe7c:e383 with SMTP id
 a640c23a62f3a-b8444f2399cmr1098699366b.22.1767983212160; 
 Fri, 09 Jan 2026 10:26:52 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a517cf1sm1169076466b.59.2026.01.09.10.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 10:26:51 -0800 (PST)
Message-ID: <20391bae-fc6e-46e6-add1-add11e35852e@redhat.com>
Date: Fri, 9 Jan 2026 19:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/29] pc-bios/s390-ccw: Refactor zipl_run()
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-18-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Refactor to enhance readability before enabling secure IPL in later
> patches.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 51 ++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


