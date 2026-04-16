Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C0CF8D74A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDNYl-0005a5-79; Thu, 16 Apr 2026 10:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wDNYj-0005Zt-35
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:19:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wDNYh-0004TI-DY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:19:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G0RVBK448054; Thu, 16 Apr 2026 14:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QU+pEJ
 f7XKlhs9ZuHflV855M/GoePN8N7HvH0iC5m8E=; b=O/dRGAJSKFDBP2CrRLhZjB
 ysH7OU+PlFc8GSO8L5lMZs62TC5qpzQTge2Kp58Mb/XzzUaZ58qxP1cw2hWzfdkY
 vFewJW+uInKQburp86CoqOsHOYVMYxr/pGtDQ7o2NehZGi9q6eiPHfo9vSgEe7JY
 dhw8KnYx/uF58rkKVvn+i4dR6WdOtW3MUGOFkyNXRhkD72/pzZ4wYeqg4840HACz
 OxJr0drmWGAO3DL9guq+n211kSrKssTydqIAWyMpu4svvQ2vDWtzX8+y7dap60+h
 d4Wy4LqhO7ltzMXo9rxy5KCwU9kM6DUE3WsYJB11MULbIt/nvEWZkuhhDoTgwTXA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nnwmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 14:18:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GC5kY1003557;
 Thu, 16 Apr 2026 14:18:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnk6up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 14:18:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GEItwq524810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 14:18:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25EF458059;
 Thu, 16 Apr 2026 14:18:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B586E58058;
 Thu, 16 Apr 2026 14:18:52 +0000 (GMT)
Received: from [9.61.155.222] (unknown [9.61.155.222])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 14:18:52 +0000 (GMT)
Message-ID: <f0944f1a-0c56-46ad-94d5-4164a72e123b@linux.ibm.com>
Date: Thu, 16 Apr 2026 10:18:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-5-peterx@redhat.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260408165559.157108-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pFDM7TdSid2kOFbwcfp40rvNMKfdFjHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNyBTYWx0ZWRfX8UBmfY2Gtqhu
 LJA1m9hxpTPwTiIkz0vGanydMLD02gZPG/emVJo0HKN3K6nulc7jYhWgRbuYM2MOTQjb48i/RRS
 ipRCvcRV2KmejIFY5NAeyZ6DRhvOPD/lMdRkiRcKEv5Ut34q9nqkzd6qn+cSm70UExgKv16VsF1
 Fwfm7fYydVl6fWHS/6cJsGZYSt47FbEYRAzPOhmuwCRmyF/St+OoAY9dWtgyKPoJRJLnvfRd2Ss
 tXACEN7Oox2iZUamzkQkZKPx6lv28PBNX+xOxT/jcenMO0eQDTsC94tWkOSKwxev9ZthT9QQxLS
 TJywFNxQy7WfDB5xSwySMs29oLRAtPLqFnoUsLVnUFf5l5/cCAPFR7mv9d2xC9dpc6uqeICtszs
 IKBi0whbyOeIse39IrIw3CKH5a9XkFJFeSW+WeNQF7ST5BjpiN2i5wlaqnXJ0shkSBUFvKDR1FK
 uyA7WGboevHnEzdjE6Q==
X-Proofpoint-ORIG-GUID: pFDM7TdSid2kOFbwcfp40rvNMKfdFjHJ
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e0efd2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=RS0Bc_3cr1L00H40IvgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160137
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 > ...
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index d808ece3b9..a22469a9e9 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -187,15 +187,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       return 0;
>   }
>   
> -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
> -                               uint64_t *can_postcopy)
> +static void cmma_state_pending(void *opaque, MigPendingData *pending,
> +                               bool exact)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>       long long res = sac->get_dirtycount(sas);
>   
>       if (res >= 0) {
> -        *must_precopy += res;
> +        pending->precopy_bytes += res;
>       }
>   }
>   
> @@ -340,8 +340,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
>       .save_setup = cmma_save_setup,
>       .save_live_iterate = cmma_save_iterate,
>       .save_complete = cmma_save_complete,
> -    .state_pending_exact = cmma_state_pending,
> -    .state_pending_estimate = cmma_state_pending,
> +    .save_query_pending = cmma_state_pending,
>       .save_cleanup = cmma_save_cleanup,
>       .load_state = cmma_load,
>       .is_active = cmma_active,
LGTM,

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

