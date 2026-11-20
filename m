Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4670606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W1q9KkRU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULOw-0008DO-Vi; Fri, 20 Nov 2026 04:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOs-0008CW-PA; Fri, 20 Nov 2026 04:59:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOr-0007dO-6O; Fri, 20 Nov 2026 04:59:22 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7uHKG2481564; Fri, 20 Nov 2026 09:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BBF5kif5Zw6Etna1U
 QHQlEvFyAUqEEM+KzGKXedmyOg=; b=W1q9KkRURLl9dwNuEA+sqzALZUR6AKxmL
 QJymG6eAjbfCUqMIi8IFfwkgP+Dsz/uAnypLgFCNuXUYCHIKgvhfBGYRVtf/Iy8W
 hQpew5/PeBkfufmyoiBRV8C+LNPD23Z7EjG2ffZKpItnrga1kGeMcP7yIpQV8Ouv
 AfMYyBdbtzbQCidogjHA1YHFhiVgSXNQORC+DbHTDsfuH6fBM8/m0puKSxfCW/hi
 aqbNjpnaJSbtZmtRU5HBvcap/gcQJhRDT2pz/EqBxRJlxmRulehMinFL745KQ/5J
 YH6CLwGzR/HYIeYqq/kfEiLXkN5FEts7X2PHUcIGGz4CYr2zP9yUw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x78af-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7o2xT3920831; Fri, 20 Nov 2026 09:59:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xfbsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK9xEmK52167052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 09:59:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 676AA2004B;
 Fri, 20 Nov 2026 09:59:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9051520043;
 Fri, 20 Nov 2026 09:59:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 09:59:09 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH 2/5] tests/functional/ppc64: pin machine types for hypervisor
 tests
Date: Fri, 20 Nov 2026 15:28:55 +0530
Message-ID: <20261120095854.35941-9-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261120095854.35941-7-asahu1x@linux.ibm.com>
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wb_cDxoUEFc9teQquDnxh1gFXSTWVfSb
X-Proofpoint-GUID: DnCr7PMgRsOF_emqkC3AiSt4o46DmJgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX4kCEkWpvNT1y
 YK/ybdJRPt/VaDWext9i+g2b8Xc9hX1hMdXxMm+sPRUKSy4nAuQhcPKKBfxAUvxD0wkwHreT27I
 LoU4l0z/ng+YO0XWduMYgWS53DEz2XyB47BObXXKFwgw8qGZgCt3GDfzXtjSnXMFh0zombz3tsQ
 /43wvjMIutcMvrwotjU7Iq4TYJul2H/MNEtdNfB1uCHCxCNRJVK9zFPAapXgITbYpn/4P139Gdd
 QnhkfJ2g8Yp9Xpu3GTDnOWzYxcWJp54kb8sqzs6+7ggm/q1jcMubl91RNHxHzWvFSbivuP6GW2l
 wzgIg+R/8DVtRI4ed0uFRXByU8VwMNFQg/L6Hl4C/LJsV8pXohzzolkR35ktmYzWb4vpXdV/Ngq
 iqOIkY5m8wgbphmngUOCoUg3+neP5dBP743mqtBZUdJJB3C9cfjkeZdJv20bZMpSmLY4SHe+5Ue
 3Abqxiit27BnbikO6dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX5jfV0TnmH5/U
 g/9t10ewb7Jjqmx9vncHgaC9Km4zTxRPZOk2ZGplo/kMxQLKOmtZ9ifoolX4T2LL6/v3060Oag5
 6Eim7qTCarChBNDlX0lxJHTjtjvp+8o=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b0019f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=w1IKqmJAaR0_HpmeUyoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Pin machine types to avoid CPU compatibility issues:
- Use pseries-8.2 (POWER9) for pseries tests instead of generic 'pseries'
  alias which resolves to pseries-11.2 (power11_v2.0)
- Use powernv9 for powernv test to ensure consistent PCIe topology
- Fix test_hv_pseries_kvm to use TCG accelerator (L1 runs under TCG,
  L2 uses KVM inside L1)

The generic 'pseries' alias now resolves to a machine whose default CPU
(power11) is not known to the qemu-system-ppc64 packaged by Alpine,
causing the L2 guest to fail with "Register sync failed" error.

Signed-off-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 tests/functional/ppc64/test_hv.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
index 8a1fca2cb1..d977038271 100755
--- a/tests/functional/ppc64/test_hv.py
+++ b/tests/functional/ppc64/test_hv.py
@@ -125,7 +125,12 @@ def do_test_kvm(self, hpt=False):
     def test_hv_pseries(self):
         self.require_accelerator("tcg")
         self.require_netdev('user')
-        self.set_machine('pseries')
+        # Pin to pseries-8.2 (default CPU power9_v2.2) so that kvm-hv.ko inside
+        # the L1 Alpine guest sees a POWER9 register set.  The generic 'pseries'
+        # alias resolves to pseries-11.2 (power11_v2.0) which Alpine's packaged
+        # qemu-system-ppc64 does not recognise, causing the L2 "Register sync
+        # failed" error.  The L2 script passes '-cpu POWER9' to match.
+        self.set_machine('pseries-8.2')
         self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
         self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
@@ -135,10 +140,13 @@ def test_hv_pseries(self):
         self.do_stop_alpine()
 
     def test_hv_pseries_kvm(self):
-        self.require_accelerator("kvm")
+        # L1 runs under TCG; L2 is launched with accel=kvm inside L1
+        # (see do_test_kvm).
+        self.require_accelerator("tcg")
         self.require_netdev('user')
-        self.set_machine('pseries')
-        self.vm.add_args("-accel", "kvm")
+        # Same CPU pinning rationale as test_hv_pseries above.
+        self.set_machine('pseries-8.2')
+        self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
         self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on,cap-ccf-assist=off")
         self.do_start_alpine()
@@ -149,7 +157,9 @@ def test_hv_pseries_kvm(self):
     def test_hv_powernv(self):
         self.require_accelerator("tcg")
         self.require_netdev('user')
-        self.set_machine('powernv')
+        # Pin to powernv9 so the PCIe topology matches (pcie.0, pcie.2) and
+        # kvm-hv.ko runs with the POWER9 CPU model.
+        self.set_machine('powernv9')
         self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
                          '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
-- 
2.52.0


