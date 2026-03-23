Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F1DF46100
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8q-0000KC-3h; Mon, 23 Mar 2026 09:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8k-0000IZ-1n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8i-0000N4-Gi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NAJpBk1584563
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pmIXsZGoP1S
 2sx8U8Y5xa8Km1onyIRUsMobLhRC9lrU=; b=MpMwI7bgckRf7upOctVlhRfkA7A
 WTQ3yqZ0NAw2PZyAF4tO2zRucheYjiWHyEg2w9droLkCb0bY+KgBVbY8pY4+otM/
 IkxgQ6UbT6XWOBHOVaq2FnXCCMTI9QG8BmvEr9d7yrAxWvlxszjXWUBfV2EHsFF5
 TfWNdf86jeWHJZKZ9JOX3FPctGfdjsEe8dlXoVtM2eopfiLiMHziZHDIysjGViF8
 jmSo+dt7Wx0+j9GC8tGs4w0oE9oLIIMLk2B/XnrVCDcRMd8Yl9yRImyInx5LBt8c
 zzZMjEfGSsgEyrTRKE/LsaviTkyJKJotH4NxmX/ly1+5zNPYiHCYOokod+g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jng5fvu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so145539eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271764; x=1774876564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmIXsZGoP1S2sx8U8Y5xa8Km1onyIRUsMobLhRC9lrU=;
 b=X5FbaGytGxs4FuJSfsEQQ84WjHuMb0l5QEpwxDAnQye/0eHuQewZdVhGIxEqjq0x8N
 q5GOa1BDDN8kqKrzJsKqkkY+B7Sx70iGCndtdwr8c4+CzWb8CAaMVCgBZfq2mO3n97LS
 i9WG9l5ztRWcmLtXSTujcOGpUiIRCvnC8C6Rs41dSau0ASSgITU+Jpl7By5QqLjgBgO2
 uA0rDrc8/rk6qg1UE8dy9cRepxorsUb3Y1fboCMutAgGtxCdqQNW1kn4wL0j7OaNjjaw
 9loDw1N8AEOR43E4W6+Qibedjc9CCaWYFYDU7m2CH/rNoKatsvUdKzY8p/4aio7xHkSP
 wt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271764; x=1774876564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmIXsZGoP1S2sx8U8Y5xa8Km1onyIRUsMobLhRC9lrU=;
 b=BQ3WoVIy8ZF2WPvZ7iOmJvG8KSAhbjQSB58Enj4YoPtFx27zwTF/DMVWHEUyBeMMWC
 JJsfzJyIX16p9leo7exv0e9VDn4WqYQy1jaYXH5M8zmy7YEF45X2roii61zd9enILNAs
 Ji1lzvIA1JZ8kPr3FRMpJ6nlzytMKVl5SrD34R6XdeRRpxSg0i3HKTexyEwMKUbMqUCL
 +9l8266ax3Uh9ABL4uxTxf4JW5AlF1rZVIwAit7Dk4IXIz5mKXXpE1ByWfMmz+XNjzfv
 2uIx8gQpqzJGwdPMAjGK7djve0LxTnJNCFiBZNPOVpCM0FB9m/tcqXuXegqcHzBUq9ap
 Ds8Q==
X-Gm-Message-State: AOJu0Yw5SSebE4EjdOOWZNWcIka09PZiUFdprYKQbyfkoVERtEWvLdl+
 MDVNE6zfS6V5glORljpnNlt3a5Q5KgLD+e+bAic3f7NgTF3wrzjW/YQykTjfFft9FNS/MaB+sg5
 pe//+bBmfU13hxQuaMIVV/gtmA/x9hiLvjc4IZ51b2pi4vR2JKqRCTNQHlwMIfzs9XPBn
X-Gm-Gg: ATEYQzx4c2LWDXG/EEbxrmliIwIklOMSjh7VqWG0OXKYNZRy2gZPyqO2WK5iJ9wy1a1
 /A8K8vyoaWsDpz+q/eel9Xi+UWq1PCs5rUrS4izekPlUvIiLepdUh36MS7My+h80aoJGinjtA8a
 gSCSadHP8ecQP4jQb95kKDZtr8ipThNTuU55sbNXw7DfXLM4mcvPYvbGCW2noRcftJhKGX9b7zP
 4hHu0c9OHIvvBnz9qvzmAlnL2B0zRcdG0zvFOF9vMDJ95LOa8FDLAvJS0FipXk7GDBcc/MyLunL
 y/Fq/IQgRSjTT00XISJ7fjSWOJjqeFXIkOK4wXsHLWvNoW5kpHGzvWkLAD2YmEwsXSH8GRXBCci
 hhsYaYA0dEAShMr9d1gtjB9QK2ltuGXUXnQkMQN+hogVpL6DzgCYJStPRNLjEmUlhqVuAgxeoZz
 FBqVgi+LqS
X-Received: by 2002:a05:7300:3252:b0:2be:80c4:2c8c with SMTP id
 5a478bee46e88-2c1095fe003mr5072170eec.8.1774271763884; 
 Mon, 23 Mar 2026 06:16:03 -0700 (PDT)
X-Received: by 2002:a05:7300:3252:b0:2be:80c4:2c8c with SMTP id
 5a478bee46e88-2c1095fe003mr5072132eec.8.1774271763114; 
 Mon, 23 Mar 2026 06:16:03 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:16:02 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 11/13] tests/hexagon: add tests for v68 HVX IEEE float min/max
Date: Mon, 23 Mar 2026 06:15:47 -0700
Message-Id: <de0eb7d07cdae77e9803feccae79f5c9f29277d6.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nBVRJPhJvd8gvmRc9t9xMxxgv4V3IftQ
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=69c13d15 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=xhxbJrj1hkZauH2664MA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: nBVRJPhJvd8gvmRc9t9xMxxgv4V3IftQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX5pRvffsO33x+
 QKOVRJgueZzTsNfjc8b45ucC65XWPk5IxlATSv03nhF0VIgO6FB9EAVdRE7C/ikSOn8vlzdFfjq
 4GBKaSShGK0WXIN8h+EBYp0M5z5UFzlkkOmnL8WnBmlbzxF/10DZMNwQmyogg/mFplhumTi/meG
 iO9NpSooPYD9RpacBAcufOPRbDs1hwd93vlDRhkFUEdiuQFfZVBtsTl+30UvTOe2U5NKluRe7Ww
 8b5laB2giaV23glHEmFTGQt/g1i4t1vcp0d3ZEHB5jIvEQOb+JBRslEn959rjZW9CPqheIi80oh
 CHYSFITvZy2AZZlyoUOWoUu8K/M6X3N/dDqovTS1WiA2Ksk4nlMSkhK3QvAswa7YCO6Z01h6hfW
 iXdOLSVmKh4H7i7SANPO/RwyIfgbJ8O7jiNBvLANJ8IHZg1cSgQ3U1QnmrA8ML5TsAQtTWvbZiS
 ZW/IoqLKU2Nh6Xhh28Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/fp_hvx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
index 85b8ff78ed..ded3a80f8f 100644
--- a/tests/tcg/hexagon/fp_hvx.c
+++ b/tests/tcg/hexagon/fp_hvx.c
@@ -73,6 +73,21 @@ DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);
 DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);
 DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
 
+#define MIN(X, Y, DEF_NAN) \
+    ((isnan(X) || isnan(Y)) ? DEF_NAN : ((X) < (Y) ? (X) : (Y)))
+#define MAX(X, Y, DEF_NAN) \
+    ((isnan(X) || isnan(Y)) ? DEF_NAN : ((X) > (Y) ? (X) : (Y)))
+
+#define MIN_HF(X, Y) MIN(X, Y, NAN_HF)
+#define MAX_HF(X, Y) MAX(X, Y, NAN_HF)
+#define MIN_SF(X, Y) MIN(X, Y, NAN_SF)
+#define MAX_SF(X, Y) MAX(X, Y, NAN_SF)
+
+DEF_TEST_OP_2(vfmin, MIN_SF, sf, sf);
+DEF_TEST_OP_2(vfmax, MAX_SF, sf, sf);
+DEF_TEST_OP_2(vfmin, MIN_HF, hf, hf);
+DEF_TEST_OP_2(vfmax, MAX_HF, hf, hf);
+
 /******************************************************************************
  * Other tests
  *****************************************************************************/
@@ -124,6 +139,12 @@ int main(void)
     test_vdmpy_sf_hf(false);
     test_vdmpy_sf_hf(true);
 
+    /* min/max */
+    test_vfmin_sf_sf();
+    test_vfmin_hf_hf();
+    test_vfmax_sf_sf();
+    test_vfmax_hf_hf();
+
     puts(err ? "FAIL" : "PASS");
     return err ? 1 : 0;
 }
-- 
2.37.2


