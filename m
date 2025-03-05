Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D54C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjl5-0002sy-I3; Wed, 05 Mar 2025 03:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpjky-0002rX-Ol
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpjkv-0002Ad-Nf
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TgtXNv37KC11iqpz/KpgUdjymsW+fqIB1TIp/6sgMGM=;
 b=AQZPNcqlvffq9JGIZ/JuZB12SHEkNvGc9fOyMXnBnAFLZxBNif+/wFm3B6/U/IXrlkDMhd
 yQWK5vob1ZQl+yst/f2xnkgw8K20T8ENuPX4MajOWCHCMNNtyOk0mMATgH4JwZD1iI+Vh0
 dPNNxXDHIPgyS3CJXL4mrWwLrXqm4AM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-iRtnDJxfPWOL-DGYHMRs2Q-1; Wed, 05 Mar 2025 03:05:26 -0500
X-MC-Unique: iRtnDJxfPWOL-DGYHMRs2Q-1
X-Mimecast-MFC-AGG-ID: iRtnDJxfPWOL-DGYHMRs2Q_1741161925
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39104a3b8e3so2515574f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161925; x=1741766725;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgtXNv37KC11iqpz/KpgUdjymsW+fqIB1TIp/6sgMGM=;
 b=fN6xfroQTvAg9vJnyMGEKdGK7SEMloGxjTqt/TDacJZaVGhJReEYVmp4dbjzQlwNBn
 9hT52vRxmDLtswr1o4U+uVHho6wGUQu6ujrP7oGNp4Ap+YpOSNspKlCFaLqReiX6kjtV
 OUHC6kFVTwaEptPy2LQXSGtK7bQYG8cKL/8eZeUL8WkHeYitD9Eqs2RSIhe8LPnOkaSB
 FESM2o+Fdj6mdQ5KIzF7SOnfpRNBT+4PT0ElEil2pfRimDqeqli3TWGydDfLm9De4hHa
 rfclaqR39na9swlgXXnKjCAgw8dYocBhISVOjFNGWt6WEWITzRFVgPlW9Un0b9qo7Ctf
 lrZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVwhycW3xpRtyqxBrrYSQsj5d0sQQ4iseht8Rb4GoKLGRyuiPKMX9zGEYMeeHmkF3a9cCScdDlJQhP@nongnu.org
X-Gm-Message-State: AOJu0YwLpeZzznuIImrR0u6Uz6UgUSHLnWsQHnA9nUWx/KSuZTYU6dWN
 xmH91m9odDNKibDZ4lRD9bDg2IPYVyYaXLASU2p84u5EX8sYh4KZDL87hga50rMahx5BGdxYCwi
 msw6vKSjkd4gDM0OD7PnMydR6qMpkIRKF2XIPP0AWKqaMT+C/iKF1
X-Gm-Gg: ASbGncuSNv5j6b6+Z7lXgssYUU6anX1xK5nmaoArHgf+oFzUu/agclV8JHrkLgZZnF6
 L3mezDcinJZt/kr4VlRXo8OcRUFqtChdlcpmGwfdAipifG2g5aCmRXQKDGB5IHv6IBF0UfCHDBF
 jokD5BlO44EMKFysKxRlkuV0UBJtJXsTg1QPfxch3CGQ8fBy49T/1WnZJe20hEKqVdClsTaf4Cl
 CtEQx/BUH10sfummszwDhICVl5YF718RFd7wICuaLHIahuau4Ozhwk1fskMvcMMqidvBhpMiGxp
 Ueq1qPrU0dCuWYp2Jn/eGG/l3KG48NK7X9GPqNXG++jG7a4=
X-Received: by 2002:a5d:5f4d:0:b0:390:f55b:ba91 with SMTP id
 ffacd0b85a97d-3911f727cf9mr1329327f8f.14.1741161925255; 
 Wed, 05 Mar 2025 00:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMJuSjZaUGzKMDPEmSumYD4nI7mkK/djEpTqri+1Own+LfHn/a1a/2LDkOtIKgSYLseVfHZg==
X-Received: by 2002:a5d:5f4d:0:b0:390:f55b:ba91 with SMTP id
 ffacd0b85a97d-3911f727cf9mr1329297f8f.14.1741161924879; 
 Wed, 05 Mar 2025 00:05:24 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485dba4sm20520622f8f.92.2025.03.05.00.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:05:24 -0800 (PST)
Message-ID: <3e35f453-926b-4eb6-a5ce-72f89c4f8375@redhat.com>
Date: Wed, 5 Mar 2025 09:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] tests/functional: Add a hexagon minivm test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
 <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/03/2025 16.46, Philippe Mathieu-Daudé wrote:
> Hi Brian,
> 
> On 1/3/25 18:20, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
> 
> A bit opaque...
> 
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                             |  1 +
>>   tests/functional/meson.build            |  8 +++++
>>   tests/functional/test_hexagon_minivm.py | 42 +++++++++++++++++++++++++
>>   3 files changed, 51 insertions(+)
>>   create mode 100755 tests/functional/test_hexagon_minivm.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index deeb7878c8..48a5e7c005 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -247,6 +247,7 @@ F: gdb-xml/hexagon*.xml
>>   F: docs/system/target-hexagon.rst
>>   F: docs/devel/hexagon-sys.rst
>>   F: docs/devel/hexagon-l2vic.rst
>> +F: tests/functional/test_hexagon_minivm.py
>>   T: git https://github.com/quic/qemu.git hex-next
>>   Hexagon idef-parser
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 111d8bab26..78b42e58f9 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -135,6 +135,14 @@ tests_i386_system_quick = [
>>     'migration',
>>   ]
>> +test_timeouts += {
>> +  'hexagon_minivm': 180,
>> +}
>> +
>> +tests_hexagon_system_quick = [
>> +  'hexagon_minivm',
>> +]
>> +
>>   tests_i386_system_thorough = [
>>     'i386_tuxrun',
>>   ]
>> diff --git a/tests/functional/test_hexagon_minivm.py b/tests/functional/ 
>> test_hexagon_minivm.py
>> new file mode 100755
>> index 0000000000..2ba92bcce3
>> --- /dev/null
>> +++ b/tests/functional/test_hexagon_minivm.py
>> @@ -0,0 +1,42 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights 
>> Reserved.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +from glob import glob
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +
>> +class MiniVMTest(QemuSystemTest):
>> +
>> +    timeout = 180
>> +    GUEST_ENTRY = 0xc0000000
>> +
>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>> +    ASSET_TARBALL = \
>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>> +        'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')

Tests that download assets should go into the "thorough" category, not into 
the quick one, so please replace tests_hexagon_system_quick with 
tests_hexagon_system_thorough in the meson.build file.

(yes, I know, it's a little bit confusing that tests that finish quickly 
should still go into the thorough category instead ... but we needed a way 
to distinguish the tests that download assets and the ones that can run 
without downloads, see also the description in 
docs/devel/testing/functional.rst)

  Thomas


