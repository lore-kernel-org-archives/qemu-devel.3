Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70173C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9N-0004wq-BA; Thu, 24 Sep 2026 21:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9G-0004vH-I1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9E-0005s8-IA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kvkC4052360
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9YrZdtFSPQyPd7DtwGa4XUTn51QYToDjPF/fE1EKhyY=; b=JgKAVXwSUX0HLu6Z
 MoSVPUhxju5FdBR3VBtS61IdTIQy94R46+3Y5yGvezcq40lEfAg+5wm4PZd3ppm9
 ULI6YLC/7tr4YlNjKDkc8ykI9AK8/HPRATMGMKf1s4qxCgO0ydEHXN5RvDCCPdFi
 0IkUzVj8dTRBOnstVqcFp9vxOzUVJ9w831CsHi/rVnJcNh6BFs/bLo8aubbeYH9E
 5SLPHmOXJ1C/czHSgZzYOpxRI31f6RvH4iaw/LifsMDMEfmQ/jGMmKHhM79AT9RM
 P9QsO1n9o6GB7/jKCh7Rr1KOfyG97IICLGnhUUZfQet64tuX0EzaqPkjrjxWJiGo
 yz9MwQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898skfg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3282d5302ffso451163eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301284; x=1790906084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9YrZdtFSPQyPd7DtwGa4XUTn51QYToDjPF/fE1EKhyY=;
 b=kEI8Im1j0FmbInW28oBL96HmrWcO95NmyGVpd2rK6GJT1tyG2xtB48ZzJzFbIVqVdm
 ji2DfgYkvLTMv6fM0ew4YATHNWXnBrm3wHQSlDIW0TP8D/Do8FttibRC+QMAGjK7vdqm
 5shi2RNG/MDx/ULyiW57sKWG7izsul5smFk5st3LhdMG0CMJkih3SHdM1PTj+OK1jYil
 tocF2Vj79ti3Ju5Fbnf/vEclDwyNut0hew1uvomPGFzCar7Jcsre/mL7+7YX2LORO5OD
 juZ3UAhh6TD/sr8KtIIipmqz6f5L/Y+ka1HmsYUjcwCANNfQA+52pZ2w54L7WeosPgnt
 uJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301284; x=1790906084;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9YrZdtFSPQyPd7DtwGa4XUTn51QYToDjPF/fE1EKhyY=;
 b=X4ssdRWxlPR4wv+irqd1rodUyT547yEfPUmtPS0/yY0YU2EW4ktftpr1PK5vqo462I
 Fn7WTZYLZY6QStlNipdgAnPm5dHWpWDa76Hu/zgG+isCMY6LNueoiqLWToqKCVK4kfBJ
 ivxrpZF7r6C17nTbooEmljmPiXs4tcMGRknY6xojXXEGzNVUp4ZBroCuLiwx0bYww8tw
 0jUK4Q4AFfHV82SoTR8QIYLPuMg4kwTIXfmpMEWBUycPmNIkvMzQxHGoCdJ7WOVAJ9Ja
 +Jm6vz4Bth9wQo1HoDIdKawRIlfsODoyvuJRiHmRlhoxl6jr9uTdPKd7IcG64WfHJ3LZ
 nIPQ==
X-Gm-Message-State: AFuF++mxl9CyAS1qymwtrfOqTfCneQKOgr0MkI/o83LI61FCqNcJ1EIF
 6SWLfadTmyFe3jsMfAqTcpyoMFnxfVjlyFayl/+WvXlH/L+pHERarblZJR8NhiNqm0to9I8L/Ts
 RqZRIvYR4zl4om9ANqQYzpsAv6ZjsaiZ+VKiLU8NyswkpwZxvUtrKqqmnVSqMjZGdGg==
X-Gm-Gg: AYBFou0oLRjLFxnK4F69muGFSzb7xvY9uyHRXZ18x2dXTNFLdbKOwSWk6QBAUGerMIt
 /MJDzAnzHDnEHYs5/Ny4a6MheELK9N9c75Gi7alRqWjcgik/r+ZB8HLamjfylSgm1IvHOUhQhoQ
 dWDO1ad+2LJ6d3T7rUmZQcA2b1v9tNYExy+/7NNDf2SDkekxcVUEFkQ0Itf2B3eXIBiTxBldQMc
 jQekd2SOIl7OWBBRc+F7Cxmdj1X4TWVAblowwYNmGxyTAIsEfF8ZgQL63j4ckxZjFQN+lK3ngjO
 SR4sBZ/4EXfk6htjKZgzf8Hhzruz41PtxHcfxKkyGpin98w5VUkSM+vCvZeBEBjzSXAeEOkZ2e7
 4HICWj78Zfiwxf8UJwbgidwmkrZptnOu1De9vsHUO2kRQQSQ=
X-Received: by 2002:a05:693c:6385:10b0:32e:f6a4:ca8e with SMTP id
 5a478bee46e88-340045931e6mr3046821eec.11.1790301283687; 
 Thu, 24 Sep 2026 18:54:43 -0700 (PDT)
X-Received: by 2002:a05:693c:6385:10b0:32e:f6a4:ca8e with SMTP id
 5a478bee46e88-340045931e6mr3046813eec.11.1790301283120; 
 Thu, 24 Sep 2026 18:54:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/40] Hexagon (target/hexagon) Check for qreg multiwrite in
 analyze_packet
Date: Thu, 24 Sep 2026 18:53:55 -0700
Message-Id: <20260925015429.2579174-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX9dhFkZegRQeX
 vshtq3dZmlBy7bLYVrPcwI9rwGfU7uoltggBMNQlOHYgvtCHOR8Yu04jbCu6c3ED+Dh8cq7fPfd
 ugrB00YFvgDTKa/0PJpYq3lie2BF59+Gt97pVjWt8swP3vJTq/x1dUKYotJTIYj2Hwnj5CMrLK3
 J1Sg+CiWF3+furRaYho89YWMUP2IqsQPfjtV2Qwx5KlQrDGkUFnF6DK2iVQGPwJh9qkjRAWpu/q
 EDNj+85O+M99yo5eOGIlHPuAR12CQUmXjWKOAAgem44iJpUf2WRzUM7ygxxcQQXVx33gXHBV9IO
 gJ8iO+jVrrbxF8dPAUebgJlYkgZLmijEqUfQzanQuPiMnbS5tCRi01Ty1KuBB9lP29ZXlhvNNA0
 fH40sAi9sDoFy+G9h0yZR/Vy3ypx3ZFlIkO1an48mCyUgEB7/4noTsInu9ZLVljX8Kv4y4Skf/u
 xHoMagcHtjLTkMxBmZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX6Zg+zBrpSxnk
 79gXtl9ZOjjwGPxnZdMe0JEH+TrAsXoh65AlZoSsrHt4FgwKjY+lkF9Nfyc3M7RaQMILmOU8Wo4
 BMpWrsXu2Udw4a6GqZpRZn/W741I6Q0=
X-Proofpoint-GUID: M1E6UpPVdZUkToDqs7vO9gT3au9Z2lVI
X-Proofpoint-ORIG-GUID: M1E6UpPVdZUkToDqs7vO9gT3au9Z2lVI
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab5d464 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=9YL_7Jk4NeMjv8K-UJoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmggfCA3ICsrKysrKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jIHwgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCA5ZWU1ZjI1MzY1MS4uYjZjZGY1MWMyMDUgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oCkBAIC03Niw2ICs3Niw3IEBAIHR5cGVkZWYgc3RydWN0IERpc2FzQ29udGV4dCB7
CiAgICAgaW50IHFyZWdfbG9nW05VTV9RUkVHU107CiAgICAgaW50IHFyZWdfbG9nX2lkeDsKICAg
ICBERUNMQVJFX0JJVE1BUChxcmVnc193cml0dGVuLCBOVU1fUVJFR1MpOworICAgIERFQ0xBUkVf
QklUTUFQKHFyZWdzX211bHRpX3dyaXRlLCBOVU1fUVJFR1MpOwogICAgIERFQ0xBUkVfQklUTUFQ
KGluc25fcXJlZ3Nfd3JpdHRlbiwgTlVNX1FSRUdTKTsKICAgICBERUNMQVJFX0JJVE1BUChpbnNu
X3FyZWdzX3JlYWQsIE5VTV9RUkVHUyk7CiAgICAgYm9vbCBwcmVfY29tbWl0OwpAQCAtMzA4LDcg
KzMwOSwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19xcmVnX3dyaXRlKERpc2FzQ29u
dGV4dCAqY3R4LAogICAgICAgICAgICAgY3R4LT5oYXNfaHZ4X292ZXJsYXAgPSB0cnVlOwogICAg
ICAgICB9CiAgICAgfQotICAgIHNldF9iaXQocm51bSwgY3R4LT5xcmVnc193cml0dGVuKTsKKyAg
ICBpZiAoIXRlc3RfYml0KHJudW0sIGN0eC0+cXJlZ3Nfd3JpdHRlbikpIHsKKyAgICAgICAgc2V0
X2JpdChybnVtLCBjdHgtPnFyZWdzX3dyaXR0ZW4pOworICAgIH0gZWxzZSB7CisgICAgICAgIHNl
dF9iaXQocm51bSwgY3R4LT5xcmVnc19tdWx0aV93cml0ZSk7CisgICAgfQogICAgIGN0eC0+cXJl
Z19sb2dbY3R4LT5xcmVnX2xvZ19pZHhdID0gcm51bTsKICAgICBjdHgtPnFyZWdfbG9nX2lkeCsr
OwogfQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwppbmRleCA4NWI1NDA0ZmNjNC4uOWFkNDdiMTgzOGEgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCkBAIC01OTUsNiArNTk1LDcgQEAgc3RhdGljIHZvaWQgY2xlYXJfcGt0X2N0eChEaXNh
c0NvbnRleHQgKmN0eCkKICAgICBiaXRtYXBfemVybyhjdHgtPnZyZWdzX3VuY29uZCwgTlVNX1ZS
RUdTKTsKICAgICBiaXRtYXBfemVybyhjdHgtPnByZWRpY2F0ZWRfdG1wX3ZyZWdzLCBOVU1fVlJF
R1MpOwogICAgIGJpdG1hcF96ZXJvKGN0eC0+cXJlZ3Nfd3JpdHRlbiwgTlVNX1FSRUdTKTsKKyAg
ICBiaXRtYXBfemVybyhjdHgtPnFyZWdzX211bHRpX3dyaXRlLCBOVU1fUVJFR1MpOwogICAgIGN0
eC0+cXJlZ19sb2dfaWR4ID0gMDsKICAgICBmb3IgKGkgPSAwOyBpIDwgU1RPUkVTX01BWDsgaSsr
KSB7CiAgICAgICAgIGN0eC0+c3RvcmVfd2lkdGhbaV0gPSAwOwpAQCAtNjI2LDYgKzYyNywxMCBA
QCBzdGF0aWMgYm9vbCBwa3RfaGFzX3dyaXRlX2NvbmZsaWN0KERpc2FzQ29udGV4dCAqY3R4KQog
ICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICB9CiAKKyAgICBpZiAoIWJpdG1hcF9lbXB0eShjdHgt
PnFyZWdzX211bHRpX3dyaXRlLCBOVU1fUVJFR1MpKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKwogICAgIHJldHVybiBmYWxzZTsKIH0KIAotLSAKMi4zNC4xCgo=

