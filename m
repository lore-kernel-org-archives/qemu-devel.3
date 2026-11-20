Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6D606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F+pEWLGQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uc+zviXT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSAS-0002uo-Sd; Fri, 20 Nov 2026 12:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAN-0002rV-Ek
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:12:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAL-0002ia-IV
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:12:51 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfii52947046
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VLr+xD3lcIgvVVDil2eTvpXN1BKFT2tB+eVaYQx5foI=; b=F+pEWLGQfaFOXAB/
 WuPw4D+mqdD+izdWAgVW/8vQ52KVxT/xjTmaZQYlFTED67mStxsDMF4LuKs6Aj6A
 /3/W/kIam0LStdyQS3dWYbAgoB4GKhqASvuoqtDtajNKwL8ddUGfPFJC9/ul+bul
 WNsGacHhzrBOCho7ayZBTkd7lwPAFQZd3The4sbbje5JjjS2wenHhjImfpyqNcox
 GPLVSeY2HAJMI4xafQhK8y5wnmbRpxbTKR7iYGTT2WkSoVkcumUtYOjgSYHY/rYH
 ce67m+cCIN5VO/hJcziez697EVNsHbcNfCO0jLKMOodRhyQlpuS8JcIFprFouWAH
 Mhkiew==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjjaw57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:12:47 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so1019590e0c.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194766; x=1795799566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VLr+xD3lcIgvVVDil2eTvpXN1BKFT2tB+eVaYQx5foI=;
 b=Uc+zviXT9XwU9MARa6+IcSF0hJttMTtm/3w75FkmarVM4ipt4pP0zWZl5lrrqVBQ9b
 GcIeqc72BWqfOvPLzI8tNfpd/D2EcUKBkp4AkK34i+dDYHap2ss0vvfWmsXAo+O/Q+3Z
 6/saLx2ZQADqdYyYlgx+6bdkeFk5SXR0GPaD8yF/uZSbphV6dygVFLiP5l/UA0jC8fvm
 Kpmw20Lz/AHhfDeZJLU3mvyBgL22Z9dCnekkQFtk6cXtW0tZPeKXTdatqeDtJhEOj12c
 lnROKuMC3ijF79cDkR1uCbDZZplcabsDgUIqUKjeU3bwm8jxAauTUFGS1SFjSuxDW6OG
 rtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194766; x=1795799566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLr+xD3lcIgvVVDil2eTvpXN1BKFT2tB+eVaYQx5foI=;
 b=jsUhlFPvB7Nbo4mTu65x/D0/0prjGzIHbx0FgqX9kuCps0jd2SpQJQosfeXMlahF49
 WZPlcnNPJpQZsDkHvEyhwPQA3sJhQ1BHQMkEzvZzlVHGiJQm6KLIkkWjr7Y8wOkVeWFN
 +TIStqUgfEzgVdZJ0uL8Gt6DMLaXTr31XfF+kP87+7LQTtzw/rhO+XxVDUKkc6So2VVI
 wAzvlNaWwPRW/zb8xLZLopOgJiC/xtTbKn6TOt5cZ2sW40AVBELakgywiYYN+jglVzqE
 oIVx29nxWE1RFz0aekyLxjzEJYfdeacFgPL3Yreg4C7HsjwtGA+DYKpgQmhRahdf18Hq
 hbTQ==
X-Gm-Message-State: APuU4Z8ieQ+DiuEMcyoJ7AUuUy3A29QuAs0XHD6jnm786uVi1F0bLVY2
 RZiU962DFuhKPb8RURkM110GYMqvZlbKK2g9QThXIP/XrLmxD4auu4HkWI/4iiOKbOs9xY8edJN
 Yr2QsfY5bjG3MDoPFnu1XDVkNSRr6YLrup+7CiEM8f3nWKED19pfrCN0LJGNYGCgtVA==
X-Gm-Gg: AZFdTZfjrbNIKvnlIZCQZwkVh2QKX/WTA+rOrFRYSJq34iOXA/msEMPlF+2XqP7hK02
 /eufLrY1Nm/5G6NN0NRBL5jpIWHwwGG1JXh0ZZL87K12OCRnKy1gRYXkiApTQ50QYipB1IyMGYa
 OmHQ40y+X+jzjRlQyDyeE596KNGFjn/kUSIk0Ce3KCPK0CC7h89itvke1DmL5juQvlzPXwlfiYi
 /4t5je/88VIs8DCT5EFUyphbSuES9QvG5qsKVwPCNaab6/OSjUrXl4KAB3G3Gn4OG3hhI4S2WiF
 4vLvOtIq/sVmAVRnERVh7YrhcJFPrapm8fHi8cAtm22xbSBSAcsA2cKgvLNDzU5GgC1WQk9FjMz
 hGl/ZXEJ6nuRJj0rABp9Y2FzVWzX2wGcesoFBMCAxewLSzGVsM2kccag3omhsW1V00nIsJXsRVS
 v8TtIHm0PDtJCLYA==
X-Received: by 2002:a05:6122:32c6:b0:5ec:c180:e1a1 with SMTP id
 71dfb90a1353d-5ee8adf3300mr2539583e0c.2.1795194765766; 
 Fri, 20 Nov 2026 09:12:45 -0800 (PST)
X-Received: by 2002:a05:6122:32c6:b0:5ec:c180:e1a1 with SMTP id
 71dfb90a1353d-5ee8adf3300mr2539564e0c.2.1795194765296; 
 Fri, 20 Nov 2026 09:12:45 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm103835075e9.15.2026.11.20.09.12.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:12:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2 v4 01/14] hw/scsi/ncr53c710: Cancel the in-flight
 request on soft reset
Date: Fri, 20 Nov 2026 18:12:21 +0100
Message-ID: <20261120171235.61325-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b007f8f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=evIlfggg4VWQIB3UXMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX5930hcYynTKy
 wcJ2tgBsWN3qRNmK8eqcLoDRoRCve/2HAKp+zn9yW6cytnkC5ywf+yj8cF/b7w0S1Rvg81vsRw0
 wUNmX3s74subLbrznYwem28bBOMHm/Q=
X-Proofpoint-ORIG-GUID: s8ZX3lbHwD0z0RSaviNGxTzw5nMxcEnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX3BVjwtfQCIYv
 Lq26TD1fWQJGe5gGb+u8t2nQa11Aq5QIYPezBnx+Y0EoTplcp6iptawFqaOmH3ts58/qZtOKu8s
 91wQWwneA6sibD97mfbKlJJ4Yqn4J2jM2Hh0FlqvRjqfLuY9nlEa1YUgZWwD1scn165khEGoB84
 Fryu7y3LNrY8I/8oY7Fj9uz/ZKg1pwa3kzmFG1dSSmQtXDAfKhzKu4Ke32HlmbsNsK0qG5MeZXP
 eIkff4GzXpYKMPCkJ1S4oBQZyOCwB8M9vuTnNphRpqXUORJMph00a/uGQLcRj+UiG5EeGfIEGrO
 Zy+CIWrAU2bJga+xVcOXhD+/YxWWsz4yFH3M5O2U88EcyLQT2hOp06ZFHdx951KlCXPFcWB53Et
 VD8ICzTFgjtYgkxwJRIQvxFaLGqkKW9B7xMCg6pDLlxx4+4nIZKE+atbPiFTK8jgnR3BjM+20lo
 FIYH+zFnKPntJu45DVA==
X-Proofpoint-GUID: s8ZX3lbHwD0z0RSaviNGxTzw5nMxcEnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200068
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

ncr710_soft_reset() drops s->current and clears the request's
hba_private without telling the SCSI layer. The request stays queued on
the device and, once it completes or asks for data, the HBA callbacks
find a NULL hba_private (ncr710_transfer_data() asserts on it).

Cancel the request first. scsi_req_cancel() invokes
ncr710_request_cancelled(), which releases the NCR710Request and the
HBA's reference on the request; ncr710_clear_pending_irq() then finds
s->current already NULL and has nothing left to do. If the request is
not enqueued, scsi_req_cancel() does nothing and the previous behaviour
is kept.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84f0..10daa66e840d 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -364,6 +364,10 @@ void ncr710_soft_reset(NCR710State *s)
     s->sidl = 0;
     s->sfbr = 0;
     qemu_set_irq(s->irq, 0);
+    if (s->current && s->current->req) {
+        /* Drops hba_private via ncr710_request_cancelled() */
+        scsi_req_cancel(s->current->req);
+    }
     ncr710_clear_pending_irq(s);
     ncr710_scsi_fifo_init(&s->scsi_fifo);
 }
-- 
2.55.0


