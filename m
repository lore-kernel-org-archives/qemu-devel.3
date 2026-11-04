Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDD0606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kZQMQtp5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xORF5-0004wp-HO; Tue, 03 Nov 2026 22:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xORF0-0004vQ-Sn; Tue, 03 Nov 2026 22:00:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xOREz-0000F2-5T; Tue, 03 Nov 2026 22:00:46 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40i5ng3333309; Wed, 4 Nov 2026 03:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=slceQsSrUMSiOQOxz/5s+OARWwf7fSgVyeSfTd15v
 TU=; b=kZQMQtp5UJ9q36C6SZj3Ax+BqdMYWN2uBqGhK0aqVISm7+aFrMUR0VkPA
 d8NdePBzicpioD8jelXQFHO/QwKFXPr1Hl9QMHCnqjkfHxfDoiAshya+6B8Oal3V
 agHsDUWhSjlZUzKnjXF6Gbpd0U9l37iDz4Z8lZFe3aigc6gb6AVSuvPY+t2yXdv8
 22CCBT9xrcg+2B4i+ps2r924sBJHZAUodljP+L+1mESV2WV6cAqvtSFJy+IN9bv1
 Lm3PXM71bFxouKtJ0qssnNGxk8LoI+u/w4k/JOynKt3fDCwyRxjf1evs0zclQNmH
 Hv0/tu5MMZOzIU9sTryzEL7/mwBEQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826sj8q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 03:00:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40YuVx3409838; Wed, 4 Nov 2026 03:00:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gwqkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 03:00:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A430ak514090516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Nov 2026 03:00:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87BE12004D;
 Wed,  4 Nov 2026 03:00:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E72320043;
 Wed,  4 Nov 2026 03:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed,  4 Nov 2026 03:00:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 46E401616B1; Wed, 04 Nov 2026 04:00:36 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: "'Michael S . Tsirkin'" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH for 11.2] event_notifier: Remove assertions
Date: Wed,  4 Nov 2026 04:00:34 +0100
Message-ID: <20261104030034.3577845-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JP7l6aI4y_jJ8QmWHZJ_j1LjiWxye5OU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAxMCBTYWx0ZWRfXzANfdp/jyIhW
 XWF8VQ+u5BJjXRGZ5fa5RAz8K93jqubGtjkY0/ATA3YZpD+s99VJ+ufMlcY7fWxj79h4WXedUvl
 FVEWZKQKtmuyhAccRVTrjlTV196tuZlcdu52I3r54SxYuUqmdSfXtMkr4qKtKZ0FBpk5X9LnNv7
 uEYKkIQ3Qqe2JOp5s6HAXGtUkgTSYdfLbSMBG371sb1c5CQHC0xfZ/KHI5ANGmE45khXC20lJDn
 Aaku3E3RzJUf3QWanu6bc6RABa+FeW+uF4dv+wMx8O/wUfF/X1KYAI6WcFY8u8KdaP3V54F18pl
 xMh5E2pWpHdbuZ5BvtPemLGTv5u3r+cYS0fuBIYxWvGjKRhcmjU5OIdh4Bu0y640WjsP4iOvIlw
 aLjsKmOIK0Exks1apW9g6T0Jx0sLc9kaMoOvxv2qPmjVSvn7oOFiQuH5MpgScFRfjlrSwq24Sq+
 UEHDSySAsF0IxiWAFxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAxMCBTYWx0ZWRfX1g8Jmib7LOcf
 Y0ovQmZPgXA1Hk3FrzftKfv6gKIG2zNFJ0HUP6+PzjVFFOBL6ULv3lcBXS7KQ0J+ZFitnXnZD0t
 YcegWbDEqHKa+pOx5sc9Es3sFpyvAeE=
X-Proofpoint-GUID: JP7l6aI4y_jJ8QmWHZJ_j1LjiWxye5OU
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aea9fd9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=tc4oSNIvcIAa1SrH4FgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040010
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

Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added assert=
s
for uninitialized file descriptors in the various helper routines, becaus=
e
it presumes that such a thing is always in place once a couple of
problematic paths were corrected in that commit.

Not all paths appear to adhere to this, however. s390x breaks because the=
re
is no config notifier so things that rely on vhost (virtio-net-ccw,
vhost-vsock-ccw, etc.) fail on this assertion when called from
vhost_start_config_intr().

Remove these new assertions from the API; can try again another day.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA8+x3Bf0LDyh9hU6J9N-A8Lii6=
fb8orB2Coucn-fAYtTA@mail.gmail.com/
Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 util/event_notifier-posix.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index f595945af74..db53e0cee02 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -27,7 +27,6 @@
  */
 void event_notifier_init_fd(EventNotifier *e, int fd)
 {
-    assert(fd >=3D 0);
     e->rfd =3D fd;
     e->wfd =3D fd;
     e->initialized =3D true;
@@ -97,15 +96,11 @@ void event_notifier_cleanup(EventNotifier *e)
=20
 int event_notifier_get_fd(const EventNotifier *e)
 {
-    assert(e->initialized);
-    assert(e->rfd >=3D 0);
     return e->rfd;
 }
=20
 int event_notifier_get_wfd(const EventNotifier *e)
 {
-    assert(e->initialized);
-    assert(e->wfd >=3D 0);
     return e->wfd;
 }
=20
--=20
2.53.0


