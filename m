Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4B6CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCNi-00023n-K4; Mon, 12 Oct 2026 05:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGCNZ-00023K-HF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:31:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGCNX-0006Mr-Lc
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:31:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8ckd9955321
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TX/7V7xOoiIPdv1vbvtIuRfbrLc4dgAZqSMhUWTu3CI=; b=g4m7BGnTd4wJxui2
 avPFPBkL+3asLbKK270Dw8BpQGTG4DePkYo5JA5BPriA/ZjTSZzNeKguqs9OI1bm
 X4wAXYFZW7vfEY7sEWwfiT3D6O6abflC8ioEHI/pguHECG1C+exfLK+e638JDVXh
 uxhrjo141SqT5CBn4VAApezyGHlGSpN5vPf4vB5fBzkqbPIx7UVgdkerJQhr6cA4
 kIAIODVjerLzItL4DonyKVo5zktUdWgWGcq1Wk/A41/o9HAlDbT42sm3cQGfCDs9
 3q6pGhVrU5gniaSb/VtJWok831m+yX61t2/MgnlP90qDQrZl8yoUmqQTjEdovOUR
 C1d4xA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7kr764-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:31:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a556c43so40567646d6.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791797487; x=1792402287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TX/7V7xOoiIPdv1vbvtIuRfbrLc4dgAZqSMhUWTu3CI=;
 b=OM1Jfvjp3PAUKa6OZl3okongKv1qrjIVyE2tOJ+Fsu9dvWLgzu1nCdV6YoD/RCiih7
 EvC0ypwyFPQfUxvQepThcGq3Z9vuswoafEF0w5At93micH/vI0l/zCR4L+UoB24zdMm3
 akVmWvm3RbGGAXHDlNGbX7IL35YwVyzRzOJIBVPjB7hfVlzrf5Y+I5p7obUb0q7S6oTY
 Q+yO9SipEafMyEmwdNnny8xSPxm9NKmQSiV1KCcCPPlNW2WMlAadXCriYr1s9lK/5cOd
 X4Y8VRxHcrOfpytORmfooPG8fbEOgi7CR2qSQZc4w/Gh8zhkmYtLGBBkPCo7+deivmR0
 xqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791797487; x=1792402287;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TX/7V7xOoiIPdv1vbvtIuRfbrLc4dgAZqSMhUWTu3CI=;
 b=uz16IpXHdsyoSmV8dB9u66g2mkMZKTS845l1Af3IlGzt8Q0Qf15XPFHkMN8650aadl
 NSSsK4C5snpzmXa6Ef/hkXcdB8qAvj/OvlhH4khob81VAKSv8S02wg1AHdNOPUAu1yLk
 /pzPsLzzEtobCIVmL0tCisKrGZaau8Icn36EkT/HBURKaU1OMdCJCdiPSMYVBE8UtMAR
 Zxk8nd6IMXDn8CieEDGVyJ+Xn45FruTHmkKcbv+24FlE3dfus+TGruUXQo+Pw1DwCDBh
 mewghiT/kGgRAIPkWgHQkckcHpKlKDeQLzUhsq8U/0mzWsarTHrcgAMVwEp1D8b63frT
 xJRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBybOYoAhLi1IeOpsB0IafElsDOdgO0XZ4ncSds1WY6zgzctnvzvOWigX1EWyffchfpobqBe6rTyI9Ht@nongnu.org
X-Gm-Message-State: AFq9FYL5GCeYqY3H79c2ej+VuJVgASUjc8o6S7ve+xuNfgWmDRnNel+T
 TMsEX9eTR8hSH7XF1szbnALexnycCQzcP8HJXTUDS5VO5xTqBwZdWtzriYaIDcSMQ02rkJlHKA4
 tArHJYEe9O2i58t/uV5PYuanCPpfLloyIyGVTqrJtB87Bn4nU/k9LhNpVCg==
X-Gm-Gg: AYBFou1ahS5OVf5N2Sor5WYo1lD6tE7RSXvhAIdSny5IuEeyWxqlakKkGWDn5Y8QBWO
 x55ay9utVwg9z0IV6pdfKLggG3bucEX7SmJybZ0J0DVY3qTI8a2+G8UYNIVQFmoOWMBr8u3mGbf
 jLNkelMdq5XOJQMXQrldbEoqXiC7DPAhFJ+3c9/WH/wE1x6KGU+49Rvp3YXLPLUHcg13yrZZ/RA
 ujUuOE82d490MpnCejF2p22wqYXsGsoB9E+Vip7sj5iFMCPFvLZAtoLKd81QN3sVQByJ3LYg5KV
 LQtYynd2iDVvShAMT53/EmuT9iihW53flTrl7c8/B3ZyJDj8OaMrE+Ogck8IC9/8b5VWaHwJto9
 l+OvDaIkNBS2GUiG0V9+rbY39v6Dk+Y177xk=
X-Received: by 2002:ad4:5943:0:b0:91b:5d3b:4aca with SMTP id
 6a1803df08f44-91b5d3b4df8mr157364466d6.51.1791797487530; 
 Mon, 12 Oct 2026 02:31:27 -0700 (PDT)
X-Received: by 2002:ad4:5943:0:b0:91b:5d3b:4aca with SMTP id
 6a1803df08f44-91b5d3b4df8mr157364256d6.51.1791797487075; 
 Mon, 12 Oct 2026 02:31:27 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b815fd211sm21655216d6.48.2026.10.12.02.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:31:25 -0700 (PDT)
Message-ID: <03ec34ad-6dcd-4ac2-aed4-65b03cacc775@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 06:31:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/qtest/bios-tables-test: Allow PPTT for RISC-V
To: Sunil V L <sunilvl@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Drew Fustini <fustini@kernel.org>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
 <20261011182552.1071742-2-sunilvl@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261011182552.1071742-2-sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNyBTYWx0ZWRfX4RYzvEe6qbWL
 b7xh8U6eegRE7ViLOlwPZtc0dwMsNKomGEkSr5kBQ/qD7kYtHjINBBAeSNXupBxSRCtZNhk+9y7
 0dJROqSWLRznMxk7ZIBzK6fjVOZmRU9nAHULY+DNGpljSNBu+AG4AFHrq5Y0LdNfpPJ8hpZtwe9
 oCq8sudGmZv70HHcu5LP6LbFWo2r9tngyfcbvftJCVfOrSpwr4gU26VmuZUe0UoPUSHJq+q4q+2
 pAKiUEaa7oPVSKbDAPHLTcaDbsp3FfiZ1Nl2c9U0De6hRk78gzWT0zIxFHANV1+u9MgRheAfd8W
 wXCvAYWOHTqoRCGxeHdvuUBbJ3KBxlJn0hi6QpyOtvGZgZeZCspD8+2DYFf7mxv98U6WcYumhqc
 CH94t5f40U2WMl/2j1YtlIoaXmxxCYy3CVXHTSVBngupUner/VfZP7wGiWgpOLfYV28RBsmEtiL
 ubWEWa+EvjSY1h9v3Mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNyBTYWx0ZWRfX5qQRIMdvrVlt
 LH9xYI4e2kLeEKqksMnqKzW5IYkxR+NtvozVDHwMxYjj9Q1s7+ADBexELIhiDtpOJiHWnFl3u9T
 nVTIiS0cIOCTngmKnMtGFAxp3oJg67Q=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acca8f0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=x5d5dAMOWgx-vAMA7G8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: kqq_pqv9sJU2Ymc5lSuMyP5zjqER5QbM
X-Proofpoint-ORIG-GUID: kqq_pqv9sJU2Ymc5lSuMyP5zjqER5QbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/11/2026 3:25 PM, Sunil V L wrote:
> From: Sunil V L <sunilvl@oss.qualcomm.com>
> 
> Allow changes to the riscv64 virt board to add PPTT support.
> 
> Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   tests/data/acpi/riscv64/virt/PPTT           | 0
>   tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>   2 files changed, 1 insertion(+)
>   create mode 100644 tests/data/acpi/riscv64/virt/PPTT
> 
> diff --git a/tests/data/acpi/riscv64/virt/PPTT b/tests/data/acpi/riscv64/virt/PPTT
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..94be7a69a22e 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/PPTT",


