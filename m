Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B76606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbtxahJK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aNoGMUag
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSY-0001G7-Ag; Mon, 26 Oct 2026 12:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRu-0000hb-7l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRs-0000Z6-Jo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvgbL4168012
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HBMaITjhy6bK/muOnm2YrBoWD17J3lSQHNgqVymuxVM=; b=gbtxahJK+G8eNcLQ
 7Etlg6X803pMoo+YGCiF/bqBdO55u8IdUkjF+vXdfDEjciaBa9NntTnS772ItNSp
 D5uCc9cSM+VoHtcurAdnjN1QYvz8eH6F/Fbwh3RLUZ531ca3JPMIiXYp9zlHlCOt
 bS1bekl8q0qeAXkUp077SFWMhD+2TZGGijWSopGJOM4qvOvbaVEHDlzqn1AlBdZI
 M0/mZe0sey0xK71f7Xx0uM/z2N5A7N9A3m5urQVTIv9KCnOHfHGO3xa5d4nwLTXA
 bwLuCZgHIN+DHpBp+Uj/e5nZslZXmdO3j3FuGylqIARts9odBgqqc9Kodbnh5sD1
 FsY0Yg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf1erx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:23 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eabb3a1bb8so953806e0c.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031683; x=1793636483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HBMaITjhy6bK/muOnm2YrBoWD17J3lSQHNgqVymuxVM=;
 b=aNoGMUagYqz+tTUlX+gfLz3NUXV3hdNLzIdekARXUhIKE1wJUb7BennD9+4GQUsn+S
 N8hTST8a7/nF1JgsfNBh0fVn9EDMwAoCZ4NwaxDHlypcPilOAaCZqLNtDbHtqgZO0WM+
 NTH5UI3luDrptvqcY+c7k7IctibWgv1mDk4vIadVYy+oYm1XdJ8VQ0AygNAhLno7tPx8
 7nzpR4beH2GBmgFo0j0R0155fWynT40UR56bCRugyIABBtAu2v4My/LU8urSa3Iz8gO3
 fnD3CP51DLiMDNy49xpnY3eu2fNtSFU2D7D0gpAqbAZWzKZvAC/Cq/47ASv2tdTCRrR7
 hIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031683; x=1793636483;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HBMaITjhy6bK/muOnm2YrBoWD17J3lSQHNgqVymuxVM=;
 b=Ma9VNTfQFsnmCrWxZFtbPpGtavbyIItzuxlKmTuLASxIQhsWOjZ+Dlft8C7rLM4ZpN
 bQogbkM/oJLjo3VGkCbs9K5wkeNR/zScRmqcxDmQGTd5kwPyRO0QT13avTbcEkvP+tia
 z80o/Zw9sVS2Y6jM94RfcTzYlFJG90e7Moa3VrluKKGywTKAqhdnf8BYEz8SHePVc4ut
 EJ5OqWaTKEQwnV9+TwyKEhU9DIqQJWOMwJaUCrIlv7XKIaxdx1CTP2eSOXpldkz/jXWe
 uu85VrS+hTHZbe824p1ULk9k2/95MTkKCgzG+DV53yoiEyuKDgNzjYMSOohMMzcdIIsP
 wJtQ==
X-Gm-Message-State: AFq9FYKAYcJ4aaSF5TikpK5ixGqrHH534Srjopzwl4llolqX39J5f1QW
 gHvM3n6u0QlQkTM9O4MOvlk5upRj1Pu2svA5WSkwTX/kxOCikxjSdeKlqy/+W3FVU9fdGpEiBjk
 +eKKA9kj3K4H6B0I7DRPY/m2wZ7dc8s8a922JbEGdZ0AiA6gowgzxQJ5heggg1A3PiA==
X-Gm-Gg: AYBFou0ZhR/LpPdRuqNQEm2rktrYWuHCZuNeCfwCKdYjcdU8H7m20ygCwpYRaSp9d/u
 tyyXSy/KV8yy69T5kOLxPAha22Mu4ppiRhjke/DQ4xrEQLiq79RCoeGICQrp2YrsxS2WN6r8m25
 lDGqX0aj+R4b3XMj0wopZTKxCtmuhtxi9H6m50t44R8Lfb77R2ClULiideiL/E7tlkU42iW8svj
 ol8AmIzPWDbheI4Y3onK3XmDxSFjSDO84FOPLu3iAusZyFWSFHpotQ1f/GsWWoXGyLoUAWw3g/p
 IvN7xkIC7nNu1qRyixH7MKrGAnfr0VOIAQVmDtR3h+TXhz4HVFWZbypoe3D1Vh1eLHd78ekr6UB
 BZVYEZhOVggsnCT4pSyINlClZrREdrAdUDzfKdvuF
X-Received: by 2002:a05:6122:6c1a:b0:5ec:2c33:f782 with SMTP id
 71dfb90a1353d-5ec2c33f983mr2145777e0c.22.1793031682768; 
 Mon, 26 Oct 2026 09:21:22 -0700 (PDT)
X-Received: by 2002:a05:6122:6c1a:b0:5ec:2c33:f782 with SMTP id
 71dfb90a1353d-5ec2c33f983mr2145708e0c.22.1793031682240; 
 Mon, 26 Oct 2026 09:21:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece13aasm16127426f8f.58.2026.10.26.09.21.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v4 06/14] scripts/decodetree: Add support for 48-bit
 instructions
Date: Mon, 26 Oct 2026 17:20:25 +0100
Message-ID: <20261026162034.32711-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX5iaYj07jZ/FE
 5qMPCIDKzIz2MUTAEVtUYYmQNxOly7Sqpddvtrp/FXxJ7Fr12cIJ+fBCWO+c7xeqrHNCHLCeOdc
 6nPiB8C+NRDuCfdamu7mmZfaw1gOQG8=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf7e03 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VSEoAdZmU9g430BQyCYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NukK43vcUI4Dq0WWriQuE27NZbhbdRAO
X-Proofpoint-ORIG-GUID: NukK43vcUI4Dq0WWriQuE27NZbhbdRAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX+3eMb+/20tLY
 GKXqUrkQJuWk54YXFQJOYc3UmcUz31kJuao+3+invsIYOCE0KhiNtfxBZ896zTQ+xjpYFiwv0J5
 SmLhEN5hVayGhKB3t4PfBawDntdrWarpJUdYD4VIyG5vfEQFey9ECQrTE6bMbBwauBYnV/2PFCS
 FzXveSrKrW4qIyaej3A00wXr+EYy/u86WWG5aSqp3lV/Wi8dOpmTVUDc8NmiSH9Sv3WsEU2Ghe0
 n9ftvfR6YDH6yCKskxb+jDFogIEFTWcy3HJ1MwuB0T8Xg+PRZtWEHPtTGepgm33wxm+kLRDDs/K
 /sKMmOSafBJen1KnQPK28T8KP8mybGDpKknLX0cSEnnh3LRwK0nmDs4KxnebaBsZvu2RZj758BZ
 bQRZ+bd+dYxO6Miwg4Ao63j7/e8zwY4Juv7hRgYbFIqU3/rWQXYWttjBZcsP4uCmKv4NDCh1kLV
 Qn+F+bhoECpx/RkohQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Some nanoMIPS instructions are 48-bit wide.
Accept --insnwidth=48, holding the instruction in a uint64_t.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Reworded description
---
 scripts/decodetree.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index f992472b73e9..eadc3850531d 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1544,6 +1544,10 @@ def main():
                 insntype = 'uint64_t'
                 insnmask = 0xffffffffffffffff
                 bitop_width = 64
+            elif insnwidth == 48:
+                insntype = 'uint64_t'
+                insnmask = 0xffffffffffff
+                bitop_width = 64
             elif insnwidth != 32:
                 error(0, 'cannot handle insns of width', insnwidth)
         elif o == '--test-for-error':
-- 
2.55.0


