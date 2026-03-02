Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3121D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwttu-00049t-Oy; Sun, 01 Mar 2026 22:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwttm-00048L-Tq
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:46 -0500
Received: from p-west2-cluster6-host2-snip4-10.eps.apple.com ([57.103.70.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwttk-0008It-F7
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:45 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPS id
 445AD18000B4; Mon,  2 Mar 2026 03:24:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772421883; x=1775013883;
 bh=Lk6bTEpwGD75rPYbjWBDL/wm+6tJrip/XWCznrT97K8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RMzH3RxzrGpFkr1C7RWT7AV3apX/1TtG96K5fAL8xOx8QV0A5Mr8WoWxvYD6zHdobQ0ZK4cGd5770hopRJV8EvppELEDjOZkWOHKECQiHd2pXGCA9Z4iLpcKlx9+xaNNhD9xqqZE59g9EL/hrdNp1tTFUC4hV6USTBWB5jFzlJVcm+CWPnwmDVHnx9pqBzFOS7R5/ZsXwIcoZYpS4DRfygEZTQC4AYnJ9xTAKSq35gTw3vhJ4BGEATZus2jfiFgH4unHuXX/VgmL1CSXomiBjpt4nyttv4sNL/b8HmIIMLzSqG6jzN4iadNAcNqNvB/GHWptAR4kQG2MU7Kaxuk9Jg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPSA id
 1630B1800094; Mon,  2 Mar 2026 03:24:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/3] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Mon,  2 Mar 2026 04:24:33 +0100
Message-ID: <20260302032435.42698-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302032435.42698-1-mohamed@unpredictable.fr>
References: <20260302032435.42698-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOCBTYWx0ZWRfX5aQB0RG0a125
 JnKnyEp2H4mo5VmqpBbYFUAMdy66HCnHR7k/UJg3eq1ZwwNlnZrkxDsVqZvooXWO65817i2FuQZ
 UTNtC5eBNlJwXV8tc7wjzxI5FpcKb7dBJarKofxtFt3dzZ0iNAInuShsRl507obyL7tTeu+OFkN
 dKEB91nfLsrAV3z+0646uyeM1YSAW46E/4nUcUcsgiJQdGd/3NEcbG2pVprVJSf36cciZKGFUQR
 ZIvF85y6vUeeFBj7iBcwtEX/9PmxnQIrxlrVNyNRaasnv00Pnk5f+75y7R/yekX0hgKNCDyZlbL
 E95enbrG5WHtmJsh8zVjcx1JHoIPknF6ZSOvL4erNPDYT29si2E5WEZCYd3NfA=
X-Authority-Info-Out: v=2.4 cv=J66nLQnS c=1 sm=1 tr=0 ts=69a502fa
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=eKpLbWQDCUPTAuIwU-0A:9
X-Proofpoint-GUID: H6GMC6GaLdvb4M4qJeC5r_ZFQJIJ19fo
X-Proofpoint-ORIG-GUID: H6GMC6GaLdvb4M4qJeC5r_ZFQJIJ19fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=832 lowpriorityscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603020028
X-JNJ: AAAAAAABCaXxZA2Dqa2lliHjvDk8kpD10J9L9Xuc4pEA0B2RwgyA35T3Cx4k8aL9QfiaGnH81ZWg2FYEutzMYbDImh/WJULyZ++udB2AtOSgoEugow6QqH6w3NQgUpJqOOS/Lzvx2x0LG1+L1ipyzlrmrswzbTbUhYK4TnEY1eo4lj1Tp+1nfcD4MtzzRINoT++60R7m/v9Pv57u06EP5ho0TzLb6LuRTFnc+TPHnDkkF9gMeJT1AZhD2Qhcd+pNfFiZAgUxWD0unmCDk3vdYkMtYel5+uedsiYnCXKoepAKdYlz9h6/dxp6pTPXfsAc7fkJNd1Zgqs5biLUDKx+/eQYrNX7J7WfFI1OnWmB92Rkw9RH7A6IvyhFtWctdKUdwpPGdYd5QuxrugmAhQ927LIZgiaJML0VGwKwltcHyfmH1TC4K9ERPySaN0JoLQehVKWTKq1h74RC8t3yFE5HEg1+VlarcpDwLWYI5iJLjEPWiE589aOBQPjFDDyxSD9lnQVqSvyzup8M9SpjpDYAMr/J1/QsViiezrSTLvdMZo2S/uRwF1mrezHihd9cOOKQpj/NdFQCl5/R7IZglymE2YS6pBHmBMHa/rU1oa98ZFahLmEgwD7mqKPUSzcRlPHXkYGqdhtchaBG0eK1+MVLoFRS4IC48rVxD2Dl9WMOt19lw0qizDr/J33nSPLIgtWVm2kGW/nwJW4r
Received-SPF: pass client-ip=57.103.70.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This combination is not allowed as of build 26300.7939 and results in:

qemu-system-x86_64.exe: WHPX: Failed to setup partition, hr=c0350005
qemu-system-x86_64.exe: failed to initialize whpx: Invalid argument

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bb1afb9cd1..99c4d03f42 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2145,7 +2145,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.50.1 (Apple Git-155)


