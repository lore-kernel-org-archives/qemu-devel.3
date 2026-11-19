Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78674606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nlq1FFQz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tlah6DjO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTxRM-0004DQ-8N; Thu, 19 Nov 2026 03:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRI-0004CC-M4
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRG-0001r8-LS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:16 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6v6OY2030628
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hv0gCW5owmh
 PA76Wzy1UA8RIz97Ep0lDMq0mGjAflXA=; b=nlq1FFQzTLlT4uXPrSdLPD2H8Xx
 /HLNBtFmKZiMuY6+ve4/D71R4UNUe+MGjGNFX2iIMkelysqdO6ZNletgapMTAADf
 YlBvJp+g0yH0HYt2r5BwFD4ru5I4X2bP5sJuPdj8yIQhYcGXDXdtTbRUORxw+fNP
 fQCsG8z+3YIK37PsIJqiMUQb34YMtpNWFtDzJHZVwqkepywZs6QnLiBUmUcYmF9P
 wkJful7YpD9P6heqr1JJv+jkpScXi3nvYETVaUSgX0pJICv68mWOLdxDGAMhnB1H
 +ZJXQFbLvkm5yxqUd9JoS8oJSLUqS4Wobtfs2DZ8jEQ33mPGO8SNx2k1QrQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3kueja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-920f9885cb1so27992246d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 00:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076653; x=1795681453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hv0gCW5owmhPA76Wzy1UA8RIz97Ep0lDMq0mGjAflXA=;
 b=Tlah6DjOyGYffLw8TRW2zRm1pDzUs1C/9WNCY6ExpCalHF7ZvJ+jZQO2qexDjnqEp+
 q3+mG4J/XCsvFZGmeKfigyLdNDBoLO/g8znF9HXF9mKwne395siQN2GceuSmDoDFngk5
 9jmFQ2er4HfuuU0tZ4RjXnxYVyNt/LmtL+vPJvPMdmpeWFYEJf5GmdnwZqtSzY1qkWqZ
 +vlfcRPnk/amc7WD4pvynk0oGYsn20/gy9bIGaq3EM4gbP5CluCNvtNbK296ZxIgxAS1
 nX8ldQeUVZP1w9hUmsmXfo4/DO77ic0Qjia/fHoH65boIvMyxooaaxj1/h8F+gOnLAid
 3WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076653; x=1795681453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hv0gCW5owmhPA76Wzy1UA8RIz97Ep0lDMq0mGjAflXA=;
 b=ooBtAoOYQfMr3u3qEGbjSAguwGR303PKWUuJllKAaWo0GBz1tdo2IDEOB9rJxgk68f
 19/OPm+O1IOIBrzS5z4JtEtUtRoxYGjwqV+pDevyvRztf5knlagcOMasa5CZbmaBMAE4
 HNvShqD3kGk+kkXrBWANUyN/bflCim7Zx2vhJDy7QPhVKj2l8C99jpO30dWmy+fB3XEy
 lJZY4wO5jh+2afdDftLrqoDpx118f7xL8PKi3+hP6fSmw+27qr6AbdgPrvxyopvBLzcY
 ZlX03oDnn3+2gA0tmR0p1u2E+CYl7fewjBeHriCSZbrWjUSQEuuZvvRtCg6MLg31JtzY
 hfIQ==
X-Gm-Message-State: APuU4Z/CwLxfJlkDSqTsN5BsCZBPyAD2gWQC/vZ2KbiUsEWpMq1oYCHX
 ZpY4SbCdenwKg9MXoYcGnfkoRT90r/GBrpucTMLr33Zle60kBK3YDfmCoWrk5A2N/jzmSvZhdIh
 Ch+2hCsJT72fyyyEzBTyUC6BKEFb0gR2U/tf9ecHBV5Ku1xVqSWNjK3Ku0F6yGHotyA==
X-Gm-Gg: AZFdTZdFmr0SqnUQu53cck9TUO3es4OqE4avNaWb6h58gRF7lTQ6MF444FbCsbOeJtD
 hHqjYxqXxG4A2LtXfyQNFfD7zz768IqeHAZGTlncCEK9E57hrpVfJgS/LA6n5PFoS7w3qbOUfO6
 J8FfdOhFepm7DPTkR84cuJ2ZUqFPqQcJ8J1SEws7U7MI2HFn+aKWS6Usb1rbwyLzLjqazjEsM5c
 srSyc9PK2Vnj4C4uHnLrCMdFjixdcvaLtysURiOaLtbVPB+qLBgwTKmL0VQ6lwL4u1EMY+GBq6P
 zDVjrY0aEhjpYyrpDrXcwKpE8uEJ1WWEDhA5mZlfUBrjo+Wrv8NSTe0EwxAHwN1EkQt11MBs+Yf
 zydbhuJqgxle0I26SQMh8w8MvdA9weVq1ttHxLqPfWgXwoS8DEk1UNRFUZobUOAlvW8BEIg0sph
 Kp7U+TxTtE
X-Received: by 2002:a05:6214:4016:b0:91e:ef31:77c3 with SMTP id
 6a1803df08f44-92114f18bf8mr79922286d6.31.1795076653005; 
 Thu, 19 Nov 2026 00:24:13 -0800 (PST)
X-Received: by 2002:a05:6214:4016:b0:91e:ef31:77c3 with SMTP id
 6a1803df08f44-92114f18bf8mr79921936d6.31.1795076652442; 
 Thu, 19 Nov 2026 00:24:12 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([179.193.8.137])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9211a6318aesm34524136d6.39.2026.11.19.00.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:11 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 5/5] MAINTAINERS: add contact for the RISC-V server-ref
 machine
Date: Thu, 19 Nov 2026 05:23:55 -0300
Message-ID: <20261119082356.1264726-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX8vkrPjcKm2ML
 4IqIpoGXJRdQHhrKiNmAHiEIFxZHDx5Dpe6hJcJvR+K7cs9N5IY8IYlxtpahBMZb1eLb2+r2Pqh
 z175HkrMDcL40m80LGJQTHB9VBoCQ/p1bYwZB1po9ylhzntHrX739zWKk9wBej4Y2f1ie9wsTa8
 G2pSAVqvh4evYERt9kqxqUt75qPsJK9Td1SscuD2fkXwulnKyjVvp6DSbqLd3EbDxfCTRamMzKc
 RBu87gVCnLYQJuhhiIwnI6HNdFBQozxxmRtG1uJ4hMUAzKN+26mL7KO/ngjV7dKcJVZ0oJ8yVIn
 6zh3Cbhhp5qxlH/jUPjLIONMFL+vhskkOLe6vEAoXdFbyt013nt2lqi7UO8aEj3dSjDQMtJmU5a
 PTPAf3/TcGrQvX8ryykpV7fDmZ/LMebOUoIN+M7dD0k0HpWNuEkM+/HXgOaeDz9HILhmM76qoCF
 j2SNhyy/Oz1E9sexrMw==
X-Authority-Analysis: v=2.4 cv=Wom+otfv c=1 sm=1 tr=0 ts=6afeb22d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=a6tGUzlCxnQfwxx7nGpYxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FRSEYCzRAAAA:8 a=JF9118EUAAAA:8 a=69wJf7TsAAAA:8 a=MOatoMk4zhW8oBTF--8A:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=xVlTc564ipvMDusKsbsT:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX8DtkXazJAi6W
 dZnyb2xwESIQMEsmutRIDRyhlCLOjkUyQP0REERm/JJffT4GJArD/SORLId9kQVElpIMeuMqjHz
 RamzZPeCI96MYynIhXDE9GWsqBTQ460=
X-Proofpoint-ORIG-GUID: f6ApkeFnmAghCawcL-Ab8TeXLLEGlbaj
X-Proofpoint-GUID: f6ApkeFnmAghCawcL-Ab8TeXLLEGlbaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Make it clearer that this is a board that is actively maintained.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15942aaba3..ba026ded6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1914,6 +1914,14 @@ F: include/hw/riscv/cv1800b.h
 F: tests/functional/riscv64/test_milkv_duo.py
 F: tests/qtest/milkv-duo-test.c
 
+RISC-V Server Reference Platform (riscv-server-ref) machines
+M: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: docs/system/riscv/riscv-server-ref.rst
+F: hw/riscv/server_platform_ref.c
+F: tests/functional/riscv64/test_server_ref.py
+
 RX Machines
 -----------
 rx-gdbsim
-- 
2.43.0


