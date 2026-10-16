Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF13CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRo-00076e-7O; Fri, 16 Oct 2026 14:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRk-00074y-LZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRi-0000Uh-P0
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE61mH1450979
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hpEZ15T/wh5
 aEQUnoeyOZAyCvyIMU4BnlrDNd99Wy78=; b=DWKvaDMMIQwWG3P74NMf8kPibDC
 /MSqhStQ1rSZj2wk0mcvlYSOGO8bx7UbkqRf/Q6JONtWVXSDW7NmSpRUt4UJGnh0
 D33MiCZ6TQhDUnyQixXG7eaRhjt50EGInEShstfLf8BxxX9L83A0X2OyLcIWEkmJ
 QTahm4ot3yNZZJEdJNMv8rzJ5oGSps3bsVd03RxW/IXUg2odbQ5Ay1/pOG36kr4b
 yq856tBZKoeCJW4PHlRt6MpQkkTcbf7cJCW5ICAgOTHSl8lC2cIbr4JhTO520Cpj
 Jy2dw24jZPfQ2141uCo6Ia9SArCFig1s9mi6FQfEbmtpD4aTUrsxGKLJHgQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur1tee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so245575a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174459; x=1792779259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hpEZ15T/wh5aEQUnoeyOZAyCvyIMU4BnlrDNd99Wy78=;
 b=KRHiYfkF/SpxwV9GiVmLf0PuVgeAu08UKOMczbY3uiWzV1baZQfGJAtQua0ChZV30u
 R3I5CfpVyTx1rAwbnr6O4AtXqQ8FigxJoC6WbEsNK72e03Ua0pmvEVfXwdLotD1sjESK
 5tTYPxwIfbp7WMQ8RzZ4XRunntcuGM8iunBxgvxVHFyIPqF/pf5SBr/6Tf4kzekLMfZU
 bnsUo2qAP3w4Uc+bj5HQ8XbsoGIgZXqSYzE+M7xTmWWRhPESKq30aQQJ+BUGNVgAZ5dZ
 2sFQtqMbHLFrCM1L+qMuGUvjGqNT5i5ohv7mbwJNJPk2DCeXUXLiWDWOgLd+uxsw7YQ0
 aG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174459; x=1792779259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hpEZ15T/wh5aEQUnoeyOZAyCvyIMU4BnlrDNd99Wy78=;
 b=Fm8tTwt+HkPJpV/SWE7RIEFsBrQHQVnbcQP/uVppeJvcPBdoyoxwIGEM0usmdrDPmb
 PJWZycgZEq1cM4wG4FVbz/5fiqPM5DzOYsjX/f7+ZDRpoQ7GsgZLuKty5j+XjThgVrrt
 NKNOlLz2+jwXF7EaqHahs5ADZZLHgx4IK8obo52GLNb9Q56SuZmWLAXYgjEerj5z+HWy
 sfzJnPJOzIc+vic/FyM3KG8xN03Xg3O46zhzxqWZdn/TWnyskvBKxoi7L1HONSeMWn9M
 ZPMPs3//8Jg8VBM7s/NZS6m8COqkB83SqGP1feIdHVq1RW8k1HfHKl9GdCZ76eDhlYBA
 uArQ==
X-Gm-Message-State: AFq9FYJkXxRO04b2raKLf+1xiLqWvW0rdGGbSzQ2yug+uBU2yd9+hUj1
 bHyphxSy1/qQC/QVnWkt1GLdxyv6YrczLLrVYCrb1oz0X7/ftwdES2TVMucIYNQZ4dAfpgK7xuR
 38BJnpXsBq+jh9+xHG+eOHREmDjiaOWkhLca2AALAVtHb3UjsV5jvUNK+OGjmhIhEqw==
X-Gm-Gg: AYBFou1Y+Ge4ZkZRd3aavGsjer4w8S8/WEY5Kz4JxV7HEf7TYyV/FadoPmZTpHzqxgN
 NS/REXuBmexO5Ev5wBN9tZ5OobyJgpw4/DD0S4IGkWbnD9ClgFufvRjTQM42HXgoQa5RK4lf6CH
 kkMJecqoT0BoCvNhR+xnX1UlDm1OgEyP4zEECELrUFwzkpy3PzIJbHi9BPy1+X9ilqNgxzoCB3q
 eJ7X+mi0xpvjpFCkF97aq6aeu2cwxj7E1TZegWOKppTjCa/XD6/E+ccnD+uiOQV2t5kzXh6vqa4
 c4z/TLr+SBpmdVy0wpfo8JOJEBP47DlBC9cO6TMSTBxb/y5ka/Z55XYKVercJNubJffUSlE4wKS
 CA8IxsewmkTlcVrXozDeOnDjo6Mk+1BCPxEVkE3NjZkPn1SYPs0NQDtDwQaSKY2c=
X-Received: by 2002:a17:90b:58d0:b0:3ac:b3e5:428f with SMTP id
 98e67ed59e1d1-3acef0ce59dmr587288a91.53.1792174459542; 
 Fri, 16 Oct 2026 11:14:19 -0700 (PDT)
X-Received: by 2002:a17:90b:58d0:b0:3ac:b3e5:428f with SMTP id
 98e67ed59e1d1-3acef0ce59dmr587275a91.53.1792174459048; 
 Fri, 16 Oct 2026 11:14:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 02/23] dump/dump: do not dump machine if doing
 heterogeneous emulation
Date: Fri, 16 Oct 2026 11:13:49 -0700
Message-ID: <20261016181410.191743-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX/Xgb+7R1YJYz
 VKTysFAFG4i8kB3EUkeaEuEPTal8gJZDvkY1K7eNVVw3UakUtvOb6MA4QpR+5CqsV386m8jtBWc
 +AIU2gd710PfhF+8swqNzmxZiPjGsb1EXASA6Ffr48sTqvUufLJk8E5gGs0roUy29vM2+1xvVAy
 BZG2By6W75p8uYHr9Z3xjc+hQMTViclnam7oLaE+9ouKwyfAMegNhbay5fswQTmkrxFBN/0Lrv2
 wdT/W60duzhQP8TkwgS/EOGQy0RX0Ab04DmulZMUDkSrrK9B7r5HPT7F97/rmAU0PibngBbtZLI
 ekyBEF9DQdh5tVEct4g6GaJJJoG0UvsCcwVvzcCI3/PhP+6nGD935++7xeFjG6NsUvHNDJ1XyGx
 bTg/W2tugvf0e5yLoqOTV3hhrhereRqPVfl/f6zmD7SzdmOfMYrCJCQ9rOhpWZIb/2MBZ07/B5S
 rW+RxUfq9387jt2Isjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXxhbKWW/3XUS8
 Yra+qElc9gDASo5PMWPnwtmRtSR/gwYpJUk7vfaw3+l66VsA1lsk9bb9C8y69YdaMgV0cODspG3
 fEGcXVoHw8ZgyaTx/0U1D/tmgkFk+Kk=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad2697c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=PZcAJl5xHOMMM7CFr9sA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: bY9YM5uMSP03K4f4XYwdEYuK6N3ZVXZX
X-Proofpoint-GUID: bY9YM5uMSP03K4f4XYwdEYuK6N3ZVXZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This would need some refactoring to do it correctly over all targets
involved. For now, simply prevent this from happening.

We do the check at beginning of function, so no need to call cleanup
routine.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index 52be7258a5d..0ecff682dd4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1795,6 +1795,12 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     int nr_cpus;
     int ret;
 
+    if (target_heterogeneous()) {
+        error_setg(errp,
+                   "dumping guest memory is not supported for heterogeneous emulation");
+        return;
+    }
+
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
-- 
2.47.3


