Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8D5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whvzd-0005fG-3Y; Thu, 09 Jul 2026 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whvzb-0005f2-Vv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:09:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whvzZ-0006w9-R0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:09:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXMA12517509
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 21:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gkDQP6JCdA+9mjovYibLa5V5Q/cEQkFPMzirQCPDYac=; b=PVejgZ+1idKij1l+
 yv+Di5nVL1v3WPz7sySJbyZW2CiE0XyG4gaF6HkDiLdJVfxq/IgLhemcyZpvR3Ss
 FRbs/dhYu4r+/IvCnqOGfcVERjNfln9ulvxhhJ+OhZ1kMtpTflqm+cKGC0MKg+DO
 aoHnIAe4v8WtWpetKNWtLqnxyXFOe6WikDufAWXfn8yaWDuM1nxxnqLKqqn2ZP6V
 slp1/wB61v2Cq0PeUjXeouk26ux9e2UHPOk7PzDfO9t+/57jUDfzKq/Sv80JoEEC
 4kizzStRqE0gd7Ef4fQD4nGuLdEyl+HAiwC+nElNyUDsIdBqbcOdAb9AQXILM3aJ
 agvxnQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesses0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 21:09:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c20762d21so2587571cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783631348; x=1784236148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gkDQP6JCdA+9mjovYibLa5V5Q/cEQkFPMzirQCPDYac=;
 b=JPfkr2d/RtUTBrc2LGClys5Ibxyu5q6WolZDWNjiUs3ButKNdJbNY9QVgkNZ0zlAKb
 3ITieHZjH9AuElcrUp4V/i9TR2FnfpF5SIu/trgYcvyyLZaNjBAHN1REdaV1rZlMYGO1
 FPjO6QWBW2zG462/BCC5m/tE7SS+fmTH7SWk+sI+DpF8KlApQiZvA/os58v/98EvdOpU
 QajyxjJU6MkQnyIBZVCtuUEhsNgANWwzyedPg6TY+MXGVGNo/Xx9ndYkx1Jr+pDId9i+
 iHucH3XZpnon+Yjw84kCsbEKyZXOWCnco6cYun3LLgfe6o+46YNFPSKjcFRX8QvYc1GZ
 8t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783631348; x=1784236148;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gkDQP6JCdA+9mjovYibLa5V5Q/cEQkFPMzirQCPDYac=;
 b=Icx6ORGDDluEzNvl98FxLNUI77LRvMZPTO2foZQIvFye+ri0B6NTnhjtWBgKp9CMvP
 uQU9anu2ZpXuDc+yYACQWcWSMNLgonbvpWnv7ALkrARla3mJRAPMRoI64bVIzk0MotAf
 5TPZyh6WDOjP+NN7zeoMMSNdC4cPCW1i53mQF71GFKyAPa8YMwgPyA0UkgFRbB5NEaTI
 w3NfZNqxy7cnhR/ALUVYX6DbyZKMQeaJJmW3ygL/n9UGIPcwzr6aVHJH026y7K5p9PoG
 E1IPSNUkKlJxnG9/tVKzjikoK80Q+V2br/WkVRSoRjOuR0Dfm0J90lz/hmeAD2GXjhvB
 Sx9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpol0ig+PGCDZUY8kY2uxVL9MyQ3fi22BWjD6c7JHWEJ3IQRn6ayFkqpLYsHE+2EnUoosBGEkG+NT7Y@nongnu.org
X-Gm-Message-State: AOJu0Ywpos3a1MSLE11p0kYZIZxDOaBqmLLyt+b5biNGtTVWweGUwAmL
 avD0QuSaVzAaEcYDEdBfKdDdct1gWhZnkhqNQtW9g8Faeg5WW9E58OkY2rGAlrmNXeo98QBBM+C
 g4R3FMIXd3dC71UXsgs+KAThgqlU8+bpdWeuETB+Y5tbwp92ejIqyCNWTNg==
X-Gm-Gg: AfdE7cm5wW4luwh7GsZFmPGTDqp1JpBmTc2XgmpuxEYn0VPBjwHWZrD+MlFx1AqpkEU
 gPx23TaXPz6ESVcW5cipETrfhQROOrLDRqYe3QXpEc/SpOUDnSlL0Cvhw3Ertmw5BbhNcXAk4/A
 wfqo4YzpZSREaT1ADczW9xuQIzORuBIDNG8Eaaax+lLwVKJ2iyeLlrG0G7W1RDnolKc1pdnOj9K
 IyzUyI1JcPj6JhfNG6IOLZ38bUdCbtjDl08fRu+BaNSkKXZmeTW4iv84QGiOjc6iOSc0oKmLCCw
 smzuugBjmfPZ46hIDrvj890tocPCUPCbw6iy9DY98arrA+N+hLHOZz0Lv24TLVR4pwLTEoQw8/9
 e9iMfJTzpexFJ/pOhL6vP3e0FBvvYhXrVWRuJTSiQEvB566eghwn8RbyobEGn0A==
X-Received: by 2002:ac8:5907:0:b0:51b:fb54:559d with SMTP id
 d75a77b69052e-51c8b420b0bmr87469871cf.66.1783631347447; 
 Thu, 09 Jul 2026 14:09:07 -0700 (PDT)
X-Received: by 2002:ac8:5907:0:b0:51b:fb54:559d with SMTP id
 d75a77b69052e-51c8b420b0bmr87469661cf.66.1783631346929; 
 Thu, 09 Jul 2026 14:09:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm53976068f8f.28.2026.07.09.14.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 14:09:05 -0700 (PDT)
Message-ID: <f2103a7a-531f-4a88-8ecb-0dd58672c62c@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 23:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?=27Marc-Andr=C3=A9_Lureau=27?= <marcandre.lureau@redhat.com>,
 'Gerd Hoffmann' <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <0abcf804-f16f-43b6-a345-e14642e54718@kaod.org>
 <5fe87f4d-9c44-44b3-a684-511d243f0f75@kaod.org>
 <1c2ed0f4-35d1-4dd3-87df-5f8b9aeb800c@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1c2ed0f4-35d1-4dd3-87df-5f8b9aeb800c@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YircLPdw8WR2JSJFUKTZ4DnHm_Imu7A0
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a500df4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=9AdMxfjQAAAA:20 a=NEAV23lmAAAA:8 a=9pETRx84BgJMKzpfy80A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIxMSBTYWx0ZWRfX+EtCXb/rKfwx
 /cQ+JU5cYclvk830fsTkYn/6P3tfkyWm/aOCrWKSUKPOJvT9OXgus3+51bqZvZYOtshBpjcRRsl
 cHYzVRxI0/ZKqb3WYGn34Di5t81M3Cg=
X-Proofpoint-ORIG-GUID: YircLPdw8WR2JSJFUKTZ4DnHm_Imu7A0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIxMSBTYWx0ZWRfX1LlJrAXutSXy
 WDT6JDxncC99jwBjBOj4Yd4OmPx6rN9fpWyTfLJhAIchMPcEIy8ZCwp7NO/iUI4M3TThX0Ibim/
 5IdkPD4ShNlmfS4R6ldq8+8n2GRMJ8bJdZoiXhmOaadaf5ZBOvgzkM3xkCruDcDlm1H2A0JpTFU
 vD+Py9YFuQV03jl0XwUUFqmFGBnmt+Kthj5BTfYX8yJ2rR4DX2n8U9KCTtTSKOoVK3o0Q4UYi1f
 Y0Ob1i1EvkTf8NNkr/6fhZngjt1B26Vp9newAv8L4ckcUkqU1ZhdvfukT+gp3Nzia8PHFKgU28K
 6J/9MHVYJgBuZyjWpfsjxUp5/0TxlHHBop1zX0WqLV9h+H99EKxwUJwcxpK74L6y4CUWs6Vu6uu
 Iq9BjZsZr0IaXSfGIwt2m0AAyOQzzNLWvMwWpsgQo8p/RHn0AnGM2FDQR9WVcOUMIVN2Oy9tLXq
 XecbMzRfclYH6BMzL+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090211
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 12/5/26 16:47, CÃ©dric Le Goater wrote:
> + Gerd, Marc-André,
> 
> May be they can provide some more feedback.
> 
> On 5/11/26 08:13, Cédric Le Goater wrote:
>> On 5/4/26 07:27, Cédric Le Goater wrote:
>>> On 5/4/26 04:53, Jamin Lin wrote:
>>>> EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,
>>>> which provides the upper 32 bits of descriptor addresses when the
>>>> controller advertises 64-bit capability.
>>>>
>>>> Currently QEMU EHCI model only partially supports this functionality 
>>>> and
>>>> descriptor addresses are effectively treated as 32-bit. This becomes
>>>> problematic on systems where system memory is located above the 4GB
>>>> boundary.
>>>>
>>>> The Linux EHCI driver enables 64-bit addressing if the controller
>>>> advertises the capability. During initialization it programs the
>>>> segment register to zero:
>>>>
>>>>    https://github.com/torvalds/linux/blob/master/drivers/usb/host/ 
>>>> ehci-hcd.c#L600
>>>>
>>>> The driver also notes that descriptor structures allocated from the
>>>> DMA pool use segment zero semantics. Descriptor memory is allocated
>>>> using the DMA API and platforms may configure a 64-bit DMA mask,
>>>> allowing descriptor memory to be placed above 4GB.
>>>>
>>>> On AST2700 platforms, system DRAM is mapped at 0x400000000. As a
>>>> result, descriptor addresses constructed directly from the EHCI
>>>> registers do not match the actual system addresses used by the
>>>> controller when accessing queue heads (QH) and queue element transfer
>>>> descriptors (qTD).
>>>>
>>>> This patch series implements full 64-bit descriptor addressing support
>>>> in the EHCI emulation. Descriptor address handling is updated to use
>>>> 64-bit values and the descriptor structures (QH, qTD, iTD and siTD)
>>>> are extended to support the upper address bits provided by the segment
>>>> register.
>>>>
>>>> Add a ctrldssegment-default property so platforms can provide a
>>>> descriptor address offset when constructing descriptor addresses.
>>>> This allows systems where DRAM resides above 4GB to access EHCI
>>>> descriptors correctly.
>>>>
>>>> The AST2700 machine uses this property to account for its DRAM mapping
>>>> at 0x400000000 and enables 64-bit EHCI DMA addressing.
>>>>
>>>> Test Result:
>>>> 1. EHCI 32bits with ast2600-evb machine
>>>> Command line:
>>>> ./build/qemu-system-arm \
>>>>    -machine ast2600-evb \
>>>>    -m 1G \
>>>>    -drive file=image-bmc,if=mtd,format=raw \
>>>>    -nographic \
>>>>    -device usb-kbd,bus=usb-bus.1,id=mykbd \
>>>>    -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>>>>    -device usb-storage,bus=usb-bus.1,id=mystorage,drive=usbdisk
>>>>    -snapshot \
>>>>    -nographic
>>>> Result:
>>>> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 
>>>> 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller
>>>> Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
>>>> Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>>>> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01- 
>>>> g172b7e27a30d uhci_hcd Generic UHCI Host Controller
>>>>
>>>> 2. EHCI 64bits with ast2700a2-evb machine
>>>> Command line:
>>>> ./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\
>>>>   -bios ast27x0_bootrom.bin \
>>>>   -drive file=image-bmc,format=raw,if=mtd \
>>>>   -snapshot \
>>>>   -device usb-kbd,bus=usb-bus.3,id=mykbd \
>>>>   -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>>>>   -device usb-storage,bus=usb-bus.3,id=mystorage,drive=usbdisk
>>>> Result:
>>>> root@ast2700-default:~# lsusb
>>>> unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 
>>>> 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller
>>>> Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01- 
>>>> g172b7e27a30d ehci_hcd EHCI Host Controller
>>>> Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
>>>> Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>>>> v1
>>>>   1. Fix checkpatch coding style issues
>>>>   2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors
>>>>   3. Add descriptor address offset property
>>>>   4. Enable 64-bit EHCI DMA addressing on AST2700
>>>>   5. Configure descriptor address offset for AST2700
>>>>
>>>> v2
>>>>   1. Remove unused EHCIfstn structure and dead code
>>>>   2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)
>>>>   3. Replace DPRINTF debug logs with trace events
>>>>   4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2
>>>>   5. Fix review issue
>>>>
>>>> v3:
>>>>   1. Add Migration version test function
>>>>   2. Add EHCI 64-bit buffer pointer fields description in commit log
>>>>
>>>> v4:
>>>>   1. Reorder patches in the series
>>>>   2. Fix EHCI migration issues
>>>>   3. Introduce a common properties macro for both sysbus and PCI
>>>>   4. Drop the descriptor address offset property
>>>>   5. Add ctrldssegment-default property
>>>>   6. Address review comments
>>>>
>>>> v5:
>>>>   1. Add 11.0 machine compatibility properties
>>>>
>>>> v6:
>>>>   1. Update reviewer suggested improvements.
>>>> Jamin Lin (11):
>>>>    tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for
>>>>      AST2600 SDK
>>>>    hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with 
>>>> migration
>>>>      compatibility
>>>>    hw/usb/hcd-ehci: Add property to advertise 64-bit addressing
>>>>      capability
>>>>    hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing
>>>>    hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing
>>>>    hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing
>>>>    hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing
>>>>    hw/usb/hcd-ehci: Add ctrldssegment-default property
>>>>    hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
>>>>    hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing
>>>>    tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for
>>>>      AST2700 A1/A2
>>>>
>>>>   hw/usb/hcd-ehci.h                             |  29 +++-
>>>>   hw/arm/aspeed_ast27x0.c                       |   5 +
>>>>   hw/core/machine.c                             |   5 +-
>>>>   hw/usb/hcd-ehci.c                             | 162 ++++++++++++ 
>>>> +-----
>>>>   hw/usb/trace-events                           |  26 +--
>>>>   .../aarch64/test_aspeed_ast2700a1.py          |   7 +
>>>>   .../aarch64/test_aspeed_ast2700a2.py          |   7 +
>>>>   .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +
>>>>   8 files changed, 185 insertions(+), 63 deletions(-)
>>>>
>>>
>>> Applied to
>>>
>>>      https://github.com/legoater/qemu aspeed-next
>>
>> Jamin,
>>
>> I dropped the series from aspeed-next and kept :
>>
>>    tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for 
>> AST2600 SDK
>>
>> The USB subsystem is orphan but it is still used in the virt world.
>> This series is modifying the EHCI internals in such way that migration
>> is impacted and the CTRLDSSEGMENT (Control Data Structure Segment
>> Register) implementation is incomplete AFAICT. From EHCI specs :
>>
>>     This register allows the host software to locate all control data
>>     structures within the *same 4 Gigabyte memory segment*.
>>
>> Linux driver seems buggy too.
>>
>> Overall, the risk of regression is too high given the time I can dedicate
>> to this topic.
>>
>> Thanks for all the good work you done there, specially for migration.
>> If someone can Ack the series and step forward to become USB maintainer,
>> then I will reconsider.

I'm not an USB expert / maintainer but FWIW this series looked good
enough to me when I looked at it. Maybe consider to merge after the
11.1 release?

