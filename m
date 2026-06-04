Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472BCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFzA-0006tv-3x; Thu, 04 Jun 2026 17:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFz6-0006sI-4Z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyy-0006ii-TP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654J5gvN2477948
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zhE93q81gxA
 MzK/KaL1PyUdYcq106MdhLT62ci/xC6Y=; b=cRgVhGQUHu4UVO8BEwDopgvtW7w
 EE3LoF8IIUdO57HFYai9RwWSit4NgTvXy+/rSgnjIX/srR0LUk5UgzEbumAIDVO2
 WXb4XQq359Sf+jZLRzFVzt5bee9QoSYj0OYMOX/IpHF0TsBUDuTscYLOp8caws5H
 MwQRHSEpIe86MXK47/aVob5nkHujPMzZCvWyIYoK8PLGn7+7fK5V3N6JW0SFSlgb
 WtUKKV1SUZHvqZY//ZGok5X7hoQ+1MJt8UyC8MqaiVNCNFMzXYUKL/i0PJ4oJBuw
 NaeAVf4U+j6tJCsnYAUWS2C5AHUotRkMYhSJGpMM0lJACF+BAZagPnv4cHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvktyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:52:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304f1820babso1550294eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780609926; x=1781214726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhE93q81gxAMzK/KaL1PyUdYcq106MdhLT62ci/xC6Y=;
 b=Jx+eu99ZljC1QKlKJjirDhB/+FEIbWuNVgjNABxGWK+IWHaiI+YTKLINue19pBZj5A
 ebPGfJQ77mfnR68izWKvhErK6SN+a3NwSnNig4N0ujeyuLstBvfCbr4BolCEeVKzOswq
 GqM9rw/niqn5JnHeAXFFJw5oNWgIPe0FH7ab30lbZ42qvDCUyN5MdHeiwb8ykCwlILKw
 jiIJkMoWLE8svMpH/rpOKO5tvrGpSv0fqbgHKSifF/gyZOEMYFTxlJoDJMaQ4fqHncZ+
 FD4XkYNbCI2JwzoyzfhBOBd14O5IFK2UK+1BXowlbHCebq7Ce+Rq1y0HZlqM8iZ2GjWT
 8unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780609926; x=1781214726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zhE93q81gxAMzK/KaL1PyUdYcq106MdhLT62ci/xC6Y=;
 b=W8L6tYWYDzip4xJTjcj0I8MQhwSejpBwFMR1eHZMa8Y3t4UpGo7Of6Uh6Jjfv1dti2
 g3P/exJP6zenFOfqmpIA3e33cBggfXgIgvmBoKDUPznCEkAfkAv2Em4CruqFFU+rr1bN
 3Pl590dyXnzh+JwZ2VQOAYYnpsXuisSCTHUkwc/gWkTMu5L6JKFkJjYN8u6waTfqUozG
 SaW00L6bW4U09qMhfA63l7cSsfXOE5wRZ8Qj+vZwB5S2PV83UkdNOTYEy/eJEVYh1yUr
 SY/OZgC+nTTG87barsjBulQBCNZhf9jyB842dvKknL8pevjiOWTg7sOSwa1EevfKq4Oi
 r2Qg==
X-Gm-Message-State: AOJu0YwkWfeFQbGKhM4G0s7rIV7yBq1DiSmNLiDZW99qR5+SoWsoqKdl
 U+/15YM82YK2L9AFAZ9R7K4ZREMCQNUMG6JDslZMOGRMkuOCO7MvSBNgAPf0HFzMC7zunUug7CC
 /3k2YubuEWcYntPIqEcoaXfFRXbKzsjKWHycrt3DjSy7HJEVRbIfRNzTpY0EcEa8pSzYz
X-Gm-Gg: Acq92OG1tK0Q8blu3ELkpIhSaTB5bg3tTerLSkfaZM2lss4CB3EVfP1MA70q0w+oLPg
 HSz+oLeHkfVeQpwo3xh02BHjxCvlhy5F9WoqTrI1lUMkfI48dRT9fPVuOMts+ooI9jAK4M8o9gs
 nVIOrhBTaEqP7t0vBt3M0zrejeMLoBBwC4pxOEcH2BQwz6oVwEpjwBYmHXv1D5w6uIhP8G3sspD
 HWq3jzecQPLQTDkom696zZdJdqq5UsE5dcNhiN1s70DLzuJZlY7NHmncjatsstIXrGmvfIhH/mN
 Fvjer+xULTEpLR8AakIUqSsXWTUk89u32mhyBS65EpttiF88/FEkULxBOM4rNBohgiY/LuDWLfH
 sOl+YmClItKdxv+VDIrdavsHM9T1bPpug1LZOS49puBbSHhPjW5VzLmOiV3z1pxNat+4/7Fb6Q/
 KIPOyx8BEMCAjxf5yq
X-Received: by 2002:a05:7300:724e:b0:2f2:6dde:df50 with SMTP id
 5a478bee46e88-3077b594ea3mr310747eec.17.1780609925664; 
 Thu, 04 Jun 2026 14:52:05 -0700 (PDT)
X-Received: by 2002:a05:7300:724e:b0:2f2:6dde:df50 with SMTP id
 5a478bee46e88-3077b594ea3mr310732eec.17.1780609925113; 
 Thu, 04 Jun 2026 14:52:05 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5270115eec.25.2026.06.04.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 14:52:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] docs: update mention to ubuntu2204
Date: Thu,  4 Jun 2026 14:51:45 -0700
Message-ID: <20260604215148.3769627-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t8Un1bUGNuD2uQQuLKo98uLovMTKPKp9
X-Proofpoint-ORIG-GUID: t8Un1bUGNuD2uQQuLKo98uLovMTKPKp9
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a21f386 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=vLs1zl3SwQCVldxWroMA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfX/CFXJxawbtX+
 8xA4UESImgZSi7wwDmIjtiAb66/AiCNrPzosuccIfC//b9BnR9mzmTMyZBlg9Yl2zLurEI3ba0/
 C/FCuHSqgnL+5HZ+75HgQs9O5X3HEqnpVvyQ5PdkGBmDifLeh/zfT5aY1CD7SrZRMEj2/mLBozC
 p9Dq2Fh2d5wJGMcFJzxR4yJ3GZj5ewXhxg+olphnhwSQEfGYjnuhn1wJUALH+pjJfqRlYxkQ8Yy
 QSFWQWid8hvA5+3Y6eKO7ehyajSinLWqceEk/uLMmrwD+NlnvZ+bpyD2TQ2Wigp6LZf24fTUBKh
 1/oGfMgCguPYFhUo0XAnl5pTHpABNYJvVYfNhXeY0p1rxnPbEuwh+0znNiX/MMSRGY3GBeGhDRh
 ZGmC6LEEVegL2kYAgN+m1UOxo9V0bpDr+uA7ficGfXwvjGQaWsrv+JEfSS8nWx7kN6+TaR1cglg
 bgAnk/9eIA+wCFPbqaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040214
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/testing/main.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 3408b5836dc..1a884da3eb6 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -711,13 +711,13 @@ https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
 
 Thread Sanitizer in Docker
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-TSan is currently supported in the ubuntu2204 docker.
+TSan is currently supported in the ubuntu2404 docker.
 
 The test-tsan test will build using TSan and then run make check.
 
 .. code::
 
-  make docker-test-tsan@ubuntu2204
+  make docker-test-tsan@ubuntu2404
 
 TSan warnings under docker are placed in files located at build/tsan/.
 
-- 
2.43.0


