Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98049105F7A2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w11dH-0008Bz-N9; Fri, 13 Mar 2026 08:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w11d7-00085J-4u
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:28:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w11d4-0002EE-OK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:28:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D4nWZl2256577; Fri, 13 Mar 2026 12:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yoHTn0
 dELzJnBus1wfWF/OGr8l39ij8XJzblbNzv57c=; b=UubouDs33DsVb9XJy8ucjW
 99QgRlQp1tgN3IHBF7lOmn5hqZQJEMV6HZyUlh7zuxqIndTL1HYKDXoFguNx/Ihu
 OTyFfjtL4vDQGnJv6JefJxBS4Qgei+jFsCwL7w139n0oecKKamnE0OE1L/japJX8
 iYtLLJz5M3Rk3s5Wr7H0mr9ysN4zcHCdlA6764lsJMW7CrTVRlqZOtqAx6ZPstmg
 wh8+2w9cWNEw7kyOMQZatq2SxDyTUbG9Ab8HWNCZkdW/AC+mcuis1F+QqdOiIS+i
 1FARTa9tGkFeCHyW+zojgG5xudS/IEbtqYH8i1CBimTdv4nfnedvUVc9g5UImt/A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92fqpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 12:28:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAUYhZ025678;
 Fri, 13 Mar 2026 12:28:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8ekv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 12:28:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DCSVYF21430874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 12:28:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AC4158060;
 Fri, 13 Mar 2026 12:28:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B76D58056;
 Fri, 13 Mar 2026 12:28:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 12:28:30 +0000 (GMT)
Message-ID: <693f669b-a8d4-4864-a85c-1223f4ab1a98@linux.ibm.com>
Date: Fri, 13 Mar 2026 08:28:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] hw/tpm: Add TPM CRB chunking fields
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
 <20260312041650.181411-2-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260312041650.181411-2-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TtCccZbtnvXa-4uBk-91oNlMGYNu9czo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX9hR4QRMNwVW0
 EDjUbmWAt8czb6gaCc6IbkdfelHUo78Cif8W/trnL4s4iaMHDHU0PoG4fMEZylHTKyD74oNNkL4
 6SGiP7RPT7MOUKxxlPyagAv4HSjNUBZAnn7I6ezE/Pzd4CatMwZoKwgZkMNTvbuS0JeIQCh73Iq
 mGROEDvoecNjy0On2xwqaeRuyu/LUGDIiAs5KaKG9ItOqGFSk56ooM1T3/KOd0ur0Cj0f6BjJam
 ECeAwKLgAgEh3HEJNbbb5f8FNEGwPT6WsX/d7Vvf++JetxNuIP9XDVL0LtjJGxbOoDJfAWX5MPu
 MZo+uPxfK4dBoFzjSuNAFllzlQDemvJVkTdaiO5tgO5pvJYidqwHWm1k4benJvl2vxE1zSVU1DS
 iKmhU3LpfxEM38XOuqBOUuhjyl2QgJmtkzWkqZz2nYVH7bifmacUWyOy5/O3+O6vZ6H/n8XlJE3
 sEDiFXKZntD7Nid7JrA==
X-Proofpoint-GUID: TtCccZbtnvXa-4uBk-91oNlMGYNu9czo
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b402f0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=xt6ew7UTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=gYlVodks8j_jG4ciMtAA:9 a=QEXdDO2ut3YA:10
 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 3/12/26 12:16 AM, Arun Menon wrote:
> - Add new fields to the CRB Interface Identifier and the CRB
>    Control Start registers.
> - CRB_CTRL_START now has 2 new settings, that can be toggled using the
>    nextChunk and crbRspRetry bits.
> - CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
>    this revision of the specification.
> - Refer to section 6.4.2.2 of [1]
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/tpm/tpm_crb.c      | 3 +++
>   include/hw/acpi/tpm.h | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 8723536f93..0a1c7ecdc6 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>   #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
>   #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
>   #define CRB_INTF_IF_SELECTOR_CRB 0b1
> +#define CRB_INTF_CAP_CRB_CHUNK 0b1
> 
>   #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> 
> @@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
>                        CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                        InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                        RID, 0b0000);
>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d2bf6637c5..03d452d2b5 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -149,7 +149,7 @@ REG32(CRB_INTF_ID, 0x30)
>     FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
>     FIELD(CRB_INTF_ID, CapLocality, 8, 1)
>     FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
> -  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
> +  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
>     FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
>     FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
>     FIELD(CRB_INTF_ID, CapCRB, 14, 1)
> @@ -168,6 +168,9 @@ REG32(CRB_CTRL_STS, 0x44)
>     FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
>   REG32(CRB_CTRL_CANCEL, 0x48)
>   REG32(CRB_CTRL_START, 0x4C)
> +  FIELD(CRB_CTRL_START, invoke, 0, 1)
> +  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
> +  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
>   REG32(CRB_INT_ENABLED, 0x50)
>   REG32(CRB_INT_STS, 0x54)
>   REG32(CRB_CTRL_CMD_SIZE, 0x58)


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


