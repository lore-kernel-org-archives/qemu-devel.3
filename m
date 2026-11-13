Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069C606A887
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=reSuYxxn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrZG-0001SV-By; Fri, 13 Nov 2026 08:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xRrZE-0001NJ-B9; Fri, 13 Nov 2026 08:43:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xRrZC-0007qb-KX; Fri, 13 Nov 2026 08:43:48 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADCEFgO2893588; Fri, 13 Nov 2026 13:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Nn2i1gdMtIc2c3D9nN2qKNGHmssBTfRIrw4fmxQbl
 rE=; b=reSuYxxnCBqg/hZ3ZWVCwa4L+/EcBugVOw/qJTSsNsB23zwscGtFU/olh
 64x6YgLaYyvnU6ULwiFaLZdisrxlA4490X2lHAWErNiO+6JG1JBjSt1R7IaxPcJX
 9dU+29hjoblfcfvPLvLtcky4vjv4GcCaB24X56bKdkkdXa2KqWf8A6LZDSrJIDnl
 xnUWxRJ9XLnnEF8IwHP6ADzpH5TYBYrc9HXW5wfixh41Nd9pQLHqv0tVe49g/XnL
 YJg2wbsNBwhu7icnffc7FEtNQMhXjIAvDaY5j1Rp4SGQwUIewGu5ZudLG1LKt7q0
 OBvXv+HrWH+tOxZEBiuRTh5eZROTw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvagsy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 13:43:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADC5Yw51149565; Fri, 13 Nov 2026 13:43:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k8en3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 13:43:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ADDhbUo34013474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Nov 2026 13:43:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 503B82004F;
 Fri, 13 Nov 2026 13:43:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B8812004D;
 Fri, 13 Nov 2026 13:43:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 13 Nov 2026 13:43:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 1274A1610C6; Fri, 13 Nov 2026 14:43:37 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH for 11.2] backends/iommufd: Delete FD during backend cleanup
Date: Fri, 13 Nov 2026 14:43:35 +0100
Message-ID: <20261113134335.2451039-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX0357PplG2U3f
 zXgIKxDO96XayX8Fi1AEv67zWh2Vqjwezkkq8wu0etm+L3m01zcxxdOFnSu8+l35PiDxESkP+8x
 tJZGFUL+r4lGcYzX4Ib+Vrr76Jerung=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af7140e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5-JOEWtVx1dYB_XXuRsA:9
X-Proofpoint-GUID: bWKL_tM05gG6mUP9ZqbebbKyZ3WrNhN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX4yTU/tVPWe0w
 qm5f5Xlal6Psc2lxQT4y7d8hJ/VIz1E34/8xjoDJB8x/SDnwXDfMdIKRM3mq2OeZxP4ViKBP5VI
 DpEqa9wIJ3DYTq4RDIkZnDwkJfWKNPr5MF1hwwBfjD+UBKErGZVFDMkXJq9GeUMdSY1M2PKbrLd
 Vpzw9KDb4ZbsfIeifCi6xR8FUUuzB9T7zREvRS5VSKCgIypzwyx+xdo+1C6E3GiUYWVvnnv354H
 HimOrdp9aMZKoaESUA7ooYkQ9B/OOBSiY+lNMlOkjGNymQTC1edvlWkpHbDeocGh6e3+rg2CJNK
 hzgr5csSfchpa7xtbGTf3sWHrvWda+4LZOndPKDKpPmBU0jaDh10dfeEjC6S8yQZfswo3Ft6MA1
 epMWNzx5/e6TqDKqcCUJBPtwP6g2WLXo83wbyAFzlZZyOLgX42hsdHzMwMHOKkhHJAAJGrt66jJ
 CYsku2Hn3v/4CSEy48w==
X-Proofpoint-ORIG-GUID: bWKL_tM05gG6mUP9ZqbebbKyZ3WrNhN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130052
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit de8002534892 ("migration/cpr: forbid saving duplicate CprFds into
hash table") added enforcement that the hash of file descriptors be
stored under a unique key, and will reject duplicates in the table.
When using a device with an iommufd backend, performing an unplug
and replug presents the following messages and subsequent hang as
reported by the host kernel:

  virtqemud[1172]: internal error: unable to execute QEMU command
    'object- add': cpr fd 'iommufd0' id 0 is already registered
  virtqemud[1172]: internal error: unable to execute QEMU command
    'closefd': File descriptor named 'iommufd' not found
  kernel: mlx5_vfio_pci 0004:00:00.0: No device request channel
    registered, blocked until released by user

What is missing is the cleanup of the iommufd fd upon the unplug,
such that a re-plug is able to create a new connection with a new fd.
Add this to the iommufd_backend_prepare_delete() routine once the
user count drops to zero, to allow subsequent (re)plugs to succeed.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 backends/iommufd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index ecf4caee1a8..bb3219767f0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -72,6 +72,9 @@ static bool iommufd_backend_prepare_delete(UserCreatabl=
e *uc, Error **errp)
                    object_get_canonical_path_component(OBJECT(uc)), be->=
users);
         return false;
     }
+    if (!be->owned) {
+        cpr_delete_fd(iommufd_fd_name(be), 0);
+    }
     return true;
 }
=20
--=20
2.53.0


