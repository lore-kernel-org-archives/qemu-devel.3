Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BFBC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiwE-0003zc-Qv; Tue, 14 Jul 2026 15:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiw4-0003nC-Qv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiw2-0005Cb-DE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwLY71448735
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f4An/Dp9OU7pX+6O4ECxohaQMbV12/YnIUigvwhU7RA=; b=fHRKOWIU8lMDxQWv
 OfEcwHVHr7llg/+by5DIgTKOCU7D3/P8oFfr9TMw+qRyVmnEZOb44AmqkCGkook0
 IYnGtdny12sGR3njaRArSCmlb9eq8e2rjUx+PlsxRjHSD424gmIPjR+2m70dx18J
 +FNVRgvcRgG64diON6BXtndnZ4ONmuav9ukNTeXH5CXnf6Kmv4z/NoKH+yaz+iLi
 6GNgQKpLJTgjxUeagpWxng0iN1n/L9f4mRCKC/5W9QdP4obpewQwOfPH0yyWOQj3
 tYEdroQ5itSqEfUwQkEoKUZL4PgzEMVhPmBqZg2/edTnt+1x8mkIbEhM7AtvVb3w
 BC+d5g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9hrg1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c083f1818so22004621cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057812; x=1784662612; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f4An/Dp9OU7pX+6O4ECxohaQMbV12/YnIUigvwhU7RA=;
 b=RF48lNxYq+/6JR7J1imfCycxATKLsFSdczjSf/FMkotPC5et44OH/sAyHjS/Zad7yo
 dmk/+ha1CoDaoDmcX/MtcquLtmljCq4IxSRQVM4BWfbMqr7cuQ2W7s8CdkQwqzJcxX/F
 VBm3P7wxYaAVFGvtl+z5xTX2v9ZR0N9EQ3ksB6KXQP5PtSgVGK9Fqm0kUt9x06vhpEwt
 DBWL2TieWvANPaHtN1V7zCJ6mcJi5TtWefeEXFcB05s5fdHghzR+5HqOTuEJGrGGrES0
 bR6J9jF6UIsBmoSrEwniOtdd8//lqhk2sLDJnE4kQxxXeHHKy7zfVqr+OTFrWHSqmc+A
 lFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057812; x=1784662612;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f4An/Dp9OU7pX+6O4ECxohaQMbV12/YnIUigvwhU7RA=;
 b=LGYsjA+6XSulOqaOhB3CewFgF8Mawvb5IdXN92I1llgAuiBUkhKyNF3NvKVkHk7Eq0
 TR71oMtbZPlBfEs+OC+5cbyQLxxf3d6lNpA0kBXC/fmkugPFz2oefrNBQt8/mxF8vLgJ
 rIEb4trH7nh7416m1bThUPfULQ1FWVDKwvkV1w9kp4X7pMwSGI3o5pAB13Yt7GuUhxFq
 K3wJD+5xDjlzUlKuOtpCYpuaZs0/XFgWHQzbFWQE2pDafFUYktFDXjSUM+uNQhZk5RCk
 b7wp0troJEyCOwzXBy5RmpZQ32wEl7udcmS7oIFeLqSXDEbuQVuY2bSnXu2DMXIS0pGo
 adGQ==
X-Gm-Message-State: AOJu0YxTd+ixHQQuV3AWXu+2ktbuZhJCLlawhMRTKICYuUS/FRaU1xaA
 tgfjXPpJEd7EZGG7sUZywdUo1kEHjzA6HDdG3T/Q9XTYXztXViUnnhfsBKZJwYLdSTnz7ItKTLY
 zSbVBPYESP/kPLZOqz3Inxk1rlQu1VsdMhQ5q2X8F8ffmFtii7AlMgH0WgmjsRF886w==
X-Gm-Gg: AfdE7clLChqPQj1K8hJkMszZApNn35HRmN7o10Wq7Phd+u+NeQ5CmJZbfkJor1dZBxU
 Be8Ab4i+9SWu/CMiBrpEzFEEs0hML44rIN3gfiHTDr/kGB7wRfIXMiWWfSTukfEWA3MwoVJJGjQ
 C0+NGyoZ1Zv4JuCPqExC687IYrtXOiDGBg882RSfRFHtD4ZTfzLxOplygPRMwpFaA7K6oerHUom
 J/Kj/4y8tiaG4xfqRgxc8rUsl2fcuoBODJQLAYOmrAqKmkT5WZrz3wCuyyHJHbxepGgoc5km9Pe
 y0+L6OK8fUXzNuNo4+rmVK4YzzjOqd+bxiQxxa6KDtFfj9hvkKPQb5ZYGTB7R7DN3G0PZzjF1Zu
 VbXJqqE/LC9dm3od3cS056uvR+5NsPLyd4GhutcGCw3HRRGwDm8uIr8UkYaUBbY2mCGBC
X-Received: by 2002:a05:622a:144b:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-51cbf1ecac8mr145768801cf.25.1784057812163; 
 Tue, 14 Jul 2026 12:36:52 -0700 (PDT)
X-Received: by 2002:a05:622a:144b:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-51cbf1ecac8mr145767471cf.25.1784057809819; 
 Tue, 14 Jul 2026 12:36:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a63esm11016221f8f.9.2026.07.14.12.36.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] hw/usb/hcd-xhci: Use qemu_log_mask() instead of
 fprintf() statement
Date: Tue, 14 Jul 2026 21:35:16 +0200
Message-ID: <20260714193517.60708-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ib+3n2qa c=1 sm=1 tr=0 ts=6a568fd5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=L-Nf6EnhhdU0iNhclOQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PLK1TjKAwH5YwMiyZaYAdik-gJCIsCpB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX5xtBvqQdK9XN
 NWms6ShYmPJXpjm+fDACU40wrMk5T8zqDhabaUghoGJ2mYTlMviDFbafKbIOOLchoA+HYTaCSKX
 M1Lj+G/0elJ4mmcPEPRLzl1f3DzVdaY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX4y4rFDopBk2U
 b3zuyfzJMgQWrCJzLYFAM0oK1Z6uocCkQP97X2xwl44M6hkpVlqZA5cGw0Y+7fy+dCiQDEBErHi
 6W+BfpgerQjpHfKPmp7TllpOxD0vW82r4YABuWN0EAX2HFyrdA9kKxAs+pByGT2BIv/+2aRE8Uy
 4JlZBsYaiSmBTJl1C0ziKMODAqPcPci9QNxP39iSQB0o3QPa8QuZxQB29vimO3NMm3LsDXn4EhB
 +QOjjnOahpznw1Ug+jU+XLSmJD8DqH/fMmU3lZXbbACGasxRE7FMoDdetwN1IYaKQmRyZS3vC2Q
 SOAafcUpNYZI69HvsYrsz1KCu7a5Jr2+Egm/ZHYuNYvIjm8GKbt653BjV3dMm8Nk/QM8ZK3+dFF
 FrCqk44ha4DWy/jbF0tHWxerxD63IeKbDtHE0alYTK+bL9Cgh2pNRKbYhod5nI2ZpROqCKhM7X4
 5OUW5eijm0twqHi4zyA==
X-Proofpoint-GUID: PLK1TjKAwH5YwMiyZaYAdik-gJCIsCpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140202
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

We've got a proper way for logging unimplemented hardware features,
so use qemu_log_mask() instead of the fprintf() here now.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260713161406.361197-4-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/hcd-xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index cc61e28d33b..c7e050e38fd 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1017,7 +1017,8 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
         }
         sctx = epctx->pstreams + streamid;
     } else {
-        fprintf(stderr, "xhci: FIXME: secondary streams not implemented yet");
+        qemu_log_mask(LOG_UNIMP,
+                      "xhci: secondary streams not implemented yet\n");
         *cc_error = CC_INVALID_STREAM_TYPE_ERROR;
         return NULL;
     }
-- 
2.53.0


