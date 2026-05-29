Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF44CD5BD1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 01:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmDU-00082b-3o; Thu, 28 May 2026 21:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wSmDQ-0007yx-6V
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:40:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wSmDM-0002YN-Ia
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:40:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SKkcVQ562524
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=vmvfZN+8SOiunlx3UPKywYilbsihiMYpMS4
 9JkiGC8I=; b=lmOnDgLHUcsVg5g6GaIWSQzzSVf1S4Ih6wZgFyhnu8efo5VCvAg
 ovOsidA/1zjNdIwqsZMD+kMFhq4atdeCmlGBY1FyIlZBkz4YexMp/7EjlDI7dRrf
 O4H5N8S1MWC193HJ4jE5Kd0/QLCI6h/4/Ln5bweLoP8yMc0Wr69nxTmcjic3+Hyp
 qOdCxNFM3D4UpGUVxQ1XuJ3ER85gsGD/6kCKiVJ+8VyvXQv4xKuAL+D7efNjDcug
 sgevefmZHVb87Ye09OFQyN7ACWvS1g6njYzdh9e75fYAqnsNv9AgjHpAK4jGO025
 /abYbtQClqRT9OMTWzYdqgNI57zpEO+RUrw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevug13e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:40:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3041ab826ddso13816981eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780018836; x=1780623636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vmvfZN+8SOiunlx3UPKywYilbsihiMYpMS49JkiGC8I=;
 b=VyokJ2gHFEOWYdmDZpuB2hbf31IHTtbJVg1ldOdA+EQH1Vvs2h0ibpZgSKHbN0tZ17
 Tbtt2gcLK7e4tXUgxKNNKujaLRuGjpndQ4657pp0vgbKBkkk8qfrCv8SS/PkouKVxsrm
 pOnckhzRcF475xfT8VN3r1pjrpftw/f511xXSeazHKnz7Z9Kt9RIMt/VdFyBA8tjj63l
 WfDRp+BtvSwIGjsB70XflijBWfbULT20HaG3woOTdCD9qt4aOv/SchQe5DgOu1IwZCYq
 2GBtyzp/NMBdKj1fZQkkkGbQy5qWR5+MQqDgrPF58/B7KAuivbX8FlLtoxwb3pVct8y/
 mzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780018836; x=1780623636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmvfZN+8SOiunlx3UPKywYilbsihiMYpMS49JkiGC8I=;
 b=nBxMaQqDZvS1imFYPl/7a4cQ78KNKQZfp8NBvUQomwsxNwCYh+EaPqutS3b+oGt6Nd
 lWRlKLyzWeIDTIefooi1Y9ID0egCqMO8fkI06a8iJHMGGLOn7HIhGSy9NYYE5Ad6jM/p
 vYu1Mj/MzOUyqiDP0fn7y/yB0CPbf/bVhQW5nmV9uuYcnjOnqgLkObZEzZNor+RyOhcp
 yuzxT3wK4UkWZ26v7Lq3UJqwA9iQ2GNunNTtdVUY3eXgfZlesV+1zZCJlhc9GFj8ta9I
 r1V/REaf+9h8DtR714kEPief7Oq3WNmyXaIEINZTtcgFxXx58Nu5MQ893KikHGqX0p6D
 BFHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UI86yXQWdkWbjnSaaZJBK0dqxgA79O+mGAgFoIB+9kumnaY1yPJY42lBtRS478WDrXAwXEgn4Ye84@nongnu.org
X-Gm-Message-State: AOJu0YxHkTtzRw1Z+I9LD5N+2QbtQm78CV3zoLoL2Zb/ONr6HaEtwbmm
 3wR5ejm0Fshl9O+nbLqLM3LNVr5cNKvvP3xmvdxen7OQv9NDpPBmwqLK4TqIpxHUM6uHKqJYcpz
 /fbn+TojdIi46OC+ksyMmoBeTSLSalNugIf0E4cxQKnvv2SZy89/JjFE+dQ==
X-Gm-Gg: Acq92OHgvqfIfZL95yVXQa+/yO2k5ubbd8C1KMey3JthkkujkB65vBGUchw/OkXsV/c
 6lyPtmHpyQmWBMilWC+Qavo808Y6V3Th5GHp3lQazZ076NgGp/Shk3nF1j+mwibUHpezfH+fRE0
 /qArxNdrdAZIEPvhRpWGdf2G4MAhxg0ZV1oe2kbFYd71U366rBtdVkqhjz6AuOwZu6QovQhAqKk
 qzOjyyhzel7oZz6tmq6DOel4LSNCCNJby0j2yHj+sTTHcJg1cVnYwHG9QVTmul8rS+kyNIkc9Qn
 16TqBLzp01P93NiJ6H7+BI7m8aFGoiodqbzUiCYatQMe1Vca1LQ6LWhQEccEpmdK7GTntwnooG2
 f3LKk16u0ZPah8MicIdf+gTS6u5+ZPtP6OuQ5yhA5yRvIWwJr54TQdFPP2uO48im5sLjG157qvV
 ikF0bpLviPAhk=
X-Received: by 2002:a05:7300:cc12:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-304eb0d3423mr390318eec.18.1780018836361; 
 Thu, 28 May 2026 18:40:36 -0700 (PDT)
X-Received: by 2002:a05:7300:cc12:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-304eb0d3423mr390307eec.18.1780018835809; 
 Thu, 28 May 2026 18:40:35 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm237263eec.4.2026.05.28.18.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 18:40:35 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, jithu.joseph@oss.qualcomm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/i3c: fix DW-I3C FIFO depth advertisement
Date: Thu, 28 May 2026 18:40:32 -0700
Message-ID: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAxMyBTYWx0ZWRfX5IEahwzLjoiX
 gfp9SrLG3uJUV0mnPPHDx/M9sRHWAM1f5ck05hBFvGggg2qBJMElzZMNRQ5WHbW/B42srVMSyhJ
 zhWUds4mkUhmD1CGWsHLGbZ8S/qOp37wDWLn7D+ui7h4cVg7tOG78iwVfhKolv6ZUxmh90x7JoT
 pB+CYNnMniz9aO9omvsvljwGHanTlnQqxbHv9Lq+chadNisZdKel7BXcVeFcPeQQ0xEMFVYrFW3
 2Kc0OBQiXxWdHjHLL2fzEyK0+s90iK/LKsQj1rat96nTfiIgrH4sWeGlaY1VYNofELOkSsWcPA2
 NgYXa2lEMfZAgJlaUPlgvUncJH4D3BCUiIF6/dLgwy/5OP9jXTbmHAIoFa6Cg/opBSBomGMQ6yR
 tem4DTQ7HCi8Gzz5uokCtqegHmYSTO9o+3/P5aMHcnIepRGa/+2teDg8x/xLINmYawK2iSSGGeL
 dYvjwRBFUkf/hfuGNmg==
X-Authority-Analysis: v=2.4 cv=SNBykuvH c=1 sm=1 tr=0 ts=6a18ee95 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=WHkpnssFEwZg4ikl-WMA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: XyVyslVlxlMXLXOIr5LOqGNmEhODFCbW
X-Proofpoint-GUID: XyVyslVlxlMXLXOIr5LOqGNmEhODFCbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290013
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series corrects the DesignWare I3C controller's advertised
CMD/data FIFO depths and cleans up the misleading field names that
made the bug easy to overlook.

The Linux DW-I3C master driver reads QUEUE_STATUS_LEVEL and
DATA_BUFFER_STATUS_LEVEL at probe to learn the controller's queue
depths, then rejects any transfer larger than what was advertised with
-EOPNOTSUPP.  QEMU was resetting these registers to 0x02 / 0x10 instead
of the real 0x10 / 0x40, so the guest believed the controller could
only do 64-byte transfers and failed any I3C transfer with a payload
larger than 64 B.  The backing FIFOs were already allocated at the
correct size; only the advertised reset values were wrong.

Patch 1 fixes the reset values.  Patch 2 is a no-functional-change
cleanup renaming the queue-capacity struct fields and device
properties from _bytes to _words, since the values are word counts
passed to fifo32_create() -- the old names were what made the depth
bug slow to spot.

Jithu Joseph (2):
  hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
  hw/i3c: rename DW-I3C queue capacity fields from _bytes to _words

 include/hw/i3c/dw-i3c.h |  6 +++---
 hw/i3c/dw-i3c.c         | 28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)


base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
-- 
2.43.0


