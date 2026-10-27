Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C26606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WIFZ5MQy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b/n6Rcp4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrL-0004cg-Rr; Tue, 27 Oct 2026 15:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrF-00044m-T3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrE-0002RG-8a
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPnU2997794
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7lg+o0kA/rhimQBx5HVSu3kWS7Q/Ap7h7SVIDwWUOrI=; b=WIFZ5MQyqFmK/CHG
 YlHaAfYHwyRoQVjuAU+wvca/LGSaU/8VV+fYVbtjTY5cd1G+imlqPaMCyLHxT0q8
 IbPdVS7W5mfQCE0R3wnUjLz5mwMR0tqVxHzy8DWGDwpWju9X6EOwM64j8eBMCt6X
 TKOfFDLBVwQyCXQQPK+PWC3K5UBsYayVaEyGUwPEEZq8XtgN2S69RVCv1rP2YH3M
 gvMAxardaY0u0T6AeBBlU2Y2ntYwtDYWD93+WlTff3ayR6qi1Qtm5f6o+ioS7gTg
 VbW3fxm+uokTm51RxCSk+rLdD1ukjEVf6MVMzrIoOTqsJbofO5WzwpbC8sYfuglK
 nBNTBg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1jcth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f559420f3so14092385a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129352; x=1793734152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lg+o0kA/rhimQBx5HVSu3kWS7Q/Ap7h7SVIDwWUOrI=;
 b=b/n6Rcp4tOQnIan3mrBYrOUp73DicL3Z2/8W9s7SrA7y92g/GwS84IKHPubo4AryB6
 khR4b6WW+4l8zdhNnDHLCYNphaWtlnB8mjq34RHKKSE+k6dS6ZbFs03AWS9mv0f2m9oD
 rOBQ0bG1X1amWRDZQlpgyfj4RflgTqKOIrf+ynLN+indPi8jwECPe09I3zW5R7WUncIF
 P7WU4Da97FavY88lSZi9qMybNINtogplx8Vu+q4cug3AdjzbfMmqzbWNx1tyyAEh3BWh
 1JDVkkHN8SuSe3T6rIOBquzOA51jCzJ0Co6z0d9PQCkuipI1Vz4mmYP+2wjRehsZTTKr
 jvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129352; x=1793734152;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7lg+o0kA/rhimQBx5HVSu3kWS7Q/Ap7h7SVIDwWUOrI=;
 b=Uloca3hZUEefx6kds+tXVGi8aZ0LyOlJWVTdFsN3/6rImGd0GeAzpToNsAzys95D/Q
 utdfAJt3kqjx8Ck8xIzNVf8VDZ8EM6hSSd0jaJCWTeWor+Gk+os/A9erQzAAJqIfUJKr
 HIHaitIWvHNwKWlMB1k1P3QwDwjZZnhdxDEUlCsqhJMrTa8N0xAQg0nXoip3hiX9W6uy
 ROReCcAkCqBC09dbsb+Go+j09JWV3USKoDTn257xqpAvbbz29TE77RpsUu/TRoatqRKV
 M/1bv1+c6sXZSwELe/Mh0e3Q4glSjGYVAoKXXpk+goZpH13pNjI2TtCK/C1QvHlg7pJZ
 tG+A==
X-Gm-Message-State: AFq9FYITK22mGUGwDjV/MTNXQsepSYdeOcwUme2FnCDQn85eT54hR8Fv
 WarEXV30z/FIZT3MgvGGROhObo4nfNWkNBHpPm9uVrmPjrnGbDkmUvyj4egjmZQ8jd/Ou4X+0rZ
 PFcCVWWX8olE0YRw9vHarDGYCbRIVgyLqzkX0Y0H/JaUN5BeYjyzWc8EKuHgc5Ut96g==
X-Gm-Gg: AYBFou3qq3XTMafwjf+n9FF9/dC+IUU/lWp0G/pMm118Wn0vRXMnit8dOZj54NIzSqE
 EwD10Gqzpw6SR68ZqvR5Ulu+XUhW5SMhQ8k7xIo47+UtiXPiE5KRe/yQuoDCCZFnoFNz85NLCPE
 i3Jaiio/ZlCtjIeD/W7v8GbGnd2CGHLrrRR/rdUc/B7Fed5j8KFqp78h5VWGCz2pGBjvtDDohmb
 zw4LRHBrBxC0lTqoy9VYwZ2YFEH5/VzQbWiGKlSh0AR9QYACN3TU5OtceQ2z5piGN+2SZys/xDm
 cCoTe41o9CQnADJFVxhgT8Rb1eu2C8NzcLs2cS3mX5/whXZ397lfDwcliBKUf5h07UMlm1zzS3/
 YvTCWcOeVvPGEYZWT6kwijsSsDa7vYLXPAiqoLbvM/IqyVJz/3AXGbHNz
X-Received: by 2002:a05:620a:4725:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-940ef9140e5mr1773918685a.28.1793129352097; 
 Tue, 27 Oct 2026 12:29:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-940ef9140e5mr1773914085a.28.1793129351432; 
 Tue, 27 Oct 2026 12:29:11 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm24758527f8f.1.2026.10.27.12.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/59] hw/char/sh_serial: fix RDF flag clear on FIFO reset
Date: Tue, 27 Oct 2026 20:23:29 +0100
Message-ID: <20261027192341.9197-49-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0fb89 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=YEB5RgzmAAAA:8 a=EUspDBNiAAAA:8
 a=BwcDH0jRu0kHEOYv7QEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 9EKliPLyhc-7-_Lr5e-9v62DikGh2rdW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxWJGoiwxDz5g
 22u2QsxCzuMTOaFGOcdL1NZCawGDLON0mmGlQYnYo2SNjw7m7aB6YUu4ff+3CvwhYtJzlxIMou9
 Jf8BHoVOwK6uy9PAGs1RGa5uQH2Qh/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX9ko+OQk9hVn4
 M+vm94BojcDqDyu0+CJE5X5iw+w5W+h7hUIzI2Yq3bBHAljjyPVtRwCWTR6Si96WUDu0zQuCrOo
 ONoS48Aa2U2K8QQAr6PbOMmWpuO5kcVtiK+THs3UMhpQSE0dqbOtHdwDEYyxAy3zLKoOSoM8ZSE
 8rWqJRNxsftY3FukrhEGjhi9yyjRBGCDkU2aXxDFvA9kWW/2yCt3f2BvPYmRg5mUJ3hz9Bh1xPa
 oulLoPwcYPQo+zco6Nq1rNGZ/NfIk937ifwzS2WrNQVksmMqn7xO4HA6KlnC9Yc7UlUlYOqhSyY
 IHoqXmsheAYIVVcKaGfoO+GnpBIKt58DyDV2J5xKL591iYEYLmrR7sfe5ZIwmwkbeJLSGd4ed8z
 /PdIo/DCTYgPtlERGaj4dJYVyV96RaW6XWl99q6jD+R9FYxsVCCglm/pJ7KJXxKh+seoNCO0BkG
 4wN7x8KunqTnCXAZRGw==
X-Proofpoint-GUID: 9EKliPLyhc-7-_Lr5e-9v62DikGh2rdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
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

The FCR write handler cleared bit 1 of the status register (sr) instead
of the SH_SERIAL_FLAG_RDF flag in the flags field. This meant the
"receive data full" condition was never actually cleared when the guest
reset the FIFO.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 63242a007a18 ("SH4: Serial controller improvement")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20261004-issue-4560-v1-36-ccbef537cbeb@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/char/sh_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 10f96e3a44bc..30a22ea2d1c0 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -175,7 +175,7 @@ static void sh_serial_write(void *opaque, hwaddr offs,
             }
             if (val & (1 << 1)) {
                 sh_serial_clear_fifo(s);
-                s->sr &= ~(1 << 1);
+                s->flags &= ~SH_SERIAL_FLAG_RDF;
             }
 
             return;
-- 
2.55.0


