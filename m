Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8E0C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eC-0003RB-GW; Tue, 07 Jul 2026 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5co-0002FG-EN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cl-0000W8-Lm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8fG83606097
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VHOBO/F2WKbk0wb9mL8oQqnc2qCfM3ovTCmXWk4KFxU=; b=BZjBhTZEP4BUfALU
 FnWKwKrJF3Gn69jlwZBpcedmT+JLv6QZViK7liaVRec7NuPi7UN7YDOPy44AFgg5
 94KanzW0/t0NODIKiaqhoenFATvi86xoNJb0GIqXQMW8+GZTtUgg15EPrgt9gL0N
 O1rBV4tMAkSAXfRHi59SGRYY6YR6tMcEDDbrjbEBo8COeC8/AWMy0HXjlr09u0L8
 z56R5KCY/8kBejUWJuh6KAYsof09FHyxNkK1TmXs0JKewjOytp0Cu7r7v2GAP8x8
 +YKIdgFJn1hKKnUWKMT4Zj/HHKWH5CI61bhprEtKD+gg2fuNe5nnuifkuoENHxaQ
 JvB1kg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8j4gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a87ef9713so6690531cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430045; x=1784034845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VHOBO/F2WKbk0wb9mL8oQqnc2qCfM3ovTCmXWk4KFxU=;
 b=NscONb6pYUDMsxy1RvfWXyi43m8cNWIHeNqfwi411SIEXwyVTtL+vxCailPw3ijLDk
 1GEgCU5qQA3MbNLH7fwxxXc+KKS4HU21EYm1vz3yk2AX9kY0u41jTsbN6TpuQsfWb4zd
 8Ns3GCc41kBDof+/SJGk+10TBrZaN8Xe63kK8/Zhb7FbDxWRGrAsuAl/cXVKRLw8agOB
 Z2RGRqWUxI8OWQsGJNkDDJjhom3rPUwtSxRJrHVuUulcCKb0JovyHbjNUhDyFR9mWAmJ
 x3jwECMXTuWXlfEZ0wJrYtR+CE+3rGRjH6LNUKZwftEkwZaRFdjHarCgzvLx0ZA/PoZ+
 /hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430045; x=1784034845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VHOBO/F2WKbk0wb9mL8oQqnc2qCfM3ovTCmXWk4KFxU=;
 b=XSlstO1cOfusTv9ME0SU+jP4LUsJ1szhflu30m3V12jp+ZK7M79K2Mjzd+/mmAjWy+
 2apZZETZgMxDIMWpRvYkirSeiYXd6SrorGaPTevCOQCI57aVwtU+i9BzvmXsFXgNH1wO
 A3Ek82VLgGdKkXN4sd8AlhJ5IAoHb4O24JQaUO/EUE74DtWxMNx1/xWzc4eInWTsXJp3
 Lqz4g5uhdp/4mwRq135zN6Sho2K/oT/ri5b2y7ewMqHMr8vduhLCvIoszApZSpJT17bY
 xleG6pozyPC+CR0B6o7thm2hHzpxTC+fsWmn4mjHCEhWi+MSYWVpv32rDzuhsTIe4ldr
 roaA==
X-Gm-Message-State: AOJu0Yyu3iomKHQubhLVAT14rCUUHQT46zM5+wLnFdUVHcqDTUF6lWx0
 00v5knrKQdOXrwsknqkZNPtD6Bb+zid0elJAZ1/vJyjwiNXTPQ1Y5lC+u2PFhTAODySjXQXQdio
 U2z2JXCY+j9wPyfPKi6OimVNfjc1L4vTHTGGqIGI6BxzZsojuZND8CzzL2uM5nqpXcA==
X-Gm-Gg: AfdE7cn5tod92/yuMoruUe0Cuj+1ZCimcuYMhNZqJpMQPFX2G6Mmr3ki+EbWqa90I1f
 HibpyYy0WarvOv7gYRiYJ8MB3mE01pRaj7w9TmKEyXWDpUTmEgOlXgGLIzOO7SUfledLEfClLkx
 EqYdh3aFfcqmY3nG0padI1Ev8goDsmzZ3mCW7Ov9u7YChNaB6Xx4M9rtMkEIJitOZzwm5RlPko2
 qpLXMkvAJDT+dE3a31CtX/4XuTQsRgIPf2PZjaLUyHdch5kZ//1jJqoEk6OpdO5Ekq6nHW+4hYH
 0o+QYigTCn/CsbbBdX00cPQdgt5AG5KLGd3J9qgNRZowV41vjsUgQiIKh+uvIY9290qUPpcV3J6
 c2PICeNAvqvqZ69efHyEWfGMiwmPpyYpNUiEyOOKA0Vwgy/nfnxSsMN0Sl7yKdYK7WRD0
X-Received: by 2002:a05:622a:6f1a:20b0:51c:7aa7:e0f1 with SMTP id
 d75a77b69052e-51c7aa7e66dmr13275201cf.44.1783430045136; 
 Tue, 07 Jul 2026 06:14:05 -0700 (PDT)
X-Received: by 2002:a05:622a:6f1a:20b0:51c:7aa7:e0f1 with SMTP id
 d75a77b69052e-51c7aa7e66dmr13274841cf.44.1783430044396; 
 Tue, 07 Jul 2026 06:14:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9be41esm137252366b.39.2026.07.07.06.14.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/32] hw/display/qxl: Fix mono cursor validation that can read
 past a cursor chunk
Date: Tue,  7 Jul 2026 15:12:04 +0200
Message-ID: <20260707131223.51505-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX/nr3H4mQEPN9
 eJrPJaeSl5OlDOT8CVv70gG/CXJ5Igx10E8VW15z6mMfT1+dosSBSN9nB/+ZOoR5OxbmdEuskvN
 Rw+sMpDhakXJ8VBf3CtNs+R32hFmHyc0paEiDF5jx0+PBs20HIojQB12nRFwBb+Z9+GiRg4QDb8
 UM8cby7VwV+rVqoYdsmp4qFTssMyf4EXu12QmadTPF+HfCNTpb8BbEqL0d0FPjs80++m+pEAYmm
 2WY2VN/3vrJ7hBbKc00PGLIeKCgfv+YfcQgTQhPExv1tIBJh/m+e2YVFZYBjTKM/w5Rq57pprOm
 Vh3VxatEq8VxegB2JN92PeSfxFLlPffC3Y4YJOPmW/LlchD6fsoTrwTbNDENwNEPeWUvdN1JSgf
 HC/1iEu0Hw1BzajuuaNRbNzaktSmED8zvlurFHyPTiAXYybNF1WiAWu9lTea8LIozwRGMGkBRrc
 DMMpsP4rxzAoAGIsoLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX4ffUcwuYtJVP
 /9UJtyf/vctcnDd/t/sh+LelFjBedmqQnuOxZX3XusPO07TjJW8Uuyrp8ijybhwJe0O8wSBXt9N
 5mMsoPwsCEpaeZHUC+2ExoerGerKUGo=
X-Proofpoint-GUID: 7jMpl-N8Pap92-H_gBLWEI9OGJlII8MS
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cfb9e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=d5zUspqiiaHCGQx4iD8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 7jMpl-N8Pap92-H_gBLWEI9OGJlII8MS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070129
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

qxl_render_cursor() maps the guest-provided QXLCursor object using the
guest-controlled cursor->chunk.data_size.
For a mono cursor, qxl_cursor() then validates the expected bitmap size
against cursor->data_size, but it does not validate that the first chunk
actually contains that many bytes.
A guest could set cursor->data_size to the correct full mono cursor size
while setting cursor->chunk.data_size to zero. In that case, cursor_set_mono()
reads the AND/XOR masks starting at cursor->chunk.data. If the cursor object
is placed at the end of the QXL RAM BAR, those reads cross the mapped RAM
region and could crash the QEMU process (e.g. under ASan).

Fix it by double-checking cursor->chunk.data_size for the correct size.

This patch is based on the suggested changes by the reporter in the bug
ticket.

Reported-by: huntr bubble
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3646
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260630101022.379057-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/qxl-render.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 7b692d5a854..3bf634ee059 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -272,9 +272,11 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
     case SPICE_CURSOR_TYPE_MONO:
         /* Assume that the full cursor is available in a single chunk. */
         size = 2 * cursor_get_mono_bpl(c) * c->height;
-        if (size != cursor->data_size) {
-            fprintf(stderr, "%s: bad monochrome cursor %ux%u with size %u\n",
-                    __func__, c->width, c->height, cursor->data_size);
+        if (size != cursor->data_size || cursor->chunk.data_size < size) {
+            qxl_set_guest_bug(qxl, "%s: bad monochrome cursor %ux%u"
+                              " data_size %u chunk_size %u",
+                              __func__, c->width, c->height,
+                              cursor->data_size, cursor->chunk.data_size);
             goto fail;
         }
         and_mask = cursor->chunk.data;
-- 
2.53.0


