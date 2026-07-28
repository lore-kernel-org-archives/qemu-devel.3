Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C302C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZj0-0008Qw-UZ; Tue, 28 Jul 2026 00:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZiy-0007yZ-EQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZiw-000235-Ru
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aZ9f1714780
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=; b=Zj3Lzn4HMO2MFUt+
 Kj1ZKqB4RpoE20JViBFJt+/4MldzkYXzbUh76qX/RwOMDdS2C3Xoz0gptpLAeOOI
 xbfWSccNuWD3FOPeCIoz+9ZIpDV8m3tnlL/OIh3kRXd5XjSxMhmuJW+9sxiUE4Im
 QeFVnbF7Alc0ePZeoPBQtkJVmKGOAKJY8Dnj7WYTvCDw12wGnZfw0RkDFWCEuCpv
 L3d8jtvessxLnJMewCGOJCSZ3H7OpL1RvuB0dNMOeHdvxO6DciG/6JA7+PYoUOkS
 pY4ifCKlGIscJ0ZVP56zmSHKwXQHtwUjrqKB+EhU/DkX4SJ13hcwZIbOuIn/EYKo
 RGNN8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjyct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso66673385ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214045; x=1785818845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=;
 b=Ro02Dkt0IJnW9/1cPAUb5IzYc5u9wzSvTvVzrmE8USK7ir9MqKBtr9M0YrtxiAp2qY
 8FtMlPSqTD2DJduLNQJ5051jo9BZl8jz9hv0FBxtuW6vIpDalINDGB5JagQUKbjELKUP
 qSjlYxh1Z65u7gEaD5MGCqq3azGuDK/aDzksM0H8Fa+tsD0TAmaw4+Vjvki6o2MwkaGA
 H7ZjqRB/AP7VMMMshUoU3ui6oI5OgnxLFaNk3uG2ujkKisBmFhV4CstV9NUK7DRdWnAl
 pCUDfwZq70Aq/Bvw5et/uwJWE/yGoP/Nxilj8+3r3I1TLbSWELeCWB8TrYTwUuBa8Ug0
 mfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214045; x=1785818845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=;
 b=dBZ7C0hQCmSvZqRpaGcLMdBWzGA/m6heBRW87MBLwjlDWxKKwuhRp9pQCjiSU+osC9
 UzzNbq20DiI4CWlKYvdvdqFIkSAMQk9GLabIJ0MWA8EbCiSQx83MXT8ZpmxjD0PyEpLv
 OtWDWgUyrQDEWgcXex0mEVrQcTI2Y/Ws7cG3Vl8+0cHAywWV3K1wszdzHQE7ij3Oz1J5
 jGyG6JRtHj7MkFEkuiZnHeeVCPOc++GYbLCGIkkP3fCX4ZFnbbu2HgHZyMfAOMSMkpSE
 J4Xgk2RVQ0dbF8cmjxID0k0S/u2TM5JswFowZNA9RZk1rN80ruILi/MCJqKyRCZpTFnj
 zdrw==
X-Gm-Message-State: AOJu0YxFtJv5ZddZ+DzlUkfog5VFK7sE2DOOzNXfdR3DYBT4YDPy2Wgr
 HjOOIAddFhX13vcxoyq1J+upYBF/1G7NNZdW0/t/j4Mk72ryC9+3oaezeXSvb3v0egTfHOFIrrV
 Cy6Q0LUWA0dNVxlwA2mB/zcH2kw5IuX3G5piSO1jILlVWyLJBvQX+ESTtd6/gdYzrHA==
X-Gm-Gg: AR+sD10t+NAkZe8e+QnSuUNPwmPDmJW6rzL8dHxoJDmapI6CvBygz0CEQ8I+Ti5b7di
 q1s57RqGqsfWv5A5l3xB9v+odPBo+SBbPJZF6JDECOw3FQ4tdSukdXS9b5tElBdhv3pjhcYmZTr
 6V4SbVzABNNfMwSgxiqKVt9d9cVcE8mj+iT68aVTodiEsSoLZjp7NXQuOvg/wn0mdo7DluSv0U1
 Nf8pLcvGwjCPy6uXPkOwrqJwehDpBQGbjeHzSUR4N38CyaFUJMP590IpVpplZV0sDypj5PTbBTh
 3MOc3te1/OmQ01IcwegYMYhZDYTMRkKkMiQKnf+sBCqRZauZQ9eoEovMvzxYb3J+ZbhalkhImf8
 TlPyixfBQaHX9pj/qp1HFBgBXG/vb87xUPFfM6Pe6DKzaC5vPEZ5gc0XQylrcatIDTCjkP0U=
X-Received: by 2002:a05:6a21:3a93:b0:3c4:1916:9d40 with SMTP id
 adf61e73a8af0-3c8aafc0b30mr1171971637.12.1785214045029; 
 Mon, 27 Jul 2026 21:47:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a93:b0:3c4:1916:9d40 with SMTP id
 adf61e73a8af0-3c8aafc0b30mr1171932637.12.1785214044674; 
 Mon, 27 Jul 2026 21:47:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 040/103] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Mon, 27 Jul 2026 21:41:44 -0700
Message-ID: <20260728044248.137626-41-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9m8g8CbJjAKB3RjJAqPAboU-cfBdKeIm
X-Proofpoint-GUID: 9m8g8CbJjAKB3RjJAqPAboU-cfBdKeIm
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68345d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4Gh5T0g__NNyS1BPEC0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXzJnsrOCXHxWj
 5lddPgPg5BYPfxlm9UsTAvSpHevQfwERTacXH+c6li3gxFmsGF3R6nH4smpNnFFQ3S4oqyYUu2v
 nsxUbkykkMh5T9ALGxoumT9WJgdb8GsVFtWauCXNGZVFm/7IXkbMshKebqWeW6aOf41tvopRd5g
 YOWP0lWyNw+eNVwgqrnJEwkxQFxeGuGuNcoKMHya+ZKfHl8wq7TLk1P4gSGopmUriiSeVWlnVOs
 txmyHm7FtTkJUSMomNMCNnaxdgpzevydf80fcIm5vJfIQC+PYLN3XYY5RTI3e2/9+iC0UGX5ckg
 pqpxflKDW5V1bNjXc0DHqb38Mpw2/SHZCw/yU+zpuqf3MoP11BP+R9JyekkDzPBIBKRGX1hUCC6
 3smptCpv7FuGU3qpmMRAQjY8r1tSRmIl3TBrLFAB9MLs5OHW6KLUQD9bZJFHVrwj8spCqXgA/5v
 VvPxyUZeqEOaZOQcvrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX1W1l1LF+Tdd3
 dC41BCxwR3dhAdEsCV9G/zDqb+gQBWtFbcfz5qLnWXoh/zPqIFpF1DGWjNJmaqophOVZnNihjBw
 MLOIe4FwBHk9Ip9wMs3ljuMCO5NT5+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/gpc-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
index f26b23efafe..0ce0ffea277 100644
--- a/tests/tcg/aarch64/system/gpc-test.c
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -28,7 +28,6 @@ const uint32_t gpis_per_64_bits = 16;
 
 int main(uint64_t sp)
 {
-    uint64_t out;
     uint64_t pfr0;
     uint64_t gpt_base;
     uint64_t rme_status;
@@ -38,10 +37,6 @@ int main(uint64_t sp)
     uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
     uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
 
-    /* Mask is FNG1, FNG0, and A2 */
-    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
     get_sys_reg("CurrentEL", currentel_raw);
     currentel = (currentel_raw >> 2) & 0x3;
 
-- 
2.47.3


