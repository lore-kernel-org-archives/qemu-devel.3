Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3F606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l3H9ozPW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kq14SEBS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTjT-0000Wc-II; Thu, 12 Nov 2026 07:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTit-0007zJ-WF
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTin-0002Tk-EW
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:11 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9DxtS480088
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=H+sCbLt/EDRJTePa8WOgfEbGWf0x4hGuAxD
 bJwe5qKk=; b=l3H9ozPWDY6s13U/qpLAMSGEppijrXBalCuXCJCRQxAvkfPkKL6
 GVSC1jf7Ca1ScHOgT9MO02BehJHXr5gyHDWsnkgyDfWhEmCCno98Q0qIpF9VOBZ7
 376PTvjo4GTNkgnHoB+j/H8vGzXUasare/scmjnZQRdnTxtEiFko+i3Mh4aok/MQ
 1HFU+Hho9fWEzywz0bqBV3AS/XhRpZeukstUQ4IAR3JiTzR0xgWZ9ebtyMsX/qTD
 6S59YG2+wMWdtq49EjVJ/asjUMT2/1FQ6vHvg7r9bu2Srh32pEpVxKRnJ2+JPS6L
 jR+JX/dCLsn4Ef58EUzj++korq+84iDO9kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4rk82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-555d08e97c5so73450191cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794485760; x=1795090560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H+sCbLt/EDRJTePa8WOgfEbGWf0x4hGuAxDbJwe5qKk=;
 b=kq14SEBSMDCv5V1xg4mYjBZwij0Ah+k99wE9itPWRvPkTvqkI+4gGa778UI90FTS9H
 JrQF/yLvmcRv9ZIZ4rQvOTUZsSuG/ICqvlshmfx3AdpDBGcSyPn2fC2K9aR+igA2lrlp
 XmJZ4KhIYy16Mg8kF3k/V0dNOhNotSqiBFJNWKJ7QCRgKW8b0Eui4C9Kqb83UgdXbw8V
 vWGKw8ouOTV4Eia+aQBZk62pC30VA6mwq1nJPLd5yhP3fRFUnYt4haH/9QWZjwk4gToC
 1Q8TfT/nEKuSu6X5Tx2G3KBN3N16s/n+ekd5LosagAT0EP5iMN1FWC7wiRZUCS+LS3mC
 hRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485760; x=1795090560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H+sCbLt/EDRJTePa8WOgfEbGWf0x4hGuAxDbJwe5qKk=;
 b=Cu9p3qzTjfDQUoPZROr0r9trDPoK+CMrZSiKbbeQ+/nOZQN/tjJN3qgfIzpBXLxtOj
 x62gqrQEyVYIfRM2P0yYRbDhOfGuQeBcuUEmO1YAmoZa8lDB55P6hHBacwFCEQCbDa1A
 MZJSaAmhD0iyTxhC3WpIFlS5Ef1MCfMGO1T2SeQtQYUcMypnXSuBuaMIzRbx82M5AQu2
 0RBdjwZPcMwC3/RRYZ6EPfvAObA3JsEhIdKAP7t+IiaL2Nk4SML+U4Q8a02NTYlXrlev
 hxfus4PVf6ULfYg1q3NEd+THl+rHhKTDJGdE1/Hq9n7aOKPzZAn9qpPTIxGx1AmH9Cjh
 akvg==
X-Gm-Message-State: APuU4Z8x2+mIAfgo9hH23z8UaeYWifMv6zBsjUmZljOGF438aCcGA9Bq
 V0YEQSmOaA86vP9Zo1xhjYqXFdoZKomsDGG5KBVGpt++9szbYAyzrfR/EN6FvxuEoG+ylO2k+Wx
 OE6lL2RPeuzSXK5hOLdZbqswCzr7BmVeb81OcdlfYYCKEfo3V4vRDuS7cFHUXhetqaQ==
X-Gm-Gg: AYBFou0mDvufjUc1ctSZcWQbOionT2jgljwYF5v1KgqSKL5HEHupKLzpiG5sUc5LRJZ
 YRjcThNbhkZEppGwP9IUUc5knxHr867OgnVb23QRmIyO2jYLuO+YGL1++mJcRw98UpRh7TJ64dl
 Ft4vyz2ZsCtkqyvIuifl5n/QZhv4/71vKHRuQmJ/dCBFtXCyFVqosOY8K0KrMpy0IqTjv0+GBRl
 6qVN/I9GUUP6AkonQUYE9hLmIJXNgd33pXIwPGkaNDrTrKKYZcQ0gP+shno0TlPjN+Dppul1PSz
 chcPJFDuX+i01iF7Y1FQMr9xepK8rI8Xgj1p6FAwk1RA2zVw3uKdSxFjJqgRfKfD/XtAx/pWShm
 he1MgJ/p1wmDf4iG9O9dZMNH+UM3w71/2MW9MK/Hs+Kl64uvIplxRClZsblYSwiV/tNdmJXwlHD
 O/zvqumW8lruKcaKxzqoLAG2g1pNvRLv/ocdhQRMyH/5FZ
X-Received: by 2002:a05:622a:5b8b:b0:536:11c5:1dc1 with SMTP id
 d75a77b69052e-556c1b5fbc5mr80750531cf.76.1794485759601; 
 Thu, 12 Nov 2026 04:15:59 -0800 (PST)
X-Received: by 2002:a05:622a:5b8b:b0:536:11c5:1dc1 with SMTP id
 d75a77b69052e-556c1b5fbc5mr80749861cf.76.1794485758910; 
 Thu, 12 Nov 2026 04:15:58 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af6096asm73538651cf.5.2026.11.12.04.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:15:57 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/5] hw/riscv: riscv-server-ref refinements
Date: Thu, 12 Nov 2026 09:15:48 -0300
Message-ID: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HpHmFPU5fvqBUuRcqPULf2wFVc1KVId-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX0CsBVfndugOG
 PHRCqzfJieM5gtWNpyhlowuGVT0JYZL71dqLw7G7f2rG3kAKJgxeHFAsKHoD1cPtO/WkNH95gTO
 kWtQ92gw90B/gd0qpA3qDbvqL1rnSrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX7VNwK323go1a
 5NwmGsRc1DEmEyVFfH++xrtwLRTDSUSS+P+4oR0hdAu7wSHKqYRFiD3kjH/N85dW1q/F+n4+wFe
 nkRKSFHe8Ycw4/IjEwnKzH0qsU5yQkkqNR0d59rwsJxs7GUGLLPHG4mmmmloMXEpFntwa9hiVrH
 ddPUKHrR25vq2BCQrlpPOLvHwaSZLr0HKls4ZjOeX03xHyXR9fFRXrfVzYTBoWYxP7eMO0361NF
 R5GxRgbDzE+RwTFXpZEJx+u4bnbDRWdPwXAbIOfyQj3FCV+eMbLYxMGEDVD1fITLhsXi/IuS5Y+
 jViWvG7LjmD9/XJsLLS3ybNmyDHMi934gl8wwMkCscHchzudtapBguuO7a+keT6asVzPmOHhC5o
 dKfY5sh39dSbj4eoJ8NdIFXQ6ledjTUWDd9NW0CUMSIAdJCl62eONnMSlalXB1wjoxJZmWt/SRz
 8hTWyeMC0d3BB2wAKLg==
X-Proofpoint-ORIG-GUID: HpHmFPU5fvqBUuRcqPULf2wFVc1KVId-
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5ae00 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=W-WtfK5NM88bNPkTKY0A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048
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

In this version we simplified the way we're setting hpm-counters for
'virt' and 'riscv-server-ref' by simply adding a new param in
riscv_create_iommu_sys().  We'll revisit this decision in case there's a
need for boards to change more IOMMU properties during device creation.

No other changes made. 

Changes in v2:
- patch 1:
  - add a new param in riscv_create_iommu_sys() to set hpm-counters
- v1 link: https://lore.kernel.org/qemu-devel/20261023160913.24992-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (5):
  hw/riscv: allow machines to set 'hpm-counters' for riscv-iommu-sys
  hw/riscv: make UART FDT helper consider baud rate
  hw/riscv/server_platform_ref: fix UART baud rate
  hw/riscv/virt.c: fix base baud in serial_mm_init()
  MAINTAINERS: add contact for the RISC-V server-ref machine

 MAINTAINERS                                 |  8 ++++++++
 hw/riscv/fdt-common.c                       | 19 +++++++++++++++++--
 hw/riscv/riscv-iommu-sys.c                  |  4 ++++
 hw/riscv/riscv-iommu.h                      |  1 +
 hw/riscv/server_platform_ref.c              |  9 +++++++--
 hw/riscv/virt.c                             | 17 ++++++++++-------
 include/hw/riscv/fdt-common.h               |  1 +
 include/hw/riscv/virt.h                     |  2 ++
 tests/functional/riscv64/test_server_ref.py |  3 +++
 9 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.43.0


