Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328AD1099B36
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3f2M-0006Pa-O3; Fri, 20 Mar 2026 14:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w3f2H-0006OI-GY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:57:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w3f2F-0004KF-9X
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:57:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62KFdlM2802935; Fri, 20 Mar 2026 18:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gulHEL
 TUzXbdqf9FXTe0M64TBQLWFGNqZYU+FGo8mCQ=; b=GqIQ9aY/heOjnk0XRGPq5A
 bbtIDxKW/4JtPRhzIlQT3Sno7eG+0KajfRYe2s+1ZqTXN6f5Qd2vY9pUlOVHQW1E
 RJZZm68VMG8TzcZFFBR7rkZhX4eG8WpY+HhOSXuaICvojp2MVrSPXlQt9q55T+hL
 0AxXEVYOkAjaRIn0xnMMDI07fcTeaxfZXrfR5TLViqJyzq48rijlhk0HTISVg1c2
 Rdqo2MPey6zobzZxIUujMbkBzl6S2Gk7IRhzsPxa8KtauDu2aCTL3BMdczI1kgx0
 jmWn4KL54aMKcGPoKDVX5ZCjSnGkTpUqombbD6kRSl+RkvenMGEMpq7x7LEmkc6Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauv4mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 18:57:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KHQFei028510;
 Fri, 20 Mar 2026 18:57:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1raqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 18:57:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KIv8LD33817108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 18:57:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9EAE58052;
 Fri, 20 Mar 2026 18:57:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3645558056;
 Fri, 20 Mar 2026 18:57:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 18:57:08 +0000 (GMT)
Message-ID: <1334de4e-710c-4daf-aefd-3eee855aa35b@linux.ibm.com>
Date: Fri, 20 Mar 2026 14:57:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/7] hw/tpm: Increase TPM TIS max buffer size to 8192
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-8-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260319135316.37412-8-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1MiBTYWx0ZWRfX3ivsYTsu7kZf
 ZHRG9QNYqvpH80eemLcPLtJ5rfalz17VBwM9xMxou3xyyv9nalUcvU0SYqwW2VqPm9dB+i7z3YX
 YkHmHFTZJzM8mckLM0bnC088yUsUtAA+y2Uor39F5SwccfLsIvt7iJIrPAlqgBuIdaOpiBm2+Dr
 NVTAoVmXmsFMNuVSdfiBuD5ExaGoGKvRWEeEQPk6+1c1f9TTHFOnHRAqf3YTfrW4jgqHfRaPJba
 ZnokbbTDCD9xMOokgtT25vdV7pv5pMLgqLONoxVzalha3vyEhs3UkFTEZBWe4hbGOqS1YWvrH/v
 inVolZMNs7W2HwDwmtXvLch7kDK8NQZl92fqMpPe79LOQL78OSO3qlh6tLNOMNvG8BmNel+Wt+A
 3mFUzSWIhxAR0bEAsYU3ywOJZ2WxmkjVO64994ToaGQl81vw5Y4cZ9wqFZz1Itv+dHdk9/eoAr3
 rXQ9EV7RPP+o59+YqTA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bd9886 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=xt6ew7UTAAAA:8
 a=20KFwNOVAAAA:8 a=15fvszgA47yWHM4l5EcA:9 a=QEXdDO2ut3YA:10
 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-ORIG-GUID: oIZ2ytosk7kbrndMt4Vw_PGjpK1bHZf5
X-Proofpoint-GUID: Lte4NvXAfoUgjA0jO8F4SrewxnNVFHvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/19/26 9:53 AM, Arun Menon wrote:
> - Double the size from 4096 to 8192 so that we can have bigger buffer
>    enabling support for PQC algorithms in the TPM TIS interface.
> - v185 of TCG TPM rolls out PQC algorithm support. [1]
> 
> [1] section 46 https://members.trustedcomputinggroup.org/wg/TCG/document/previewpdf/45151
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/tpm/tpm_tis.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index 184632ff66..0df35d5a54 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -33,7 +33,7 @@
>   
>   #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
>   
> -#define TPM_TIS_BUFFER_MAX          4096
> +#define TPM_TIS_BUFFER_MAX          8192

Unfortunately TIS uses a fixed-size buffer that would now become bigger:

typedef struct TPMState {
     MemoryRegion mmio;

     unsigned char buffer[TPM_TIS_BUFFER_MAX];  <-- now 8192; before 4096


static const VMStateDescription vmstate_tpm_tis_isa = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_isa,
     .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(state.buffer, TPMStateISA),    <-- now 8192; 
before 4096
         VMSTATE_UINT16(state.rw_offset, TPMStateISA),

Problem would be if an older version of the TIS (with size 4096) then 
receives this 8192 buffer, we would (probably) get a buffer overflow.



>   
>   typedef enum {
>       TPM_TIS_STATE_IDLE = 0,



