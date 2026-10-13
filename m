Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B51CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfC0-0001do-KS; Tue, 13 Oct 2026 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGfBs-0001c7-LK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:17:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGfBp-0002tx-9P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:17:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE422x615635
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HkEV0KD3Yy2mDb8vl6QacftZwQHn3hdcVj9AFUlU2cY=; b=em4ehRpamqJ8gLHA
 2oANGKcIRYcK6ktBxaudezKDgilqpqP1w7HJOHtZzbbg10swkPf+Ae972fVvD3tL
 Erot1IxhsKHPuX4frrx1OSTR4/c1h2w5BOMxXU0B0G9OBeiclFNZFMAqrBcgkYIT
 l6wgUph9Xkr52CMoTYC9JKfCQInb8+y9h17qArldhQdD3ZYNYpdRUFTuBdl37cXz
 R67+UCpiyehMmEGONfswrnsgvppC8XbmuxIwR1X/T6/SiLbHcE1kQHdFFv2laF8Y
 LTx57Jv6VC6tvYBaRwPO56U38FTlAWIo7VBUbhQwzJ64iDkmqG1dcHwMIYip2vGG
 lyOXFg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7jb2f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:17:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a082c014aso21975985a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791908235; x=1792513035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HkEV0KD3Yy2mDb8vl6QacftZwQHn3hdcVj9AFUlU2cY=;
 b=jcZs2bTKPjl9OJpX6kcF83seNXLQqZ5qCW5vd87ITyXjM5Si12TwCyyL8DoloGpNCz
 e9cYWotM34yyDkpKTc1GtqscRs2IsXqwamUjl189V6gX6046tfCY+QPG/8r7ETIzrecr
 /jCyDGupnxQuPAK7Rmt47lnp55wNFSUCHTtoocCM9XQRxtr7b8c77IoRZC5RihTwQ4//
 mht1a4/O7gYIKmPmmxEhqHCOCY2RA5DnpGUOCXx6UbgV/XW8wiCTz+CZh3P3FMTgxo9U
 N9sIVTL/17rXZcv6W669XJYw8Qucp73OvcMi+0eUsrs0FiyXjmGTLhNvFo5xxWenOMC4
 35KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908235; x=1792513035;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HkEV0KD3Yy2mDb8vl6QacftZwQHn3hdcVj9AFUlU2cY=;
 b=wHXDUm3Rj4Ri0CXCvNhBKynoreu2sYq1K9VQ2uIy4h1UI5d8n692sH/cOdpNJoXkMU
 4dR4FMSZVPxeiwNuGTRFO7UH3+nlKL+/llazzoI9vLo61NcZZWkcxPHFdpH0gOF8Mgh7
 L8kV1pvm7qry56ZQ57TqWJkv/Ysq9gUgRUiJFazvOwnEGWcxzgcuwwqK1kieDRBZUlRc
 L3F35U8VSpPSPaSGV7KEqghQ8aSM3kBYpUK9/sf4CaHSXv9xD0h7L8QFzcz2Z7xbdWyk
 4rQEHEzyvkzzlkqehYb1yDmofIItjz9IeDyHiLbcUsRtzScY+ukEUjB3/kx35ijIhTKr
 bz1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByZLDhKogySnMqIL6trMclEOdAvt4z4jJMditIVkvPA2uvXeLSJeExGHYwuCXwbwOBTFMcnkg+JG4g0@nongnu.org
X-Gm-Message-State: AFq9FYL5aBksfUL4JUvduVzPGR8qImLwnU+PvBzIwIQiAFfBmhLT9RBE
 /vJP2k/LjNFP0biCndcg457HeVpMkFnDepeOkLfs5F9E8fCK6pKdnLmKBV5ld1/1iYSIoFSDu10
 /LyqZ8F6UiphdpQSxPHYzcmppNrvX6hDkZsAieW8CmkxFcJq9Mmg/QGBx+A==
X-Gm-Gg: AYBFou2N1aMIP3G8lpkRlfvfi2hp1VT/Jqjk1Hjt9YfcWWbg7PA8TIyJriL7IR1oy45
 LWgKzpsCGRplP3xljLulfo3fdRfMM1oZribKg5tFW8F8NW4xx2WmzNRXDqpFbYJnziopwRybgTQ
 bdb7rMv+WhccCjYaAuiCzDhYyW0m/uZQJLLTlp2bjpKRPfl9RiZ/r2SJyxx4v00LsQKLazaTRO7
 co3FPlcZpHzRWDLIa45aTq633/XWnE5VsEhgIQMjiyrPz1D1fIlyvSScqKaO2WHhTjaqQd+f7CI
 1QdSgOpxUPUCMqRoha7kZ3RFZTzVbtYL+9FH0qja/EOcg7E8Njc7HV3dq2U0hvKXMXtHrh0iQZ5
 T2LuCdulEIS+ES70d9vWVXQ==
X-Received: by 2002:a05:620a:40d2:b0:93c:7861:675 with SMTP id
 af79cd13be357-93eb93ef2cdmr2053519285a.1.1791908234525; 
 Tue, 13 Oct 2026 09:17:14 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93c:7861:675 with SMTP id
 af79cd13be357-93eb93ef2cdmr2053515085a.1.1791908233918; 
 Tue, 13 Oct 2026 09:17:13 -0700 (PDT)
Received: from [10.111.130.93] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa9f9sm6200038f8f.19.2026.10.13.09.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:17:12 -0700 (PDT)
Message-ID: <eea8bfcd-f1ab-4397-bc1b-f770ca7caaa8@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 18:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] hw/core: Introduce Remote Port Co-simulation
 Protocol
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S30Dm6yul-o-pxFfyjb37DqvQY3fkun6
X-Proofpoint-ORIG-GUID: S30Dm6yul-o-pxFfyjb37DqvQY3fkun6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NCBTYWx0ZWRfXzbkUD7R5WorL
 Uq2XGraZhXnslU73V8Shxe2guu04Y8E1IHYKO1TwVu4m5TAYcfsQxHaNSMn1pml93L57HPgsyqh
 zC0hcQydOsUYoDcttJfNw6gOt/58/Yo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NCBTYWx0ZWRfX46lPOdRazQMC
 nFP7HCTSecdgtJeqtoHD1KFvzLaOm9ezVYWjs1N9SupeUg8F4nuOlDe6b1wZ1ewXH82cYUNY3j7
 85GQQi0pUXXjZ472HZ2VECjIcC2JfoXiYozSunkcpaakgiPhRWzum1X5FH3T0zI+kroEsLe9xPA
 DlcfQQwfX8BddHXk4COPKy5/CLlc/Eb329fT3wfPFLnVcUzBNEAErhELThuqG6j1vLU27xYmwwJ
 C6qZYjM4Pe3Db/9SXzf65+T+1J5PguXZX8+Vf7xe4i8pRuUUWWGnsLidblrrCnSj/lYvKnx+QEi
 51Jw9DJWHViEMK1kSFk2FerjT1MP9AcRsg2Ykf+26ueT0clUnIUmBiWHbteAZ+ITKX3xa3WAs45
 hdgSmgzI6Buh4TiCGBHJPL6cpLSovI3K0+XKuwtbUThETfgYKo30deVaRJfSDzFwxfNBmhQdEDx
 XFOK2JnyTBGa5mG4XlQ==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace598b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=69wJf7TsAAAA:8 a=NEAV23lmAAAA:8 a=javpHEMGAAAA:8 a=DBfv99YmAAAA:8
 a=Zv_7PsYmnftF76vf0H0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=UTe8bF8JKSS6dPDzRicV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-09-15 18:00, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> This patch series introduces the Remote Port (RP) subsystem, a framework designed to connect QEMU with external simulation environments (such as SystemC models or RTL simulators).


> Motivation
> In modern SoC and FPGA development, specialized hardware blocks are often verified using SystemC, Verilog, or VHDL long before silicon is available. While QEMU is optimized for high-performance CPU emulation and software development, it requires hardware models to be rewritten in C, which is time-consuming and duplicates effort.
> 
> The Remote Port (RP) subsystem addresses this limitation by enabling a Co-simulation environment. It allows QEMU to act as the high-performance Processing Subsystem, booting complex operating systems (e.g. Linux), while delegating specific peripheral modeling to external simulators (SystemC, RTL) via a socket connection.
> 
> The Remote Port protocol provides a socket-based interface that supports:
> 
> Memory Transactions: Bidirectional memory accesses (Master and Slave) allowing QEMU to access remote devices and vice versa.
> Interrupts/GPIO: Propagation of interrupt signals between QEMU and the remote peer.
> IOMMU/ATS Support: Support for Address Translation Services, allowing remote devices to operate correctly behind IOMMU.
> Time Synchronization: Keeps QEMU and the external simulator in sync by advancing time in fixed steps (quantums).
> 
> Integration with SystemC Ecosystem
> 
> To connect the simulation side, the open-source libsystemctlm-soc library [1] is used. It acts as a bridge, translating Remote Port protocol packets into standard SystemC/TLM-2.0 transactions [2]. This allows users to attach existing TLM-2.0 compliant models to QEMU.
> 
> Architecture Overview
> 
> The series is structured into the following logical components:
> 
> 1. Core Protocol & Infrastructure
> 
> Establishes the socket connection and handshake (Hello protocol).
> Implements the packet dispatch loop and thread management.
> 
> 2. Memory Transaction Support
> 
> RP Memory Slave: Allows the remote peer to initiate bus transactions within QEMU.
> RP Memory Master: Represents a memory region in QEMU that forwards accesses to the remote peer.
> 
> 3. Address Translation Services (ATS)
> 
> Implements the logic to handle ATS requests from remote masters.
> Integrates with QEMU's IOMMU notifiers to manage translation caches.
> 
> 4. Device Tree (FDT) & Configuration
> 
> Added FDT support for Remote Port Memory Master and GPIO
> 
> Dependencies
> 
> Patches 19-20 in series are based on the following previously submitted series:
> FDT based machine v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg00415.html
> 
> Instantiation of Remote Port via FDT also registers its reset handler,
> needed to start protocol thread.
> 
> Validation:
> 
> The Sample Project demonstrating test setup with QEMU/Remote Port and SystemC emulated PL011 UART module available by following link:
> https://github.com/renesas/SysC_Island_MIT
> 
> 
> Patch Summary
> The series is organized as follows:
> 
> System/Global:
> 
> system/physmem: Add ats_do_translate helper
> 
> Remote Port Core:
> 
> hw/core: Add Remote Port protocol packet definition
> hw/core: Add Remote Port header helpers
> hw/core: Add Remote Port session state and hello protocol
> hw/core: Add Remote Port object skeleton
> hw/core: Add Remote Port protocol thread and handshake
> hw/core: Implement Remote Port response handling
> hw/core: Implement Remote Port time synchronization
> hw/core: Implement Remote Port irq, sync and ATS helpers
> hw/core: Add Remote Port files to build
> 
> Memory & Bus Access:
> 
> hw/core: Implement Remote Port bus access helpers
> hw/core: Add Remote Port Memory Master object skeleton
> hw/core: Implement Remote Port Memory Master bus transactions
> hw/core: Add Remote Port memory slave device
> 
> ATS & Streams:
> 
> hw/core: Add Remote Port Stream device
> hw/core: Add Remote Port ATS device skeleton
> hw/core: Implement Remote Port ATS logic and cache management
> 
> FDT & GPIO:
> 
> hw/core: Add Remote Port GPIO/Interrupt bridge
> hw/core: Add FDT support to Remote Port GPIO
> hw/core: Add FDT support to Remote Port memory master
> 
> Links:
> [1] libsystemctlm library: https://github.com/Xilinx/libsystemctlm-soc
> 
> [2] SystemC TLM description: https://systemc.org/overview/systemc-tlm/

Re-ordering this series logical groups and the internal
QEMU APIs used:

[1] Protocol and transport

   Patch 1-4, (5), 7-9, 17

[2] Memory management

   Patch 10-15 — Memory, address translation logic and cache management

   - get_system_memory()
   - address_space_init()
   - address_space_destroy()
   - address_space_to_flatview()
   - address_space_translate_internal()
   - flatview_to_dispatch()
   - dma_memory_rw()
   - ats_do_translate()
   - iommu_notifier_init()
   - memory_region_get_iommu()
   - memory_region_get_iommu_class_nocheck()
   - memory_region_init_io()
   - memory_region_iommu_attrs_to_index()
   - memory_region_register_iommu_notifier()
   - memory_region_unregister_iommu_notifier()

   - sysbus_init_mmio()

[3] GPIO and IRQ management

   Patch (5), 16 — GPIO/Interrupt bridge

   - qdev_init_gpio_in()
   - qdev_init_gpio_out()
   - qemu_set_irq()

   - sysbus_init_irq()

[4] QOM and QDev glue

   Patch 6, 18-20

