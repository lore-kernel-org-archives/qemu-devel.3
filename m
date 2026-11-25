Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBEE606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BUV60vB/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNkxFl8T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW7C5-0003lf-9f; Wed, 25 Nov 2026 02:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW7Bu-0003in-DZ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 02:13:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW7Bs-00023d-Dv
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 02:13:18 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP68TAw3534167
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 07:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1rTLCdLSfx61MhDCjsM8d2lq+m1242/nF6RKOsZmgoY=; b=BUV60vB/6bMLM8lA
 P54SGyUSJBZc/4kYyxrZh2DMlRGsweLcM+hP++wGCNiXZ7+7EJSu7/Tt00xmcKTK
 EKpNHNZKTN0b1iU0TF/0CMfY3Nt19YjxXzO/AQ6O8bpgxB8xRJhJEDQYAQPwiQhO
 LN2dzY4JAyC8EetIKmgSJmpy4wRc+2hpZ1gj+SnhhEPrTEciUVqTGf1mu60L/yrq
 +A9z2so1dc5c3Dxw1N8rF6fFA3BwGo2bkAmNpPYX5l6nkWWqYEtoHNocNoVyIRbK
 glNOMeRE3o7AZrobqmjYlsazmGrJRBfDajWW7Fh/JiqfKPTo/59vSnwQpxB//xnS
 qQ4DzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbhbrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 07:13:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94960131b4eso124603585a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795590791; x=1796195591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1rTLCdLSfx61MhDCjsM8d2lq+m1242/nF6RKOsZmgoY=;
 b=cNkxFl8T4QBm2qYYnoDgH2xw0VzwgRYD6r1BmNljRsjfhWK7TOM7GhyHETBlvXPBtP
 V8Rnwt2PmusgXjfQyct5tpm2Ft0PInoiXG7U3pahTxE46WI+F/MHwlhJPodyORy4oL4c
 itB4Y8V3NV8inpNpoXIFKBCnEzbwTxVLDqCSMU7CYTtDJv59RHfyjahJ4cCNnyOO7iix
 kOzddOWakXrFn31YcF7Nebikd6YtIoUcgjNNshY5oeKJLYA+1ScbFxRit2+mU4PGWPUh
 juv1UXeqghnIzi3VXf4GE5w8KJURouGlnkwvXMEhhKb+LbjPZ5EEp/jIaiE6d7vxKwMb
 weHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795590791; x=1796195591;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1rTLCdLSfx61MhDCjsM8d2lq+m1242/nF6RKOsZmgoY=;
 b=IGRg06uzJcqraeKiHN3XXqt6C3UVw4KvCPdOwwWZUiBc4yfE1MRxCd4yE9ur/dBMcd
 CNUji/P28G2duOp6S6G29sWBQ40a5fzoZd4EaWh/a3hqh6oJvt93rdc1QUlvQOh3xxFb
 /9D1pHo+PfhqoFBjqTxO5nrJJD3vYcQd0MkvMKaQ0GEHjJ5fF4qaD09f04gEUevmjJ3Q
 G6l3AlQuIFCSkfTxMD9THyZMG1M1LRaSzv6tDcYP13mikjHEhfUMxA1g18pn6jJgAK8K
 HZ9PruLglA22OfJQLoiDYDMlVeqnkwN+oqi5neNXp933vG4okwGxwe3j4xLtNAMzCcPS
 oNGg==
X-Gm-Message-State: APuU4Z/03wlLEqFdGFxTrKOpDidjDTIAGyzvINUVpsWe3nkfkQFO6hy6
 YkkxIKyZgcQAtZQHRbMACJIUC013QmxkhwA0CNB8XCek3bVj3xB8/mv+u7k/ytuiuApySLZxUWC
 M9I9BDI2YCwHOOJA39nxGmedbEoXpCEB7GP4NTveyCoykc61LZEEEgib6XBln/FX+vMVA
X-Gm-Gg: AZFdTZdxxNPfoTQmApead8VmebZYKZ/WRQ1SjVT2HCJq598UU3xfbtizEEn5USxs2aL
 TmPPB72E2q+vpqx04IrOKaHL1uYmG8rp4MFxMrAKJNTEv0xnHAng/5yd4u8TKvVfBCHzxDi6LSe
 t+d4WEyLwSedb6Opy9OsnPy2qtn+9enNi2sQ3khFk88KA9KIDG7PqQbGonP5L8k7OH62eTinyV1
 19LeV/9qqSU+Dv8WpKi1mv0aX+/f4a792YHNpdPKSQ800IhrASvm2amihSdlC6epQqZ+HdKipMh
 b2r3BkV9NOkH4Ksi5z2eiK54Dxn/Hnf4IQWW3HgK5pFUGbefwzW9NL6K3b1+QuRrW9GvP8kwo1Q
 nwRsd3DhLBhdqzpaIb5xM9nlLc4GITrieMrmyNfxImG4aYS8tZVN9ZwFgV5B8JpMAO/vmiEHVmo
 7Bxmmfoyw=
X-Received: by 2002:a05:620a:2886:b0:93f:707f:28d2 with SMTP id
 af79cd13be357-949ba9b83f3mr3039647385a.26.1795590791100; 
 Tue, 24 Nov 2026 23:13:11 -0800 (PST)
X-Received: by 2002:a05:620a:2886:b0:93f:707f:28d2 with SMTP id
 af79cd13be357-949ba9b83f3mr3039644785a.26.1795590790639; 
 Tue, 24 Nov 2026 23:13:10 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399e2esm555198055e9.7.2026.11.24.23.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 23:13:09 -0800 (PST)
Message-ID: <903cd807-c7ce-4d44-ae74-aa81289a887a@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 08:13:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Misc HW patches for 2026-11-24
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfXz61a7JG5luX5
 mYEcsNN7SmBzC1HZ45g9sCZ+PkNts0R3u5OByI1xj88L8nBZ+tXC/Cj5Ajblm6YTBdMrvIvDcHv
 KOqLF7wEMXNaSdo+A8R3pAfP3KGRoyE=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b068a88 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=aREHiMvZP0Ng0lgZy2sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfX/ydzSnTwE98p
 8OZQBsxYQm++4DBw59bb3pw9S68KQEooZECV/7miexKOyqwE7Nyr3iC8qQXDsfFYqYqDCAgXJ6g
 ccueNab47M6fithCK0+Snz8BAoG2Bp4zbIM7OxfGcssPAzObCR6Gy9n+TnOt5ssmcMzQx8Z4RrW
 SlP/v0XZNLox4LkfCjddWBBOtA9Npaki6+PzHeVJSA7IXdMUIFMrqJZg90fJN9qpQfz75zUgFIv
 rx1Gc/FUW1KJAFXsf0d50ZwKwnRCr8JKWQGQo3MBz5IkGKbmxiS1LXJ1IWsDfCeesgskqja25E5
 CpTR7EATLUAhx7D+XxM0GA6H4bnHzcoELxHSCoanudDsHJomOhs6Ak+zpn50qn91jj3pXfJ0xj3
 WakbJQYzf3JjA6EDsAeRX+Y/KaxfREWzJxJBD5SXVRDQs2VMYV/XBbY5afe0t0y1W/rg459r4iq
 lDAECWKctarvAlQs+Aw==
X-Proofpoint-ORIG-GUID: WXjfWnfUXMGwAu6FzTRFDb7YxM7s4bvr
X-Proofpoint-GUID: WXjfWnfUXMGwAu6FzTRFDb7YxM7s4bvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 25/11/26 00:09, Philippe Mathieu-DaudÃ© wrote:
> The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
> 
>    Merge tag 'pull-target-arm-20261124' of https://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20261124
> 
> for you to fetch changes up to c3800302668ff745e10b810f12723eac7068abda:
> 
>    hw/ppc/amigaone: Invalidate TBs on NVRAM write (2026-11-25 00:02:01 +0100)
> 
> ----------------------------------------------------------------
> Misc fixes for 11.2
> 
> - SD (card, controller)
> - VMWare VGA display
> - Parallel NOR Flashes
> - I8257 DMA controller
> - IDE ATAPI layer
> - Amiga One
> ----------------------------------------------------------------
> 
> Denis V. Lunev (1):
>    hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31

Please drop this PR, there is a issue with this patch I missed
earlier:

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

I'll drop the patch and send v2 once tested.

