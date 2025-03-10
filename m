Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D243C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treHI-0002o4-U4; Mon, 10 Mar 2025 10:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1treHH-0002ne-SF
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1treHG-0001jB-8s
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741617523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1e9d+owy3y6971c85ckgQHigN2Ng94isCUrTfQgQZd8=;
 b=IzXJmOE5cqpdP4IthP5vewX4tM2+tVxuNTX1eksXhJHKTIHoJcyM0X6FNRqd/PI7v8x5Ye
 M4NF4V/KrUOQWUljbNruTzejKwtKo+QsqgrrYTVOSx/rP6+JOfCg726svcdlknzz8Xdezn
 exJy2wJgs94XuRIqN3ydt2KT/INQ4E0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-UdkUp0JxO_GFQG8Lm6YVAw-1; Mon, 10 Mar 2025 10:38:41 -0400
X-MC-Unique: UdkUp0JxO_GFQG8Lm6YVAw-1
X-Mimecast-MFC-AGG-ID: UdkUp0JxO_GFQG8Lm6YVAw_1741617520
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so740645f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 07:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617520; x=1742222320;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1e9d+owy3y6971c85ckgQHigN2Ng94isCUrTfQgQZd8=;
 b=FGZvQ37WffsUIF5JAeXwEu5KMDKmICD4Yth4/LLjGGRKwxydsRdi2hErzKuRB41/St
 SOMPhz0Dw7GvQD/gtPg6F/ylHP93QqCDH4hvW49Oi8Ikkj1nBvmH7hYKhzQG4Fn2uC3U
 F2p5HBIuQohcGrvuuj+UTvu590u4B8Sb6yyWXFzWdKeMoRM8AiZ1IwyV1RkY/7p07NmK
 aUqGdbpO7RP8J7PgcRgky6Beak6X+8Ua9yRQ9erGXciAbLDXCiLTYprdpWVUiTnxtriX
 nfV5zABt63qS9ABr35Sk1aloiNOrLjXxktuEYORpZF1upgAPTHMLEdvzwWnd25aC1vLp
 3eLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmHLvLnUEgifPkkSMYTvwXsDsrQuttOWWK14AQt3iM64FOB8F5n512sAep8Dj6a9nmOlRb9fpQVeVC@nongnu.org
X-Gm-Message-State: AOJu0YyjoigAR0X9ilaaoqMYhSPHc5RmLDzQlVTuvbEeYsgZV72hoaf0
 3IcQjtDwhAxePitlZnqmz/vCNN/quCo5KJs2wLgLLwUa+zzFhtyEejVFQZpvXkRpAdqaplMD75O
 S+LIgevAv1OIjYG2f7HHlDTZPsheMuPeC/botRqe5+gMY7Dc3VwDy
X-Gm-Gg: ASbGncvOcPmGqp8Mr7hIERZc0Db+mCL+2oAhSwnR5KlHSvFecmkqyaXvpjFjUAkFUYi
 3J1Tq3ZKpaDCuSnRLMpKZo/au9B7dRxtVy2P44uwhK5dDOEgUQGSwVdXgyQcFODwtNnaQ4K5EDv
 pquQQgdqwBYgTh/t5q8DEvwmqaLr9mNkCv0mIynBMlp8YR/rU3oAOHBcJu6aAEdHDRryWEHwu6R
 H6nms0anhbnGscK6KK3MbN6M14nswiOYZDP0h2P0gBfh0ab9pPo0p8NeYUohe9HYraLDte1ZrM/
 Pxw7g/8gJS15yT+2mAf9cXPTvtmvtXaCXSLOhr97p1wBeAseKKqI2A==
X-Received: by 2002:a05:6000:1f84:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-3913af060e0mr6671654f8f.15.1741617520356; 
 Mon, 10 Mar 2025 07:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJaUheq3tB/PQEalv3A72j2mBwfmY1a/bMnyUARQ4jG6hxTZWKTy8Yt8TfHlhfyjcVmK5HxA==
X-Received: by 2002:a05:6000:1f84:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-3913af060e0mr6671617f8f.15.1741617519897; 
 Mon, 10 Mar 2025 07:38:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfbab43sm15419845f8f.15.2025.03.10.07.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 07:38:39 -0700 (PDT)
Message-ID: <b274c191-36db-4671-8361-59d2688d16de@redhat.com>
Date: Mon, 10 Mar 2025 15:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Vasily Gorbik <gor@linux.ibm.com>
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
 <20250204170759.36540-2-rreyes@linux.ibm.com>
 <52dddefa-a9d6-41e7-ad23-a93f65896034@redhat.com>
 <27ccfad0-99d1-47a5-8370-2b16ea924ac9@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <27ccfad0-99d1-47a5-8370-2b16ea924ac9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Rorie,



On 3/10/25 15:20, Rorie Reyes wrote:
> On 2/5/25 3:38 AM, Cédric Le Goater wrote:
> 
>>
>> Are the kernel changes planned for 6.14 ?
>>
>> FYI, QEMU 10.0 hard freeze is scheduled for 2025-03-18 which is
>> approximately when 6.14-rc7 will be released.
>>
>> Thanks,
>>
>> C. 
> 
> Vasily - Since you applied my kernel patches already ([RFC PATCH v2] s390/vfio-ap: Notify userspace that guest's AP config changed when mdev removed), would you be able to answer Cedric's
> 
> a question?
> 
> Cedric - I have some changes I need to make based on Tony's review comments from Friday, but I'll wait to post it once you get an answer for your question. Sorry I took a while to respond. I had to
> 
> make some changes for my kernel code this past month.
> 

AFAICT, the changes were merged in the s390 sub-maintainer tree,
07d89045bffea30ef08b902c2441a3329e44f29d, and they haven't reached
Linux master yet. Seems a bit late for the 6.14 cycle now.

linux-headers in QEMU are in sync with version 6.14-rc3 and that
should the last update before QEMU 10.0 soft-freeze tomorrow.

Most likely, this series should now target the next cycles:
Linux 6.15 and QEMU 10.1. We have time.


Thanks,

C.




