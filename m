Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B373CEFD11
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 21:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdEKs-0004Tr-FV; Tue, 06 Jan 2026 16:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdEKr-0004Qx-0m
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 16:11:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdEKo-0006pQ-G5
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 16:11:24 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606Efolo322971
 for <qemu-devel@nongnu.org>; Tue, 6 Jan 2026 21:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DBiM6zP3FawkCotMdZEL6KQhyI8vT0HmylX
 +KvoxhvE=; b=gNSKbTIKLPAPndu/o4GydnchWs57xPMCMMZ7xnMaozD7AU/YCuo
 NXxG0lagc5bNdvpt1zHYa/1m0YYB7UoESYC4Ijtb2hTEp7Vgjku9sqVxlDlZhlb4
 z9E9x/H3yt3taVGj+1PFM71pH+LBaSXpoCq0gUDEehHONobTxQAAervAlGnGX96E
 7PYc5q08dtleLZxYuyfM/xv9WMgVWeDCHIJDvYw4lG7XvC7S6vnlZd/+efCpiCwb
 9gfKlzMUIm0++aoMCHOfb5VMCZuZfHrteA3TzIxpJfJNnwHDQ37AIHYUEYno6jSA
 szdSlXM0/G4MSMKeXrtPg5UKD3d0k8BCs3g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh4crh5gt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 21:11:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b0531e07e3so588391eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767733879; x=1768338679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DBiM6zP3FawkCotMdZEL6KQhyI8vT0HmylX+KvoxhvE=;
 b=L10F7nqRsgZj2oFOYByK8klxZhr8NZY8lNRvX0GkuZW42Q6LftnhOQFnZJeQ/RX7Mz
 uBWFMx7KspKmzHIB18DrxKPtDG+CgY+rNus9V4rL3IXcgnbsDB6oMLCSkhFphavcGHmc
 g4uRVVirO3yiOjgxBXYKMbWXnvrgKX2l/dYfN1bw99cRyL2Vtd9/U9seeahFiLQ4aV6Y
 ybcyTb/VCAd2oElgbg0JAQGd07ha4ZHAbTBHkjaryg5/OAi5T861wRuMQswNOOCbKQSd
 Dd2G0fVg5/T+rQGXuqtfskU9JA5NFZb9VNirnIKbwBgONWnrQFyZkD/I+IKt64L7yQRa
 4sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767733879; x=1768338679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBiM6zP3FawkCotMdZEL6KQhyI8vT0HmylX+KvoxhvE=;
 b=m8tLaOKBPpNaICk78KeSsrDrUESTelU49xCZjxdrf1ATbZp7ou2Fizgr6AKTeHdVBh
 cXfM/Q9HF2Yl9hgPNobYigNt1DwgCjInZTMb9/y0XGI3rewRRktkxdvz2Wc6jIA1321B
 a+4+x86FejQjRakZ65zu+qMc/L4pZMPD12T36Fg49j2dyQpayzwFtByCA8COnnf8/Cq9
 OEyh55Ckz231PXAPUgGEO8D2L1NWEYM8oz92VaOGnTB5LKMTO5D7PvLQwQ3JHDLL2W5E
 JaYlgCG5OI5x8CP4C2K/Qees8SXpkmYqCqMVcNkRlT6iUb6AwlJQW7+8j9nDWcADLwQq
 vK/Q==
X-Gm-Message-State: AOJu0Yx7jn+oThwYvlQgXFA3Fvf8hISMhGLnNq2rbzfh5C6FHJPpVYty
 /3z4+0YEmbpSiyD3r6q1Ltn4TqS6T1LgxbCpV3p7xwu5oXsEDENkDXXnl8YbOd4591zRQhtzor+
 fvV6azaXSzCxQ+JnoamgqSNbEUTa2XNCtH88W1UeC0UIty54+UrAMY3UvxQ/IWFASsg==
X-Gm-Gg: AY/fxX70sA1xQH8ZWW77rcFXqtQb7qHk+Zu4TIW3Ee5zlyW6V4Yhp0gsYakosJ5jgkN
 G/Fu2nal5ZRZf6nToE7w1Zh0qBWfXmnVeZ84VWRSMv/CIuBj0Bb3t5Xhs+ePXuW69Xd6XpsBiMk
 1AdgDGnbozc9gpd7/wNLfq+QUYjKr4um0tQr1sDlUMT4de+9Vggac7+A96zFvnamkwcKn6Kw3Bx
 l6T9ANaKRfovrQqCDGkqfGztbjys6tCQNjKC6WTXS4of4qPzyEMKJHcyHp+sj0D7/3Ck4hTAsEs
 PtQB2wAWoIfdHmi8EWtj0K1B06cft5EunDDSI+DzDPF8Ns1c07WqLKtFkNYOHEhluiMz2lw9kFA
 T0i+YboYPfZg1NOdQ6wmQ9vbKDv+Qz/tQSOK6FB7h7ckoHby5bgtBv36djdDl+Ev33aaIvUHbJz
 vZYpjQ7nhC8q+qurB5
X-Received: by 2002:a05:7301:5f0b:b0:2ae:55f2:ad57 with SMTP id
 5a478bee46e88-2b17d30d394mr144652eec.29.1767733879060; 
 Tue, 06 Jan 2026 13:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI7Bdvwi/GwkNevabG52KXTENdOIn8DVrKndzHJaE2uxGM9XIrlhkaArxeEChz5qioLVZNEg==
X-Received: by 2002:a05:7301:5f0b:b0:2ae:55f2:ad57 with SMTP id
 5a478bee46e88-2b17d30d394mr144635eec.29.1767733878535; 
 Tue, 06 Jan 2026 13:11:18 -0800 (PST)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-127.static-corp.ajato.com.br. [200.162.225.127])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b17052dbc7sm5073680eec.0.2026.01.06.13.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 13:11:18 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] roms/opensbi: Update to v1.8
Date: Tue,  6 Jan 2026 18:11:12 -0300
Message-ID: <20260106211112.3752298-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V9FwEOni c=1 sm=1 tr=0 ts=695d7a77 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ewOVoc8TSmC0cCmMeNMfEg==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=iHZTgN8fm4JCfjMH96UA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: JtPGRU5uuO5hn0J9dTADzmdFWZniptrI
X-Proofpoint-GUID: JtPGRU5uuO5hn0J9dTADzmdFWZniptrI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE4MyBTYWx0ZWRfX9hK8vI2j/MhD
 R7XubjcJTCT7HB5SzmLuKnRlgNRTR1Y8x9ImEyldcdhMQJ8I+whSRM/qlqDGSZnEiKI8bLaNv9Y
 pAPG7T5kjDrvfSx+xmMDZSlqaiU2qH3QrVTP7I6UGS+/itJ+99j2fhGPkbE58O4P9vWyxkd1FGm
 6Clug+3oOb4NrIGGKySigHHd38qoI1mLugmxFiIrmXDZk/xd2tHwGj2UzoLsLmYnE17W/hMJaRx
 Kq/l9FXbiGLmm/7ACflbCMLSc7he22+p3Lq5IM+J8+82SLiir0iY9eYyBeLCRkX3+v7ru4tulkz
 p4rRG4k8J5qyax+tmDFUY0Esj7eGBJU1EyUsRdpYsP38FDdGLNymzR9OfSZpkp/j0Vyg9nDZ4z2
 qqTBoHc0HDa1J9Jhbc+WR5s0rHAftp9poaLbqtas0cfcqopiLFD2HYMvr90qA8+i/0Cur+k5xTb
 WSVRM4L8AEJUfgyqR6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
version 1.8.

I had to build and compile OpenSBI v1.8 to verify an error message that
started to appear with this new version and existing RISC-V profile CPUs.
Figured I might as well go ahead and update the roms while I was at it.

This new OpenSBI version features, among other things:

- IPI device ratings
- SiFive CLINT v2 support
- SiFive PL2 cache controller driver
- SiFive Extensible Cache (EC) driver
- SiFive TMC0 based HSM driver
- SiFive SMC0 based system suspend driver
- MPXY RPMI mailbox driver for voltage service group
- MPXY RPMI mailbox driver for device power service group
- MPXY RPMI mailbox driver for performance service group

Check out the full release log at [1] for more info.

[1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.8

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---

Alistair,

Images are located at:

https://gitlab.com/danielhb/qemu/-/tree/opensbi_v1.8

Thanks!


 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268752 -> 270384 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 273048 -> 275928 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 02be3a72a8..eb63a39e46 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index cce35c65c2..edd60ae528 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index a32a910691..e7fa66c216 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
+Subproject commit e7fa66c2160ec139de1853a00f669c09320a9256
-- 
2.51.1


