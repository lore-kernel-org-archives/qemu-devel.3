Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83BC18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKFA-0002i6-QQ; Wed, 26 Feb 2025 11:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnKF9-0002ho-Jr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnKF2-0000eu-Um
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740587188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VAmdflLTB5qcRbTe1Oox1WgdRPSWyC4vlzkSwoNkNJc=;
 b=WQNIHxfwPYJ2k2Yo9RlUCPLEC/eWMGmZued5nPhuAWOG5Oz7Gfx7IPv6YpHXmoMvK3ZYhf
 kQ+DKY9T/pgoDvB19E3gl3MsLamquP2WOkGvLJIEeCCcPRbIhaQD6k8udAOb/6DIroRKu9
 HnBUdeYos25Ox9bAoMDQYUbxik8Q9NI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-oBhmt-q7POu3H8JWqOrlUA-1; Wed, 26 Feb 2025 11:26:27 -0500
X-MC-Unique: oBhmt-q7POu3H8JWqOrlUA-1
X-Mimecast-MFC-AGG-ID: oBhmt-q7POu3H8JWqOrlUA_1740587186
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43942e82719so50754965e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587186; x=1741191986;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAmdflLTB5qcRbTe1Oox1WgdRPSWyC4vlzkSwoNkNJc=;
 b=qNbmoEEPK/i3n558Fq0KkWG2J2cg0efoK4Sr+2d745lTCJHqC5xKeJN37kJkNQE8Fa
 Dtq9zjnrUWf7vFCH8M+xO9K3eyiN8I6Ra+A9LaTWjuI/dHa6Z/+E4KWuygT3zguKIIuu
 at5MQcAXawClxTMZFYKK3PZu/Y04Ef5mleUrXpO21JhPkTYvGiO4Tes3jyDiVkHWy/VD
 mjNSWuYm8he/ru67hExiMAFE+Km35rSEF3KZ9efk4VqIvMVxvn1ex5sUd7DroAjDAfcB
 SH1qxXSZbSgV+jop3R1c7qz3d0DKe/PoNRyhAujJdMPd37ImhlEKmuH5IhL8IXzyiiVM
 JBww==
X-Gm-Message-State: AOJu0YxE2vkXrLRMUpZDfn6IoTCm2POIgZ1SCPRNrzxpW1CcI9B4JW3E
 pPc44iReFZbiKXZCITlILpJN/f89vcFjQU59vKJ9T03bTZJfJhg2k8KUYCnRVMvdNga57uiHhB3
 FQtrL9k5vjWybmKJhXUIvqoaRuayrO+sgbGZeJEpOHTJp8S2Rs5w3
X-Gm-Gg: ASbGnctivz0J7nNWJ7oK+/YRhyD+ggJPjnk3+bNO6SJVU0OAg4VUQfOXJD+s98G3XWt
 s6n3Fb1SVOaLsBi8hfx4h6OtyoBSHBhlLPXeqzVZ1eiVP8sdqX8dsSpagyzf0cJupR07xEpJLre
 LsntubIUE4AYDlqlb3DiYqCob1hFiTOr6ZzWKy9onpz1kPV4sFQN6QauumW6wprwQ84Nfx2BUGk
 OBLE3dkK2bAwI3tYj8OI5ychuP1Cq8zn6zOjxtV+yRkgT7WHYpYJDuVfBlo2AGBkHzWC5ocBafC
 vDNwNm5SJWhpsRmPSTh8PRR22di6huK7OTayGneEHQr1iZ32XmT/F4sOQqk=
X-Received: by 2002:a05:6000:1366:b0:38f:5120:129d with SMTP id
 ffacd0b85a97d-390d4fa34demr2619203f8f.49.1740587185596; 
 Wed, 26 Feb 2025 08:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkIIM0GkTMJu82DDFrBN17TOKHtx0KNthBOeFQ48/oPB03MUIO27/3wCdn624zqT9qrN4iTQ==
X-Received: by 2002:a05:6000:1366:b0:38f:5120:129d with SMTP id
 ffacd0b85a97d-390d4fa34demr2619143f8f.49.1740587183753; 
 Wed, 26 Feb 2025 08:26:23 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba549eb9sm26693395e9.37.2025.02.26.08.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:26:23 -0800 (PST)
Message-ID: <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
Date: Wed, 26 Feb 2025 17:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/26/25 15:12, BALATON Zoltan wrote:
> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>> VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
>> worked on i386 long ago but we have no plans to further support VFIO
>> on any 32-bit host platforms. Restrict to 64-bit host platforms.
>>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> hw/vfio/Kconfig | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
>> index 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 100644
>> --- a/hw/vfio/Kconfig
>> +++ b/hw/vfio/Kconfig
>> @@ -7,7 +7,7 @@ config VFIO_PCI
>>     default y
>>     select VFIO
>>     select EDID
>> -    depends on LINUX && PCI
>> +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
> 
> Are these defined for the host or target? 

host.

> I see PPC is defined in target/ppc/Kconfig so I think these mark the target not the host. Vfio-pci works with qemu-system-ppc 

Ah ! I am surprised. Which host and QEMU machine please ?

> and we are trying to use it for GPU pass through for 32 bit PPC guests. Please keep that enabled.

As per commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13 "meson: Deprecate
32-bit host support", support will be fully removed in 2 releases and
it doesn't need to be addressed by VFIO.


Thanks,

C.



> 
> Regards,
> BALATON Zoltan
> 
>> config VFIO_CCW
>>     bool
>>


