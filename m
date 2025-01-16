Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC12C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTU2-0002lY-Ds; Thu, 16 Jan 2025 12:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tYTTz-0002l1-Kz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tYTTy-0000KO-5q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737047797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jLf0a+uWrlY3CBhS4twrHFpg6r7keS/CHGqK/Nszags=;
 b=ExA7pnVFbRWXAgm3hkR3nElNy3TL57vHL2lhXum4otaScZ4IwsHQTTDVMHwk123FPX5ySU
 hPGFitezHi83SKhc7u/oIK4VUNBZp2cHpBsjhKBDPpaXwlwXkkkaFa42ATibgEbJfInDgk
 34e3wduC5ZkFnQJjoVgFBqxfOItvA4w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-4EnX1-O6P6WMkuXvC2N28g-1; Thu, 16 Jan 2025 12:16:34 -0500
X-MC-Unique: 4EnX1-O6P6WMkuXvC2N28g-1
X-Mimecast-MFC-AGG-ID: 4EnX1-O6P6WMkuXvC2N28g
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e00ebb16so502168f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737047792; x=1737652592;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLf0a+uWrlY3CBhS4twrHFpg6r7keS/CHGqK/Nszags=;
 b=iy6j+JeP2VhBp52Q361kSJIb5uwV2MogxW//DmRoWyr9PoNU6Cdm7R3O2CU3AererB
 1q3dVBVlKFmVi20S+So1drFbDFmT6Q9RN028PjQR/u6xuyeU9HWU8c1zzh1JOjK+fgZF
 nMLM/doz2PyuaEtJTS6R+xUMTBC53SNlxeIrY6E2VZ8xqN0E9jJcXqI5I8oHnEJk8fAS
 HgDBWbIT2Tkb4mJe2dBs5kUBnk/DeCLFkXZlpetsf8hV5QtzAzBNCYU2FkCg46PM5zQv
 Grrr17vtL0B8iQLPJCzAZyKMvyUo0T9el2qYZjtHtnUnvP42kVHS3RLW4jB6x4RcANWA
 pMww==
X-Gm-Message-State: AOJu0YzSJyOQ8iwnNladxBX/4905oyipYPySdWLYCEZLTYP+XzN0MsHb
 65zHrIl6JY38c+tnxLGqU7mU2vE8CWW9j0y6kmV+tL2gxZvLFJla2iff9/MefY2bKIgF8Pl9qhK
 7DUz4w7g/YgrIn+UGHO9luOyOtJUHp9dZYGifGkITcT1XoXa7ijHPuD8V1lEIBqBpIm+grh/riz
 ZKIcbZTPjNLLf8Tmt7XT2121X5FMhpZA==
X-Gm-Gg: ASbGncs+NfqhNbot0CVPCET1sBTpaIPWDjFmonNmK4XkvnIhnMhLpmiFwFwOjVftkmw
 2fM9r6FbkzRUmRY0ISIVS+TPP2TFhPBMLjRIHG/znlBEplpNb6xygqa/uuOgGHv89QDPXJql4HG
 s4axiykISsLVJDhKCd1tpmVgGtOh7jXGOMBO2Zm0P3ULFJLgVphWsgjQGiDdDJMSiuduoTN1h+J
 6R93NV3X1Pga2I5Sfyj6chzYNgNmISg5lGaV7lVp+Qc4VZwt7teUEfz2/ceYmDcGEuTbZiQ51Xg
 dt2ISsf3LoUwwTkrfho=
X-Received: by 2002:a5d:64eb:0:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a87310667mr29962623f8f.50.1737047792541; 
 Thu, 16 Jan 2025 09:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVvSQsFHvJi6/U7i+sOm6Adw+Q1syjYITWbJWeKEIWw1/BS6HFEXTe33OQ2AtEW2M8WTQCxQ==
X-Received: by 2002:a5d:64eb:0:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a87310667mr29962593f8f.50.1737047792142; 
 Thu, 16 Jan 2025 09:16:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753ca42sm63997695e9.35.2025.01.16.09.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:16:31 -0800 (PST)
Message-ID: <af0a3f93-18e4-47d6-8b36-d79ea88e1be3@redhat.com>
Date: Thu, 16 Jan 2025 18:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Fix potential overflow in igd_gtt_memory_size()
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250107130604.669697-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250107130604.669697-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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

On 1/7/25 14:06, Cédric Le Goater wrote:
> The risk is mainly theoretical since the applied bit mask will keep
> the 'ggms' shift value below 3. Nevertheless, let's use a 64 bit
> integer type and resolve the coverity issue.
> 
> Resolves: Coverity CID 1585908
> Fixes: 1e1eac5f3dcd ("vfio/igd: canonicalize memory size calculations")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Applied to vfio-next.

Thanks,

C.


> ---
>   hw/vfio/igd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 0740a5dd8cc9346a92c4613194faa8dea42e1d98..b5303ea565d6a344d0a43273f288bbb4a7f48327 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -133,7 +133,7 @@ static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
>       } else {
>           ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
>           if (ggms != 0) {
> -            ggms = 1 << ggms;
> +            ggms = 1ULL << ggms;
>           }
>       }
>   


