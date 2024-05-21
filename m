Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22988C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 05:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Hri-00060H-38; Tue, 21 May 2024 01:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9HrM-0005wI-Sv
 for qemu-devel@nongnu.org; Tue, 21 May 2024 01:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9HrL-0005Qz-7N
 for qemu-devel@nongnu.org; Tue, 21 May 2024 01:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716268580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6rLL0yYfxe8Lth/pZimRI+J6NNQU8Oz2cXeSJYlm1I=;
 b=LplSjHI0AEr50Se95Lwcc2p/vxWKkzlK1Z6oewwgmb6HxzpAWxQX54gG7jBD9AJ9AU6n7q
 OqqnptWxBACGc1RX3BqrIFxcocNhdg3BLEiG95qWfXcCmAfNwvQCfkbys21Z1quGs60lvk
 VNz8zzgIZBex04xghQ5F9WYTD9TLdEk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-lcp-Bh7tNYiXauU110pf5A-1; Tue, 21 May 2024 01:16:17 -0400
X-MC-Unique: lcp-Bh7tNYiXauU110pf5A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a9a8590196so28314986d6.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 22:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716268576; x=1716873376;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6rLL0yYfxe8Lth/pZimRI+J6NNQU8Oz2cXeSJYlm1I=;
 b=elkFi7bP1pPsX9fC6crEhhsW/Te4/i/Vr9TY6S6c5/3+GG1Va8gpYJj1WbODRxisMM
 a9cnZgab4F1JyM3QQGRofFn7RqL6CHBMnhWAVig60yRDGAJbxi0FwQ82ImlLpFUXUWv4
 8jA1GxvbOOirs17zRx2+jIDjieTrmBacY+1/+DWfUz86KbLIEVNe3qsEWbFHX8fZswIH
 C0cUoPt4f7EDDCaJ98omnwush4e2Go2RgYlBugy283pZm4xa6uH0OZ4ge6BdFz+b27e/
 3/WqRKTgY1zjtu3bI5iMspvDj8D93+O3w2ybTior3LjytWgtIexgtMPIGxEcRXL3Hgbh
 hsPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdaxagV0FadfwxhY5n0jjFgrMI0UtVtIg+dSZxe11IJlFIw4wz35ka08RfglzWCRPlz82AZAYQ+s63C1vpVrlfSMkwCSQ=
X-Gm-Message-State: AOJu0YzwYK95gz6lpg2YW6fK3lB7cpTrpD1QoVGscgzuqu9QkB7byirj
 kH0JX13JK4SiSP780wTWcanU2BaCAGK7n+vfmvuOfJ9COjZJzguAWo8d4BsIyaTPtgEe3T7YHfZ
 hd8s3X4zKONFvJ4zb7OaaKI9iTZFO+oEE7HFioWNP2gM+2+Qifi4H
X-Received: by 2002:a05:6214:5e8a:b0:6a0:7de0:a28c with SMTP id
 6a1803df08f44-6a168259719mr261681576d6.65.1716268576578; 
 Mon, 20 May 2024 22:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo1s64d2U5i2GY2FDRNZbPm+KzaO6cUPAvYcUSeAxciUA4bG+ryN4QXeUXMk/tslH6lwWTYw==
X-Received: by 2002:a05:6214:5e8a:b0:6a0:7de0:a28c with SMTP id
 6a1803df08f44-6a168259719mr261681466d6.65.1716268576141; 
 Mon, 20 May 2024 22:16:16 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd271sm118812106d6.101.2024.05.20.22.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 22:16:15 -0700 (PDT)
Message-ID: <342858a6-c8bd-45fe-8b91-8e0a444eb2e6@redhat.com>
Date: Tue, 21 May 2024 07:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vl: Allow multiple -overcommit commands
From: Thomas Huth <thuth@redhat.com>
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240520174733.32979-1-zide.chen@intel.com>
 <20240520174733.32979-2-zide.chen@intel.com>
 <7b6bb859-acbe-4fb0-a8d5-c1698f597ef7@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7b6bb859-acbe-4fb0-a8d5-c1698f597ef7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/05/2024 07.08, Thomas Huth wrote:
> On 20/05/2024 19.47, Zide Chen wrote:
>> Both cpu-pm and mem-lock are related to system resource overcommit, but
>> they are separate from each other, in terms of how they are realized,
>> and of course, they are applied to different system resources.
>>
>> It's tempting to use separate command lines to specify their behavior.
>> e.g., in the following example, the cpu-pm command is quietly
>> overwritten, and it's not easy to notice it without careful inspection.
>>
>>    --overcommit mem-lock=on
>>    --overcommit cpu-pm=on
>>
>> Fixes: c8c9dc42b7ca ("Remove the deprecated -realtime option")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>   system/vl.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index a3eede5fa5b8..ed682643805b 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -3545,8 +3545,12 @@ void qemu_init(int argc, char **argv)
>>                   if (!opts) {
>>                       exit(1);
>>                   }
>> -                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", false);
>> -                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
>> +
>> +                /* Don't override the -overcommit option if set */
>> +                enable_mlock = enable_mlock ||
>> +                    qemu_opt_get_bool(opts, "mem-lock", false);
>> +                enable_cpu_pm = enable_cpu_pm ||
>> +                    qemu_opt_get_bool(opts, "cpu-pm", false);
>>                   break;
>>               case QEMU_OPTION_compat:
>>                   {
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Ah, wait, actually, this is a bad idea, too, since now you cannot disable an 
enabled option anymore. Imagine that you have for example enabled the option 
in the config file, and now you'd like to disable it on the command line 
again - you're stuck with the enabled setting in that case.

I think the better solution is to replace the "false" default value at the end:

         enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
         enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);

What do you think about this?

  Thomas


