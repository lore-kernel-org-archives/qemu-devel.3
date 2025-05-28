Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0280C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKCBT-0000cl-La; Wed, 28 May 2025 04:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKCBM-0000Z6-UI
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKCBI-0007w3-ID
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748421035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u+2mh2ViOZivHtbPKyiLhNGoIQl8Z/GvWHszLzwiyCg=;
 b=bOHdQzZTs/3oiyeHAabHTqB7uuzNXr/Oj5lmks4lhvAFgDxS4scuHVP9hDpOtPePnzW4nD
 ScBWE+hAdtUocTWiC5j8fL8UTZI60LyawXaROY4FoXm9FQwi7LRMF721OYjdTPwcRfhwES
 Emrjf3ONTviHd1tDstqQ8UpHaA3tIe4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-xiLaUAtUPauqqZ1-9ghzjA-1; Wed, 28 May 2025 04:30:29 -0400
X-MC-Unique: xiLaUAtUPauqqZ1-9ghzjA-1
X-Mimecast-MFC-AGG-ID: xiLaUAtUPauqqZ1-9ghzjA_1748421021
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3683aa00eso316110f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421020; x=1749025820;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+2mh2ViOZivHtbPKyiLhNGoIQl8Z/GvWHszLzwiyCg=;
 b=vX4mB8BqrkTuLS08GTVIFaz4Z4/h1CjKYVLJGJbQ9bNh9xibllnhTX3jALkbDmDzhI
 LRcasyQaAqVnvWMIxvGKfDtyCOIXV1cffheUqhaS27Ckgogy3q2gw7/xOVxrj/YLTnZt
 9aGHH/NeJQilVYn9lzJ5K2mrDe7v3WWhSPXGMzRpyFS3HiidASR/pk4I3df88ufqlOQV
 SobazaFGpsFA8Y0xLT13kxVBkn2k8KZqpo8sWKINUfaDXqApVev9nUC7EJIa5/Rg+SZ9
 SAV96aLHgGMKGUugXpOsZpdm6yay8gTKDvqhpJUYOUj6IAlb0MzqyhOuX/AKrVDt+a94
 k8GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFkY8qX2SLlj9sig39q4y+PxuU/DOLtbfJ3/HDMqo6oO1xaiNKB1Qt1KpfMjf+zR/UmIQl+jBb6C+3@nongnu.org
X-Gm-Message-State: AOJu0YyLJoBWkVG/60KhhJClk4uBPqxmrh4L5AS4UtHsLKTzE2uCZfp8
 2qA12TGzOYDRtpAGmlDEgh45iboa+DmX6ZKgKvDeD8ehat4YICLvhKZhalbOr8+NgbCwndcVxHY
 61KE1rRi7PGRi8ReV3KInULS9my+2GwRj6UBFg8oFC/iZRynViDcZznWs
X-Gm-Gg: ASbGncukGeYig3gehS8TuaIrqHRhjkT0wX8pbQ1iKZiwDm6Uh2RV1poP8M0QAh/shKs
 +Es5V3BjhkCdAEGo0yCDddTCzD4F2nI0G7q3VfQ/qaRqTk70MWbrZcJi/rJ1HOW74g+ham/b5Jd
 kP2vOb2Lo79tIPgMYoAdZVp96o9a2zZjwutKUYiCJ+QZ5fYbP0m/VzNDxwhmEMGoZdJM4cM3Et9
 U0s8zV6mj0egW1u8yRUpXYMWWwS+X08FDEC0OJoBWwyCRfL18fbAMJQaL21+BXhZAssutEoh9C2
 SupQqCQO0mV+DsN2t4SywyC0vTLtD164N/Y/RDgUzkoWcZ7vutOw
X-Received: by 2002:a05:6000:2284:b0:3a3:6434:5d34 with SMTP id
 ffacd0b85a97d-3a4e5ea80e4mr3286050f8f.17.1748421020666; 
 Wed, 28 May 2025 01:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMeVosLDNxP6NDr03YfFU/cmpPmHoa+dZgOrP0NJ1Bo0oTvgPUEVHtbA9rYlt06gravs57ng==
X-Received: by 2002:a05:6000:2284:b0:3a3:6434:5d34 with SMTP id
 ffacd0b85a97d-3a4e5ea80e4mr3286009f8f.17.1748421020160; 
 Wed, 28 May 2025 01:30:20 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac7e08esm817297f8f.22.2025.05.28.01.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 01:30:19 -0700 (PDT)
Message-ID: <bfc0d4e7-d062-4526-8969-9fc0a7a3d179@redhat.com>
Date: Wed, 28 May 2025 10:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] hw/block/fdc-isa: Remove 'fallback' property
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-14-philmd@linaro.org>
 <6484086d-22a7-4cb6-9140-bb5251c5cf93@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6484086d-22a7-4cb6-9140-bb5251c5cf93@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/05/2025 19.20, Thomas Huth wrote:
> On 12/05/2025 10.39, Philippe Mathieu-Daudé wrote:
>> The "fallback" property was only used by the hw_compat_2_5[] array,
>> as 'fallback=144'. We removed all machines using that array, lets
>> remove ISA floppy drive 'fallback' property, manually setting the
>> default value in isabus_fdc_realize().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/block/fdc-isa.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> FWIW, this needs a fixup for iotest 172:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/10166450223#L466

FYI, since I was testing this series anyway, I'll fix up this patch with:

diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -14,7 +14,6 @@ Testing:
              dma = 2 (0x2)
              fdtypeA = "auto"
              fdtypeB = "auto"
-            fallback = "288"
              bus: floppy-bus.0
                type floppy-bus
                dev: floppy, id ""
@@ -43,7 +42,6 @@ Testing: -fda TEST_DIR/t.qcow2
              dma = 2 (0x2)
              fdtypeA = "auto"
              fdtypeB = "auto"
-            fallback = "288"
              bus: floppy-bus.0
                type floppy-bus
                dev: floppy, id ""
@@ -79,7 +77,6 @@ Testing: -fdb TEST_DIR/t.qcow2
              dma = 2 (0x2)
              fdtypeA = "auto"
              fdtypeB = "auto"
-            fallback = "288"
              bus: floppy-bus.0
                type floppy-bus
                dev: floppy, id ""

etc.

and I will queue this series (without the "Remove X86CPU::check_cpuid field" 
patch as mentioned by Xiaoyao Li), unless Paolo or another x86 maintainer 
wants to do this instead (please let me know!).

  Thomas


