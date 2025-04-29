Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE1C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lSL-00012j-5F; Tue, 29 Apr 2025 09:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lSJ-000122-AZ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:57:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lSC-0004G3-Mc
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:56:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3295254f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935014; x=1746539814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQhyjyHB7SOqPd2T0/+6fTK7ySNWEzUlD1H6ItqERo8=;
 b=FiIrhuwunCxW6ha39u+cGvl/B4i4RD0Qh3KDOGsODmTMYye/uXybIu+nnTlKyT8iYo
 JaZig718wOPWI4k5KE3WYa7S2NFmsx/KX3TOjCH5hriBkj3EhtlBI1qpDEh9wq4WUfOM
 HKyccMiS33ncbN2Uxa5XLdg4lpv6R5ZefZCJ74g1Z9/XN4Pvu37yyB3WmkF9+Lp2OFPq
 g2Jp0cG0a+aXnfSEPcupjXjrqpdnkxOEfVMfNqM5WIoF6955OD+txZfxy2t51jifzljX
 ec6RYpTUi0JqeaGQv2ATUaZSTqsdAu6lw00Jpox49U9qgt+496qZ3PNQ0iZnQaTOWyMv
 hk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935014; x=1746539814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQhyjyHB7SOqPd2T0/+6fTK7ySNWEzUlD1H6ItqERo8=;
 b=UGG3ie1MS9F1nccQUtk4pZCPOgOObodaoAgwlNKG9pqfN6ICIolU2vrBQRVeo7xK06
 JA7aFFOgVLBm8oYjhfbUWBcya8wPGnk+IaXkKSLEOu/RHevnrQjPLBiF89Wd+uqkY9N5
 AsHlBP38IjNht63ZRLeN6U3v3qqPTkIB9PvIBPelC7ksbbwU0gt0e97AlOsnJPu13ee4
 kCWbuoqOeg2Et5ixq7HNjdIJ9aagiJw30RlNaEIbnWKlIoqDrrInuzRPJ1T7Xi6BwDbP
 Tv8oKb4yES4h5DifZEzappAUtgIlPkR85acmCICtCXt+Y6XbEdR5byrfmHZSIyv+ga1J
 ZB7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoisdyHQcrmu84mzkCa55ZICqRVSvGVVediiVNJaTHYwUrnpUF9mbPFhOqnM0VFcrRbpwn7DN84BNH@nongnu.org
X-Gm-Message-State: AOJu0YycbUtnGRB94YSTsXriHKM8YYpwFm9A2/qMqUZKTwqpR7l8J+Kj
 S7eb/hXApa+HyCwOf7HSw8cZtMp2yBf9AYwnWVEORk+wb4F8ZtnaIzir6+ptly8=
X-Gm-Gg: ASbGnctudFBpr0tu1hCKDDsfssOlgrA/jXGDn9HezBUzWf01xneCYxEQ5q2bVC1s2hX
 nV03+x4UHIrNJ9Z5Coys2A5SOGy1kZDEoC+WDJlROvCdaZ2fgU5zga+Cfow2aOaHqmn0Pr77jdM
 kP1xCuAFVFWtYOrlrANho3SNUS81ptjzE1oR/9zuqPwz4VHcMbxO99Rw+rmaTwOBW2XOSksoe7t
 r9kmFqusUZ9WRtT1JQeT28DsiCq5C5BQrnXJanf8AMGkkkVOhe8aI4MUHYjkNYQBiUM6E5HC6y/
 wNSIrnJe9YNgk1fcv1+Cuq9aAPtWdMnS+7Oa/2gSFEi+clyr7ICgNYEgh6n+Anoby3IfEKPdhnX
 9Z/ATXlVoZPZI5A==
X-Google-Smtp-Source: AGHT+IHDaZ95JqhuU9kRDaL/yssXhisJx9xgA10RXqCzoRDgW7mIC13n9UfCKQe/AxMGurml2DyprA==
X-Received: by 2002:a05:6000:2207:b0:3a0:80b0:10ec with SMTP id
 ffacd0b85a97d-3a080b011b5mr6515936f8f.59.1745935014172; 
 Tue, 29 Apr 2025 06:56:54 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbdb78sm13779142f8f.41.2025.04.29.06.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 06:56:53 -0700 (PDT)
Message-ID: <b55c0805-2166-4fac-90dd-f7f99fe461fc@linaro.org>
Date: Tue, 29 Apr 2025 15:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-17-philmd@linaro.org>
 <00cc3b9d-7bf3-430c-abc9-d7dcaed25c59@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00cc3b9d-7bf3-430c-abc9-d7dcaed25c59@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 17/1/25 10:16, Thomas Huth wrote:
> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>> PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
>> hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
>> property. We removed all machines using that array, lets remove
>> all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/scsi/vmw_pvscsi.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
>> index f07e377cb88..8c793b4188d 100644
>> --- a/hw/scsi/vmw_pvscsi.c
>> +++ b/hw/scsi/vmw_pvscsi.c
>> @@ -69,17 +69,11 @@ OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
>>   /* Compatibility flags for migration */
>> -#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT 0
>> -#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION \
>> -    (1 << PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT)
>>   #define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
>>   #define PVSCSI_COMPAT_DISABLE_PCIE \
>>       (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
>> -#define PVSCSI_USE_OLD_PCI_CONFIGURATION(s) \
>> -    ((s)->compat_flags & PVSCSI_COMPAT_OLD_PCI_CONFIGURATION)
>> -#define PVSCSI_MSI_OFFSET(s) \
>> -    (PVSCSI_USE_OLD_PCI_CONFIGURATION(s) ? 0x50 : 0x7c)
>> +#define PVSCSI_MSI_OFFSET    (0x7c)
>>   #define PVSCSI_EXP_EP_OFFSET (0x40)
>>   typedef struct PVSCSIRingInfo {
>> @@ -1110,7 +1104,7 @@ pvscsi_init_msi(PVSCSIState *s)
>>       int res;
>>       PCIDevice *d = PCI_DEVICE(s);
>> -    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
>> +    res = msi_init(d, PVSCSI_MSI_OFFSET, PVSCSI_MSIX_NUM_VECTORS,
>>                      PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
>>       if (res < 0) {
>>           trace_pvscsi_init_msi_fail(res);
>> @@ -1298,8 +1292,6 @@ static const VMStateDescription vmstate_pvscsi = {
>>   static const Property pvscsi_properties[] = {
>>       DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
>> -    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, 
>> compat_flags,
>> -                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
>>       DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
>>                       PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
>>   };
> 
> Does this compile? I think you missed a spot that uses 
> PVSCSI_USE_OLD_PCI_CONFIGURATION in pvscsi_realizefn() ?

Indeed...

../../hw/scsi/vmw_pvscsi.c:1155:9: error: call to undeclared function 
'PVSCSI_USE_OLD_PCI_CONFIGURATION' [-Wimplicit-function-declaration]
  1155 |     if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
       |         ^


