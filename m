Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EB606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GTzf6Ikm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WPJJBH8d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSskC-0007UF-Hu; Mon, 16 Nov 2026 04:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsk0-0007Sp-MM
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:11:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsjy-0005el-5g
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:11:08 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG7fD8T904211
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hSKbL+Sq0BZ1UFgcIY+VspDS+bEIssklUfWt7m4DEEM=; b=GTzf6IkmJOvoZbVR
 ctng6ERF4k1kZvZ/9uHssohG+sJRyghSqwBxjbH+okHnGpyVO9XlP6VOp5pyskTj
 qlR3x3G91+4wnsIhXszYhObM4LT84muMaxDG+CEIIExnF4hSUQSoknfoVSNMwFNO
 KexUFb1Sqo8kkeSjo0C2c/Yj+Un6cdQFNXPqkc1Q/aKVjPl2MaFZfU0ow7+fBeHs
 jEFo0xg7O9w5/+YC6r0W9ustdS5pZ6+GmXOmQ97D6kpRsCu/vBEhOScM2LWsm7cR
 GfKcXR1NP+YHIdWeF9cufD5TqqlVkTvYZW5j/JIxhAt5/vC4UezDAdgsP1Byskp7
 H8Q4vw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjwru5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:11:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495c71055bso359430085a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794820261; x=1795425061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSKbL+Sq0BZ1UFgcIY+VspDS+bEIssklUfWt7m4DEEM=;
 b=WPJJBH8dVk3xx3vOJzlCEd56h851wCzd3gBQBK+x+m23T+5wUapI1YWZQVtoGllpuQ
 toQtLxbSCMT6Eo7n7jZybcW5laMiHzI63U5aI9CYfOHfvI92NmJo0FmGxi8ZEIwTcH3h
 hLHxiN89QGwwi9Bvod4n1nZZBAusOh4+S4tULhOwq1HqgGljPDqr/ojx153Po+osXt66
 iKi9PZiz2xVUhtqvGivTaQWsssNvvcAtOoyed/FiwyiC0Y/mWGwu6UVD3MNHBbo8P2ym
 Zgq522X5GdiRnqHQQ8o1FhESbsO15Glb5Xnayw8VJn7rCtNGPENkX6REnHefWu5POW+w
 8jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794820261; x=1795425061;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hSKbL+Sq0BZ1UFgcIY+VspDS+bEIssklUfWt7m4DEEM=;
 b=oKdUcPKeZDO3ysjbC90PAZ2FjTOaTDStet0yOvKFypSjqAzAhvst/sATvZOsqitNZj
 TLI2FsfPG81LcUxSwY5tlhwsnOyc587O76ftyROHXNdi6nxV7RrtdAlnBXOBawEF00G7
 FQgpc/7i0PlZWIME20CjaDWKfI0T8n+nupo4wrI0lK/PopjqdobX+xx0/b+b9yVQSiIg
 9wbEHx+tC0NgzeW+TrKSJBDbq9v/4hBNN/UT5ebAg24JW65zN5L39Og9avIs/FNuGUR2
 J1BctcwaBAC/e27NcIAlPDIgElg+jSxNDekvaTC5V3BZ1fhNpf5rb2VuSmB2MCtdI6M/
 JAYw==
X-Forwarded-Encrypted: i=1;
 AL+hErEt6U75O4x7G+LP+HuZZZamjFat8vKYrPEGjnJVN4sIjuCjBG7zuqw/SSXHsYipKZQ6K/vjqtgtfMdp@nongnu.org
X-Gm-Message-State: APuU4Z9InEJGP1rJPXkTWSkapNoc2E4arQDy71ekIj1fb5+5GaeH1qVT
 ATM5BgmSfl2NscXwHCiufg3VNptdEHpUKtQxcMgOcKRxzQPn/YeDidqSG3QVLOlUGR1oPXO7aMK
 TEJF9GiJcXh8n1s5m29+uT+8r2UGKEvwBUkUQKpXz8ojRjnoqvIh4efhw5w==
X-Gm-Gg: AYBFou31JZoLhG03MznRj5nQ3Zsnk43jruSL4BP0v/aMh4m3sEwxLNj0FnaH0KtC4CF
 yWLEpmxM96Qw7T+mTCD5LwfBGcILd1SMB/gVCl0eR5zWOsrv+tNDrucpZ/kBLqgS5ACRik2Ikqr
 xrxLnwkShOqsQ0FU1PkPXfSc4FAz9f32ni2o7ocsiKaSuUU2kvvoNHDQmvVp2UH9uVm9Lj36eKI
 I6Y5UPWxKZDeI5hE5rNAZM6TJzwfFfeihZyi9nMyw0RbRzHA9f05/W10caNDLhusXZ6GpKHiAWQ
 Ztwe3Dv8+nAWH8QRtl0zo8SNpt5deMvaSHuLxCnl8SmJ7bf16Z7h7GThVmLaXZtiaAZu6ihc2AO
 VoUovf7UOAley6qvCtbx7adeQUHRYfJtSR14OxfFZH0UqptwYn6AsVvq71TeiaGXAYUdkQBHVF/
 lLEAODkQQ=
X-Received: by 2002:a05:620a:29d4:b0:949:70ec:7e98 with SMTP id
 af79cd13be357-94970ec8d8cmr776516085a.40.1794820261202; 
 Mon, 16 Nov 2026 01:11:01 -0800 (PST)
X-Received: by 2002:a05:620a:29d4:b0:949:70ec:7e98 with SMTP id
 af79cd13be357-94970ec8d8cmr776512585a.40.1794820260648; 
 Mon, 16 Nov 2026 01:11:00 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5671059bsm163435815e9.1.2026.11.16.01.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 01:10:59 -0800 (PST)
Message-ID: <da3e7b28-1ac8-4263-ac36-6e97d760082a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:10:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/26] hw/mips: add Octeon III EBB7304 support
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261113214926.98536-1-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX9x/vU2z8GFHr
 STOA9MQ0YClBxwnT66i25wQCcmLJSSD3PsAgufMmzm0QU1Fp2kAapwT0bR+8Lb5HGFt3VE6hx6o
 UJ2BGqcGFIGF+/jivwZ69ZEJwk2DXe2NcjgAPho2W8lX0Em5X+PsqVvtYBaoW177twuqruX+6wS
 xAKPewjJA2iMu2AbJ+G6nyNyyHlfEzLissde+moFJIMssY6SLnRRVBPotE+3KmldGNC/tmkk7VT
 RBj82frDB/yHtcF6SowtnI6smhPfkya1Z9mLQaNJL/EI46SXWJkKHSy53FuW61kJCL4O0Wp+Rq7
 l4uorxY+WuaKQKncz+qp1XZEhPMaXQh2yxsQT7OielCDczjs7sV75XjX5745cvMY6fwq2U1PSgP
 LRcAMQPJwg5usZFHUIy+ELwxpkVlSzo+dwCWZ6+NOLVTtHaMDeDAZC4mOPF/lXy9MTGKPvP8wv0
 ZwB8XZYhJnORF2+sH/A==
X-Proofpoint-ORIG-GUID: p_J0Lsh9O34DhoL7pji7xnhcGnrBfnli
X-Proofpoint-GUID: p_J0Lsh9O34DhoL7pji7xnhcGnrBfnli
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX3x7m9+pcDMcc
 GfYhkxwpnuaqpuBudvrEsSKPugYedtN983epX2GW2xLxRqirAIOWGg1H7JUmsI3HLx3Klsu762U
 SC5QIuhHvKJoRKmRX7hXBxNTo2b9FSU=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6afac8a6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=GaQpPoNlAAAA:8 a=EUspDBNiAAAA:8 a=eEnIh0Fi-7NRnJ4LqJMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Kirill,

On 13/11/26 22:45, Kirill A. Korinsky wrote:
> Greetings,
> 
> This is rebased to 29760efaf96bbe5928f8111881eddbf5ac06439e
> (v11.2.0-rc0) and addressed a few remarks from Philippe Mathieu-Daudé,
> and additional fix of two typos.

Thanks, I was reviewing v7 last week and you respan faster than I
can process. So far my first comments were:

-- >8 --
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 5e4341003ae4..c86e0d6ecbea 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -47,3 +47,3 @@ void mmu_init(CPUMIPSState *env, const mips_def_t *def);

-uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val);
+uint32_t compute_pagemask(const CPUMIPSState *env, uint32_t val);

diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index e9e233d3b366..ecf9109a4576 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -144,3 +144,3 @@ int get_physical_address(const CPUMIPSState *env, 
hwaddr *physical,
          address <= 0xffffffffffffbfffULL) {
-        MIPSCPU *cpu = env_archcpu(env);
+        const MIPSCPU *cpu = env_archcpu(env);

---

And rdhwr_cvmcount() breaks all non-Octeon CPU models.

Please list the change between versions in your cover letter.

> This series adds enough Cavium Octeon III CN73xx and EBB7304 board
> support for upstream U-Boot 2026.04 to boot OpenBSD/octeon from USB
> storage or through PCI e1000 and TFTP; the same machine also reaches
> the prompt of the vendor U-Boot 2013.07 image from the Ubiquiti
> EdgeRouter Infinity ER-8-XG recovery set. The model intentionally
> covers the hardware exercised by these firmware and operating system
> paths.
> 
> The vendor recovery image is U-Boot 2013.07, UBNT build
> e1000_002_ef3a9; it reaches:
> 
>      Octeon ubnt_e1000(Failsafe)#
> 
> This is the expected command prompt of the recovery U-Boot environment;
> "Failsafe" describes the recovery image and does not indicate an
> emulation or boot failure.
> 
> Early Octeon investigation used Amir Mehmood's original Octeon
> host.patch as a behavioral reference; the basic machine approach and
> several hardware model ideas come from that work. No code from that
> patch remains in this implementation.
> 
> The series starts with three generic MIPS correctness fixes for MTTCG
> interrupt state, MIPS64 segment checks, and architectural tlbwr
> replacement semantics. It then adds Octeon CP0 state, the CN73xx CPU
> model, PageMask handling, and unaligned accesses before introducing an
> empty EBB7304 machine. The remaining patches add the machine state and
> peripherals incrementally, followed by the functional test.
> 
> The machine currently models:
> 
> * the EBB7304 RAM layout, boot flash aliases, and boot-local RAM;
> * CN73xx CPUs, Octeon CP0 state, CVMSEG, and configurable clocks;
> * reset control, legacy CIU and CIU3 interrupt routing, mailboxes, and
>    secondary CPU release;
> * UART, two TWSI controllers, synthesized DDR4 SPD, four LMC register
>    banks, fuses, RNG, POW, and the firmware probes used during platform
>    initialization;
> * the EMM registers needed for firmware MMC initialization;
> * two UCTL-wrapped DWC3 controllers, sufficient for U-Boot USB storage;
> * a minimal PCIe host bridge, sufficient for a PCI e1000 device.
> 
> The functional test starts upstream U-Boot with four CPUs, enumerates
> PCI, obtains a DHCP lease, downloads bsd.rd through user mode TFTP, and
> boots the OpenBSD/octeon 7.9 installer.
> 
> The OpenBSD boot and USB stress testing requires additional patch for
> xHCI which I haven't included into this series:
> https://patchew.org/QEMU/20260719215455.96122-1-kirill@korins.ky/
> 
> Each submitted commit was built in sequence and given the meaningful
> smoke test available at that point. The final tree was tested with:
> 
>      ninja -C build qemu-system-mips64
>      gmake -C build check-qtest-mips64
>      gmake -C build check-functional-mips64
> 
> The machine was used to build a few GCC build and full OpenBSD/octeon
> release with LLVM inside OpenBSD/octeon using:
> 
>      -m 32G -smp 8 -accel tcg,thread=multi
> 
> The longest non interrupted workload was near two weeks.
> 
> Known limitations are:
> 
> * native Octeon Ethernet is not modelled; the OpenBSD test uses PCI
>    e1000;
> * EMM implements the firmware initialization path, not a complete MMC
>    data path;
> * direct kernel boot through -kernel is not implemented;
> * the newly modelled board and peripheral state lacks VMState
>    descriptions; migration and savevm are not expected to preserve the
>    complete machine state.
> 
> Patch layout:
> 
>    1. target/mips: make CP0 interrupt state atomic
>    2. target/mips: fix MIPS64 segment access checks
>    3. target/mips: drop hidden TLB shadowing for tlbwr
>    4. target/mips: add Octeon CP0 register state
>    5. target/mips: add Octeon CN73xx CPU model

I ended adding the CN71xx instead which is the one I could test,
why start with the CN73xx, do you really need this one?

-- >8 --
target/mips: Add Octeon CN71xx CPU model

Add a model of the Cavium Octeon III CN71XX, as found on the
Ubiquiti UBNT_E300 (Linux 4.9.79, "Cavium Octeon III V0.2 FPU V0.0",
MIPS64r2 with VZ). Values read from that board:

   PRId = 0x000D9602 (ProcessorID 0x96 = CN71XX, pass 1.2)
   FIR  = 0x00739600 (S, D, W, L, F64; no PS, 3D, Has2008)
   FCSR = 0 at reset; ABS2008 and NAN2008 read-only 0 (a probe
          writing all ones except Enables/Cause reads back
          0xff80007f)

The remaining CP0 fields are copied from OcteonCN73XX, which already
matches the CN71XX hardware manual (CN71XX-HM-0.991E) except for
Config2.SS (secondary cache sets per way), which the manual gives as
4 (1024 sets) instead of 7.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 7f7a33c5e5a1..45974da950c8 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1117,2 +1117,50 @@ const mips_def_t mips_defs[] =
      },
+    {
+        /*
+         * Based on register reads and write/readback probes on a Ubiquiti
+         * UBNT_E300 (Cavium Octeon III V0.2) running Linux, cross-checked
+         * with the CN71XX hardware manual.
+         */
+        .name = "OcteonCN71XX",
+        .CP0_PRid = 0x000D9602,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << 
CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT) | (1 << CP0C0_VI),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (6 << CP0C1_IL) | (7 << 
CP0C1_IA) |
+                       (0 << CP0C1_DS) | (0 << CP0C1_DL) | (7 << 
CP0C1_DA) |
+                       (1 << CP0C1_C2) | (1 << CP0C1_PC) |
+                       (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2 | (4 << CP0C2_SS) | (6 << CP0C2_SL) |
+                       (7 << CP0C2_SA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |
+                       (1 << CP0C3_VZ) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) |
+                       (0x3c << CP0C4_KScrExist) | (1U << 
CP0C4_MMUExtDef) |
+                       (3U << CP0C4_MMUSizeExt),
+        .CP0_Config5 = MIPS_CONFIG5,
+        .CP0_Config6 = 0x0800007C, /* Octeon III CVMMEMCTL2 */
+        .CP0_Config7 = 0x000FF0FF, /* Octeon III CVMVMConfig */
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .CP0_PageGrain = (1 << CP0PG_ELPA),
+        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1U << CP0PG_XIE) |
+                                   (1U << CP0PG_ELPA) | (1U << CP0PG_IEC),
+        .SYNCI_Step = 4096,
+        .CCRes = 1,
+        .CP0_Status_rw_bitmask = 0x74F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) |
+                    (0x96 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 49,
+        .PABITS = 49,
+        .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
+        .mmu_type = MMU_TYPE_R4000,
+    },
---

>    6. target/mips: pass env to compute_pagemask
>    7. target/mips: accept Octeon PageMask encodings
>    8. target/mips: allow Octeon unaligned accesses
>    9. hw/mips: add empty Octeon III machine
>   10. hw/mips: add Octeon CPUs and boot memory
>   11. hw/mips: add Octeon reset controller
>   12. hw/mips: add Octeon CIU3 CPU control
>   13. hw/mips: add Octeon CIU3 interrupt routing
>   14. hw/mips: add Octeon legacy CIU
>   15. hw/mips: add Octeon CSR window
>   16. hw/mips: expose Octeon reset CSRs
>   17. hw/mips: add Octeon MIO boot support
>   18. hw/mips: wire the Octeon UART
>   19. hw/i2c: add Octeon TWSI controller
>   20. hw/mips: add Octeon EMM controller
>   21. hw/mips: add Octeon LMC controllers
>   22. hw/mips: add Octeon boot support registers
>   23. hw/usb: add Octeon USB controller
>   24. hw/pci-bridge: add Octeon PCI host bridge
>   25. hw/pci-bridge: add Octeon PCI memory window
>   26. tests/functional: test Octeon III boot

