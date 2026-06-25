Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE3CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckss-0006b7-2r; Thu, 25 Jun 2026 10:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksp-0006aS-Q8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckso-0008PJ-02
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k4hx2048176
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=GzfjMTa7/TAEb8Qt7kfPRKylaW6NS9iOefvoJnZ46FM=; b=gN
 vQcpljn5edzCSE2WZzyw/UkA82TZ2bV5g8hW8vJP18mylqawv/RvukE0qV1j/qES
 B+WrQtJa7fhMGCI5+FKCf3vRUvEDxm1UvnfSm5/6nFoChncZ61iD2bP9eUv6Wl2t
 DMom4A8IHK/tNCSxixiqeS/0X4DpAyUHMCEXDToKU0Xm7stePBDR3Mi+z9zAe9C1
 boPJBJaH17izFcTBptpdgp+pppppsqTpMytx5yB5dYt67+dElsMJT/347385Z5J6
 u8AdCJDXN25OSSW69v3Li9/cn+8YKO93vSu7MlU21WCA/4jGoM33ytlpN2pw9wUu
 g1jQZmudV3m2zcQXtAVQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqjf1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c5978b108so6528040eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397001; x=1783001801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzfjMTa7/TAEb8Qt7kfPRKylaW6NS9iOefvoJnZ46FM=;
 b=Idw+G18oQ1cpwHR3z1BdXUK8qxEKGxVzPe7dw1VMoRivLlyfCVfpYZnNQYQWfb8Mfz
 uOZWQ825Wcl1E7uoqdw990u6LCi1Z8Bx5cuaCqmsC1JeYz7iN0oApxl3bBPMkMMGPAw9
 AgaUhrS+pUTLT7L4M0KpEYxGkZ8IuiwXePINVQSA6Kh6No7PuVN2HCPbldM0pkUCaY1/
 zsnvDB8p/uPjmNBUahZoBIklV8EkzIIgYrKV5/SkuusgWAU46U1zYMtFM67Wi/uAh29K
 loNdZyrAtJf3UCMj9XEGN7VqrdeiVJSy7VP77Pk2GEY07I2vt9mKncmigC9bYA17DZBb
 KIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397001; x=1783001801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GzfjMTa7/TAEb8Qt7kfPRKylaW6NS9iOefvoJnZ46FM=;
 b=bVj6/mm5K7KUXEtHptLZkzS1jwCyi8eBRs8O/ziHb1+kUdOLUSMAemJUlkEVANdHcf
 CQtCKvtCbL1nw9XMCg28UCeqf2AfDTu+S5gcRWqcpgJMgsyMPtrUs9z1ef9EKXIRbkup
 LPOZlUl2bMRp0ApVK6lm+qRaKXUx0pkGLsHm3sI1xigZ96p5ioPKWC+X823zGUYkN420
 8Nmezx0kstpyFhFwYWJ0GaYg/Sw+scOY5EqNbK/FQy3PeMDCGzoV0wAgnfXVuf7dwbB3
 eQ9usOG02C22wJGsUVzDKekfILkdRg+9fWEMS/qb5P6y0ncRqA9QfoO/n4+Xn0wnLpf2
 Y3wg==
X-Gm-Message-State: AOJu0Ywc6Jn0qphL65Vrnh/zpYw3npEFVRAzOaB5whkhzt5IX/4EL386
 Kqa1AKA5j/71OcY0fe+aygh1+oOQVgs0BRy7DXe9DzmXRRfAMa1eHCImgpH9CvCu9A2MdTZg2qp
 xKnMk0RUkxzUewfK2aPgR9cTqkVKi/1L6LSFYT/rdF+PsejRLEMnsBGLdc76CQpfGNg==
X-Gm-Gg: AfdE7cmf+vWLJ/4Z8TuUscvVql1ZfvQiieXpW090mgwAL1/UADOlCfN4QHDzYP9eHOX
 AVwG2XPulIX6J/fKzQPDG6p5gLQ9IFaG/+ccZieIYD+EafhmhdCFtqTvDNQK3vp/MKARR5IRfiJ
 SmZjXxfmkJYasQGXJ72Fd0TCjbqNQKj0Ism8D/QhiXIJ3mZ0TU5aXQWLRytizP8sD2L8WFBoqRN
 kH8YGfC3YOkiAVqB7fletRH6/v8fz1eG9FiE2X2W1MQQObIbeAaBW/31uJjZa6wjuyL67k6k6vI
 /0sgpv0jXNy8YPKOR9/R1hhPnW3/pxSd4vzi6sDF1RhH3jKMMydd50hvgMvTYXuk3xOYbs0Xd2E
 IqgVKtVzBesYniqjD4o+F8j9hVZHk2pCKI0fFdpwVJf01Q5a3RHtElzUEGX4=
X-Received: by 2002:a05:7300:5351:b0:2df:7fe3:96a with SMTP id
 5a478bee46e88-30c848aca17mr3826131eec.0.1782397001073; 
 Thu, 25 Jun 2026 07:16:41 -0700 (PDT)
X-Received: by 2002:a05:7300:5351:b0:2df:7fe3:96a with SMTP id
 5a478bee46e88-30c848aca17mr3826074eec.0.1782397000423; 
 Thu, 25 Jun 2026 07:16:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:16:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 01/76] tests/docker: add flex and bison to emsdk-wasm64-cross
Date: Thu, 25 Jun 2026 07:15:18 -0700
Message-Id: <20260625141633.449487-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UzpNGOnG6NBFQM9XcmSXqgt-SsMTLdIf
X-Proofpoint-ORIG-GUID: UzpNGOnG6NBFQM9XcmSXqgt-SsMTLdIf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX5hXrkHfGJZGL
 iYkLmoIoYP86mUTkvXGvEULhXh8sXo8ilCKpiVoETAmtH5UR6PPHPFzAim4+Hs8DmOekU27B2UJ
 jMjD5gQUBdDymql34JdgCkyS042nolA=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3d384a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=dTW7Cx3YwPv8u8hf8ikA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX8B30nzMY64vn
 JzrjUajC/+jm3lBkrCB2dv3ov1hLYqBnB7+ZQdf+e7hNn0Kf05+Skqqln45pPsoP5bt1Sl5ncUg
 TOEgDopEQhov6v+rOU3LFfZs6xpI0FrvlCH7Yq9rdvDNeSYcGex+8JwENHaxZVASlpguThFz80P
 AzWrDvqrrzOZRW3y6vaZ3bvvsJ9H0JETfk1GBemBmAfNLV9T7XPQTV0cYzhEdGlXAtDmIdURyBq
 BWKJA8KWgVD+YZ3VnuvklHtLG79FhXsNoCPeYsvtB187SgEZe0Pn+mln49Ow8lWXgfEfxfjystt
 8mFZ8jGJP/qukJ5SWaOIKpqHJwcURfm0EuArYXUJbQQlzDRs1wRTbm6StMF42FVY8hmTbRRpnDQ
 YoyfEJeRCnVlMAczbxeKnojMgXvX2GDSslH2UbJ/7+OtPBrvxgJwYrSRSlAiFGc5P+1L+gvPn2o
 VhGX64SHz5TMbZHiLvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGhleGFnb24gaWRlZi1wYXJzZXIgcmVxdWlyZXMgZmxleCBhbmQgYmlzb24gYXMgaG9zdCBi
dWlsZAp0b29scy4gIEFkZCB0aGVtIHRvIHRoZSBlbXNkay13YXNtNjQtY3Jvc3MgY29udGFpbmVy
IGltYWdlIHNvIHRoYXQKd2FzbTY0IGJ1aWxkcyBpbmNsdWRpbmcgaGV4YWdvbi1zb2Z0bW11IGNh
biBmaW5kIHRoZW0uCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL0NB
SlNQMFFWazZ3c09uUEFzcEM0WWZYUnA5MHNhS2liUWZENE1rLTQ0LVJRbzBrPXozd0BtYWlsLmdt
YWlsLmNvbS8KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IEtvaGVpIFRva3VuYWdhIDxrdG9rdW5hZ2Eu
bWFpbEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZW1zZGstd2FzbTY0
LWNyb3NzLmRvY2tlciB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZW1zZGstd2FzbTY0LWNyb3NzLmRv
Y2tlciBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9lbXNkay13YXNtNjQtY3Jvc3MuZG9ja2Vy
CmluZGV4IDhhOTI0ODE2ZjkyLi41ZGViYmM3N2QwOCAxMDA2NDQKLS0tIGEvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKKysrIGIvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKQEAgLTE5LDcgKzE5LDkgQEAg
RU5WIENYWEZMQUdTPSIkQ0ZMQUdTIgogRU5WIExERkxBR1M9Ii1zV0FTTV9CSUdJTlQgLXNBU1lO
Q0lGWT0xIC1MJFRBUkdFVC9saWIiCiBSVU4gYXB0LWdldCB1cGRhdGUgJiYgYXB0LWdldCBpbnN0
YWxsIC15IFwKICAgICBhdXRvY29uZiBcCisgICAgYmlzb24gXAogICAgIGJ1aWxkLWVzc2VudGlh
bCBcCisgICAgZmxleCBcCiAgICAgbGliZ2xpYjIuMC1kZXYgXAogICAgIGxpYnRvb2wgXAogICAg
IHBrZ2NvbmYgXAotLSAKMi4zNC4xCgo=

