Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0023DC3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 12:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSc88-0004HJ-TK; Sat, 13 Jul 2024 08:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSc86-0004E0-2m
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 08:45:35 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSc7l-0000cm-KB
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 08:45:20 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25cba5eea69so1389936fac.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720874711; x=1721479511;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7Q5afzs4OT0PezKZGPKvJtrMk+Z1yfOj2LoOgmN83k=;
 b=ZyflH9mp74kKWT7WCYtQrBxeIu0qlK3BfXA0OV5P3yRQ430FAN3Q+iuoK9ixzQRMJS
 jmZ+tpUHk6Scf1s9rPTmS2PQAXeOUEZiBV1eAPlwEOPMYXjDDgwq62FTtiEMR3hJGke3
 ztUuQtxWUoSVsz1LaEINnt6rVoowRxMn0NE3d90aKZnVEIDHCTP4ue0e3Vavn6eoz65j
 ie6LqPEcn8dDRvdD+bn+nT1ofRk2M/TUjPfc4FshsD7KRW5wPaWz9rO65CBmpQrHSitX
 ucdeYRwvOHQc5OQwmjgmXfTMFPTlM27Uf/flk4ldEMusLo+nZES0SZOSIpdE5PV+w0+L
 UT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720874711; x=1721479511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7Q5afzs4OT0PezKZGPKvJtrMk+Z1yfOj2LoOgmN83k=;
 b=c+3xQC5A7zS2X1Cf7TSH83Sdwqb1dzxLC24aj0h1m1iLChMQAeT82XIedJfEkgjDb3
 XiL35h+UIqITZPx/T+ivV7RSg9xuAvSgzDHcN0+v+hTWWPMUtk5lw3Nv9jF+YfVFp3zS
 UDH8JkUsUjrBpPKfkzsCdK2gumvS0xHpfYAXnjeR5ZmnHHFDkWsd6y0uuNa2T5x7gdFb
 tOr1Exjucpk6QpcObvKVauCvUlHQCipkatDRrYJiikNVD8QuX4lTh0yWIk8jjpUR/qE0
 a10SiwPtCSx5bh+ngTWmqTQ+2jVx0rEnYSoroqKm83tMzKYvp6jASzsYs//KwrrsEgPA
 lT7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIIncF757e2xiUk0uPA7EMOYvU+8u4WsHe2lP39Uzz/zc3c5ufEjMKPYDF9/edRxJR7FaNw4U2VHZ31wxU6Tajx9F9s9A=
X-Gm-Message-State: AOJu0YxpmjgApY235FEjF/eTQloxf1ojQhSlX99FfMeKaMXFjcIx7+BX
 qZaTguVa+fCOEgujB6nkHB7Tg+1ENjkMsHsZa/giglebQ73VBmOEC25TzCuHBaU=
X-Google-Smtp-Source: AGHT+IFMnJ9RlD9fKtzySc0mRVL2R9EuFVprwn+fhrSRxAljwtjJOA/7gtA9I7PS0pnKFix6LuqSHw==
X-Received: by 2002:a05:6870:3482:b0:24c:ac7e:8a5c with SMTP id
 586e51a60fabf-25eae7f1f0dmr11695143fac.21.1720874711635; 
 Sat, 13 Jul 2024 05:45:11 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca6c40sm1189890b3a.145.2024.07.13.05.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 05:45:11 -0700 (PDT)
Message-ID: <97c6ac3e-d099-4cc5-9672-1c1658f0cbc6@daynix.com>
Date: Sat, 13 Jul 2024 21:45:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/12] pcie_sriov: Reuse SR-IOV VF device instances
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-6-7ca0b8ed3d9f@daynix.com>
 <75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com>
 <20240710065145-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240710065145-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/10 19:52, Michael S. Tsirkin wrote:
> On Wed, Jul 10, 2024 at 08:37:27AM +0200, Cédric Le Goater wrote:
>> Hello,
>>
>> This change introduced a regression on s390x. I could have spotted it
>> earlier. Sorry about that. Here is the scenario,
>>
>> QEMU now creates automatically the PCI device objects representing the
>> VFs when the PF device is realized in pcie_sriov_pf_init(). This is
>> good to report errors early but it has an important drawback.
>>
>> On s390x, PCI devices have a dual S390PCIBusDevice object. This device
>> model has 'uid' and 'fid' properties which can be either set by the VMM
>> or, if not, auto-generated by the S390PCIBusDevice realize handler. In
>> the VF case, these ids are auto-generated by QEMU and they can possibly
>> conflict with the uid number space of libvirt. The conflict is detected
>> when the machine is created and the start is aborted with a message :
>>
>>    2024-07-08T12:51:42.876883Z qemu-system-s390x: -device {"driver":"zpci","uid":17,"fid":16,"target":"hostdev0","id":"zpci17"}: uid 17 already in use
>>
>> This problem can occur today with a s390x VM using an IGB device.
>>
>> It worked fine when the VFs were created at OS runtime because the initial
>> topology of the machine was in place. Adding VFs was more or less like
>> hotplug. AIUI, libvirt should have full control on the machine topology
>> and so, creating VFs in QEMU at init time in the back of libvirt seems
>> like a violation of this rule.
>>
>> That said, the s390x case is specific and could perhaps be handled in a
>> special way.
>>
>> Thanks,
>>
>> C.
> 
> 
> Thanks for reporting this Cédric. Akihiko what's your
> plan to handle this? Do you have the time to address this issue?

Creating VFs at initialization time only makes problems apparent early. 
Even without this change, hot-plugging another PCI device after 
realizing a VF results in a similar situation.

A proper way to handle this is to add new properties to igb and nvme to 
let libvirt specify the VF ids. However I wonder if it is a worthwhile 
addition (i.e., if igb and nvme's SR-IOV emulation will be used with 
s390x and libvirt).

Regards,
Akihiko Odaki

