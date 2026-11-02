Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA1606ABBA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZZ+6IxdH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwA6-0007mP-KJ; Mon, 02 Nov 2026 12:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNw9x-0007l8-VN; Mon, 02 Nov 2026 12:49:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNw9w-0001QX-4K; Mon, 02 Nov 2026 12:49:29 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HiQxK1933872; Mon, 2 Nov 2026 17:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Lzwa2Ly7KFIjahhSneRhG5TBBsz30tHOKyBhH1VyF
 ls=; b=ZZ+6IxdHe56hdr3nZk5hIwsHppWz7ksNvii5R2iKYNGTAUpiJ57H09LRN
 22AAwaDJ3o7bIGVhteTNPUlVbKtvRVyBJ4+GRLikLWnTicEbSX15NzeQ4sde5vaO
 jsM9lRIAv8zLWQhdh4ZNWHbj8yEPV/pYgIGWhaEH6UR56NWjA21lDYc4GMzUFMni
 ACpgOOVovLLkyHSPiRacMuyWywm2ua6/oYtbNlG/bhxWt7sS3xGHqf50fbEFQqFB
 KGZiKNEIcye5+qWjTNviKEcHbI9tirhgE3oQnTsfDRRwOob3Rzi3MDse+KDe/19d
 UkcVaRWsQi8Mt4VzxxGrCKQWhhSHQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sj1er-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 17:49:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HYx871340225; Mon, 2 Nov 2026 17:49:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gq1e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 17:49:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2HnKOP45810108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 17:49:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 662622004B;
 Mon,  2 Nov 2026 17:49:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46C6320043;
 Mon,  2 Nov 2026 17:49:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon,  2 Nov 2026 17:49:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 2EE04161028; Mon, 02 Nov 2026 18:49:20 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH for 11.2] vhost: do not get config notifier when one doesn't
 exist
Date: Mon,  2 Nov 2026 18:49:16 +0100
Message-ID: <20261102174916.2301985-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cHEYhr8GnsY1mTSN3hHujh-EgdCiTA8H
X-Proofpoint-ORIG-GUID: cHEYhr8GnsY1mTSN3hHujh-EgdCiTA8H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3MCBTYWx0ZWRfX6v4PHFqyFAoa
 czlqYJB4QwiBIIMPZhkonxR3cIN6HWi4g7Ne1jazWA9DlNHN+9RFHvuCVbW+dMA7R7FVDdeYXeA
 SDmSEf50R3lSHVol6cmJYZpq//EzPBnM2gcleKHzYwi9vrUNwckI1s9OxnuJnSBsDqqb00hTl7N
 uImvRH//WaagZA5PbogQh+FOpBm5xqDZb6KdcMy1P9+NL7L2HzviYNLkN92RbxBsMOXCJzzSIJ6
 bzHk8wCmMomfiRLJR/VEtg4EQujra8ps5Xn8lPu3aAehlmxvI3BcqA62x++7ua7g8oE59jdrgfk
 082NyHw1QIkkIoHggXpHlsxbJ+9KpACGpOE2IDkfjq/aH/RkMi7ub8yBAdvBl6DQYr3s6VV5tKF
 oVSQXzPVVevxKJ5FZ8pAYSKnGBse6907aCTG8Y06jDsc/czam3XzBsGAkPLO206tmVciRYgxu5/
 XhDrbGaj99Bg2KiKPXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3MCBTYWx0ZWRfX/Shg451KrLok
 kOivhazBxhz8Fl56OUHVE8R9szxsYkUyuv/9WiMaKXxr09VzajL0i736P7ISSJQlxxS/XQ2UZw9
 yYYCzBjNpKzs7RJgROrYSDq14nuoQ7E=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6ae8cd25 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=imYxtfgo-3jAVhZrOLEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020070
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added an
assert for an uninitialized file descriptor in event_notifier_get_fd(),
but it presumes that such a thing always exists.

Since it's only vhost_ops->vhost_set_config_call that expects to use
this file descriptor, move the retrieval of that fd inside the non-null
check to avoid an assertion failure when it does not exist.

Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b25919c5c7d..998518c3b2e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2119,8 +2119,8 @@ static void vhost_start_config_intr(struct vhost_de=
v *dev)
         virtio_config_get_guest_notifier(dev->vdev);
=20
     assert(dev->vhost_ops);
-    int fd =3D event_notifier_get_fd(config_notifier);
     if (dev->vhost_ops->vhost_set_config_call) {
+        int fd =3D event_notifier_get_fd(config_notifier);
         r =3D dev->vhost_ops->vhost_set_config_call(dev, fd);
         if (!r) {
             event_notifier_set(config_notifier);
--=20
2.53.0


