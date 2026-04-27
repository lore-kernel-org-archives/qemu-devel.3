Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F94FF8872
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSae-00042I-W2; Mon, 27 Apr 2026 16:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHSad-000408-NX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:29:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHSab-00024m-Uv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:29:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RDvMB92585373; Mon, 27 Apr 2026 20:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c6BvwC
 /vnI4urO5zFqjJM5k+9ut1vHGmlzC4/lF1EIQ=; b=gMtNR1AWeur7KOwbg8Vnzb
 9X7CHmXxaWzru3ILVrsWkKQb6bvneFuPkvrykxAMWo1GckAfDT057wDNNpePiOFw
 vNQR4USnvGVg6bLUaRwWR6zBPYeyTBXJHOS6gq373IB0L8KDP/KxWXWOOpMAUqLX
 4pqkpK0G1SJG3mhHKXP+srrQs8PPHrYMtO6xW5uOaxWzGs1J50U3X6dm3/4CymMC
 d2YCL8jEQiLqgLaALj9SkVQUk1zm1Kx+foAXPG5lnZxojOqzmGO4zUfGhPKZJs21
 ZmmQB+BlRtHJX4kT8jO4ttlV4HrL81HpULpoj7XwYkXp3PPTHASysjZVgeyP5WIg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb52de7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:29:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RKNjxH027316;
 Mon, 27 Apr 2026 20:29:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g6nrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:29:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63RKTr7b33358576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 20:29:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 300B358059;
 Mon, 27 Apr 2026 20:29:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFD3A58058;
 Mon, 27 Apr 2026 20:29:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 20:29:52 +0000 (GMT)
Message-ID: <ae0fe676-0c3b-4038-b603-c5e0ac4fdacb@linux.ibm.com>
Date: Mon, 27 Apr 2026 16:29:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/41] hw/tpm: free PPI buffer on finalization
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-32-c413f3605311@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260427-qom-tests-v1-32-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69efc742 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=3YzR4anQ7WAeTY_66tUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxNiBTYWx0ZWRfX70xV6zhrpgCI
 Whx6/u56u51q+LDUv6K+VP5onLT6Gh2k4Qn9KpqnERIhsMMRBVi0j36xzvtlRmVGC4t60O+UhNS
 y2rCs3SEv/yHkrJQ3irXFV/qq0k/RfBf4EWWWpGDhgtexhRVhr0myE+QMJqtnYaLKofjTAcBT1b
 xuW8+63ynHXviWJU+qlKjGiSDaNSG6MXnTRIlmAa/tFIK1B1lyi7CCdlNwJJLp3swwHHdILvQ9Z
 qdI5DNy5cSc4gOSzFfTC29D7lq9/JJ+jCoCRrXu8/z8rGOHSTKz8wVRDosH+VWd5aD0m0EFrtou
 CMnutZs/Q3fXlXEVSbczdzkvrKMUge6pNK5FZMiuhUyJEsWiUbcgVTDYbShdra8QRoeIN6mz1/2
 E6zaLlySYnSD+ejJdy2iJaBMmQ6lErH9Io3SuXNuM30RrDgEe0FSvHscWnRLlOCKyTTJyd0drrb
 7oit8UMVmQ2HefpXRdQ==
X-Proofpoint-GUID: KUHF9owHL20JkVV3yiTAxssDzjo0DBv6
X-Proofpoint-ORIG-GUID: KUHF9owHL20JkVV3yiTAxssDzjo0DBv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270216
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



On 4/27/26 3:42 PM, Marc-André Lureau wrote:
> The PPI buffer is allocated with qemu_memalign() in instance_init but
> never freed when the device is destroyed.
> 
> Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 6bec30c36fc..891766ee03c 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -150,11 +150,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
>   
> +static void tpm_tis_sysbus_finalize(Object *obj)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
> +    TPMState *s = &sbdev->state;
> +
> +    qemu_vfree(s->ppi.buf);
> +}
> +
>   static const TypeInfo tpm_tis_sysbus_info = {
>       .name = TYPE_TPM_TIS_SYSBUS,
>       .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
>       .instance_size = sizeof(TPMStateSysBus),
>       .instance_init = tpm_tis_sysbus_initfn,
> +    .instance_finalize = tpm_tis_sysbus_finalize,
>       .class_init  = tpm_tis_sysbus_class_init,
>       .interfaces = (const InterfaceInfo[]) {
>           { TYPE_TPM_IF },
> 


