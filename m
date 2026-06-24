Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B7CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGTa-0004mZ-AT; Wed, 24 Jun 2026 01:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcGTZ-0004mM-1K
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcGTW-0004iw-Mk
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:48:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1Sm7C1386045
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bRdWqyEny96brkn78m6/YO
 wGPojMTwgL9iQSRIoiaYs=; b=fggadx5TSjJt+5Jl5GuVi9HcnfT1tB+iRN+pOE
 gEolpBSkJdkyEfWXcCkbMnbKFTGIuOTfLaKC8tNYhUqGjlDuafjtBl6jOmewOind
 lesty7MT6/OJOTTemToTSxWwQYMe36RBnq4MvUDgebvyl2HVtDWmvirjDSzgJnxv
 En3Mh1GEyqqSnd9qwtQJKYIs2Ct7vtX4ckiKwjJskldzfjeR9NB4n+HRFbVl2r7m
 igI90Kzx7HrDLWhyvpdaROaH9iG4CG4JgOpop6qo1pgSI8emY54OeoQJYWpNsMS8
 w1mwAqinSP3x/GR+uVwKxBljDw5/CR36Q30fhNa1i53vQcWg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00ev9kd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:48:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso727182eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782280114; x=1782884914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bRdWqyEny96brkn78m6/YOwGPojMTwgL9iQSRIoiaYs=;
 b=aCDW9kqJzj86ZDrtwofJZwO1sdJglZQPSM8C5xqYfizn0FjL8Gl8ZKqMs6mq+cmAMF
 R6idfo0Qracq8fVHyLVmkch6fqp4UJcQYZlC/IUjE+5QSti7fQdtq7UqHhuc/QVEweuY
 1lUU8ixvJG2zpuQE2oYb8aWGcnsFJCO03os76tuNFpXl3NQFuk5L4ZmWby7LM08Tx67T
 yvhJUovCh/dzl+HvIz/xft6YyxPjq4/WU6XisW0ajZKorMi5PpeOTqPRiTrtlD+rrPRu
 2fEiuCYj9wgN7jY3Wb64YZIw0e/2j8P4WCBUzl2IhifbT36vYTF2lpZmc5QfIVR92fo3
 Ou0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280114; x=1782884914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRdWqyEny96brkn78m6/YOwGPojMTwgL9iQSRIoiaYs=;
 b=MmzX9C9r6wugx7ywUres62fJq88FbwrG1b3Fa+KkdNe7+CTqAHXSkKVe8s+ytlaxX9
 uaMS9I5TLpGYVFG7wszZcOfXFYNQTNJtKjhSiNsYpTldsfwtb6C9cdm+qXEjfb15FYQy
 6wbbYX1h0eJ5FLpDct7zi1Gcz03MYB4tPzoWsjHV1Db4lVxt5AoXEUxHqoDjMwPUVX6k
 BRK4VRC8x6M+uvlDdygaoCr4xz5qlKBBawB9qjuHhEzB8pakgPLOZ7dXjzqS5UeLKRyC
 ubOeFIXmCcjwHK7zYQI7OXVM/XDV3O7dBfwntyox19RWmxaHuH+9KxM1OEXJbJAuETTh
 ETfg==
X-Gm-Message-State: AOJu0YzeF+CYwaMk5X2DVMt4iCpbgMWjd9fpSggCOY55BqiLyoYbW/Am
 uYQqZc9QmcQbAsEDFNEcHFf/Oy8doRU7wdbddWK8gZoief91yeyLk8kQT9BOJTcVBTBHnlTVhUa
 Eou1SoxtTlciP/6kpl29V4wAu1ck9OVvyqbXwGzJ+e62QtNC4Fc9XiJAkQoJmNB/2WQ==
X-Gm-Gg: AfdE7ckWSMEsikwxefGpTPSyB72qrONh8QQbispcYXCmDU4jLhwwiKOq1Kw6SX4dWsJ
 jOOmjlDZoTLxbMZVQQ1HkHCcn68Jd8NXhy30xzUhLMhrLqngtIivwqFO8iElWU8mwODR2j5qota
 LicXJeodB00RGShtLEdDz+ugzPhCjIhLRf7DsZELU/ACU39fJlG1OpftbBv+RIwBnvcXZXiZiTn
 PfYeGoAeZE5CzPcLPNCHc69nhxsBivyF8j74bJJ38cu2wac5m5XYbKfba71ToJVon1/llvBG0Ab
 9tjCt1/TElY7kfRsyuiP8gWxf3Pti4qfVlTT65EDtU251pITNGTKhthnBMqloD2X3F8YCM0aWxe
 iCaLGt4+6YvqhKQG7oR2p9r81aBXz9S67jeiM3j8oiLLqL9PRj9/+69zsK6o=
X-Received: by 2002:a05:7300:7c11:b0:30c:5807:abbb with SMTP id
 5a478bee46e88-30c58c18f30mr5466246eec.20.1782280114549; 
 Tue, 23 Jun 2026 22:48:34 -0700 (PDT)
X-Received: by 2002:a05:7300:7c11:b0:30c:5807:abbb with SMTP id
 5a478bee46e88-30c58c18f30mr5466224eec.20.1782280114028; 
 Tue, 23 Jun 2026 22:48:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c52daf89dsm11306095eec.31.2026.06.23.22.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:48:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@gmail.com, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
Date: Tue, 23 Jun 2026 22:48:32 -0700
Message-Id: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA0NSBTYWx0ZWRfX1v5rYcBsH8oO
 Yqn6YwS4H+1ZW2Dzo/KwKkhKoDymRr3AyXERdCm+C8aqDyA+HQhLnILGo1nv4xBWNE+vOB/wx7d
 lAtMGn+HFLHmdaSrUr2zjB+r5td7ETqF8SK2FXqdfY9djUCiYCclqqI8+C7QCugAWmGGMLdAD23
 Bs+TjLRYDUpl3grGiZb3CfBb8XmGtA437agj1xldZUJhq7oq95VevwJDFe2JqkIlZjh8niXXuzl
 fxuBy+PZkv6mD7oy5yBr/1C03eQThy/Zd4shQwTLh11HqagCRH/1ckPlqW4PRJu5/c7o8OG8ptL
 dU/5bvfhl67SxEY2NqCAtcLOvfHul1XQiGfq5AiplQL9zY4xu1X7YNokuZihlsaWRbfFLvioE+e
 vCsbEwYRWdV26utE+qd4dTblMKmjS+dcL5sifYnzKP3DNdIg9cBGg1w2F3XGKQqz3jQte60capv
 ktjDLyKBZmk3TSG4Zpg==
X-Proofpoint-ORIG-GUID: u3zJJZBC1Y0veGpkUxJqIVnJynMmWDio
X-Proofpoint-GUID: u3zJJZBC1Y0veGpkUxJqIVnJynMmWDio
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA0NSBTYWx0ZWRfX0wbUHTQf2zOD
 IA+6NfOIE4/hMLg5wlOysHIGoCumiJM9AzKRvx3GGe/MrqrGz6Z/suuQ00RyV9vjxfVmBWF6JVe
 H4nB3qzjv1XOJ2BiBrEkZnTJXpbygso=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3b6fb3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PPtdwtFBn-pjDOyLn9UA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

VGhlIGhleGFnb24gaWRlZi1wYXJzZXIgcmVxdWlyZXMgZmxleCBhbmQgYmlzb24gYXMgaG9zdCBi
dWlsZAp0b29scy4gIEFkZCB0aGVtIHRvIHRoZSBlbXNkay13YXNtNjQtY3Jvc3MgY29udGFpbmVy
IGltYWdlIHNvIHRoYXQKd2FzbTY0IGJ1aWxkcyBpbmNsdWRpbmcgaGV4YWdvbi1zb2Z0bW11IGNh
biBmaW5kIHRoZW0uCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL0NB
SlNQMFFWazZ3c09uUEFzcEM0WWZYUnA5MHNhS2liUWZENE1rLTQ0LVJRbzBrPXozd0BtYWlsLmdt
YWlsLmNvbS8KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9lbXNkay13YXNtNjQtY3Jvc3Mu
ZG9ja2VyIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9lbXNkay13YXNtNjQtY3Jvc3MuZG9ja2VyIGIv
dGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKaW5kZXgg
OGE5MjQ4MTZmOTIuLjVkZWJiYzc3ZDA4IDEwMDY0NAotLS0gYS90ZXN0cy9kb2NrZXIvZG9ja2Vy
ZmlsZXMvZW1zZGstd2FzbTY0LWNyb3NzLmRvY2tlcgorKysgYi90ZXN0cy9kb2NrZXIvZG9ja2Vy
ZmlsZXMvZW1zZGstd2FzbTY0LWNyb3NzLmRvY2tlcgpAQCAtMTksNyArMTksOSBAQCBFTlYgQ1hY
RkxBR1M9IiRDRkxBR1MiCiBFTlYgTERGTEFHUz0iLXNXQVNNX0JJR0lOVCAtc0FTWU5DSUZZPTEg
LUwkVEFSR0VUL2xpYiIKIFJVTiBhcHQtZ2V0IHVwZGF0ZSAmJiBhcHQtZ2V0IGluc3RhbGwgLXkg
XAogICAgIGF1dG9jb25mIFwKKyAgICBiaXNvbiBcCiAgICAgYnVpbGQtZXNzZW50aWFsIFwKKyAg
ICBmbGV4IFwKICAgICBsaWJnbGliMi4wLWRldiBcCiAgICAgbGlidG9vbCBcCiAgICAgcGtnY29u
ZiBcCi0tIAoyLjM0LjEKCg==

