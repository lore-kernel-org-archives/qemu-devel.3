Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4DCCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXec8-0000m6-6B; Thu, 11 Jun 2026 08:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXec6-0000lL-9m
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXec4-0003Ea-Qc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:26 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCTEQL628623
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HHU0IyCiBIVulOgwgEzbUX7LMva8z5g63gfaJmFHxwI=; b=nsdKYkxsVX1JycWV
 Fdv3f7sne4KlHzyTL2pbIZQOwfjvlnuNfNp0V2PdWiP+9QjgmdQ8Rpi5TdI18q2a
 HBE9iQpxXy1dtx01nJCchfPRjbOzYg61LK3DDh64ZEpftjKgKBSoIpLexj7jQBAd
 5Vh6YuuclmZ5AtK61ok//Y0zoLpo/skBGmHJrs+EcxkMIsqk8011cWe4Li/UtX2x
 KrIaOT0qzkoroXPBniCtG/EtLlqQzTGUkdFx6cBabo440wHn8AGLCZTNmKWxvS4f
 LPdFP72ax7SMEZBbCBYbz/C8Jdw91P9gVxIrl/NySRPliJbJeNUljZdM69/UYuyz
 bWN7gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe703bm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso831088885a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181263; x=1781786063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHU0IyCiBIVulOgwgEzbUX7LMva8z5g63gfaJmFHxwI=;
 b=ikvaRH99HMIpHlGe8bUkC/gHRssvZGeupwASC/qb5dfGjkSRchL5459Lec2bxp65H6
 aiEXumC1qhro41kvC02IeAXVahP369d4emGq53ROflwB20OB7agbqRRjOmafhtVOneF5
 kzpXRoiVG8BGasZC5xtL5OJoteBF1zNMLzaSBOeZV+C4FPwkwOtN5fUYktg9VUggARp7
 LPNcpWob20yc5jSDliAdJkhDV2FAZyJ3igAeSJxsAsCQBC/QZKi0tld0pJ2+J7w8XDgX
 DGTjrJwE6ru4u2h5Q1nafCyB1aDNAF6Vze+tlwqxCvgHU2IqcUeXjTBV0y5FAtcfMbjD
 N5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181263; x=1781786063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHU0IyCiBIVulOgwgEzbUX7LMva8z5g63gfaJmFHxwI=;
 b=YHY1Z8RZQ8xzWhWtO7XJlQ2jG2L89hDhfjvomRbdpsGI5b2BEAHrCiiH9i/W3S5VEv
 BcSJQHIvKG2oIKGvhlmlnW21pWgo2AFFl7XQBmMK5Sh9c1fskbVPSvEUQahCb6F1ZWic
 2jnck2Tg3owzSYso+kF1fpb+B0q5jjacdwMjLFzd8B3/sKoY2dQe8VTubZ7dWx474J0i
 cNVvLKImsZnZMe3PJAkcmBYJtOTFmJxh/SzJLSRo1QHxLPJrEBCq9Uvo9Pzj0nixX5R2
 ippjMnpME0624mK9R7qqQp2PTidC8erNB8jhKLnOlMTFLVY3jIVQ1IDp/JZHCa3kdmrI
 q3hg==
X-Gm-Message-State: AOJu0YzRh+MLx6j2yqp2sEoagIFg10SR6rQweBNakTaat/F8pgoatx4e
 wdGrUDFkhblVp7v2D5CjPRGXNXpxt00aFCHo9ymeVBy5N2OmJDtvfmaLFTocg4qzTLw0ITRe0NQ
 R1FYjrZFPGd0eIZX/BYX6ui5KBExR/S+ihZVfrOwRSnnYD708tUXrre51aTMvmRmfjA==
X-Gm-Gg: Acq92OELpMVVQXmsu54XUo++SVw6TzbRC1o9OEg4J6FYHu6JY2939d0GJLrIBCvelJ+
 LhYj8JKTZVeVVJa/87KMUUaXHAG4udN/P0uN+3zC/QcVXeebvpQLcDfkm0xKHnX8sIHw7/DFZ7z
 j3I9/hilv5ihHjdi03evdeiZrMfAhRdbK55vYFEtu+ABwRU/ccn8Anbsp0H6XT1tT5e90rlFVVc
 NHXqunodGr3Rn11/y4lqdpc/OCzaWAMYe2kige11wsJagL+jOmqNCMZCCz87qyVeJKrQhKGO++c
 x1CR9LxW3rbuJ88n7sck5z2SpveAtC4Qo4v4oHrpwJr049dgCrLhGzllmaipzhzYg9drhhq46Td
 NvWY4rMdJkEfGyCV2KVbamQIOexyfuuhauhtE3saMApqEpFBQrzvDIxsw92doAgNgLj/bUEKslv
 R95asQpUO/DT4xbyOf3w==
X-Received: by 2002:a05:620a:2681:b0:915:9047:940b with SMTP id
 af79cd13be357-9160ac9ffa8mr369789185a.1.1781181263124; 
 Thu, 11 Jun 2026 05:34:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2681:b0:915:9047:940b with SMTP id
 af79cd13be357-9160ac9ffa8mr369783185a.1.1781181262632; 
 Thu, 11 Jun 2026 05:34:22 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (201-26-7-9.dsl.telesp.net.br.
 [201.26.7.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160acd7904sm181042185a.21.2026.06.11.05.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:34:22 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 1/3] target/riscv/cpu: add CPU unrealize callback
Date: Thu, 11 Jun 2026 09:34:10 -0300
Message-ID: <20260611123412.2135600-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P-AcnCCqjVicWyvnKzJzoBpy7DRLfXhU
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2aab4f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MITIYaLR+oYcSln1dApPwg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-V4TLcwJ7WInddZtJMgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX3Fbc0ZTS4SKl
 vBmqp8pSeerjrBAJ/yvJLR2bhxHUraSqc0PSFLkl4uaXfCoDjbZxBlAEs/SODE0+LnFyEyNifoI
 l4zKsWAgdiiom2XRfSW1v5mQaW0T6Kr2UjUwRb9YckAO3MJkzQDtQ+ov7QGJicgqBi1Ia2TACTV
 D/+KKkBFj98hlbmijAqKz0bVmCS/d/PhDUvKCBnwulQ3lBXaJj//qa7bbrZfwreLPd0qQ40Knnh
 z23fwtvAfM0ObePB8vXmxTiC5+vAUtq2qsgGGal4yBbzMIMH6XbcrSzUMdfNRH4VH+fQiJGOzH5
 1Zd1UP/ZhoxyBn12U4Uksv2JCLgR4DVeCo133BpKforIxhOn5XMGL3+zqraeFJkSiGQfe30wAPD
 zz0xDfNy5fYHIuewI1owp2PWE6a0x6YqMF14ELO/B066qvVjvmFcrubQoHNb4BbI63YaEDmHzj1
 N9tis5E/gQ9QKnC0gIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfXxvHocEBJpP6s
 RCCsfUegEa4qJbz7zwxXVnXge3/qYAqgyq9ZTz1m756VxthfWp/LuyJPazMmPIdlobC9CQ47rnU
 BF+6a922rcnw8K949GkoT28Nxka5F1o=
X-Proofpoint-ORIG-GUID: P-AcnCCqjVicWyvnKzJzoBpy7DRLfXhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Next patch is going to dynamically allocate debug trigger arrays during
realize() time.  We need a way of freeing them during unrealize(), which
doesn't exist at this moment.

There's a lot going on in that patch already so we're adding the
callback infrastructure beforehand.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 9 +++++++++
 target/riscv/cpu.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c1b10cc7ef..5b2133d811 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1012,6 +1012,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static void riscv_cpu_unrealize(DeviceState *dev)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+
+    mcc->parent_unrealize(dev);
+}
+
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 {
     if (tcg_enabled()) {
@@ -2667,6 +2674,8 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 
     device_class_set_parent_realize(dc, riscv_cpu_realize,
                                     &mcc->parent_realize);
+    device_class_set_parent_unrealize(dc, riscv_cpu_unrealize,
+                                      &mcc->parent_unrealize);
 
     resettable_class_set_parent_phases(rc, NULL, riscv_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c98652cd62..11cd710990 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -575,6 +575,7 @@ typedef struct RISCVCPUDef {
 /**
  * RISCVCPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_unrealize: The parent class' unrealize handler.
  * @parent_phases: The parent class' reset phase handlers.
  *
  * A RISCV CPU model.
@@ -583,6 +584,7 @@ struct RISCVCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     RISCVCPUDef *def;
 };
-- 
2.43.0


