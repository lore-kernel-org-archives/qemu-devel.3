Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD51606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VLWZh8c7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qkp01+k5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRow-0004rz-IV; Thu, 29 Oct 2026 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRon-0004qv-LQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRol-0002xb-Sp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeQD23215099
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=woTLSHlqACjlbRj+pogOm6
 ecuRwle43yZLJQpFoGaho=; b=VLWZh8c71TTVY09N3LnyvuiOXiVp9XXDqqbmDa
 KU6Wz5h4NaQdrDZ0iiN5IiZSAhIq5Uac0Md17CGpPuz9WOmoTQEO78mWsZpu6K/t
 QQcnGWY1SmcFbQ7pltYMV9FZPzTPndmCwzt1KLhLJ92zr/z2U6EPpGgHAnr+ptpP
 1zyQizn1TssX6bt8D/Vi3kRY52K7UdHABtJQjhNJlCTWVpU/ZR7QCgyyOlm53gZD
 BFEcu3BLW1VTGp77Bj3R2vKpmB9P1DKjQDK941ZzQsvIFBD5cGoQz6J8oQ/A1fi/
 y0MrbpjU4/rbMuyl0wUvhbzvexjojcsd28RAUnh6GkbRY6pA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sabab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:26 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8ab3dc2a7adso35660977b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286805; x=1793891605; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=woTLSHlqACjlbRj+pogOm6ecuRwle43yZLJQpFoGaho=;
 b=Qkp01+k5qjmzLobEBwQg2YQSGZBIkNha0xXapIQA+iOku33ACrtKCEh0FirniWhPOE
 1DTuytMbIIEX9Ps/vF3DWc7e0J7l45tkZnqJu8LH21WrRhpCwC2sIfY/ZUeJt7d+ZhFt
 AfWZ/I136Ttj7bOjE0bLqynzD/pIfJ2QWG/OrrkSToLisbCdjtpoAqCkO1PHcGi11nIH
 Q1Ula91Wainmv/HRQQ1TWIk4zm+lkf9ou6NEFv2Kb5O0gD2GK6CngJDdnPQ7ee0QTP5g
 e27a1xAM/qX+mAGoMx76a4MLmrmGex7D8uLckID1pM4jOfIyiTbbwYCcOw0FgjuyKe3w
 A++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286805; x=1793891605;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=woTLSHlqACjlbRj+pogOm6ecuRwle43yZLJQpFoGaho=;
 b=mdutQ6VaxavFCZDfsz935fgQYtJL5BTJc2eowbna2UJVzmjBDOA9DsahU0nlt2YSYW
 cngFCZ3RbtY/61smiYFuRCARSca5OdPMa70yCxdIluX4PHDf+tBFkEJ2sjvBelltUvTT
 ra28gVyx0prH1GCChkqtW/oqAdizAmHboxdZMHGiGgTXaPIbF7jS6Hi4EN/Bh0FX5lLy
 bxAUMxkoPBEr6ZN4r4J9tXTX5m26jeWxyBh7JVxZuqIvzIgcPm7jwBnUjuO0oCsUvhnB
 q3sEg3sTFktUlYzAfZphC4cWVXTOvRUPqfHSJ6KgktyZNYoDLDP5gIdULxUMuhu2TSJj
 6Cpw==
X-Gm-Message-State: AFq9FYIBbJZfjaz7F03gbI/aou+e39QhWDs9VF1ikJ30Nt/g3ZpuXNXa
 7NeTE4uaQfrB/9DaxoFa2JN93/6FgGjKpMui680c9erwAeJjP/50fUwh/yl1XZDC3sAjt4K2aHQ
 nWRklvKfLdd9JPiKSToPL/H/oOmZJrI3JqRalZhSNqDF4/8kwk5ZpBcavnFujnd0ai485
X-Gm-Gg: AYBFou2yVK1d0+ptM7euewouloulN1+BxH1DAxV1KjTvH7K6JiaJoJZRRmr51hj6F9i
 BSrEtg4cRcRmEhgaiA9ssCEL4xt4vTWjUoypwg2nlW1xQIldIHPgDpbe3WYyLhhtLhkwa5eYcWU
 enOG1uzdPzBhpk80QVyIY3sR4iqLZ0RRGKiOHpo2k1eF+eLLRuNYq8o1wV48SzKLl8E4di6FuP3
 MMf5iniYhFlfD5RHgYyCRwNamaE/UW+zQC6Fi+sk6CJjMrjDhjQX88ItEAogH0W8qLvriQcky8r
 r5D65Lk9Elgo66N8wiGkiffLE4mfLNKxO9D9U2UBRjuYtIebuB4kYpFD+9TQulTDTgkGSoQlp4J
 KrQ6cAMoIzJFmfhqY8d9t4zpwkt2wC5B4aVgLaEx9NiPlDQD3XGd/Hcsrcuhk5f+cxBglj1ZiEI
 /aYVmArNoV7EUBlS/NGr+GZnGjnKWvcw==
X-Received: by 2002:a05:690c:270b:b0:8b0:a8ce:5794 with SMTP id
 00721157ae682-8b1b5ba661cmr26638807b3.26.1793286805628; 
 Thu, 29 Oct 2026 08:13:25 -0700 (PDT)
X-Received: by 2002:a05:690c:270b:b0:8b0:a8ce:5794 with SMTP id
 00721157ae682-8b1b5ba661cmr26638667b3.26.1793286805048; 
 Thu, 29 Oct 2026 08:13:25 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd39a9sm36310813f8f.46.2026.10.29.08.13.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:13:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v6 0/6] target/mips: Translate MSA vector load/store opcodes
Date: Thu, 29 Oct 2026 16:13:10 +0100
Message-ID: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX40yt5qcd/wFa
 J4vLjOAf8sSfltO3pgGG/bpJFGmqZra3YfA/Kd9tzlrInG83H9GGZ9Yu8eUJZcP2/76n51H5eb4
 mti2y1tFs3LIMIaxqhEOWeECQ3MYpy+Uw2PpXcKEErEWOx84WlIfYKw+D71GBwl2Pq9DKPZD7W6
 xUFz+CNbNkDl46L7j8BW/iGgM9neaBY/ACDqoQb1QjZXLyWfvwo82UzScAUlF0ATTH+AxdvKQUL
 A9T3r1cw4+NgtCVx821+qukqFNuE0KKX/Fu1lrHMoR+QYZ1PXM2iz9qaFqpxzddBVs0M9S0xRC4
 olewDGyW3ZnUtV9Xcz3tE7wd+HzSgYFRVPXhqKh46zN6E3jqWsT3H+iC+GxWBdAsF9KqZfTG4mM
 bx/Vifx25e4e2aeWrnJaF2j9DV6SPl95srNLOWAZx/rUwR9N+wcPBomPBzLnTaKGF47VGWTN9MK
 OgB/FdtoyHkrmmNcJZg==
X-Proofpoint-ORIG-GUID: l4B366oZjfW5c9feOYXdcVmp7HqtgC8A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX/8sXp1d3N11N
 Pz8KZCiQa2Pm8WlQqnG9kU/QVZlWQxaBgshVWCvbT9TD3ibIECDkiyZnY2uKEGP/Y5vteP3zsmY
 0mKVLvWDE7+aCyOzZKDfCJYrMRWQeU4=
X-Proofpoint-GUID: l4B366oZjfW5c9feOYXdcVmp7HqtgC8A
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae36296 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=qeQCzVK2-HvHzGt4w9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290059
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Missing review: 3 and 5

Since v5:
- Rebased
- Swap temporaries during store (rth)
- Bswap d0 and d1 in ST.D (rth)

Since v4:
- No algorithm change
- Split to ease review

Philippe Mathieu-Daudé (6):
  target/mips: Expand TRANS_DF_iv() macro for MSA Load/Store
  target/mips: Convert MSA LD/ST.B (Byte Vector)
  target/mips: Convert MSA LD/ST.H (Halfword Vector)
  target/mips: Convert MSA LD/ST.W (Word Vector)
  target/mips: Convert MSA LD/ST.D (Doubleword Vector)
  accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers

 docs/devel/loads-stores.rst      |  18 +--
 include/accel/tcg/cpu-ldst.h     |  48 --------
 target/mips/tcg/msa_helper.h.inc |   9 --
 target/mips/tcg/msa_helper.c     | 186 -------------------------------
 target/mips/tcg/msa_translate.c  | 106 ++++++++++++++++--
 5 files changed, 103 insertions(+), 264 deletions(-)

-- 
2.55.0


