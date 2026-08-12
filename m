Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2674EC5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMZ-000336-2u; Wed, 12 Aug 2026 17:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMK-0002U9-Uz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMJ-0007vM-JA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2R5S297068
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vv3rNqnVj/Wl2XQrkMcX+ZywENfxlAP74DyxM9wJH40=; b=DW7Bl98Y5qpHy5zp
 601/CeFDeY7Jbr7/j5/x6czil3j3fBdnuYkyP+rFCf+SayN+RvuEjkUUlKC3O8fZ
 62+h+pgW70T891IpQQ5mnqdYqSwf0k6P4o+Azj3byZylFIGHReIg9QVcqGN3gNYv
 1owlLUOVn3zXRmRU6iYOmoWkkYRr2+AkphdxAZjFnkfV0am74EYLIrfJONYVOcXM
 Ewfm3PqUFNzMuKNVe7Q1EayHk0l3fsxFknREtsUpf4Bapmj5mycjw5LmRGxfuuWs
 r3NMRXhvYKAGIr9onL9QFzj/IhNqJvHtJJM1v7WSEIj7pHmI1fypDG01SykZE6yW
 arsU0w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d36sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52827090cc5so4525191cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569574; x=1787174374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vv3rNqnVj/Wl2XQrkMcX+ZywENfxlAP74DyxM9wJH40=;
 b=Kx+Vn4OXun6JYWW3/bGMrKI8yTaEG+lc9jIZ+km1w6Y4y1zBQNgdA9ik1AsATBp23n
 alGkSGO7FGv7Cg1DztRRo9wnDwPukp2diBMijNrGb1527FIUK3mgNFYMpjwUXf9gHlrv
 xDwMWlyz4+MFHXI4cxltC1M5NNgf10NJskVxg2lhSSxaZreI0G1GK7zbRAa81yJk2lWB
 hBPpTFUhiBbuJKfgXSu+I9MOQnP2zY3sNL6xWc3AV4YZ8TofjDOtvwwR5/dy8kj4NMi9
 MbGHA8BDFi15o5y2JKuDjRAhv7kaHiffhyCkY4RqNHyMCrkDrKgVslJx8RlMeUHqYcmJ
 ivlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569574; x=1787174374;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vv3rNqnVj/Wl2XQrkMcX+ZywENfxlAP74DyxM9wJH40=;
 b=dQOf+pKl0kEwM6WdJB3sBJWd7TSgDzOq61bGow/fkCOZTwH4YyvNSdwFamCcrwkD5Z
 vHGrDki98qECR+End3P7oG00B1ajDU6Mst7UBMBzgtvbvMqLwzOOt1g3a+cGEi6kScXA
 Ezsni+8yk8dP/JYJxWC+mPCKuuQLDq+4M8QE+oC5nkZkpqLLdLj+mCBu3+/mHONDfBSF
 CakR1+fM7zB0samq+Qa4iazMKS48f4fJQUdaYLxZxXgG9WG3PFqj0hvjafcxaOSQT5eC
 zdwn6i2scW44GNle4KcY1Z4v6DJPf78sfKbbAyvUpEuusjieToxJFWrMnm0nFVTdyZI7
 iYRw==
X-Gm-Message-State: AOJu0Yy4GOkrJ0v3/osDn8nm60XGlCmeD9w7bLRE6Au/b9zKIUwwPExb
 CCWb2ZG2/xWc1h90Si049Mmz3QkNjDf3136lPR5qTZZswZF8cc4QxeHfwPQd9X6iLshUfTXU9qW
 pXW6CHrXM4pluPAs7lC8/c2QcSEnxSps/ddJFxesSpnwg4Xz17vivokPw9rkS+L0iXA==
X-Gm-Gg: AR+sD11mAbLs4ePqHmadWIZ80Mi2FESnJ45pH6Uf8CEZ5U4oBP81oWP/q0NVH/3C/0i
 dZCWVzAUK7MlE5CmS3v/rgVHm6Zdnb1sAzzP/4oW3iJ35b3QhpcBcKd979yr8s6E0QcWoX0dSft
 yrstz7JvnmKyAL8cnv5Yt/Td11ROKeJsUYQjCnL6vBwYSvpk16CfnDyvENFWU4vUh6aAcY08HaG
 uruYUqpft2zIQSdGk+SLPGtCcwTOEv+rU5dNFafIs/Mihyn0HoaIvKN1XVqI7ZXX5w2bOdG2wGx
 KLLUL+8c5V55fpfc+tcD5Oiy2IDs1tDtOi9sSfr7K0hXEkalQZm9B87038qyOt3K1WvoVJg4pLD
 +IBbsonO/Qd4rWwUqI9S5XQFZkDDq4RXqwF5iM3IDrA==
X-Received: by 2002:a05:622a:8b:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52d74a70ba9mr5757841cf.9.1786569573865; 
 Wed, 12 Aug 2026 14:19:33 -0700 (PDT)
X-Received: by 2002:a05:622a:8b:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52d74a70ba9mr5757361cf.9.1786569573315; 
 Wed, 12 Aug 2026 14:19:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998212a3a1sm6744155e9.6.2026.08.12.14.19.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 19/23] monitor: Better express monitor_read()'s opaque arg
 is of Monitor type
Date: Wed, 12 Aug 2026 23:17:03 +0200
Message-ID: <20260812211708.92824-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3bJOIgBn_BuRWyAnUmH2x9KVAPwt0bib
X-Proofpoint-GUID: 3bJOIgBn_BuRWyAnUmH2x9KVAPwt0bib
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7ce366 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RPUA3qnEMxG_1LUdHp8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXzM614GKgiv8l
 4bJRKB9pwDm7KsimX8abgqL1KXrtt9zdQRi/H6DF/MMaWOXpHsU4XY9xldCnb42tOkmWZuYGRr5
 vdsk4rQARB78e/u6zabJBlgZ925LYscCxCVAdm+qwxSJcpIM5MTGkZC6zT6nknWA7H1uG8cwbq7
 WP9yCFmqfL2j7CHnjPHmctoYjC20pYQxNc6MzsUDET6YIQyTWBQnILDX0e72yQb3i1Uss3lYU+b
 z+WEDcfphOmtvjBD+tIo35ibDxL+S8LLXhJg7fFyuk2FdV9z8k1yyKbVlmuK45YGMpflo2O3iKb
 uN5E/FPWK7lXtbNOIgcZUt6PGXHsPBM969QTblIPleEXxLmCi0mBGvUsNZx+PulOx3KBW0qaceW
 ARG3NlLoY5ZDsZCVAk/M90doUEuEoB4J/mHVUTgjvFaQzz8ouMvucsDvf2MV/iv/RdAGRnUtiIH
 +FMGufGKwOWdFbc2lmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX3BT8usJcY7or
 j2BC0ZK6WlOyquN+i1XD0ZSuOk4wS8W2H7oWF6ZrZV0fVofgykT8MmYwbnlZldJCijgR6qD9Pb4
 nobmgJmHG/s97mcjUoYn6MOh6WatmV4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

monitor_read() is a IOReadHandler handler, called by
qemu_chr_fe_set_handlers() with a Monitor* opaque argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/hmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 24076dc7c03..bfe3cea902c 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1519,7 +1519,8 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *hmon = container_of(opaque, MonitorHMP, parent_obj);
+    Monitor *mon = opaque;
+    MonitorHMP *hmon = container_of(mon, MonitorHMP, parent_obj);
     int i;
 
     if (hmon->rs) {
-- 
2.53.0


