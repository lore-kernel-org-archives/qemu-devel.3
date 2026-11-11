Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AF606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L0iGLQI8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jvsBtLdi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5NS-0001TV-JX; Wed, 11 Nov 2026 05:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xR5NQ-0001SH-Jk
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:16:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xR5NO-0001X3-Tz
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:16:24 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KNkS3958975
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4SQZ08Riw4thrARiVzKi58ZhC4xqL2KEq1q
 2H249rEA=; b=L0iGLQI8/6/BD7n4zw8guW7lopJbOiHXdyzZnA90tpgJHtjPpEj
 ByDRl7LKH8CAlyYEs1NuM8diurcnUOFseJu9TgYjpybKkkDzQei9Ye5hYLjp+3OB
 Ei1kFjaIRlY7+35EdUCjzOxL0bid4aVdjmBNj2rY9Go4pnLyK3JZj3XIsg6laGq3
 yjMEkFGGRILdRStJHykW1EkKNLiThAV8RuFHngSHzj/7be+Q4f7NVmI3wTxgYDO2
 t1kXP7vM2bnVQMvq4ALHTND1Q+WiauQpMPW0RuWFm8iIq44h3IklK0BThigySZK5
 2QBuaG1BgWcqTABG2slW95i4wCucrCV1tlw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b332u7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:16:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so6246455eec.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794392178; x=1794996978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4SQZ08Riw4thrARiVzKi58ZhC4xqL2KEq1q2H249rEA=;
 b=jvsBtLdihZ+DtOJuOD54zV7XVhhm3KhhwyUKuANYmgb+J83hUxJPim8PjzWUp+PE/f
 gbOjdRgPbTOmZ6ySA0NVn59xaZJ+jelcg6d1zBOgixbxQiiKqlhS/AdsPiYbXMFqoyNx
 3lmR/DUmaOwWLiJXwnoXMsPAycrXJRTGAKWTyZD6SoGy57kMd7iVVevxAgXMb0e7Re9j
 oa8Nq20zGagurevNk60zp6dem+qywfAD/E3llaNE09nmbuliL0Xn8LgC2XSn3SErEMUP
 bbHeGEgJ8blmqmneoLJ8UcKbYJ+lL3Xv1a5nsEPchCr9VYv/pBsnj1OjbVH/V8EGlaNm
 a+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392178; x=1794996978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4SQZ08Riw4thrARiVzKi58ZhC4xqL2KEq1q2H249rEA=;
 b=o81C5TOpIMv0QvI1tGkCXDOGEv0c1MIhf0Bg2/dWUzSu/duBXo0CPBxV9yRYSKgc0f
 KHgt7OlSG25e/94/6v+Hxf9rQZGHm2Na4hKScvP+z87bEM11xG0+Uu6MflQTJlDLtGi8
 GC4pjZHRsOMBTrmHttJ4XEMrbjjC69TAMOHVJJbzRJ8CEfPbLdL9mAwn7keidbBnMA86
 mSGTX/axrV28xrygcFdEQkipq/HhJbBuWnm4hEkH1xPn+tp5Q6cktLh6tmTBU5Uc2Y0C
 PPYCj5YTMBW88q9JzZkPM0VWeElyOW6w0mnsqTpglN/N2jzNxHddBo9wcmBKTTvzHCA4
 HdPg==
X-Forwarded-Encrypted: i=1;
 AL+hErH1HF+AO1c0SY+yA2LO77Uld1aCsHtGuP1c9Z/mIPwLp6pUrsRv0uKM1dn2M7UpOKXmIUqS2CWG7oEz@nongnu.org
X-Gm-Message-State: APuU4Z9dgLWiZir51GmYkabdd6lUb+k0HeoFSWE4W+wEFcC/fsx2No4t
 Gti+P6+Ogn2pACnUoR8Ft4Lc2cZ4Oi/9x6x8+anV71c0Y5Er4qiY4n4gmNGQ3R4qwcgRf4Wfo22
 OIRndMZpmYAxoyz72YkLSLijB06HcxDZ3TtzSetE4wLeBYlB5xX2n80KzDQ==
X-Gm-Gg: AYBFou3tgTvp80vdZ/Iax+1+Dg+h53ngGj7coVSfGMfl4hq8E+U4Q+tqTAwdaj8+a28
 ZjaHCVvdQBAQXIK2B9RzPqpWhR1F30YxgOW2iJkUwLG2wVe9k8c5S0GeZkgLZhEh4z/TwU9CtzG
 sgky+bwPbohtNRQR27uuWc2Rpno+O0DWGbL90Zf6VtPZvBk6pAASKE6co2GT+ohf9i9lOIMiEvs
 ZsXEISEY+B1TM6nSBrS8J7IJuoaftI3Gimvr+PwL/urn2W24bBe+02RmLuhz9bvBRSS6+vD5RSd
 L49Uj/9QhwPuVYD4x40Gp4eyviS8biwyS1zVFcJbZiSgOlLoyJaRVvooTQwHa7iQYomhLsU1uf8
 BK5VopFK8EYpghwiH1QaXx5UoMvn3fBsf3bNlEL5q0WdxPaHN86QBfPuam5041jLniUeHNsiEwp
 KD4nZOW6mw6n9v7Nmn1/CtULXxwlp9vEc1RnXduHxUuFl0CApI+jSINeMQzKYY+g==
X-Received: by 2002:a05:7300:1486:b0:376:feb:2df3 with SMTP id
 5a478bee46e88-376861801e9mr3637329eec.20.1794392178254; 
 Wed, 11 Nov 2026 02:16:18 -0800 (PST)
X-Received: by 2002:a05:7300:1486:b0:376:feb:2df3 with SMTP id
 5a478bee46e88-376861801e9mr3637286eec.20.1794392177498; 
 Wed, 11 Nov 2026 02:16:17 -0800 (PST)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e76e2sm16222559eec.24.2026.11.11.02.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:16:17 -0800 (PST)
From: Sunil V L <sunilvl@oss.qualcomm.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH for-11.2] hw/riscv/server_platform_ref: Fix mtimer frequency
Date: Wed, 11 Nov 2026 15:46:09 +0530
Message-ID: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af44073 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=mxqZULYFSzO9YBsGqBwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MCBTYWx0ZWRfXxHPvR+JsC54D
 /S/gqk7oknco3oBDvTslniL5i0bNTR9nywBF1PWwIWDbPurieggX8eo8ONMVVBRiKLnx3onSWgZ
 txFKPPQDnmr3NBWpol3KvUmZl/PGl+3383/fJcKWar2XPKl8/6rvW1fxqKvnYQM/V8wbUaxlpY0
 G7iaVmEYdnqaCtJ8MawaZ5PWwByEmY8yl/CGTYrZMwisBJn/Rt4aaCPjcAW9OWQFSNRXDv6ar7w
 Tw6J5NckK7VxbMkF4ZfQrPq3IUVk5rLrQEGbn8KcHFSs1zA2QQzuQLHhNPiS7OVTaEtRap3KAOl
 sSrFWoPn73/um453ZBG+VD1QLZndLo929dvW0+qMsmd6GhZNHolnuQCi3nB/qUdX7DAJbIvHKKi
 kftRry6lQ27Aj58BcHTdXc4IoRX/LDmOuxNaSMtapLnRDkb6mxzH+Seo/c3oCBgcuE8i7t0FvQe
 nP1F4GD/CIzENNHMsOA==
X-Proofpoint-GUID: IFtNF-lO93UD3EhwYz89kclz9x_9bIez
X-Proofpoint-ORIG-GUID: IFtNF-lO93UD3EhwYz89kclz9x_9bIez
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MCBTYWx0ZWRfX6iAdQ8WExBke
 eu5RnkjosRYSo0lx9s7GK9ytWaWcsRftJU0ZRry9e8JmyB1d7QZvX4/B0Tt+dhkoeVUa2zogkYe
 22+ZyGcZqrGiyL/jqQ8oc+MYgetzgvY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunilvl@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RISC-V server reference platform requires a 1 GHz timer frequency.
Although the timer frequency is advertised as 1 GHz in the device tree,
the mtimer device is still created with a 10 MHz frequency. This mismatch
causes the OS to boot very slowly.

Use the correct 1 GHz frequency when creating the mtimer device.

Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 hw/riscv/server_platform_ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5f485b1c79cb..fec967f708c2 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -556,7 +556,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
                 base_hartid, hart_count,
                 RISCV_ACLINT_DEFAULT_MTIMECMP,
                 RISCV_ACLINT_DEFAULT_MTIME,
-                RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+                RVSERVER_ACLINT_TIMEBASE_FREQ, true);
 
         /* Per-socket interrupt controller */
         s->irqchip[i] = riscv_create_aia(system_memory, true, s->aia_guests,
-- 
2.43.0


