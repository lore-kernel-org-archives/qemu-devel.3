Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743FC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sm-0006US-Rt; Thu, 03 Sep 2026 06:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sZ-0006EI-9o
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sW-0006dj-Mj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHDPx212469
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OwfosKO+kwb+j/x9ZXToNhbIX/BpKhbQ6Dr+/Zkhuxc=; b=THtTySsU2ECjsSws
 jmZXoMxLkculCz15grjrEDJWUsAxAAoJkW1nfwH3f2rYtW01qdhuNArHjP2t768j
 kCGhpq31HUcc4mqWBnOD3cSfbu/9V+jgYY49gFl+LPsHtIwdj1YGdYgHSVdHF6tY
 mbdWoYy9VY4JJ4S848Pc9up6phcR1MeFwJTDOfxP4iGo7zCeChT6vNDbFhKrSRnC
 Ppr2wZRYZfVX3AchGSyCvCoGSw9K93G7+k/QfVj/yZn8muwudKPjrUfPRKI1frc2
 8QEF3IPJOCVDM2BFU6oseA0sj1NcqU8HgpaCkhgctFlaDJMU3hC1GaUiuMSPP0v6
 hcgyUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhfqf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so409033485a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432066; x=1789036866; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OwfosKO+kwb+j/x9ZXToNhbIX/BpKhbQ6Dr+/Zkhuxc=;
 b=XXzdDrleoOG4IpHPephBmGoPyWc5UsTYLKQS7eqw32HV5fD2QNnq1wkWjSfeHep45t
 Ljv4pWvu+spFRSyjAM5Yf8c8xJJCKeINAEhuF5GrBviNyu2pjfYSpOC5MmkJ4lNAOCo6
 ebWiFg4F2Bi/wq/HLFn2MIeFDk1YOORzt0Zzgtnx/MFk1wLJ49AvfiaXFkIqlwtNfOZB
 j783rVX/Pbh3eqslT3FdXlmUyj0b8DPDPkxOPiAeLYiFsupWoCwMURWzsXsXbcViStL6
 QphqUwGQZtuCEsuh6rGK4h0/rXSk1iPmtxYOJw/wdpwpmvkKonm+heVUwH7yy2Myb6fS
 v1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432066; x=1789036866;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OwfosKO+kwb+j/x9ZXToNhbIX/BpKhbQ6Dr+/Zkhuxc=;
 b=Kg8GcTCSrtjAq2aAtZ9pI0+mcBIMAdwOHvkEWbejbITaEV68XIuUghNdUdl2+0dupj
 fremWokvaYXbbJ6Hwrswa63/bVWULfujBx2WYx4WTyjq9nQB9dKpycWjRA+qMneIDsTs
 zGMR62TXm+BYzVz4TdhkXejqJ7wuQlCatH8wNnfkE8oQlwe5iKt5gbIPQC5+6krajH/z
 f/Sem31FktuPen/GTyadEsVYbY1yemjvYy7t8TBWfOEZ1U2cPcA8DyPqYDQy7l9IutVd
 1jOyGa21CbTzJVwHiOdC+0Eu5T9DNT7bubIOEvzZ+3Qtabsvhnj7jOT6pqUtfvkXG5XA
 3vOg==
X-Gm-Message-State: AFuF++lYOwztedGvQwXfc1Jz8KMDghBGGoiY0gZY0EhxjFQZzGd9OGw9
 EpeRadD91Qzlqwfeff6UaOlhJCdPOuGEFPZB33oQSu2BsqG9BTfbUIwiNn56GIkEw5p42PEk4p5
 FctzcqRu8gAT1cC1IOAT4ILOxMz9FyAsG9q37FwiOoznIiZYKnOIK0HaU9sxsxyEyAQ==
X-Gm-Gg: AYBFou0SUo/4EllxOl/eg2bEXFCmXBJJQR8l/XnzwUK16Eun6OOkBK/nrP6YwzkNBR/
 5RqDnIuixa7K2xRgt0MLRDkbEpuQYiLyf/Dk2CEbWWLvyU95ZyniS93bwJe06OT6VtCo94dbWZU
 gniVJDDz3PujE/DPwJ0ndSWApE2l7YorMIhMIx1DHIW2v26QWC8xCNRBh/o3TlPgAHqB5R84QT3
 7RL7mQ8xMb7BgQNmwvIrHVRAsH//n8hx5BRDxBBgpBozY1L1mpHNM/opSVOnaOo/eVmYJUA7AcL
 zOtTeOnZ7opEUMv4Cs+jniRdc4I299xViIWPngaP8KeWlhmEfOFyKA82UYzLDxPX20lRsWnKJDJ
 kySKZN/kIB/QQrwoX2W6T42mnlYBHLLwEev2cMmqt
X-Received: by 2002:a05:620a:2881:b0:939:34c6:a333 with SMTP id
 af79cd13be357-9396100e7e0mr1059369485a.40.1788432065692; 
 Thu, 03 Sep 2026 03:41:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2881:b0:939:34c6:a333 with SMTP id
 af79cd13be357-9396100e7e0mr1059366985a.40.1788432065187; 
 Thu, 03 Sep 2026 03:41:05 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf2abe1basm30389585e9.10.2026.09.03.03.41.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/51] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Thu,  3 Sep 2026 12:38:56 +0200
Message-ID: <20260903103936.62355-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2oo8jLSQBfYp
 ZEHApDkLOUV+0mKeGAhM3MjK6vRiwLJ8sH+RzoF/SDTibzoAFBmjZ5f3yCGMvrhicjdBra11jhY
 +kfsiHfqT37t/yV/Fr2HOGNJrX5zUccgRr2SWz864z5LzwTOxlSuyoUZ3hznDPYw3ceOtX1HZGl
 CjOBnctu45SqCtGotw7bA6zzjKRcqDgbhfv/TRAwXlDmYLabAcNtFhvltdZqDMA9goLoP0MnIO1
 rfTnZ6iilyjja1uN9i4Om+srkGtAKuoqHqb2dYih5mQ50720pev8H3fo+Xpgr5PcUqq782xGppH
 zCsx2HZHuAOwcQXGPnifzK+MnryuSMrvxbZvFue/1erHmmHSmf/nU7BO7NeR210s6beRwQl2AOz
 evd13ZC/1KDRYsL/fYx7MfwniovK7gzeQjruknNCmPT4TtyY/XjxuH3dkPbW8tIMIVr2aTYZwpw
 eRlKE/BbgadgtmgC78w==
X-Proofpoint-ORIG-GUID: JOzvO1U1sUNPRG91IMTSBBSU4u90cK86
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2IamfwlRpWOq
 UeBhHjZOcbshY5zEqw7x2nIYahKaJOdwlKgMYnav3mBqknmzFRwIkrTjT43Pozvx9Q8duIKid99
 eonsyHcOnWa43u0v6oo2NXhqi5k7YjA=
X-Proofpoint-GUID: JOzvO1U1sUNPRG91IMTSBBSU4u90cK86
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994ec2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=PgTHkcLAMzWx5aaXWEMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Junjie Cao <junjie.cao@intel.com>

cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
cxl_destroy_cci() never frees it.  This leaks a timer object on every
device exit path and, more critically, on every device reset cycle since
the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
and re-initialized each time ct3d_reset() runs.

Tear the CCI down in the reverse of cxl_init_cci()'s setup order:
destroy the mutex, then free the timer.  timer_free() cancels any
pending expiry via timer_del() internally and tolerates a NULL pointer;
clear the field afterwards so that a repeated timer_free() on the same
CCI is a safe no-op.
(The function as a whole is still not idempotent: qemu_mutex_destroy()
asserts on an already-destroyed mutex.  Callers must not invoke
cxl_destroy_cci() twice; the .initialized guard added in the next patch
enforces that.)

Cc: qemu-stable@nongnu.org
Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260729144645.1552511-2-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ec18338b423..603677a97bb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4795,6 +4795,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     cci->initialized = false;
 }
 
-- 
2.53.0


