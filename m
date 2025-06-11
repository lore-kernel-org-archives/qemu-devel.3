Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87454C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPI1S-0002YB-B2; Wed, 11 Jun 2025 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPI1M-0002XW-30
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPI1K-00039Z-6f
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749635119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmAR55xcMt2ycvqTr5qtm/ZjRJwV2rucoaq4kve9UEs=;
 b=W0itIGzKZc/uTS2ccHxpiStGesJtGNNvn+UvIKQ1i2uGScXDywphoePvCMeb9U02F3oxHk
 DGL68iVbSYMpj6txZMA2Nc6+2bFVVfjQ2S5Y/xCt48RsgqhcSA6RzzQ1T3dQGtAZokk7ph
 vUBvjrYasQP+2FV628KM2XKHX8SZ2jk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-01y31FcEOv6qI9y9DnVmOw-1; Wed, 11 Jun 2025 05:45:17 -0400
X-MC-Unique: 01y31FcEOv6qI9y9DnVmOw-1
X-Mimecast-MFC-AGG-ID: 01y31FcEOv6qI9y9DnVmOw_1749635116
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453080e4741so30257675e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749635116; x=1750239916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JmAR55xcMt2ycvqTr5qtm/ZjRJwV2rucoaq4kve9UEs=;
 b=OnZIoEVsPjl8Z89X95m6oxEjvDLWzyLlI1X+Nbnxk4fad6nMI6vfwqPp3vIjpHmcOw
 usZq8pVyivjNFAvbjIbNW2L5bwYoivdPCFIIpZ9Yf7dSaZnjpKFu2aDQrkkSgzcAcx/H
 0zLYTWsi64AR3K0s1Jwpdb76AX9SjpMlqAxlFVDLcQjprkqsnqumoa/amrlzpVxakRd4
 Dbh/cCIucr7/sa6ymyQnK+Zxxog1ESLqL2PNDn8EhhPqwfALW4pKKbT79h4EZ5EthsWK
 WD8nGZjWkzJcwCFHyCCZzOILlaAiTrPKOWPuCJj3vtSeR2Xu+rtmvohqpl+JSJAyANu5
 JdOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYuJfJ9e/tft9IqWPg3ADYc+TYM32HtLmrFjdFQiMpdbqi7c1mMCMWpn+ZAwdExSBrGn2Mhtkh2W/E@nongnu.org
X-Gm-Message-State: AOJu0Yy1rRH9Asyz97eeG+KDq+e8u8ARPYau1laZBQdpAmUBD5ZNuxu5
 dL7zXxtzQ/lkvVJGZPYvRojnB87kfUexrRo34piWVpxmb0RqrGHwohO1dCD7718rvHWrNbJWd6t
 VduWCP/4ttwkt6OTxz0CBaJSdWIA4N/N/zxZRL3GEgXEcaQBIjoIBWt7y
X-Gm-Gg: ASbGncuZcnqPPV4yiZsJQZINVl3lCccvdmx5+qiFFMuya8YT7td2PtUWlPf5v3jz4dy
 S15NdFubM9M18S81A9PfWKGMdErT9IulcHVTK92fTlar52kEqUD1Fdzqh9S/MTHxxWD9nmC8ZmC
 W0vPriVbBLY6kJAN0biIhT3an9mQ66EcXAJ8efVp7eCEXB9V7FWQN8PbYSbZyukjk3DqhJGn3Ja
 gDFSYDWpmKBieOOIZ0RaXrcaKhq8Q8jJbVyAVC4HKwzPJhxic6e+kP1KlSCKL+/8eJPDmnSxOsT
 R8bta//Q8bJKKQ9MmZ9txuynfhT4waElo1Yzrgj/+o+U/7jXcaWB4Nwpel0gYQdTAMTTQw==
X-Received: by 2002:a05:600c:3848:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-453248f971fmr19823875e9.32.1749635116326; 
 Wed, 11 Jun 2025 02:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMwZ9uuUtaDQ5U1emQKijDf5Gf1EQJ3dUgUjaZ9ZyhnGGRh1a4XvhKr4fWacmfrHs3FOJ4cw==
X-Received: by 2002:a05:600c:3848:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-453248f971fmr19823545e9.32.1749635115873; 
 Wed, 11 Jun 2025 02:45:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323ab1a2sm14573895f8f.28.2025.06.11.02.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 02:45:15 -0700 (PDT)
Message-ID: <dd1e452b-9b64-4c9f-aa3f-6deedab5d912@redhat.com>
Date: Wed, 11 Jun 2025 11:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/25] tests/qtest/bios-tables-test: Prepare for
 changes in the DSDT table
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-9-eric.auger@redhat.com>
 <20250527143816.39c0dfab@imammedo.users.ipa.redhat.com>
 <20250527150357.03bfab2c@imammedo.users.ipa.redhat.com>
 <0dc27145-d748-44c2-b6a8-19df16254882@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0dc27145-d748-44c2-b6a8-19df16254882@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/2/25 7:45 AM, Gustavo Romero wrote:
> Hi Igor and Eric,
>
> On 5/27/25 10:03, Igor Mammedov wrote:
>> On Tue, 27 May 2025 14:38:16 +0200
>> Igor Mammedov <imammedo@redhat.com> wrote:
>>
>>> On Tue, 27 May 2025 09:40:10 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>
>>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>>
>>>> This commit adds DSDT blobs to the whilelist in the prospect to
>>>> allow changes in the GPEX _OSC method.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> I take it back,
>>
>> test with x86 enabled breaks on microvm,
>> so it's missing some DSTDs here
>
> It's fixed in the series I've just posted in 24/25 as we discuss it.
> Thanks.

thanks! picked up your modification

Eric
>
>
> Cheers,
> Gustavo
>
>>
>>>
>>>> ---
>>>>   tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h
>>>> b/tests/qtest/bios-tables-test-allowed-diff.h
>>>> index dfb8523c8b..abe00ad4ee 100644
>>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>>> @@ -1 +1,6 @@
>>>>   /* List of comma-separated changed AML files to ignore */
>>>> +"tests/data/acpi/aarch64/virt/DSDT",
>>>> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
>>>> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
>>>> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
>>>> +"tests/data/acpi/aarch64/virt/DSDT.topology",
>>>
>>
>


