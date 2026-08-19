Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806E6C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYJB-0008E6-JB; Wed, 19 Aug 2026 00:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwYJ9-0008AM-5O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:53:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwYJ7-0004jJ-D6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:53:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lPOi2223233
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DTnpwtj5Gfi9Hj6gNkpNJ3mVeY9cQhw/BZjlZ0es5B0=; b=QSoS3DAA794jVnvP
 16F6CktuzAMjBq3f02Re5J6gbYQm7ATTsM+cq21GBxIizh8zk2DzF5h0J1gA7FhJ
 uLYPY59AQgM3YqH4TBZftSh8cE3wxIAWpZVArzZn9piqxNp1zjm5Og1mKkPJWDbQ
 8NKcnCHCTGEZBkWPDVwf/bu2NO63ols6kNnH/OkUSDfR5rSAgeGw740qFauCPVSn
 z/w7p+kcmrDnaOprnC9OcnzKdsfNd5Ha/UCJq2S4YypH8VNcDOMNolO/sf6xici6
 NCLqpl1E+L+nSigaqCp4mPnHfCzzQpNq6zg+R6lCb5Q/cNbXUHhZ+70TCnVDhPu5
 1IMDqQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm1c7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:53:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso690212a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787115223; x=1787720023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DTnpwtj5Gfi9Hj6gNkpNJ3mVeY9cQhw/BZjlZ0es5B0=;
 b=HB+F3RJce5lXRWKUbzZtsXtdEZPmycABNNLRab5eaiRjRXLy4sZyReYBl2hDWtVy4f
 y+jjZe1ggXcn+wEGxPGzjMGLZbpR1C0ztGKhUFEFoMqc4FZ0/N5h5+QP5Dv/9mDFnRkU
 4BbiFpbJfYlD0kLt4X6R9Ko7AZYgq0poabfdMkKLvPRwtCSfZy2EFErxZ3QACWqjdzb/
 jHwmi7BifcLtXpYcZaDFx3di7Dw2Mj2/O6oGzmOMVKXpTipV2lR2G+GR00Y5KsrCrRxi
 HajLIc67sUvcN6M5uGpNKBjDvhjkiKXrdTqCZOcJcsxjS2AQdNvPaYqevyY2HjmJ+sIH
 D/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787115223; x=1787720023;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DTnpwtj5Gfi9Hj6gNkpNJ3mVeY9cQhw/BZjlZ0es5B0=;
 b=M/x+mGnNzLfTNv2D0b5/Iq3Dtk2yCc/VrA8YyliWZedrmCgeHziBvednpwrGtJlDws
 RwB++d7yoAmVbjix4mRbXgB/WnInml1ujYKLklTLFhXk+TKw6Ye5hoZDUBKonVBNwppR
 Tr+vflmtdr9g6NdDUSlMjz50zIbybA9LwB3Ho9TWc9o1qPmj9aNpIWnOyiD+nHOrSr0+
 N7UcKQ8iI4EwtlNcD2dlSL5zJWVsV75EaWMks9RF+F+5zr4ZNkqJvDTZrLmkVK8ZpdIr
 KEVSxw9j6O9bp03vK6C8IzyqGDhoxN2BiJJpTLT25/RGlayd8qufki4XwZuKv3eZMHM3
 wtjw==
X-Gm-Message-State: AOJu0YyiQqAXFILHFU+Uyn9r0pVApPdcE1WKsUyrMiBRr9BdevM1kHhs
 QxqX35rbFqes3V9DbX0MagHFrSjDlSzoQs3/EOyB+bKJGku5queSnvlpAimjXpExe3ZfWeHU8li
 JAV+Qg2eq+bVOJR+gPhqqPnF4grvXKiQs5tiFhanCKTuFs4w65oAoS1lm5JQGsNob5w==
X-Gm-Gg: AR+sD10KjMj5GPGtnrXI/va74cQ6B+NzUQJnpcFJCbculxdc2N6sGyiimkKv3AWVBAy
 9k2CiwhDFxldkdikRupx8yIvKzi5Y1mMNvyPtEaU6tquvcsa35ReKaFf7Fp7MW2KESawJ80+Y2r
 DFJGUGVWOzBqSSRJoZp1IJjXa8m3YO232DqRFrNavAKcPkiN3jPxmlPIZu7/GYIOM0sk08Tiu4w
 qOGzmJ59G1sOommf50QvrWrX8AIS8BRJl+sGp7dg7w9GFszNSkrIM+x50HX9Rc2X3D5QnxPvZRZ
 mNoezyoNisghkCQtIf2qoHdIbzTF0sqTBov+QTySvJJKjl+aKTwZsLIJi3ujnvo+iRVo9A/vrkl
 Fuwt2wqN9272QmnydxeqC4eCbSB+X46S6VfqOmZJyDQC2a+Q2
X-Received: by 2002:a05:6a20:914c:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cd00db96f0mr3857293637.3.1787115222921; 
 Tue, 18 Aug 2026 21:53:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:914c:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cd00db96f0mr3857237637.3.1787115222508; 
 Tue, 18 Aug 2026 21:53:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3ce17sm3763421eec.1.2026.08.18.21.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 21:53:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/2] target/hexagon: invalidate translated code for user icinva
Date: Tue, 18 Aug 2026 21:53:38 -0700
Message-Id: <20260819045339.3661773-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: EPmweOr3YskxiBQPLf3ouWdnEOlatcqk
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a8536d7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ooCGj4RZbTp4S4j5W-YA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: EPmweOr3YskxiBQPLf3ouWdnEOlatcqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzNCBTYWx0ZWRfX/Aa4RmMxqspQ
 MoqguFUSY4f4LESaZU4yxbAeh7iDXFNUn7UEvm3oR7vh25/XanMW/NMqgflU0VyXnoVB4vD6GYs
 2hik8DJWqn6KVzqF9rGD+oEZrAR3tc3jAuF4b2vbXN2t2SmY/YG+0EJ4LuOLYWATtrkOhk9K5CY
 /x0chjQpZIdx/ZDn4gt9x081eAMS9VJ8nK9JXG545ImTDt0qazgmT7Ci6lAoauDM6JSRQRJaRlk
 BOnsm0KcB3Ei63xEgrShP9a5n0R+bSfqKIn84Xkb6un2NblwOvzx+W7q8YaVxawng3yd/qmJCWf
 ADNiaeIoOY0k8gTgUsosd6GxvzBj5hmiFV8V01WpzWGI69Slm0rt+rPvjXoVuI7S8MCmQhTH1Xb
 +pXcyjuLRrhOCdZT9bwMqZrGG5nepyZbQjHNXr/SCTLHfkFSk7kRzw0S2XhAJcjGnmVzQ6kkmzy
 FGxCRQZ9we68CWFoBGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzNCBTYWx0ZWRfX8v8CI4U6UVkf
 4gwyyJ42FAp9xzbJAKB5aAMe6o/nf5Ktp1Px6WUY440siSAI7+NIvq8fI7Is05R7+bp1nUEEBh3
 MzrVCIChiDuuRV8nOsQskU2dhk/NG7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190034
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

Um91dGUgbGludXgtdXNlciBpY2ludmEgdGhyb3VnaCBhIGhlbHBlciB0aGF0IGludmFsaWRhdGVz
IHRoZSBhZGRyZXNzZWQKaWNhY2hlIGxpbmUgdW5kZXIgbW1hcF9sb2NrCgpGb3Igc3lzdGVtIG1v
ZGUgaWNpbnZhIGhhcyBub3RoaW5nIGxlZnQgdG8gZG8sIHNvIGl0IHN0YXlzIGEgbm9wLgoKU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgIHwgIDkgKysrKysrKysrCiB0YXJnZXQvaGV4YWdv
bi9oZWxwZXIuaCAgICB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTUg
KysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8ICAzICsrKwogNCBm
aWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCmluZGV4IDQwZTAzNzgxZDM2
Li4xZDI1MzkxMjgyYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtNDk3LDggKzQ5NywxNyBAQAogICAgIGRvIHsg
UnNWID0gUnNWOyB9IHdoaWxlICgwKQogI2RlZmluZSBmR0VOX1RDR19ZMl9kY2NsZWFuYShTSE9S
VENPREUpIFwKICAgICBkbyB7IFJzViA9IFJzVjsgfSB3aGlsZSAoMCkKKworI2lmZGVmIENPTkZJ
R19VU0VSX09OTFkKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWNpbnZhKFNIT1JUQ09ERSkgXAorICAg
IGdlbl9oZWxwZXJfaW5zbl9jYWNoZV9vcCh0Y2dfZW52LCBSc1YsIFwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X3RsKGluc24tPnNsb3QpLCBcCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bChjdHgtPm1lbV9pZHgpLCBcCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bChjdHgtPnBrdC5wYykpCisj
ZWxzZQogI2RlZmluZSBmR0VOX1RDR19ZMl9pY2ludmEoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBS
c1YgPSBSc1Y7IH0gd2hpbGUgKDApCisjZW5kaWYKIAogLyoKICAqIGFsbG9jZnJhbWUoI3VpVikK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggNzhkYzI4Y2E5ZTUuLmE1YTVjMTIzNTMzIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTEzLDYg
KzExMywxMCBAQCBERUZfSEVMUEVSX0ZMQUdTXzQoZ3ZlY19zYWJzZGlmZl93LCBUQ0dfQ0FMTF9O
T19SV0csIHZvaWQsIHB0ciwgcHRyLCBwdHIsIGkzMikKIERFRl9IRUxQRVJfRkxBR1NfNChndmVj
X3VhYnNkaWZmX2IsIFRDR19DQUxMX05PX1JXRywgdm9pZCwgcHRyLCBwdHIsIHB0ciwgaTMyKQog
REVGX0hFTFBFUl9GTEFHU180KGd2ZWNfdWFic2RpZmZfaCwgVENHX0NBTExfTk9fUldHLCB2b2lk
LCBwdHIsIHB0ciwgcHRyLCBpMzIpCiAKKyNpZiBkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitE
RUZfSEVMUEVSXzUoaW5zbl9jYWNoZV9vcCwgdm9pZCwgZW52LCBpMzIsIGludCwgaW50LCBpMzIp
CisjZW5kaWYKKwogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCiBERUZfSEVMUEVSXzMo
cmFpc2Vfc3RhY2tfb3ZlcmZsb3csIHZvaWQsIGVudiwgaTMyLCBpMzIpCiBERUZfSEVMUEVSXzIo
c3dpLCB2b2lkLCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggMjM4OTRmZjNkMjguLjg0ZjU1
NjRiMWU2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjMsNiArMjMsOSBAQAogI2luY2x1ZGUgInFlbXUv
bWFpbi1sb29wLmgiCiAjaW5jbHVkZSAiY3B1LmgiCiAjaW5jbHVkZSAiZXhlYy9oZWxwZXItcHJv
dG8uaCIKKyNpbmNsdWRlICJleGVjL21tYXAtbG9jay5oIgorI2luY2x1ZGUgImV4ZWMvdGFyZ2V0
X3BhZ2UuaCIKKyNpbmNsdWRlICJleGVjL3RyYW5zbGF0aW9uLWJsb2NrLmgiCiAjaW5jbHVkZSAi
ZnB1L3NvZnRmbG9hdC5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgogI2luY2x1
ZGUgImludGVybmFsLmgiCkBAIC0zMTEsNiArMzE0LDE4IEBAIGludDMyX3QgSEVMUEVSKHZhY3No
X3ByZWQpKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgIHJldHVybiBQZVY7CiB9CiAKKyNpZmRl
ZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihpbnNuX2NhY2hlX29wKShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFJzViwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCBzbG90LCBpbnQgbW11X2lkeCwgdGFyZ2V0X3Vsb25nIFBDKQoreworICAgIHRhcmdldF91
bG9uZyBzdGFydCA9IFJzViAmIH4zMTsKKworICAgIG1tYXBfbG9jaygpOworICAgIHRiX2ludmFs
aWRhdGVfcGh5c19yYW5nZShlbnZfY3B1KGVudiksIHN0YXJ0LCBzdGFydCArIDMxKTsKKyAgICBt
bWFwX3VubG9jaygpOworfQorI2VuZGlmCisKIGludDY0X3QgSEVMUEVSKGNhYmFjZGVjYmluX3Zh
bCkoaW50NjRfdCBSc3NWLCBpbnQ2NF90IFJ0dFYpCiB7CiAgICAgaW50NjRfdCBSZGRWID0gMDsK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKaW5kZXggMDZhODE1OWQyODMuLjE1NjBjNDEyNzMyIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YwpAQCAtMzU0LDYgKzM1NCw5IEBAIHN0YXRpYyBib29sIHBrdF9lbmRzX3RiKFBhY2tldCAqcGt0
KQogICAgIGlmIChwa3QtPnBrdF9oYXNfY29mKSB7CiAgICAgICAgIHJldHVybiB0cnVlOwogICAg
IH0KKyAgICBpZiAoY2hlY2tfZm9yX2F0dHJpYihwa3QsIEFfSUNGTFVTSE9QKSkgeworICAgICAg
ICByZXR1cm4gdHJ1ZTsKKyAgICB9CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICAvKiBT
eXN0ZW0gbW9kZSBpbnN0cnVjdGlvbnMgdGhhdCBlbmQgVExCICovCiAgICAgaWYgKGNoZWNrX2Zv
cl9vcGNvZGUocGt0LCBZMl9zd2kpIHx8Ci0tIAoyLjM0LjEKCg==

