Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08160C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9O-0003XA-65; Fri, 26 Jun 2026 19:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9M-0003VD-63
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9K-00042T-M1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxh9W2793983
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X0ETRuFo76ALMbt8d1kKF5xibZCT71RPU8tqEx6CAQs=; b=RCFZQZRyt2UdfxcY
 TSaRexREJ0XUt8Q8GbxIvESp8+OswaiuIHh+UAX1WSzaJBCT3OvJAKpNRuTOzc8r
 3ZWatR5gWqMx9CJ0ha6gjv1Vc6ywZ/e5YDM3YJEue+K9mRdfW16wn3WjK3/4Z6+J
 KLB8SYCDXAsNMDOx1acnC3nO3STR0c502Bq0oeVecOQVU2pkjGSYhcGZruuIiuxn
 xf5G+3859N6O80001iVcA/LcSPM3nekvAuJySOVZL3uIRAtK19PZUy4JFXmWlvFl
 oHe0m8iGzS4qva4reDghgRQcRs3lSQEfeHQo0HxBBCLavgXqDelcS87JDuQ44SCr
 0ox9Zw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1tc3hyty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c62861b3bso3652667eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517183; x=1783121983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0ETRuFo76ALMbt8d1kKF5xibZCT71RPU8tqEx6CAQs=;
 b=OQ5P7RNOCXaald+uAxxMPqVSBEv2uyoE7p7XmeE/+MDzgsCcHK8FlbgIeMqnUw5bSf
 p2MCK2mJA58aGEg8JZ5EvJYsXe2NaBoCDvF0TvZGqrlW3C4C02Pv4YHiYGu2x+hqjnix
 8eOJxNcnB9Oh7NIk+lWnCjMr+mRyj3o6amfBfBft7+d1ppwvqm6m5U63xNSRigY6odTX
 NGpcsdWQPh65nPeDF5FbHD1TMaU+I0sCOatK7tik9g792XubDjvmoN5OKJ8WJXo4Ot4d
 6SokUk+lCznTnWsrQS2VmJt97Tvu9iPbn5YyWHV0q2xoX2fx+a5HPwgwqKSxX9TDVRPs
 LCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517183; x=1783121983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0ETRuFo76ALMbt8d1kKF5xibZCT71RPU8tqEx6CAQs=;
 b=bStiwHqV1S5ItudIApWkT6UAZZDrvoP6qzfz5VtayCvIhqLKhuWfA3uYhDSBmN+ah+
 inDQm0cOFbzWX4sDOODjuL6MSBizsaxvTGGVhuqXYwwCPZJu46OPqaz1bZ4MWGuimMUk
 zp7G97YoyorQBADpDx5HS3V0ORKg0Lqc0a7BKFtlD3KvlTJiTEp7r3PWgDaWmZGr/iAe
 ZNLf8CWNgRbqZXnE2djAQ6iMpAy+Q0adu6ZYxrvlkB+mtzRaWeYrF3rHfWCZMiRFRTD3
 8CJKtzz2D3RrNXsIZ/ncQy0tpD259KUbzpMTag3W6mKRHoXDKqQRpvUNTgGgHk946sL9
 Nang==
X-Gm-Message-State: AOJu0YwXupscaTN1U7nmZVQKl5Poey5rmEqwMpOrrHd7UVvtY3mqxvOH
 vbV/YckjzwTZaTFMmnBK4DQNeiEBD6dut5sSepzwOvUIr+yFTjlCcXQqNhKPGW25wvKsjyCeB4W
 hNTE04TewjHetFOMHOVToDgIZ3jGPygllprldme5ECm5CS5+3LqHp78pxLABiqKBA4g==
X-Gm-Gg: AfdE7cmEai/hApQVbtoRjoKCp/ZQbOSFIYsPSHQmKILzBKN6Zk3PHy289KzzYIRk+Og
 WKWUmHGLj2VEObJGzHmZN3TpU7senzOC9J00K5pY5Xk2rdc2hjnE9TYQy8qvhCukL9xCQp+xLKj
 h/RMxeqWbx0OllkTasjdLPKLnYsBVn9RZJwpO/SYUGu0Wlyv5zsZK6f0v89g9B26yjEYTZPCMGa
 vlI5Ww25Xwo2ny2CrnGZFBexmLdZ3sA1LXi9yzPH3hzCkod7Hz6vPy8/fZN9p3/8pyhREbTBDZs
 iLccD9TPiAK9AawvERQzGY7D4ieqHNv1AjpcIPCdI9gIMzaEa2uGE7mxRCXNJFGDiPF4S+5FY2Z
 k8rsrOHlHG/JQYL/Lmyghef4IArLmbaUHzTFSBVl2m+/B0AB4+xZQ4bvvsI5l7OUgWEGSl/Ge8a
 ybx7SSLw==
X-Received: by 2002:a05:7300:a145:b0:30c:38e8:54da with SMTP id
 5a478bee46e88-30cab36a243mr2518960eec.24.1782517182707; 
 Fri, 26 Jun 2026 16:39:42 -0700 (PDT)
X-Received: by 2002:a05:7300:a145:b0:30c:38e8:54da with SMTP id
 5a478bee46e88-30cab36a243mr2518919eec.24.1782517182214; 
 Fri, 26 Jun 2026 16:39:42 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 14/37] tests/tcg/meson.build: add default flag for testing
 compiler support
Date: Fri, 26 Jun 2026 16:38:55 -0700
Message-ID: <20260626233918.158740-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zSAXcTT31qhcOQIJ_o3KWXpoiZkzlvKK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX2lGTvRIVcCKT
 lNQHPgCZn90Ze0+eGnnnbtyN6q4UyplsBlT7laIBfLmO/hmI+BD4PM7cjZrD/cE3QRvEceSrPAg
 qWfoxljjWiXrsbWZivjYFd+sWzs21uo=
X-Proofpoint-ORIG-GUID: zSAXcTT31qhcOQIJ_o3KWXpoiZkzlvKK
X-Authority-Analysis: v=2.4 cv=T4m8ifKQ c=1 sm=1 tr=0 ts=6a3f0dbf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX60Bojv5wYIwm
 mKjDnA8v2LL+r9quNOmsC54X25G1UKyO2wKC17rdv1O+f8u/7GWVLG/pkXHk5uQpd9gCDbslyUd
 aNs2knfRofe8En2woEn0I7+/zbGHpbsH59FSXxr8Gvode68LrVtSiFKJAUfevVgzcQxy4oE6HZG
 kPfjqaJjk5F97+XfRIXueUq7R1LkLGRzcHv1c7kJ4EtA62Nstkh4KOvtGXYyKfpithnEGhXyaet
 CaRgXkelXH2vbE4rb7+gGf1f5qWaSytnXM66NsgJ5vvr2+tXYTgIOlzIasvwcq9z47idsQeWHJE
 jzM3tsnQm+EBVx5NQG2D54vuQkq0PounUm65JvBo6T2EUdGmLVF16vrirmkXMyJUGaCA8Hnoc9m
 JIDtP1IMlOnPCihV/Dx0fOxyMWW4E3t9IKNBLj5TbQT9+gQ40F9qVAwj6u1EpqlmaFpfop99Xky
 1IL/Oan/Yb3G4GvEQOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This global variable can be used as cflags when checking if a compiler
supports specific flags.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 35af4c609dd..fa9c0d15342 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,3 +1,4 @@
+cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
 env = find_program('env')
 
 gdb_progs = ['gdb-multiarch', 'gdb']
-- 
2.47.3


