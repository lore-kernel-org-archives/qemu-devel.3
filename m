Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4FD1091917
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 20:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KR6-0005Qc-7V; Thu, 19 Mar 2026 16:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KR3-0005QF-RU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:57:41 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KR2-0005gW-7J
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:57:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b061b6cf36so10217155ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953859; x=1774558659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZbHkxEaq2y/MbVWwd4LBhMOJbILvHqrkcuMKnGBbXs=;
 b=MIdc1fmoHKi+8EL6TseJhe9OiJy+qgp7rCbEdZcpDbXGVldo9iu7u4K2x+XPeMcMLE
 xHj1EBFF30X1+1qVbPVR222q4YvUz7B5Y/5CcfT07c+qXwdDyai4tPSLnFUavOuJw8Em
 QJMN6FWDNoWE36ohs7Eq7fzCoQ4UGDglL9+9tvWS8EFpNoWNyIquWL6V8UAxmJ7O8Ikj
 NKBYoK/syCSNBkKb9qqBn+bs+MM8j3JKhzS3CFQUGsZSdCUGG0DXcL6y6/kvpy4IlBNX
 VwVBsIHDFSLW5tdklXnwhc6XrF2jOf4KItAHyIgc2smuqz1Nse/yL3JibfFD49X9824M
 VBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953859; x=1774558659;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZbHkxEaq2y/MbVWwd4LBhMOJbILvHqrkcuMKnGBbXs=;
 b=DJNdmhORkSR14HHSugBgBqf8h4eqoT+QRd2I44agjK6Rkc3wmoIVdaDjgJN9fY80XZ
 zfJbPOfC3nab4LWwMwcrdCksOqGKdX6Ag2ElDeYe0vHv2p1TBH9ofbMbu7HNDiYdIgH6
 RMiXSHAlsWdKg5cD7CQSnglib+IB1toeNPI9uu+1HeA0t3rUKIHIE6/pei1dnhZyOhMS
 YMuyGphdMevMyZk84ohi/PnX0Y84S3HMj/gJIy/DnzNp6/CLQSZOqIWDi4ohdyCDFjtA
 PLZ7kX1IqJ0QZS+3Cu8yUGlMoD4W+h0tPFMbtVAge0ymWZhgQzYnhhHxnQk8EJLeYXk2
 Yz1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE4M4UOKcqUOwfLJ7mDfypZNFtd3L0vcmobSs8qs1Xsdt6TnLE7H9HUUUDB7LK6sTthR+0X/g7bhZE@nongnu.org
X-Gm-Message-State: AOJu0YzuGiIG2Rk1lT2gQNa4S3uFJ0CJv8Q/AghrZ3qhN5niSsqsiob3
 hImMP0/DNswidwDAty9DHJ2Xefx290jn5gUQ/d65r4bSNtRc3AYXMqsYQlRsQWHqbdc=
X-Gm-Gg: ATEYQzyqHO6LuszHb77HiDxgPKa83bBjJIbVXBPzp+08+9YEQq80djA6Re77RYsQYYQ
 DzsWWg3sODMyN1WjlIr3tnum6hPhvPoHgJwJFuHzyN4DNijAYxWTLIvHtqenqMJ5MOejbeqjor6
 GMc3KBN6hNosJSfAm8YPVj4boWtYaHnae/it8Tx2H0/F/rzEYEWZjRzNnPq3GHuTWJJSIuWoaxz
 LQD14KSzjX3wvC6cTPzhK//3jQGsL8i8P6OERI/SMQdNfqV330DyeOGK4UI/L5y9l5x8abQ8nxA
 BP30jowZKsDFLY8VhiGwprRwVjNY3NrVPAiWk+qgAZ27b+95ynseaP7YrfymxmTfvGsouNfh2/g
 +q0/t03qAJZiy476xALmyl3S4drKKsJsmVOmRNpDda23mRkkFOCJKCxJyX93WyhjeIhdi939k8E
 gLWsQUBaEzsknW8mNnytRFvqC9d374LnehlkwdVH7/N24l/tLiHYzTMcFoKsZI83UfNFYna48vS
 yuutmM=
X-Received: by 2002:a17:902:bc4a:b0:2ae:ceb0:d5eb with SMTP id
 d9443c01a7336-2b0826c7d04mr3641865ad.6.1773953858538; 
 Thu, 19 Mar 2026 13:57:38 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516194sm1252525ad.4.2026.03.19.13.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 13:57:38 -0700 (PDT)
Message-ID: <c137e3eb-1260-455a-8283-544e4f207e88@linaro.org>
Date: Thu, 19 Mar 2026 13:57:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] backends/iommufd.c: report error when /dev/iommu
 is not available
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex@shazbot.org>, "philmd@linaro.org" <philmd@linaro.org>
References: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
 <20260318180641.1797902-2-pierrick.bouvier@linaro.org>
 <IA3PR11MB913625F24F98AA40ABC7AE3F924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <IA3PR11MB913625F24F98AA40ABC7AE3F924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/19/26 1:35 AM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Subject: [PATCH v2 1/2] backends/iommufd.c: report error when /dev/iommu is
>> not available
>>
>> In case current kernel does not support /dev/iommu, qemu will probably
>> fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
>> since QEMU opens it before /dev/iommu.
>>
>> Instead, report an error directly when completing an iommufd object, to
>> inform user that kernel does not support it, with a hint about missing
>> CONFIG_IOMMUFD. We can't do this from initialize as there is no way to
>> return an error, and we don't want to abort at this step.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> backends/iommufd.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index acfab907c03..2c3ca23ca0f 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -72,6 +72,12 @@ static bool
>> iommufd_backend_can_be_deleted(UserCreatable *uc)
>>
>> static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>> {
>> +    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>> +        error_setg(errp, "/dev/iommu does not exist"
>> +                         " (is your kernel config missing CONFIG_IOMMUFD?)");
>> +        return;
>> +    }
>> +
>>      IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
>>      const char *name = iommufd_fd_name(be);
> 
> I think more accurately it could be:
> 
> @@ -82,7 +82,12 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>           } else {
>               cpr_save_fd(name, 0, be->fd);
>           }
> +    } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
> +        error_setg(errp, "/dev/iommu does not exist"
> +                         " (is your kernel config missing CONFIG_IOMMUFD?)");
> +        return;
>       }
> +
>   }
> 
> Thanks
> Zhenzhong

Good for me, will send v3.

Regards,
Pierrick

