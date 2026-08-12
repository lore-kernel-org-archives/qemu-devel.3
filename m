Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7985EC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIRR-0004TF-Un; Wed, 12 Aug 2026 19:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRF-0004PY-EK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRC-0001SC-Kf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CEp9FM881381; Wed, 12 Aug 2026 23:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=gqf4b
 jSNLm08jyB0dCIC6aS4VvZmDL+FUiWRJ5AFlbI=; b=SNk3F4LNR29DxDFyKGCnS
 1HE6NEzsfHX/oY6ECA4+K8jyGPs+zAmNADEWMkaurEBR4JS9SduKTOtvHodFYCf6
 QNznq6mDUF7aLyq12F1yM4kpac0Pmg4HNOASwjyPzTBQV7nMVitqItIUUMP5a4g3
 Fv+N6z/qgRK2xXnpUGs95w8roIkdZFET2+KUnbvPACZWK/CZT9rirsv2nyd6BJ7b
 gg110sN4Clh2lofGSzRXGW7zTKsuPOhJbR3hIGtTST+iZhhMFg0kGhe6ai+EVJWS
 BpVoXDNwhe1/fZ8HM/ZM+ojg+k1r63c70Gq9isokpcxmYthh4n9qsB4UAMekYqlZ
 w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvh2fk8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67CNTx4F017385; Wed, 12 Aug 2026 23:32:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fwtwfngsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:41 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CNWbHg025569;
 Wed, 12 Aug 2026 23:32:41 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fwtwfngqu-6; Wed, 12 Aug 2026 23:32:41 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: [PATCH 5/5] migration: cpr-exec memfd transport documentation
Date: Wed, 12 Aug 2026 16:27:50 -0700
Message-ID: <20260812232842.470225-6-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260812232842.470225-1-dongli.zhang@oracle.com>
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120190
X-Authority-Analysis: v=2.4 cv=M6V97Sws c=1 sm=1 tr=0 ts=6a7d029a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=XpoGA2NoF1k9M7sJ63wA:9
X-Proofpoint-GUID: ZmMnRn94STqqxAJxUgESzewuLZU-r5FM
X-Proofpoint-ORIG-GUID: ZmMnRn94STqqxAJxUgESzewuLZU-r5FM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX2fSlle9IQhFV
 2wGx1cCQFRTerlMPkfmfhAX3Abv62ZmikGGFLY/weAAyGr8J39vAgJ6Quc8SWVxFzq6rIllAHKp
 LOptC037atVqE9AQQa2Kfif0k/ItbEihdUloKUti1PBdlSkIx5T/1LzjB8uA2QvoDeHN8iGNEv7
 1qQathPy7px2wThiZs+bfzo3xxojnEDZGrVchTmwdn44B/flfpjWw+aWKie7+Bl0GlrQrARyyI+
 iD4wr4e21QMRRZagV3LykdO8T54L2EfYHPIuI22cdKgbVZSYmPazCkKpOuNzDHdZXrzzQ0M1Jn/
 dT2KLj9j3iAJND70mI6IgUHKT9vrcBnfVML8uPAPzceG0hi2z1hl9BQRNGPLHwv/dLqtBtDn52+
 K1jNfO+JNtGvUa/i8bibF+UISkUfhhw5VFaU6cFJC65zUOOigauEI7CZggKI/P6TtdKA+whxOTl
 4GfNjrcC9mdL6SNFUIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfXylJbFrz/84Yp
 16aUD2nj9dRsMcvyPC5dIGL5jg9DBbF4jNMZKNAd3lPFF8rIa6KJ1E+Wp7y9/pAwF5K0Lm8rpor
 CqcjKtiwwTQOSCMVr6cZvITtoYwfE1Ves/F6zTwN3obsRbfnTqfJ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Document the cpr-exec flow using the memfd migration transport. The example
keeps migrate_incoming explicit so the command sequence mirrors the
existing deferred incoming flow.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 docs/devel/migration/CPR.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index b6178568a8..8afc83a08d 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -369,6 +369,10 @@ Outgoing:
     a ``file`` type, but one can use other types such as ``exec``,
     provided the command captures all the data from the outgoing side,
     and provides all the data to the incoming side.
+  * Alternatively, use the ``memfd:`` URI to save VM/device state
+    to an internal memfd inherited by the new QEMU.  The new QEMU may
+    use ``-incoming memfd:`` to load it automatically, or ``-incoming
+    defer`` to load it later with ``migrate_incoming memfd:``.
 
 Incoming:
   * You do not need to explicitly start new QEMU.  It is started as
@@ -424,6 +428,26 @@ Example 2: incoming defer
   (qemu) info status
   VM status: running
 
+Example 3: main state memfd
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -machine q35,memory-backend=ram0,aux-ram-share=on
+  -object memory-backend-memfd,id=ram0,size=8G,share=on
+  ... ...
+
+  QEMU 11.1.50 monitor - type 'help' for more information
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming defer
+  (qemu) migrate -d memfd:
+  QEMU 11.1.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: paused (inmigrate)
+  (qemu) migrate_incoming memfd:
+  (qemu) info status
+  VM status: running
+
 Caveats
 ^^^^^^^
 
-- 
2.43.5


