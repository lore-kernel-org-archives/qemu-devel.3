Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A708CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdn-0007U3-H7; Tue, 29 Sep 2026 22:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdm-0007Tf-Ak
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdk-00035G-Pc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQ3vo2411050
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sox/13Ikc5I
 WetFCTL/4WH7Yp5hGg4PkH8hsYfKwohE=; b=ZtlfZjPXB0MKj1Z7BKKs7oiX639
 y+ooQ7q7Q59MoNAB7yQ+HeTornKixSc4NCNZ6AvdwxHTYpzBETTW7Tu8uHsy+9Jk
 +4RIog+nbyL3wcwh23TEqL4mMdPfXq8AEbjlLNQTKx0HQ3lara18o6xz2kiR5EIz
 4pURZgUuevqbdB1CnmN3QH0iqWtFdJuh+3Uj+V/ufJXEzWS+grFUmf0ZBiWYBvQR
 e4aSP2MBHJWtgnZ91Yb/IPk3IC2r12t1qkC7O8odIMCkeY8YjxjGEGRa1VIjLB72
 gLIp+BYaG0lnlD/TlB5IF1/oW+BYzaTpHobMMMWNJO+u6goL+F0oOVXhJ3Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97sjyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so9562778eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733706; x=1791338506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sox/13Ikc5IWetFCTL/4WH7Yp5hGg4PkH8hsYfKwohE=;
 b=Hg1oMnLg2tKr33wdhXRA8U7IKEwf7gG0jwUIokd63ohaXg9nRI4Vs7JuT2xRQq0fe6
 mLOlxMj25viiLgqvd0cb2A3w5vIuijjOvpiqTqNk1/mcPmqNSVoxQmZZ+UVT7BzkDCT+
 5IRQsTbLwsbgFY25VgyhSXJ//ZLTqoNHYqoG+DmsZ7oUsl1F+x21JaM3qj48WWJj2b2O
 9aF/2TtQmHOTOpppigr6GThP+DGnbJhYUMZCWnJ4emsJW7tZaViESN1IvIxPkHIr7XxZ
 SZVwl71VRrsCBz48sWBJ8uWRjq6kM0wV8qu2hwbU+LrFD9CR0YzHRMWDFgEFJevUxSXG
 7bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733706; x=1791338506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sox/13Ikc5IWetFCTL/4WH7Yp5hGg4PkH8hsYfKwohE=;
 b=FLYgxnWSqNr19Bc07QjJNe6quOf7Q4t2qOF40J3p6kTDh4A6my+HPGgPuJzxj9WJbe
 LQNEII94JL7H/pPAanF9aTpUvJaSqtPPAKrJVDMukrfqToRSVh1sNXKfpAsRAbhXmZ4m
 CIxdaZNlSjMmsRUhx7z0EbK500xwy80tH9pxZk8OWE5f9uOLMdTZK6WuRIXpo2Bv9vTT
 J++qs7wpdFeqN8v8OfyXBNYLiAdONySbA1vhqGeUiqXbdpSdFc5diQvIVa89kMaTMPl4
 4tLFHKZaNj3iUkDZAy7DrVmjD9dgECv1W1gSFV6Fli3rJ5Jj0wojoE7UhEmDLJbOWxku
 /XsQ==
X-Gm-Message-State: AFq9FYIimA/x9ww9L/amxBNfRqMqak3cDbZoO3GttKKMwrSNbZKtgeNJ
 jp5wcP0q46znKhbd8HFWiR9To9X00nYIw5ZY+9owEu32iWkZMtz/I9G7d6Obudkcjtte1ovdbZ/
 PdRG2K0fBe3X1DX6DSA0JS+DNqi17tm4BI7ZWnklFdA3i7S8TyzHOLPXrqQ2GL6yoCA==
X-Gm-Gg: AYBFou1OGKgo8gTvpsUAbLVRzVyzfBrujy/Dq8fT68xaHYqswJOv4p2vPr7DyEIgZE5
 DCwTdesC8+v9ZgbZ51BQQV3QSjdsXA4XJEmFhD3HoRCkkuu6eK4+a4a5utP/rKF1cIQBs0w2DID
 PeEKj1U5RtwqaMhZCuXI/ERsGFrGIg77xMkF9968XlCm89UhNDb87Ha3SLQCKh2EKMr2NTqU70m
 bzn7fkZ+asJ+Noy0TcFpFK73HRSwhBThCSd5FrtBtF2siLTUl3ADURg4nduJm1OeDB1pzZvMWKT
 DSbma8waaRI9aNDpH4qwLXdzmmSiOOsUU9lXbY32BL57fsEKG8Iv+SgJ4I4eZra2V2v0LsYhBoi
 FW4v4IOymy/5CbZwH4tYUSR9N77hV6h8k6dpd98y8ZXH5d8q5Y2P6ndr7K7zA
X-Received: by 2002:a05:7300:c01c:20b0:33c:e72:5b3b with SMTP id
 5a478bee46e88-34cdc4ca439mr119170eec.25.1790733706417; 
 Tue, 29 Sep 2026 19:01:46 -0700 (PDT)
X-Received: by 2002:a05:7300:c01c:20b0:33c:e72:5b3b with SMTP id
 5a478bee46e88-34cdc4ca439mr119137eec.25.1790733705850; 
 Tue, 29 Sep 2026 19:01:45 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 08/21] hw/pci-bridge: use stub_ss for
 pci_expander_bridge_stubs.c
Date: Wed, 30 Sep 2026 02:00:55 +0000
Message-ID: <20260930020108.217892-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Uqwm8gWfO8zR_aj78HXulqLGcVQgIADv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXxNaVMXVS9nH0
 uGTkTlZrU91PAci8rkRMYw6i+I+Jfr0FAiyhSS0yGT2n3KM9FF8ucDjoKJmw5p/PfyhCkg3DNPD
 sQte9K2rTN+lmnea/eqzgCkpeuUt3NYGDF8tPENAfI1n5H4blN8R+mmY/ltFnsAYn+DItlC+F/X
 TQrIUv95EwPbp9xAxA3DdWc15pnEkTq4wi8mt95Skz3GM8BA3Y21k4yHsGvCAmDy8ozFJBInEPq
 2FHXFDwM5infieEb5MxKyrXxkqZvm+kp5JIapvzaFexHbq8ylwuCQikh4UFh77whSNch9dcOk3T
 M4hgEmJBZCd0+4pdMjG3HF9uR1eTzqZS/XwD+6IA2YaOLduGcszxG9RzcbslAwfaN3SLqvqEJeP
 SEuQYd7hhpouBDLuJpC8rJJjf+HKsCzKmTU291EfMFlM/KO2Z/nawvEv6MmJOdOXlNVadGs35ic
 LJR9sh+tbm81EoA0iiw==
X-Proofpoint-ORIG-GUID: Uqwm8gWfO8zR_aj78HXulqLGcVQgIADv
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc6d8b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=pe9or3G1WPHJhyOFo9gA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX2exAUTzmvQfA
 Ya7gF+sn03A7Js82Sc33HP842JiTgmn3cD6dT3l36n9QxqmfgQwY/MjkaoBrQ0pCUpqI0My/uGK
 7Qo2Cr1x4E1DDJmEHa/God/OXMoMT70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Solve double definition error.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/pci-bridge/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 2e0eb0d2332..073aeacf7fa 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -4,8 +4,8 @@ pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
-pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
-                               if_false: files('pci_expander_bridge_stubs.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+stub_ss.add(files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
-- 
2.43.0


