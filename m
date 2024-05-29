Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B830CC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJ6a-0007nX-3k; Wed, 29 May 2024 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1sCJ6X-0007mH-VD; Wed, 29 May 2024 09:12:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1sCJ6R-0003oJ-Rs; Wed, 29 May 2024 09:12:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TCR4ZN002957;
 Wed, 29 May 2024 13:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8l71S8m8cFbLcxdKavLItx5iBGsHKmlWO6REGHHN7hs=; b=ZQsoxyisJtcTAan7
 Ogbo28OY/UlDhhvIpIgryAquD2Br3fJOpjXW+I+gdiOVeKPD+fm2EMj3xvQ7JwLU
 B5iE5dprH1xp0xDQ6KdfakFhqFmNlRgM0Bu154yaQMb/2Nfp4/Y9F/j0j460dmPR
 o7A33YVHKN2GEbTKG+u0fz8bH4q8nXpfXh/JKsSPQ8nDgDea7vqrXV/GdDuhjJXa
 g0vvUEtu27McSca9DbU+Aq2UedTKHklvKqHJYKBhJckLZolqCyhjAQ9uZ8vgut47
 snyHrcG4kxoXoWYjD89VloL/+v/4LRfgxhQwXsxYfNvulNbQaSJsnN0Z6qpW55Xj
 8kFAPQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k9126-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 13:12:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TDCLrW010638
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 13:12:21 GMT
Received: from [10.111.132.194] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 06:12:19 -0700
Message-ID: <543bf25f-ca93-43a0-a93f-c3de6f878b16@quicinc.com>
Date: Wed, 29 May 2024 14:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
Content-Language: en-GB
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
References: <20240528182917.91027-1-marcin.juszkiewicz@linaro.org>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20240528182917.91027-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: _O14f3NFbBoWKarbu3jjeONaSXYVqxGs
X-Proofpoint-GUID: _O14f3NFbBoWKarbu3jjeONaSXYVqxGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024-05-28 19:29, Marcin Juszkiewicz wrote:
> Partial support for NUMA setup:
> - cpu nodes
> - memory nodes
> 
> Used versions:
> 
> - Trusted Firmware v2.11.0
> - Tianocore EDK2 stable202405
> - Tianocore EDK2 Platforms code commit 4bbd0ed
> 
> Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).

Missing signoff?

Apart from that:
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 98c76c1ff7..6bb82f2a03 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -37,18 +37,18 @@ def fetch_firmware(self):
>   
>           Used components:
>   
> -        - Trusted Firmware 2.10.2
> -        - Tianocore EDK2 stable202402
> -        - Tianocore EDK2-platforms commit 085c2fb
> +        - Trusted Firmware 2.11.0
> +        - Tianocore EDK2 stable202405
> +        - Tianocore EDK2-platforms commit 4bbd0ed
>   
>           """
>   
>           # Secure BootRom (TF-A code)
>           fs0_xz_url = (
>               "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240313-116475/edk2/SBSA_FLASH0.fd.xz"
> +            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
>           )
> -        fs0_xz_hash = "637593749cc307dea7dc13265c32e5d020267552f22b18a31850b8429fc5e159"
> +        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
>           tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
>                                         algorithm='sha256')
>           archive.extract(tar_xz_path, self.workdir)
> @@ -57,9 +57,9 @@ def fetch_firmware(self):
>           # Non-secure rom (UEFI and EFI variables)
>           fs1_xz_url = (
>               "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240313-116475/edk2/SBSA_FLASH1.fd.xz"
> +            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
>           )
> -        fs1_xz_hash = "cb0a5e8cf5e303c5d3dc106cfd5943ffe9714b86afddee7164c69ee1dd41991c"
> +        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
>           tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
>                                         algorithm='sha256')
>           archive.extract(tar_xz_path, self.workdir)
> @@ -98,15 +98,15 @@ def test_sbsaref_edk2_firmware(self):
>   
>           # AP Trusted ROM
>           wait_for_console_pattern(self, "Booting Trusted Firmware")
> -        wait_for_console_pattern(self, "BL1: v2.10.2(release):")
> +        wait_for_console_pattern(self, "BL1: v2.11.0(release):")
>           wait_for_console_pattern(self, "BL1: Booting BL2")
>   
>           # Trusted Boot Firmware
> -        wait_for_console_pattern(self, "BL2: v2.10.2(release)")
> +        wait_for_console_pattern(self, "BL2: v2.11.0(release)")
>           wait_for_console_pattern(self, "Booting BL31")
>   
>           # EL3 Runtime Software
> -        wait_for_console_pattern(self, "BL31: v2.10.2(release)")
> +        wait_for_console_pattern(self, "BL31: v2.11.0(release)")
>   
>           # Non-trusted Firmware
>           wait_for_console_pattern(self, "UEFI firmware (version 1.0")


