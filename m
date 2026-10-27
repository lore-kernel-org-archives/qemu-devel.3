Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF844606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1WR6Y+5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=byXy1Nkg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmos-0005Bh-Bc; Tue, 27 Oct 2026 15:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoE-0003h9-KX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoC-00027w-Mb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPQl3553875
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c6kaTYYd0Yy8EPRQwert6k6IgQJP89E4HXVxDGkqtJM=; b=m1WR6Y+5IfOOqFx2
 nLMoxkmOKFJzOHsEnKICyXwWQ4dbl19VOEw4AnjHQa/S/whUtk9kHKlgX8nyCWtM
 AX0T/ZCjnDVtmqZBs10Nibv4hEDJ1ITEFjM4lD+cyctnD5ulw+XepaCc4aEp/O0i
 rKyyKmj2tq5GBANdECd76UZlhirzcxVkiEaEPc3aap+9qmlnUPasH0AzR4eLQa8/
 vrgeeNY/Uq3i+0l+kJO+YuypHGCQNKCu9J60Tue9ZthX/HV5Z1ak1jziUMfxijs6
 SGjRQju09CZbJqLQGww7AhbloOZSL7kEgH9Fkff5UfSUypzIIJqdwdCvcEfW7mQZ
 isynTg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-943e8ff02d0so11697985a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129167; x=1793733967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c6kaTYYd0Yy8EPRQwert6k6IgQJP89E4HXVxDGkqtJM=;
 b=byXy1Nkg1SVCQSBzGvIUTab5vIr6P7QeNUYSM/fcGU8WH9G0RliYmKNuvYCV/oCf4f
 q/RedXb8Z+AET76PC/ZYZMpu/It45uu36TwifMMCXcODX+p3ar7u1fPm8CO0d03Q/qAs
 cxuIDhMEMmE80JIs1RAcssBZNV50pRcoDLdKva4uQjkMLH1mWhgIgU+9fLFHyBc3Nenl
 iQp0pKMZq415kcWjN+hF5WuCRFrFs8kUGs65kI8wznVc/M5HDp86yy+XK7IgWB1cbcBJ
 0/bU1bk4vX182KLkx6lsIr+rdPofIQiN5ET6g95uQ7+H+u/5hxJFgBqWx6PLGhLLBCqD
 zl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129167; x=1793733967;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c6kaTYYd0Yy8EPRQwert6k6IgQJP89E4HXVxDGkqtJM=;
 b=ZY0BR8391+KDBBnHyvAsgYM/1BePg1eFs3ivCEwiYwcQf3jlJfarQ0j/z2K3/N9Tdk
 6j7NSCHVE3SYn4O1UoM+RTFSvOEJCKOAzuoSNE4ZB8zxsn4tGFP/Fs28lGqwmVs8CIXq
 fP4P+24tdMphrfH3domlhHips/5TajmzdR+w51LE5ZsN6Zv1Ge8awTYF3mPBX6OhBhAu
 xijgzMP6x0wrqCDVCBJSueNrdA8N3bs+IXAvPOk4QCBwAIiaqPMq2U/1OTzaZsat4CGv
 uxZtNwnOTxylkstoc/hiGixDYycw+6BCuMBnWabK+6Kw+bwP5OPxZdfSI89Gxhkzha6E
 sthg==
X-Gm-Message-State: AFq9FYIalpz6NBjaxyenPMRfQEicK+ZGPBEwSCR9IlJYgXmk7ouhAgGu
 4ree4egwFPWlo/ahHKwnUTCvBIZ+kKLAAYh9EiPcugnkWQzBqBXK3tasDvnXBcydxMeVzHWhm1O
 JuKJmnZmJdQD3iXGtBE7WIMCavKwriMc+gWC/q3luRceE+jeVAQJ+lZzK6xLlwMOYFQ==
X-Gm-Gg: AYBFou1MMd8wBdxzLBj4g0tD/vmNmsv7cOYvc3JmTBAJCiVFVNJh8XTffU2xdqNN5Iv
 XRYDHHShcaa7+rb38poETsPjXbgDqVEDO5QRpNAZ7Vsbi+uriwpgQn2PPDAa5kF9qU3qzdv+J6q
 JMbFeQEqZkFvYKHLpKQZVtAO2+C/0aJMuzrTpQZcTHbVtLZIvZ8ztLAajKbBXntnZe/S8+TX0/H
 tppzEGvuxHZk5pWFubMYC2LlCnfOE0IiktArFAVyOrT4kE7aa6Nj3xZkuJie/wBtdrjJy7UicTB
 Zhz/Cfv8QKlav4xfKfaB0b5G3rcEyVOz58Ulu3a96p5hWwebM3q54pcqpD6YBgZ6QBFfwpMYuss
 kM1wVSTlzNxb9o/tQ767IMAzLdHZ5S8Vn3p4cfYx4H4gZwmjuUgqLsVpN
X-Received: by 2002:a05:620a:4725:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-940ef9140e5mr1772568985a.28.1793129167084; 
 Tue, 27 Oct 2026 12:26:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-940ef9140e5mr1772564585a.28.1793129166545; 
 Tue, 27 Oct 2026 12:26:06 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm24488516f8f.30.2026.10.27.12.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/59] hw/arm/Kconfig: Select missing UNIMP in config FSL_IMX8MM
Date: Tue, 27 Oct 2026 20:23:02 +0100
Message-ID: <20261027192341.9197-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXwn2kaIeZGlsI
 8cFlpexdLg357u0CQtZ/O9fRss3af0f+NXH0+K7l+EoQNUiqz8m4v1vahDVTOExHX1yFFCYDv8N
 C7KCGe4cgxPaMp5D5MnodOYzMlRvLlvgE6iJDoPTXJf/jGkrc8+irbbm94h6gqm6R9tsoXCy5kH
 Lm7P3u3YOiHqbvZXhnBrcSy7b9EEgLvi/l3EbqKBCT5SV+KB+jslWBjJwaQYOo8kcIgAmK1YMTh
 VymaEDOIKvKOgI7gE/DhV8RuqJtONMT5QQFD77PNBvvyMIfUQXkIB91Rf6ItzxAJMA4L1psZhu/
 5qr7MSQka4GuMyvRBhfNJDTh3lsylaf4QwlOiGvv0XAB8pMS7DIFJ8I58mrCEictQ3Qv9p5e5Yw
 jzcni1DPIm7emuRSlyYyXh/FRrzDqxxBDOC4eWTHwHQ+AAzDSsKk7IZBdGi8k2yu+yUlpTYJb4V
 y7czF0b1ToU9XFIW7IQ==
X-Proofpoint-GUID: 2YpMtW14tfsNyd27GeD3wxe5-Na-wdbA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4s6l6P8jZIuu
 tbJL00yIF/5ul0vt3SQwdwujCPWouyhTMP/tgZ/aa9YDSgstiB/GiqljIIlEVpruRlGsmAO7Fhw
 1BoDy4jAMjffqwgvDwt9X3Jfup6VmO4=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0facf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=y-BW506dPmda5lYNwRoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 2YpMtW14tfsNyd27GeD3wxe5-Na-wdbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

TYPE_FSL_IMX8MM models the whole address space by representing
unimplemented devices with TYPE_UNIMPLEMENTED_DEVICE. This means that
UNIMP needs to be selected by config FSL_IMX8MM which is currently
missing. Fix that.

Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-19-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4445f16f4517..6e8755783e67 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -627,6 +627,7 @@ config FSL_IMX8MM
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
+    select UNIMP
     select USB_DWC3
     select WDT_IMX2
 
-- 
2.55.0


