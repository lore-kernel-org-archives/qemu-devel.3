Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M4rbZbRN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NgEhjiPd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyo-0005Xt-Rl; Fri, 23 Oct 2026 12:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyM-00053b-4b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyJ-0002aw-JG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Poh3000292
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UzBrLyD535/Y603iJ1Dw+wfYw5v4tQHqEdAByKIdD74=; b=M4rbZbRNmqHKxwWX
 IUGrTDjujLv/8D1tviGrmgtaHBiiGt1Tn4FYUxdIdVKqEHxhEuFwuFmUEt2e+Vg4
 0xZs3qP1bE9zxJAlWew60uqfgql44okXxZAdsJI0Pd8D1r/LmtnsrwS4+sv+Gw5W
 w3c716wqPj7h+ScFjXGaaYxc3TvpkO5R5tZDUoqXpLOO/Z1mhwTyhgvKTX+vqJOH
 M7n5WZhzfLcE6BlutQsGXi57RxRCxI+asABY7NLeXpaHkQkzHBq1iKY54hIyW89Z
 dwasHUMRwHtbD/hNabbQnTItC8qqkmE2JlJWH9EcjCNSlgdyrJnaaanx99lZQJR/
 o7Yonw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0w2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso133536785a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772298; x=1793377098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzBrLyD535/Y603iJ1Dw+wfYw5v4tQHqEdAByKIdD74=;
 b=NgEhjiPdrJbKNzdLnj70n46WlA9t8sGAdhWNbTgj9zxbmpufWGT0RIkPgR5oKDpRHp
 gNs3ClPaEgOITJpka/4S0Nhd43GqMBAVvXQsWOFYG5xlHsx25gj8wL32pYugJlWeDqvB
 qBoU89Q5hAyNPsmIl9TMU5GoGItezcWld7CpMtX4CCdsW8eR983M6jYx5xDm1Q7LL5ma
 4fgoA3T4Zeskw5R7TsXxIEONm9RMxWUP5yvBe7cIwtaPk/CKsoIOivEWREmtZ6NjSazW
 CLP4tSTk1tKPAWf+G4fvuSKUpROn4Y5b+6NyjjqzRTYa6BqBSKOa0c4qLmB29qdPP7nG
 fJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772298; x=1793377098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UzBrLyD535/Y603iJ1Dw+wfYw5v4tQHqEdAByKIdD74=;
 b=REISCbFEb5AfmmfgPDBJyENVvdmPOYHvkh9v53oHJxZCSLGkDyQgGdBbEm7MTpJ1cO
 a/TxMHdw8A8U2LMNh+1bW3NnMKq6x3VQN3X/q78q8FSu5G1XjPbeNcuOR2E/mxXfCQoY
 G/Tk3+Ek1gtjTwrnguWK/sVrGl9UQ6eGCeZ/2cPjOM/zAGNbXKUI7a2DpJTG2ZLY1GCc
 3Bo5WVYLvzgXdTCTvLcG+uEa7dH6YKd4hhdFh9E5wBP6hXwfoTEAqqxgPiBN+J6BGLja
 XrW79qCLFjzDuocKBaSJ1bACLwK9SksbRiwiKFzoXHLfjdgdz+/cPM4iFd3GyopZIk59
 44lw==
X-Gm-Message-State: AFq9FYLjQ1GwMlqCMiywFAZ5dC1vtkLoOqkHJzuKJHTXf6KqsKzQWZXx
 ltTCmblrc41EXb20eyLIU3OUSRA9c6f6j8yA2T4w/ysdyA6/oOm8EzqkJ3IeBOC8J1ZsvA29J30
 4RdzzfNYIe3/OGikIMagOcf21kskZnjfrIRpDVWLHUoUCcXSyjeUFYsEQ+tOp0j7YzDqe
X-Gm-Gg: AYBFou2b5IOaIegawZ2uqbcrhYsNX7q2bUXhyBfUgSlZy+6qlLhgULI450D56WsNhj1
 WPZSPow287P7Qo90S4gm6F5NI48KZoXq4th2rB9UViEnUPcQ+D5Kax8uWq+z1Ou+WN96E/9AA/e
 rWU50OvvogrlvXoJ7VYhNIVVdBLzMElZB2pXGcBr9HNkWhxlGVEMspE9HJuvFhdoOqxdSaZyru3
 R6qwJ/WdQl05t+k05Qn+4Cn75Gbv0PdRc2eaAfxU6lqrMX3pVbj+QdWFq2i36A5+IeOxHGzeXbR
 Vn8t8Yc6JH31aHQ0Xt6TpnUANLMJPm1r3ILLJ4iY6Qfc/iEWpH7Yr4CdK5g29840lJdteXQZNBz
 gHPsjn3YUXOh5dS8YySnLkWpmnjSAbb74FRaX1PfZ
X-Received: by 2002:a05:620a:4725:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-93f6f907cc0mr501464385a.16.1792772297990; 
 Fri, 23 Oct 2026 09:18:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-93f6f907cc0mr501456685a.16.1792772297254; 
 Fri, 23 Oct 2026 09:18:17 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312eafc80sm18746605e9.3.2026.10.23.09.18.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/83] target/ppc: Name the EBB exceptions
Date: Fri, 23 Oct 2026 18:12:47 +0200
Message-ID: <20261023161332.60153-40-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXxoIP1kNBWbuO
 bTeOztACL8kdTTpFDgzSovLG0+6t/7Ta1ZjDr2mrNHZEGJapId/mC2yyEqTgJw6JD/Q++sW9iV0
 9pdfpw1yMKOuBBYIdQ+4zBOUZJjr93JzMU5wX13kFsdnZQUF8xmQmlYU4fx1LrQiKgC7Se0IczR
 2NQvh2nrW6OQs1PTBvxQEJfbiutDM5eYHivlR6JOEXkCMON8j47t/QXISopWLSRu1uMStC6IXLM
 Ytgt/y2i1hRmNimqxllCibcNhFweqb+m1vTfyYO1Nu38DxyLAkIHkRlUiiqIYDunonaTIqjX1cQ
 CbArSuIwH1rxY6B0z4i5orIStKTWJjRgqtX7wUcpexagJjpTcvY4Tf9QvLmJXtmnltyRvvRsBp5
 5MDZe2XOqtZAwGXYACtyjtGELIZSbuLjetWn/FGJhS5UfNrDmR7wJXnBJ6QiFaxARI04wDSKpQY
 5RDLkfyVPkFYD7jdxDQ==
X-Proofpoint-GUID: KLtqJDXF5nGfxjMWN8m69PHfIDuGSFaP
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb88ca cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=Ni8MKOl5piV74ivutUIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: KLtqJDXF5nGfxjMWN8m69PHfIDuGSFaP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXzENxyHSO7A4q
 YeTRxNESPh6LpwUP1MecR80K5OS2w8YYuAiwI/AXSarlPzr8m0r+GOgh0kkr7gZpnAjw9G12faV
 Wzem9UyCJHsg9xHuSKqdhxSj5OMyJSk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

POWERPC_EXCP_PERFM_EBB and POWERPC_EXCP_EXTERNAL_EBB are raised on
POWER8+. With '-d int', powerpc_excp() logs them through
powerpc_excp_name(), which has no entry for them and reaches
g_assert_not_reached(), aborting QEMU. Add their names.

Cc: qemu-stable@nongnu.org
Fixes: cb76bbc43fda ("target/ppc: add PPC_INTERRUPT_EBB and EBB exceptions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-21-philmd@oss.qualcomm.com>
---
 target/ppc/excp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6d05b865058..895127fb2e6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -100,6 +100,8 @@ static const char *powerpc_excp_name(int excp)
     case POWERPC_EXCP_SDOOR_HV: return "SDOOR_HV";
     case POWERPC_EXCP_HVIRT:    return "HVIRT";
     case POWERPC_EXCP_SYSCALL_VECTORED: return "SYSCALL_VECTORED";
+    case POWERPC_EXCP_PERFM_EBB: return "PERFM_EBB";
+    case POWERPC_EXCP_EXTERNAL_EBB: return "EXTERNAL_EBB";
     default:
         g_assert_not_reached();
     }
-- 
2.55.0


