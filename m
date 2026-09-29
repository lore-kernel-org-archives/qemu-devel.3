Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66681CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSB-000340-Rg; Tue, 29 Sep 2026 03:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSA-00033O-5o
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS8-0005ox-FX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7U3eW3127855
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s9VvBROy6O3
 Q20R1HmvYgTY+AJHnpSAEsa6YM5GBOr8=; b=pzsjqiBlmpUXz/q7Rx5iu/VpqYG
 LonJO2eRNYPGchCX6dnF8dFwd4jXSrJk9mqWNKQt+CBOsv0P83htwhXfXgfkjbkA
 GwC+zuBArcIBsfymn9zduUXxuwVtStNM3RPhpOlw4ACjBlLjvxtpLJ7pjQhHrzMb
 6kG8K5Kjm3KJ7zfxhsqtaEUGE7wZe1F3k6Kw+uBo6jLq8ymosuAj9TQrU8oUXwkg
 qqEcyzk8pN6p6vBCq+gPFxjtfFUXJIcHJCAnKEomTvqFI4K9YseK3MRbH3hPtm98
 FNqk9dvdws67XOShsLS6n8o4elgaEbOpdGwj5Gz4gCSir9pmZcjYb1a1IzQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mjhfep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34344599f01so2042260eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667638; x=1791272438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s9VvBROy6O3Q20R1HmvYgTY+AJHnpSAEsa6YM5GBOr8=;
 b=blo2k82nkiDXI5bCUbcYW3LmRKC5c96VmC5saEgOosUPLCzKldaxXp62QXtfCWJqPJ
 DAGREJPKuIIePzl4C8S1E9okNrk/LdUeZt9XlC2s4SNr/d8CwIWkWmBLy86CsgoQ1/XS
 Cad8hwS+CKgcCQ23C0p/q/974vrT2qG2Ksu6Ct8/f/TBnqk2UcM/UAvj3LQes9MtBiQm
 eii8La4df9bVaM48/3YQp7BGqUX0NWTBNpTsDSbxEElUncex5Uh9hTBErLdmVe2uXCIg
 Q6yd7Zpu6pt4L9AKuz073ThcPVz+R4wVqPnok5g6TLkjPFPI9CzljpyDaDo7lXhOtlW6
 0tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667638; x=1791272438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s9VvBROy6O3Q20R1HmvYgTY+AJHnpSAEsa6YM5GBOr8=;
 b=anFA19hdAfQpcCYCSJJY9C8424i2mUJMin2o2NMtBERjL80TEzEktJMYtgV133aUNm
 eQq5LnwzUsHN5TSBakAFHlpCIG8cYg4f0gEX9x2ykj+H04bHUq+VVZRtiPKPDLXXlzu2
 Pbbq2CleKkJPJmhs0A4m6zSs7wT1QwW2RiXjcO8SFpxrYfQRT5R1+I3xRh71AojnSRWz
 7ZkdpWb+tk/oXCRAFMf1GyTQIq6scUHkwDKofeagqaoYvSFU2eXd1jt84CsB6OL5+5Lm
 OQyL01YFZHWFYUhetbH8YEgfJNvP9A43xnv7dcS/1gQ50DEYTZDnkGGNyYV2R7iD+x5l
 SU5w==
X-Gm-Message-State: AFq9FYIZZdlNAnsqXVMPckyFdQ7nP2A0PkFhqaeDr/Nw1UsBxqBhtESb
 WQT44ODLt8cTP+8anz4elGtyEmshRkJoCOgo+cUXl0DqybJQvpfc9ojRfBPUgQjmhmzcjt5c9pB
 6JsopH1pQNyB72W6Yn61axkm8jSKaviI4alKqeYtnC9GuRZBBW/stuLxBJROzeWp+qg==
X-Gm-Gg: AYBFou15v4fxeAW7Pmq2Xhp/a03BGDiiC5uCyk/cslmH9kjTeUhg1wVtzyONCf33+1i
 K/DFK6LTZFmPhKcHOfil7RkKU5FIN2Ogfu34RsT+ycL63PTcXgCngjpVHxbhgnHYv/clNQFicc1
 PxOwUhgR8Xneh6j9pNLoYNY0qeUko1UNywkwWnp2mfw76Ex+Upv+X+uE+p/shsnGP5GsNP67s8k
 loJ6HdVvQRQsUIAPf/OM3BP/S3udwdjfdFHQLDaWyrSVoYhuI8caQNhpuCgZTKQfuzxs9hHuDTP
 iE+NHIn4wOkXIWxT1ZbrHpp7MzhwusZaB6SIrQUCKamvUkvPNGi5UPJ/0wUB0TI0AcHWM3gDZdh
 2iL8jzLsay8m95A1XHIKdc4ZpICR07wMgvfZebYmOPdshUjQxtmjuHVFJrw==
X-Received: by 2002:a05:7301:24:b0:33c:3134:1055 with SMTP id
 5a478bee46e88-342707aa7eemr11899588eec.12.1790667638267; 
 Tue, 29 Sep 2026 00:40:38 -0700 (PDT)
X-Received: by 2002:a05:7301:24:b0:33c:3134:1055 with SMTP id
 5a478bee46e88-342707aa7eemr11899564eec.12.1790667637701; 
 Tue, 29 Sep 2026 00:40:37 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 06/19] tests/tcg/mips64: move octeon test here
Date: Tue, 29 Sep 2026 07:39:54 +0000
Message-ID: <20260929074007.118970-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX7wXWnj6RMtkB
 I74pRIOFBzFcP4h1HcEPYb69UTQscvWLVjCZlUHNcfv2OKdj05HhO0YPhpXbaUybyxd8xIBA1aV
 4HKpzSuuY1c07x9LMQ+jHwY+47Y2icO2cjCAirhXqZPwd5HBvuFqVl/eEU6YWukqew6QkmqKRDp
 r9JSWktBYrIBICymFKVeZD3SGpRZliqrqTh8oPLD5u/pIgOnIfN3JSA0m9zcywigez4yLET2txg
 nn6FgnL9Lx08x3SMqY4q7Hfginx9KXiSmuFjmO3Gyxy3PAT8dFxVcghz84Qj6Xke55k2thiEMGh
 5HDxfyZJ4i80BuFjeZ8l5ruuyX3MGByZjvVDUAlCOn0qEXp7blUtbuagQSmPFeYcLIxQ9sMNm2F
 gbVSlXWsL3QUIrUrVc9mnTLtQm8qhUxm5yac9RIRvdILZgT797XFhGyzTx6d9AH4+oX3VnqVUUy
 6zuC3BN9lwQPqAU7KKw==
X-Authority-Analysis: v=2.4 cv=OdgNnRTY c=1 sm=1 tr=0 ts=6abb6b77 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=nOWy_JZj0ApRBHP5Z1UA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX3EeR2PpuqFIe
 5fXiJf9NQ9fY4z95WHxVdpmsYbvh4xUp9rRPggb5Ec50sAYlrUHdBF2DXbPwgvuObKlrDFAWuXn
 AD3jVG4Ykzh0HhUWlEuWifiTk3wvtSo=
X-Proofpoint-ORIG-GUID: QhOrqSbu92QQK1F1agdIFfnEuEZ8IBgk
X-Proofpoint-GUID: QhOrqSbu92QQK1F1agdIFfnEuEZ8IBgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290030
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build                              | 2 +-
 tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c (100%)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index b8eb6705eae..a324a16d671 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -3,7 +3,7 @@ tests = []
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests += {
-  '../mips/user/isa/octeon/octeon-insns.c': {
+  '../mips64/octeon-insns.c': {
     'qemu_args': ['-cpu', 'Octeon68XX'],
   },
 }
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
similarity index 100%
rename from tests/tcg/mips/user/isa/octeon/octeon-insns.c
rename to tests/tcg/mips64/octeon-insns.c
-- 
2.43.0


