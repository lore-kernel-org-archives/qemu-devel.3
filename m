Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BECC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 06:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvrK-0004R6-2M; Tue, 12 Mar 2024 02:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjvr0-0004Ol-Ad
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjvqy-0000Qm-HF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710225791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s1ygLUTnF0HACGwDA9NCcM42ITrOA63ubjnOqhRlZdM=;
 b=QggV/g9MW3Q8SEbIs8ptzf0qtikFdZXn4Usm5d51NndBGtB24BEzkUvOZyRuNLFnhN6Tp+
 V8hSBcm0LsqzJT7QmOQwpXC5zT0rnpeDcUPFUy1LH0QvyWxSYZBNCAFca2+F223djxEPZz
 pwBpNEeSPcAZ9M/tQiswLHr7vGsSY6s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-7a-tas7SN4KQqF_LPcm8NQ-1; Tue, 12 Mar 2024 02:43:10 -0400
X-MC-Unique: 7a-tas7SN4KQqF_LPcm8NQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7886591cd10so360475185a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 23:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710225789; x=1710830589;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1ygLUTnF0HACGwDA9NCcM42ITrOA63ubjnOqhRlZdM=;
 b=Auy3dvy+kSsqNX6eUa96p/DoMkvzoE2oLpg8q+xVmHLrfsxiBcmrXROBSaetQnwgOo
 shsT1QUvrKOkWfEBiSjpCsNYZT311u3L1Hj/vjd1xV1mIiNVTg57ImtqZf5PBL6WXZdT
 HytkPE4q5YwhrHU6+6VKIj2Y9qBXfO69BE5s/Jk1zwstXj4OWLKPBnESk/tQrhBYJfg/
 6Kq4MgcGDR9JR6TSoskAxYjROBDNTggJJM3Dnfe0vY9crEOblfLmWish3HdtjZc80+1F
 vhh7wirYYt9qc6Ul5w9npSnvFrHDTBtHYV4bWDc+EsKuRdF70QXQmn3EGpGrE2tVJs0+
 8ejQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg73gY7rF9Vw/GfjervYjmx/6Me2CrKrrahTYBLziH91ba/L6VFsh7xOx/IcLlLIXIX6X65WfbEOy+/DG1oraJFoISzEA=
X-Gm-Message-State: AOJu0YwT65o/XuWZ0KIPyYCO19qL94K4c2hZRnOeYLbeIa0e4KGSVYQt
 8yjASzJ3eCZllB69BmGcCbGvcGJh+d2qxQSp9CVhdS1YVh+mEivXBgOBi4B5kDl2w1YDO9rsm7U
 ygqyI9yck/G0KL7E4j4Jy5aOZmwsD0FOLmsUkWu+azJvKDNAwFs4u
X-Received: by 2002:a05:620a:8388:b0:788:49f3:ab57 with SMTP id
 pb8-20020a05620a838800b0078849f3ab57mr15164749qkn.34.1710225789726; 
 Mon, 11 Mar 2024 23:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ5DbqvqN/RRR8gh5cD9cHlj4eIEDUbo+BKxGMavHFnDguv7wS61Fq2LA0V39tPbpmpG1mCg==
X-Received: by 2002:a05:620a:8388:b0:788:49f3:ab57 with SMTP id
 pb8-20020a05620a838800b0078849f3ab57mr15164737qkn.34.1710225789472; 
 Mon, 11 Mar 2024 23:43:09 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 q5-20020ac87345000000b0042f3e7c13a4sm2621823qtp.66.2024.03.11.23.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 23:43:09 -0700 (PDT)
Message-ID: <f044de44-2ea8-4f67-bf93-22dee805c387@redhat.com>
Date: Tue, 12 Mar 2024 07:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
 <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
 <ZeuxcZmE9Ejr6acx@intel.com>
 <94997958-3cc3-4e4b-bc92-2eb7e501539e@linaro.org>
 <Ze/6R0kT++CKfaGP@intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Ze/6R0kT++CKfaGP@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/03/2024 07.46, Zhao Liu wrote:
> Hi Philippe,
> 
> On Sat, Mar 09, 2024 at 02:49:17PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Sat, 9 Mar 2024 14:49:17 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
>>
>> On 9/3/24 01:46, Zhao Liu wrote:
>>> Hi Philippe,
>>>
>>>>
>>>> Can you share your base commit please?
>>>>
>>>> Applying: hw/core/machine-smp: Remove deprecated "parameter=0" SMP
>>>> configurations
>>>> Applying: hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
>>>> configurations
>>>> error: patch failed: docs/about/deprecated.rst:47
>>>> error: docs/about/deprecated.rst: patch does not apply
>>>> Patch failed at 0002 hw/core/machine-smp: Deprecate unsupported
>>>> "parameter=1" SMP configurations
>>>>
>>>
>>> The base commit is e1007b6bab5cf ("Merge tag 'pull-request-2024-03-01'
>>> of https://gitlab.com/thuth/qemu into staging").
>>>
>>> But I think this conflict is because of the first 4 patches of mudule
>>> series you picked. Let me rebase this series on that module series and
>>> refresh a v3.
>>
>> Ah no, it is due to commit 01e449809b ("*-user: Deprecate and
>> disable -p pagesize").
>>
>> No need to respin this series, I queued it in favor of the 4 other
>> patches.
> 
> In the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate unsupported
> 'parameter=1' SMP configurations"), the smp related thing is put under
> the section "User-mode emulator command line arguments" instead of "System
> emulator command line arguments".
> 
> Is this not quite right...or does it need to be fixed? If so I can tweak
> and clean it up with a minor patch. ;-)

Yes, please send a patch to clean it up!

  Thanks
   Thomas



