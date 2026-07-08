Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD533C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whT8A-00009e-En; Wed, 08 Jul 2026 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1whT88-00009W-EC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:20:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1whT86-0005fK-Rp
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:20:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668CIfbX2335744; Wed, 8 Jul 2026 14:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VAq7aY
 rRLJMTPnyyykA/r8mymIVuMvK/Tv8h93S/iQ4=; b=DiJ6vVrwxtQQPVAbelPoTT
 ULca+8Z9r8og5VCvHi0bvG6cttuwKB/bWNjI+GxPBa8wk3xtEZ9nZSHHDhJelaOG
 /LhTwhIm1zihvnrT3okULWvNJ3wf8v44+h45ulP8XaibYwvdV9RknhDLjVjyexc5
 OsJCqsdkxrseoXOqzTkdI6ljcSVrEH0Lbz03Dijc0rKGCK7AtFeeKIc5YFfRNrHo
 DsdlSX5qi36+2EcX/25VTU3zpbrWR9B1KbvunpDhWYI8/7uIbjs9Ig5j4kM8QAAG
 938jOsOxKOVHAz+8fR0oyJWF5I/caRfsKnsWCRSNpvIgAtyr6S+nXqEGDVasRNEw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsw59v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 14:19:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EJjAA017287;
 Wed, 8 Jul 2026 14:19:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq8k8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 14:19:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668EJq3M65012138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 14:19:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A7A15805B;
 Wed,  8 Jul 2026 14:19:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AB0458059;
 Wed,  8 Jul 2026 14:19:50 +0000 (GMT)
Received: from [9.61.10.20] (unknown [9.61.10.20])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 14:19:49 +0000 (GMT)
Message-ID: <6bb9a8a6-e7db-4182-ab94-6b75666be338@linux.ibm.com>
Date: Wed, 8 Jul 2026 10:19:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] migration: Run final save_query_pending at
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
 Lukas Straub <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-4-avihaih@nvidia.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260706085211.13905-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -XHzoERjpNjjVpcquF-SJEGIosBeMklM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX3cJOqpO26RnQ
 9vEnT9+ymv+crvaovYn32z0gqskW8SqNIDeEiBTX3Wreptf2MLKycHg+/oPMv1GXnCHNOLB2H2v
 95080QoEZJ3rUgiiGs1mgiDiCp4DVEc=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e5c8b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=7SLSWBKCu6aSPr36NZ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2qCytMQlHvKjbbLmho-mQwfvKmIY0ph4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX3YTuljLaRApk
 L7z0m+eyJ8hfGaHDOelC4j8ypdCMudtlhhjogQsfgqlQTUGZBcF1UE0/n5lylEn+DdF/Hpr2/48
 oNsWR+fJvf9YhvzgWNGUfgaJtIXRKItf28fpnZqhQB0K1tOnZvkz0GBvSd6gmNr/XB1tvW5HEF9
 oDmOpZZLJWeZV38IqPlJQ8JRtEWcdFNiuV/yW7MyIBBgI+ISDkBqHsuepaRy2hjrIhn/nGuN2d8
 iiiyB943b+PKP8A+XBIqIWl2AInyAEIS1Vnr+HHU1dCTVGcbP+8bP8gjqVXWAnl0WXpcjNM6bUH
 Gcvnlh6o2q/Mj8d7gKfl6FEqVoYXH533ijpRcsym9SL1deFpeyR52C9SjRAJthuQW2OLwJ3eS8x
 cKFNHyMcIQ3l1TaeydxyTV4RUYuhqk5AKVUuDC7XhxaLDl6+cQwXBgCQ75cFhh7wjj01l8M34VN
 +zM8D9ojxdJC69I794A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
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

On 7/6/26 4:51 AM, Avihai Horon wrote:
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
> Call final pending query also in COLO checkpoint, which needs to flush
> dirty state before the checkpoint's live state is saved. Unlike a
> regular switchover, COLO reaches completion repeatedly for every
> checkpoint, so this must be done on each one.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/migration/register.h   | 41 ++++++++++++++++++----------------
>   migration/savevm.h             |  3 ++-
>   hw/s390x/s390-stattrib.c       |  2 +-
>   hw/vfio/migration.c            | 11 ++++++---
>   migration/block-dirty-bitmap.c | 11 ++++++---
>   migration/colo.c               | 10 +++++++++
>   migration/migration.c          | 14 ++++++++++--
>   migration/ram.c                | 40 +++++++++++++++++++--------------
>   migration/savevm.c             | 20 +++++++++++++----
>   hw/vfio/trace-events           |  2 +-
>   migration/trace-events         |  2 +-
>   11 files changed, 104 insertions(+), 52 deletions(-)

For the s390 piece...

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

