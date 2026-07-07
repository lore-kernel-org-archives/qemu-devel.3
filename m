Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182BAC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eT-0004Km-VN; Tue, 07 Jul 2026 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dQ-00032N-Qt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dL-0000ah-5i
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9NTb3740993
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y0iWpO4qul3ujSwbc//EU/lt2JDiLE8eQeaVXdL7YXs=; b=ogjm/v/3kiJ+BwfP
 e97ODi36Z4RNoWgK773+liZ1CdZRHf2bcVDPVe4l4enLMGCEnYOvNifabVYa2PjB
 0+rg85lKNmSuLz1XtsvU8IpnfQutxuGIIPXWR50X1cyNSfkWfyubhLdMDwRkrXey
 6aML8Fx/4F01xLlcoeU/B4SUGL+TwbUnxTpGRkCwGBm2hwGVk2VqCJwEAYRCVgbz
 xsCbLQEnk6ke2seDnJ8kv1pSru+gV+76GWbMOsTXosKKyzUIQCXPwvIo/LPlJBJn
 Nn7U6v60V85+Z/Mc9yIT61xKeN3pGcmnYzNFYTrWwGeqEf93W//NZQJgpBSCu0vP
 US9v8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a9kxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bec738909so31110681cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430081; x=1784034881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y0iWpO4qul3ujSwbc//EU/lt2JDiLE8eQeaVXdL7YXs=;
 b=M0HVdihDn55pk0bKzN+Sqj2X+BGsd/Jxec/QYn8W12DjJB2YbcEhcJpoIG+PgJ5Xyk
 6R5Z1xftuKGjoaCwjqH/8wpl1DIm/sfNT9EfnwTDB4D2QaFYST+V7eh4pTZzVt11Mk8p
 KVQzsXVxqlj42BvkkW9/YdZtowt/N17GaWONaYJ6XDpo4BlaT89XTRjleEij+FMv2Bx3
 83X4oHP88Os4FXxK6Wg3LYlr3zfGXMc4gL8b9CC7j5G31N7vQPk0qfCLe9FZ9hCsIPKQ
 W6VILMCp/4PpZLmhGfQXs/wbS7YBF2DtuC+rfXRqHtpIJYQdKzu8bNEfN3NRzzEUH/cZ
 qO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430082; x=1784034882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y0iWpO4qul3ujSwbc//EU/lt2JDiLE8eQeaVXdL7YXs=;
 b=Sh8noFLvK2RYEj4Bm83mdodWzOPHWnVI/ouMnd/0JPofiY+A3BkSvQElcIXR5Jhlsl
 IG7jg27kAEGpVNRwGymxKDEXCGd9ydxgsT2PdCErURYW1N6pDpwKQ6cD7vwbdKxB3A52
 PvVNALvOoAy2SFje92qfFKLESFtexrcYTV4vIcNQIAzeqIO3xvhuOQb9sMPX1izCLGuB
 4aOeGY4EH/ZqlO9FoewpJ3tQCUXkB8djsxIdXQWfv49mP4mJTrAGypZghf7MUqYzSa8F
 rHCsM19tWPJxWDxfFniKQu++wS2jAVHlpJ99p4bMtTZslvr7vBnfBef87z/sJ1/aSqIN
 ziRw==
X-Gm-Message-State: AOJu0YwzCPvaaiQ4Kto9h0esiADBySdwDHaZg13DXn4BpMp1vVRANy5D
 QEMKu5bJBIlQ2PvUakt+KSJZdDieCqmQZhMKK9gPCBUAobazkqBKuHEup4JW9+8jnJNotJVQXEO
 6nRDWfV2kc/Y7HB8ymFAFyoYTXo8hhUKpmB2LZ5WNKUOzX/4wDFAQLxhFcyz2lhHVfw==
X-Gm-Gg: AfdE7cmHJhhOK6hFLhDIFTrlhk7q/tOH0wHFlnrjHuWj9mIoS1VlgwuEmooF5DBIJy2
 XIZTTAWwN9bDXkTkVZw8kIt5Ax4g/DP4pm/zNgNvV0Yeuxb0AM6u2N1U418PKF9sm5xpWLzCHtW
 F+NT4cqup2Bde2qXgxEGTVXIArEKwRxz4h8Oh19vEmb67dDzozBLtzVr+XvDomQsuzlHvsGCkA9
 5TUwiFkUut9Zz3C64Rg3HAdUAw2JPlbCNWqKXBFfT/nUL0w46u45ZGozLt+U483d2bLr7NS8sDK
 bAxmuJk8Qg3+fPUFqXZwBW2lR1P0UqHbSIF7uHM0/gx6uJcrnVGhlsab2DT3EoCxlAQGf1JyRhc
 MgMphQUMq2e7g7u/5P/Oqmh5qPKmpSZ8q/RWBa+UsDd8PGkGVY4oQFnDOWtmwuzjLje20
X-Received: by 2002:a05:622a:58c5:b0:517:8a18:7624 with SMTP id
 d75a77b69052e-51c7477f4a5mr53569321cf.3.1783430081413; 
 Tue, 07 Jul 2026 06:14:41 -0700 (PDT)
X-Received: by 2002:a05:622a:58c5:b0:517:8a18:7624 with SMTP id
 d75a77b69052e-51c7477f4a5mr53568801cf.3.1783430080755; 
 Tue, 07 Jul 2026 06:14:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm6322458a12.16.2026.07.07.06.14.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
Date: Tue,  7 Jul 2026 15:12:09 +0200
Message-ID: <20260707131223.51505-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jN5-sza0RdVuMTEI0niymwt--2j89Jlb
X-Proofpoint-ORIG-GUID: jN5-sza0RdVuMTEI0niymwt--2j89Jlb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX6OyOOvGIB2Va
 vvZ4ojiOlTOR6w1h+a3YdlH1ETRCdipo3WLv0hEFDe7l2B3JxCmYvWVw6mHmhCsj9igXFIyFmCf
 mOewYzIJBjozPC2P4CYdYvOTg6/nnqA=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4cfbc2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Eoc93EqmeQnS0nBNkFAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX49Wn8L1+d7ys
 Ueo1crps4iA+fs8r9BF8wiEPIGuURmXD0sUx1qSMLwcXB/qRWTdMnc9N36MYB29MouB0B+m2QXZ
 /gLLnW8ZuUtts35M0mzaQthdwSKaV17vk9kfqM38YHH4fIeFFEjkHJFzdSWO+RgkasZsAZX1uN4
 HSouGLYE6IllwxEIpzYDo33iz4tGyALthZpmnWMS5SegBy2eXWW7kEib1Z820YidICLTRTc7YZV
 hdcaQYC4HC9I4a8m3ThHRsVmYWpSv+LNhtBnfxPENBGi7zWK5FA14r9ZSL0gpQusgtGoPwKWHpo
 /4jfbqqoOh5Ja6dXP+1DPbgunZ6OQowjpUgn4EhZxUj77Zk3vb+eCMYLV7QNb9cOhfDg9JH6YWE
 znzCnQcyMuizwBrDzYTVih3EMJ49emyoCoT/EA5wXm2ua83CgBRTDMlMsadT+tgKe98U2MxKjbN
 Iax1A+aAS020WuUfjGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Bernhard Beschow <shentey@gmail.com>

Open code the DEFINE_MACHINE_AARCH64 macro in preparation of creating
FslImx8mpEvkState class, needed for FlexCAN emulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-ID: <20260702184038.178196-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/imx8mp-evk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index b84ac91a17d..4a0c9df76b7 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -113,8 +113,10 @@ static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
-static void imx8mp_evk_machine_init(MachineClass *mc)
+static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->default_cpus = 4;
@@ -124,4 +126,13 @@ static void imx8mp_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mp-evk", imx8mp_evk_machine_init)
+static const TypeInfo imx8mp_evk_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("imx8mp-evk"),
+        .parent = TYPE_MACHINE,
+        .class_init = imx8mp_evk_machine_class_init,
+        .interfaces = aarch64_machine_interfaces,
+    },
+};
+
+DEFINE_TYPES(imx8mp_evk_machine_types)
-- 
2.53.0


