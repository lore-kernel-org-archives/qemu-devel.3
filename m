Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6247CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5ch-0001zi-1O; Tue, 07 Jul 2026 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cD-0001s4-Sm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cB-0000Tu-F8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8x7F3719152
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xc+tMxSyHDkaEQ13iyZi4Bg0l9zwBc8qedmGedZWFmI=; b=FWMKc88cfi87F/9b
 2/KdoCgbzzpo+0FS3cJhy+FrbSwuw0NAb/IiChddSIF6AHXESMEZ+FzxXa4+D5kZ
 fuarPrJPKuxgJROmqxT4dc0ZXuNWeJQ9sljk6B7sKsDiVBWPHF9fnL0aF39hleQk
 u6wo49qfDJIfaP6Yf8GXZJ7DuLDyoQL7vYSoBRx9lw1jnJe8tVV9pxbfm7rmUxmK
 PYdkzlDLDGGSqcj6WNYl7Cg08JomJaDg7QQCyFokmgzMlZW36jGIKymaiJrLZaVk
 FitwiaLy3lspEPfpbpL0Vc2Je4x7i0TAnyqWF1CE09Ff+6Bb2GgrS0BAGjtX/xwD
 NigfUg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t9mj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517e054fe07so77443661cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430009; x=1784034809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xc+tMxSyHDkaEQ13iyZi4Bg0l9zwBc8qedmGedZWFmI=;
 b=S/8NAYb/7GatYw7mm0nbXiwfhJvJy38n5CsjpPGhKRfmTPHfs7tdG+VnrPbuzsxASK
 C+pRxbcdT2Bw8kSmSnjwEPfYieBeR6iEqqhH65mjSLixMITY7uXR9VYvcU07QO+GF9iT
 CAaQRAcbspsXMHf6MpDKg1j7qFoscajltaDuT3LccYAD+dFIylPPLBaM49iEK1yfYEqw
 jZ0L9WKrE4+MX9A/nKVg9R6I8eExRXX2N+UlEOhWixI3neVvOqYb7WPammfH0/F6QrQL
 WmP9bAa8HwzRivZv2XLOnJ2WigxU6YTZH+Vrqkx/RG5tOv5Ty5C3uTlAjHpMJlOWxv61
 b1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430009; x=1784034809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xc+tMxSyHDkaEQ13iyZi4Bg0l9zwBc8qedmGedZWFmI=;
 b=rCTw5t60n++20nsdZGYMR9AkWU/XIYl/Pesn/wX1qLzzN25SwbETSSI/yDwOUT0A/9
 PJACe9Y7WwlXyXnZtVc1LCRRclMA/JAQ36VVhqMFeibdnfsXPDq9LzP6ekymEWJQarK9
 3VIfbgFsnpLy7bmYU3Y2sLXNJQVnqSfLCEA2YfpCnbXo4LCUGJ0T+gam2XIwZoTR5pXI
 fuES0Coaec5PiPvMocdNVcS2sZY9KECTMSD1w9/kzK1hZAGtjdTlB7hg68DrqqWvlfiu
 jSBoBfQdlN9O0DekNrqtOhof8GBB3rBkczOGrUIN5ZR7BS+5e3GPl4GJj2IhTajFHy51
 tsZg==
X-Gm-Message-State: AOJu0Yx77Yp1Gtt0iaG77LRqlOdKHv38Z2S5vyyFU87iWZUPT22WsaVh
 1rfphv9YpGzbuSVGIvOv2Hhq5x+6zfuM+e9wMXY1+WXq4QDZHSiersrObP0q09v3cn3BFG3dEzN
 hEFLLUYQsft6ZMmw7QRGeIJFFWdxrfwRY8KUqC3nBcY24mRjXQmQiY7M2HPHgPXZ2UA==
X-Gm-Gg: AfdE7cllwxgJhc9MHy88eWIdbUSQCcnqsHgrnjfhWEMFm7HKWbddDIXQQ1ife7niQqn
 guNJowUYZAhnoSG9OQdKY7IvbMpUDGfF6wvCx+C+wb9LgTrOXBZ04lTZOiCdMlyRsI2p3MfaUpu
 RSqe4zbEnGoNZcs0u2cRQTcuC/Y9L1Yd01wiw9Ojv7hBoJFd7LPTuDVUbFZgVkV9+3u0R7dM5Ve
 FBNkX9vCTav2ZAG5ceiTujqYV4m58GkTXTUVC5Rxqa7cY7RyGNfkFja8qOO28X8My35b27Ke5ZN
 KlMu34Igk6xxEI51d9f8/XSs2iEjzBmUZCK6inVzCiNeR635wAN8271WpueLQ5ejYsOOfoqm5yX
 FbfF5uWzYN7quGFXkaWZd4xQMJ7p1slJikWitcHD+nGNN+Jj7X+8tm0ddXBFmfZBSDBJo
X-Received: by 2002:a05:622a:1a91:b0:51c:f4f:b3ab with SMTP id
 d75a77b69052e-51c747d5315mr55268441cf.20.1783430008952; 
 Tue, 07 Jul 2026 06:13:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1a91:b0:51c:f4f:b3ab with SMTP id
 d75a77b69052e-51c747d5315mr55267961cf.20.1783430008406; 
 Tue, 07 Jul 2026 06:13:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a9c4a4027sm893683a12.29.2026.07.07.06.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] crypto/x509-utils: fix gnutls error code in crt_init
 failure path
Date: Tue,  7 Jul 2026 15:11:59 +0200
Message-ID: <20260707131223.51505-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wsSETylWuBAHoNN0cG2R-u3yxFgHCUNL
X-Proofpoint-ORIG-GUID: wsSETylWuBAHoNN0cG2R-u3yxFgHCUNL
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4cfb79 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=bnHAcCUCCFN1SB_dUukA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX2F9FoFC4JCvG
 K45s5dgmL3E0Ncffdj5J+H+kgIGYsBtG+Cp4IGCF8YLACm/oEP/EDGTWEhfoR01ROYKDpD2eYfe
 y4DDlP/Yc6IZft5SoFRxz6ftmb/VLrSogMpwy+JVyy7O7qLxdeXU2c7X4b8qlEn1GJ/W82C8v4c
 N7DfhVMnmu/i4njezhOlGh6rKgtlPPl1UpVuDofj3H6EMsyvq7zoedIVB5vmEZkQ/PW/VBNk4BP
 sX61N465UuK7XBgi0uBQ7HXSSyk3oSc7DVD9cE1JQULMMfrnPoXzUBweJKkFby76Jicb3IWqEuH
 t8av/u/h+Lt52yE0l/dnhGoP/mz9Q4dRBxAGmVL+kERhxLJK4L/7wKJa7EPfpidtYY7RHoTDLvD
 O7qItq9zURn8TrI5KwI83D7cqMETTCKKtiElYrg++KsMsZ6Ofz9pfzvVx/3NNKZq5rp8UzwpWSK
 G+6JUeM3NIsPQSLNiKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX7YnEoyg9k1L6
 szGG/Uxi5Va+H7zZf8dfrBVpCe7921hdHJJUd4ImzobPuYqb7jPr/VH7LvbrMAO3hjb+LzPSy2Z
 0OW3feau0MX/Tz6vSpojncrzzvHeOOY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: yujun <yujun@kylinos.cn>

qcrypto_get_x509_cert_fingerprint() reports gnutls_strerror(ret) when
gnutls_x509_crt_init() fails, but ret is still the initial value -1.
Store the gnutls return code before formatting the error, matching
other gnutls call sites in the tree.

Fixes: 2183ab6251 ("crypto/x509-utils: Check for error from gnutls_x509_crt_init()")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260629111026.281185-1-yujun@kylinos.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 crypto/x509-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 39bb6d4d8c3..1843488bca3 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -46,7 +46,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
-    if (gnutls_x509_crt_init(&crt) < 0) {
+    ret = gnutls_x509_crt_init(&crt);
+    if (ret < 0) {
         error_setg(errp, "Unable to initialize certificate: %s",
                    gnutls_strerror(ret));
         return -1;
-- 
2.53.0


