Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A6606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gB9Rqti9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZeWgQHMx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvM-00014v-3N; Mon, 23 Nov 2026 17:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvD-00012F-Ho
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvB-0004vA-8E
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:02 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuS8A1332575
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yU9xXAdx/qDOBH3UsrpNBzEVfILsnlnL6cHSvR1auVQ=; b=gB9Rqti9ATD3A5op
 mxRsLZ4gm2/wxCMT98UUMDc3jLmn2Tyh0v9p8URmekOBi2VYzhypyiSvQW0XqQfr
 3py2Egh+9VYJFRl35yuazArg8soxG+TZpAfMfXIRyqVUI3JcFsJ1TqIH14o0HJJP
 J5JbrKXXO3JbfTro0s6iFxsmMTZz2L5IWPKS3T/pTfSkX700/nvIqy/LDj0Z+pwT
 3DvaS167culljF7FHE6sCM9XtBbilGRd4/n7gQgS1WS0oRDpNxKMEv5YvxTNrFnq
 1TJ0IqW4/AqUE+Fpqj6Kd8zOt7ToVFdEXmOAXc9Mfj4nfnlY6pycOcaQd16xg+aB
 i1q0dQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g743tg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-921286add9fso12550216d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474439; x=1796079239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yU9xXAdx/qDOBH3UsrpNBzEVfILsnlnL6cHSvR1auVQ=;
 b=ZeWgQHMxWplbVbCBDvifs3guOS+w0gJ8gqyxZr80NQBaHK8jT0ZpnFSGemzZ/AXlN3
 ko4MPeC22J3pgFDW70vDaSWEQz7oAzo0sWSvjshl2MEsxUR743w/IcsaRJeHTgmAoq2j
 jLtiFaAVM/qlKQb1nFfA/xKnq68uppCpqXuC9C4nZVyspJYXGKqL27/Cl2cRYqO0vdPP
 Xf4l5+4XmbmdBK1LL6f1S2/nkVE2sZ/XF3mSWplUjLIFRR2Wb6colk/QwXJ/Li+suYEs
 JgYAGM0GHh6b/CIFjVKyvaeijKMZLHY8y9lJQflXbRJdj+tjReRWsQlFMzq6E0wc62Vm
 D+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474439; x=1796079239;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yU9xXAdx/qDOBH3UsrpNBzEVfILsnlnL6cHSvR1auVQ=;
 b=qYH17NOs2a/zBZ6ONJatTzfsIAFaD/hqei84tAqdWiW8EEFmcvMOo9mCGoPVwEOiWW
 0M+lW3Z4CQLiRhzOukWouHbKaVbqoQ7zRpuaayc++K7eC7KoHSQR87GwX7miMQyJGx60
 Fc5HFT1vfatSWmtP2Em2R2cDw2s7YOAy/sArtiyJr18Ennujys6BHNl3DDBXDY36dSxk
 Vf5JsCkCWvonkZzJjrF04gCxvPSlwBzXxe2eYSabCE+82c0pDads8v/iz/bRCK5Xx8zE
 Bt+HQJsBGes7P7vxmJ0B60IebHhDX+IW0maZ5VmpeDLQDpJMxYnZUubuEMLMzYXJLk5m
 vfBw==
X-Gm-Message-State: APuU4Z/mrgrx7PPT/jm0f2fbL6YQoSP5mmzLuxf75QVaKDXbV3Hglkzs
 OcDQP+Z8TldD3+W1EI6w/fGmcYjXDWD4QF/tJslOCwKmkn7JrC9XPhWMvAOLLGiwz0Tl12k0nYW
 4sxhhJLRLRqJu6iaDSTYY5jCNnUVkNeIsnMYrmwgUdLpv43N2pcPd70MKPFClEjJRz0za
X-Gm-Gg: AZFdTZcR2UkWrXBlRmzG5b6PCFBHwHeeDto2fWx71TbhvegpRqrSqeq/OC5X+xifMOV
 CqVbMO4O3HNeq2/jXDOjTdDjfL1aluit3jdcMaMpGhT3UxlRu4gx9SYXrfdfzK7Peh9mLki/jA4
 L+/RASTq7mZJhaVpqAtigPgWVE590WDoWrg2SHUHNTQOOrBqW4x+lj9GR4FUlMh8ZZt/1nziXsE
 oomd2iLaNZf275W87rhrwXzmiD4x0cHDn2vXZNBa7cTG1bkRVieJF/Jjo4Mb9bjqZp3htrjZgYO
 BKH5wBoOTBq9yNIuVaItrD//aGSenOGAhFkMZkqsZSLqD6vV5lrTTuoN8Pnga4uoCy54JfxBhXr
 TQQmo4w7yOp5HVdRXkoitaYFHyujnQz4GzHTcxagxMJCuhcT4aqYPHc6Ru8PkCL7utimWgtNfFy
 fOjAAN9WZgdJGuWw==
X-Received: by 2002:a05:620a:1b9b:b0:93e:c12c:9b6d with SMTP id
 af79cd13be357-949bab5446fmr2119619785a.72.1795474439444; 
 Mon, 23 Nov 2026 14:53:59 -0800 (PST)
X-Received: by 2002:a05:620a:1b9b:b0:93e:c12c:9b6d with SMTP id
 af79cd13be357-949bab5446fmr2119618085a.72.1795474439061; 
 Mon, 23 Nov 2026 14:53:59 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm392016885e9.15.2026.11.23.14.53.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:53:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 1/9] hw/sd/sdcard: Reject zero block length (CMD16)
Date: Mon, 23 Nov 2026 23:53:41 +0100
Message-ID: <20261123225349.54981-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: axOND8NSLREFGNenKa5wCyaG8aCBMU6C
X-Proofpoint-ORIG-GUID: axOND8NSLREFGNenKa5wCyaG8aCBMU6C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX1TkqchZ37wFN
 9JJakMLkojYhRQ6HJI16Y5UCXWMcIkf+ueeYFKdYLZ9wBHFZqMBeJnNamAEFPRedcewMrFqPL84
 RAAi5OXuzdfI0LYEpO3OiVPXMvGi8Jk=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b04c408 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=JfleF5YHFwbTGIRgw64A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfXzY+VIyU9Iz3i
 n1it5wD0qnIKZeOH+5J3b7Jy+302RwNrmm6zBW9PdiYKJq8GGoNYBOVhP8kKHJiJrlVhS6nt1HE
 vlnyDg2P5r6X8cDwbVC1uXM+p3CBipmd99dh7VRSWiwn6L7byNq4FcDLHcE+yPMZ0MJRYT7bnJk
 xyubg0jYQpj6dyEHIOyEgo5Dkh3escep9lYyh+pHTN2UyJfwl1LBMhFZ+zy5+NzzXes9NAygeC/
 G9QXvj7U+iV6CQ/UlCgIoFELYrLC5GWUxLmYRl2VMbNl8j99uuU1Ih6oHZHaRjw56+m4NtY8BeB
 MlH2e3LIZ9KrbS5681YKd++E9f2hcS8XlC2wErmXPhgx98xPx/ixJgqMOfnxvTpI50bWfCQx/y4
 vu2QO0LgTYMme3/6LQ0vbvhkeYebBc66f6aoqvtgZ8UBZ+dciSqicn1zPfhvJPJFXe449LkDIWf
 EBsvFwRbhBCR4QaBB5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SET_BLOCKLEN (CMD16) accepts a zero block length. A following
READ_SINGLE_BLOCK (CMD17) on a Standard Capacity card then reads 0
bytes from the backing image and enters the sending-data state with
the data size of the previous transfer, so the guest reads back
stale SDState::data[] content, such as the password sent by a
previous LOCK_UNLOCK (CMD42):

  CMD42 (set password "secret-password!")
  CMD16 0
  CMD17 -> data block contains "secret-password!"

The spec only requires BLOCK_LEN_ERROR above 512 bytes, but a zero
length cannot carry any data. Reject a zero block length: set
BLOCK_LEN_ERROR and keep the current block length.

Cc: qemu-stable@nongnu.org
Fixes: a1bb27b1e98a ("SD card emulation (initial implementation)")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0083b8e064e9..6b817f11c5d2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1961,7 +1961,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
-    if (req.arg > (1 << HWBLOCK_SHIFT)) {
+    if (req.arg == 0 || req.arg > (1 << HWBLOCK_SHIFT)) {
         sd->card_status |= BLOCK_LEN_ERROR;
     } else {
         trace_sdcard_set_blocklen(req.arg);
-- 
2.55.0


