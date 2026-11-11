Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DFF606A992
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T0jCkbb7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jERPfvUp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Hv-0001ws-4k; Wed, 11 Nov 2026 01:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2Hp-0001tb-Tn
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:58:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2Ho-0007u4-3D
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:58:25 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KDTu1409006
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PRXOSpARm0saCp+f+u9zQS
 VUjEZiT8BBK+1N7lxLNdM=; b=T0jCkbb74IvLhhb+eN2qvfHnIPVqWGkrbU45g4
 Mm7RgThEdqrJ4n0CTzEmK1l5p1vrjzbvEP3p95IG3l2J8tB/L9Ddf3dQBBMZYSoU
 EMQtG130kbGwKMMZFHQ42V94Gd0RM2cry0aPhw4BQ9zdMYkI51XLsKW4dUPg3EuO
 UDdJWUs1EtEnRg2VrGRvBMqkOwjzwzxfnPnkxvJ/h0NBKrAQtLoDb5f75foLdYdb
 xBEGjUhAYQkUhHWArACbMfzfCRRcW2vbVIKKJJfJ+wi6+IYOSqQdCWMIJYsPUDKs
 G8m9+8TEtgl+vrcNk85ZqDkdrjKAB5PIDBiMaKIIHgetOoaA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdgncd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:58:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so685148085a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794380301; x=1794985101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PRXOSpARm0saCp+f+u9zQSVUjEZiT8BBK+1N7lxLNdM=;
 b=jERPfvUp2RCHc1odjoDp+WB4K3Vyu7QBf0kXjldwkNACCNebeDTj3S3LIOP2YGTvog
 /6Vl0vUlJ7Mytcp/oD1L2kxEvwxBChOgDMuGpTILHirOe+/N1cbPr4/1jiWjl7x3ZGy3
 B6xC6L7OqU34QuNu4XAH+aNE2g4WNcVUSHtfHMR4QnEnVEg/yCXaStyMJO5xuog7Uwr7
 2KnL2ckfNrmJZ3YsYRE7SCnjSGr5KotCwFxdGKOvF3Y8jmq6BJun2WUvnXIdDHul3/X8
 gtyTEIl6GPJZpqAvkin1RXVzIfa588CTGwbTfJXfmAzQhsype8uoyozP80ukq2VYiI8J
 Uypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794380301; x=1794985101;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PRXOSpARm0saCp+f+u9zQSVUjEZiT8BBK+1N7lxLNdM=;
 b=NG3GzXXGoe8JFbE8dUIpf5XC0PMKJhwByP9cf9tp/JiimlhSwTDQF0PlZ06CKETTbM
 tRuPh4wEkYgTnVW7nOak/Ca51wF0+2FOyrSM/O5fgKndzHxhronM5sPRf3eCkGDX8Crv
 jjilXGd0D/HgUnvh4xNnaO1RNTA1QgSGgub9eLps87b14A0EyF6LR/BfqmmVBCGG/lUH
 qGyFIkH3/hJIVKx/W1mQ9YjAK9mWgJpRv5eCrQ/2vvnS2yO8eCbzPXBXpVemycka3Rn/
 yyJGVEkqBn0azHJ9Pn+KKtRaE2zQhsGVUqfQHXuDfiPC1YnMB/F35dLfKtDXhJbzOStw
 tzjg==
X-Gm-Message-State: APuU4Z8U5HBcd8HkCIfASEAcQVd7B3+EJ5oXIMCsu0NBPlit7CDC2t/2
 9skxginCDgx27JEE9WhwtM0r6Kga97VsWLvvU3qXAsAFYkWjBBgwS3cAQd5iVNEuJ0FVO9INBva
 XsK3Bc3NOX7+2h6i1lX+yeLm7Wu0k1Tu3frrs2xQPkhX2r/tBtasIe95OtktgvSz6vw==
X-Gm-Gg: AYBFou3l+vGenYDEZkoUYtS7UxG/SG8g4Kt5z8fiWYtLY5GCTIws1uvvUY3chPYgOtd
 fLnjfM/4lac+opy/w5HEB09HcGgp0OI9cXVv3jqyAPp7FIQQL49lQ9Ux2QT7gaAZHVMfHvhQKEX
 tiCvceXFDW7MuLG6efs+uVwPqJ/7SpX42kTMWgEL8OL2hRX4KKARpf3YenaF+M0KyInDD4WDE3y
 DK6sn5HIHqE7DhBksmv+BAlEIUTmbhAB8ko5QhTbQai+sy1fyzZZDEw5sLp+f6xo3vNQuHATa3L
 JkEnjY7mdmFMC72eP4ixs9IlXe304jGUPjBkV762YD1w+qeaxh2dwvU7T1C4dibfxaub30DZjI+
 R/Hw/PEyeGryZl6LwAN2iDk1lyXPCXfrrL3bRdN0KJxI6u84wJRQkCUQDD3UtiaJ8xk5oPktzMS
 NOMk34nnoAvxI=
X-Received: by 2002:a05:620a:271b:b0:947:8344:17a7 with SMTP id
 af79cd13be357-947afcd6addmr212859285a.11.1794380300855; 
 Tue, 10 Nov 2026 22:58:20 -0800 (PST)
X-Received: by 2002:a05:620a:271b:b0:947:8344:17a7 with SMTP id
 af79cd13be357-947afcd6addmr212857085a.11.1794380300389; 
 Tue, 10 Nov 2026 22:58:20 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e734698sm424919385a.13.2026.11.10.22.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:58:19 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v5 0/2] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Date: Wed, 11 Nov 2026 03:58:13 -0300
Message-ID: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af4120d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=76F0wDgyi296CdbU-VoA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ZOdhbDEiEZMMl7-aXBOJsrz4CjHGOXpV
X-Proofpoint-GUID: ZOdhbDEiEZMMl7-aXBOJsrz4CjHGOXpV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfXyJge495yz1Tn
 izNcIPevD7Iet7aaXz6bNzCDT9sp+xEsFAOdcCEcSWO09XHcFn8RUQVv/KrMs/oP6xvtPllD1G5
 GmFHDyVu0x9ohpcvME+VwIBB715jJH0QvStw8gzVL546VxjtZB7V21a/uG0l5POiUZNcH029N0K
 4XyrbTsgMO6OV4ehYmHo6G7UNZicAjf9mWYONF/oiM7DQk2eGP/a3zyRuiwQF26y+zJ10m1AWux
 CPt7lCw/1FfagdLOSJsXSV16a2YAMkMMCWU24CBpeMjXGjg3E8njU5tn1NUsJCQbZWXudQ1iph2
 Bh/ibFPliSiAJFkCIZ37GaObM2Gz3A+suv/kPTur9iMPCqMM9fdEreNHuj76XT3xl/fIy5V9dtO
 6S4mAv4FUh+NnZdTJcJ6c5VzVL5pVB0BVzhxtpdJwMkqowaRpui0S71BiIxpn3yc2yBwp7uxT+u
 M02WJwTjrpj9yXszZLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfXwcttdHBX4DlR
 0+UXF6ONf2SdPBnrg26nbju4bm1a3jDkTvZjZKLznYfIzM30rG9ULsQTq8mFc4VpaT6sm8sbyRW
 O1R3wKI2lCMCpRDJahzmdDoTK1CWIFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110027
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

In this v5 a 'Fixes' tag in the commit msg of patch 2 was added.  This
was detected by Sashiko.

No other changes made.

Changes in v5:
- patch 2:
  - added "Fixes" tag in commit msg
- v4 link: https://lore.kernel.org/qemu-devel/20261110212312.56809-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (1):
  target/riscv/tcg/op_helper: avoid env_archcpu() to access
    cbom_blocksize

ZhengXiang Qin (1):
  target/riscv: raise access fault for Zicbom MMIO-like accesses

 target/riscv/tcg/op_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


