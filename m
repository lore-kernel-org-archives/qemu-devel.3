Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808D606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7AmseQH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WRYtyM4X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoQ-0004T6-TU; Wed, 21 Oct 2026 14:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoN-0004RI-HH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoL-00084D-Ut
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpKEu2415972
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ux67zfQ7JX2LE9t4lTOz3fktCHrJkpxNSXYAjH2AxDs=; b=o7AmseQHVPgLbvOe
 ENDRxxEP+I8xdDxEBvXWxwb0Cdo69sdKGAshYAUUeZ6iHDPvGQF7GZNgK5ZYJXVI
 B4EB6lt41ruAgph4ODoKjF7Sk+PfUcakSZBcXR0d71DZl9kZqQsYV8ez9IfQW0Ls
 MkFSqi+SfNnVynnyHqe3blRNDnfyFXjbkSM9aIIQ3o5edd1SOU4WCEYVn6N+PFNs
 7yTAcICFgowAtcFYzuXIfkMEzoqOtn+N156BM686iwypP4ywkKfHv599YC/zIo44
 Ci4u3e6pER31owwB2EfZp1qR0Vumci30fVVd6cY7ZFT72whkqHL0Ie2vPyZg9RXF
 JBDC3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhuj032-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so1024927a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606382; x=1793211182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ux67zfQ7JX2LE9t4lTOz3fktCHrJkpxNSXYAjH2AxDs=;
 b=WRYtyM4XGdB/xVJ4IQLpOeaFjtbt9PLfABOYJipDTLSumDtUWIO7IzD0BTgC9t969G
 Mi7KsFD9JRDAxuZ3tiRHqT05LOwGkDjx1fuFbTTnGA3B6ZDpHj2QmU9LJ9QXAdiW9swn
 Y1kWxHMSkq1rTxkMWXTUvFgldsEKA176peEUfZze7bFh1+jRL2/L6Hj0AQPF3u6c4VdZ
 plx5Tx2ce0aBCGtKu3FVSM8Bg33JvvvaykqrVECN/LlFpyUKEbI/IyWsgq1lzxIz0BxE
 yEoEfqh8+e3VdOxWV4BCjMTVa7ro5SiIWF3rapekgmmQbOnrRwJ0fcvwGlVXzyrmXapz
 GW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606382; x=1793211182;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ux67zfQ7JX2LE9t4lTOz3fktCHrJkpxNSXYAjH2AxDs=;
 b=sQ7JlIvTD4Rg8r37DIQOv3YYoEFsuLqCJ7rky9Ek6E0M5ZQwJxubldBXyowMTSHCA4
 9wfpTGXEb6hQIMwf8NpqrUSI9o1etg3qumh+LGZFKPSAjaicNMkUkYfOyBp/KgEfUzuT
 s8v26I+JpUZA5UHvBeFYhCUvfCS3y3QdoHUIlbh60y2FEvGdvAzP0kRJ2nnV75JMiLLF
 x1uH5gHZgilQWdjMHGAIwYUFdIZHBQMYgQuxNXZosDEECWgMLLqP8uyUOY8PxxV5RNmG
 cuiKCrHJK6BHGou9OcQo5+QEgO3sXgDrrtpmSJqHwJV6WWkZDTRyus+yrCPeUVSywB/T
 E0dw==
X-Gm-Message-State: AFq9FYJjQyZjz2M/PSCjR2ZgnnBWfuxx3bZ+jbnupdm7bqvF/G46yh7o
 t72cZOaGcaujpP/t7b5lHoATqjX023NvjrVPuF/Vjuz5r6GOSILn6hFU/IGDqkR9APoaeBY2KWy
 nwYJtdN2WsF8TgF2MbVlCBKbtJKjyfaVSmv0OpdSWZFhnVl2JvAdr/b1pF0Hhl8S36Q==
X-Gm-Gg: AYBFou0AZqyXq+Ke4ywWcnBqpJ9+w/ZfW/STPHIf+xaq20Upws+psiWCeiha5BC6eoc
 GrOs3VIkkaUsDxpoXiGsVWboinx64FI5viFzJz9Qm0D0vFOxvNMFE0WRcc2MWf5dc7To7Bj+d6S
 CapyxBmyncq6nFTf9Xq7KQ4JfllRxfX0hpiL6P1a/i8Z6XlyOfRyxaJI3pa7jFsfDMYoiTfJp+z
 NH2N0f8sebwW46ekZ4m80r0ezVqGI7JDsGQy0s/ryLRGWAhUsKSmrzbpLL4Zj/mqpSAxd5H0MO9
 cfhI7tRqVIQ0JMYQ5fnu1Hobtk4DCi+VdARdz9tZGjZSS2CUu/Cokj+ks0CFJGWh2uih/G/d7oy
 tqkJ4jkpnfIXyJHSc0lPmH4pCVsn6y7ImralnBOfGA7fJ20pTNstTEUYg/ShZch8=
X-Received: by 2002:a17:90b:5688:b0:3ac:b185:fa16 with SMTP id
 98e67ed59e1d1-3ad86ef57d3mr2434529a91.43.1792606381831; 
 Wed, 21 Oct 2026 11:13:01 -0700 (PDT)
X-Received: by 2002:a17:90b:5688:b0:3ac:b185:fa16 with SMTP id
 98e67ed59e1d1-3ad86ef57d3mr2434507a91.43.1792606381374; 
 Wed, 21 Oct 2026 11:13:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 14/21] hw/core/sysemu-cpu-ops: add get_note_size
Date: Wed, 21 Oct 2026 11:12:37 -0700
Message-ID: <20261021181244.867840-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad900ae cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=s0xbLSvG6KTaNPbiVawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX9YJHo4PTe6SQ
 yRwwPbe4dRyG0NyRxG4q2+64ZiwQDT2cxrKcXZjQZAakQUR2f+y1GdclDgTxcJ0etJK0OmiIas5
 fkoaX0nC7Dg/EPBVaaagm7sOZhFfZqs=
X-Proofpoint-GUID: J2wrciPDh_-5yS4QWVptZwR080G9nh1l
X-Proofpoint-ORIG-GUID: J2wrciPDh_-5yS4QWVptZwR080G9nh1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX6HhQwj8G8oxo
 0AWbElZ7WkIsFzktJ/ClsM3Lj4EKxYWl7CoH2qOTTqoyZfqa3EyHpI0WH4rMkjC/CNf9yx9nIkz
 Yrot9BAb9fazEl6CLLeVK+/vms5DMwD8exEQRBlScML9QE5QFZPOuKfF3g+cg08nvfPQ2qNmULI
 jSxkErjBMi1KFIA78N55oEQPs44snuo92X1dMj8gN5GiWxWbyBpEbnOM+nylELTph4iAGbsVtpd
 4Lsht50C8bOsuUhvdcWvB6l7ufLSBYjspxh3uyEZaWhfvYWXChKMlT9Okihxzt76B8DRfTVFIym
 zczDF7HHNLPqXzI8B3MB9OLjDKa3wRRRwwLTVhs/pzMgF7ANEF4/pZPT3v5bmyrFj+9A24LZLXH
 UJ/IzXDFXD0zrq2Y4aRLlzRnBWqHOGjQEwzvpKmb4h0JW201y/7LdLckdzIhcxdDE+AJY+uWAQ1
 oEy8bJYNi6Hyw44Orrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This allows a specific cpu to report the size of the ELF notes it needs
to dump its state, alongside get_dump_info.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 1d4a04ff361..4654a2a43d2 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -99,6 +99,13 @@ typedef struct SysemuCPUOps {
      */
     void (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
                           const GuestPhysBlockList *guest_phys_blocks);
+    /**
+     * @get_note_size: returns the size of the ELF notes needed to dump
+     * @nr_cpus cpus, for the ELF @class and @machine reported by
+     * @get_dump_info. Must be set if @get_dump_info is set.
+     */
+    size_t (*get_note_size)(const CPUState *cpu, int class, int machine,
+                            int nr_cpus);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.47.3


