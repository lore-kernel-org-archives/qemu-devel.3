Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F1C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lQS-0002Z1-CE; Mon, 21 Sep 2026 17:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x8lQK-0002YF-W3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:19:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x8lQJ-0006CP-DA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:19:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LL6ZxU2635312; Mon, 21 Sep 2026 21:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CH/nqg
 zm+2Ff/9xzBEpTUjLb8yI6/ZuSQvqMDnw5/Q4=; b=UaYPor/Oekl601wjVQMk76
 wIjhq6WrCk5R7ez52UUDl+SJnWtpMedWsZC7IhuKSsnXIZkQWMFXrjpfGaH5fVCB
 XUMU7yC4ihUu5hVuFwyZKU+goGAZwSUXIOC+XBvAoDpvklvVCrS/VVbdL0RXPcXO
 lzvsQTSMiXNztOeykltl1h6yDDwH1AT9gnLZaaKQ+GdgEjpWQOGcLetRLLunNHDh
 +OAFr7eRcD9Hyt0KIfIrDIaEsmitYOEmyKvpKhTVHkNmRGhMlc/nz9XryWsA9IC5
 LMFgkCEKd50z8V+I2UibHXC78AF8a4z3hmVNXGASvxY12VE61218yzvD6cyPWLCg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv2k2j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 21:19:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKlY1w554589; Mon, 21 Sep 2026 21:19:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk9pe7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 21:19:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LLJUPj33817312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 21:19:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00BF45805A;
 Mon, 21 Sep 2026 21:19:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A7A65803F;
 Mon, 21 Sep 2026 21:19:29 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 21:19:29 +0000 (GMT)
Message-ID: <7ba6ff93-fd7c-4329-9b05-204e9c7d7e5c@linux.ibm.com>
Date: Mon, 21 Sep 2026 17:19:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/tpm: Block CPR with unsupported CRB chunk migration
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Arun Menon <armenon@redhat.com>
Cc: xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260912-xen-v1-0-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
 <20260912-xen-v1-1-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260912-xen-v1-1-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: U8T5On-oluWmG5fO3RsKdTjn82nytmmX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMwOSBTYWx0ZWRfXxzM6dPuqEpZD
 JQ2jODHmoTmFPLAlCOMAmZrze6dapbCm7LmWj3MkTFJCeVIk9H56BQc6Nbn4PAZKclOypba+BCR
 p38FH5hWH/+jodt6NsHVuZgrPmNu3Dg=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab19f63 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=wMWkrOazxYPWhfr2cWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dCq0QmMIDtwMHgqpSfOzgX4KAAfr4PZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMwOSBTYWx0ZWRfXyZStMPDy51q8
 4//peDjD1kLixfqez7oPBy20XvxGD6dT8aPErHJRCsZXZIrqs0q472FO+/vTsLEF3Gbvq5/AKlk
 wE3HZPGGvpH0xIe/zL19iZuby+E2SycfBZ6JOCnwmH8j0jIaK08cc1XID0O01ByIBklCZ8jVXya
 RvLeQqWDjekTFfi2KHixpvYhx0v/XycpJEN2TIPMW++AoV7yoU5NXT0cBKaDvy7lleE7GKrnWRD
 YNtxcDA/0FRcFvRBJXN+zpV8wBjhdALgg/nlTQ9ldL7Qk7YQbqOtHri1IH19XP9gGZQPynWgIF4
 +VXDj7N+SP6DxP2klI4RG5yp1WIfoJsmER8Mlj3lBXFrhWDa52CnUidsW3HqBZzbJiq0Kq2aNyE
 fAbT6r19Bq8cEwwug5guyHXTEb44RTbJ1cGW3FJvLUYyeE1tznn2q2rwp3wFyEACS1h/MuYUMj5
 sJX+LFr/AZ6ck7OINig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210309
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



On 9/12/26 1:31 AM, Akihiko Odaki wrote:
> Currently only the normal migration mode is blocked with unsupported CRB
> chunk migration. However, all CPR modes stop the VM before saving.
> Stopping only freezes an outstanding chunk transaction; it does not
> clear it.
> 
> tpm_crb_pre_save() waits for the backend request to finish but may leave
> command_buffer and response_buffer with some state. Those fields are
> then omitted when allow_chunk_migration is false. CPR preserves guest
> RAM or selected kernel resources, not these GByteArray heap objects.
> Block the CPR modes too.
> 
> Fixes: a8aa1b220c71 ("hw/tpm: Add support for VM migration with TPM CRB chunking")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   hw/tpm/tpm_crb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 54fa2042b5a8..943809103b63 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -482,7 +482,7 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>           error_setg(&s->migration_blocker,
>                      "The tpm-crb device does not support chunk migration with "
>                      "machine version less than 11.1");
> -        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
> +        ret = migrate_add_blocker(&s->migration_blocker, errp);
>           if (ret < 0) {
>               return;
>           }
> 


