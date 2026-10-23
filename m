Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YOlHp/Cl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OV5TsVF6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI3d-00082q-4d; Fri, 23 Oct 2026 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI3D-0007ry-S8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI3C-0003Al-Bk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6C5v2215802
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 03j8g5aUIgadKLzv4Szplf3KH1eWTKQPWnvbYhYyolk=; b=YOlHp/ClaHzZqELu
 dlIoKm9x3jvhwcxfPyOXXl6L5eydNckBIFmoaX0j3CB0/ljXdLnjIE9KRBahs86x
 PkDMSf64tJdE9tnePgMH9V90oepCTd6htY7CejWCG9S0zfxxrzxI0tDRrcCI5ZvM
 qzZXxCv7NLQRJWknjqpYteYNATjBAApJLIOhrwxvmgl+ITnz2KpoiEWn5Z43/v4c
 Xjsc9B330iQjw71zSk0+eI1dz+9xs86NWkBK+s2aIswW/L0d69jdx70SewgWpwkD
 Xt1xRFSyKlb9qwp4prFvy9r1T+6zypKEVSdVBafGlJZA0aqUTqr4o1Kq0gZwG3VA
 6xLuuQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc822t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso140600885a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772604; x=1793377404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03j8g5aUIgadKLzv4Szplf3KH1eWTKQPWnvbYhYyolk=;
 b=OV5TsVF6gTTXIYOBh01s8w6nGIR+e4yWEw5m5Dn0i53nzE3XkXOysKk13FspdWWuye
 Gu/Q80Zy2RNYKHlGhec/z5/rKPEgLsKI4wq6FiYgc10bZ9gb/ZQ8EhjficPHAdTwy/O9
 kBmAYKY6PLQ+fzASnSxSvmgErWRmwnxD0+a++rxXo/WEGvMB1WYW9PUMH1VDKnRos1Xg
 65CbZtCaQFM0R1yVV0eJ86jY0xiqi5IgACwuAHX8kGs6mNYivB0Zt5/Tyu0jTv5fhXM+
 MUKMmhPcimeDzPdoa4JbXhqyAKHNYMrrnvycbPR+f8pu+0ut89Jz8uM4a6Gi+SWHWp3r
 c+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772604; x=1793377404;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=03j8g5aUIgadKLzv4Szplf3KH1eWTKQPWnvbYhYyolk=;
 b=W95hoSLAaOV6QjRJw49kLOKq3zhD2DVFQNHLj4sgihcwvnxGlFkFnWM5wzoc+aYl3K
 VXmiHnCfrdfTBwAUu4yN9anzNdHMZEhH0CtnBiLFvHwcBNyNv11/ItngIYUbdXRukxNz
 KqgDrArwihfVK6mwczsgWsNbOO1bJwqNLRDaW68vjBE5CoRk7pVPXKiIIFbDSN3+HdDs
 czV9CGXSYlsCbCBv0ph4WKXLqXriL8JMFy4h+Pd995wmj1t5dRDS4EcIJJjLMNbiPwxC
 12LYgjUNSWxWL26sBUkNidULpGCUnRb/aX4veJS8QRlRbdi6fUYi5rAEVlQwH4+yt3I0
 IjDQ==
X-Gm-Message-State: AFq9FYL3KfD9XcMMYJm/n+nRN5jg1Hs+Nx/LFhUSZCM99iBGZHuKwLyh
 FB/lJsFltOpSIUG/b0NNnKkh7PPfeVoUB2DMfxNsWyRJ7EvlS2MGn7x0UKYWhMRy/Ea9PGBjx/c
 UcYng9X7fwjtdLlruu2C2T8NHwf2wvyemao7F1jAi2o/9CEGjgiT/kXyZVjLPu75DE8LB
X-Gm-Gg: AYBFou2oXHq9fSEdbra15yjVMFPcSGD0MuA7QNyg6xQnDtBsL791cXLVL3040+kBkow
 +4+2MyaI3b2uxw9YaD5fXgVMukNmwvy5+U6UfBpaNB92iTHnMcr5fZGImEpxdUGeP8C/uEnJIg2
 FnmBkSSU/p6LBQLr+UufYqJv3gpXno2x5m77UavTn63FKB36c6gooXWt71skIS+Fuhe+to5zKP/
 BOSJL+oouM2k20qnS8bzAU4OrwCKIj+ch8V0S3tHuXa9XLteNhzdCo8O7m3kXo5/ZPUSSCaHU8P
 hKJkQ6jnXsKLWR65KUdEi5sKtGeTgCgqVmotxYSwzvPKSXgurKwqBkd2qnR4IiUPE5teSVQQjki
 sVSntPqsuRh1rf7SfWZ8QuIg2+k90tcogqGsGn8EV
X-Received: by 2002:a05:620a:6c0d:b0:93c:7f48:8f46 with SMTP id
 af79cd13be357-93f6f79b469mr475484685a.4.1792772604405; 
 Fri, 23 Oct 2026 09:23:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6c0d:b0:93c:7f48:8f46 with SMTP id
 af79cd13be357-93f6f79b469mr475478985a.4.1792772603735; 
 Fri, 23 Oct 2026 09:23:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42b275sm934215f8f.55.2026.10.23.09.23.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:23:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 81/83] MAINTAINERS: cover m68k GDB XML files
Date: Fri, 23 Oct 2026 18:13:29 +0200
Message-ID: <20261023161332.60153-82-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX9/c9mQelel9y
 Br3h8rvbhR314ELeDuyMRJ6p2d3ZYxEh2FfL8UCaAHYnesdu2zKjlm7OFErYpkmn5j9QivIzDAR
 yL7SgGgYHsJGgJVW/WVTBByQNVjqaXaez1MJQKNiOX6IR9clSvaWbab8uIzx5Q59Kcj6Ox/cRSU
 /KXF6PNNjoPKHTZ9V+XcXS2vmyLilBSNssk58I63YZjPmDnIezCpOOhgU1ZxwhVJ/mDq0z3bbRK
 jErWvQoQKkKBUMcWLW6/wkgS5iDXLOV1niNPm08yXH8/DGbBFxRwenevIfM5jk+OCIDUQFt61Iv
 KFdUOD/dbQcjiJLE4WHt5/XdZgf4Me0eeBu0sIE2NdgdS+ZOaHfAD2UEGxH+4FyEaJNrULXoyeh
 CSXxMc0J+MJA27RriItTkss+LkQaFQbHtSOf1rfh7yzvzqXMMLCpLsWLFjvWrS3d9W27tA2zszC
 SKEX/pB3xSzLnGMGLtw==
X-Proofpoint-GUID: wb-aeRs_-KwDeN3LuTSRBOKT8uLjS03n
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb89fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=cplnpDx6AAAA:8 a=IoNqaDBMnLll6KUDmakA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=bHwCOBSOUrNypjIvOSWD:22
X-Proofpoint-ORIG-GUID: wb-aeRs_-KwDeN3LuTSRBOKT8uLjS03n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX3I8bVHLDRaHI
 FhK5rxKLX0mut4tulQysh8D90Ad7995UPCN9U0QvlhT5VzDouhEnns7qVuf+bfeEE+oT8RJJ3RY
 wW5P5at7nHESLbuPpAxKoSySut5oDjA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add entries so changes to these files are routed to the m68k
maintainers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022-query-reg-v3-12-7ad902b9a7cf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f0..b09c54f9ee0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -302,6 +302,8 @@ M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: target/m68k/
 F: disas/m68k.c
+F: gdbstub/gdb-xml/cf*.xml
+F: gdbstub/gdb-xml/m68k*.xml
 F: tests/functional/m68k/meson.build
 F: tests/tcg/m68k/
 
-- 
2.55.0


