Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7619C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk8O-0004vI-RD; Tue, 16 Apr 2024 10:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwk8G-0004tX-71
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:50:00 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwk8C-0003Cz-Oy
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:49:58 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516d3a470d5so5164615e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713278994; x=1713883794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kEi6ruhnU3S3FhwT8XtVe9Nr9s6T4FUQEEvlScExHyc=;
 b=gAxaMqYoGqABfdsXK3EXFz/wHSdQkV/exwXMCCSANwpXxwS5hdtpUv4TVF/zhETji1
 3/mVIyIrVH9eqRLw4xLOE8p2Bw4DQ1Zt8dWWcECviTc50HzK2hzGrCD1h7q6/9i6oVqn
 HcFX3NYXAqc/Uk7mVJilLgC1O8IMdKeWzayeHiDeMYt9CFl0lad+5J5luurOq5Aw4slU
 4nzbn215utCSLzlLctccTom6964/9w/2Bd4ipDFBv1vpWj8MY9+fN5Vo+e80eIC9Z3YT
 qmeVEN79mlC3L7Ua4XY6qDBtNIn4k86iCxrOubV3KVeX5ujApd68yn3nM3IgO9L37D1E
 1czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713278995; x=1713883795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEi6ruhnU3S3FhwT8XtVe9Nr9s6T4FUQEEvlScExHyc=;
 b=nVSqm1U07hJaYE8+JM1FMaJzGKaVJp21EQyCAESFCy4gX0qgrkjkGgSqre5ZQd8rWo
 MjBij3xjX1fANhBSG7Y2iELx/KUuheDJDjcXxGUnvuvPAj90rFdQwI+T42VOVXKPbKfs
 AU/bF0MMUPdZxxk0yM6PIh1Io+nld1plN/QOaIIiik95b5eKJUm/cEWu+6sqEy3xsM/0
 Grlm1sIoDs0FVS8mJc2B0zJr3QU6LRqHmcrOTf8+fTWvH2cEOvKl0TvF0MgS0Qb9oEfW
 1uyjytE4WOzp8nOjbvF1euUi3v4PdwXANgeTb5Ihw5tVsTIVuqBPxHzb3O+c/C60Wlof
 ye5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcoCgQboLH+VpQ1bWg4lm9PNImaALLo8iLJQuZo//9buC5uDATFmnVc5wDMD+80aIg/syMPoRs2rq7ZjrTxfNevboOulg=
X-Gm-Message-State: AOJu0YzKamBW+y+d1sYtc7iqgY4bHhLMiAP+eApqKl4cNW3s4lAbECLj
 lsY0EiTQiLA4CPmzyfp0cCXOIquSfiftkXTY8pZyDeH+6acaKRdAlAEKwrVzYiY=
X-Google-Smtp-Source: AGHT+IEFW0wxbRlpsM9T0SXQI8EERPCH7oVpr4Wl4hCu1JQUItg82RhJ0oWcdVqUe6xN1nqrCyhzDA==
X-Received: by 2002:a05:6512:3094:b0:519:13be:c42b with SMTP id
 z20-20020a056512309400b0051913bec42bmr3013879lfd.61.1713278994641; 
 Tue, 16 Apr 2024 07:49:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 ho41-20020a1709070ea900b00a524318c380sm5036114ejc.80.2024.04.16.07.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 07:49:54 -0700 (PDT)
Message-ID: <68336e9f-7a30-47f7-b4c7-ad8afc2c16f3@linaro.org>
Date: Tue, 16 Apr 2024 16:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/22] hw/i386/pc: Deprecate 2.4 to 2.7 pc-i440fx
 machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240416135252.8384-1-philmd@linaro.org>
 <20240416135252.8384-2-philmd@linaro.org>
 <15834b55-8226-4355-91f2-9d5df4d3bc9b@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <15834b55-8226-4355-91f2-9d5df4d3bc9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/4/24 16:23, Thomas Huth wrote:
> On 16/04/2024 15.52, Philippe Mathieu-Daudé wrote:
>> Similarly to the commit c7437f0ddb "docs/about: Mark the
>> old pc-i440fx-2.0 - 2.3 machine types as deprecated",
>> deprecate the 2.4 to 2.7 machines.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst | 4 ++--
>>   hw/i386/pc_piix.c         | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 7b548519b5..967ee34267 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -219,8 +219,8 @@ deprecated; use the new name ``dtb-randomness`` 
>> instead. The new name
>>   better reflects the way this property affects all random data within
>>   the device tree blob, not just the ``kaslr-seed`` node.
>> -``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
>> -'''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and 
>> ``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> 
> Didn't we want to mark everything up to 2.12 as deprecated?

I took your suggestion:
https://lore.kernel.org/qemu-devel/2a01baa6-b6a3-4572-94cd-63b2eaab7b38@redhat.com/
I am happy to go up to 2.12 :)

> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


