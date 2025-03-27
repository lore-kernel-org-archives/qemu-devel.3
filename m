Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4459AC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiDb-00074A-RB; Thu, 27 Mar 2025 04:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txiDY-00071O-8i
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txiDV-0005Pb-Uy
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062636;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqiZ8b0K7F3/LhHoQ8DE2457h5HuEEasSkiMMWavqyk=;
 b=e+nkKZ0svL43TK/2EjhkKLHMsI+g9OFF93jsgpiu8Eh1qcNpzkAu7nYpkdOD52ATLLqwco
 4MKOrCyeGoyqjLjgHKpZ/WxhlvUpKYpQjBrvbbyBeJl9TjtfKpLVCpqKILey1bfHvGy3Cc
 sHWZl5h8ZfWjtC4LmBgpKaxroVLT224=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-QAWpRr_7PtmRi_-UGguuQQ-1; Thu, 27 Mar 2025 04:03:24 -0400
X-MC-Unique: QAWpRr_7PtmRi_-UGguuQQ-1
X-Mimecast-MFC-AGG-ID: QAWpRr_7PtmRi_-UGguuQQ_1743062603
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43935e09897so3908445e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 01:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743062603; x=1743667403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KqiZ8b0K7F3/LhHoQ8DE2457h5HuEEasSkiMMWavqyk=;
 b=ATyPXN3s5XA06vAbT1XKD+PROupwx5VX0AGz9tJAOIJyl7Ri7DXCmjwuDNwux9MkuG
 fCufxZkYOTAHWdoLlzq+DxKjPECRSa4Cq4SAxrm+5aRFuXWK9BGn9LuJXr/DTmhEiGp0
 N70k8a2SuNn85N4vqUqeJw0X715ZO2RkypdMXsHuTVOt24FPFsx2B5B5gGZpCYCMlloG
 LABfmlojvjsDooh7sEya91DjsL+wHPdXqjd2FWDOOsbxNnmxBGIJFYBWjGBHtV/zj5Gc
 I+wboCom09orwsgvbbHgsnTSB3ZQdX1S60+b7c9t6+RWI5SpVNw41k2PUEX4gKAJBbdG
 TLFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy7bRNHUJE6fX7tnYXwazGqtq0Y6+9gWmrsFVTa0TRiDelY7vDAkAa40NEnZCUJrx2Z5i/ZI0Oj+xW@nongnu.org
X-Gm-Message-State: AOJu0YzXwGM8j+7eKuBcly4e4odYIifPdUHdR0M6RWTX8CBZmADljIp/
 zv9qLyyh7FEhW/iB5zdmckc3MNZrjLVtYRwb6YkSV1PW4RBdUJz2tfb4b3Iw4s2yje6Q5O4LjZ5
 gQkUlAGb3xMyKfJJU7CC3ks+Vb+rb8CsAkm7fxguyxBrnyzKhNs6x
X-Gm-Gg: ASbGnctxro+A+gF8H6aEdqg2MkmfQW28ywPC+3h+zA7c834M5g2a+W14nMa6p84gKry
 BTOc2yjJJKP4LHqEE4MgBim0JxIJOSeeo+y/JHRw6Xa7S9RpUf9y9FPFl39NdKBWdM/bPva6iSg
 ojYAOOgLjx/zY5azAPfZlIetRpUzBLP4HWF/niqDaD0+iPXxD6Qf68HWN3olZvImk0pdi7w7n+x
 OwipH9QUEMn5HOG1w2xXgjJTwmbLI+kSK6nkcGBIRz3H00P2W7dP1J5DcxQ1x+3Qrq3rR8t3eb4
 /YkJH2y1dxqx3sgGW6Qs84471QCmpNQkvpytiF2Ki/wKGegkpoMWEIZNmNfdAFg=
X-Received: by 2002:a05:6000:4211:b0:391:12a5:3cb3 with SMTP id
 ffacd0b85a97d-39ad173d283mr2019561f8f.3.1743062603484; 
 Thu, 27 Mar 2025 01:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWPSfV/cpz6/HaxFI/9RXxa4cZvxRGF3r6ND+r/lOM0crXYJfkj4n3q7x42cBkf2BGTu3xGw==
X-Received: by 2002:a05:6000:4211:b0:391:12a5:3cb3 with SMTP id
 ffacd0b85a97d-39ad173d283mr2019508f8f.3.1743062603045; 
 Thu, 27 Mar 2025 01:03:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e64casm19147079f8f.73.2025.03.27.01.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 01:03:22 -0700 (PDT)
Message-ID: <8ccf83fd-0d32-4491-a812-f1d29d44f08c@redhat.com>
Date: Thu, 27 Mar 2025 09:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/20] hw/arm/smmuv3: Forward invalidation commands
 to hw
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-16-shameerali.kolothum.thodi@huawei.com>
 <af531bef-4597-4729-bdcc-f6b7e3647266@redhat.com>
 <Z+RVM8Cr+EcnhDaJ@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z+RVM8Cr+EcnhDaJ@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/26/25 8:27 PM, Nicolin Chen wrote:
> On Wed, Mar 26, 2025 at 03:16:18PM +0100, Eric Auger wrote:
>>> @@ -1395,6 +1403,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>>  
>>>              trace_smmuv3_cmdq_cfgi_cd(sid);
>>>              smmuv3_flush_config(sdev);
>>> +
>>> +            if (smmuv3_accel_batch_cmds(sdev->smmu, sdev, &batch, &cmd,
>>> +                                        &q->cons, true)) {
>>> +                cmd_error = SMMU_CERROR_ILL;
>> I understand you collect all batchable commands all together (those
>> sharing the same dev_cache prop) and the batch is executed either when
>> the cache target changes or at the very end of the queue consumption.
>> Since you don't batch all kinds of commands don't you have a risk to
>> send commands out of order?
> Yes, that could happen. But would it have some real risk?

OK. I don't know but this needs to be studied.

Eric
>
> This practice has an assumption that the guest OS would group
> each batch with a proper CMD_SYNC like Linux does. So it could
> reduce the amount of ioctls. If we can think of some real risk
> when the guest OS doesn't, yes, I think we would have to flush
> the batch if any non-accel command appear in-between.
>
> Thanks
> Nicolin
>


