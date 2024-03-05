Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7A1C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOyK-0004S5-9X; Tue, 05 Mar 2024 02:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhOxi-0003zY-PR
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhOxf-0001ld-W1
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709622699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJXSIOH+YBRZRygDXtueZZ6Vz07xd7JTPPO9WZ0Ig8g=;
 b=ajWaNLJZ1Yr21lyORkJAodKs0LQ9/QwSTCs6VN03jU+G7hOe0fqOMJTzhahmT7KMvFthvS
 ogB1TNMKjXCSoucYiwj/0dQUuhRKNWHWknimQNkP/fIqwDYeinxLqMNMiRLDeigmuSdAA2
 3x9IG+q9DHLJOJxmjPZjrqSZ1cI9ZFg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-g1Ocmz03NEetik4SJk_x7g-1; Tue, 05 Mar 2024 02:11:35 -0500
X-MC-Unique: g1Ocmz03NEetik4SJk_x7g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78319f64126so838958985a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709622695; x=1710227495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJXSIOH+YBRZRygDXtueZZ6Vz07xd7JTPPO9WZ0Ig8g=;
 b=tDNKuz41dH2fYfWJWxN5TUMpZf31GP01yjTXovKTa00hzOBBuNMB8z6lIN2AfaVC+f
 diE/wiUOmxiujLM9ci8pfeiKbgeuyJXR9PT2/2KNYWLFhu/OBGEQi7X9Demb+YkVvqe0
 kKVFkLxcPs7q3lBZezVSCiEFH1j0o6C4a9zAW8GR3zJiVPsHENGio+yX92OLprXj7Mbz
 eS05f6PQPOrBIm4iU9WPt79Vi6uxbW1XuFQHpH3BCd8IZ7bwPXqqpZObPQlk5+3UI6gl
 WcdIi3Y6IaS3QJUjtQ/VhDyTxx/qPsko1HA+fOdX++r08TtXzS+RbCfwLn54nwnC1aFd
 CjNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9m3/hp6vben3yZ4jq51YwBmRcvXrlKJ8gZciZhijp5pU1foebIZfgn5shSPLhbytOZlkk4Bk8dnUiAXJP3jq3QrAwOOU=
X-Gm-Message-State: AOJu0YyHwCCsfSA1j+H0z8gBnUy66O+JltZORfeN8pRf5PtBpsM81mFL
 8aYeE/Am9LdmOy031Mvu11TOoweOgeLtkisV4E8lPD9nTwqzFxBBu/8MVzvCnQqtNg9iFNhXugv
 9jp6698nkqUveaW0HhR52dKAA/qr0HOonlHx42/vZFgPTJyiOkzUu
X-Received: by 2002:a05:622a:104:b0:42e:68b5:da8f with SMTP id
 u4-20020a05622a010400b0042e68b5da8fmr1107501qtw.1.1709622695143; 
 Mon, 04 Mar 2024 23:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYbyOGIjyXYKQQCxTfAl+0QcvfB/gCAjtdFXoRsBfCIgitujAaRSN/AfeKFcS1tEO0xY69gw==
X-Received: by 2002:a05:622a:104:b0:42e:68b5:da8f with SMTP id
 u4-20020a05622a010400b0042e68b5da8fmr1107465qtw.1.1709622694795; 
 Mon, 04 Mar 2024 23:11:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 he29-20020a05622a601d00b0042ee1ff302esm2592910qtb.66.2024.03.04.23.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:11:34 -0800 (PST)
Message-ID: <533ccbfc-7d90-42cd-9183-a5b128c41fad@redhat.com>
Date: Tue, 5 Mar 2024 08:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Content-Language: en-US, fr
To: Ankit Agrawal <ankita@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/5/24 06:59, Ankit Agrawal wrote:
>> One thing I forgot.
>>
>> Please add a test.  tests/qtest/bios-tables-test.c
>> + relevant table dumps.
> 
> Here I need to add a test that creates a vfio-pci device and numa
> nodes and link using the acpi-generic-initiator object. One thing
> here is that the -device vfio-pci needs a host=<bdf> argument. I
> probably cannot provide the device bdf from my local setup. So
> I am not sure how can I add this test to tests/qtest/bios-tables-test.c.
> FYI, the following is a sample args we use for the
> acpi-generic-initiator object.
> 
>         -numa node,nodeid=2
>         -device vfio-pci-nohotplug,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
>         -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> 
> Moreover based on a quick grep, I don't see any other test that
> have -device vfio-pci argument.
> 
> Jonathan, Alex, do you know how we may add tests that is dependent
> on the vfio-pci device?

There are none.

This would require a host device always available for passthrough and
there is no simple solution for this problem. Such tests would need to
run in a nested environment under avocado: a pc/virt machine with an
igb device and use the PF and/or VFs to check device assignment in a
nested guests.

PPC just introduced new tests to check nested guest support on two
different HV implementations. If you have time, please take a look
at tests/avocado/ppc_hv_tests.py for the framework.

I will try to propose a new test when I am done with the reviews,
not before 9.0 soft freeze though.

Thanks,

C.



