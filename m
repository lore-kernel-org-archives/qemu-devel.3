Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FB0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 07:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxj1K-0004lv-Vx; Fri, 19 Apr 2024 03:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxj1J-0004kU-3T
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 03:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxj1H-0004pe-Hp
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 03:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713513050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+AG62GcDBEyEdQ1lxMLNJSZF14z+oN69VJUqqygMQ8Q=;
 b=fpWG5JyM8QAyo1VIcSDRWg1p8oZzfi+TA93qm/upwEQtGwDaVJT4MiU79gPNMvGwF2I39A
 S0oH5OXRAGWFiwvqA7BbKMN6RiQS/F05vYxpsLoQ/ljoqCJhkxCZ50lDqL5DqPzRRrE4YF
 fCA6tHuXGhuFQEjiW/2GkV03HhOYTBs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-7JS51YwUNIiq7DfFtkP7og-1; Fri, 19 Apr 2024 03:50:49 -0400
X-MC-Unique: 7JS51YwUNIiq7DfFtkP7og-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56fe8be5474so876206a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 00:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713513048; x=1714117848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+AG62GcDBEyEdQ1lxMLNJSZF14z+oN69VJUqqygMQ8Q=;
 b=muYD9aA0SFWwfqM8fNPQ34CnlWpKrpXVeDMo46RNiqk1s8Y7zovFZXNSDga/bd5C6s
 Zttmnz5c4ml2nQPs4/BezjN93z1Ke/pIgYhijMJi7nk3t0rKRqNqa+hVgIslXFFVnueZ
 JUMUbOp7QBJEzbvCEIQYldNfvT7LDzl7rOJgHwB5MGop7hZfRtK2rDTnPJSK+/QnhDzQ
 z2m80nfQG2pjBfqFJDWsjdtQ6Q43vOXpSD4MlnFlfgiTID0Y395fqgB2bBI/HA2caWGa
 ybr7V0zqY7NvSFQal/x2n6Z0U1pLO0kInaIBGqu/jiaDoWK2co3GXS5QedEDMGoWFTN9
 7NfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdlun23CTTrFY9lXPJYHY0b0xkroVjyriYLNmhjOSQazebc3iD7xVCH1+pcr3nlNg4m7Ja4XpabQkOgCsRC0KGaZ+/KaI=
X-Gm-Message-State: AOJu0Yzy8vwUQTl99m3JRP7YLelmkk/fm9IhbDLTEscqzkO9EeSiKj/4
 HbBznKRicxgSLL3ij3FJ6SBIdPV3bUMRoenvYAjg48nounblwhcLV6ugyDm54SvCRfhh7jrBRoA
 4bRjFRq+CU28cyEH9dI146AS7dZ1NKguZ6rJ63XdYZ1uH7Z2hkSga
X-Received: by 2002:a50:ccd7:0:b0:56e:edc:9837 with SMTP id
 b23-20020a50ccd7000000b0056e0edc9837mr1378590edj.35.1713513048008; 
 Fri, 19 Apr 2024 00:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF7l5o5a8kyVE3l3KiJZyoi6UnrS7dyhETEH6ngwDRpJTJETdY5Ip5xounljYenaUnd5B5rw==
X-Received: by 2002:a50:ccd7:0:b0:56e:edc:9837 with SMTP id
 b23-20020a50ccd7000000b0056e0edc9837mr1378582edj.35.1713513047710; 
 Fri, 19 Apr 2024 00:50:47 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-117.web.vodafone.de.
 [109.43.177.117]) by smtp.gmail.com with ESMTPSA id
 k4-20020a50cb84000000b005705bb48307sm1804300edi.42.2024.04.19.00.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 00:50:47 -0700 (PDT)
Message-ID: <0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com>
Date: Fri, 19 Apr 2024 09:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
To: Zhao Liu <zhao1.liu@linux.intel.com>, David Hildenbrand
 <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On 19/04/2024 08.57, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As error.h suggested, the best practice for callee is to return
> something to indicate success / failure.
> 
> So make kvm_s390_get_host_cpu_model() return boolean and check the
> returned boolean in get_max_cpu_model() instead of accessing @err.
> 
> Additionally, since now get_max_cpu_model() returns directly if
> kvm_s390_get_host_cpu_model() fills @err, so make
> kvm_s390_get_host_cpu_model() return true by default for the non-KVM
> case in target/s390x/cpu_models.h.

You could also argue the other way round that there should be something in 
*model if it returns "true" ... anyway, the stub should never be executed, 
so it likely doesn't matter too much, but I'd still prefer if we'd rather 
return "false" in the non-KVM stub instead.

> index d7b89129891a..5041c1e10fed 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -116,12 +116,13 @@ S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>   
>   #ifdef CONFIG_KVM
>   bool kvm_s390_cpu_models_supported(void);
> -void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
> +bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
>   void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
>   #else
> -static inline void kvm_s390_get_host_cpu_model(S390CPUModel *model,
> +static inline bool kvm_s390_get_host_cpu_model(S390CPUModel *model,
>                                                  Error **errp)
>   {
> +    return true;
>   }

  Thomas



