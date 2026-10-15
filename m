Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3691CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBN-0008Lk-8C; Thu, 15 Oct 2026 15:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBC-0008L4-MP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRB8-0000WX-FH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3PjE406119
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c3tCuSvB99B4uoLx5ZJ+Nh3SRO8gicAScFCTUBN2kGg=; b=drHohEjoYvabMFoW
 3enOBCwWq7kh3sUAQ4QKaHsv3c2QCB4I81CkgdCmRLLA/xbPHbKtyeqUwnQENfPS
 mH/dp52kgB8kskzmHchRl+hWpP0hESVtLjN0ID3KCzY7T310ocl1j/qG4mn7nv7Z
 O2O9Q7soEB8EfT3xJoCInUkpFZraRrSY13Jc3cyoQX70XMAqB9gunzyqMGarEOy6
 dSB2E89n+p2FDEPZjMTUzyQiVAWSbg1qTbJbiC1v5u7A4i7wjlgqzoPbYUsmy0ft
 Pl+U92bDqpkMYoGtRgcanWrrKKw+5cmENtoGyk3ZRUTMXiU1+S83UqUznR0BKXV4
 erIlvQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so15754562eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092700; x=1792697500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c3tCuSvB99B4uoLx5ZJ+Nh3SRO8gicAScFCTUBN2kGg=;
 b=HwZUsWvLR85Vv3/5WwyoYIK10xREqwp7bg91MoL/wpEX5KdmDCKOuIV7cxiqj3lDGZ
 IZQ9OqRnCEN5hGim32fzFnnqzh+RWY64ykHtsbXWhEm/F4oHD+arlUZXtRQm5+LqZjRa
 4YBYGwfffrUOKwF+9I96L9GUPoi7Nx6yq+kjc45d+w1rTxmLo7FukcrlD5qTHjnt35Wv
 DxMuFRkd51qXpG5xZOh/0+fECNZ6WynA0uaxmd7AiSGee0kM48YPWuzRRQQEapXkBoCE
 pF7j2FmHc3GRVJpyyIWCgBJHZc5qYdiG+LhqOchVV1GSdXV/zdJrFzNOKi/hEuDwvq2g
 2bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092700; x=1792697500;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c3tCuSvB99B4uoLx5ZJ+Nh3SRO8gicAScFCTUBN2kGg=;
 b=DYmr+v1lS4agTmEFBoeKXKoJFnO9XUX8vfhfmcu1h0+YIjMIzNRjfMd/HsXfmTzF9L
 T6QK/Fw93SH08M7CAw6MrmoL9+FL7G8GXlqATmTJ46j1DpiM0X8Qbh5z7YmQMakX92p+
 Cgnt1l19+FrOwSJNMz4fux/FjQscai2zuzGdIdziOVZnvg9v8v4sWhJWOoGaLVCZpg2O
 vAC8tz5fflHoSE+uOwVyKMeYbf3qxEhRwMB2+OpsPf1obuyl1/CzJP4DPd4a/eoa42Pu
 RMr8FzV+8Bc7tYh7LtcOcmvRIwyOOPgggwZp8atGAX+lfXezzabJpGUHex2v98mxxao+
 /bhw==
X-Gm-Message-State: AFq9FYL8eH6QjYBIJWjUh2YDfUHVjmsle+AwSIyqpi8MAzy2+vg35cnJ
 Q/H0Ou2l5UeYp8Jsgw6VsJzh0kvKUF2uXofQ7a3Tg4g83qRVe4Yjvrzps2Kz9+loTUIcnHzPnzN
 KoWoBbWUfHS9imaPiQX4kPvjubVIENn0t+RGiQ5m/QY4KdYZelAAl2AH8g7KtGKl4Sg==
X-Gm-Gg: AYBFou0mTTnADKgT3hiGfOn3ZWUdFTVw5H/CuxxTE0RNBYrWF1wtLc6E429YBg3byaZ
 faU584RJHdFP3ABjsd0dXM0jkrbFDaE8WZGA0mGELQNslhzrta/XSfrF/4DHYPJERRvAdEU96BI
 j6OLbE93SOYUncy3K4Hh52Nckn+wZxxj4EUgFqN0tt2aq335RhAyijK9MlHCAR9W50Ba60K9mwv
 Vc7TLXt3iuJAn5fskSYAdXBCog/uWvUqYrgC+cyQdRPX+r4ZxU+A58XPHmz9hGihZ/Qp5gW1z46
 mznfmUUDspG/cbDZFILU5TXcwf2fbju0AvKEe4xFvCx51NrczZalJzgzVJPKle8w7QwQRDtH3MI
 lgO2X6pGLcQl7Ol3htz/ZkgLE1I2YOBjOkvcIDEGaPhjnF44++pdOLgDJOc4Q
X-Received: by 2002:a05:7301:3d10:b0:34d:96cb:d75e with SMTP id
 5a478bee46e88-3537e069fb9mr40486535eec.27.1792092699372; 
 Thu, 15 Oct 2026 12:31:39 -0700 (PDT)
X-Received: by 2002:a05:7301:3d10:b0:34d:96cb:d75e with SMTP id
 5a478bee46e88-3537e069fb9mr40485665eec.27.1792092688402; 
 Thu, 15 Oct 2026 12:31:28 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/20] target-info: add target_hexagon
Date: Thu, 15 Oct 2026 19:30:54 +0000
Message-ID: <20261015193112.145326-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX8LkhL7DgXiQ0
 YkPdK2zADxcdA9WmVe2iW3GfkrjvFPxd6eauSYGJwvGt6PzvX+tf724TI0YcEc2dcATI/YAiBoZ
 Knxlk56rmw/bpf8ZYUqjg5EMBuhb79A=
X-Proofpoint-ORIG-GUID: e9r8Cg4CsaptxTfI5rYyNy6d3-cLiy_p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX8bL8Z1epqT7u
 YViLd5BFpwBAbJZJg+QOpToQH8M+aioclX/hIMcaIN25UyI7bTtZfEFwtOkflYwBDs+bLIslUEt
 cdDg8bpsKjbGw791L0uVMVJcI+JCUly8fYwDiF3lVcY3nsPVHh0IGSa60bYXlbSa+mJIsyPZjA8
 6LqQhPTUM9AE5r+gO0y6Gv5vxdV9XfoU4KLhvJ5CYuUyjSUCK28QIaZotQSR8xywOpe6RM/yXdv
 ZCVJ8KIkw6lqdLKqOQkWFx5MIcwh9mQASESLqZ8e9l5ma6lh0Z9bpHyonRQddcCKEsDqmOB1dNF
 ZGjeHKGTCqykKqAHwSEpdObLZmoUBHYAArNAFk8Tfn3MP+RnVnGp9dLoYeZ6ZGIQeSK6T95KVjl
 NPB9ZgAFFPeMLPWlmPkFaxyYb2VBr7Pry4eP1f7nuAoaewoX4m7i3R4DafLO8yB+eaP7Ti9Coly
 PDlS43wS/WC/ELwXoOQ==
X-Proofpoint-GUID: e9r8Cg4CsaptxTfI5rYyNy6d3-cLiy_p
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a1c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zTXboHLKykkbUYI2VpAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index adda363ac39..862097c6c63 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -70,6 +70,13 @@ bool target_aarch64(void);
  */
 bool target_m68k(void);
 
+/**
+ * target_hexagon:
+ *
+ * Returns whether the target architecture is Hexagon.
+ */
+bool target_hexagon(void);
+
 /**
  * target_or1k:
  *
diff --git a/target-info.c b/target-info.c
index 6b365113955..254530d8ea5 100644
--- a/target-info.c
+++ b/target-info.c
@@ -68,6 +68,11 @@ bool target_m68k(void)
     return target_arch() == SYS_EMU_TARGET_M68K;
 }
 
+bool target_hexagon(void)
+{
+    return target_arch() == SYS_EMU_TARGET_HEXAGON;
+}
+
 bool target_or1k(void)
 {
     return target_arch() == SYS_EMU_TARGET_OR1K;
-- 
2.43.0


