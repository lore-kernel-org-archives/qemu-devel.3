Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C2DC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxzM-0006Kj-4f; Thu, 23 Jul 2026 14:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmxzC-0006JX-Ke
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:17:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmxzA-0001eQ-Uv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:17:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NHW6Y0656353
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 18:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KPLEDTfe3bivJmjuuyXa7Jy9Fd42cqkcp2RKaFXmMTE=; b=BFl3g28bSgx99+/f
 8sP/l66fw96DRvB6MtAOnxkcIzISjP86JLIrWObPJ8/60Ik0qJhD5N9smihb8o2U
 aSIyU2XWm0kO8BszJGWdmyH8Ff9KkYm7BX7CxNHyd6rIaIgKTGCTWWmoMQJUI80Z
 ASu34EY7uzsB11YStrnST1GTSDtcDf/mnFSwXsGFmj9V8rADAX++zqIKyNda6a4v
 XO3Wmlb1m/uYxzRSpygjWN3uCupvyS/nAl0M1vCJ2ii4tlwmA+/WY8ph32VsICmL
 G2n8WeZCPxASfR8F39ihYVP0irZwwhKTSylk8AYwqBjfcmywZvoOb19dbErGweJN
 3O9rQw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqamr7g8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 18:17:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso23397186d6.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784830650; x=1785435450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KPLEDTfe3bivJmjuuyXa7Jy9Fd42cqkcp2RKaFXmMTE=;
 b=dYC8XiiEjAe/vrbX3axxMzEEHkF4hP2B3d4972d3QWy8vLQk10ol6B9LoGep53rRJZ
 5p4jkgCd736Idm2d2nx/7gueaOcYvVfO9aqE/2TKNGHhSBy6E5hFkz2bkGJ/gkWhBJrg
 UGsRpm84VWBpKzaT7SzM1gNKt+AwkG7cugZHeRbeLILnLkXC8ai585wydI+YL1KoKsXv
 JE2WZZboJ/XOzkYJC897szPR2G4qRvENycVS0m73/cYcsZsmiDqAvHItOyOML1y+gYtu
 YwrLdiXFbc+kgfsnZL4/reaMJtjYQwZCylv5RMf/jz/KQoL1ufzl3Tho0AIO0X5wbw9v
 ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784830650; x=1785435450;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KPLEDTfe3bivJmjuuyXa7Jy9Fd42cqkcp2RKaFXmMTE=;
 b=TG1HYkVCrVTi7CK5aafTgzbugXhNA3/YPWM9qOZOrNeZmq+mCf6+FbqEajuVfuMk+T
 1+eFNWtO6ruBMXSDGQV/2dHfa1ZTUiVIkTrbk9F4wDK76WooR6BNxGaxzK60T5Jti2Wm
 oqiLGRtVZz4dnlpVMRz4dlsM6ng8MfEL2HYahXxEOEAuzQ29VIpF4StNYDNZqup22GMG
 ubTJSpW9Nq03KdERG3VZ0U9V+Y3TXbfgTCiaFkwXRfhA1l8T89Ue7ctQmt+DlTEgzt4O
 WD6+3upH08z9hNwbf99rl9wiYKfStQvVRtPimnSZE5b8CarNJYtiOX2estkIV09uqOZH
 ZjvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqliBngdpA6l9kx60jq3IQE820b39UCetG+po3w9WHJpZjccPKVVmPfyi7NdT2Ucd+j7PmlcOPMa3Q5@nongnu.org
X-Gm-Message-State: AOJu0YxYqOO4AUyq0vHgeq8VjNWsQuRq8JuV0/jTdKiqUTr7oMLGECrk
 sMGHjMjvLaseOYWCoW97B6p772oRim0BEcp8VwiAwCTAwp/oIJXdH9v+LRCZADI90o47ZVCaJo/
 cw+YDObngTUQyXSis48KQ2CMnanKKlruiVAOxBCH/7eCqTVlKSihUJT8vvg==
X-Gm-Gg: AR+sD12EEJ7QeWaU2rurYb5CcCj649I4WtYZj5azDq2Iq+rMoYq43LRuUdbfurxz9sP
 K7Os7UlL/+qydE5hwFBopYWmxZVCES6Qe6Veo3kmgCXScoIP9tcxjtaZ3MxRxtl+hnLc38EQ3Ip
 vlDW9GGxOeD6lt5TpHIdg497BKRA5RpwCXxDWytKPk15cdAGYCrvlx2C5PQABEDPL0JH+TjijMN
 gOrVnf7urRTMEpwbDKp7KblcOr2Q1iJAOE91Y7Ism/2Q3JrwPAnn2CK7kjwfuf5UUqoM/5kWu6g
 dLpN1rA+h7HCpoarQTDA9XXP93Y7BXDQrY0Nij3TEJg327KbsALWUJPlTQzLPApVBPK32P5laAV
 f+RJoqoKblzHpP1FOWA1XiazFuyBRymrAOg10+g==
X-Received: by 2002:a05:6214:5501:b0:8ef:feee:f91a with SMTP id
 6a1803df08f44-907ca34d286mr49074616d6.42.1784830649857; 
 Thu, 23 Jul 2026 11:17:29 -0700 (PDT)
X-Received: by 2002:a05:6214:5501:b0:8ef:feee:f91a with SMTP id
 6a1803df08f44-907ca34d286mr49074236d6.42.1784830649362; 
 Thu, 23 Jul 2026 11:17:29 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e18besm51295826d6.24.2026.07.23.11.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 11:17:28 -0700 (PDT)
Message-ID: <9b31ecf6-35f8-4d11-a2cc-28d1306bacd0@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 15:17:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
To: Flavien Solt <flavien@nus.edu.sg>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
References: <KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92@KL1PR0601MB4874.apcprd06.prod.outlook.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92@KL1PR0601MB4874.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX/96GA5UP7qRZ
 lOv0Q08Zwwbu8ODc6dT5avNU6tNBl/W15e++ee46HElAeu//4wSbFx+dxXZsWcqdimboDczoFmM
 UxSOBgLVuvKvLOKtq9GtBdtBhrtX5M7uT9u9tJ6t+Qtr0T8agriy/RsNQlyb0zUrjT2pUgpe7Rt
 LA0kQGQxJUSxCq0tZZlpjqU6jHh8Hvn9GWHRCV+ml2mrkwYYxQs3JBU8IGNBW8Wcs3/NYvZgCwM
 nEYzfAb7+SPUnquWp2KPReYvf3SDAzjPB2KODnE1AuV40zkiak/saa8PB74RY/1jBvasQaB55ya
 FeRMK9yry8V0I5NWCtWDWg8AnAYoxR8uG1r25EKWiQDs7JFlUxLtUauKldbmU8/6tJlxSojpwFw
 gpe0f2xjUv5U3EktoYBtvvOzMYR6f2DcjaG36XuUEBfo7oVzSAZjGqb4+eDu1ZEZKSYt8/IGaKn
 ojhH7Sh6ovw7Vn8WjrA==
X-Proofpoint-GUID: JqKZgz9mkp8didZ0BLUCKtt2gTo8rRKw
X-Authority-Analysis: v=2.4 cv=DfAnbPtW c=1 sm=1 tr=0 ts=6a625aba cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=3NAPQOWDTWkrN7lJYGsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX/z6T+5RLdRQg
 fLGRJuIzxKAxkQhgLutSqyUKBjpJ4jQQFLb8ijLPQbWnjs5BSLMuW1RESste2MO3QPRAuf9tIcv
 /Mv/MJkg81DNYBUQpwzHV+uOnwUtqco=
X-Proofpoint-ORIG-GUID: JqKZgz9mkp8didZ0BLUCKtt2gTo8rRKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230178
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/14/2026 3:01 AM, Flavien Solt wrote:
> The AIA specification requires an IOMMU to send the configured notice MSI after storing an MSI to an MRIF even when the corresponding interrupt-enable bit is clear. The problem is that riscv_iommu_msi_write() currently reads the MRIF interrupt-enable doubleword and suppresses the notice MSI when the bit is zero.
> 
> This patch removes the enable-word read and always sends the notice MSI after updating the MRIF pending bit.
> 
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Flavien Solt <flavien@nus.edu.sg>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Tested with a deterministic qtest using qemu-system-riscv64.
> 
> After this patch we get:
>    enable=0: pending=0x20 notice=0x12d
>    enable=1: pending=0x20 notice=0x12d
> 
>   hw/riscv/riscv-iommu.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index f6865d1..9627cab 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -788,20 +788,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>           goto err;
>       }
> 
> -    /* Get MRIF enable bits */
> -    addr = addr + sizeof(intn);
> -    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
> -    if (res != MEMTX_OK) {
> -        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> -        goto err;
> -    }
> -
> -    if (!(intn & data)) {
> -        /* notification disabled, MRIF update completed. */
> -        return MEMTX_OK;
> -    }
> -
> -    /* Send notification message */
>       addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
>       n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
>             (get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID_MSB) << 10);
> 
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> --
> 2.54.0
> 
> 
> ________________________________
> 
> Important: This email is confidential and may be privileged. If you are not the intended recipient, please delete it and notify us immediately; you should not copy or use it for any purpose, nor disclose its contents to any other person. Thank you.
> 


