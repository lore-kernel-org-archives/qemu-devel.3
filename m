Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180C3CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6pv-0008S8-Kk; Tue, 23 Jun 2026 15:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6pu-0008Rv-Dl; Tue, 23 Jun 2026 15:31:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6ps-0006nk-No; Tue, 23 Jun 2026 15:31:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmRck1914571; Tue, 23 Jun 2026 19:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=H2xSPS
 DZmlm8KEXtdzGCk2krR5LR9yk8Z5jPEESiGCI=; b=O14hJ+XXLoOcfjjE7lkwrE
 HDCR4Qe/F8htvQqmYVAcGX1tdpAlkaBCYqUk+Cvvz/maZu7c3n3ci8Oj394mzKD0
 py+dU3OPK6HuxGXie/rIHvZhIUohaFJ27vfMKTrpdeX+tChDVlE/YHZu0mfwdr4j
 ECRvXbeMBFAlxHA4ia5Z0HNSuMHa0Ok1NTZCwRXcj51pWtC+32XhEixR4rnQM+14
 e4cgRJPgULebhT82kFu374fCiS7nCYVRNJO6eEtCrfwgIBN+RKUznK+1KvZAROd+
 4QFU5fU+edOOs9wH7zRAJoWGt0WexCFu2upBnWbuY/saHcwtJ7PXs1T4XFFr7maw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4gh45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:31:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJK2Uj001546;
 Tue, 23 Jun 2026 19:31:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg4tu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:31:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NJUxGT28115542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 19:30:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3964458052;
 Tue, 23 Jun 2026 19:30:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B56B58056;
 Tue, 23 Jun 2026 19:30:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.119.138]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 19:30:58 +0000 (GMT)
Message-ID: <2c8b9b6a1fee7a755fc207ea97f1b671b0c42a04.camel@linux.ibm.com>
Subject: Re: [PATCH 1/5] pc-bios/s390-ccw: Refactor byte swapping
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Tue, 23 Jun 2026 15:30:58 -0400
In-Reply-To: <20260623002539.126124-2-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX6OeCKMnJTjFY
 jQ3YaX3IGdUeLaJquMfL2x+aetHqQO45tJbgeNARroKYj/wzbq7q0wJLrHNVOnmmWv5qorvUk3k
 GFO9RcyquHP/tMxLYLh3H67ANlbnj4o=
X-Proofpoint-ORIG-GUID: ZR-6NhRTW9nZCeg1FS1gmiQ25swlUOox
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3adef5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=-Bf714O7gQZDNXjWMs8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX5Xj3zt4GDasH
 JjwCyio4o6sUs/+NQtjH0rg+gdeZLke+v5r+3CF2c269jFeSL96LBaBwLsLKkTfQI3d3RJC8bXN
 2E9HSGli4hnUsg4PPu1HIhX/YZpoSkmsbPs7wLUuu11L8GrQ8X7O67HLEtTohgYa9QWBWZ9ImF1
 dOAisqQtj+DhZT/12EBuqofLt4J+O6/EOw3iHMhkmGg896EpO+p/18D4DTeqiE9/usHYJ7NFX7O
 6gdRI0/EKMaGIuEUOi3sHbR/GUFzqSgZAPoey7yJ0WqB8iwSXEhpNlYcZp7zn6msmYiKOAhhikx
 kt9kIWv7kg+yNaXYz6vF7bf+dND6DnnjeWfwoVa1Cx3ZiGgYydgcwsX0NEtd9+3XwdVrwoPc94y
 b6jKRIAJDE4p9l+cTwyYjOlvQCLEADe5flEzqmgcluhk7KnXdmXXXleopSGdCWVaXe28d5tRarj
 j2cIOXt/tFCd0VmLoog==
X-Proofpoint-GUID: ZR-6NhRTW9nZCeg1FS1gmiQ25swlUOox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Mon, 2026-06-22 at 20:25 -0400, jrossi@linux.ibm.com wrote:
> From: Zhuoying Cai <zycai@linux.ibm.com>
>=20
> Introduce local variables to cache the byte-swapped values eliminating
> some redundant byte swap operations.  Additionally, do byte swap when
> polling to avoid a special case where endianness is preserved.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

