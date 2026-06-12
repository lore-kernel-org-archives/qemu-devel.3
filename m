Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CFBCD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2eU-0008Oq-8u; Fri, 12 Jun 2026 10:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wY2eS-0008OQ-I7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wY2eQ-0007xG-T2
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781273664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RkPseOosZoEncJN/TIh0OXn/Tyi8CmxsUd64wNlsFYk=;
 b=A5LIokAHyqYLWzRwheNimyTZEzHbseMYmC1VqFgfhGjn0ntHTwvo4ZfcU2qbQluxJlbKpJ
 OZUP092xTaugIv9gCh0nRiAkO59zwYluBhn6KtMcoFHnqOWAx37HshEy2h7XKWuCLoltWt
 DK+1pJDW0fdGCsZ+RKxoiHpIwmv/39g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-psAd5nkSMaKD0zLl28VN2Q-1; Fri, 12 Jun 2026 10:14:23 -0400
X-MC-Unique: psAd5nkSMaKD0zLl28VN2Q-1
X-Mimecast-MFC-AGG-ID: psAd5nkSMaKD0zLl28VN2Q_1781273662
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490bfd70b0fso10105085e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781273662; x=1781878462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RkPseOosZoEncJN/TIh0OXn/Tyi8CmxsUd64wNlsFYk=;
 b=CPnqB5cwUW8IGodoIXJimCIsHxdS3+3HxPhioKeu6Ta+KESVYNBSH51ATKB5IxlKtj
 1i8P1PO9ZI2CLMZeMUoZr9zTl4mKB9y9ej1jqtuzqyeNsy0eEHz0HLuqniJQnwHpyfZf
 XXoCT64qywhFG/EKJds0TygFoKim1tqGpKwL9l4eCDbdcidiJ5AQDFrq78xvq9IJOAC2
 GghWu5XM5O3VPR/xR0MIPxHKq/Io/6FfSL735ASKAr4K20Z3bc3ZwW2uBuYFTgfJHP+V
 XxT1jtTUEkUUJcGv6hc5XeC5JttfKWoIFCRRdqKoAyckcsGAWkg5T2RFuzZrZjpkn0d2
 NWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273662; x=1781878462;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkPseOosZoEncJN/TIh0OXn/Tyi8CmxsUd64wNlsFYk=;
 b=Cr0RK0YvSupeE9qTMUXu2kpY/kBKuWxaROGGhTFcalTdvnrLzSfHVRQSTP0/bBWl11
 jdsIPijDmGXHundb8soDoKIkjPB29hmFMCB+MDdUqL2QehHi7CTcnMFo8Wa0mUteslca
 Vb42cHFZJVJjW1CMHBVUcMCxkqoEQfYNflngjPwBF7PcX0M5N6M5hASHvKConAiAVgq9
 LL4xx1/fzM3E4X3kIX4QtivewIK2o+gHSdrljBPnb9fF+yxugtZGek5IEfTF5r4Dpp6a
 fmgIPsOnQegffJF9m0+j5KJuepIDjmXtkaW5dYpq6rdGzJnzeVsc/EaiXBqlS4uXM/Pt
 J9OA==
X-Forwarded-Encrypted: i=1;
 AFNElJ94IqsIpol9V9/BtP8lEvYmxw1q2mJWMRZSwntfz9VFWtAyCTmYNLkodVen57PONOgqtiVOqcBPq1xn@nongnu.org
X-Gm-Message-State: AOJu0Yy5ZZKcsWl3Jd7DjSLxqIPZvAZRMeWMzzLkAeDFAiy28v17FCvJ
 Qa47O6YsER9Owz0QiSm+MrqhNDb5zSrivrOvu2B8+TeJw7HRtZcHh6j9yDKNoc/vgfyg0kemm5Z
 gzdHWgYn/WbmgT8FFVgjFnjWApNspg/yoLfjYiteDHFsHiB0ItKwFlH5w
X-Gm-Gg: Acq92OFSL7Znh3G1amG5PbgDEukZRxTzaH6Il5/KmrSFHueDHQxY+QdF0r8AfjCb971
 Y/Apo0/TRTORC2iwkZiYgsddimtMCVKPC4pE45mwBV8AYZWtp0kBrZ2N6+cY/gumDjNI/GYF9Aj
 6AdnU8EEUuQRdEU488t2zCL2J0PngyCFYCi9Hn/18X41nRzZ+7gYaGArfM0lQmcvDMKTYEONs85
 RcJPIeVgrC+azJdTC/pVNrTfHyuXl+2p/lizRr54QZDroUZj+A7BEMyXbflWEW/Oas80YplEc4g
 DcwGPoEDJrjuVmB1UCiRswl7xA4IAReLQdxC+acgI0hM5IMfaX8wglM9J+4jFtSgVCkkot5Jh44
 Etjhjb5tf9GFryEAZXFnkI54iXTLGH6VGtEC7IE1YfXyGBduaXIMrM+BA9Rje
X-Received: by 2002:a05:600d:8494:10b0:490:c7dd:de3e with SMTP id
 5b1f17b1804b1-490ec521187mr29722005e9.31.1781273661990; 
 Fri, 12 Jun 2026 07:14:21 -0700 (PDT)
X-Received: by 2002:a05:600d:8494:10b0:490:c7dd:de3e with SMTP id
 5b1f17b1804b1-490ec521187mr29721355e9.31.1781273661435; 
 Fri, 12 Jun 2026 07:14:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea843d63sm71394205e9.12.2026.06.12.07.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 07:14:20 -0700 (PDT)
Message-ID: <6b6f9a77-e4ae-4eb2-bf8d-9c3d441975cb@redhat.com>
Date: Fri, 12 Jun 2026 16:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core/machine: Add new compat for vfio-pci ats
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-4-nathanc@nvidia.com>
 <71f8a1d2-e123-4815-a4da-dbb249b8cfba@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <71f8a1d2-e123-4815-a4da-dbb249b8cfba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/12/26 15:56, Philippe Mathieu-Daudé wrote:
> Hi Nathan,
> 
> On 12/6/26 03:43, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Introduce a new compat for the changed default for vfio-pci device ATS
>> property, from "on" to "auto".
>>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/core/machine.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 4d8b15d99e..c0cdf7c9da 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>>       { "tpm-crb", "cap-chunk", "off" },
>>       { "tpm-crb", "x-allow-chunk-migration", "off" },
>> +    { "vfio-pci", "ats", "on" },
>>   };
>>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> 
> Shouldn't this be squashed with previous patch to keep bisectability?


Indeed. Patch 3 restores the old "always expose ATS" semantics for
<machine>-11.0 and older. With patch 2, ATS could be exposed OFF.
My bad.

Thanks,

C.


