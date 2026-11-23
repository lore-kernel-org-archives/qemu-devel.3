Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A840606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U0hVcBcc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MEa9LVxf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZpV-0005hH-LQ; Mon, 23 Nov 2026 14:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVZpT-0005eH-9d
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:35:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVZpR-0006uI-E8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:35:55 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJNKnG3440251
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wQEm2p66UgyiG2rgx/y6wNVsgtEm/4Z2NAA
 BzyDhRZY=; b=U0hVcBcc1RAgBJNHXJSnbgxe0r6GNkNUKPZwFGYFtcizWHS1iFs
 HJDHtTfoHkls95xRF5YRjc3CT/NY46Rv3zI65hj5fR+Pn8CIq9L9UHKM0No8cOeH
 ngdZbZU1S0aVkH7ep9sRskghoqrfWJe9E2xp3aBuSHJZuaIOxZTDlOf0j5ejAap7
 Db+4pnxihRidWCcZvj9q6VqvmcnkwipnCswiiEhlfPyrwXtcuf1J1Nr6Lek+Y+Nf
 IR36r9e2Waok5pKtp0kXA38t6y3+J16C7CCkpjy9vsCKPrVFlOnsu/IR27ayEYhs
 GD9w4Y6sqKBIID5n8tCyVAUPWgiSGuky5+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukr81ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:35:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55bb7f70b06so77137931cf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 11:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795462550; x=1796067350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wQEm2p66UgyiG2rgx/y6wNVsgtEm/4Z2NAABzyDhRZY=;
 b=MEa9LVxfmZJbODvm3HpE7MdMWLYw22t18ntgKjfTArO62eY5W8gPnFh4gYOJz2GgjT
 DkBYc3yGf6BqdCpiUUO3Y6xCE7vYD73QXb6s7l18sT4piGGTzwDY7+4marpUjMZD57TL
 2TL9K9LaTy3pqc3iQlwRsyGIR7R5yRUWXuFstcmyFl/zqyvHAkszHLgOIE5XsvTAALUX
 949Xi712nVGingOG0qUrzNviC+z1utsMhSjfxBGy1ecHd2vLVv8fi4uyBa22Gja4HORz
 x8vBr4WMeASqACpFycBfaf898uxFxiLjIE5k71CNV30xcOcU2LD5rMKY2IHXWyTfj47m
 MwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462550; x=1796067350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wQEm2p66UgyiG2rgx/y6wNVsgtEm/4Z2NAABzyDhRZY=;
 b=lLyhmsJpYD6EJqHHEQRest/Pm+7ICYFGSkRkdJHVaXsL1MrttCfNFukNmfC3fmXeX0
 WsbUKWMBiniPdtye9WyP3GF8KBk7svJ3Q5lTxHmmLNlz3ozAV3CKQndddqRxGDLLoLlK
 ujdjg7+BsWFdTPE5aF+txvJfux1/u6xibVZWdSq1qMD2FmIekSTBwxxdXiqtxubCRqXD
 NNT3rs1ESPsQUsLC0YdS0bnUVE1aWJGFcWZKC6J0qR4E9WrtKjGUcVS1BXcHQkBmwswf
 R0fsD2LMEwno0UVFS5WX06nBsdtNkvUZGwRFUthPEvg2KhPyL6tvUMfr+zqxkjJey/h7
 nPcg==
X-Gm-Message-State: APuU4Z/92Cq/r2BwM8hYfu45qO0O446LHuFiXM8273zGzFqkLj5kYc8K
 9Q8kesJPWCZh+P/anB3Lc7lvfEjz3feN7lCG+Y1dfYNtxInAuwqONVcUoRzD0W4zpSid9qoFVBE
 csRXxhIBJikVWeDtH6R1wIwZ0QxIRc6JzJ1rSu8gE/fu1ml0XSKhdF2cnQPn5hrxBeQ==
X-Gm-Gg: AZFdTZdS3DQsVbipY01yY9bX8DXeWb/YTKUd4bQ4RNgmJu66qOG62ILD7ONM0FujTiC
 5U/nATgwPvAthf20l5nQXvJzEFvJZzPTBxGt/vhJ/TeeWH7kxUjpdrjtDXk7znRGDiNlrKIvIAa
 S8lD5S54rtcdhjBAwCjXC1TeDrmCicSzOwPLhA39w/JsNe76DHMKl/fQihnSvtKJKEgP8UOqdhX
 wHp9eKQ8oRjBcW7WT3+wZBnZZwKTq3syt4jHO867BU62xHzuWT9FdbCh24oUoxNG9N+A3FZITjo
 +bhBPUlh8cGMa5lwwIm8zP4xJVSY4GgUkgshaYHeHTwVmMQAREco7dTY0ZnUdSsYSb0vX07no7b
 cTvoyXUPWgJ9Dyh6KpuESXC7opZWTolMvlwZWFjvCj9TRzLw/EGdLHlYeXfkLP5aYFxSchoSFIv
 5eREs9c3fIHw==
X-Received: by 2002:a05:622a:228d:b0:535:1a6:6e8b with SMTP id
 d75a77b69052e-55d76a1f717mr208316871cf.22.1795462550134; 
 Mon, 23 Nov 2026 11:35:50 -0800 (PST)
X-Received: by 2002:a05:622a:228d:b0:535:1a6:6e8b with SMTP id
 d75a77b69052e-55d76a1f717mr208316371cf.22.1795462549676; 
 Mon, 23 Nov 2026 11:35:49 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55da2408ba0sm24439651cf.20.2026.11.23.11.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:35:49 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] target/riscv: do not write RVG in misa CSR [GL4811]
Date: Mon, 23 Nov 2026 16:35:43 -0300
Message-ID: <20261123193545.15632-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX6K5/tDDLtGA1
 wnrCYco1SQUM0ZUg90V68xy4mdEU4vs1lQy0VsIFrPdT9+1rDV6kXJXJlY0mOspuuQKM3iaHGwx
 vPrcgG9kXiLVgUj97EZ+DOn846jSWwU=
X-Proofpoint-ORIG-GUID: E9JlJeENtKrTAO60OlSFgGnouDlsOL9_
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b049597 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dADub0cJKTBBEdyMd0IA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX0qkPRSh9RduS
 6KUnYtXoo8IB9Lx4Hvt9joue0foBzo9Mg0Y8hOx9iYzSVCD8amqLNojo5HMJm4vKy/u1P27jLl2
 YpDAntWiRf+puOZpy242rLj76rhMlPrEPDNJf2B31qrDGVCYkFbJD19S/pX9HGg0c2fRoauK92Q
 3bGjyVxoppYumt2h+TXdwGRZWxALYtCC1OuHEeIA1PIQXhDZpeH7TKk6viHuEGH0Zr0D14zBp3S
 1dPRWkyIRoqukQfAFGBOKoEB6sQHiBSbhae72ZzAFmravZUBt+YjN6tqTzk/WxWN+ODKthTf1tz
 2mRUFvByZ1jzWVIGjQyZIXgJkp7+HZ658LLZapZLWfjtKNI7Hf/OTTf/qZMzDnnaEL7iDuxeKnn
 OgBXdjRt/I0+N9ThmdgTZ07v9nyJNdWSDaWxfljvTjvSeRQIai0cXO5KaxMRGZdxQeBGkO9cMyY
 OpORNgIknEDOneQqXNg==
X-Proofpoint-GUID: E9JlJeENtKrTAO60OlSFgGnouDlsOL9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

In this version we removed the change in the RVG description, as
suggested by Alistair.  Sashiko also wanted a "Fixes" trailer in the
commit msg so I added one.

No other changes made. 

Changes in v2:
- do not change RVG description;
- add a "Fixes" tag.
- v1 link: https://lore.kernel.org/qemu-devel/20261116215953.871862-1-daniel.barboza@oss.qualcomm.com/ 

Daniel Henrique Barboza (1):
  target/riscv: do not write RVG in misa CSR [GL4811]

 target/riscv/tcg/csr.c               | 17 ++++++++++
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-misa-G.S      | 51 ++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-misa-G.S

-- 
2.43.0


