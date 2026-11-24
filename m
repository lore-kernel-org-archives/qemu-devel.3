Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7C606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JvLMdo22;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R9HtDC2f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVze3-00008X-To; Tue, 24 Nov 2026 18:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdx-00007p-8d
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdv-0004u9-Mv
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:44 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb4l62656287
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n5j84UuTJbVGwKhfqp7LpVwcv5IJOwRcz/J+8mZr3EU=; b=JvLMdo225ibGGXx3
 PTUhBCbIre+EpaPW+uGCYvikdYjQBewmybMgzjrtx8xOKlFTTZKzc7c3CGS0RAqw
 5Fy+4TKrfhc4MyJKMcrncqJ1R+4C5OuLWaMqoGcwI2nj5wCit2oTHRP2qwEbnFKX
 haqPIcc1Gp/fSk21OCjEbWkru1jM28CMYJwydTyXtgzhySiMjVaj6VMDbPkJatoW
 KNTW9TpttARAw7Vy37XT/KGNfViZpENSlMLqkWbuZtSwWRzaMfZDMj8N08PO5HSD
 3UiwGWjY1Sfd5aIVPVTYqiwzS3wC6JEBXJUqWEJXORqaAUaRpsc7apdEPF7UUXUg
 VVC2Lg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b802hc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-948d83322f6so298994285a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561782; x=1796166582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n5j84UuTJbVGwKhfqp7LpVwcv5IJOwRcz/J+8mZr3EU=;
 b=R9HtDC2f2X0Tfhqa+t5GI5obm9xb6pZDMseQLuwHK4qTW4f0piggwzbCuEBU2tjKTH
 gDbddmSL2qqD30oQP/eJ4WtgjQgOpUYb5bwK2R/30TEqeO+SHq0PF5H5k6Vg6tqRxbRv
 vt0HaRM0z8t4FjaAwpxWBGC2x1z16L8bZC2gOZRQdxDMWt00iqUGksr7sawddX1vnAOl
 jnpedLm0XxzPOr6ijtxBbYCXKzhwvb1za6Q4njIyhJFnN2leyjbwDYL9TtJgBdHlczOa
 +FFm/p2x3CVjAi1En/Jqc2+THWcpnrrlg/loBMiSA1tbF/yQhzfPccTOjYpcurruY+kr
 NWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561782; x=1796166582;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n5j84UuTJbVGwKhfqp7LpVwcv5IJOwRcz/J+8mZr3EU=;
 b=hsbZAimDhsrM8pWJJqbACLNeDS8uuBQpJ65cpGVZ85e2OxESd8aDR/xys3EXbYl0N4
 AW7Nfwqxt/D5BbHUlfCKGcG2YQ58VypGw5r6juPByWkoRg8eVQ+5mwutkM9pQwhS3g5K
 6y0gka89U12rdBRhIkG8qzawtF3KDP0ckYpwWHpgzzuRXpLeqd/XvtgW6vw3ZAVnrNoH
 TgTNJPaUBaGAzeHgVwkchSXMPnoGd8FI1K0HPvaMjn/tknuH/Qiua0faDNfjuC8WQ9xL
 y4PTohuVuprMZH32Ll98tyM4uu4Cq2kJE9MRVqjFiMr/hXjH8TjIrQyYRSPcjHLXUB3R
 YJdQ==
X-Gm-Message-State: APuU4Z9XOE6Z/xwB/Ol93kfgdZJjxKqyyikQJkbo+kqwvMiIi/tCWghW
 99MyngbHicvWsoT4kBor6p+Nwg/wPOzYcaig+Hv2g0NhF1o3FRe2am6NeaB1itnbAhyL3bCWkzQ
 Y7Arsm8/gZZruP5BY64+o53U3BAE/Ywae9bTl+JK/oZxXOL5EjvRKQykPBLAeozFZztEg
X-Gm-Gg: AZFdTZc46DplhabBkIPdN8+OhH8ffHs6WWP/H7vXbdx9xLtLDZ0ssm2Vp8G10oMB5oK
 74Xvd2UBq6Lp2OFI8j3pIv9rdHlK1lzX3lne20fmXB8na2ohp4X1yfB5+8CBtSROzExGBpKlpQD
 W7fY3ZrkQJyDlzpmYXEKTBeUOlvrcr4nAslvrmyz1jBBYygU/Gh3Irul1FTJhuKGoweX551xvl8
 QsTXOwOxfbYEvihJcpfCQvO96I3G4q/nYYIzXEHT2xmQFCg4ykVDAfsVAWweUzkf1TYvsDeN6LC
 VRjV1c2yr/pVThPA4pacpm+UTKj6BjisFqF+It3rPcjhsDjJHQ7lteLMov2KKYBSW6OUJdxbtnb
 4rbou1XtI7WPkfswRBWT8fLRJoBZirspgK2GOlzF4ZGFTZHKeMlLOWsP1E9n1ul2tUGnXPOIiZp
 TJYZbRSkRqDbFIFw==
X-Received: by 2002:a05:620a:4607:b0:949:7acd:3c31 with SMTP id
 af79cd13be357-949ba6b3d57mr2614207185a.0.1795561782189; 
 Tue, 24 Nov 2026 15:09:42 -0800 (PST)
X-Received: by 2002:a05:620a:4607:b0:949:7acd:3c31 with SMTP id
 af79cd13be357-949ba6b3d57mr2614203085a.0.1795561781686; 
 Tue, 24 Nov 2026 15:09:41 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm30787428f8f.41.2026.11.24.15.09.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:09:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] hw/sd/sdcard: Fill SPI R1 response for rejected commands
Date: Wed, 25 Nov 2026 00:09:03 +0100
Message-ID: <20261124230917.88704-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXyYQ7rv3W95Xr
 rjC8EyMD/uzTsg6ZdETUkSi5P6J5E/JjSgi+BrWeLqDlt6sCQgzAGx2uG6uAF2DKK3OxnuMowS0
 bFhsJA5/FJ2REBGeiqgAx0758166IPIKKvQai2DVdjZRUONDNkhZFuqDSzHfy4qaURE8FMYnBbJ
 2bKpQ2lcYvlf/OhbyJ+YYtHfBV8uK34j/zL3E2KKdOCK1G2RsGsOwI2DtFs8j5XYH+6Z/Sp8EYU
 ZhpiMZ9lLaMHh36mReN00jDfFBVeHaZXv8kGfVLpfKaenQCMWl0kfhny2bHXm+ouYoMVtMMljsx
 6IhacHjvM8su68LGplEh3avFGzo6sFXBT/c31MbeJpgVBA4F/r79UOEHpT+ZT8mxICQl1klKBFj
 eGWcJz1I1o6BY8JAq/vTAjZIbMLJUFQRR1uItbC4BWVD/QVgPwIBKpDybesOBCZC58Ny0HGbKwP
 50fkUzDryvL5fAe23WrCuM6Zh/7jIH5TbjiZ2Zhg=
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b061936 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jg0HPy1x56av6D61QKAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 cc=bnc
X-Proofpoint-ORIG-GUID: Ud5-hjskfSzb3O08f3Aba8Okc2-wVv8-
X-Proofpoint-GUID: Ud5-hjskfSzb3O08f3Aba8Okc2-wVv8-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX6VRRfealAncH
 2jmyKwovGjbDsp+CF2EQvOTb2vNvfmJFw88t38qcK3Qf61QYVdu1M/Rf6Rj8wm8DcrnCaRV1iH1
 B7a6Wp6rKlU3aPGrYLllvfv63uqXeOw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc=bounce route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
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

In SPI mode the card always responds (Physical Layer spec v1.10,
7.2.8 "Error Conditions"), so sd_response_size() returns 1 for sd_r0
and sd_illegal. However sd_do_command() does not fill the response
buffer for these response types, so the ssi-sd bridge returns
uninitialized bytes instead of an R1 with the "illegal command" bit
set. Before commit 1585ab9f1baf, ssi-sd itself replied 0x04 (illegal
command) in this case.

Build the R1 response with the "illegal command" bit set.

Cc: qemu-stable@nongnu.org
Fixes: 1585ab9f1baf ("hw/sd/sdcard: Fill SPI response bits in card code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261123225349.54981-9-philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5a6045f1360a..1772a4fdb11e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2610,6 +2610,10 @@ send_response:
         sd->data_offset = 0;
         /* fall-through */
     case sd_illegal:
+        if (sd_is_spi(sd)) {
+            sd_response_r1_make(sd, response);
+            response[0] |= 1 << 2; /* ILLEGAL_COMMAND */
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.55.0


