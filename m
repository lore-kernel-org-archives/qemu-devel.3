Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6383CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0S-0007Hn-36; Mon, 01 Sep 2025 23:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzi-0006hO-1M
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHza-0004Qs-Fh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rnlo029672
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /5v75VngIy4d3QCUt93PZDE7TZAdwElcelAyga7d7i0=; b=CiQRumypMQ1wPzRw
 ooB/ojq0kAuPl82NhGAsPt8NMN+cN8yHbXOKtNQ6LSB2CH6XYJrnXHalukHNHoOJ
 2s8E1wBK5M8qp4SftXmlOXBkexo2BtKboNG5yNFM5dyKqUOAsmorzYDQwPsokkJN
 a/lCydismtPWDiyd6BPYhmlg9/pZjduqn19Ysa0gxpr9oDIAjB/DPaCV+1AmkPe7
 1ejdqwfNeb4IoO9/cvx6xh/s+mHNoDFr82aZxCva3mZl402R58EMZY4T0B6A7T9U
 bGxCULMFscu9B3XV6lRZ9KiD8ncrXYefUy0tieM8ufat7k0waVvNilfzCddCHUo7
 K6XDvQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-32972a6db98so2997941a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784850; x=1757389650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5v75VngIy4d3QCUt93PZDE7TZAdwElcelAyga7d7i0=;
 b=WvxINflac9pn9CRzY4xl6/u49J2G3h49K5Myix6RJXK3RrIY+bwkNJ2b5KW/MUlhvT
 sbozS1zKbIm3VePZ9WHbczL5qmsBn2+hSPo2jDSKtOMFAd2RGq2G76ESXLsU5W8eI+Lm
 +jG8qw6d2+Ib5pu52+3PlSu8iFu2BaQV0oFai7okzWXp+jj0oPhJIWsPyHxZz8RP/uyN
 j4YsurNZipqgK4j+IUpHOq/0s1ji34rwFprEaoj93boyDN9IQooqeTb054AtW8nz1PUN
 6fsY4pQgKhtVpvo9aSWt72PRG0YWuOuv+Of6XbODLInjQiQXQCdU+q9ghvIRqoAD+FYx
 uRfQ==
X-Gm-Message-State: AOJu0YyIKTRBxxIu6uvQ6dYdtgQG0wPIitbfWBhjOeHuTbp3Yv35m8bM
 2AfXwWzg42D2YK4PiUCJHfBKyoAa+QnfjgfHP4cLVlflPI7yKbbeFaUUUF5yg+Sp/82BePVBbc3
 9Qlon3fw3lF6ar9I4PacBy6hEw+C0HUyn7PPZpWgU1H4eQkHuDhj6bx1DoZhiEsGwNYZ2
X-Gm-Gg: ASbGncuT2Qxi52ppRHeoV+T4wt4FeyVDVMv+MKE19qUQ5sDBv3ScS/oJKM+A5v0S3i+
 T3us/k72hTOtQqnBsDwpvK7w24MN2bDJiDlyMcRQxht/gGbWwd7y7aROBZTXd3UPpR1LCRynwwZ
 d2iKi+DuGtDGAwLwWw+0O+91JBVJtv8mlA70DP/xg8jcA++EQMHPFtaoZxeh8CS606eAyy3ptEj
 BZJ1kDuIYnmCCAKcVHLbIaR1ZTiEPkLjqGfSNlagkRrBkKeO1q1sqDz7mugnekJjhKoQ6h/QJH5
 hq5Jm+izUoqbrNgjcF2LTozKGKc5H9Bv4kaFk4J6xA4q7FkgEpg7+hJz+K55jP4Yv2GQZZ/q1bG
 ehhjSRHU6TVVS
X-Received: by 2002:a17:90b:518f:b0:327:ee13:5763 with SMTP id
 98e67ed59e1d1-328156f5089mr12244172a91.32.1756784849987; 
 Mon, 01 Sep 2025 20:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNRSouq7LKEDjIBMVJqWU7JSI/nbO8Lyz6kqlxg0Jddla4LQaLUFhHr6qwOduMFJv+YHyslg==
X-Received: by 2002:a17:90b:518f:b0:327:ee13:5763 with SMTP id
 98e67ed59e1d1-328156f5089mr12244148a91.32.1756784849544; 
 Mon, 01 Sep 2025 20:47:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 06/40] target/hexagon: Make gen_exception_end_tb non-static
Date: Mon,  1 Sep 2025 20:46:41 -0700
Message-Id: <20250902034715.1947718-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b668d3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=DaFmz2gY0jefzUg_QRQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OuqZlF5s30PXAOxYut3gMkaLvIK2c-Sc
X-Proofpoint-ORIG-GUID: OuqZlF5s30PXAOxYut3gMkaLvIK2c-Sc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxldouIw7NH6j
 zoVifZTbvEpHDiLE5eSot6n8iXIlR5nZHxcBBhE3p1gbMAtoYalw1xNwpw8N7c0P9yl7ixgPuNG
 7W1bPYolCsJSIx2d9MzJu/h6d3A71YJSf30sJW4ewO81WF071JIte1/7zKsl+ynil4+xBM1G0kB
 wFroQXDd5S/0tDWr/MtXGezEYxRRcwcs+xq5sAIW7KMqPgtrZfJEkqNWMpd/kOWK9BeMlB/72fg
 QRGKnf8Nqmw4rby1m/4OZz01KvFk3+4N6TftjdBBf11zUGeZF5X4mshI6+nPjXrnDVyhpfgDu83
 HD2pER84IlkuOxlgY/15ZWb180EyamIc7Trn3EtIg8iuOTgsZtwqRc2u9mlP5owDmtD3FQyUega
 sWA4KZh/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h | 2 ++
 target/hexagon/translate.c | 9 ++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index d251e2233f..2bd125297a 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -281,6 +281,8 @@ extern TCGv hex_vstore_addr[VSTORES_MAX];
 extern TCGv hex_vstore_size[VSTORES_MAX];
 extern TCGv hex_vstore_pending[VSTORES_MAX];
 
+void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
+
 void process_store(DisasContext *ctx, int slot_num);
 
 FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 02fd40c160..15f5adc400 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -185,13 +185,12 @@ static void gen_end_tb(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_end_tb(DisasContext *ctx, int excp)
+void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
 {
     gen_exec_counters(ctx);
     tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
     gen_exception_raw(excp);
     ctx->base.is_jmp = DISAS_NORETURN;
-
 }
 
 static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
@@ -558,7 +557,7 @@ static void gen_insn(DisasContext *ctx)
         ctx->insn->generate(ctx);
         mark_store_width(ctx);
     } else {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_OPCODE);
+        hex_gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_OPCODE);
     }
 }
 
@@ -912,7 +911,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
 
     nwords = read_packet_words(env, ctx, words);
     if (!nwords) {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
+        hex_gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
         return;
     }
 
@@ -927,7 +926,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         gen_commit_packet(ctx);
         ctx->base.pc_next += pkt.encod_pkt_size_in_bytes;
     } else {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
+        hex_gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
     }
 }
 
-- 
2.34.1


