Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B06AC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxV-0000Vy-EO; Mon, 06 Jul 2026 18:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxU-0000QK-2L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxS-0006tg-Ct
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqai1628729
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=y7cc+W4GRwW
 PtsnsbRTpIncVHtLXOS4GX2BlZU0QalQ=; b=G+d4aj0+LylqsmKxa0SCY9P3Og6
 /uMv7h4lToMgC5mpN8WcUL1bPlH6NfmzK8uzNFnHDNPvy/wGt1Aq/TAbsm/gv8JE
 nhPx5ZRDWs5ohjcWcK5qeK/1xpktlk2Dqqej8YfkwIJDZcZKtOSVks8AH6seIvsY
 caPmGNRsnQmNAP/JT3oU26xoAwuN6/d/zu2AXHuNMO3KuaHmibOUuaKYHZJ+LHdG
 RSwBvDJ7DR2U1gorQ1gMlAnvdJiFuDHKfe9dU48CLtRkq8Q5HRG3MobYiivoevcx
 Sy6ZIRoIPVFuRSb0sGvow9q0eREV5c7qBamZISCb7F86tIWC+AzNKqkVL8A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw1hyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88da04b719so2802260a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377512; x=1783982312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y7cc+W4GRwWPtsnsbRTpIncVHtLXOS4GX2BlZU0QalQ=;
 b=OPdNsQ3B/gzZiKv1etJGbJNZN7oUsyu1ncZD9dOX9ZNRSnPS5slEb9Qx8zxSbkuUxM
 jfnnXAvwLkJVS0TuQq1ZhxCZmN0iZeo9cy8e2/0tPAFBCBbsZWedKpxWnduQ/HTM+ePW
 3ILt9r9umJPOk3KP/CunN2ijsLTdrfOLUp199kt/wlf62kvFozda3hLJJW8UbAOGQ2An
 pl5Na2BiJRDjFswom0kZapPKRBWuSuWzGXxQP2/e3xlRKXSNOdySGXBtglc+XWUWHvA1
 PnAmyjkvlL8eqF/M4rkCs6t1Zq/LmuDRJkP33WiFR6ErDQ9Wf6H5Qiy8ocZ9Axbectmj
 vVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377512; x=1783982312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y7cc+W4GRwWPtsnsbRTpIncVHtLXOS4GX2BlZU0QalQ=;
 b=gxE+TFiAZg4+sMLqgClHeBVZ2hzPBlQKf1FAu99a6dH9Frkh/v8sjxOPGh1zqLxsGu
 /9+vF/ebp3nGW7HnKnTfBexVpUlY4oQSzHz/i/45ofF1zku/2bEowW1hEzWikOc0VKI1
 kzGB/H8sL4J2q150G4MHqrGnxPB+iwhuShx7/HZdTSdUx0PCcDKSz8goxts2VmKPOFoG
 vIqY15hw2fr5jigBCst6Q5uKGoUWHjYh4lyRnjEUDo60XD9d14JdMo9cpiqDsi5eo2Kx
 n5xpVwWj51HufqQ4EuMq6jQrZ7lVGoJ4AnOcWILEYE/CU6xqpfO1fcDcoO5eCUKc/S2J
 xlmA==
X-Gm-Message-State: AOJu0YwfepLGozXp5aj5qVpCMAiMErkqm5S1SUxAz/zb0nzQwmBa/IjP
 yYqy1KZfkVdXTCSs9YNmS9T9psFNTPSZwzQBwpme/esT8ugQa0vEBdafA3XkYZOZTWpTB2acaIX
 y8PGv6NbTd9M9oxQ50zK2/LRxe7RFYz/WAeFMvV3wh/Qq9taq6IKeYmn3xTcRmUg8cg==
X-Gm-Gg: AfdE7ckuRL7AKBK+w/0py4l/ftz0kbcYZA3Ko8cc/uGv32UNGN+1zskcLR8CxCDpnrb
 1u5LjR4tEqlGh3vvMPXyqpfjR8MdBm5yaunqC5OI3x3/sUjQwMXj0CVcJA6IKqx80US4CM2DDwH
 10aVTWJrBWAifwhCXxBWpdpQ8McefuU3GqB0kCsbYkKllmj8B6A5KpthkWONiCEhZISusRL2E10
 JIz6wDmMlJTasDafFD1PMoGOagUg/qWDzW+/VwaV4+Azw5WVmoH+sDMg5id/5DVtYQ52qIWpRrU
 64GAny3t3IUnqq4hLBDDMRCmGXJf9I+92sB9h1cuWiy1pjxl/8zFw4MqEigQ0WJvC9ntD//54xY
 Y9E3pg/kB0QKnlkEz0So3orKUt84eWXVWUv9UYgcVXrhNEVyFFPhhIZ08H93m/Wx/IpEbISgDP4
 Ae9yH1Cg==
X-Received: by 2002:a05:6a21:3294:b0:3bf:866b:b74a with SMTP id
 adf61e73a8af0-3c08ee78ab3mr3097596637.35.1783377512388; 
 Mon, 06 Jul 2026 15:38:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:3294:b0:3bf:866b:b74a with SMTP id
 adf61e73a8af0-3c08ee78ab3mr3097572637.35.1783377511938; 
 Mon, 06 Jul 2026 15:38:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 55/91] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Mon,  6 Jul 2026 15:33:07 -0700
Message-ID: <20260706223343.988769-56-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9dhMUmz5nQ7l
 0UdVr/kKeP5L6S8Kt8dSgVoJYtOoF2nXXPsH3w55ZH8bL3D92caHu3Wzi2b0j1UdOeguOMdn5uP
 3dH0e3sezYKH54+ofl7VOXdjq7WqZLY=
X-Proofpoint-ORIG-GUID: cn7jQnoCX4dmQ6EQuI84VsX6f8fUQR7H
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c2e69 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=JRkr2GGw8Z1LICAQipUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9qiuDdiXOqw7
 XPvJOdE8JVFhjDSZ37PNxPAuYoNrNl0zVo5hJYDDHYrVKfgVkBNPMBKggb4WTurm+OmNnHDILxb
 kbyf6GX4XM2secZlWYjr01sd06LH2TZ6tK+AK7Vh+KE5A2ZLGEjE47YXRqogrNCjw58SjTLcCPP
 ajb61Q/b/FiqddPMOepyMdoupKvMXgBqvnuZio9k0ScQmFSqrqnsBlQt5148nORV5OhIN0vPLJ0
 4MCUCSTaVQOXi1znoBq+844WXDtcU9zy9/XcPv3WjwPLOomJkANfWQhPqZ+I8PPEQevKuS66ftX
 sa2sR7jiOpfI1zagDLpg5yJwJt+8WiD2Ms+UQtPJ/VqlwoAOV9qf6vPCySH+Advs7UGkYkzb88+
 o1fHy18FHEPAxQB0fr2nZdE60b8yTzs/wKYo3XhHaWOXeZ566ZxBAJqq5js/7buShwUsggyqHj/
 emxIAR+3EygHqEQWuRA==
X-Proofpoint-GUID: cn7jQnoCX4dmQ6EQuI84VsX6f8fUQR7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/probe-gdb-support.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..6e3b2579770 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.47.3


