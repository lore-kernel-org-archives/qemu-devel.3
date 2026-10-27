Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97459606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bYuCVlca;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B3Ws680V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrV-0005oO-2H; Tue, 27 Oct 2026 15:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrL-0004eZ-Ax
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrJ-0002Ro-B7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:22 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHCfl2087833
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jF66YvahWYKuX9FvRtpmRLZLO+ne1wfECjuR6GMRhV4=; b=bYuCVlcaIBPRrYOG
 LFutFltV3BqFub9AvJ9vQLfhiYYsnYEww0DXk/cGWj0DrCwcK+grDKc+NDGhH4Yr
 RSpy9b5JvqQi9cq7nrryFAFLXkrULabc85KMvDgb3LzUuTeHS2cGenXZZpxIY6AH
 iirAFqC1Iff5HXDxrGAJN6g+i42EKEeaJC4e5pzpz5CbPJWv/ZlJzmsqOYup8hmz
 zD8ljdEg5K1CeKmH36qark8YZb7l4KEMUzrR4/z6YKiU1z9AL1BOoV8tQo5LXJis
 odU39gY4S5tG919Ahub3/DG94ctyUwdV2ySVpQcfJczrZ/qXkCDULzI1iuh+NvnM
 tgb0qw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbb9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso269181785a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129359; x=1793734159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jF66YvahWYKuX9FvRtpmRLZLO+ne1wfECjuR6GMRhV4=;
 b=B3Ws680VWj6tk4KL2u/ncAD1+UL8e7QNyFQEf3Z02QPnSOca8OsO0oQvvqBfG37J8Z
 FIN1TAmyQQ/kEyos9fTjnahPqbWpT8fFMavr+loes3CHERqb1hKTZD0SCY26Fa3F9zy2
 2D2aQHlz1mUvTP5KueksKD9ks8PhUfC09mlhL1svKvi0hhDk3d9J5C9Lm5Ism/6ouWo6
 wAl0GMc74o49MP88mZi9OlRz4NonlOiDSQfmxiaa6Qhkmn7kGkqHoeMkHq03UuQRwPg+
 8MQf7cabnhJcBYbEKlmwSAoBInYqwptN6ui86keihCdoREt9kcbFazdnC+s0pi6UufTv
 5Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129359; x=1793734159;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jF66YvahWYKuX9FvRtpmRLZLO+ne1wfECjuR6GMRhV4=;
 b=IXGXUrI+un0GyVZjTxjh7Mfd97zu30XMnQhsT6li64RDeIjLpYEw3G99t99SQKSI12
 Xq3w15c/Bc82vxFG6kp6rQ80JyFSBS1gxoJ6N76b58FS3hF1btCh7KPfdifKZ47R0Rl8
 IJC+kRrZdMT54un/FHEAve/q3PD+qIo8XgCpjQ/Jarovo00MzA+TsubzuEMIHoNyZidO
 IGT5MmyRFir8GSCLxoq3zPmIymv4K6UDl3sRIBeV/6OC/+AszyO60rPqJ9kqZcGH39pG
 NswFG4jL5+jS4X6XZ6C34Y5hAYPNxyJRV5Zzm2MA4u4jl0eAfCmnj68dRwuYua+tFgvN
 o6XA==
X-Gm-Message-State: AFq9FYKpa1vlqFLeeUg1Vy4N0IyFY9T9dUGvCIx4ueNx/Ky2BnPG+uDu
 JRsIi/sjSM9hln9CnCWaryf9vMbJj0QK5DLUmeXJH6jOOQQhoQkkUIt65IFPhxBQnPLOehOct3v
 Ir4ii4My9K1+bkXOteqlb3b7wRxIZWWgad5Ro7KVU5Qihvo4/+ZAc/8kabDZTp/3e5Q==
X-Gm-Gg: AYBFou2IqTF/IVKczXy1GbZz/bJOCUzEJbr6Nj0Z28Z0tywF5FFVTRTuQstde/4GysE
 qGhrify3Ofe0QGfb/pTrolATWwWTqckfCEtxQBbL0m9CrhLhzk4E/+NNuRot+AxUyHFm+LvuVoq
 ftKCVjBj9L3a4TbAiNdnGi5kuU4+WPKYY9bUDtknHZiJCtSiJOWwWkljFXYscKI52RyMO8KH8KE
 ZN41aKTfu8fERMWmtrqQO8wg7uDTq7mt8fTHj12ZkHDlJvVFLgK8VCbFI2oxVXOc7iCRSt2Ynkl
 1D+TuTJMb5YnA70UiLLywfa/HHTj9Sj1qJ07Xjv+B/W//VejzsaUztEolaPFbVjkDb85x4ld1RY
 jsdYqfBu+uDc+bBAKQro+Y666YCC8SWuZa3l6hsfOiqpL4TwD5uoD/b1/
X-Received: by 2002:a05:620a:400c:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-943f4a0489amr583439085a.3.1793129358672; 
 Tue, 27 Oct 2026 12:29:18 -0700 (PDT)
X-Received: by 2002:a05:620a:400c:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-943f4a0489amr583435985a.3.1793129358163; 
 Tue, 27 Oct 2026 12:29:18 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9493bc4a8sm8300215e9.0.2026.10.27.12.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/59] hw/char/sh_serial: use rx_cnt for available FIFO space
Date: Tue, 27 Oct 2026 20:23:30 +0100
Message-ID: <20261027192341.9197-50-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0fb8f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=YEB5RgzmAAAA:8 a=EUspDBNiAAAA:8
 a=FF89FASyZ2sclMI0Zw4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: uECX0UWptpv47BWMaIfbj3siYpycd4bf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX53M44hDU70qL
 8l0xoKRMh1gcB5d+NEW1sdB+zceXoWagMHGvyVfVB3n6AjUcsGu9AkBflxOSWGVZHD8MWJ6kTfp
 4oJtgGRbjKTRgujeb53LujPDBMWrtQ4=
X-Proofpoint-ORIG-GUID: uECX0UWptpv47BWMaIfbj3siYpycd4bf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXw7cCnS4Dscht
 7bHNAyKrOzbPaQyv1cZPYgxJdxGoPDwDegeD8xl3CQfqjcFn+qQuKhXNXTGpeqsvhb9vp8ctj38
 6dKIR8KwT04+Ue7cVKnQaeJPjMm7N6dQByD1/gLJ1SqqzIJ/1vJ4mHSjPR+de2Fq+GACCd5VX/5
 3KHuro2LIj1wSh8GHpJ6Ufmtu3ItLxD1ihUqgy/ARSxGxBbUxBwyNGe5jWze0qFXt8vadf3oJkQ
 nBcq7++NR3DbWmTcugAFXs7CvibG8s2jk17arPS4FFySYBWnEUZutOJJpaGh3geQYZ6OO5MvGKT
 ftzlLycvgfDM1ryvlWtPZyUpyOdcRG/M+9GDrxtQLVPG5zXArsK/zldznTUpUBglvI38ek1ZV6T
 7EFdPBI5vk/ffHMBqgDKkZ2xkASm6eWmBjB0bI+o0vyfgtGcj0Pz/aGT14DNYN8K/M/fO+6SYIQ
 Knp10B4DWt78FbNdFOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

sh_serial_can_receive() used rx_head (the circular buffer write pointer)
to compute available space. Since rx_head wraps around, this could
overestimate or underestimate the remaining capacity.  Use rx_cnt, which
tracks the actual number of buffered bytes.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 543671d9907f ("hw/char/sh_serial: Return correct number of empty RX FIFO elements")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20261004-issue-4560-v1-37-ccbef537cbeb@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/char/sh_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 30a22ea2d1c0..8728842b84e0 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -316,7 +316,7 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 
 static int sh_serial_can_receive(SHSerialState *s)
 {
-    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_head : 0;
+    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_cnt : 0;
 }
 
 static void sh_serial_receive_break(SHSerialState *s)
-- 
2.55.0


