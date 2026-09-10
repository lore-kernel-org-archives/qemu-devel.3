Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B231C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4gmT-0002QN-UK; Thu, 10 Sep 2026 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4glk-0002KP-Ft
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4gli-0005Q5-Ez
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4MNK791979
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8TGGJtmfoSMJpYjUe8xw3nYBbzGzvH0H5wJVTGHP9d8=; b=gGH8ag+R0Ez4bVck
 59PnscAEJgkzqeJRKWy2oDpU0padCgeRZebtJP5hhTV9X9UrHkafNq1FK9zNfOdm
 5ieHdLfVgZ80dnfl23QwO4pO68THraos1e7E/FmY+oG9tSfFXaTCASMNaBcT2x+8
 ztclyj6XET5Zm88184bxwC7wcCqTI/9yQvxGfFQdIk1/dewfncTzIGp1dVOyeIhp
 TxUAKg9Rt7eCoFIC4rFWBvD4IFhX/Qrr4xggViL70TBLBk4Gd8U4UcqXExSk9shD
 GkmYASm3/ii9BIGD1QuGRV4ZcJr5BqhmlePshP4p+s4CQcrOlKlNhhj24ASugAQA
 PXzGlA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwvx0jej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:52 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-46f178d813bso7315204fac.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789054372; x=1789659172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8TGGJtmfoSMJpYjUe8xw3nYBbzGzvH0H5wJVTGHP9d8=;
 b=V/XDMqhIt7mpuZTwNjgYD8ko0YqXxF6xo+byR7UajWaNiShJv+BaPLxNgv2hXjryQw
 nOYQ91Py2aEbAub9BYuEZdCOrOxibRaa2O+wXxqs9eQZoEe93VZfrTi6yBqlLHOjzBbI
 dYgGmngqsY1TgUfOwIlMU88H/UjrZuRloaCmTyi3uoNd6/cNLnNhuzpG0vAeBaloYdOL
 jt2lmATsfxu8rkWTt79lYOfX8DqaihnutOESFvXC3B/HwH60N5DlLW0zAj7PtBhrRgxD
 i9XXeB5zvnqPMwHOWxXWizdBeoomvk6GQXeqkQv1di2LfylfGPheF2pUsfnyTFtoxfeu
 33vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054372; x=1789659172;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8TGGJtmfoSMJpYjUe8xw3nYBbzGzvH0H5wJVTGHP9d8=;
 b=qDJVw6OUZ3BtDx8Oz3JYFhI1UyPxPdVH56+oqm32WE5jCVfTw3JmcYNT4ITqx6PSti
 dp4OZd5RdEc7sssvbJwBT22lWhRsgXGqTdhEqFYxkr4fdbKuCl++6c4VcJxzflhdG8at
 62BlRolUmqVSL0CEsbKmAgKon0u1nouu2MuJpdtnau0Z2Q1LwknPYRtYchsdJmqk9rwM
 e7DouUoKw+JI88qJMfxKP/eQQ8mfUfOI7tAs1ELeykQ0FbvsyhzdzwowQHEmVE8sKA6n
 fg0cuh660rRSqZeXsEp+t/glakuy6bCWnBNTtscLEST+pYl7Fu4m0B88nZl1BPXoEtVo
 NHrA==
X-Gm-Message-State: AFuF++lkUlSRQ5awX0VFqPDw4NlHSw0ed0AhVd6AofYv1gNLLOQ+1w2T
 piNZFKUx1chjWZZUzJ94E4wGL0XdVp5pPJ8FF5Hs7+IMTu4n6Fcaatm0onLxf/Vd15rhJaFekfu
 88AgU/8MSeZgGVaIWcvFa15EMFF4k2G3OzkLOuh++BPW5N1lZLcq0txWuxs31BXz3CQ==
X-Gm-Gg: AYBFou3vtKJA2SkhV0Yx+YiI3CFt0dphoMKCcZTXJrKIERP3euoNYKoNvMB3O70ULSw
 sulEONZ6b8w34YJcoCCkdsEkopURU8BdC+rtGL6suPe0OojrGJvHm9RuXbix7EN2VsmX0F+55+t
 EPlF4BPRgBPETFSA8GWDErec1QoTnqf/HtedlTXooVrT5t8MluueEi8aHkyPFoFi1WR3YPQqAlZ
 9dzFDpGClFneXDGO9w11PiC+ccQoI2m4A+UKI4bNDxZO1rXNG91qzen6qpu88HhzOQPFcAZUZgO
 CthHTjIAHFTYN8Giu+Nvy0cMUd0PjC02rx7E5j+rDTiinLA7ujf+zjYdk/k9p8neYK7VubQmUFs
 uS3RF4DNo6/of7AfjYUL6iSsIK/HllEGGsDgj2Ddau/jH3s6N
X-Received: by 2002:a05:6870:2247:b0:469:fb51:b351 with SMTP id
 586e51a60fabf-47552a2e2e2mr25178009fac.17.1789054371846; 
 Thu, 10 Sep 2026 08:32:51 -0700 (PDT)
X-Received: by 2002:a05:6870:2247:b0:469:fb51:b351 with SMTP id
 586e51a60fabf-47552a2e2e2mr25177968fac.17.1789054371400; 
 Thu, 10 Sep 2026 08:32:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm19563727fac.6.2026.09.10.08.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:32:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 8/9] target/hexagon: select the HVX register file with SSR:XA
Date: Thu, 10 Sep 2026 08:32:20 -0700
Message-Id: <20260910153221.1674285-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfX3hO258WwHS42
 i7cq369BQ5VSRRU2mq3XI8TyhH+RlWk7QZ3N3GNygTWKniK44htqDfkT7iVxLCDlXF7xGMoETe+
 vkqrzNgwUYiSnf2hi80yYA+ekkO5f4mLVKWyFFHO+9mT26bmO5MY9pEdan7ut67syCTsIfwoFzR
 /aUmuk8xICMizsehTV6dN0sMOYUfuNZuTCy25HTkxkJVWrFGfa/KfTcI74nZKIUy8K+LpoPNq8x
 cvlQVO/Xgv3K998mGarMzXAogfOOPQW1OYTtT4VJaBhuAfVxNnZLUMcJM5bESCiXYqCXhkmPZYv
 C1LdKY5h7QAcbNw41PgwANqvsIDswnmTBxmcjnXYnndmBb2bM4lCk+9oyfyhZCMEvRKXy7l44FZ
 woDc7XRLi6SSBoPiulH9N6sFUWbs5r1pJk4394CZHfQw4LE+sRKdPoXzCYjmZwnJ0LGTmANEIhF
 +tD/yI/kOlUFPJfqQcA==
X-Proofpoint-ORIG-GUID: mvkXzVwK_-o4dratAg4E8S4qlkSirNro
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfXx7qxKz+Yhsg+
 EKzJY/rKXowiBFwzfSKdFmyP45WlsmfRVX9OBWCcp4FOU1le4V1r/647u5AUnM1NLBkxLxRNNi7
 uHKONr/XErgobchOyo6y9WwQfqxHZVU=
X-Authority-Analysis: v=2.4 cv=AdkkjHXG c=1 sm=1 tr=0 ts=6aa2cda4 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vYdG1gwSUFETiTIC8psA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-GUID: mvkXzVwK_-o4dratAg4E8S4qlkSirNro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100187
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

QXNzaWduIGVudi0+aHZ4IHRvIHRoZSByaWdodCBjb250ZXh0IHdoZW4gU1NSOlhBIGNoYW5nZXMu
CgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oIHwgIDEgKwogdGFyZ2V0L2hleGFnb24v
Y3B1LmMgICAgICAgIHwgIDUgKysrCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCA3MiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9tYWNo
aW5lLmMgICAgfCAxMiArKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90YXJnZXQvaGV4YWdv
bi9jcHVfaGVscGVyLmgKaW5kZXggMTI1MTJlZmQ3NGYuLmFmYjRkZjU5ZjgwIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hl
bHBlci5oCkBAIC0xNSw2ICsxNSw3IEBAIHZvaWQgaGV4YWdvbl9wZWVrX21lbW9yeV9yYW5nZShD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3RhcnRfYWRkciwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50MzJfdCBsZW5ndGgsIHVpbnRwdHJfdCByZXRhZGRyKTsKIHVp
bnQzMl90IGhleGFnb25fZ2V0X3BtdV9jb3VudGVyKENQVUhleGFnb25TdGF0ZSAqY3VyX2Vudiwg
aW50IGluZGV4KTsKIHZvaWQgaGV4YWdvbl9tb2RpZnlfc3NyKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCk7Cit1bnNpZ25lZCBoZXhhZ29uX2h2eF9zZWxl
Y3RfY29udGV4dChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3NyKTsKIGludCBnZXRf
Y3B1X21vZGUoY29uc3QgQ1BVSGV4YWdvblN0YXRlICplbnYpOwogaW50IGdldF9leGVfbW9kZShj
b25zdCBDUFVIZXhhZ29uU3RhdGUgKmVudik7CiB2b2lkIGNsZWFyX3dhaXRfbW9kZShDUFVIZXhh
Z29uU3RhdGUgKmVudik7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCmluZGV4IGE2MjE5MWNmM2ZiLi40NzJlNzUzNWQ0ZiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMy
MCw2ICszMjAsOSBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dldF90Yl9jcHVfc3Rh
dGUoQ1BVU3RhdGUgKmNzKQogICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7
CiAgICAgdmFkZHIgcGMgPSBlbnYtPmdwcltIRVhfUkVHX1BDXTsKICAgICB1aW50MzJfdCBoZXhf
ZmxhZ3MgPSAwOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgSGV4YWdvbkNQVSAqY3B1
OworI2VuZGlmCiAKICAgICBpZiAocGMgPT0gZW52LT5ncHJbSEVYX1JFR19TQTBdKSB7CiAgICAg
ICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSVNfVElHSFRf
TE9PUCwgMSk7CkBAIC0zMzAsMTAgKzMzMywxMiBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhh
Z29uX2dldF90Yl9jcHVfc3RhdGUoQ1BVU3RhdGUgKmNzKQogICAgIH0KIAogI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZCisgICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKICAgICBoZXhfZmxhZ3Mg
PSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNwdV9tbXVfaW5kZXgoZW52X2NwdShlbnYpLCBmYWxzZSkpOwogICAg
IGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgUENZQ0xFX0VOQUJM
RUQsIDEpOwogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywg
SFZYX0NPUFJPQ19FTkFCTEVELAorICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1LT5odnhf
Y3R4WzBdICYmCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9Y
RSwgZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOwogI2Vsc2UKICAgICBoZXhfZmxhZ3MgPSBG
SUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwgTU1VX1VTRVJfSURYKTsK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29u
L2NwdV9oZWxwZXIuYwppbmRleCA5Y2UyNjBkNzQ0OC4uMWIwNmI0MWRhNWQgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmMKQEAgLTExLDYgKzExLDcgQEAKICNpbmNsdWRlICJody9jb3JlL2JvYXJkcy5oIgogI2lu
Y2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbi5oIgogI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdv
bl9nbG9iYWxyZWcuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQu
aCIKICNpbmNsdWRlICJoZXhfaW50ZXJydXB0cy5oIgogI2luY2x1ZGUgImhleF9tbXUuaCIKICNp
bmNsdWRlICJzeXN0ZW0vcnVuc3RhdGUuaCIKQEAgLTI0Niw2ICsyNDcsNjUgQEAgdm9pZCBoZXhh
Z29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqY3VycmVudF9lbnYsIHVpbnQzMl90
IG1hc2spCiAgICAgfQogfQogCitzdGF0aWMgdW5zaWduZWQgaGV4YWdvbl9odnhfY29udGV4dF9j
b3VudChIZXhhZ29uQ1BVICpjcHUpCit7CisgICAgdW5zaWduZWQgbjsKKworICAgIGZvciAobiA9
IDA7IG4gPCBIVlhfQ09OVEVYVFNfTUFYOyBuKyspIHsKKyAgICAgICAgaWYgKCFjcHUtPmh2eF9j
dHhbbl0pIHsKKyAgICAgICAgICAgIGJyZWFrOworICAgICAgICB9CisgICAgfQorICAgIHJldHVy
biBuOworfQorCitzdGF0aWMgdW5zaWduZWQgaGV4YWdvbl9odnhfY29udGV4dF9pbmRleChIZXhh
Z29uQ1BVICpjcHUsIHVpbnQ4X3QgeGEpCit7CisgICAgdW5zaWduZWQgbiA9IGhleGFnb25faHZ4
X2NvbnRleHRfY291bnQoY3B1KTsKKworICAgIGlmIChuID09IDApIHsKKyAgICAgICAgcmV0dXJu
IDA7CisgICAgfQorICAgIHJldHVybiB4YSAlIG47Cit9CisKKy8qCisgKiBEaWFnbm9zdGljIG9u
bHkuICBDYWxsZWQgc2VwYXJhdGVseSBmcm9tIGhleGFnb25faHZ4X3NlbGVjdF9jb250ZXh0KCkK
KyAqIHNvIG1pZ3JhdGlvbiBwb3N0X2xvYWQsIHdoZXJlIG90aGVyIENQVXMnIGVudi0+aHZ4IG1h
eSBzdGlsbCBiZSBzdGFsZSwKKyAqIGRvZXNuJ3QgdHJpcCBhIGZhbHNlIHBvc2l0aXZlLgorICov
CitzdGF0aWMgdm9pZCBoZXhhZ29uX2h2eF9jaGVja19vdmVyY29tbWl0KENQVUhleGFnb25TdGF0
ZSAqZW52LCB1bnNpZ25lZCBpZHgpCit7CisgICAgQ1BVU3RhdGUgKmNzOworICAgIHVuc2lnbmVk
IHVzZXJzID0gMDsKKworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIENQVUhleGFnb25T
dGF0ZSAqb3RoZXIgPSBjcHVfZW52KGNzKTsKKworICAgICAgICBpZiAob3RoZXItPmh2eCA9PSBl
bnYtPmh2eCAmJgorICAgICAgICAgICAgR0VUX1NTUl9GSUVMRChTU1JfWEUsIG90aGVyLT50X3Ny
ZWdbSEVYX1NSRUdfU1NSXSkpIHsKKyAgICAgICAgICAgIHVzZXJzKys7CisgICAgICAgIH0KKyAg
ICB9CisKKyAgICBpZiAodXNlcnMgPiAxKSB7CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dV
RVNUX0VSUk9SLAorICAgICAgICAgICAgICAgICAgICAgICJIVlggY29udGV4dCAldSBpcyBlbmFi
bGVkIGZvciAldSBoYXJkd2FyZSB0aHJlYWRzICIKKyAgICAgICAgICAgICAgICAgICAgICAiYXQg
b25jZSwgd2hpY2ggaXMgdW5kZWZpbmVkXG4iLCBpZHgsIHVzZXJzKTsKKyAgICB9Cit9CisKK3Vu
c2lnbmVkIGhleGFnb25faHZ4X3NlbGVjdF9jb250ZXh0KENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBzc3IpCit7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2FyY2hjcHUoZW52KTsK
KyAgICB1bnNpZ25lZCBpZHggPSBoZXhhZ29uX2h2eF9jb250ZXh0X2luZGV4KGNwdSwgR0VUX1NT
Ul9GSUVMRChTU1JfWEEsIHNzcikpOworCisgICAgaWYgKGNwdS0+aHZ4X2N0eFswXSkgeworICAg
ICAgICBlbnYtPmh2eCA9ICZjcHUtPmh2eF9jdHhbaWR4XS0+cmVnczsKKyAgICB9CisgICAgcmV0
dXJuIGlkeDsKK30KKwogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewogICAgIGJvb2wgb2xkX0VYLCBvbGRf
VU0sIG9sZF9HTSwgb2xkX0lFOwpAQCAtMjY5LDYgKzMyOSwxOCBAQCB2b2lkIGhleGFnb25fbW9k
aWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQp
CiAgICAgICAgIGhleF9tbXVfbW9kZV9jaGFuZ2UoZW52KTsKICAgICB9CiAKKyAgICBib29sIHhh
X2NoYW5nZWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9YQSwgbmV3KSAhPSBHRVRfU1NSX0ZJRUxEKFNT
Ul9YQSwgb2xkKTsKKyAgICBib29sIHhlX2NoYW5nZWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwg
bmV3KSAhPSBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwgb2xkKTsKKworICAgIGlmICh4YV9jaGFuZ2Vk
IHx8IHhlX2NoYW5nZWQpIHsKKyAgICAgICAgdW5zaWduZWQgaWR4ID0geGFfY2hhbmdlZAorICAg
ICAgICAgICAgPyBoZXhhZ29uX2h2eF9zZWxlY3RfY29udGV4dChlbnYsIG5ldykKKyAgICAgICAg
ICAgIDogaGV4YWdvbl9odnhfY29udGV4dF9pbmRleChlbnZfYXJjaGNwdShlbnYpLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdFVF9TU1JfRklFTEQoU1NSX1hBLCBu
ZXcpKTsKKworICAgICAgICBoZXhhZ29uX2h2eF9jaGVja19vdmVyY29tbWl0KGVudiwgaWR4KTsK
KyAgICB9CisKICAgICBvbGRfYXNpZCA9IEdFVF9TU1JfRklFTEQoU1NSX0FTSUQsIG9sZCk7CiAg
ICAgbmV3X2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBuZXcpOwogICAgIGlmIChuZXdf
YXNpZCAhPSBvbGRfYXNpZCkgewpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5j
IGIvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCmluZGV4IGJmNDY0NmY0YThiLi4xNzliNmY1M2Ey
YSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL21hY2hpbmUuYwpAQCAtNywxMSArNywyMyBAQAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIK
ICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgogI2luY2x1ZGUgImNwdS5oIgorI2luY2x1
ZGUgImNwdV9oZWxwZXIuaCIKKworc3RhdGljIGludCBoZXhhZ29uX2NwdV9wb3N0X2xvYWQodm9p
ZCAqb3BhcXVlLCBpbnQgdmVyc2lvbl9pZCkKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBvcGFx
dWU7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSAmY3B1LT5lbnY7CisKKyAgICBoZXhhZ29u
X2h2eF9zZWxlY3RfY29udGV4dChlbnYsIGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0pOworCisg
ICAgcmV0dXJuIDA7Cit9CiAKIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hleGFn
b25fY3B1ID0gewogICAgIC5uYW1lID0gImNwdSIsCiAgICAgLnZlcnNpb25faWQgPSAyLAogICAg
IC5taW5pbXVtX3ZlcnNpb25faWQgPSAyLAorICAgIC5wb3N0X2xvYWQgPSBoZXhhZ29uX2NwdV9w
b3N0X2xvYWQsCiAgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRbXSkgewogICAgICAg
ICBWTVNUQVRFX1VJTlQzMl9BUlJBWShlbnYuZ3ByLCBIZXhhZ29uQ1BVLCBUT1RBTF9QRVJfVEhS
RUFEX1JFR1MpLAogICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShlbnYucHJlZCwgSGV4YWdv
bkNQVSwgTlVNX1BSRUdTKSwKLS0gCjIuMzQuMQoK

