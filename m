Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=as5EzWtG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MuSV1y7h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzfk-0002lf-Qb; Tue, 24 Nov 2026 18:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfh-0002Vf-Bz
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfe-0005F7-1t
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:32 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMadEc2139911
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qvroYgXhO2tHJIbwTjdvcqQ7vVCDvJpBNnznt0wM7fM=; b=as5EzWtGPVa3W0DW
 InopGdWzNrAkIC+QMr3EuUjFyYRpJ3Hws2NUOwPrWBW5m5xl2FDGTsmsOcYr3gNA
 RXfNLzIlWHj6+3fKU/ByO/ti69sP95RQlqBTrtTI8qhGzztAYtn0c+PVYFetJt6p
 OZ1/RyEk6ZRay10Qm+VYbln9PfADpK/dUlNnz130/EXBF0Fl3B4RK83hT5bC4nHx
 5tOniiGkVqujDZK3xWnE7ToioaQETuR6smE8/PRQvEyCP2g9T/4+Kg2CFAwhV9Nz
 7gXEqM3mmT5nl4hLuQza67nFEdrv2J22ESflrhoxTwncE5qmE6bEM0hAYCfkHE/p
 RuIQ1A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gns8r21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:11:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-948d83322f6so299146885a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561865; x=1796166665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qvroYgXhO2tHJIbwTjdvcqQ7vVCDvJpBNnznt0wM7fM=;
 b=MuSV1y7h2mbbKB0iFGg6QZAApAYsmDcPAmBycqd80oBlbniPTqtA5NwV2gUHincyQ0
 UWyTQIro58xrjtuA50pm2Eou08BrMGuSOjY+OofDRRcmyLERLwgh+wpa/73eJ38aBhVD
 P+FCK0aNqVQ0+iog8cSO0mFIZzuLI0qf9+LDHVPsV8dY/i4JlxSag1KB2Ffx5RQj/Jf2
 SIyXkrmkpLUFDygW3uHXmp4PX3+OKAKhdGwLbuE8Dw5Iyy77Ftmw2YonhM6y7OvdbeXO
 dETSoFc2GUDBOI/zn4/fbbthSzzUFSb707m0/xNe8dxjcvgbHCmYDpYBunIyObs7MjSQ
 m4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561865; x=1796166665;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qvroYgXhO2tHJIbwTjdvcqQ7vVCDvJpBNnznt0wM7fM=;
 b=W9Rb0rK7mu8XzKuA0reellxZ69hHSjvcH3EHbNb0WsawT9ciddOCubg64NYi4pXt3P
 RcHBzd6R4u47gUAGPCy7DNYu/+Ox/63U+SExVhS3LLV69gLZePyIjbrs4J7DPkKz03Zq
 lTH3kM4erD7vXUtktAbIwv+jp2xI8yc5TlmpUmMZjz8rY6RAGSVFxl8Y5xTDm62lxVvI
 Ew5dcOuXaOXLvJRJoRHB4no8EOw7e72sB5UsNrXpoaMo+yoamthemOBc0xeQR1g/71Sv
 GJw9H3AlySG72KY8cgaT2viCbQEatJvu3xMTRY7U+GAqd4IH43ur5tcdTC0noTvSusiy
 fHNQ==
X-Gm-Message-State: APuU4Z/3O0gba5CkK0tq7Hranmx7fDz7bIA5OmSeWmuOqU7saKLba+c+
 ufl0PAKblRdbpn3PZOtXF9TUNxOkqN3RVcdfH2jpYm4ikiI1NLJBYgklx2KgNm8KsaEXnuwv+Hr
 oX6DMdeQETgZeZsV9Png5tdK5/CIWVCZP/ftDfkyUTqcr4lcNmAdI40V0jnpOpFJJoKTf
X-Gm-Gg: AZFdTZfNuEKT9waX9vN3O5lkdmuTuGWbnDJ19NAv7tzlKqT9pVRbZG9TN5UOR+WlR8h
 j1dFZ6dhvd/HVZ0eFnfL3XO7Y2ijlhVrhvsLtMCP5Q3ZK18vtf0IxxLyBKIc0YZP0LVaG/Jhot7
 gKSDy0X3VVxl4WXWjnAFqhmsm/szhaan93vaILZGDxNPxN64Q01t1LIGmrJ2x3/DjNWKo96ZdDz
 2I5lfAK4znn6hbbMQFIsZ2TKc1aKiCJQA6RQN9NvbSYuIyLOizbnSLNF5MWDXlh++pf/Jb3J8pV
 fQiCVPmpEz+rv2bnLsqqt3IzEdVnx+xGDVr9X32Frc7qWrM1wwr60jvlKtVvgNfCY4nfsBo6efK
 SOwRZgRx27vbMyRfeqGaG4sZYu3HqUuIJZHUy01ttfW80HOR8N4y7FSDHfJP0ORJ/Sq9dlrjiMM
 BaFfFmG+uzdH08fA==
X-Received: by 2002:a05:620a:271a:b0:949:7473:b1a5 with SMTP id
 af79cd13be357-949bab1d726mr2845694685a.55.1795561864663; 
 Tue, 24 Nov 2026 15:11:04 -0800 (PST)
X-Received: by 2002:a05:620a:271a:b0:949:7473:b1a5 with SMTP id
 af79cd13be357-949bab1d726mr2845688285a.55.1795561864159; 
 Tue, 24 Nov 2026 15:11:04 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm31408875f8f.3.2026.11.24.15.11.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:11:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] hw/block/pflash_cfi01: Reject out-of-range blk_offset on
 load
Date: Wed, 25 Nov 2026 00:09:15 +0100
Message-ID: <20261124230917.88704-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: co2CohdJS3mJ8b-YsTJrphKjDm7MP00o
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b061989 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=HH7jAQqVQHSkANCi50IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX1VonMBilAl5K
 hxtU9hmuhs4eITIdTDLsvYDP5O4p73FvhbcfsKUIio725RKxo+F3c+A6a1qOWsBvLJnKoOlyqTW
 SD6I46s8U9n9OHSTHC30GpHpowCxTgc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXzpoqo5IaJkgj
 zsi0NqBlKa3UJoQSLoH2FivcE6Itvq4Xmox+c9Xs4EOoqvX+4UICvOQHZ3j91BzR8Kh2xcwCTLB
 aNjoGbxjHoIgEaOUSNO5xTqHsLy5Aabr19ZM4UD6k3VROz/ojt7jJJ+nLc6jbiXKwny3ndJMqyB
 kUXWcPXI1M0xNOkwMUB0X/jOpMW8q7GlJr96Lua/ndPMctHY1NeiaoncgTheS/AwyHi8lEcwYXZ
 cDaTrqPB3j0FgjLFU4AhwE4Y6T+02Vutx/Kbs/NN6zrSzJ6te7zHrzN1F9VgmIxzKo9vCm8Uv/D
 Jy813LYlN/OAunmR3al8gXMuctr/F6/TcmRKUbdDUBJWMXxU+H8zZj0SmdpmLnQG0fwf/TY0O2J
 7HEns0Q74pF0CzKxY94pLSL9JCowGFelUV5qPNgSxZXZxns24oob0UBszSAXD97ONxT4jVOkEmo
 dra4SiGxgTjz4K32fww==
X-Proofpoint-ORIG-GUID: co2CohdJS3mJ8b-YsTJrphKjDm7MP00o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A migration stream can set blk_offset beyond the flash storage.
The write-confirm path would then write past the end of it.
Check that the pending write block fits in the storage in
pflash_post_load() and fail the load.

Cc: qemu-stable@nongnu.org
Reported-by: phudd6 & kietvha1 from Viettel Cyber Security
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4388
Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124185556.81132-4-philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 72c544dee8d2..7975d3578973 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1028,6 +1028,13 @@ static void postload_update_cb(void *opaque, bool running, RunState state)
 static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI01 *pfl = opaque;
+    uint64_t size = pfl->sector_len * pfl->nb_blocs;
+
+    if (pfl->blk_offset != -1
+        && (pfl->blk_offset >= size
+            || size - pfl->blk_offset < pfl->writeblock_size)) {
+        return -EINVAL;
+    }
 
     /*
      * ROMD mode is not in the VMState; derive it from the migrated
-- 
2.55.0


