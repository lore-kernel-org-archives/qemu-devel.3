Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC146C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHqW-0003iG-UQ; Thu, 02 Jul 2026 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqU-0003Ra-KN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqS-0008IJ-0r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0Ycp505082
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4Yvu2Fw4Lme
 yR/bMRwzcwj89l/JCaFfxPkZEgK9zj/8=; b=aQ7y/6DORUfFAQyh+GndPw9+EZt
 GGjzMzjX0i/sqTxJotS/ncyq82qgBPGAx456jEXOHooRbfN+4cTCfFIP9Jnj7jlo
 zS6RJQI/BwvG9VYS8rAW4GWIb/7+C3zwDkuOfOFkqS+v0hXjTqYjFaFF6JcgFCX/
 s8+4jueAU53uKT+LT/MajDvbB/14aLJdPAtjQrg19C4+YfyDYg+KZAooeLuNn1JW
 5aS6yPr//bIgswnhhBgCbRzldLtPydiUDAaGXnxOsuvN0figCB4v+LVV8CqpZqyp
 ZeTV4CLp6d9kgUrLrFjLw7AyAtRTuGrOcjBVPWp+/am0M0zAxoX6888rEWQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5gmb26cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:36 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-73c040cc990so611506137.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000356; x=1783605156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Yvu2Fw4LmeyR/bMRwzcwj89l/JCaFfxPkZEgK9zj/8=;
 b=LTkUIG59+rz2asayIlzsmwzyZquE5co1tyMq/vfHDuZd5RvSeLk0y+m93tYlI+vtz0
 7rxi7cMjpoYCSlKe5gjLlPjQaPxULFT38ECPZPItJszzRjKgBFViRyzHwF31Xlfb/6oG
 f7UB5E56DPMS+e1s4DmlMV4eJZNCgbNY+UKgQi1595cZBoWO7pqXSdRkNG8956LaCv/f
 a26Xj26JfX3STv0Y4z6dASVixUdrNGVPTS/X4p0/vpfXdyXkfl4+S/ETqXRKhQBGh2lH
 93h470H0yQAi388gIiUkdMvL71eZFpi1MNYNbIcc3GuyQBR/mUCbHIy59vBvUyIkGGCS
 /Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000356; x=1783605156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Yvu2Fw4LmeyR/bMRwzcwj89l/JCaFfxPkZEgK9zj/8=;
 b=Jxi5SUkxoIvN+bjeNWe2MkjZavpTl31Xb7ooltwDiIWypiDAzMlP6HZY6AzYxiuHJH
 2yYkJCmmLV8EgSwck7uLRS8gZUvagjxOg7IX2ndp2ytgcGb0wZsHGdWjPL6WPKx9b/F5
 pKpq7C1Oh4SQkTou7pGtSXF4yOaRoBKAJhx7xbsrm4ZiXzHomEvLqq4tbVN63mS1Ur84
 nE8FBc2o4bAJADsFJXsncSr6LOrveTZCHRDpqi0ZpWCFyVOmUynQVu0Li08gyo+jeu6t
 /fJhcIc5noEjCmVmrWRiWN7OeirUD9RwtNRCfhXhqSClNO+DsQYBwvRw6SNLDS19bU6s
 wgRQ==
X-Gm-Message-State: AOJu0YwgLDvPTpZETr5PiFIBe+RWMwh+Fx71N5YFfrdSFKupAMX9+YOR
 yA6FC9Ad/vTDc0N+zfJcu9TET9Qq5V4RhxBqc/0CXwwb2c7lrhaG8mRnlHHT1EMX7eXNLOzJkJq
 vxIYds07fjmEIESxsAMKYRktijVvOk2hDa7nCJz0cPFR+RvwLktxXsssTz6t04CTrDw==
X-Gm-Gg: AfdE7clR1Z0smvgQGGgxVI44WoCdNko0Wbe7VnP04t/v54hy67I85ID4Cly6YybW8LE
 h2lwIiU26n5jXoeeAOFPRmosA85UGlEAgkxrmsBX1bQ6Q0OAGhQP7oqKwYN6RAOOwG07brp8dqG
 1iPLQw+CyMZiT04jcZcmt6hE06501IgY5VolCJE90VfNGBosXnun3Fyxo/TpmTGLvZSEB4JB6Hj
 Kq6rYi1Owj3BRO91pOjXtnPUzAncuw0xDNrKmQiaP0Vju/DILCcWzrfbnRass+lfiBsQqT43LT5
 KwLbF5yrlw2lBBRiDLu13rhZWWzewbsIn1q02lUjVaswBhHUZQ8JovxAOcBUb4/2RX7JVTOVb2X
 iItGQmA3Nz9dXCMYOJrHpUmCsATUMB0FaS8RhGhPYAQ6ukQ==
X-Received: by 2002:a05:6102:3913:b0:738:9c30:2ba3 with SMTP id
 ada2fe7eead31-73dbd607187mr2126497137.1.1783000356352; 
 Thu, 02 Jul 2026 06:52:36 -0700 (PDT)
X-Received: by 2002:a05:6102:3913:b0:738:9c30:2ba3 with SMTP id
 ada2fe7eead31-73dbd607187mr2126487137.1.1783000355936; 
 Thu, 02 Jul 2026 06:52:35 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 24/24] gitlab-ci.d/crossbuilds: add riscv64 KVM-only build
 job
Date: Thu,  2 Jul 2026 10:51:26 -0300
Message-ID: <20260702135128.1188021-25-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kbRnDS0gMCx3bcnWC4eF7l8aACZHZMxi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX58eVYiaWGkll
 z1heiFMxk4z6PH2UigjXcjw6GI5cYn7yXSLvwapF4KbpQVbLL45BlnBNmc8wAimlOijL8oi7m3y
 5w3TwB1SFttC28BdcFybpAPLR9E6b8s=
X-Authority-Analysis: v=2.4 cv=aJ7Ab79m c=1 sm=1 tr=0 ts=6a466d24 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=BEvAcZqKd-QGyfCP7A8A:9
 a=gYDTvv6II1OnSo0itH1n:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+/QXNuuiAGjn
 FX851scO0hxJ+rHQSiwUQXwVpiNNOo++rYrHhyA0Q0ivniqrYRH+Sfu6h7bgSTs247hwsd4XUA8
 Uy3wKU2Q3xJpP9q7MuQ2FIvR+yvflbWjLtqm6/asreR2iC1pzba8SuJgLu01mZN+ak6TkwnCaQk
 GOtIHlnKO5zDnLaaxQJ5OpX43Jjs15+8nCSLmj6n3V0ZAPasSzp6oCPNU7INk5qoj23RXiWSynf
 /iQciKDcc8iRKhm/NWNvVq3qXzhclbmbuy5furisgxJYMR1abRXQ8ZO0L5Aa0gK0N2uwFb6W6wU
 t3FNKFjwQgFZHsotAFQnN3Rk2k9T0l94Iywd+OG1Hw/CtrBXMC0BCIzdReyTyIp+7DzTk+yhQF9
 chEOM4jxkwdB0pYckJlP+HoHOGFuIarWMSGIOLpSod8CDCfEaE3V78OjrncQFsvVxIhwYodLmWb
 SYI7HoACP67aSQ7000A==
X-Proofpoint-ORIG-GUID: kbRnDS0gMCx3bcnWC4eF7l8aACZHZMxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Add CI coverage for a riscv64 --disable-tcg cross build. This ensures that
RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code from
being accidentally pulled into common RISC-V sources again.

The cross_accel_build_job template enables KVM by default via
--enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index eaeeb533ce..a823aaaa21 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -59,6 +59,14 @@ cross-riscv64-user:
   variables:
     IMAGE: debian-riscv64-cross
 
+cross-riscv64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    - job: riscv64-debian-cross-container
+  variables:
+    IMAGE: debian-riscv64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


