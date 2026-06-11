Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD3ACD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdns-0003P6-SD; Thu, 11 Jun 2026 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdns-0003Ox-7G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:42:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdnq-00037D-N5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:42:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1VEI168341
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qjPkUn/Nb/ou/w6S2hdZJlUY3x70pWjDL181JetZe0Q=; b=fDmrgoY+ciot/89J
 FoSEyt3lKATjuwhtTYPdgM9Dhtb1SDyA7MfHiNTztQ0NTW6ZpkbZmFq74Y3UQ6DB
 QyFIj7REisxASELbppIguA7vTjFB9qMZP0qKTsKDbK3zmaY/dnfyTvki6mCzi+XA
 iQACbLVz05WTADBHw6fQOHvc8sh4eHyU5h2sXDrwJA07WZMk9ulaIWHsg/4Ax+5n
 bZOUyAOFIfwHUbL5gqShbZBQSs9/airIRW1Djvz7lAmt0fTVZULX5+iy+q1BpEOb
 feQUIdoZU1viM1M9PwTfHNs0Ef9Pv8v03xMXfOAvSb2cEBJC4XgcMwmEAVB4IcJw
 KHxQzw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ub6vm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:42:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51775f7b2afso16151861cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781178149; x=1781782949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjPkUn/Nb/ou/w6S2hdZJlUY3x70pWjDL181JetZe0Q=;
 b=ihJQ6sifSL1mNwrCNpadOs/xvrVllBL0On1yk/EsEQbcJu2DCGveSf04FDYt7blH85
 eqxMgBJIsoNKWfngvKDIF8p7oiG7Kk3UDSdOke+sVg8pnW0WzptkucgrhC+89FlljDgE
 fvu1QK4EZjhSZX3n0hDJqevs4o6koeTX8a6VRjlg+TkbuEtX/OcUMsQAgXNiywzRd8X4
 ffH56CdWzqaRZLzzTeNcEyOmAoQmXLPptjLHYHKqXBtg7/01BzujPFaVX2ZT6fah6hx0
 o7nqrDTFZECBB/hGZYRXKkakprMmNErcW3GHcCnT6wfURjTKdRxzb61HMaNGLeuutZBA
 Ycnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781178149; x=1781782949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjPkUn/Nb/ou/w6S2hdZJlUY3x70pWjDL181JetZe0Q=;
 b=ejdF6n8s8dNema+MknZEcj4RmLp0WgRcWBbzzNWKbVuoeYBe0nRNRHNwzHwBBJlYCm
 zUpkhGx0NuDcatUrzgXg2KFAvSEIkijUQMGD4s1zOvq25XJWTvNj9w/re/Hvgl37coPf
 5sMQLf4R1dbBt60ijaKRouMSlitbkB3o/URlC/nKuHuTfrEDY1Xmz5hSVL0zMfoHi5R5
 kjaHZ7bBOGGkkxWIu9Q7Qp1hRs6BNfOFQnKj9G2nGq+U1guN9DtpbV5/VnGt6gaUCHuf
 BDNkbbqD+gX1aA/D8dhHexf1noUeGl8F1LC02MEQa5ytvjbMRaVph4SjPmHXZhY6uAho
 ooqA==
X-Gm-Message-State: AOJu0YwJdlYJBSQh5+pU6Ee+mto5td7Bjo08WRc+xEydMk2e8W8ker2S
 XdHdK6S1hRMsw4ZatZf1t1dWInWZp17Gg0zFe/9Xiiv/oSHmj5MqYEGM5y8WFTzzq9EWvdd/4XS
 7yQIIkZS/hr+MVmQvAA8eKoWJIgHyEhzQZ8CURgzbd2I+yUHPub8evD/+ZHDqVr2Ot1Ct
X-Gm-Gg: Acq92OF7nLlclgLpZ74Mocb8OaX012GorVALDnsIHUP5LLDym+3eZOwSm97BwXWE3aJ
 /KAVWJip2L1SZQ2TzwCzUlZ2s2bRjcFLX/eKItkga3KWDRNoObPewupYJ1WCiy/ZF0Z7bmRWrIB
 sfEpcpiqRCNVVmb07kiV6teJoazT70H5YWlATZoGzBWZYvhyE/r8zPVmudD8e2M9ISdrMGqEfGz
 ZPwkUuEXC0LJaENqDLRmZd7eJ6bjZE/RCIyJU0GpNPuOMJniX3IVA437HrHYORcwyNh4KiAL3aW
 kOtCUVHnbeT5K7dMA5FKl6NFrZwvOzAJ6L94tGuxoE7Wv+PZtlU9YKsFBMJe/OakJYqZWsBRTMY
 AWrTyjCX/dm3X0deCC0BXftlRDrlxUcCi0/9sBaUDVowwUBa4TOkzxkHU1yxy0gRhIdVGj/Hjct
 u9zjDaqx8oV1le4Q==
X-Received: by 2002:a05:622a:3c6:b0:50d:ea1f:f99f with SMTP id
 d75a77b69052e-517ef10ed01mr24780891cf.31.1781178149181; 
 Thu, 11 Jun 2026 04:42:29 -0700 (PDT)
X-Received: by 2002:a05:622a:3c6:b0:50d:ea1f:f99f with SMTP id
 d75a77b69052e-517ef10ed01mr24780671cf.31.1781178148764; 
 Thu, 11 Jun 2026 04:42:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm89071059f8f.5.2026.06.11.04.42.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 04:42:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] ui/input: Have qemu_input_is_absolute() take a const
 QemuConsole
Date: Thu, 11 Jun 2026 13:42:12 +0200
Message-ID: <20260611114212.27472-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611114212.27472-1-philmd@oss.qualcomm.com>
References: <20260611114212.27472-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNyBTYWx0ZWRfXzoTaqVECNx1B
 579URMg0U/nGywMUvQ5NaJ4/9hm6/fQZf8Ipnf6ubU+BGU2mEskmVvGzMtyOYnQrrjiYJpQytIS
 HsN9ULX73O+iFIWopNsW0Lur32u1aCE=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2a9f25 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=x9Aiw9FezRBkBCJUNdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNyBTYWx0ZWRfX9GXpHmP3jnAA
 DY9+eYvJZbGmVD2aZA+kTRhDmaWvYxknZyl6VbNT3UueYJYQh3QFI3kvJ0qNk/x9IpnZZLINEF2
 6rrPSFglEX1S3pB3NA42zYU+39wuUuLoIS2KWGjZfN0TNvQXEchJ8DrkcsrcqqXaCad1rPc2Y1N
 y4KG9OfOJgRjIRSYqYiNOmLZFAoOg9jofoC/nSK2xsHCBZ0aA8RS2LDNw/w4UbBob/QNPhLrEQN
 Kk4WaiXWFSMJvKOQV2TkpXhizI/bsD4sU3JTDEtjT84n60FTzTDhFlzYCUEjycVPQ+JfMdvEK95
 BARLthEfZjilg28oepafh7pJ9rnwj5cG0G96oXcWh5LLDPW3puNortaVpj4lU8NFrGdsvDzEL2H
 LGw7M0MyippUJpLeJ4PKe17cW90HxnnLjgJOP7+G7YIYBVMiewUWQlQaTl5BUsHU8/+BfXTM4da
 ysiyS71Mu2tOEoTCVOg==
X-Proofpoint-GUID: VGXQdnm573NqgG_Qo83ZNYunftihtDyc
X-Proofpoint-ORIG-GUID: VGXQdnm573NqgG_Qo83ZNYunftihtDyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110117
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

qemu_input_is_absolute() does not update the content of the
QemuConsole structure. Make the argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/ui/input.h     | 2 +-
 tools/qemu-vnc/input.c | 2 +-
 ui/input.c             | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index ea2d944a7ed..68571927761 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -72,7 +72,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new);
 
-bool qemu_input_is_absolute(QemuConsole *con);
+bool qemu_input_is_absolute(const QemuConsole *con);
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out);
diff --git a/tools/qemu-vnc/input.c b/tools/qemu-vnc/input.c
index 6fb73b31248..9f21d20d26c 100644
--- a/tools/qemu-vnc/input.c
+++ b/tools/qemu-vnc/input.c
@@ -175,7 +175,7 @@ void qemu_input_event_sync(void)
     }
 }
 
-bool qemu_input_is_absolute(QemuConsole *con)
+bool qemu_input_is_absolute(const QemuConsole *con)
 {
     QemuDBusDisplay1Mouse *mouse;
 
diff --git a/ui/input.c b/ui/input.c
index c013cd9f7e0..6a80b42ef3e 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -98,7 +98,7 @@ void qemu_input_handler_bind(QemuInputHandlerState *s,
 }
 
 static QemuInputHandlerState*
-qemu_input_find_handler(uint32_t mask, QemuConsole *con)
+qemu_input_find_handler(uint32_t mask, const QemuConsole *con)
 {
     QemuInputHandlerState *s;
 
@@ -436,7 +436,7 @@ void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
     }
 }
 
-bool qemu_input_is_absolute(QemuConsole *con)
+bool qemu_input_is_absolute(const QemuConsole *con)
 {
     QemuInputHandlerState *s;
 
-- 
2.53.0


