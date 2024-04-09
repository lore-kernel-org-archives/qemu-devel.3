Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818DCC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru6Ci-00072W-MK; Tue, 09 Apr 2024 03:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ru6Ce-00071w-HD
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ru6Cc-0004RG-0U
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712648852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2vOMs/DIcveirHQQdM7XrMgLSklaYSgQkSBVonMYZA=;
 b=IMOn/8LVldC0ErVF9gaeRPaofG6Go8AYf7zzZqJQN4caz7jKVphmCOKBaRak3oo6q2wF+3
 IrCKetNvAZPGvl3tsdWesRi3U3pmmA2EmAOWGG7AEQGOm7fftPY6cRU1PIrsyatDL5JMBl
 F5E6WoekzYK6bcc3dRApnRFDU1onIsY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-d9K4aU3NOYWgY9Jd3u38TQ-1; Tue, 09 Apr 2024 03:47:31 -0400
X-MC-Unique: d9K4aU3NOYWgY9Jd3u38TQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a303938023so1400925a91.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712648850; x=1713253650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P2vOMs/DIcveirHQQdM7XrMgLSklaYSgQkSBVonMYZA=;
 b=uinMNeeNDBulhfe/FzGNxPb0iBkobTdRoGWW5K4VOKGwvTyfEkUs/zGKUIaJtNPu10
 rrVaWR0JwWCWa8JHGZ+DUELAZtn4YHq5ekUTlYs1ThMbKJtIeYnb5HE/AgSo9w7V392m
 1QZrbT7yezmUxYi1pMLgq6oHqLS7QZJt+CNCXVEqFKNrN6Y/QF+w4cho7zBvjeU/x67X
 Wncv53PJgknWj8bg6E8HzC6p64AJdXb7cXEh+T5IXRDpU5IfAJH9729XqFqWFXu9zEzD
 uzLnAFdl+auftR/kqL+zPe2pIonqLubWya9u9n7xl8JSiypkTZTZVI51KEk7UBXxQA/k
 exaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVTnp3j1ziQDgvv8ufQ2Yta5qYBV2/XHJQjhdlMdBogw61mHCe79GwzqbJZFyCY6vsayyhfoONA4Kdsp7MR4e/AQ71LFI=
X-Gm-Message-State: AOJu0YzkabyCZRTJcqTG953kipZer41SRMRvsP1Z4tPN8ALEwcCQ5wC3
 Ppg3EB1irflCFkrnInBdaTUXK00X8hJ0N9fA4T2riVcD4NVeFDjuW+uDqHPN1F0EX0XxJLfoEDp
 cTtzT1Rf2gjvKxp7TLwEocEMSHincsyq/T1yFsibAAvihcETY5q4H
X-Received: by 2002:a17:90b:4b08:b0:2a5:223c:2975 with SMTP id
 lx8-20020a17090b4b0800b002a5223c2975mr4212091pjb.3.1712648850038; 
 Tue, 09 Apr 2024 00:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7574SO9/7DyXNoUy3VNVQ5xzwm72Y2uh/pXo2iu7a0i1E2f+PwGW8tQKIF5+NHIQSryvhZQ==
X-Received: by 2002:a17:90b:4b08:b0:2a5:223c:2975 with SMTP id
 lx8-20020a17090b4b0800b002a5223c2975mr4212074pjb.3.1712648849634; 
 Tue, 09 Apr 2024 00:47:29 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 fs22-20020a17090af29600b0029ddac03effsm9393320pjb.11.2024.04.09.00.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 00:47:29 -0700 (PDT)
Message-ID: <47e0c03b-0a6f-4a58-8dd7-6f1b85bcf71c@redhat.com>
Date: Tue, 9 Apr 2024 15:47:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240409024940.180107-1-shahuang@redhat.com>
 <d1a76e23-e361-46a9-9baf-6ab51db5d7ba@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <d1a76e23-e361-46a9-9baf-6ab51db5d7ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Thmoas,

On 4/9/24 13:33, Thomas Huth wrote:
>> +        assert_has_feature(qts, "host", "kvm-pmu-filter");
> 
> So you assert here that the feature is available ...
> 
>>           assert_has_feature(qts, "host", "kvm-steal-time");
>>           assert_has_feature(qts, "host", "sve");
>>           resp = do_query_no_props(qts, "host");
>> +        kvm_supports_pmu_filter = resp_get_feature_str(resp, 
>> "kvm-pmu-filter");
>>           kvm_supports_steal_time = resp_get_feature(resp, 
>> "kvm-steal-time");
>>           kvm_supports_sve = resp_get_feature(resp, "sve");
>>           vls = resp_get_sve_vls(resp);
>>           qobject_unref(resp);
>> +        if (kvm_supports_pmu_filter) { >
> ... why do you then need to check for its availability here again?
> I either don't understand this part of the code, or you could drop the 
> kvm_supports_pmu_filter variable and simply always execute the code below.

Thanks for your reviewing. I did so because all other feature like 
"kvm-steal-time" check its availability again. I don't know the original 
reason why they did that. I just followed it.

Do you think we should delete all the checking?

Thanks,
Shaoqin

> 
>   Thomas
> 

-- 
Shaoqin


