Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB200606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z7/Kiw35;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HfqKvLH1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUIs-0004W5-2O; Thu, 12 Nov 2026 07:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUIp-0004Uw-Vb
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:53:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUIo-0000xB-Av
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:53:19 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC7ixq7126150
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Zau7GHircVSCPQ+4KmecXSucJj622hCmEeS
 EjRFpPpo=; b=Z7/Kiw35k17Mysioo5Urv+suWDumi9vf7Yvzmv2SXhT+EvTfzKI
 42lf+Hp0Xpr/Foaq4oHW405b1yWuLVOqnP0AT6LeQ1112LCCFQ2YqLbW1e1POwyd
 HipfqxHuatIvY6MGumofFeVg0oRFa6I6prvRpq4lD+FXTZu9p+8lk+uuYgaGcjNx
 FtrGlQVBLt3cNr0FxT+FaT7xTYzjIu+L6uTqlFBXXlD6GOQXjTQhOcEnCABLzqBN
 OMpPbVS73B8CKV3l5JZdskkBo/FgkHLm/OLLEj/Jh13Z8wRswY5OjfLeubxsQyBo
 BmEP+ySTbhxbh8E8t/QqqO0uTKrGBvmStjQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a092kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:53:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so1013525985a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794487996; x=1795092796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zau7GHircVSCPQ+4KmecXSucJj622hCmEeSEjRFpPpo=;
 b=HfqKvLH1PKwsnRHEjqG5MPpvn7aTmfbOxh87Hk4gHKI+xc2C/gQPPUAvPYWdXipWrc
 vVQ3yD+cZIfYlYvCcBEFNV9D27aSfXnxDqrHz/bs0mAddNqf0G4BPpxicYSW/2sBL7CI
 9/Fq+85cU3CJ//a42EEREuw9b0tHfgFCEJZOnuQGNADgnFF/n+d7DhGmJBY3VW7Hb0ik
 1DVN9LIHgq/1gvyZagFEj2WYYQPl1lzHX0MqKfwXEOSqESHzQ+uJuepQEKdzJeSfD5Gj
 KiPFPJI9clPL9wLhVgUNTurtPX/AfhAEUnDIfLtTmCNyLiDuzi11LNgRk1THhMB/BbOC
 JvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794487996; x=1795092796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zau7GHircVSCPQ+4KmecXSucJj622hCmEeSEjRFpPpo=;
 b=IjqJttjGyfpTqe5azv+aOOkeNyb/6E3pzsGyGvNHlyiJI0gcCEDiMWdLtgao24Rr2A
 0m/Jam/ZVoC9+Ehw2UQScVCvMoqJay8ApWkZUNFxkEvK2qSbWcTBSnM0hX0XpzkH6mWY
 7WRTJnfwA3uZvLQVtJ9m6pWDRPFM0gfv4v5cyt6QzF4YYqA7M4jk91s9zRVxJwfcra25
 kk2HhstZuM58PUOWgJgJF+h16HVuuG+M2GWfwfNsfN/dhTotEFrCwfpvh7vOuECgBu6M
 VhShrVVZjRiKhvowjn1Lz5pVpNN/2OM/3Jgui84kvoK50lVLGY+6DcHJ2rqNpVwIwDGe
 vqug==
X-Gm-Message-State: APuU4Z/KCFmkVw/Y72f/kQmB0VkP0Tod1ZiQXdyhrhJkXpjs54iEDkcb
 pNqhEVoghB5wnBy7OeihxMavP3HiY0bZ4PKgWabFt5wocWjDfm/6llR6EbG50ysU3TKT8Nh1ovV
 MZF4Y/6X23/4YvFmEDvxygqz07iWFVM9JqDcxQjgMbd3miNQDe18gy0RLAjViQoOPTg==
X-Gm-Gg: AYBFou2a17c/xZgJOd3rpIRVBYKWPU5s/rJQFfxj+oXM/ayftq2POf7lAmZKHetuan+
 i82elsBANPzBYFPXLIgjvxioi2yBQ/WDFQTjlo7bbGasf+LKpPN7HG44SBfOnZoAWjZAzTs0LI8
 63mz3WFMBJoQp+U38KzTDjIBt2qJZgc2522u+jepN9m2ZkncqzBtXoCRLKQ3MHYPRIilLOU+HbB
 ZSMR/I0qdBf1nke0UHiCfrhY0QG8TZBclCSLdSdzEGX5ncDas8hXpWHQhNllU5QY0ex2Xbs3rQB
 5bxaMqR+Y30L4XjULrqy2xp5zfGCkZimBOi5uXllmy9V/wsDD/0BGc9doQBvbydWqoa7JiGmLP4
 P/8ZzaH+H4kLyZr8PgixJ2R+6qwXPlVg7AFyfqyL7iMK96X4v24HKbS7/Vy8znYj/vJ4DegAV6J
 JhbOwGsvqMml4OaKkfgB37feOTZdENM2lBTNCxOhBEBhSH
X-Received: by 2002:a05:620a:17a3:b0:945:fe1c:82bf with SMTP id
 af79cd13be357-947b0083af7mr904163785a.61.1794487995753; 
 Thu, 12 Nov 2026 04:53:15 -0800 (PST)
X-Received: by 2002:a05:620a:17a3:b0:945:fe1c:82bf with SMTP id
 af79cd13be357-947b0083af7mr904161385a.61.1794487995326; 
 Thu, 12 Nov 2026 04:53:15 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08de826asm92994755e9.0.2026.11.12.04.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:53:13 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] target/riscv: avoid amocas.* x0 clobbering [GL3526]
Date: Thu, 12 Nov 2026 09:53:06 -0300
Message-ID: <20261112125307.485690-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S-lnKH2ObcmoNPtr5J2ZWZ1ja6ghDkPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MSBTYWx0ZWRfXzsP0xQUvIAOD
 jWsZiYfyOlr9a7LX3vSUJ2mqeQjJ3j1GQNOTHeDZ8PUXQD6SJ1M5wDNFQ99LAYhA0T9cJZX9tWj
 tg4azR4P92SlNdXi6TqImz8Eq28/tH+aeuBhLcf7UC55YOoddGYPfDixTLfdo/IqjddY9CY5Oyq
 d4Bq4mymjSyWQ7hrcAutuAEJPT+WJYJ/ypXGl03ICRVX0DtZA0AheEB/tWCWfVQ4adN0v92yxBE
 xJ98hivvBi3QORL4OlXN99MPY+ebwb5dZIa3TVwzkBhJrVKgNgifYnvOK1UkqTxA7cSVjU9huCA
 tDzlUYYe4MGqD/23m+VonLeo4icUeV5wgzhVJdN+BE2cqSQS2SpI2/H4I9puwQBessD/EbEIdI8
 V12SUyGJBzr791x0AGcYXyrYP0avZKpftc3O0Yoy7rSPRZzpPhYmqp/GYv+10HOCwM6yxcpWutD
 GsNuJlwb5wDpQz+104A==
X-Proofpoint-ORIG-GUID: S-lnKH2ObcmoNPtr5J2ZWZ1ja6ghDkPi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MSBTYWx0ZWRfX25N3JRCfNlqs
 QIaM+2u65rPyJBkQPDneK4lc4itl+fwTIf4d5ppw76kGf5l3nlIyi4ii+PrIXmTi3GCN5MUDN7k
 RyOSX6PfVlCE6OcS01C0b1zUDZkJplM=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5b6bc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5YhHKsphd0Gvzk42CI0A:9 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120051
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

In this version we removed the 'exe_name' from the meson.build entry.

No other changes made.

Changes in v2:
- remove 'exe_name' from test-amocas-x0.S entry
- v1 link: https://lore.kernel.org/qemu-devel/20261111205043.327652-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (1):
  target/riscv: avoid amocas.* x0 clobbering [GL3526]

 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  | 15 ++++--
 target/riscv/tcg/translate.c                  |  5 +-
 tests/tcg/riscv64/system/meson.build          |  7 +++
 tests/tcg/riscv64/test-amocas-x0.S            | 49 +++++++++++++++++++
 4 files changed, 69 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-amocas-x0.S

-- 
2.43.0


