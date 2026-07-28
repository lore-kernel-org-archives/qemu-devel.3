Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879DBC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJV-0002wh-Jt; Tue, 28 Jul 2026 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJN-0002vm-Ma
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJL-0007RK-Vs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82ol02309835
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lHLRNvm3Ny/FbIZi9oQtTg13RJJdi79mWKQDY727r04=; b=PtlwfjdhjMA7wybY
 32gC4koMd0v26iLZ1nXuPvGULdXjf5yUots9garctwPuJSWmWDbV5anVUBtLDmqs
 EYYjjlL7FCIr61b6jcdyIBdn/Js6TZHlCHg6kqSAthanvPBCyiuwxCV7yLxGcDyY
 GNpmbuBGKNDB25mrMTWRmUEy2AL2CjS1xSSZgLTLyldOzXfMTvUSNq49pSSp6E2x
 AXiMFT5Sn3KfUjf3XA93JZvKkGT/aeNjuzMO7WgZqOz2lSu9XM1CwYN/9twgY97W
 DDNQKXHAZK2lj7m6jAffEqG05CPCBAYp6bEWJqmJY4vGLj5igrdleMg8cGXY2BHq
 dF0Kcw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7j2rg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so53415051cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231678; x=1785836478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHLRNvm3Ny/FbIZi9oQtTg13RJJdi79mWKQDY727r04=;
 b=gcDdwaSfV17w6RFO/dwH3aNwW2tfFhPUM1mOx5zcdahXMVyEVs84l98G8M8pe83Loc
 0954+ruEFEqZUPaXW+RHtlgHKmszEY5njSR6xdxvlCBlsG48yGIkree4NkbPekM4zoiI
 enkqYsz78Hfnn6cIFTEXU1SvQ2GsClZVAWWWdVD/vSEEZZvsy+kjh/qZnHmySLKnRprx
 GaHJekRdv6NXR+BKrcriXBKcQi4ZdsWVdEFRuh8NeNZgYQv/Nuqvrb1V52Z2pRnNukau
 uB7Ul5tTBomvOj5KT/xwDbMhD45AJOANyC1DDNtB72F3p9P0eXsZ9GtysvIbkrFfqDJ1
 jOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231678; x=1785836478;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lHLRNvm3Ny/FbIZi9oQtTg13RJJdi79mWKQDY727r04=;
 b=Nor3sTZYWrILMr5Ci9uVbom3CoGYqoIFnKA0TVZxNb+CdaNwOy9ks0EOTQej6tP9/i
 eIrQjqq9kpBrRv/uQ30LlSl/xIzeKMNJ8s17lzGhjyZO6NI3s6m4a8vjEiECs4LavI5x
 oVQu32dB8eKbN8kJi9B1rWLermTiU0LkFio8LHlsPJVwJ/HYbrmWZsc/4d2s54oYoyiG
 QmYcabo2tEdMTPc/k1CzklD0P93y6MuC2qgc/C8S0/uB0ZO9J+6y9INa4qketA+3EFsf
 HxgNs6BYxMS//H7iRX49i77T8OMVgCcxaVbmRRXJcdWMF0sMRpxXptXDNX1ZfFhy4DzY
 0FLg==
X-Gm-Message-State: AOJu0YziuFxMmJKIo15W/Z7M4Ter/1eJN7kfQs86mEh/9anAkW0Xokdc
 /nDh9i3CeY+DYk4JxZkex7Fzx3RyG8iUkmfnuWhni2/+7xWykodktQ3c03LslfHsxQmsN3wpPvd
 36lQU6zSAnK5Gu1bgesl/hJPFQ+quAfSX7MF6/usGVZAx+Bhc7J8vTbgxAjFxwEm0rg==
X-Gm-Gg: AR+sD10hvbtx7g99s1TLkt05rBQX6ey7pI+jp+vF0iG/lN08HpNhJm6Gj1XltPcJIkX
 Md+vLGmMmvG9tQL1zMo0M17dbx9nSvcsiJyperM9uJUevKB1O64Y/5k96XYrLHSuG9rFfHtqXAa
 YnzwDC/7TUu8urUc67RNWvCRl7JA5CH7i8moAj6Vx7S6ZY+mvDFkLsyo+qtjL59bENTiW1HPMtU
 Fsat21b8XQoVLohfUdaWrWHSUQig8VHxNNcQhfPLqtCMNGyEzn+QlFY8pEl6D+b7G56Vl4SJe18
 IchqYRC9uTqjkcYnAlZ+nsX4V/zShnLDv8BkLjt/mIqU2an3v0FpDRRtAlXd2HJ27RrdOL5iSAe
 JQEYxsoaJyBHOLDK/gWcNxfRidErMhCKl6yh88VaV689gEXDRHiH9WRDUsQ==
X-Received: by 2002:ac8:59c8:0:b0:51c:f3:34d9 with SMTP id
 d75a77b69052e-529d6fea3e6mr12887561cf.27.1785231678472; 
 Tue, 28 Jul 2026 02:41:18 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:51c:f3:34d9 with SMTP id
 d75a77b69052e-529d6fea3e6mr12887291cf.27.1785231677923; 
 Tue, 28 Jul 2026 02:41:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm57111561f8f.27.2026.07.28.02.41.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:41:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] hw/net/e1000e: recalculate rx_desc_len on migration load
Date: Tue, 28 Jul 2026 11:40:52 +0200
Message-ID: <20260728094055.12684-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfXyxYb1WTQKP1/
 w1ZTg3KP76AoG/VvrovCinI6xHmsHHU0333s7DS8bhyeXsRzXRFXeiOkojDAHfPr/cMSJbx5YzO
 bVrLB8MtSocyiWabPrenRbbciH4i5Di468GImj0eDlrls0pMrxxvlYgc46rVH9/1aheyaJ/JBSb
 CRu1TEK3r8lZxfjMCWfwQSPAP0NIf1iJTpQs0LrdX0s8LzGVftI9VGN5FfJxA/AyCvEzGiLPV3k
 ++hUy2pU+kfHNr+z+RhB9RLAQkM/LR81ZDQ5EQkCeSFNsi68Opef7xt8shxX6oQGOPXyjSrs0eL
 P0fqd+yPTs/i/U1qS5vXeEMOL0Sr+E+HUb7j4fxoKQcNZf7BDAH1oZogF19wecALHzObxsae3HS
 eVw6q6f0sV7IUd+Ny3Ul1/a2mFgFpPT474/DeDt8ZFCTpfrJdhzqJOOQVAoQkvG3aq+2gCw43mr
 xdXA3OOnOBvY/F0qHcg==
X-Proofpoint-ORIG-GUID: Eq4An3NSfPFgs6ATZBLnSbP1-FbSlzKk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX6xUUQ7pIVEBV
 F5xZlVAihXZ7K0CNWU1ObzV3PsK59jauTefulgnA1kLaQFF5rn5+RpcMThQszb5skl8pkUux7bE
 JcK66RgkSmB6GarLzqpwidQruwW5GQk=
X-Proofpoint-GUID: Eq4An3NSfPFgs6ATZBLnSbP1-FbSlzKk
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68793f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=u9DDSBZwBUtJ3TGLOyUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280084
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Laurent Vivier <lvivier@redhat.com>

rx_desc_len is migrated as a raw uint8_t from the stream, but it
is a derived value that can be computed from the register state
in core.mac[RFCTL] and core.mac[RCTL]. A crafted migration stream
can set rx_desc_len to an invalid value (e.g. 64), causing a stack
buffer overflow in e1000e_write_packet_to_guest() which copies
rx_desc_len bytes into a 32-byte stack union.

Recalculate rx_desc_len and other derived values from the register
state in post_load, ignoring the untrusted values from the stream.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260722112449.1386162-2-lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/e1000e_core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 46e156a5ddc..b87a9f167a7 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1948,6 +1948,16 @@ e1000e_calc_rxdesclen(E1000ECore *core)
     trace_e1000e_rx_desc_len(core->rx_desc_len);
 }
 
+static void
+e1000e_calc_rxconf(E1000ECore *core)
+{
+    e1000e_parse_rxbufsize(core);
+    e1000e_calc_rxdesclen(core);
+    core->rxbuf_min_shift =
+        ((core->mac[RCTL] / E1000_RCTL_RDMTS_QUAT) & 3) + 1 +
+        E1000_RING_DESC_LEN_SHIFT;
+}
+
 static void
 e1000e_set_rx_control(E1000ECore *core, int index, uint32_t val)
 {
@@ -1955,11 +1965,7 @@ e1000e_set_rx_control(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_rx_set_rctl(core->mac[RCTL]);
 
     if (val & E1000_RCTL_EN) {
-        e1000e_parse_rxbufsize(core);
-        e1000e_calc_rxdesclen(core);
-        core->rxbuf_min_shift = ((val / E1000_RCTL_RDMTS_QUAT) & 3) + 1 +
-                                E1000_RING_DESC_LEN_SHIFT;
-
+        e1000e_calc_rxconf(core);
         e1000e_start_recv(core);
     }
 }
@@ -3557,5 +3563,7 @@ e1000e_core_post_load(E1000ECore *core)
     e1000e_intrmgr_resume(core);
     e1000e_autoneg_resume(core);
 
+    e1000e_calc_rxconf(core);
+
     return 0;
 }
-- 
2.53.0


