Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1517E606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UOXVXQ21;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dstexu5Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSBU-0003WZ-Vf; Fri, 20 Nov 2026 12:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAg-0002zt-JQ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAf-0003qo-4O
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:10 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKH0aNw1882370
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JmdLh6eIpLeeHj6fyYX4hd0YOlk1E6eEip2rEcS+gxQ=; b=UOXVXQ21kUDvXeo6
 v6x/mjIsqD49g06ZL0Qb+ehaUWOYnY98HslG0onr+LwyfIGHCLZXbz7U60IjItAa
 Ps926VX0cIXuUPy0jJsFwV/MsFkcZ599lez7KAFehg1S1Z3q5cgmZxL5bHRyYsga
 FaI36+D1dRsmnJ/1BsXcvGHyOPuRDDOR4/uW19bONanUG/Ts9+JIftyQ34ed+rZJ
 sPd9+rQuRoyE+knUozAfHeamoYwPYcT0JfBaysK2Tr3+IFb8tduhVD4k2H8La7y9
 n6nWK9mESYQjOc8kff7iNLIyJtUS0dcceoXHQaQYnmwsGRdHn8BcSObE5Zwwm5If
 s4suTA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2t7vg1uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so234370285a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194787; x=1795799587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JmdLh6eIpLeeHj6fyYX4hd0YOlk1E6eEip2rEcS+gxQ=;
 b=dstexu5Z81PiYyvHIpODbr7ujbi3jokacqEYgnxpaPSWLt8xi6YxfU08/kp02glHiU
 OVfYxaYKdpFIaSAxfYQcHEw9ZR/ARwiVPa3CCmVjviqqogGQ1FgT6aSuZbYQ5jCmHq1C
 y467jT1EgaoLckhM9ptyFrXH23pOjkpRwCXKNvek/zti9hxIS2kZuM6pIsBHwhLDcS41
 mjSLX16VYfiHCB0KB57Nw+LW7PB+njpRX/oNQIC0+PfQabyTcVDf775ZZ4exxlN2wxrN
 jCiUwx/gOMEMJ2y6D/zB0rToIDhk0BrSvC6Os4umYWDwTnxaM/VjRkWyM5LFgPt4vqf3
 elog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194787; x=1795799587;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JmdLh6eIpLeeHj6fyYX4hd0YOlk1E6eEip2rEcS+gxQ=;
 b=1MclH//dmAphi7jiV7UsKr9p5AtKgUZiuRea1p+RLWVGMyrdpCTgnoyTyGjxTfHtGA
 TiaOKd3s5hLYGnn0oUx3Uv0GTDTXv5JI+wDV7iJgyHDVxqrBs+XT2q69Ivhm+udaUgEe
 xUQD9lM1l4gjK4Qp2egJ6xJtUhvfZeMLO05PdrhpyWOdDVHnXJZ6s9mTwtHG5KZSt3Lr
 CdYZpe92+YKvaobpAQk0v4tOp9hhit7K68A7l0J1uFPXj7u58FvKLF9/6pkV2/wuubbL
 s3Z4V1bnjMdDGTE2xPNoyEqXTYY8yEMRrtVcykNFlJ6zIqfVrht8myxZD1E1Iy9gdwxo
 Dwpw==
X-Gm-Message-State: APuU4Z8JVGONrZ9AZ6Cr9SmpZ3RxjfSOQ+mFvDbbAXSNOABKiyS8Fr1m
 dOxVpS4p+aTUxjm5YlXiXaSs2yJQYhHyrGtOez9PEhm5P/Vtg2lMRR//6Ih0kvsfvl8Sze1SHSd
 UjUoGxCI6YqurlOrNUyX+LYY10BA+jY2jTqrzyXyd3IQXWS4+Tm6AewnNZZhabXQqJw==
X-Gm-Gg: AYBFou04qofs8l4ljnnw0t0w/PuDgoiF5oKQwrU+g4Zs7JbqVY71dLycvIXj/t353t+
 zSTZXQTQ9MYhkq8jzk+m4gtFPajD2wCOklOG4pcyhIHadfU7NgLcbxD13AA2q1qfanOAxIRwA8c
 lD33Kapb4/cBb4EIHO7Sw6OsuVAmGce6pa4my+Hb2ynNoG23io5BC89BUQGmsymcI40GlDk1m42
 JtQxGLP2EPxeDfJKpD96SlnMfTLlbvGGzD5jUvzClhChs3jMbBOcER9DEv3Arni380JJHALWoHA
 ggZiD+gL3Ue1jV2uVrwwxA7oq6tJjDYDp4vwL3m3QHaka/WBRdDhDPmcGGQsG6m4jTTELZK0Tzf
 ymw76KmcsMyZGvoy+KcbOJZiHrHwzf7WwCiYP5A2Dlu5no6QCGcQX+tjWmakj3fF+/MK9feTJpa
 QV3UUOgRoHuMRRzw==
X-Received: by 2002:a05:620a:468d:b0:93e:d051:8f19 with SMTP id
 af79cd13be357-949ba9b3950mr620271785a.40.1795194787018; 
 Fri, 20 Nov 2026 09:13:07 -0800 (PST)
X-Received: by 2002:a05:620a:468d:b0:93e:d051:8f19 with SMTP id
 af79cd13be357-949ba9b3950mr620265585a.40.1795194786529; 
 Fri, 20 Nov 2026 09:13:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm497385e9.4.2026.11.20.09.13.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2 v4 04/14] hw/scsi/lasi_ncr710: Limit max_target
 and max_lun to 7
Date: Fri, 20 Nov 2026 18:12:24 +0100
Message-ID: <20261120171235.61325-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -aAGqVtKBRXICrID4mxHhsdcg9Kn1MNR
X-Authority-Analysis: v=2.4 cv=BZZNQbt2 c=1 sm=1 tr=0 ts=6b007fa3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=WsAls44tjjwPSMURo_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: -aAGqVtKBRXICrID4mxHhsdcg9Kn1MNR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX576YYmkI2ky0
 zflJaa9jByM1vou6dO1GGREBPHOQtC0vejYf8NA1Cw+IZTZT69+GU9ulecGh4Cj75/rrn1G2RT9
 ODve1S2UWBLiCgvxgftso0tpJoHTfC8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX4LLoXXAUkzrK
 E/+3hxlKH3uj4R5vc+ago/3YtAh+p/mtAj9BM5e9EsxE5j+vnbkwL0Ia4n51U1kW3/R84zlKBh8
 zoivKDMQc4J6Sm6U5XF7sRDyO3uT4q6eezLysNmb0BZfC/yBYpBE2OurYXs+K6KeFNhQAduiR6p
 NAPW4ET3o5MP+vSGzyFrI4/BVG+naO/HoIz+lDKszM/A0RkjhgI0kijiTnb7sEoput2DyVjNHBA
 WSGrx09QQxClbOgqQnTHyYTJ1Ra8bK9uUVZm4iTou5CbBrXZbXD4lgh9wHMGreUyywcJwva4fV2
 1DiDhU0lJut6Akb9cEio14uNfBIGle2y+vHGQEwQtTIGfoSXmrLK7cgcxXgYl3WJ/3UKafPno1X
 uxeKmNZ+0l0aQ2XdVkeS9T05ij0FveX9jLWsRJwzhTM0Ua2p5hZD/mTHseQR7B56UEkGmZ9/X2t
 kxj0JgEEx9wjlMnSqEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
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

SCSI target IDs and LUNs on this bus are 3-bit values, so the highest
valid one is 7. scsi-bus.c treats max_target and max_lun as inclusive
limits (id > max_target is rejected), so 8 wrongly allowed an ID and a
LUN that the chip cannot address. This matches esp.c and esp-pci.c.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/lasi_ncr710.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 4fde2265b5be..27234aadd390 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -137,8 +137,8 @@ static void lasi_ncr710_command_complete(SCSIRequest *req, size_t resid)
 
 static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
     .tcq = true,
-    .max_target = 8,
-    .max_lun = 8,  /* full LUN support */
+    .max_target = 7,
+    .max_lun = 7,
 
     .transfer_data = lasi_ncr710_transfer_data,
     .complete = lasi_ncr710_command_complete,
-- 
2.55.0


