Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339B606A332
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Al3hyllL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIJ9-0001mm-2k; Tue, 03 Nov 2026 12:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xOIIT-0001cO-Ks; Tue, 03 Nov 2026 12:27:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xOIIS-0006Uh-3l; Tue, 03 Nov 2026 12:27:45 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EE6uv2251362; Tue, 3 Nov 2026 17:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0oO+vuLvf7d81YehrCQEVWhSl7ylkDd8aqbBQkp8t
 ic=; b=Al3hyllLFPzq1cbkTPN5Bv9UgQah0a4R/gCAV1jh9SWNb0XMp/RrIbI//
 TGx+M2k3SK6XsguK3+gv8aTnUfg29RrF0xCFF+6G/JvFz6u99qNORSUfimKYCMeN
 rtL0QzH/B8AJrhDaob8mYUfSS7LHLvtP/vbnpqIDrNV+y8oa0GMo0FkYpPkOqbsg
 l1kw+Fdx5g8HV+HzZjAi69fgHNps//cwFlLCW3/VfFRUxnlPipdhgaFnR/IiT2S7
 iDX509WA0haO7H3wOHDByyk26tSj0+LV/KPA5ZLtG8x2ghgSv/m9FRL3UHC/r3Wd
 5mttGn+6K10rhSCojHvpF2bJ5H5jg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3fbm6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 17:27:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3H8cm82695639; Tue, 3 Nov 2026 17:27:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gup6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 17:27:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A3HRZhN37421392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2026 17:27:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A102004B;
 Tue,  3 Nov 2026 17:27:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C19DF20043;
 Tue,  3 Nov 2026 17:27:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue,  3 Nov 2026 17:27:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id A7E39160DF7; Tue, 03 Nov 2026 18:27:34 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH for 11.2 v2] vhost: only use config notifier when
 exists/initialized
Date: Tue,  3 Nov 2026 18:27:32 +0100
Message-ID: <20261103172732.837511-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aea198c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=imYxtfgo-3jAVhZrOLEA:9
X-Proofpoint-ORIG-GUID: HEAG4OSXlKpdCAKDRae5LGHBN8tdbBrA
X-Proofpoint-GUID: HEAG4OSXlKpdCAKDRae5LGHBN8tdbBrA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2OCBTYWx0ZWRfX1JI2tgGJizTg
 8Nbt9doah0D35PDP/ChZACPgH3llETfnxoVM3eI8UfjzQ6JsXOC3edFrCSQrdcVD/zFJbkWIO4T
 73AKO1ye0AELqOWtCd7mtkjCK0pQyYAa6hwIrLXKNIIXU/ndoe81hMpm+yHRVl1szGU3xZkMm0p
 GOrrwbi8vJ5TPYfoEvM0JVU3bBHAS7mxEHvbTatez/2Nl3kBrtTWGsAalMgE6odtcgfH3jmv8bT
 Wlhc2AWjVKfkE0ZFTKsEnpPfWx8+I/df20OYyM6Hvf/d6wcUHzfzh1jZz6t7UdBE/3yiF3d2Mc2
 RW2sqih1swCHteZCJGfLLXsoY2KwhoDSMvnNSSg7y1PlAjyIQWKMruo30kzklvUVMEPoTMxm+ns
 VqEIj9sWbj1grGBvTd93B2/x8Run45M1dkJIENzWiPgcCATx+uLWq8K+4fcKsKY9By0mOyH8yP5
 grp+G4wOuR37we52ovA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2OCBTYWx0ZWRfXxc1UQ2yW95bS
 u0G4oBVAuLFcRJ06se4zwgM5xI5yyEnBv6Bc+Lmdit0yjgFPnOVyrm5ZVooMSMwxEyJ9mnIjUTs
 e5ZBNdk5SkoZdYGEj9D1JETh/0bAXR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030068
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

On s390x, where a config notifier does not exist, this is a breaking
change for any vhost-backed device such as virtio-net. To remedy this,
move the acquisition of the file descriptor within the guard against
vhost_set_config_call and expand the guard to ensure the notifier is
initialized before being used.

Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b25919c5c7d..189ac541178 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2119,8 +2119,9 @@ static void vhost_start_config_intr(struct vhost_de=
v *dev)
         virtio_config_get_guest_notifier(dev->vdev);
=20
     assert(dev->vhost_ops);
-    int fd =3D event_notifier_get_fd(config_notifier);
-    if (dev->vhost_ops->vhost_set_config_call) {
+    if (dev->vhost_ops->vhost_set_config_call &&
+        event_notifier_initialized(config_notifier)) {
+        int fd =3D event_notifier_get_fd(config_notifier);
         r =3D dev->vhost_ops->vhost_set_config_call(dev, fd);
         if (!r) {
             event_notifier_set(config_notifier);
--=20
2.53.0


