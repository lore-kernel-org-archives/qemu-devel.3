Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1B606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jbJ2O5eO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dMB0cRSI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVv06-0005jR-GY; Tue, 24 Nov 2026 13:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVv03-0005i9-Vz
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:12:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVv02-0002Fk-IY
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:12:15 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOHQX0t2852915
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=u/PHMfnWtPxz+ykyxSaNlb
 Y44n5dkkVivAEq/0deCCo=; b=jbJ2O5eOrCRquv1Kjbsj3j+eVmZ1o1AgRmFrNF
 L2ag6n5ATCR4k6LVx9j3PD2sTvIRneipYay/v0yzm3VQMjE3V3FlKXtejp7bO1xf
 /9S87hOnpgtt65syxY50y0al9HZBr6WbxsaA/DiwKRZeNEhSg8eEo4s/3I85PmjV
 RDOGVHYniuAPI677c6nnBPGRRG4+LC/SSjyG9Kpbqve+Iz0OnBhfEMZU41pXK98e
 /Yb8BLl42VB4jaiPRqg7GRnxY9pAtTH1GmV7YDy44Pv86ARGZYw6hDOhJVPBb+5A
 1fZYW7bzau5dt522ErQjVU0ExUc7edKMuL5uOjgK1FYUh2gw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00g6pn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:12:12 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0f1c06332so74602697b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795543932; x=1796148732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u/PHMfnWtPxz+ykyxSaNlbY44n5dkkVivAEq/0deCCo=;
 b=dMB0cRSIKxjMF/ISd+Pz847XtjG2j1nJPjJel0NQKV4RNwjxeGTCzGAv2rA2RfIoyE
 TpuadDMbaCDZQ4dZeK6GvGPkDzYUsmV6VizChQ+6kHMrUfj0PniqbNMIyi5o5tZTkaro
 vLxdU6pmGFZq1VIUW0TytH3zFSrYiXizt1iENge5NmpZn6OS0joyROPdI9NNAZzD1nYS
 18W52tuLy+nqBoWl2aRr+IRJaMOqPO54ccghdHz0/Uh+Qt2d0TRcsH0/gQtvZcW6Q1OC
 QPmLmwEem4QZo0b11U/aU8RuFYMrvcxOxyt5cROFO3XTpQRbpzGQ6PIGfLc+ZZgvHUe9
 ruQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543932; x=1796148732;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u/PHMfnWtPxz+ykyxSaNlbY44n5dkkVivAEq/0deCCo=;
 b=jfMOd+rnwqMSBsdq9IyFjMF8pmqsfWlR6UMBOMDmJ9KigX8VeOjtCD9C5Zyq15uJaH
 OKFFrBe4Nv0K49o0tKGLxASLnhoJKJRO3JZairyQs4F3OD3C3fOev4Xd6tBcn69Nmue5
 bWr3JNy43gDDrlEtPj16E1F/E/n01vvItxqhiH4Z57X70Qw5YMIVJIpoHjuSsqjuAxwd
 5ED7EqjFvH0sszw1nrejtblN6NmDhoWlUFZ1/9hLjLzJlcMnC/J1dRMzEhiBBR+9hJNO
 lUhdZCbEil/Om5bf21TD1qMqq5Xf4JqPXGsQVX0J/6iIDinjTB6ZE+4sgR6U5uP2CSed
 9Zwg==
X-Gm-Message-State: APuU4Z9nUZB10zNVozoqYlA9+HvnQelC6KsAKgzMTKu1R+BLN6fOUuw2
 T39cEliT1CMP4JnXCih4F63tW+zTsbMOMgQlxEN+79obemYXhjzJYR342jLU+Z9hzJlI+IU9X9D
 8MQ8wAjNGBqaumbXmxlUBRjvsr2BHXGNEsBUNsA2b/7oyBDWzhIfddnUymOzWj4icbhN9
X-Gm-Gg: AZFdTZfLLBeJ2zE1PRONnypGKXoSdBWVYph/+31Hws0U/vcBYKdFS5VKjGqZkuoDFEV
 kBggMs9ci3SrjzaV9NkB46z1uZjRW92Y8O7PITvbNWA5T2eQWpUQDQ7BorgxOUga1VaIeJ/xivW
 WAIND75R7JoSR3oaOtL735fTFCvUn7NBfv6F39P5te5Ph86xgmhiLmoA6uxWpUXmyJI8vLYJJaZ
 rhq8eLX1qDUZJWcyLPpGypQz9m6O1vPUGB4p403y34J7+j3Gn2qPBkBa30T1cW0P/9VwpgGf37f
 gfIx/n1MrE+PrqWwvK8hB5s25o80DmVzHivKo0lnk73qNi/OD5mUd234p1oksgrpSRI16ZwrNz6
 K9IWr/ahEzhNsPpbUdXI95qkJu9SfHZ5FMDZfOsYz6JBboFpPzdBpB8O94RrKFMP+fHMQuCaIXB
 851PWanOa3DztP1w==
X-Received: by 2002:a05:690c:b86:b0:8b4:ed0e:7b11 with SMTP id
 00721157ae682-8b52032939emr65411467b3.4.1795543931869; 
 Tue, 24 Nov 2026 10:12:11 -0800 (PST)
X-Received: by 2002:a05:690c:b86:b0:8b4:ed0e:7b11 with SMTP id
 00721157ae682-8b52032939emr65411327b3.4.1795543931374; 
 Tue, 24 Nov 2026 10:12:11 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm29165373f8f.38.2026.11.24.10.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:12:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH] hw/block/pflash_cfi02: Return to read-array mode on reset
Date: Tue, 24 Nov 2026 19:12:09 +0100
Message-ID: <20261124181209.71534-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ifPNd0ajKBQ2wNROY71fMBiBHI-cwzxN
X-Proofpoint-GUID: ifPNd0ajKBQ2wNROY71fMBiBHI-cwzxN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MSBTYWx0ZWRfX75IURFI68lGs
 rHZM5VbjtG/J1JwMRJr2xpMRzygtvsqIqTRW8YHbfyA4hiZpENUa9ooWV+o4sQGddgykC2Htuau
 qhRFC9eaSVGnTZwEt/XVgfGV3ZQBhRI=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b05d37c cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=v_A6ruy6FsjtNwel148A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MSBTYWx0ZWRfX9ngF1hWl9nqq
 TJwwA9VoWMjJS7rNYYUElSN+usMFUTCq6UWLMAUqYukezVjyRMV0sftsA4c4onA8Thue70hrSIs
 vMQLUPoqftfRtuJ9pDOYtfTZNndoGxnxiLH+NIVB5N4tVS60sX1fY8yiaQKVLIrxm1NtnZ0L2tk
 JOqSEZv7oAhCvMwAOLCd8aWgVoNY17ull01KenPAFweufuSeA1DoplnyatJO7aikOUDWNghndFD
 wVlIvT7wi5jh4Zxcz8V22LAMUvyR8ooZRayUdITgpV316lQqb/Shtzjb2+0xxBbrIfJG//LYPhm
 0Xyp5cl4oQmc8n1idgy/Q1ZJTHnBuwNKZQIbgOcjEmsQxwUSelplxcmMHHAA7mk3eGBxKrGu2dw
 q3318rKp37T6WgGT3q5Gngyudb8zzj0fDw1DWuKk7Y4/cwFXWpDJ1rvhPzgsOJ9FD7cjVFozrot
 UTvoun8W1/gSl+t5ASg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Reset left the ROM device in MMIO mode when reset in a command
sequence, unlike pflash_cfi01. Use the read-array transition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4f72c438c0ca..8d130e14d1c1 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -958,7 +958,7 @@ static void pflash_cfi02_reset(DeviceState *dev)
 {
     PFlashCFI02 *pfl = PFLASH_CFI02(dev);
 
-    pflash_reset_state_machine(pfl);
+    pflash_mode_read_array(pfl);
 }
 
 static const Property pflash_cfi02_properties[] = {
-- 
2.55.0


