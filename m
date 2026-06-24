Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9D7CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcBA3-00009D-DU; Tue, 23 Jun 2026 20:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9o-0007xh-PH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:08:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9n-0003NU-5Y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwkau706574
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=novCirPSAB+
 Ybo1QyBdlWXtDjYfXG49M7VvGodoMtJI=; b=MxqoyS5E0opbuHwGMPJbRD7EnkH
 FJrHR2nB6GcNJLUCaeFhOwNBExhmU/78LhM/EQaet3r2V3wiz9zxISDaR/zu3IUE
 8iJqSF1tjMN6w3hjaDJVvy/xpQeV6KnCvD3dQuhXq58/h+9R5nrcxoZwhO7pMcew
 X972x98REP6zJyYAqETjaI/sX/V+NwVEVFt12TLyOE3Ua4RQ7dHRXLct1vGqQSjk
 XkGkQEqGqUJLmMIkC0GnhDn9wCZjt4g83MwlyoXSQbPkwvzeJgu+xDWrVOwQS9Nf
 5i79ur90zJj5vogKBkz1gOq5Z9LT4jC2Lr4pRrWoiCg8y6NkITouvAXRzaA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29ktc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dd4e82d2c7so11243416d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259672; x=1782864472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=novCirPSAB+Ybo1QyBdlWXtDjYfXG49M7VvGodoMtJI=;
 b=Dq550JMq1ea9J9BEK47Qa11op59a/FYDivf3XMM1NA/v3s+rYUV8F9TI4bOrVrIGLs
 TAhwYEuL8UhMKe9QIaXEBIMyfYFTMNBb7/C17YJhAJHSlnyIbiR9kcccADSe6jMuAV0L
 iAJ6K90JEUDPKzjEZV/A6i0xHGOSPmOpI26XuwsFw9J+5r5R//XXJAu7adG3jRXZq5+y
 sFJ8hURI5ktBOrzZboW4bJte0KAOuIQDNX1aOh62mq19ctmPsF0xu9kEXSwUr/O9EUOA
 giaOkUHn4THn3gcBUE8goZX0mHvSGJ5GCIV+seweTtHmhFgafgQWoTa2QpLrLwjtv8kx
 EGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259672; x=1782864472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=novCirPSAB+Ybo1QyBdlWXtDjYfXG49M7VvGodoMtJI=;
 b=djyLI0EILroKE1h+AhMRjyyCCSxNTi7XQa8uX53sMphnFIGNyaDlw5FOEG3BtqHGH3
 tR/8z5g0eo4bNumYT6D5cdTkmGDr80hso5OBDiKDY+rY56ZBJcRmvTdr5Yg+r90R48j+
 9pYT4sY91cI2UH93cwQyYRHqCrO95UQTTbyOhu0BYzmEyj5rWuRYebir7OueHsm2qLt1
 w/csTCsd+yIEezOl4x+1k6UTmLygH6Hu4dPg1wUP6dyu3n6QSYn+0gaii7OKAEWKmBnW
 u0lxG4VLLD4Ot3MmIRSzAA0OjRZ+SgB2kbnGuIsuxUtQiyiHv1KkU/YXmGRQdn3FMe/O
 E3JA==
X-Gm-Message-State: AOJu0Yxu4ONHBNigYoRuUqOnmzQmqKIRBnag6tCGKr9w5kcoglW139zf
 P2c0bQql41bCyjnWxGe6bSlJwlQR2yTJWRfN4i3dWgeXhZNgR3aRic8fuyliLW/85+3pb0LXPO4
 5FsHvoikVzMnnNldpsfsuf4fIZNseLPIrNqLLau6GvAQ7iQr3eHjSV4Fyr9wX7jKBIQ==
X-Gm-Gg: AfdE7cmYkQu6EWtd71uJeGXM/dHH7pj9t2UzQSfdKCAZ7EJcV5id9/gRygxQDLt1E12
 JQ93HdmuLrk2CXRPA43z10+FhCVAG2Yl9kAgv5Pml3seX3Mg9Y0D5AsIxpOrMEr/SamP7pXFmVF
 zbr6TjgXK6acwI06gjO2mUKRmgsWA2FgncKaKCQh42GlOImNZBw4BKw2GYOte3o91J0Va5pnSIP
 AfiVYGYk938QFxGl44IYOg9NrenG6bwZIA5WXkMlzTujpj+MO1gjSgj6zccUgYh9QtZZnfr4bpt
 BwcqyEQVz+3c3VwYbF+aoh0XcKu9zW9npX0ceKqsglHbNqyPm7d1heBPX7xRZ8gmOFykbhY9ITj
 FsuSY86RJ0ZRuxCNR1vun2VSF+l4BWUhkN7d9mnvMYgDhuw==
X-Received: by 2002:a05:6214:8087:b0:8cc:d74a:8dff with SMTP id
 6a1803df08f44-8e3b44488b6mr86598006d6.5.1782259672415; 
 Tue, 23 Jun 2026 17:07:52 -0700 (PDT)
X-Received: by 2002:a05:6214:8087:b0:8cc:d74a:8dff with SMTP id
 6a1803df08f44-8e3b44488b6mr86597616d6.5.1782259672034; 
 Tue, 23 Jun 2026 17:07:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 24/24] gitlab-ci.d/crossbuilds: add riscv64 KVM-only build
 job
Date: Tue, 23 Jun 2026 21:06:31 -0300
Message-ID: <20260624000632.2149359-25-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3b1fd9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=BEvAcZqKd-QGyfCP7A8A:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: VpTqXdgt8SgmAzjjDvBYISL2KbhhWXr7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXxoH1qXALaeid
 ud4xeG3m6+gECiXt/mdWyyogEVIh96mZvAWH5oACec8Ud1B++wY4vUYERqavsTeb/skxtst3hMT
 uGmEVfYMUFUJ9GiqMvjqW16BYGeQYu8=
X-Proofpoint-ORIG-GUID: VpTqXdgt8SgmAzjjDvBYISL2KbhhWXr7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX9/PEiuJ4DlPb
 iNEHgmeEyOBWDfSQDRhnuvdo17U+5QSclpfcOUZQiKuMtWlczi5Za9a55L6U0wZFr14cUyL+bKN
 akyT3OXyab2yPY0o6Y4IFkeYap+VKkLO6nwViCC5BGfr2blo9FWbJxRXpwe6BTATWjDJUeSQEEt
 /cHclHmoaFOyj5F72myl7+F4pA5/SloDKOjxS/VmYfxjb9/2nq3mJRH6qxfrHmEfmc+r2eFRtL5
 r9dt/5mUW54UZ90WW2vD772IuXQEi/FiGoZnZRunJTwDjhPBOAhH/MRbOKphoTOU87NrIdW50bQ
 XoSjxUIJBpHg17nnYvYaYy/vBv+/vPHLgJozhsRX1fSj45fflFN1TTnWdEMyYferquKPGzogR83
 ZMuMguy1BNJL8nhlLxgKQ++B/wFhUkWTtUJeio6TbWBwKwYlASnPHn/nhfGyCSLDSRuiiu67uXy
 fcvFqCH9I48ML16/CAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Add CI coverage for a riscv64 --disable-tcg cross build. This ensures that
RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code from
being accidentally pulled into common RISC-V sources again.

The cross_accel_build_job template enables KVM by default via
--enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


