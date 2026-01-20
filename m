Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412D6D262A0
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJ7j-00036k-Ej; Tue, 20 Jan 2026 16:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1viJ7Z-000358-FU; Tue, 20 Jan 2026 16:18:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1viJ7W-0005Cj-Mx; Tue, 20 Jan 2026 16:18:41 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEkiMw019662;
 Tue, 20 Jan 2026 21:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BLji5a
 96jeOz79j/oKbXxdKjU2QVJZ9WogJMo7MbMfg=; b=QWpD4cg5DWYlmOcW22olYt
 QfekJEpvsx31KHJjiXvaHo4DRRBmG6ZdktNyP27fG1cYGRnxiiG1Owpnvv0GEiLj
 hj6KJutj6ckWf0cMshSz7VnEAnjKcv2JLrQGvN+bJRAWLHI4CkO8Ws1/cUELfOvr
 RsGyu/O2If/Jw6AAZ0AYjPg/7HEYJsaIKfLScKTrVt/S2DIHr5QOk9xqIxqcdpM/
 EpDZY/G/tYCG6+YTHgcFRW4qPANl3n9eJsAUP/zrSOr3LmGYZi43Le80dnPwuagd
 ujtEWGYz9RVtBJ2BT6A21zco9M1nqO/fWGCv0qXePMCg2ubLn/vZdbfduqq+ENiA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2560h9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 21:18:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KJJMgI006451;
 Tue, 20 Jan 2026 21:18:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1fmwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 21:18:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60KLIU2J25494052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jan 2026 21:18:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 133B05805A;
 Tue, 20 Jan 2026 21:18:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD31C5803F;
 Tue, 20 Jan 2026 21:18:28 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.131.235]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jan 2026 21:18:28 +0000 (GMT)
Message-ID: <ef086589932b5f3bac39a46eae24cea8cc425945.camel@linux.ibm.com>
Subject: Re: [PATCH v4 07/23] virtio-ccw: virtio_ccw_set_guest_notifier():
 fix failure path
From: Eric Farman <farman@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, Cornelia Huck	
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth	
 <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Ilya
 Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Christian Borntraeger	 <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>
Date: Tue, 20 Jan 2026 16:18:28 -0500
In-Reply-To: <20260119185228.203296-8-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-8-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE3OCBTYWx0ZWRfXyNm76T3IratU
 bMw+ZgHxLXqmoGu5B5fcvEgKcBuLvpUQWPhC5hpGUjpTaIaBpCEbeWKiX4ZO7QrklO+Qp9DHnsX
 GRfrxtmzyj/rAxzqLTMi2J3nrtgqCIr8OgHwm9Hu82Azkkfk1ZEyWIq6HE2Zu1S0CUkjfFfYV1t
 KUF+Jb0nxgRe+pxI+WATQyJSYpX5h6EbYPvBJzGp+m4bf95jrp5c1n2OTPvL5j68Z3L0qzIx6qf
 fKkjdJkSppJoPQUKQWI3ILHL21WM/SbcRrkRx/bU0n3W319vZO/7e308pYTasWenwQN/NSxC8Kt
 PiMZegF8uZYHqQugo6C8W1DOv4LKkTp98fnKJ4t7QCYvJwwuBllP6BwEtEtmvoqfIkTWVjHGVcc
 ZF7CCSJSRO8P0acGAeoBlQR1fHejnRnXo2oans1UHxylvhJB/YLH5Gia1TrfRz4zoT8ptTjZtS5
 +j7KD2+bA6vgW+5I3eQ==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696ff127 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=49E5kkUQfOZ3Knp8DMQA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: fArTHAy0BoNr68aUq1kfTqg-hIF05Bok
X-Proofpoint-ORIG-GUID: fArTHAy0BoNr68aUq1kfTqg-hIF05Bok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 2026-01-19 at 21:52 +0300, Vladimir Sementsov-Ogievskiy wrote:
> We leak notifier initialization on that failure path. Let's
> cleanup it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/s390x/virtio-ccw.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

