Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7657C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfY-0007Oi-Sb; Mon, 06 Jul 2026 09:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjen-0006jk-5W
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjei-0006MA-6h
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax90c391056
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wg2IMCq5o4M/IqZkqQnUukZyM3Q8liJmRPUOO+zAvSs=; b=BKDsceUdjGBzROu0
 gGg3On6kSZdq9gH6R5Y19Vu6+tNTNDylnDpCBGPLa/ViouJ7w+e3TXdW4siePobf
 Xrua+8RLADaG9kVzKEWjI/a4gbq6SZj4NmXX7O9hdn2awoj3pZohjj+ZpLcN2wa2
 J/FhaKdc/EMMXj1RdN/skbvDGDBHpR09tH7dZjsh9MYj+rddlPOFtFotm8nNWYqa
 hP/nVREecbDjlPWv3MOkp9tO0JxXVayIaKFBKYZ69hmp9L6gn7n9U0KnI2oiI7QW
 LuOdRQe+nfBTZ+Xis6MoNYMtO1l+9nphijZREc80ukJKVf58qwnlExCXtT0JI161
 rRCoKQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs18n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bbecd25037so403376e0c.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345598; x=1783950398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wg2IMCq5o4M/IqZkqQnUukZyM3Q8liJmRPUOO+zAvSs=;
 b=dI2tBdZC+A6x82idQegMfmimbjBpKkoBtNg8RTfNXGvhbsUkZywi6qsnSTG4srnvao
 JkqZc8HGJOeigrXOsYvm27B3OzcZ1Q/338jkDPw6YFZzPsp2SqF1Jx56JILsSjv0YAxi
 rbrYn+PNDsuz4neobszQ6m/N1WoYx9eLtLA26El8l6OSIjh1tDxCGaVlctCIdq5LsMqu
 JydmqX6lBw7rWqL1HfJeqfnt5jFAvRpRrt5nqV6kpSkQx0illZQg9xabTZnpRgxiB4+v
 aOFbEMG/UMghhvd0HGN4WlgA815tak4xqWCuo0BCUKMVfjm5N50X27bUnDcJaIr1mu4L
 PQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345598; x=1783950398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wg2IMCq5o4M/IqZkqQnUukZyM3Q8liJmRPUOO+zAvSs=;
 b=R1x7OyhOM5LlUceEO9+P6q/Ztcvz5wIVpod/0N3alfSWkO2QrKBc0a/dcDT0Rpf71n
 fnADIr8MvDms2ggzrqcvS+nSIAUuFouS+hjTwiRS1Qt1TdcBEeWfJWDkVRpr8Yjw6HfU
 FwXOLN0qHI1tO1YL2Q6DWdbbwrB2Ug40NB4sOn/l9lnE96aYANlJy7Wkd6ItvvMx+Se+
 mQd8x9SQzLfr9RulZk7DXhQszwJL8062XyEPdGVUE8ruARwRWUFR/2eTmn+DcZ8Aoysf
 N3xydcXcv37ZDBSyGGFNfrn2JCAdBkci7YnBA6k69QrYRxeY0SCQzg5IIjuTHGD9FhT6
 azMA==
X-Gm-Message-State: AOJu0Yy8d5hf3WNlHC0S7OMjNL6jH8A8sPxzHRUcOi7xuS3wkhl56eI4
 bblVP7zl5qPSlSP/FyYd3n6QTNqtXZKDBkXzvJOa+v0O258SVeHV3dKFVRY2G70+ktznx+ocbVF
 Ab7+rsJIdCCJ2DnW/g623U6w7JQ4herUE6RmHoefvpwnTAGaKvHzpPeNiKVPTgTrvRg==
X-Gm-Gg: AfdE7clfTH8hIWooNDi7t1PSJK3hV2iw9o177SLqBx5puJmuZx74a4qnABQFk26TUj5
 /jtdNZubbOcXtcmPkrWJ5p+WMsZ+/c/ayNeDvn8XZSc4DDh0CHhRzWvPIeZr7rpyGVnuXCqrEeb
 H3w3lA6KKImJYWDao8uNM3R0Mj3SCkct1yS3m7u+1X4snRQV37fcKSm3FiEm/uNVG2E7NrF75SZ
 Gfq7ZjTT2BoCHXYZymBHOJC7sbcZOPraVeEDPCJuEE9BqcpokfMD1kCun8eVcL9dVv1JpKJxJnw
 jbVNfjboTLU/X4DVkIB/wq0gCn332azPiJr7L6Mcy5SzVn2ggtHuLSY+rOjEUh0on8PHmaWoHTe
 gShteH1YbCYElthhdmknWxEJNCg8pbMxpMCzQ+IsoalhYcQlmf1kyshkQsQ==
X-Received: by 2002:a05:6122:3a10:b0:5bd:9ea9:3de5 with SMTP id
 71dfb90a1353d-5be907c16b7mr276846e0c.8.1783345597744; 
 Mon, 06 Jul 2026 06:46:37 -0700 (PDT)
X-Received: by 2002:a05:6122:3a10:b0:5bd:9ea9:3de5 with SMTP id
 71dfb90a1353d-5be907c16b7mr276836e0c.8.1783345597274; 
 Mon, 06 Jul 2026 06:46:37 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636e9e9sm355798385e9.2.2026.07.06.06.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:46:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] gdbstub: Add trace event for STEP packet handler
Date: Mon,  6 Jul 2026 15:45:02 +0200
Message-ID: <20260706134527.84808-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lWXeEy83OJMm-NGtXeNlxF2Fpl8dUQQH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX6OYI22zdMKZb
 cawwXEmmFfgsHRkk3OPYQqH69UOQYCLnmJgoOtOzSS8RziZg65oFmNPGpYnW6dGZSl/5/uyM12L
 w55LKW2lDGqSDKoMQAYarLO1qQVItqMv2jx8Gj5vFq2EkAvwSBi9QgbjqT3AFB0qBR0miHjUYwH
 GnsK8nVSgRLUlOFjq4hXcEUx26WGV8YKDFpf6G0ZSxlBRGpDM5UjSwuetkuzqSvpDwIlj1OHJ4K
 I22CVApusuBQOC9EL6GPu29iC7AcEbP9u6W/9zGoSqZtZfKC03QoagnDy8XJ+pbuDQcgST5QdEY
 D0j/NOcMA4S6SzRag8vHBTDJUtEzxI+o9p2rtqVHfUNp0kxeI+QTvr5r9lNa5Eck4/pXyLyuViI
 dPbvEG0fd1fbSdjJmI0ayCQDGKLQkl0le2v+eB49sGe0Ck/ZOSUv/qK/rj7YaQzc27yOT9azb2u
 RAPlUL9S7ldjV/lRkuA==
X-Proofpoint-ORIG-GUID: lWXeEy83OJMm-NGtXeNlxF2Fpl8dUQQH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX/oSQ6/L+ZLgr
 rPUj3TdvNZ+ZiMizKiT/WIMYfhZlwMQ+NTn7Vp21EGPpSorXNKdkjN9g2No+r2GFsWjRqHKjeEC
 lfJ0fxD9x+60Q5j/qJtkNobVerVKI8A=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb1be cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260705215729.62196-7-philmd@oss.qualcomm.com>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 26366acb674..246e7746300 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1369,6 +1369,7 @@ static void handle_step(GArray *params, void *user_ctx)
         gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
     }
 
+    trace_gdbstub_op_stepping(gdbserver_state.c_cpu->cpu_index);
     cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
     gdb_continue();
 }
-- 
2.53.0


