Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EB606A33F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H1j1zW9+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jGovdm5f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWA4M-0005bo-Hp; Wed, 25 Nov 2026 05:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWA4K-0005aR-Bl
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:17:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWA4I-0003Az-MG
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:17:40 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mTdb4034201
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7s3e05jPnPpSupK/Fl+yjTI6DjiuviOW5DE
 A007d/Nc=; b=H1j1zW9+D5sEK7yvd7XS9B1DOKxXRNFvYoBCr6lrQiAuIDCvcoG
 3C63lwzVwP4hxC105KCb26pMSxw+x2DSeo440wGfhK3nxcwYSpRrXd3S/0p70/X9
 asl6Js8RsYJGeqllaeO4JHiGWEepN/65eBi5Fxcwfbx8duSg2OOFf5efBBKZ4OWg
 TtjDkK3zuomz9LFC2psQMc0KTp9erBaDaEHaA9UV/czkTYPAAe3bhq47ip+yI3vV
 r9onap+WqVZLEcgVcE/ZN6B1jPFLRXCgEg2hdWRAdrTa0jx2hkiKoUSiNXlvewCM
 NA/mFo94xi+jwezQW37teYBrRRacsjSRK7g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbj87g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:17:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495af07676so881210585a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795601855; x=1796206655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7s3e05jPnPpSupK/Fl+yjTI6DjiuviOW5DEA007d/Nc=;
 b=jGovdm5fZZfEaYIpYyrCYlKjYoPlEIUN8ZwF5/oNmoTcDDMJJqx27lQHkVAsj3tmL1
 VGtB+VFDwpdvUt6H7OqSP21IYqf/IyNhaT4FScAXt3zrp/FJpixmXrRzi3FvXzB3SsZJ
 P24kVaifY/hqqDMtXrpPwYW19A0DM9v74sedpyKdZqAUUp14PZuYolDnZ0Y6E4wKJpXB
 Efko1XiKiPuXKPvUeHuU9o2SPfD+uVRwZVrdYZLLfQQA+HI3OZ8R8vvwPwBG03AUZj9r
 HedwJNdwDJ4VaPBhym0QOTWUY8nmHA//o63+gD0a3obrlQPQn2IHbQ9wDaHmR24+K3Zp
 bU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795601855; x=1796206655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7s3e05jPnPpSupK/Fl+yjTI6DjiuviOW5DEA007d/Nc=;
 b=VnH3Dwzp6ZgKwUWoLRZiQEPBDpxiGv1sNCxjUatM8ze/rq0uQngfOO3zXH1zbU9VRo
 OIxltFhhILTFw1g1AVMN1Uz0S224014SYP8Ednvuzrw3A+J1BpHD8aZYn9WBnyQE42Qh
 JhpV4uSIZ6rWSF+wCoSsxQMfXhhqP9/J3Bwewh0yuRV82RIM8lt6Al+W3PND1wel6IDk
 OXpV3wtmBu1YzKAYwCfTSpwlg1pd7/7cfURvfcEEoDfyXDAzBfVDkd+vhNvK2PuS8KP/
 9qGUI+HvFO6sEOyxSc6rHc0Y5xqhuAjBxSV4u3w0PCval0IxhPwmXJvqiGY9LKPnJyo8
 cn4g==
X-Gm-Message-State: APuU4Z8Mp/tmGBYxy4EN5vVZFsG8w/52m5p/yRR0nU1zKRPGiN4Wth/N
 Y/4fPeZLY6gXH0yZ2cdCDqRW1glXZ7XtAganbZ4Pd1BqXAkXaOM9uHPlFFOQMU8GHqcbZl+F0t3
 RTFdLWyzyGLXaHITiSmCrvl879jGDTJRE/+SBwoCFZnGoCshVXVq18l4pQG4ClFAl7Q==
X-Gm-Gg: AZFdTZeRVIXWR3FT2y+349kiXmZjR66QlFWuczu8VfeXlODP1Meu7xD5uD+0Omfev01
 i6z12Ueh1R2KTLkmJNZSdH0hpQyrDAUXO/5pTn4RhOdIWz8fePqqYIaHz5J8wcnqe130snWLOgq
 WqinZrLjBo2E9zvm1lbRsQMDsBAi0Z2/Uj3bwPPnfTYaV6oC/4P36sRlt3gdjEmf5eOeypqF+eC
 WyOrG6dB2RXqUy40Pxsfx1VrGIRo6g3XUcybFMLw4OG1E9rpGRHeeUye+dgURVIT25Hh2/Ymkyg
 V/bdtglXZNqIQNlZbyvvinye+R+xZJILyRq5tW9PtVH5radz1sZnjbgkP2lCOP62msTzeQhdp+H
 DDB5ly3YNFCRjTdhS2gvNhrw5UOwM2lfDX3mH/lBfoZh1sFpNpFfmND0Olpb5nGoHAaXpitueCb
 Y1OOdsa4ZSow==
X-Received: by 2002:a05:620a:3722:b0:949:472f:226e with SMTP id
 af79cd13be357-949bab15455mr3373524085a.71.1795601855411; 
 Wed, 25 Nov 2026 02:17:35 -0800 (PST)
X-Received: by 2002:a05:620a:3722:b0:949:472f:226e with SMTP id
 af79cd13be357-949bab15455mr3373520785a.71.1795601854905; 
 Wed, 25 Nov 2026 02:17:34 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb34ad6dsm1280811085a.12.2026.11.25.02.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:17:34 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 0/1] target/riscv: avoid amocas.* x0 clobbering
Date: Wed, 25 Nov 2026 07:17:29 -0300
Message-ID: <20261125101730.228914-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX4A0zpmiMHtHM
 tKnea8SHh8kkWAFu1hiPlbL2vHsnhuB3LcuZQjlAHIMvy47D19vOJBa8QXPttavRRhCowDB0OvR
 SyhWlJdOxy3CvcpmouSO2J7MC+dph5A=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b06b5c0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5YhHKsphd0Gvzk42CI0A:9 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXyT0floJDHXzk
 NUTQoOMe5dKZeyxuBgHUxLdqfgJoFKnAWn5RaxuluRaTpvtbKb8Bpz4L5b4j7HB4o+5409yX0+1
 jeSg6PZTCQPuldY4Hz7z9sIzSLqyx90oCN4kO7WLw5Me7gMku9vLH44T7ajILat1HtkwlgN3gXn
 sZgSLxswSHTFlpJE+y9c7zvczajE7KB2OXgZz1lQaaQTBY1A8FUQr9GQH9r95AkZYnvqKuN4jNF
 lYXtf2S6uHM2jxLp7cq0UN2Bi2kim9rt8KovstRxEwCH3y8dzW3KmNV0jTGA0zF0Whe+XgRC1S+
 gEu63bIHL/pLjwIuUO77XDQ71vAMxDOo8RxjgUPmDNBCoB0HsnnmUYVK/FbuFRiBW077yqXfUUD
 gZOEsc4PdSLfcuw0jNzPzlgfWB99IPz3e7Ayh5K/7gcFqyuejoV5HM/rejsB7y1Dv1iJUHji8I/
 KxMtH6mAzipWSm71p/A==
X-Proofpoint-ORIG-GUID: UIcVTrXmKQisGYal088s1J-ysOBwnaJ4
X-Proofpoint-GUID: UIcVTrXmKQisGYal088s1J-ysOBwnaJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

This is the same as v2 but rebased with alistair/riscv-to-apply.next.
No other changes made.


Changes in v3:
- rebased with alistair/riscv-to-apply.next
- v2 link: https://lore.kernel.org/qemu-devel/20261112125307.485690-1-daniel.barboza@oss.qualcomm.com/ 


Daniel Henrique Barboza (1):
  target/riscv: avoid amocas.* x0 clobbering

 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  | 15 ++++--
 target/riscv/tcg/translate.c                  |  5 +-
 tests/tcg/riscv64/system/meson.build          |  7 +++
 tests/tcg/riscv64/test-amocas-x0.S            | 49 +++++++++++++++++++
 4 files changed, 69 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-amocas-x0.S

-- 
2.43.0


