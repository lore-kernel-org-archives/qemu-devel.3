Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C376606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pcwqofLB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jaXop/1V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI3i-0008M4-5f; Fri, 23 Oct 2026 12:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI3V-00080U-BE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI3T-0003Bs-Ei
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6rC21492221
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SLURXAXV9LIzQqyUPzZSTy97PEo8fESRCNPoOtbqhcc=; b=pcwqofLBIN4hxdRD
 A6hTXJLwnaMXZWBdc/ZvBSijoLg9ww0FvDerz3oKhnRlnjpKLPAa8Pl5j8h5i1Vp
 m+IRET+9rREGUJwQk9Xy+IgVX8u5iqALtQPaWT4JyUHKuwfzS6nMOcytUPnUpZm/
 nHW9IjS/Shdv7GRc5Yv08XwPKlEPlbumL1/7l6KEwul2MxAtaVme4cEG2anzHsKV
 pJfSYV4izleBaY9avSSHa1z1BuGl9tIFQbruj8LpUutC3ygvHq8NDzBNbrVBS10M
 w5CSF0k4ndCryPSEMm4T0WmsI6QKzZpc3qgHPuI3wSre4IevSxunsmktkLxiU2TM
 0FY2JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmav00h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so309366085a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772618; x=1793377418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SLURXAXV9LIzQqyUPzZSTy97PEo8fESRCNPoOtbqhcc=;
 b=jaXop/1VZvZ4jP/XDiDyGmvyjmDp1BKVv2/Yg2dUQc2RG/lCS0ZZSfKyoUC4BUwZPq
 ibwrPVcSe0Z/sM6tvl3rNVa8VqmIbO0uMMzSDZ25w1i4w5ADiyKQlBBRJpk3LKRPPpvn
 n/CfurvHox7wpKlvjlLJNdMT/0FvsJKUBU4ycR0jMssMQ2hOUJ0TaQoXRCI1mfkgV+b2
 WF62HtY2nwCxwjxxOOB6NkuW7mIrnoVJg47U7vf9FAjaupiMx6b11NcN1xqxRMV7pVom
 4W2FL29WPYWgoUItHLU3Jxyhx8Ahk5tNToyxhjs3UgvG4QNsc8eZQPkvgCSsZa9K02Vz
 5slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772618; x=1793377418;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SLURXAXV9LIzQqyUPzZSTy97PEo8fESRCNPoOtbqhcc=;
 b=FjQS+uWk3Mcdez2ZtpI58T9z5l14DGnIeQJ5fm8eXQGh+dvOIW21YoNh3MujCskR3Z
 72potcWVkcFFe3LZWjREO/Gw/d8t7DYsfSry446+tN3WKTG7lpOgt45yOz8vmm88zraH
 8EHIQVAoXCZl324YsK9GuoFz0x6RwTYdJoEPwyAzirnFu5FjufEz4VMsvZdl4yNOqTzq
 H0I9y2Blu4sb5lSLbf0/SjGl6tPPUbFvLUncpJuUefX8ukZUFUCD9KEmZy5OI2k/UEiH
 fvMMywzA0B5+YWBrEh4W2OjZ5Dqbn18mTk0PAokSKt/WooRn8CD5+JyKhztaoI2OswYx
 d1pw==
X-Gm-Message-State: AFq9FYKMLFKCKtXx6F7C1UMMenoTJN3HB4nelJAp1FglNrPMSYFhQtlH
 ZMe8zxJ1sxm+hNQXGGAS90I2i2qdLpamtQ60u3F/L0j1PEn/js/E4+fLUeLK6g984AczjBxtr2n
 TjgLDoh6FcGcIvtjgkmLibo0JjI2ruYstOWpE5Q+s8cubeLTciKdmA/pnGMZHxFwPuLyy
X-Gm-Gg: AYBFou1QfkY252wX0nA6G7Jr+1/HRgBs9UcONG58Xo+5QrBMYJUCtq044APrWW6klTZ
 PHUOfWiP9zeDNT5FIebnnHr49FDJbz/2Kz/Q2/cZC6XwB5GO7/GIhFe/GvKO6U59jYlEhUNEXbk
 Ig0AiS34Q7GF0SBFmmj+OgjnDsVH9Ghb+xMGZ/afvGE+v/m/NMrILolLTIH8HR4UXiOyTe+f81m
 I9dUek81CW5st1b7SFEo4BkbXCVnudyVqlofwYuDmrvXUzSIQV+ck7+UDcE+m6ycb1YtQQAmzDm
 9l9ME3WuW36UuDD36t7WGux2yVLBhFPwdo+lp9bs1FGyfPq2TzZBFXQSTgF/1BiE+8a4NmvFNpL
 KeVtz1FIXR2uWQhz6XkfTtp4p0ZnewNRHa3DRdiHe
X-Received: by 2002:a05:620a:4712:b0:93e:869c:43e2 with SMTP id
 af79cd13be357-93f6f9a2bcamr507725685a.50.1792772618575; 
 Fri, 23 Oct 2026 09:23:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4712:b0:93e:869c:43e2 with SMTP id
 af79cd13be357-93f6f9a2bcamr507721285a.50.1792772618005; 
 Fri, 23 Oct 2026 09:23:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d413c00sm753157f8f.40.2026.10.23.09.23.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:23:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 83/83] MAINTAINERS: cover riscv GDB XML files
Date: Fri, 23 Oct 2026 18:13:31 +0200
Message-ID: <20261023161332.60153-84-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb8a0b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Ii8euAZ9dv00lu50D7cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX6bNV8Om9gJHa
 XKNwSDWpc+lmG8YNRx2txyVo1KsWShaY9Y6D4bhS1hd5r1mvEJ8knwE124GWRyBcKipG6KAF4vR
 D4y0oG5ZXDdzP7057XxNarZ6G2Ywbp0=
X-Proofpoint-GUID: sWw06dV2giuzBeOH7N42_1SD7Pkzp_5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX1PXVAKK6Ml+s
 H59pfVDXDTTXkQUPUSswbdLN/qFMZkZYBJgvIV2cdEMWJxEeKwr8Um0Zqiv6/0CrMUXILCAiocY
 JsCmXDXfib6PmbQF5rp3tX6dz4gPiuzZ2LXfq1qzna985/InXUCW3SgVAqK/5D4nS/Pzfi4zxPU
 x5ffI5ISAsw4CGcBg7Sr4l+zUqlo1wD9oUNxZukXCar+dmEPCRkRzUk5mWLF/fdY0qjj3+yVu7s
 NSpq9VX9tmqjvxNOhA2ea2YXlsl2nPJ1hlsTdJ/kCiSRE6mw9n+2xN8bs42ykTYSSmGsQTlbTpy
 mD8nCGiHvBZMDKAq9+qWkjgcUjJlAABLpXV9mlTisb/FoP/zRZ5CMRTTW4XjnsrXxbo0flHwlXt
 lQDUxMHX8X1/j9uTWm9J+LBXrnXndua/wuk0z8XREa7bsnYG7f0oDWGJ3Y7WaTR+S7IxXO0S8p3
 n6wFyEYkrp1z7TLdPYQ==
X-Proofpoint-ORIG-GUID: sWw06dV2giuzBeOH7N42_1SD7Pkzp_5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add an entry so changes to these files are routed to the RISC-V
maintainers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022-query-reg-v3-16-7ad902b9a7cf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index de3cb9dcaf2..010539dd358 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -372,6 +372,7 @@ F: configs/targets/riscv*
 F: docs/system/target-riscv.rst
 F: docs/specs/riscv-iommu.rst
 F: target/riscv/
+F: gdbstub/gdb-xml/riscv*.xml
 F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*
-- 
2.55.0


