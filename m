Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A32DCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcxx-0002Uv-4b; Mon, 22 Jun 2026 07:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wbcxt-0002Th-OQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wbcxs-0004wk-13
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:37:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAnEEZ2712749; Mon, 22 Jun 2026 11:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JrSJm8
 vr2E4OUu6mgMCm61CK48lr6jO1pcJaF6z8ZFE=; b=eGFLsmLKxyEyhfzkPk8lnb
 E3bTE6AiQbkBBGvyGOKy4/uPsYjdWL3tr3LkXAJhtSHqnajaBWOnl1tV3RrE7acZ
 wgQWZH6CETF8uqm8Z6iP6iDAhUdChyngyk096lKlxjEv6WzRgA1J2Fdjm9hKZIyf
 V8SqhG+sdhIsEfXtnb7J9lku8Xasg0uTN5ctzWyRyVzDE1Y9y1RAOBIl/z1Din/i
 Efqd6JuIaIX/axYVNL6mI0KcnQD2mmCu7Qb6r7NG9GVaNelQ+MeGZbuFkdSmJLkD
 cG3rSaBN6dp0gyHt/GROJtqSG0kO4yMQa2xoLcsFlGO8ePisicD28Gp5gLu3ew1w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqgu1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 11:37:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MBYZgL024589;
 Mon, 22 Jun 2026 11:37:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q65t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 11:37:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65MBb8BI26870360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 11:37:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A839E58056;
 Mon, 22 Jun 2026 11:37:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2EFE5805A;
 Mon, 22 Jun 2026 11:37:06 +0000 (GMT)
Received: from [9.61.143.217] (unknown [9.61.143.217])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2026 11:37:06 +0000 (GMT)
Message-ID: <a20da0b9-a698-4f1b-930a-1e6c15fec819@linux.ibm.com>
Date: Mon, 22 Jun 2026 07:37:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] migration: Run final save_query_pending at
 switchover
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-4-avihaih@nvidia.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260622101214.25770-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a391e67 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=K2Trgu7Bcb2n33MZADgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX2SA85SV2K+MO
 3Iqmu15z5ay9pNboBngVJMAu23SIIl5xsyAqrZwjISEBHf3msP/3gC3EdCAkM7xWh+MJJFKhFmN
 nq4ImHYr1jy2Rh6gkxsYePIbf7kpXwv5dWX5x3xzdkex8Y+pxQdk10u7rlkBjzQZIucPlhjUiV5
 t3AYO/WS1yPLrWXliEmxLMxIQtiKQxb8jnJjzimRxtft8dPP/Z+wQz7G/z+NilMO0EmT1brX9wr
 ut5Ox721a4bMX0EcNrTkGs4CiAmKTszFeDRDq2JHF3icNOM5xXmPaow7amHefsDRPu/gI3of/eB
 OWaFWCqLZ/kr1rn7A8JBZ3FcVEvCCfB4ObVW76cgCzVA+DOksT1CuqvFf+UN+D7mm4VH6kPXZIz
 8Kc6UgZeW/PM6BGt/Bl9jQfD3t/8xDhDFPDzSkAgSgdYhusO7wySDs+/XbseHAM4W4F5cUzi5rs
 wlKf4T68aoM4g/CSxSQ==
X-Proofpoint-GUID: GBJj_BvP1CPpghAjGdDkRc6hWEioIqFp
X-Proofpoint-ORIG-GUID: GBJj_BvP1CPpghAjGdDkRc6hWEioIqFp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX7Iu1feva33SR
 Yd0tUv9xFBFLgi1NgiIGvC9odM5R/mPkxu3d1JvYLVXjSlBhf97u6BzJ9Q0XbIRO3GETvSgXoCF
 Q1O5zNVh8oZn7YbGBOd4Yk/1coM0EBI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
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

On 6/22/26 6:12 AM, Avihai Horon wrote:
> Before switchover, the source needs one last exact pending query so
> modules can flush dirty state. This is currently done ad hoc in modules
> handlers. For example, RAM syncs its dirty bitmap in its save_complete
> handler.
> 
> This should be a general concept relevant for any module, so extract it
> to migration core instead by running a final save_query_pending before
> switchover.
> 
> The final query requires special handling by modules (e.g., it's called
> with BQL locked, during VM stop), so extend save_query_pending
> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> flag so migration modules can tell the last pending query during
> switchover from periodic iteration queries.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
...
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c334714b31..b0f04eb30c 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   }
>   
>   static void cmma_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
Reviewed-by: Jason J. Herne <jjhern@linux.ibm.com>

fwiw :)

