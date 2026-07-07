Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DF5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7KD-00028g-Ai; Tue, 07 Jul 2026 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wh7Jj-0001vc-H3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:02:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wh7Jb-00056X-7m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:02:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667CIOsH3536712; Tue, 7 Jul 2026 15:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JvUImd
 TbkNHPK40eCpB+dx0stRIhoeR37W4ZVXxCavI=; b=o8fw1q520rQrzCNRbKcdZB
 MKrg4Tkely1EEwVAMBkOnYhUP6x9+Zsrgh9IQAISpL/fq1pGvi4oi+BaeDn7nIhQ
 h8mI4ldA7hTV6VMhfrZ+H+Z0n9XbGlxgMVF0QFUiFQstaFtw+IyTE2LOuIOcL8Ih
 MZ+bxpiVsJo5n8hfzQber5nITdX0Sr8s3or+ojT8cyxkqsaMlC/Xz6sinjp83kEn
 y+CyVlb4s0XHFFlOiYoLjiZttr0p7B3KWKRNajGfHQgSN9hzt/V0uBzxOOB/bMYm
 gPaXuP85VEmVqe3Q+OXUNYNn/kEWWbiznWioLbeejio/uYjJzEGxwIfEjvfF4Czw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4qtpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 15:02:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Enb7Z000622;
 Tue, 7 Jul 2026 15:02:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg33g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 15:02:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667F2KT960948950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 15:02:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3E745805E;
 Tue,  7 Jul 2026 15:02:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18F9A5805C;
 Tue,  7 Jul 2026 15:02:20 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 15:02:19 +0000 (GMT)
Message-ID: <00a43a10-67f2-45ce-b2fd-15e4bb32b101@linux.ibm.com>
Date: Tue, 7 Jul 2026 11:02:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/core/machine: disable tpm-tis-device PPI for
 machine type <= 11.0
To: Mohammadfaiz Bawa <mbawa@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20260619093140.832136-1-mbawa@redhat.com>
 <20260619093140.832136-4-mbawa@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260619093140.832136-4-mbawa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LvArR7x0jBWSJQwEQ7Mhx-dxyFbAJnYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0NSBTYWx0ZWRfX4Wmxmoa3mknD
 aVeVowFhpQHNFA1bcCgcGFrBX5lKb5LjYWYmup67GxlwFfx8e/ql7WQ6R8zB8co3cCa6af65Dmf
 3hHvDVFL6zjM3SJaxqEmOuGoUEKtglfq/bd10euO1CDU8S6Yfp9LLiBAuqfwHlvHgFx2nz6U9f4
 qxGlCLBhsIO2K8n+ZuwpM+6AclCp28QzmBA6BLLIsZpl0QFyKyAnoD5MunFXLGHbJe4KK4wixf0
 7U4wdLwhMgQv3HHJLnbgUoSr+8NwGlHD4gM7V5FicmarkLumYN1MJJsz5DyE9uck/5l2sOISreL
 Gx168putcTAapjUfQdV8CkwSUC8qRYK8wkG2us3ePKjfvjN1o/TpmATOeYUjjf2H01RWonLReEw
 eiq4wn3rf4tXY6JXj/9i9NxeYbMT3hf41aKewwOofZW32nt0mgyuV8otFm7m/cUluDGhlvNgdTH
 zfeUY8Q0OP2VRNpCpcA==
X-Proofpoint-ORIG-GUID: LvArR7x0jBWSJQwEQ7Mhx-dxyFbAJnYM
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d14fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=HiZxU16huqEOhowUG_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0NSBTYWx0ZWRfX5NN2HDiXCLK5
 pWM1IHVkKs4qp/Gx1i1M2JalQZ9IT9btipMxXXFJQPRUYaXlwCcIQE8mfCAF1jNQSqo4MkHBV5g
 hhs+iewTxDYOqYpw2ZKmNt6b9K/kruQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 6/19/26 5:31 AM, Mohammadfaiz Bawa wrote:
> Set ppi=off in hw_compat_11_0[] so that older machine types do not
> register the "tpm-ppi" RAMBlock, restoring backward migration.
> 
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9a10e45aab..92cf5e1ca1 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -44,6 +44,7 @@ GlobalProperty hw_compat_11_0[] = {
>       { "chardev-vc", "encoding", "cp437" },
>       { "tpm-crb", "cap-chunk", "off" },
>       { "tpm-crb", "x-allow-chunk-migration", "off" },
> +    { "tpm-tis-device", "ppi", "off" },
>       { TYPE_ARM_SMMUV3, "ats", "off" },
>       { TYPE_ARM_SMMUV3, "ril", "on" },
>       { TYPE_ARM_SMMUV3, "ssidsize", "0" },

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



