Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BD606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B80DTjO/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VzZsN0Yw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVaIJ-0006KD-4l; Mon, 23 Nov 2026 15:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVaIG-0006I2-3e
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:05:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVaIE-0003B5-Dj
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:05:39 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuH673514055
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WWLb8+fh6oO3ZnzEEKtRhiJ803Mtq9Gx0HjgM7/TCnM=; b=B80DTjO/shIT/blh
 q+h+7FJJFahuPXXJi30WjGIryphv86T3jCKpYbnPcvdOtIQk39PSTSD703J3Ertq
 3IOhIYaSOJjHbqps5pDio8/6quiWQWDg94ZFeQ+gaQTZeHNl/U3g1P17gTbSRXo3
 P7TjyrTROpQuAk1JjBGhnZKgv/B/olMPKkbRdLYCPSk7T+km9nkCCeZvGhw2Qrc+
 rSjgv7n274Odt09Eu7NBGU9Wln6Rtlg2ilZzEYPlrrfqOkb8NaWMqVsDl5mWXq/4
 Kqk+IKww0rg9c788YnV3POLuWC/VvKzvA7SycSP6qv8mSFTW/XICrCT4Bk4/mSMe
 GQEESw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukr8598-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:05:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so778174285a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795464336; x=1796069136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WWLb8+fh6oO3ZnzEEKtRhiJ803Mtq9Gx0HjgM7/TCnM=;
 b=VzZsN0YwNgzFx2D1eftRTolUAm/if2+ZU1zeLPI9QxAqOZjN5sdFX34EjNbOsFh9rr
 dFzr+dwZCeEDHrWyyfhBUzpgpex9OpBPk7D9umODzCE+ciNOGDfuFu6sbNd4Icy8JPQG
 MnAMLf8qh8r+NIr+882EN76M/TUERAEFj77pfnjD8DPeISfOeQkn82nCUkrfLJpg2+ev
 WfNVF8MdvRLcx+wikcgVIJ/kDuiZWxxNBK+jSm8Hnkmw9niUhrOJjdkg7B5DWkIO2r6/
 pwDOAKnNF9KnAoWDwwtgdx07Y7q42vsNYVEFupaEcAXeM4X8mOjW9xG4xA13t75Qae0v
 aZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795464336; x=1796069136;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WWLb8+fh6oO3ZnzEEKtRhiJ803Mtq9Gx0HjgM7/TCnM=;
 b=ub0IStac7gas+Tue2qgHdXMU+JzpDIsirPMQSDMqqohJ5fkyCkvH/sRqntu0YwOTZp
 fHQ/RLL15dPRuhpgcYnA6Qr30O4iYzBiHnZzrrXfnv+bL0Sr1GKOZ285c8LfQs0Fv0l7
 QzEcvlYgV7DEw6/xjzTtxJzISbvPkg1nQ8Mld5rUHGwu36xpZHWkvFEEdNMoT8NLdMDm
 2Bbijgkco0vJX4Zx4M9E0h5L/BBHUeCobyG+zFza4fhvg/Nmprr2yHqSwR3WbhC4FktN
 edujT0yavTYcK1dfpoCC5jOUJzbqG0073JSWFCNHN8U39csvoDt/LT35PN5KmDoq4OEL
 fvnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH7omBLxXHv4DlbEsmnVxnYuQDgzDb5qfbtApM1I8650FTqulr8Zr/ECEUjai2ukb3l/lLEdAI8x7rG@nongnu.org
X-Gm-Message-State: APuU4Z8BIM+fCXMlJeFP53ep7XmGIZ34MsIYVaLVKOCPJkno2zMudZ0z
 +c0+cmJCet+EwiWo04NwE6nrBHQKwWFr9XGmX40kYVzLsYmfpL8nXYjaOfK9BWDx5IeG0mDeBoC
 N07slz3plVEYVqdPhaEb6keB+2fDVbpCmibBcvieEMTmQ5oPJmGP60qnvtA==
X-Gm-Gg: AZFdTZfCyOD42S51qCnZ7qVxAwKNlMvIBW6P5ouaz54brZfHAubopjEuUU+VYZAAFuX
 0v2keKq0Ui5RW+ozYWHoBBAuvgH4m3krbYF3xEnuRZ3ACdnqZ7YwTZbL/BWeiPcvO/gr7le1l2F
 UpwauR7oBoVhWZCaAZY1al/39ZIrqfbvkiusTKYOOexK/oH5zviE55C3AKY9hrkQXJn8SzFie/0
 w0Ecs7gQbEy3ZX4VzcOhVCxPNAjARxlB5wErRxKmOt7fjffqcHc25XnvMfJwRXEKIp4xgFLwS1L
 D12Xg+VcZfg4WkcZBjyocsPcE+4mk4EQ4NybJI2ZLgFC6ex2lISxtYC+VXDAXWARbYWkW1yuNul
 vnfjHheK02deZDzCyA61fC0RlUw5/x7bu5q/aAkXgZzOjqwZ8bMLWdmENDvLnT+sIf4Rtk1pVr/
 Efgybrg6rM
X-Received: by 2002:a05:620a:4384:b0:949:733e:dde5 with SMTP id
 af79cd13be357-949bab32aadmr2124873485a.66.1795464335950; 
 Mon, 23 Nov 2026 12:05:35 -0800 (PST)
X-Received: by 2002:a05:620a:4384:b0:949:733e:dde5 with SMTP id
 af79cd13be357-949bab32aadmr2124866085a.66.1795464335146; 
 Mon, 23 Nov 2026 12:05:35 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb35005dsm880498985a.11.2026.11.23.12.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:05:34 -0800 (PST)
Message-ID: <aa883642-c38a-48e4-b883-c3206d1b8426@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:05:32 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/riscv: iommu-sys: Add migration support
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
 <20261119024251.280765-4-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119024251.280765-4-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4MCBTYWx0ZWRfXwHKMXI+s6B+r
 5kqkIowSJB3YWKbhb40bHnGYEXQrCxVTGFGjPTWpV+Dfwc2yoQqN211RRuFF08WK+jNA5KZzmLu
 LPZsAQmNxFHWGRIsjz8b0oLXhGNM1gU=
X-Proofpoint-ORIG-GUID: xFDM6uDOdhTRUDQN1lYCvmwms4iOs_5I
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b049c91 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=fGMt68kduvb59XZs-sMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4MCBTYWx0ZWRfX0sAZAsDeJb2U
 6KiHnqRnZ6lF4fK7NbwNBotOmrltAr1fucTARnJKaplA/XfuW1D6MTlp5/m8RcO319HhIrYM1WZ
 7Cm6Ly6YCaGFzkTvlNGBHiYTRPq4ci3dMrwd83+dW3p544R4zj5Nr8Hl4NdmXy+97OGT/7Zji7f
 t6YUxW944CWG1D3eXRsXTaie8FtFPB2TKgO8w0dAK/0PqZwKmTfmEO8zN0AC8XbBUOK5XvtYuEB
 8rQz5+yXB8RbKuiuO6//DnXeAtMspCzdhlKRWi6rLWZpbJ99Jevlc9YZ6I50FgqM40mPndbgwrS
 aqVih9YwzWgINuNo+zl/cFelIzBnF6FmIG/GToJPIN9Ew6D1/LfwfykLnmddsJnHdEFBGANuLsZ
 DCRHGec2tm0/Cup0xK8sEHaS7V+i9nRIZ3pWquU/fmNWpoah/k9UNfuUGryQEcJI5IaZKsOdEgc
 62GG6rxKy4vvZW+BUTw==
X-Proofpoint-GUID: xFDM6uDOdhTRUDQN1lYCvmwms4iOs_5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230080
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
> Add VMState support for the system-bus RISC-V IOMMU device.
> 
> Preserve the MSI-X configuration table and pending bit array,
> which are maintained in separate buffers by the system-bus
> wrapper. The common IOMMU registers and internal state are
> migrated independently by the embedded IOMMU device.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu-sys.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 258c171efd..6e4cea00a5 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -21,6 +21,7 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/sysbus.h"
> +#include "migration/vmstate.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/host-utils.h"
> @@ -242,6 +243,25 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
>       return iommu_sys;
>   }
>   
> +#define RISCV_IOMMU_SYSDEV_MSIX_TABLE_SIZE \
> +    (RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE)
> +
> +#define RISCV_IOMMU_SYSDEV_MSIX_PBA_SIZE \
> +    (QEMU_ALIGN_UP(RISCV_IOMMU_PCI_MSIX_VECTORS, 64) / 8)
> +
> +static const VMStateDescription vmstate_riscv_iommu_sys = {
> +    .name = "riscv-iommu-sys",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BUFFER_POINTER_UNSAFE(msix_table, RISCVIOMMUStateSys, 0,
> +                                      RISCV_IOMMU_SYSDEV_MSIX_TABLE_SIZE),
> +        VMSTATE_BUFFER_POINTER_UNSAFE(msix_pba, RISCVIOMMUStateSys, 0,
> +                                      RISCV_IOMMU_SYSDEV_MSIX_PBA_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const Property riscv_iommu_sys_properties[] = {
>       DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
>       DEFINE_PROP_UINT32("base-irq", RISCVIOMMUStateSys, base_irq, 0),
> @@ -267,6 +287,7 @@ static void riscv_iommu_sys_class_init(ObjectClass *klass, const void *data)
>       rc->phases.hold = riscv_iommu_sys_reset_hold;
>   
>       dc->realize = riscv_iommu_sys_realize;
> +    dc->vmsd = &vmstate_riscv_iommu_sys;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       device_class_set_props(dc, riscv_iommu_sys_properties);
>   }


