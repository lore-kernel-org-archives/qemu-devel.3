Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62403606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bGArtbvp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i8AnXHP1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwY-0002DO-CY; Tue, 24 Nov 2026 18:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwR-0001pq-2v
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwO-00080Y-M7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:50 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMax5X2656238
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MrzdoiqmeK3/sVffPJ0ZqLhADPv+aMot8aqSqI86BKk=; b=bGArtbvpSFwA+02S
 eWnJuMQoAwsVsBtqFYMISfQR7ijQK145wrMI8Lk8Z2mYqZb9aAY73Xj31m97ikZ4
 PtMiTJGHsdGOl9PdfyT3ijDVAXSdKf7Qe9qxXNeho899P7oyVAudHWR8DWSSAZvj
 jEjKR8ADxgoRxNShBR2qq2kB1wUDHrrZcWRbsxluHI4Bg0X1xRK80WKirGFIt2we
 PBDrEAbXFs9fDP14G9SmIO83sNIZfyTSFZDtW3WXeNHV09boMAhshWvidt0k1R9/
 39v+dSNuw8lCqkzT0uIX6xv3ThMalTpxQtcAd5jXOdpSrHPwEgPNB3JhsgGRGO4p
 Hn6gjQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b802jwj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94961511b61so854622185a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562927; x=1796167727; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MrzdoiqmeK3/sVffPJ0ZqLhADPv+aMot8aqSqI86BKk=;
 b=i8AnXHP1ls6MOV1bcaPPQTeHOKudWZWwlu4CWASH39WrsqHzQ7Cr3teijQEgrxPcXE
 ZAobkeZ2la46jS1jdcX8E8qiYVQ5SX0JtORZ7RdzePwVImLQDOGf5Re8bGQvSVuz3262
 SCK3Ikl5YLBMYeZ9rMt3sNffAKHRq//Q2xTSm67t88uu4ckWs9anAOHM7kB/q7yZMn6C
 n9AfseJpON8ugkpuysAjE54Sx6WF6DYhMDWYQnfnlxMYN3SrUQBPiWD9GM//+KxZm6Lk
 8qDWYS3kivVfwSDeLiZxH05sLvTQTmqPXuJzO0sE67Xd7L0GJfPNrLnvmVGzYsy//mw6
 tL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562927; x=1796167727;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MrzdoiqmeK3/sVffPJ0ZqLhADPv+aMot8aqSqI86BKk=;
 b=k6Y+qp7ztaW9/1OqL2RjDIsjsIkBIf8454/uqFMZR2My+3ace6Ek7qi3BPghume+bv
 0DABXD/t9OzlQ/+DUIwrmNruE96Ya11tYBm8j0Ul3j96L6v50yRZopDIPFNCQ8kcjuXw
 AeqFx1/+Bhj49LPQXmDSzBbp09d574tcjeeF0qAHWYLh3gfayDfM7DJaPtjjtrjihgbf
 G7IrhEUDhBNrXH9VOaCuEiJjSjPW4fuQfMx7Kd4uoTLLuSsgcLTKjhtLIiI24XYXt8FO
 luYIHmSQMBgUyQsByfPgbJMzlgSjO6dBf8y/Lx7jsWhD/neV9b+HUq/jZaMCiLRGRvw7
 KptQ==
X-Gm-Message-State: APuU4Z9OLJ/WLpwr+ZHlUVdD9PMjzdA+NMosR2kf49fLsR3xXEEtqD1G
 KD3yPMYdOBUnY4AT8fDUkUEGiyGWu7pFs2rEQ/pbpybi0ARpkNzDh04V3bQ05OybG5xFRz1giiM
 aVW544fKw8Rn+xGuM6mOqRiNHvVljbJmHYd0R/71ynfjyopqRksWlqFEm7LEY/KdzhlYm
X-Gm-Gg: AZFdTZeYAcb8CFqBqUPw3qDTIlTJMwReO4YQI1k3gsK8l1vZxs+YE8f1ZEoGnnkb2MJ
 4wFSD5+e2SsqV1FmrZ3mRoiIEoD/LvQNfwH0ino1zzgfRizACrtjJ+CuI6ltkdPBOJDHNqjt/6O
 46r/XvNk8DKbhltoJL9d1El9RumjTijwuyWmvvSzpd0siYUHMm64tt+fK5whIsvEqb5jlTb3Tn9
 /jE/XY+FPSWs37ZnhhKfDgLPiJXbLAmMIiZz1EpzWVHd7juj08vsZwFbdSeGyiyWsVJIl2Io6K8
 fo2IaVmGXGadOQ/kism2VlW3I3ZMaHl+bTsrN4DQ5mANOJ79VrMyQ3AAIQ0xF0TPks677XTDHur
 SgcOR0Bwhg5RlsQc6AdtzWvbFLNyA02HMeKtDueJ4W2ANWp7yqFz4hr+klhcqBWafD4JiWtDBF+
 aROoa34vEKCWSt4A==
X-Received: by 2002:a05:620a:8802:b0:945:b967:475f with SMTP id
 af79cd13be357-949ba956648mr2779284885a.16.1795562926862; 
 Tue, 24 Nov 2026 15:28:46 -0800 (PST)
X-Received: by 2002:a05:620a:8802:b0:945:b967:475f with SMTP id
 af79cd13be357-949ba956648mr2779281485a.16.1795562926402; 
 Tue, 24 Nov 2026 15:28:46 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm30002203f8f.47.2026.11.24.15.28.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] target/mips: Fix microMIPS BC2NEZC POOL32I minor opcode
Date: Wed, 25 Nov 2026 00:27:15 +0100
Message-ID: <20261124232722.90234-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX27Efs2Z8jLeW
 jYqcZ8LSzHHxFYJ3nMnWFAEI6k35Tonhqxb5yil8wfIQXgZ6wyA9xn/pHjXTfcx9OH1OCjQGSr4
 iPjbCHYCgX4aTn+/XzlN0AXxqVfJXtOxGMQowWvOhkNfufAS3JGzopiqtfJWgmBfIp/FJk8V78R
 pHS/szsaMzg459zOKK023Hf0bz+0XX12IJRWjK476i/1+k136ewn+n/raYUI+vpNQIXwuKzhhCQ
 AUo0NPUqP4yQC0LmFWSS7u3HJA/BBXdoj2U974GkeyNpYISXZlOmrlLB0exsKTxNzjRLzfTfPCH
 uyCON3qfaW/FxZF9hMR+YXpRSiYsJiOvSFx6poZsVE5eFtxi9aR9kH/BpAwWTIjWVGnB1yaOjwh
 W1C6RlsC9l6Yk1mhW4dJfM4Az5Xi+WD/0MiSouXy4NCeyxQh6pKBr1karGHfXmRplq3SJXJiwxW
 ei/t2hrBlJW3gknwCvg==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b061daf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=WFrJT7Q6A0Mo6TPDIPEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oZGWdFMZ2X584V5z1ViEW6yTw2xmyYKh
X-Proofpoint-GUID: oZGWdFMZ2X584V5z1ViEW6yTw2xmyYKh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX/bGRtmyKUYAw
 hlQjxk+v0fQdkWS5FMotlNTbx6uVIgq5ACvWzdjPvfXqfWnJw/T/2D4lRSiB3OZXJoZsK7u7xfI
 OQtbubm3nbWR7jHAdwb3jjgi32PcHNk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BC2NEZC is POOL32I minor opcode 0x0b (bits 25:21 = 01011);
0x0a is BC2EQZC. See MD00582 rev 6.04 p. 131 and MD00594
rev 6.04 p. 145.

Both constants are unreferenced, so there is no functional change.

Fixes: 3a1f426828cd ("target-mips: add microMIPS32 R6 opcode enum")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-8-philmd@oss.qualcomm.com>
---
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index d6a5c2263b56..4ad2b699615e 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -513,7 +513,7 @@ enum {
     TLTIU = 0x0a,
     BC2EQZC = 0x0a,
     TGEIU = 0x0b,
-    BC2NEZC = 0x0a,
+    BC2NEZC = 0x0b,
     TNEI = 0x0c,
     R6_SYNCI = 0x0c,
     LUI = 0x0d,
-- 
2.55.0


