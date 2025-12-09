Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BB5D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 18:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT2Xr-0006vp-4m; Tue, 09 Dec 2025 13:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vT2Xp-0006vY-4e
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:34:41 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vT2Xm-00079H-V7
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:34:40 -0500
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B9HjYGY2762499; Tue, 9 Dec 2025 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=jan2016.eng; bh=rbKAW4DCTPkc+7NDY3Ll1h1knsFD1QWPt
 G35cUn/vuY=; b=U0IP69yhTMUlgyZYecePNVtrYLhhnVEhZDupMWN7n9VZ+k0Qb
 QmYGrczRTb92pAAtpn9Xbx6LBalSbazMzTqMQY9+Udj+5bcrGBOzda6k/EWcL9YA
 KKpmFGsyN/Cp5uRsJM2bGR80/hKQsNf6T3JPhafmuaKhusSDeC+PquR3J/I2UeAF
 IBUrN/xTDdUoOQtJ5+nktSAuXqqe1itmppus3EqrFd3139MScXJVOlSGENDmo2yI
 3ZsHWzWQoLE+GcZpqy0yJhPvevKzEwjjwxg17jmhj8L9N/LV7TqMXL1hMSm9YnT9
 WCp6T6pklGFqtrQxKL21/4wQUf0caIXUsTXXA==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4ax7rhu63n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Dec 2025 18:34:35 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B9I3Afp009434; Tue, 9 Dec 2025 10:34:34 -0800
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4avkbdvrsy-1;
 Tue, 09 Dec 2025 10:34:34 -0800
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 3A4D880;
 Tue,  9 Dec 2025 18:34:34 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
To: qemu-devel@nongnu.org, clg@redhat.com
Cc: mark.kanda@oracle.com, bchaney@akamai.com
Subject: [PATCH] MAINTAINERS: Update reviewers for CPR
Date: Tue,  9 Dec 2025 13:34:12 -0500
Message-Id: <20251209183412.3903519-1-bchaney@akamai.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512090138
X-Proofpoint-ORIG-GUID: zRhy8V5Ftz-4mGTZ-2qDJAzjUtEaXqXI
X-Authority-Analysis: v=2.4 cv=SKlPlevH c=1 sm=1 tr=0 ts=69386bbb cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=X7Ea-ya5AAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=4VVcHpUFlTeZ-k0x__MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDEzOCBTYWx0ZWRfX5oQIGt9iWzA8
 /5ZflHn3/S8gtqnsnpYx7EDMuJCixptElUYJVv5EVxqM3tvnucxapnuT4eJq01I1L08DMhgEG1B
 SngyjzOnYaZLvT410d7PBpY0684ESVqAKYFcR39WdtAQDFVMZzohuWphaAV6HYA519RQnjaLTS1
 xl2xuQgNX+kr1VL/Qnz8uvKFweYi8arGPhzPexMwMKDjP21Qg9/3/BVBSswL5BuT8oafy+VFxHd
 G6uJ4JJ5n11LBcOyTtmgzpplXkpVqNKHhB+0iyrsX5InSfk+FNJXtB4mRrf4ypetqgRNIf3jUug
 Kx9K+Ss/7WXq4SoctBSerqXnAASaz77g80+XTb8gM1l/GR1EeA7KWfPfWAQjDF6pxXsEear5K/3
 AiJLAJ+iiYs5evNgNttctDEPOPRLjg==
X-Proofpoint-GUID: zRhy8V5Ftz-4mGTZ-2qDJAzjUtEaXqXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090138
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..812c86fab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3116,8 +3116,8 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
 T: git https://gitlab.com/vsementsov/qemu.git block
 
 CheckPoint and Restart (CPR)
-R: Peter Xu <peterx@redhat.com>
-R: Fabiano Rosas <farosas@suse.de>
+R: Mark Kanda <mark.kanda@oracle.com>
+R: Ben Chaney <bchaney@akamai.com>
 S: Supported
 F: hw/vfio/cpr*
 F: include/hw/vfio/vfio-cpr.h
-- 
2.34.1


