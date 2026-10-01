Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E23ECA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKy4-00088T-OL; Thu, 01 Oct 2026 13:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxt-00085o-4A
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:53:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxr-0001rm-F5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:53:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691HUvKh2353177
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z0El8y1UPi4rBBlipj2PQNSZNuXkXFPICS/103bB8BM=; b=oWNMSxS98UwBMq61
 l7dBBFReUNTSxiBaJSN9DoT7dqrbt/3Y8siPr0UvPcheW0+BpNG1mDIoWsX8e+e9
 24KcHF0xypN8BM9aCmKoUFi30rYojNIdHrfuB+ma9jsDv7y8F0cgU6WRAUXn3dHc
 QCLXLuLQEhqLSQzhBNRY+pGOcpMvoyrs3qgC1J0EJn1SZ4zphsCkn+XCKqGMNwsc
 Et2naHMGt/mBPXJ4WYleBvwJ3w/tb5oHwgKAT5XWOk/xF8jvZp+g+VOuQ5Xd67gS
 WEVp5AKgS7N6+c2t62X7X3JJpJAj9x/tu3FxqIgNGoj7kOvSmonibp1txvPouiDG
 Z6puaQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v0304qq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:52 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-144d4ba280aso688238c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877171; x=1791481971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z0El8y1UPi4rBBlipj2PQNSZNuXkXFPICS/103bB8BM=;
 b=XeGra5KyHT72fKCk+la27LLGYCfaymuc2BYo842ci4LwwJRD2p0/i1WMhzAjXJKpfI
 YoPyaXaJU4w3AjBL63npAawP0Y8of8ZlvBL/ppPEy4gsa6NpfXmFc634ElMpFs8SNmF7
 ng2EBpvAfvqZ7mCZSLrCqOKgUyexyi9QCeZ0tFHBrOMIQULlSe6E6XeUakUypxQbptnR
 4tCMMusqtnTdVM6WllHRoUvB+lR/SO1SlPZrX+4HdG/vPFWIbeTPvED080V/K1rh/GL3
 0fx1KkHXZw5wk4XT7cd/oZDWomBqqBzWajXH6Kb3CusPeqeFAWn8xZmuSG171/jxynTM
 5vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877171; x=1791481971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z0El8y1UPi4rBBlipj2PQNSZNuXkXFPICS/103bB8BM=;
 b=UBMCuEeobl/cIfT0Dmo1QMoQJ9VS4g/BmaQ9HBG6SPGOHK/8mkFY5Xmli5rP5+tSQm
 hlZZE7xZ6k4NC2HXppne0f6eSq7KQWMFJXqHz4Zx7B29wo8s6VLz4EPvpJjkY/nFOVNI
 nvuA+LCFjMA5lfht6BqV4Bk3KiSJ/m6kCWImrOWxhcvSlIiH8udUeH047Bl7QbfGi9TF
 k/9dD+72VaT6pmMVYV4S2dQvG6pRSsY4Pxe/FMZVtPkWsgrRyFe2Iw3mJFDZmwGPHM6E
 BMUrDmY/ZmnA+5IHaCLBZUKZZKGuoSuT0KlOwI3T1jUE1Wm/osEKYJgDwPKIbxV3rLCe
 telw==
X-Gm-Message-State: AFuF++mWqMS9y5avyc0QlV4N+WGzie/TEuUcowAAtz9AMZ2ZS30bJjQO
 VAS6dWJ/5mFwIqbfNw5DeLZ17uVo00QyblRzex0WK3j/9kXh5Ow4M9fJUtiUZmZv+dCS39b7/k5
 M930yjzL9swCgyu798xf2ZEKwCUnC1hxoLYsaCyIPYGu5r10aTSTZuh1z4jSoXFmHZQ==
X-Gm-Gg: AYBFou2Df9ytcnD9kH1g2DdEcXuCeoK/xP+WHGzW0KdxQGXYFuvUg1XrxRrxclb185D
 rdj5KAHoMCyihOL+KebYJ66OnDnGusQLnl7nYtx6KLIU0TTLKq+So5hTPzQUpiS8fK/FVyMd+VF
 J/2bSBAZrM3eKLCw8FrbZppXEiMXSUGv0ExeDW0BoXZw7A2sCy1QeLMKqy1Zue5Zl0/i2n5pnkY
 ywy/6P2A+ThsAEjXgCKP6J1h3kegsgmfXd5FLQ9hJWplOeEJIhyUt79ICIgX9ieKtvYNGj2RkgA
 QHJAWnTGFFWniqVUiQh4sy+Dm2vrCQvCRyXo5c0j0NAD7E/zfw/lGq5KtcWunARJIOt1K//1bBy
 +XyPD2or8ibPEqRlsDQwODj+yyXr9GZSqe+X4ebfQ9ZWh6CiXESlLi/AbpsVU
X-Received: by 2002:a05:7022:ec84:b0:13c:e1e2:fc86 with SMTP id
 a92af1059eb24-14dd07fcb2bmr4397046c88.4.1790877171162; 
 Thu, 01 Oct 2026 10:52:51 -0700 (PDT)
X-Received: by 2002:a05:7022:ec84:b0:13c:e1e2:fc86 with SMTP id
 a92af1059eb24-14dd07fcb2bmr4396998c88.4.1790877170551; 
 Thu, 01 Oct 2026 10:52:50 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 26/27] tests/tcg/i386: Build test-i386-opt-shr
Date: Thu,  1 Oct 2026 17:52:02 +0000
Message-ID: <20261001175203.8673-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxZTB3KyqMuqa
 iXBlNPtYYqlGvYCBMnXCGGEU1HjmKYtd6AQP0woReUY8ftPuP5JPMWHF4U73Su3x92YFleBK70m
 7eFmNDrMOL9TS979pNL2mp2Pk+Vctag=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abe9df4 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zTXboHLKykkbUYI2VpAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: Q3C_PNPVG_UAVVI_fizvffCgAxJLTdVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX3RlSQHLk2Y7e
 yRLLLMMXqG3HYoBv//CvdvJbo/53NK7PnLe0RzCEM/PcdadzPl97Gr4SXN2EVsGRNlTpT4Pfpv9
 mRkwmhjV7MMu6WVfg4cG35gASlqTzs5OFzjUfw/qlGnsSIx86CqnRd5rGyaA2SagtZSSb+k90O5
 1hO3NHxs/++prEof43X6+5tmTi3MgujS6AnJpub25RoFFlzTKH1JbmOxK0rnwtljCSKhTahiwc5
 DqPcwC6RF4cNEsL+jmU10cHvTWvKRusGov67pbW2jpM2/yClwv/5RX+fDnhdJhZZh5PSEY8Bwc/
 zSJQUz9EiNX0IGcYo4wmnpvFpSSuD2mHjrP8MiqTd5knYGaJ81vAbqIn5FSxEjUiJ33/tUdsbJV
 i7ymnedrqKpl7mVOpFsNBlcMRC4D/8Xgx9RkqwPIIrlPlGOoOiS0RqS5fED8Rfu3tqQmZCrX6pq
 5AcELarQTo3HAEU10SA==
X-Proofpoint-ORIG-GUID: Q3C_PNPVG_UAVVI_fizvffCgAxJLTdVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010071
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

From: Dominic P <gcc@gcc.dp11.uk>

The old Makefile.target built every tests/tcg/i386/*.c.  The meson
conversion lists the tests explicitly and missed test-i386-opt-shr.c,
which 5fe51606146 had added in the meantime, so it is no longer built.

Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261001163751.172720-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 04d438a062a..38723d7f8df 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -28,6 +28,7 @@ tests += {
   'test-i386-fxtract.c': {},
   'test-i386-fyl2x.c': {},
   'test-i386-fyl2xp1.c': {},
+  'test-i386-opt-shr.c': {},
   'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
   'test-i386-pseudo-denormal.c': {},
   'test-i386-snan-convert.c': {},
-- 
2.43.0


