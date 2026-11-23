Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6EC606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QKxar+mB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D/woBh/U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVaI0-0006B1-M3; Mon, 23 Nov 2026 15:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVaHy-00069r-Q2
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:05:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVaHx-0002DL-5y
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:05:22 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJujDJ026341
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BoMnSgKCuyqwgoFZJ4WBn7Kvl1YNqVVxk85wmsIXcY8=; b=QKxar+mBwAdPnHoJ
 V2NTXGMcv5JTnv0rx02w2zF7Pws8fOpVadT6smdRq/tVfim9NMilfV2rurDaN8vU
 UJMA/7L4rrUUnfpFWn4+CUU1sxnhXmjxQCKT47805dtQ7dv/FQJunoUJm/bOWvxi
 A1rDOu5QUg0poH/ocsC3xAR0TTTa0GQlikyJob0f6RvyzD0OFeyRQd8j/Ok1peVb
 2GHhf0BbocpJGbKyIfUJO6Fh6Kc8F+CQUwgWmzgWeMek6xoEwEFNVt63diwBB3kV
 ublzumkAxXAoyJVFpPa2YfUFyrhnkDyiFOK4KgCw45iFwc5TcM0exKBwIGrSAO8r
 xxcQJQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd39c7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:05:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94967c6d4f4so393294485a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795464319; x=1796069119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BoMnSgKCuyqwgoFZJ4WBn7Kvl1YNqVVxk85wmsIXcY8=;
 b=D/woBh/Ui+mCmZNalFiaoWClGQLGzKKaTDMalqTXKn18gPrDEd+MYXEE7Mmd/0tK0b
 6a00pr/y3a+fHha4MihuWqx2tUaMcWbEUECvwWmVxrd/THh2MHqJZVel9M7QCASqDCQa
 wO4gJb2q082bQoAuOr40TrpQDllqLYhooSgPI1WPxAC0XwiFMYJuJM0y2H6uZXIcNT/+
 sNHI0Oq5FvwYM+UMRCE4+JjbZIrisCC8wFG3nIcxXmDvXh4jti2GtxM0oW4lTeUiwj/f
 DIp7mgopEkV39Rk/4AFmMW9H22jWrZEiyQaFuYy+LE2r9z8iLfCVO2rqFou3f6dsvrDv
 xgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795464319; x=1796069119;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BoMnSgKCuyqwgoFZJ4WBn7Kvl1YNqVVxk85wmsIXcY8=;
 b=ARLqqAQ3dM4DVvrFHHWE8FCheNcyCr4fZNKGTihAwzc2ggv9MzPCiCBMFNkYSlcLfJ
 k5Al1/yGgTD+OwykaP7WPJOHInRIg3Otq5ne6gsmummNLEPqJFGRxyyJIlKZ79OJxdvo
 RIMRVbx+cTSC8QjWCVUFSkt82TljB0kEzZV+VL1FKUEogz7Thow3vdHP8cotOyLci9St
 5gn1tIonW0Gk399YGkzlRYX9XbxJgMBv5tu4NrJbWph+IhK5Rjj0fDiSW2EWTds+ak7I
 nsk/v8+Labu1O6ONxB/lr++DAGDp+OpCxNkUGbxHaVcgPrMMgmq9dsl4b3D0yzRA+GKb
 R/Rg==
X-Forwarded-Encrypted: i=1;
 AL+hErEPBfPbc9GiqifPmNhd1m5Hubei6VCh7jIaIK9e9fNY/DBmtnQcZJ8cHE/Mlx4vx5Fl2hX+E9iNMtpm@nongnu.org
X-Gm-Message-State: APuU4Z/IxQXcwmE1zxdoAmkraNZBpH+vZIwMZzKDAtptvq67krXBUj0X
 lxFLv8v+XrXLZQxi26baiN/H/decwz2pD2Y9n+bQN2vJWDpaJ6qHtZkZfrzUZ3+/EdhGKm/OKPi
 /Op05vwR2TYwNr5KRQh1pzhqCQAxF/t7uEvetqQLL8ELCFkawiPjBwT9vnw==
X-Gm-Gg: AZFdTZfnFdMzNwTPLSzNKUNIQVecITdQs+UtXlE9us+osf2f4KIX4MfSW2gt9gAsRW0
 D1J3+1nWNTCTqOcawVKWvJPGQWu2Iy4DuhSm4Q8S7dVCXE8A++PLZwCdGhT9WHZlfyr2VJX+hd5
 m4SqiMJmSI9hCqmOQVdSBFxBhqIlZFxQLmJZ9+XkBfAHdr+Qk865TgQ/nkWd5u1BBFv3h9MF5fI
 FXG36CvNPLI33mpEyDNz3yV7jq53mgJUUSkJAbyb1PgY/voDfW0zEi7xXyH+JtftvIzZSDJAyoQ
 Se3HejTeuP+CEXGPrFljnIRKbYF6x7MnMn2KKE6xIjgoW8g88wPbbz9RZid7+Lr7eXRwD+2uA5g
 R9KD3TAR5Inu58n8eZva5yHSGevJfNP+pWxQ13oTKGLiMIZShEUBzTQAHU4kKwPmiELpKybyx51
 Q0qNuaDrsk
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id
 af79cd13be357-949bac80948mr2177806885a.79.1795464318584; 
 Mon, 23 Nov 2026 12:05:18 -0800 (PST)
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id
 af79cd13be357-949bac80948mr2177803685a.79.1795464318058; 
 Mon, 23 Nov 2026 12:05:18 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949ca6a0693sm668728685a.20.2026.11.23.12.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:05:17 -0800 (PST)
Message-ID: <6b9a3884-393e-4f3a-9b47-e7a19438d3da@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:05:14 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/riscv: iommu-pci: Add migration support
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
 <20261119024251.280765-3-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119024251.280765-3-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5N4Q1SP7koimiWSHSEr0gjlQJZw6F8PK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OSBTYWx0ZWRfX5GV4VzV1Yfnw
 vSSanZo1fOMD4vQwg4/ZAfQ7B0nshAhcq+s+g06KkmQA2IRetJqtomFev6lBfz2kU4JASpzQWvy
 WZwl8Q233A6BqiD0m8taaHH7jbogH8/OdyWfEd8X4fhMGPdNxcJaqWT44YOLCpwP6Go6aFSKjP3
 puv66YjM7q1WNyxJlLUFlhiWVgSaSJl7t6M2UE5xQnspVx2xjjAKbVu30aXVPTmqP75jsR/Nojt
 5NbJ2B3LK+RIaJ1vgWzwJAeiXx0U1KIHE0BVsox2ae2sl3ZzOR6AUMNiQRVrxL1KWEpZrJJqzRn
 ef0YHTCp96Z9uWjOATmFZ9zN7ctix8XPMJdTsmVN8rFVdE35GsBxWsAqJxLu+lMHH9D4bb6ztX5
 GCjLksSnKemlvWNSZOrj/+tiKUmq4UjH4HDQO5exDD2DyLfVARxpxTnxsDuf2H0RsSvMkaSt8L+
 gMOWPPS06vVfrHEvoBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OSBTYWx0ZWRfX6XWRmgkegO0M
 bPgARwusW3Bn6Lnj3QLxhp/r4KeYhbqAC2YMDoDFMKpDiFgcBOz3ngDyCuUrp7KnlPVmt+A9Kpz
 Hg6YUtYstLh8ypV5fFbXa44KagYfemU=
X-Proofpoint-GUID: 5N4Q1SP7koimiWSHSEr0gjlQJZw6F8PK
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b049c7f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bAV9XMTbiyrS9rdrDgIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/2026 11:42 PM, Tan Chi wrote:
> Replace the unmigratable VMState description with one that saves
> the PCI configuration space and MSI-X state.
> 
> Use the existing PCI migration helpers to preserve the MSI-X
> table and pending bit array when MSI-X is present.
> 
> The common IOMMU state is migrated separately by the embedded
> RISC-V IOMMU device.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu-pci.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 14dd5f3857..d149032cd1 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -143,9 +143,23 @@ static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
>       pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
>   }
>   
> -static const VMStateDescription riscv_iommu_vmstate = {
> -    .name = "riscv-iommu",
> -    .unmigratable = 1
> +static bool riscv_iommu_pci_msix_present(void *opaque, int version_id)
> +{
> +    RISCVIOMMUStatePci *s = opaque;
> +
> +    return msix_present(&s->pci);
> +}
> +
> +static const VMStateDescription vmstate_riscv_iommu_pci = {
> +    .name = "riscv-iommu-pci",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(pci, RISCVIOMMUStatePci),
> +        VMSTATE_MSIX_TEST(pci, RISCVIOMMUStatePci,
> +                          riscv_iommu_pci_msix_present),
> +        VMSTATE_END_OF_LIST()
> +    }
>   };
>   
>   static void riscv_iommu_pci_init(Object *obj)
> @@ -193,7 +207,7 @@ static void riscv_iommu_pci_class_init(ObjectClass *klass, const void *data)
>       k->exit = riscv_iommu_pci_exit;
>       k->class_id = RISCV_PCI_CLASS_SYSTEM_IOMMU;
>       dc->desc = "RISCV-IOMMU DMA Remapping device";
> -    dc->vmsd = &riscv_iommu_vmstate;
> +    dc->vmsd = &vmstate_riscv_iommu_pci;
>       dc->hotpluggable = false;
>       dc->user_creatable = true;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);


