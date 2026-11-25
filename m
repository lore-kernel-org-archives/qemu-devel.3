Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A673606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C5gZbKLZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D0kBXvXq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAEG-0008T3-2k; Wed, 25 Nov 2026 05:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWAED-0008St-KZ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:27:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWAEA-0005nd-Rj
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:27:53 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mOmH3764000
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cmS7QqIIxHD8feewj0DwMbNYGLavKc+v+kO91CrNG6I=; b=C5gZbKLZXGahuC3b
 h4pjS37YD1RrRUhledM7fycEH2rM9B+L9DLPCU/YLG6Szak2pCwfO0BhhGEFPU5j
 +mx5X43JCIkAHwafExxbUqoIiPxMFW/ZcQFJUnMP97mqX6FebeJMZRq+scbMLj5U
 +fcbMK5bmMqP02961uGxBJtTtqQ5S2p8FXTi5TJ73O+/u4P7U8P6llSrAARtKbkV
 ySt/+9Dbei/H78beyR71tp8FinavhbzaOvTWZt1FZd+o6tSgxxtW2L/j3gWm5VbK
 qhY3PLb6wz1VjNEk5FlFswB8xj81xI+HeITchlXfL5sAphSP8KgVoDVP/KgGMefI
 5Ywxpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2rawd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:27:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso638151985a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795602468; x=1796207268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmS7QqIIxHD8feewj0DwMbNYGLavKc+v+kO91CrNG6I=;
 b=D0kBXvXqfwjtEaHmcBDUpyRxvMVuvXB/PxKDK8mzEbVR5Go2Cgj4qbIrNS0aySIfpV
 TZwZHq0qZR10BacZRwi0g/Vgh9A+POMIA0iqA8HU/QqvOI5GRD3ujpsFKOWkyX8wTFSv
 95pPAV9ilr80aAkjUn3tU83DPkA14taCMr7mNQgYnTaILio/SChhC3qKHRQoff236NNS
 nQawVjaKo6vrr/MNdCra4Qzp9hEQf51eEf1K2jh+xUdjTlw2kIl6BsQ+WyuCQZb6HcRu
 FQU/31sJXSF32pbPHWwF5PiUwqg4GTyU1STwNes7AVk20RIfcxLeMsVZqFJ6hDy3WMtU
 X+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795602468; x=1796207268;
 h=content-transfer-encoding:content-type:in-reply-to:cc:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmS7QqIIxHD8feewj0DwMbNYGLavKc+v+kO91CrNG6I=;
 b=uVKEvB45rSAXYx1IHrrsCJbxAtMnrn5d1fSakztBEE+xzEkN3TNYNXUvgIHDER/B74
 e7WBtm0ZvxMECmLdYypqXipSyMny1tW63BtBlZyJ4BrMDgSEd09+LopEiun3W9D/YY3f
 qOBNqu7C2goIarJnnHumhcKr4bXLD+P9cWe7mpkkbpYBD/cTXLnGtalYhVyPIt85y3lL
 998EvJ5VjymGtPamIwwblUYggiHiHahPXuXmTn/RxjPysexnyODrRnJ60tXd7LRsh5U+
 wSKEdbl866MvqoGPIMvS7zu2YSPTDlJgb6bnoUbHDeVqWdKtggq4jxYgOwccKQYa7B5Y
 2k+w==
X-Gm-Message-State: APuU4Z92adW2wugww3/M/cUQQpfdPgULehxaPzc3HT/DNQ9IIynuYzcl
 7GlYyn2Eb+5gCZaP+1agMboi0bC2EJ9gcbGoa8NAFLML/Hbc1XApf/Sn6CD3ZqrVkzzYI4RWPDf
 6ItpO5Qb0jE3Rqszwq5UJjblowHxUt80upUOj5UZwZK2Lvpj9g1K2H3ad1XqQQnwyxZVt
X-Gm-Gg: AZFdTZdVkF/1zb3RsaNkII27c0Qs++4WmiDFbNJ1OGofUPtDXMNJ8ZIbE1pmYHyZ68/
 ltDQe5ino9NMCKJomO1znvK4jDdMd0mAFO/JTBv/ELtvMMwDAMqeZCTOXGL06MJfOJEdYRnOykS
 dtpGhiKtXQ5Q71cZVqlbVutf2ix7qwRSWAUfKICTMzYTPNcNdL/fE75iaKxwkAsSdZKyhXjOXPD
 xvFkI00nZUo7+krfvMx5vTiCg2hdEE4E2+TNa5nA8x0eS041MUysPyeV6yW738yT2K3mVeYWDeM
 K0kq8EibBdWxxI+FnivuRYCKDSxcsAgZjotOV7pR1IG2AcMQDiAKLkp/yrVFaFs96anQwWRVr3o
 Qjkkl1e4RYej3D492uZlHMJAni8ZYJSxtOm3yKS06kas8kOoG0YgsdBM0J5mmwGt56DPUUP1I2O
 MUgsYV91Q=
X-Received: by 2002:a05:620a:a186:20b0:94a:8bf:19af with SMTP id
 af79cd13be357-94a08bf1c26mr86631885a.30.1795602468297; 
 Wed, 25 Nov 2026 02:27:48 -0800 (PST)
X-Received: by 2002:a05:620a:a186:20b0:94a:8bf:19af with SMTP id
 af79cd13be357-94a08bf1c26mr86630385a.30.1795602467657; 
 Wed, 25 Nov 2026 02:27:47 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906cdcc1sm280514835e9.2.2026.11.25.02.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 02:27:46 -0800 (PST)
Message-ID: <99e904bf-c28b-4ce8-a61b-01a9ca2b22c5@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:27:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Misc HW patches for 2026-11-24
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
 <903cd807-c7ce-4d44-ae74-aa81289a887a@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <903cd807-c7ce-4d44-ae74-aa81289a887a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX/CAEIO0y46oa
 vQ2SLiCtppAZKccUbKfdJrL3lxIYnqDnvd6YQMGqYF5AlJMhEnLDuO3GUgtddv3YyEXFtqMPdkc
 /T+c+GgBlh1pdVT+73qWXm1yYtkZFdg=
X-Proofpoint-GUID: E9R57x6SZ8Ifh7fNpWGaWNjr4KwCdMFr
X-Proofpoint-ORIG-GUID: E9R57x6SZ8Ifh7fNpWGaWNjr4KwCdMFr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfXx1sovgJ71i17
 48pSZ9iOOsdsEJY3EcXqe+6T9ZyNolyhkeIbkJHf1RBi3mOIl6WFubHeugPze1Z9PQvJcul0O8S
 q5eb32cPjPptHkSy94UAv30RgG20TT9mr/vnsWL0hqfGnjWaYtzFyvhteIlvRD3Hejtuln8dBmv
 lc6+VwJr0vQTvJvXwk5hY3mfRFjS6IkH6dyU0KHMAWIrqs4KQ2kKP89m75HDLlZ1NYBkY/8JHpk
 fNE0RN2a6MpAbPJoB0wp+cm3tBFJLjXJK4o+Ck3X3KF3S2i8lHh4cpA2AJMtRwEDWmXpIEvF7Uy
 TQD7M4q5Dei90i815++s7la8WYbaKEGjvyg8+iW5141keYWWRhle+aJicJ0a72O/mvjckIxWV7a
 bapSGQ8OPUueIixCPYJHofcyyr8+dl6VQCQZj/anjiz5Z1yLy+KwMhGN1Zopv//nFAPYlQSfCD/
 i9jxGqTgGyCYAG5N2fQ==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06b825 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=popR_c9GyiWU4UWPk2MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250041
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 08:13, Philippe Mathieu-DaudÃ© wrote:
> On 25/11/26 00:09, Philippe Mathieu-DaudÃ© wrote:
>> The following changes since commit 
>> 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
>>
>>    Merge tag 'pull-target-arm-20261124' of https://gitlab.com/pm215/ 
>> qemu into staging (2026-11-24 07:09:41 -0800)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20261124
>>
>> for you to fetch changes up to c3800302668ff745e10b810f12723eac7068abda:
>>
>>    hw/ppc/amigaone: Invalidate TBs on NVRAM write (2026-11-25 00:02:01 
>> +0100)
>>
>> ----------------------------------------------------------------
>> Misc fixes for 11.2
>>
>> - SD (card, controller)
>> - VMWare VGA display
>> - Parallel NOR Flashes
>> - I8257 DMA controller
>> - IDE ATAPI layer
>> - Amiga One
>> ----------------------------------------------------------------
>>
>> Denis V. Lunev (1):
>>    hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31
> 
> Please drop this PR, there is a issue with this patch I missed
> earlier:
> 
> KVM: entry failed, hardware error 0x7
> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000663
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 00000000 0000ffff 00009300
> CS =f000 ffff0000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
> DR6=ffff0ff0 DR7=00000400
> EFER=0000000000000000
> Code=09 66 31 ca 80 fa 80 80 d9 00 66 0f b6 d1 e9 ce b6 cd 1b cb <ea> 5b 
> e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 
> 00 00 00 00
> 
> KVM: entry failed, hardware error 0x7
> EAX=00000000 EBX=00000000 ECX=00000010 EDX=000fd090
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=000fd090 EFL=00000007 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> CS =0008 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
> SS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> DS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> FS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> GS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
> TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
> GDT=     000f6220 00000037
> IDT=     000f625e 00000000
> CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=e8 43 3b ff ff 0f aa fa fc 66 ba 90 d0 0f 00 e9 ba fe f3 90 <f0> 0f 
> ba 2d 28 4b 0f 00 00 72 f3 8b 25 24 4b 0f 00 e8 72 3d ff ff c7 05 28 4b 
> 0f 00 00 00
> KVM: entry failed, hardware error 0x7
> EAX=00000000 EBX=00000000 ECX=00000010 EDX=000fd090
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=000fd099 EFL=00000007 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> CS =0008 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
> SS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> DS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> FS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> GS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
> TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
> GDT=     000f6220 00000037
> IDT=     000f625e 00000000
> CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=66 ba 90 d0 0f 00 e9 ba fe f3 90 f0 0f ba 2d 28 4b 0f 00 00 <72> f3 
> 8b 25 24 4b 0f 00 e8 72 3d ff ff c7 05 28 4b 0f 00 00 00 00 00 f4 eb fd 
> fa fc 66 b8
> 
> I'll drop the patch and send v2 once tested.

I could reproduce with / without the IDE patch, and also tried
with / without the I8257 DMAC ones, so this isn't related to this
series but to a flaky CI host/KVM or nested-VMX setup, apparently
tripping when boot_sector_test() starts with 260 vCPUs:

▶   1/388 /i386/acpi/q35/core-count2 - 
ERROR:../tests/qtest/boot-sector.c:166:boot_sector_test: assertion 
failed (qdict_get_try_str(qret, "status") == "running"): 
("internal-error" == "running") FAIL
▶   1/388 
                                  ERROR
   1/388 qtest+qtest-i386+slow - qemu:qtest-i386/bios-tables-test 
                                   ERROR            29.63s   killed by 
signal 6 SIGABRT
stderr:
qemu-system-i386: -accel kvm: warning: Number of hotpluggable cpus 
requested (6) exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of hotpluggable cpus 
requested (6) exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of SMP cpus requested 
(100) exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of hotpluggable cpus 
requested (120) exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of SMP cpus requested (54) 
exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of hotpluggable cpus 
requested (54) exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of SMP cpus requested 
(260) exceeds the recommended cpus supported by KVM (4)
qemu-system-i386: -accel kvm: warning: Number of hotpluggable cpus 
requested (260) exceeds the recommended cpus supported by KVM (4)
KVM: entry failed, hardware error 0x7
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000663
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
EFER=0000000000000000
Code=09 66 31 ca 80 fa 80 80 d9 00 66 0f b6 d1 e9 ce b6 cd 1b cb <ea> 5b 
e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00
**
ERROR:../tests/qtest/boot-sector.c:166:boot_sector_test: assertion 
failed (qdict_get_try_str(qret, "status") == "running"): 
("internal-error" == "running")
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

▶   2/388 /x86_64/acpi/q35/core-count2 - 
ERROR:../tests/qtest/boot-sector.c:166:boot_sector_test: assertion 
failed (qdict_get_try_str(qret, "status") == "running"): 
("internal-error" == "running") FAIL
▶   2/388 
                                  ERROR
   2/388 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/bios-tables-test 
                                   ERROR            43.19s   killed by 
signal 6 SIGABRT
stderr:
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus 
requested (6) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus 
requested (6) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested 
(100) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus 
requested (120) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested 
(54) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus 
requested (54) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested 
(260) exceeds the recommended cpus supported by KVM (4)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus 
requested (260) exceeds the recommended cpus supported by KVM (4)
KVM: entry failed, hardware error 0x7
EAX=00000000 EBX=00000000 ECX=00000010 EDX=000fd090
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=000fd090 EFL=00000007 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
CS =0008 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
SS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
FS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
GS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
GDT=     000f6220 00000037
IDT=     000f625e 00000000
CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=e8 43 3b ff ff 0f aa fa fc 66 ba 90 d0 0f 00 e9 ba fe f3 90 <f0> 0f 
ba 2d 28 4b 0f 00 00 72 f3 8b 25 24 4b 0f 00 e8 72 3d ff ff c7 05 28 4b 
0f 00 00 00
KVM: entry failed, hardware error 0x7
EAX=00000000 EBX=00000000 ECX=00000010 EDX=000fd090
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=000fd099 EFL=00000007 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
CS =0008 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
SS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
FS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
GS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
GDT=     000f6220 00000037
IDT=     000f625e 00000000
CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=66 ba 90 d0 0f 00 e9 ba fe f3 90 f0 0f ba 2d 28 4b 0f 00 00 <72> f3 
8b 25 24 4b 0f 00 e8 72 3d ff ff c7 05 28 4b 0f 00 00 00 00 00 f4 eb fd 
fa fc 66 b8
**
ERROR:../tests/qtest/boot-sector.c:166:boot_sector_test: assertion 
failed (qdict_get_try_str(qret, "status") == "running"): 
("internal-error" == "running")
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

I updated the tag to include Marc-André R-b tags, otherwise no change:
hw-misc-20261124 (new hash 1ce5a76136be).

