Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DA606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RbMtKBKU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OvluwmNI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzeu-00012L-Ql; Tue, 24 Nov 2026 18:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeW-0000UC-Fy
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeT-0005A5-St
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:19 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMakar640308
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZcTllCjqii8LmxjvrUAImvIZu9tcprX7igb13fW8lS8=; b=RbMtKBKUwkr9Pw21
 2Xz+N3/zVLwjMEoI7nopHasnZ4mNoMLLM5p+nRCyej/NMLPCGnnjGRj00+YA8Zzi
 ZmUAvJEULFfwF1/sPMQpqBCUKbDM89qu5ii97FZPy9jeqUBzS24eTAiI4w0rfluI
 F/nsveyY+bpDE14xEBQWfyB4iTuega3i7Dx3wo18yqPCcKexhuUheRJBG6CFYuxg
 YxhNI/G+xv36HrNlcEFahC03vndOlCyhHk+2zHMAr8159D1BQNls6w1tWK8VOg21
 R5p3UDQczps8xYISEjAl1wikWs4oloD5EsPkmd7Cllgp3BQqFhIgHdKihfmZaKLv
 JmrKkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5effse4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94967c6d4f4so546906885a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561816; x=1796166616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZcTllCjqii8LmxjvrUAImvIZu9tcprX7igb13fW8lS8=;
 b=OvluwmNI53cxY3dNJmdqNUtv4NdCJmADCQ1IIAED6Z/lQL5FhDp47HXDrmqCp+F5in
 EONi/yzaNnCM0ArVZCo4983ev9ipzxFNVPFE77OHw6FsYAQar3K8xrTFQVPHxW5BrUNS
 bOp80N+Xde6Nq4i4G8GRqdJxAbB5NGImZZyIZ/qtrk4Af7JN3aYDP9wwYMWf8I3tHyCb
 ithE0oQXkZccdj6NEfMfEEGOjU3/pAWXwCv/1suZKrToF97+WqWBFZly9dqeZHNRP+ej
 JiU3dANmi6/hlF4h0I21AmJqZ4B6tXqIv85YoTSd3ahLnvtwgbi6AqyYEbwvXvB05pUi
 wu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561816; x=1796166616;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZcTllCjqii8LmxjvrUAImvIZu9tcprX7igb13fW8lS8=;
 b=0aFeo9sfa1nYpSBxirzedaGqR4OEjb3CNm7NBVQHtDub/hpcrzA4X637Us2Rj3unK7
 YYetL1u5JhEr7nW/Nw7PhCmEUuxV+YurCDLdAvOZHP3AnLVNS9lBTPBimk38WmWKTzmX
 EsP7a56I5v3i8qZepEbEleYj3FQPY0dy5zo5geNs6TDQKXaBmQ9lEnf+D7PpAVN37RwG
 ZtQIKaoYcBGu+5GrJiHxGYw7qQTELvnP/iT1WtXU5riNo+pYpIe7+NtyQLYRd6yC/xq4
 jWwYPanOwS9vEUN2fcFhitv+KGxfApIvWPjHsNSpvk+fQzHarNCs6D+/NkgVHJ1xjDyq
 2rQw==
X-Gm-Message-State: APuU4Z/5NojxC3mQSnZuq/Tr3XMXB8bT5ouov9piWLEvsIRfR8/2taD8
 6Bilh2V0HKYMT89slU4e+RmfHtEW64iUH+WgBrA/E38dtKqKasd3/KLzghmr9E07jFh8UhQ+6ES
 cTydAH32CP6PoH+RmP5aX03SqP9RCUpq2yXB3M85VmJ4eftaVAgyZhx0qcDZjOyLTy+xk
X-Gm-Gg: AZFdTZdCvrLXTaDtfSNRtY+LOLx1u9vhg7KCfmomP2OX0zvJ0GEZrTGzgJ5B2eVr5Ne
 6x1Tg9LCBUV1V3s4NZHBwRXuZEfmoVSbFZ6t01+dxnWBbW9shcjUQg08YUP4Mk2g2jHZZbihpEA
 xvl+YMUNDahFkI1MuubN3XYKu3CWXQBDKUYkl+DVC+Rz5CqHyTy+jKJFCVgsmFNS848P4xC9WMk
 j4hKs5DmkSEwa4qeu8qCQ8Zi56AeX8i7Fp/Cy6cwVc34c2xx3mvNSn+TMN2g6oGCrDb37NH9cp5
 pzeiIGLR+MUNztmklyd9Wz+BOFM8OiamCqBP5lhCbl0VDIFVlj7MPccH0tktXHVBFb2hKNBo1Te
 m6VT0WzvLOwFOwcttBHhebFQcuM8xS60Gndv/C9M1yKP3ZtoFCqmE584fcWS6T8IIiV0U0w4qV9
 OFQvTxJ2lm/2rVJA==
X-Received: by 2002:a05:620a:628b:b0:93f:6f8:9d72 with SMTP id
 af79cd13be357-949bac7c684mr2561603385a.77.1795561816090; 
 Tue, 24 Nov 2026 15:10:16 -0800 (PST)
X-Received: by 2002:a05:620a:628b:b0:93f:6f8:9d72 with SMTP id
 af79cd13be357-949bac7c684mr2561598985a.77.1795561815455; 
 Tue, 24 Nov 2026 15:10:15 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm273608475e9.2.2026.11.24.15.10.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] hw/display/vmware_vga: Zero-initialize scratch space
Date: Wed, 25 Nov 2026 00:09:08 +0100
Message-ID: <20261124230917.88704-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b061958 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=LSjrgreAm0ToU0vYokAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXz4AvTTnfVMS6
 QOD8uEV/NDRz6xBWXT8Qe4dvWqt8o6rjwis5Q0i2QQUxHkgNO050PZchndzBO+fT+T4uQ7Sq3pR
 lfapl8X7L7Nt3O/fWxcU4vWk8D+CLNOs1JnFCOzjIfoUGzca36psUgRWQOu+UiBDPSWoqe+G32B
 sN5tZvtsKfF5a0cHQ2w++jXeF2Cl88YRKyg5sRMO1EN3M9+VeLM7Q2VLUb2ZUftatwjTbxJrgPh
 ISL8pvPHZ7VXTryVZ4WpCThmM3wTpVq/Asd6KTxm+weWpqcWITaHzK99CkrFbOoz1Cdfay8zkKN
 2hZlr6ezKpjqluqCEYlhb44CAsAFU9uJyup8xjo6Yzvh959F9BItnSp/1sbhuQXq1tJHRrxLQqa
 Z1R4MpPKtbj0BnYayq5tuD5qHESKc7Od9RyC7fzOJjb9L+7dvAe9Bv99m1Z03Jv9yuAm9uHSTeX
 CVp/H4yhWK2ljt+n3aw==
X-Proofpoint-GUID: VjZ6Wteo8oKBp-o07MfUwH-GYdqS8TJ9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX5TvIjSWM4dPy
 HIjlJrDUHCfqnBcrj6AERs6nEFM2KuYiZCb5G//mRM1JMwBNjWsN352UU8FH5FkwnPt5q7rcbc2
 Xd1nXX2IjVxZwMYk4QfzPdinwsg0BQw=
X-Proofpoint-ORIG-GUID: VjZ6Wteo8oKBp-o07MfUwH-GYdqS8TJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The vmware_vga device has a set of scratch registers which the guest
can use for anything it likes; we implement these by backing them
with a lump of memory pointed to by s->scratch. However, we allocate
it with g_malloc(), which means they start out with uninitialized
contents. We should zero this memory so that we don't potentially
leak host memory contents to the guest, and so that the guest will
always see deterministic values.

Since s->scratch has type "uint32_t *" and s->scratch_size is its
size in 32-bit words, prefer g_new0() over g_malloc0() for this.

Cc: qemu-stable@nongnu.org
Fixes: d34cab9f49bc3 ("VMware SVGA II emulation, by Andrzej Zaborowski.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4519
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 567806f0e47d..f72896873196 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1256,7 +1256,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                         MemoryRegion *address_space, MemoryRegion *io)
 {
     s->scratch_size = SVGA_SCRATCH_SIZE;
-    s->scratch = g_malloc(s->scratch_size * 4);
+    s->scratch = g_new0(uint32_t, s->scratch_size);
 
     s->vga.con = qemu_graphic_console_create(dev, 0, &vmsvga_ops, s);
 
-- 
2.55.0


