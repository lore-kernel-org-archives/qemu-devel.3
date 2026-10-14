Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B33CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6SO-0002W9-DZ; Wed, 14 Oct 2026 17:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xH6SM-0002VM-3U; Wed, 14 Oct 2026 17:24:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xH6SK-0002Gd-F3; Wed, 14 Oct 2026 17:24:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiWi82466234; Wed, 14 Oct 2026 21:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UiZrLH
 Lv9am81rTN0L3KGFlZBljwpdwXcKcZOgXSbFk=; b=EZwm5AfGTRfBVwkCAPx4nG
 QieQAQzhNUcNIHYYZAQqq+M8Qk/Njw95S9U62oWNfs1MP6cmvp+jInQqqvaanJL/
 e6GZtNfif2o2rxsj1o1jlb10+qMLppd99/LDFNtfm8/U0N1jiB89d/YKanXl9UeO
 TLP0fVw0NWNDZSb8ZPVLdDxUrwExy/FA7oqquI1j3pPU6MnOl2CMda1wGEPrHocJ
 UDkYunGH21P5KsgnJHRhl5nCjurJCRlteaZ8ut2BaY/dOy2WftiyvrKiNWPUbtvG
 P+3C8fH+P3XQEse6WU/ezm5dkKIi5qsD8Wjlp4SKSIsmB8UlnjkHwAxvHkzh6Lzw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1we6gt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 21:24:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIUnFI3639755; Wed, 14 Oct 2026 21:24:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg4gx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 21:24:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69ELO7oi4064056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 21:24:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A250458059;
 Wed, 14 Oct 2026 21:24:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DA475805F;
 Wed, 14 Oct 2026 21:24:07 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 21:24:06 +0000 (GMT)
Message-ID: <92949383-bb41-464e-bbb5-0cebe1a236a1@linux.ibm.com>
Date: Wed, 14 Oct 2026 17:24:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
To: qemu-stable@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>, QEMU <qemu-devel@nongnu.org>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
 <20261008212723.3679685-7-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20261008212723.3679685-7-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX36pNkSEt0+pf
 vFf9PumufFt+4vSrej8SNzPNoqJWMk/onYVTJNUkP8PhPB1b1fSfHX8C+ikbaty4IrEczRknjCg
 +CQGNuFTwXZ31noHX5eHYK77c8goo3E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX9htPLWnsSXc1
 U83tWKJalIZD+FkZs6JigDKGDSVfyWtHEuTEXKelpz1LSCG1SQE+fxYaFz7XUqfreXSDQss7ab/
 5mZSVy8eBsJXquzen4EkXS3yz4xFleaH1obqTc3mN53D/dM5asLWIU8Hob99uQT7HgyBncZn/IC
 FSiyMJqFYOYgIJlySHPIoMBbluPAMX46pwecneeLwd+p8M+dKVSdakdlxV0SMC4ePcRI5mYBuZq
 1JADqockuzAvBJnnFSEWzzoz6b1LVsqntyLQ+8ZBVo5J4+Sz4G+soHzA6FAuk7w662DtArPIRxm
 qRFNYZkW2zCRqfseBIfh+egR8aFck/rK4pIck0xqQ7UmK9u5wB0X8izFE6QhoEEbSA0MYze/iMi
 cYIowCUif3hP1rPxBI/wBCLRNnJIrbg8SbDsTLWFcEWhIhcoUyFk4Zn31rObWb9LA/Gw7oFXOSQ
 oyplTwiRfWEvb8FHeqQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acff2f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=kkV7IriFoqumtxw7-BcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r0TgTrLWz-d8a9oWEXaA6becvD1ycncv
X-Proofpoint-GUID: r0TgTrLWz-d8a9oWEXaA6becvD1ycncv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Please apply this patch to the stable branch.

Regards,
    Stefan


On 10/8/26 5:27 PM, Stefan Berger wrote:
> While the backend (thread) is accessing the request and response buffers,
> do not clear those buffers upon a command cancellation. Also, per CRB spec
> the TPM is expected to either return a normal command response (command
> could not be cancelled) or an error response indicating TPM_RC_CANCELED.
> So the response buffer must be able to receive a response as normal.
> 
> Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Arun Menon <armenon@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-7-stefanb@linux.ibm.com
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   hw/tpm/tpm_crb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 54fa2042b5..daf451aa56 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -219,7 +219,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>               if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
>                   tpm_backend_cancel_cmd(s->tpmbe);
>               }
> -            tpm_crb_clear_internal_buffers(s);
>           }
>           break;
>       case A_CRB_CTRL_START:


