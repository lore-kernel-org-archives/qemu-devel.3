Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409C606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J7tGpGiI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i5oaDJeV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcwA-0001xQ-JT; Mon, 23 Nov 2026 17:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcw7-0001rL-Nl
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcw5-00057g-8E
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:59 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuYlW1579761
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GStmKwoXoWRWEfw9QEx8NmYd2FOC4cfpzvtlSc0HZVM=; b=J7tGpGiIH8Dvpbnt
 Y1/KMAECr/0txfcCAAC5gDHtxEv6c01sdmOmYGGzeabN1lkvMAyvbtHVvHIsAYJj
 hLGnomslBbvesczmIqvbxgyrYk1o2wReBa3/tkltv9mgFrsr+k+dv4gx/qj1LAsU
 WTRvS7LW/60lfbGXYzT7nkhwX00FAeIPvw4Ld1vhMmCah4oN/ReuFAkR42SwQTvM
 wpPVDJi/6FmgBAZ7CHemxF9FWTil6T/XL1R6G/4tXNwvIvGnGr8flHmEQdf/gm6f
 tpjcUIwbkVIWDrnhiJGCaqpckoibQwSzRxSnFsP+NlV75bFXFJCerZOzZ3yCTzeW
 T41zeQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0tqxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495c71055bso742310185a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474495; x=1796079295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GStmKwoXoWRWEfw9QEx8NmYd2FOC4cfpzvtlSc0HZVM=;
 b=i5oaDJeVQ32tANn8x4s5yaH/Nhkf2GIoU0LrnxFtoy2TW3M0kbKG8yAwWdjlH1V9fJ
 I6+xo5o/jPeJRcL2oXduFfuMMKZF5Dr7ncaPsk4IZJjRAGm3i8uwM6rCcLU7TYdo4wr9
 aOB/z8Mbcsjlef6CG0GPj0zzw/np81YLnJqEWspbpAwtvcURbVgKHz7HNKnIAjOTBi2I
 /nRqKv/2hISq6smUbMtPoUXQ/ORnUIL/Zc/p66LirF82H2pDAYqSyTPl1FX+Q0AmnEnP
 PchllFXhHRBfLTajgUyMHx1GI7FrE00fQjEyOnaDIIMfu+Zctm7BnwiGAHSaPC1oG7G5
 +Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474495; x=1796079295;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GStmKwoXoWRWEfw9QEx8NmYd2FOC4cfpzvtlSc0HZVM=;
 b=N+CY3S7thteQ7MV+09OQtp7ndcH1Q+I0u6ngrOclN3fxm3utdkeY47a8mo2Y0N4Sdj
 9+1kjOl1obSNShb2RJXwlYtFegFp/LvnmSSPMlSDZ17QDZgjSCTn2ojcvtXgUQ6f5n9V
 Kb+dILyi+8iJOzCt+oo0LxjgETUjgmqclL4dVfPPXdv+zJ/PahUxQFlD3LQ0xSHTM2PE
 VrbqMxg/PYACJR3VlcPoRxQmGA/q7lXqaCwgJaguORY1nKz+fthgjGs/oJ2geivUsYf4
 v8AarTzoZNLVZg8JD9SSnFXRkqiCKIcVWLLx7SfGYcG0vJr+uOMymAEhAPJ4zLEoGN0j
 FAuw==
X-Gm-Message-State: APuU4Z+CIwiP4le44SKlXqDKRLCSKj7Z87RA5xszYeGfggX3A1PdFIdy
 Y8aXTdJuUUBbeLgLQ1NlNxhmtokQFMSSfkcYRVu5fEkUe2a8rivN/1gsJiIGMMKOFoyHDStUQsZ
 lx68IHYmvgejLOq1zFpByz1HxvnsxzjowgQ2P3/GtCSc6P+nrclqjXXA3DRF1AeXw0P7c
X-Gm-Gg: AZFdTZcVCdgsBkl6op5sS6FtHZX0xIZmJ8p8YWiNE5JkEOafquC91MSBZ5b1nGqrWnC
 NWjky9sLHaDS+2KptsQHDQuESdjaV1LfWJI8wPn0TEwufcoYaPq+7YrATLqU0yr/XUZUixXOEFc
 fGQQPMBbCQeOa1YHsLdKKQKlS1ZtuHFqxAgonBEGNssl8aFLHX4862cK5iZ7tuLXdXSxfDAeV6o
 0uWeyB8icvSYVZLr09m04hr5wsKihooRcxDvo2UXD5KBRP3AaDkikA9rdQjKQm9jiL4WPDeeoRe
 z9J+pfALPdOvjx7Jn1FGVlpwl7Zp4lGODepMrdOivQK3fIlaWP+K9Ga3STsi3APQDQwnKWP3+mf
 Jhm6kbBAbJ/XUDhTJkosMI6pJwLxjAiQfwqIBvQlWo4NdvVnb65Acp+zD/JumQcE9A/m2/52Cgo
 PJaX68LQ4mziqg5w==
X-Received: by 2002:a05:620a:130a:b0:93f:2f48:c9e5 with SMTP id
 af79cd13be357-949ba9f9712mr2308734585a.34.1795474494695; 
 Mon, 23 Nov 2026 14:54:54 -0800 (PST)
X-Received: by 2002:a05:620a:130a:b0:93f:2f48:c9e5 with SMTP id
 af79cd13be357-949ba9f9712mr2308732385a.34.1795474494223; 
 Mon, 23 Nov 2026 14:54:54 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680355sm21157100f8f.27.2026.11.23.14.54.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 8/9] hw/sd/sdcard: Fill SPI R1 response for rejected
 commands
Date: Mon, 23 Nov 2026 23:53:48 +0100
Message-ID: <20261123225349.54981-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g_Jyv4i8eOZVbIdYEaELb-JaFSwgxTTf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX6rfN4Avtt9Gu
 /SZTcSZCL9jnTgWTLdrN0VWg5vNMYtLPVAGd2RFna7oWzYTTGLIoiIUxN24PgoHVIguOVaIuKa4
 /zgbktQ9tA+tHDoVM2o54dFi39WIxa4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX5qLI8E6bQ8PC
 s899w1J5XigP1mJjFkGF364inLzHNiiOZDWyAiB2SOt0oMsaM/YyidqtSQhmId99zaB0zk+pYmQ
 IX3LH6AG0OGz3MmKCROnLYyRqxYUPwGKyYYHgb2Dv6FxDSwvg8RjZr3Tk7/OAvWqCzK8S84A4A6
 eGLEvGi32Zdx/5RD2SINcO4AP+DlQLmhHXadxjsXSfX/+St9wluddbEu6GK4aQo41lFQZ1O5M8B
 fg+qmPvubKPdrRzz/ZcptGf6YzaZaqXOcsO8lBRWQlWJkh5uePMyvmEVXdA+NiEstYcrP6x5XgG
 YDRNWotbFhfHqCS3xxzzkKy2yvhHgC0Vc3ycuEx07CQG9v3+cTdGk+E+90vvSLtM59W3IQwUSih
 G+sBQUuUvoai/smW8PUYL2zivZ5+LxJcQttj5DbzqIx/ybVy43FGAsfdPDegVTJEyJDONllG3ZX
 bZ20Pjh02ZD5lf+cd/Q==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b04c43f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=jg0HPy1x56av6D61QKAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: g_Jyv4i8eOZVbIdYEaELb-JaFSwgxTTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
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

In SPI mode the card always responds (Physical Layer spec v1.10,
7.2.8 "Error Conditions"), so sd_response_size() returns 1 for sd_r0
and sd_illegal. However sd_do_command() does not fill the response
buffer for these response types, so the ssi-sd bridge returns
uninitialized bytes instead of an R1 with the "illegal command" bit
set. Before commit 1585ab9f1baf, ssi-sd itself replied 0x04 (illegal
command) in this case.

Build the R1 response with the "illegal command" bit set.

Cc: qemu-stable@nongnu.org
Fixes: 1585ab9f1baf ("hw/sd/sdcard: Fill SPI response bits in card code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 862622e217b4..a3a4947e5645 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2693,6 +2693,10 @@ send_response:
         sd->data_offset = 0;
         /* fall-through */
     case sd_illegal:
+        if (sd_is_spi(sd)) {
+            sd_response_r1_make(sd, response);
+            response[0] |= 1 << 2; /* ILLEGAL_COMMAND */
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.55.0


