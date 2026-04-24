Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47522FDEE5D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6P2-0006jy-LI; Thu, 23 Apr 2026 22:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P0-0006jT-QL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6Oy-0008I2-Km
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O0UiEK154571
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oByYefPobt+hcemOQ65toT/WbilTH5wPecxvjLplOqQ=; b=eN7x2Cxn2DsKTSk7
 lp7Xr7MTuU4vnmtNdeDfeidbKsBz1Uq0ApjIfgCxfkQUh2H9dnbhHsu56q/2ROnV
 W+DwCcexSkh1CFy4LIQuzvTar2KIneMyeuVNj5Mw9+Grp9QMHPcnYB2/UwZC+zRT
 W7g3FWiihSgftYpS5EpSkxmjtZLibpFAcMTTvF3wI4DZDW84BLY4KwRkhC6ocsx9
 5ckSiDLGMtKflfnYkZv9I/E8koXv11oo8L9hK9fLh6Q5TkMrQFN0K7Jg8yctwPjv
 7Bl4IKD5nj2rhig6nnBexrtNyOSevR9T+x17hhPJgLX2/bFMoIekyW7QWxRBhINg
 OKEHaA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpf629gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2e60238adb1so16086473eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776998178; x=1777602978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oByYefPobt+hcemOQ65toT/WbilTH5wPecxvjLplOqQ=;
 b=LzZL9G2oU4Q7Y0vS4kMkb9UEmTlxo/ClQq1BUtoyERDDJjiRcls3iFE9c4Qvg+euiF
 5xrPxXVtz0Adbp5QCPhemXP4KwyF+jCWFiWQkhsH1XVUJGDRllqbqiqVCHYoIlOvJErq
 ER708qhujYZ9/y2hoMwVbmzGLopyBVRMVNsUMQhJ4h8oh8Qo2EXMuiDiMDQyhfqj+tvc
 GnDPHApwyyJ7Zxvue2uPrzNBqJnnlW2xEtrdE01N5bYZqWrf9Zugu9DjaVicwIMuLEeH
 IcqGx0ME/1wn+eqGVIxPRNCI+5VLYs3hcVSHkbfwsDA8hDOcJE9UTHvoVekBA6DSefi6
 2Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998178; x=1777602978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oByYefPobt+hcemOQ65toT/WbilTH5wPecxvjLplOqQ=;
 b=J9CuCTRfPsblvSUFkTadneBg5X67Ike8fPe/WTrhDzyD4DFyZdgo33QGXJVT474zhA
 76Lzfu+WQZx1gmx7XXs39oGiEvN6cQsuW61oTDpD3fyxAmJa6pRC9QBbaRUXBur0jEuL
 QgvjUXqmgLIEFl28M5cjjYrZGYrFKdoPHrmiiC8QiBTSbqmHxIhKNVJT78de9iD2/1Yf
 dmVT/jOhpFdkpN5dEfb6EtOcX/N01xIFr3tUDEtca1yEoOgD8SmCHzoO/SA7N3zQfMWt
 tRKFJLhabsEGLs1YIu5QbCxs4W+JQOhh7r2h5lV4tPOpR8lHe91E6IbjXbUMcOUp77Gz
 z0HA==
X-Gm-Message-State: AOJu0YykmW1qkyKCzl5SNDVs2wtSfqCRKQh2ZhrklYhgMzrBUiccDhqY
 FB6ssWeLc2uhTVwbDQUI+GGYMxtjzIiA4ykvyw3GHeMQlkhpZyiRDiY/l9/+MzUDMJM+nYZw5T4
 BYiTlvMzHMGUTTiFanABMw1dXOKMrRETtm0DLRS1MN9Rz6XQq43zFEOx15Oipujeijg==
X-Gm-Gg: AeBDieuF53mYCH9gfbix8TV1+k7YsrKmgWGTjPjupa4QzO74KTZtD+4XEn6v+WGmQyN
 3FB/aavizAtHhj95JUzv/+ju7ai52pAGgxt019bmqhEolb2ZNTSrdVpp9N+P1m9mvSLwg7MXM23
 S34zo/tufU2aVNhMpIDh5A0fhNJlPa/qQaKR879OEzHxKVOnStychMPItHumg8PaEqHbFamwopX
 uHMvv9U/CJMoVunvHIG3vKVFHdIAKZSADJWFRp68oNzkhf6i5nQ3/Nn+D1jH6YMZMlwce3yObL3
 13LUodWKNqQdplWpYq+RTtfqizQDc+yuf55ZSTS29allK+gkP1rrtK9Naz2jpqDojdQ4IwWMJi0
 spNAOZ86P9QdQtD703+/vazdLsRA22S+OFLiuexdRr1JzXQR1b61qblLL0AjdliesKN7/vtxWpf
 /dk4Ir
X-Received: by 2002:a05:7301:6587:b0:2ea:6361:8981 with SMTP id
 5a478bee46e88-2ea63618b8bmr10546376eec.22.1776998177775; 
 Thu, 23 Apr 2026 19:36:17 -0700 (PDT)
X-Received: by 2002:a05:7301:6587:b0:2ea:6361:8981 with SMTP id
 5a478bee46e88-2ea63618b8bmr10546365eec.22.1776998177258; 
 Thu, 23 Apr 2026 19:36:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm31240868eec.3.2026.04.23.19.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:36:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/9] Hexagon (target/hexagon) Properly handle Hexagon CPU
 version
Date: Thu, 23 Apr 2026 19:35:58 -0700
Message-Id: <20260424023606.2556830-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
References: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Iocutr/g c=1 sm=1 tr=0 ts=69ead722 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=kO7NYY--Zd9gfOQAb1oA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 8tfChXzFOW5o3VhYfRu839aXxj8imIeQ
X-Proofpoint-GUID: 8tfChXzFOW5o3VhYfRu839aXxj8imIeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAyMCBTYWx0ZWRfX5rJey1EOLnhI
 72OKajPPjSLuOh0u/Ld7/MnVtczpWdgN5LO8Ft9Ur1RyycsOzR85nri73CnprMJBGLa3TOdN+7m
 SN/5subbI7E0JpNd9il9L0iZDbEfBy+LKH7zjTYbeeMmgUUVzYCtx4kS1DJTA6iDc0pdWVjJiOf
 LW5WG6kUyAmEwbBP+grGdebZcvh/aE/9K4uLe1ENH1kkZe7Cwy2BhczCUfvWNDRiGWhRYBSSnrS
 AXRmBby2n9QHPNUOP94wL6/KB4iTllc1vmve1GjTBXaF5c/AmiUQkhisxTkQDMCVRhskSGEkl+i
 Stx6JbAPdtQCD0oPqg4q286resLdBZudhxY+TQEhoF45mE2MuITRZruZ/CxarM30bfExsa/66zJ
 CRi44Zev27CrqmhDE7scMR4FW8Up8vuPrGKQxBf7xz6eZRFbs/0JFeiBFzGWSHqg2Wdcjtu3PJ+
 5X0bYaKgUUywVHqUbMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240020
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkFkZCB0aGUg
Zm9sbG93aW5nIENQVSB2ZXJzaW9ucyB0aGF0IHdlcmUgcHJldmlvdXNseSBtaXNzaW5nCiAgICB2
NQogICAgdjU1CiAgICB2NjAKICAgIHY2MQogICAgdjYyCiAgICB2NjUKCkNyZWF0ZSBhIENQVUhl
eGFnb25EZWYgc3RydWN0IHRvIHJlcHJlc2VudCB0aGUgZGVmaW5pdGlvbiBvZiBhIGNvcmUKICAg
IEN1cnJlbnRseSBjb250YWlucyBhbiBlbnVtIHdpdGggdGhlIGtub3duIEhleGFnb24gQ1BVIHZl
cnNpb25zCkFkZCBhIGZpZWxkIHRvIEhleGFnb25DUFVDbGFzcyB0byBub3RlIHRoZSBIZXhhZ29u
IGRlZmluaXRpb24KCkNvLWF1dGhvcmVkLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8
bWF0aGV1cy5iZXJuYXJkaW5vQG9zcy5xdWFsY29tbS5jb20+CkNvLWF1dGhvcmVkLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBBbnRvbiBK
b2hhbnNzb24gPGFuam9AcmV2Lm5nPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oIHwgMjcg
KysrKysrKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICB8ICAyICsr
CiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDE4IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCAwYjE0OWJkNWZlYS4uNmUxYmIwNDA3MDQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTExLDExICsxMSwzOCBAQAogCiAjaW5jbHVkZSAiaHcvY29yZS9jcHUuaCIKIAor
dHlwZWRlZiBlbnVtIHsKKyAgICBIRVhfVkVSX05PTkUgPSAweDAwLAorICAgIEhFWF9WRVJfVjUg
PSAweDA0LAorICAgIEhFWF9WRVJfVjU1ID0gMHgwNSwKKyAgICBIRVhfVkVSX1Y2MCA9IDB4NjAs
CisgICAgSEVYX1ZFUl9WNjEgPSAweDYxLAorICAgIEhFWF9WRVJfVjYyID0gMHg2MiwKKyAgICBI
RVhfVkVSX1Y2NSA9IDB4NjUsCisgICAgSEVYX1ZFUl9WNjYgPSAweDY2LAorICAgIEhFWF9WRVJf
VjY3ID0gMHg2NywKKyAgICBIRVhfVkVSX1Y2OCA9IDB4NjgsCisgICAgSEVYX1ZFUl9WNjkgPSAw
eDY5LAorICAgIEhFWF9WRVJfVjcxID0gMHg3MSwKKyAgICBIRVhfVkVSX1Y3MyA9IDB4NzMsCisg
ICAgSEVYX1ZFUl9BTlkgPSAweGZmLAorfSBIZXhhZ29uVmVyc2lvbjsKKwordHlwZWRlZiBzdHJ1
Y3QgeworICAgIEhleGFnb25WZXJzaW9uIGhleF92ZXJzaW9uOworfSBIZXhhZ29uQ1BVRGVmOwor
CiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFUgImhleGFnb24tY3B1IgogCiAjZGVmaW5lIEhFWEFH
T05fQ1BVX1RZUEVfU1VGRklYICItIiBUWVBFX0hFWEFHT05fQ1BVCiAjZGVmaW5lIEhFWEFHT05f
Q1BVX1RZUEVfTkFNRShuYW1lKSAobmFtZSBIRVhBR09OX0NQVV9UWVBFX1NVRkZJWCkKIAorI2Rl
ZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y1IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjUiKQorI2Rl
ZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y1NSBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY1NSIpCisj
ZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjYwIEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjYwIikK
KyNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WNjEgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NjEi
KQorI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y2MiBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY2
MiIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjY1IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgi
djY1IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WNjYgSEVYQUdPTl9DUFVfVFlQRV9OQU1F
KCJ2NjYiKQogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y2NyBIRVhBR09OX0NQVV9UWVBFX05B
TUUoInY2NyIpCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjY4IEhFWEFHT05fQ1BVX1RZUEVf
TkFNRSgidjY4IikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmgKaW5kZXggODVhZmQ1OTI3NzguLmY5OTY0N2RmYjYxIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMTE3LDYg
KzExNyw4IEBAIHR5cGVkZWYgc3RydWN0IEhleGFnb25DUFVDbGFzcyB7CiAKICAgICBEZXZpY2VS
ZWFsaXplIHBhcmVudF9yZWFsaXplOwogICAgIFJlc2V0dGFibGVQaGFzZXMgcGFyZW50X3BoYXNl
czsKKworICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWY7CiB9IEhleGFnb25DUFVDbGFz
czsKIAogc3RydWN0IEFyY2hDUFUgewpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBmZmQxNGJiNDY3OC4uMjNhYzkxZTdiNDcgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CkBAIC0yNywxMyArMjcsNiBAQAogI2luY2x1ZGUgImV4ZWMvZ2Ric3R1Yi5oIgogI2luY2x1ZGUg
ImFjY2VsL3RjZy9jcHUtb3BzLmgiCiAKLXN0YXRpYyB2b2lkIGhleGFnb25fdjY2X2NwdV9pbml0
KE9iamVjdCAqb2JqKSB7IH0KLXN0YXRpYyB2b2lkIGhleGFnb25fdjY3X2NwdV9pbml0KE9iamVj
dCAqb2JqKSB7IH0KLXN0YXRpYyB2b2lkIGhleGFnb25fdjY4X2NwdV9pbml0KE9iamVjdCAqb2Jq
KSB7IH0KLXN0YXRpYyB2b2lkIGhleGFnb25fdjY5X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0K
LXN0YXRpYyB2b2lkIGhleGFnb25fdjcxX2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KLXN0YXRp
YyB2b2lkIGhleGFnb25fdjczX2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KLQogc3RhdGljIE9i
amVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1lKGNvbnN0IGNoYXIgKmNwdV9tb2Rl
bCkKIHsKICAgICBPYmplY3RDbGFzcyAqb2M7CkBAIC0zNzcsMTEgKzM3MCwyMSBAQCBzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCBjb25zdCB2b2lkICpk
YXRhKQogICAgIGNjLT50Y2dfb3BzID0gJmhleGFnb25fdGNnX29wczsKIH0KIAotI2RlZmluZSBE
RUZJTkVfQ1BVKHR5cGVfbmFtZSwgaW5pdGZuKSAgICAgIFwKLSAgICB7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcCi0gICAgICAgIC5uYW1lID0gdHlwZV9uYW1lLCAgICAg
ICAgICAgICAgICAgXAotICAgICAgICAucGFyZW50ID0gVFlQRV9IRVhBR09OX0NQVSwgICAgICAg
IFwKLSAgICAgICAgLmluc3RhbmNlX2luaXQgPSBpbml0Zm4gICAgICAgICAgICBcCitzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZv
aWQgKmRhdGEpCit7CisgICAgSGV4YWdvbkNQVUNsYXNzICptY2MgPSBIRVhBR09OX0NQVV9DTEFT
UyhjKTsKKyAgICAvKiBNYWtlIHN1cmUgYWxsIENQVSBtb2RlbHMgZGVmaW5lIGEgSGV4YWdvbkNQ
VURlZiAqLworICAgIGdfYXNzZXJ0KCFvYmplY3RfY2xhc3NfaXNfYWJzdHJhY3QoYykgJiYgZGF0
YSAhPSBOVUxMKTsKKyAgICBtY2MtPmhleF9kZWYgPSBkYXRhOworfQorCisjZGVmaW5lIERFRklO
RV9DUFUodHlwZV9uYW1lLCB2ZXJzaW9uKSAgICAgICAgIFwKKyAgICB7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICAubmFtZSA9IHR5cGVfbmFtZSwg
ICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgIC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fQ1BV
LCAgICAgICAgICAgIFwKKyAgICAgICAgLmNsYXNzX2RhdGEgPSAmKGNvbnN0IEhleGFnb25DUFVE
ZWYpIHsgXAorICAgICAgICAgICAgLmhleF92ZXJzaW9uID0gdmVyc2lvbiwgICAgICAgICAgICBc
CisgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICB9
CiAKIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CkBA
IC0zOTQsMTMgKzM5NywyMCBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gaGV4YWdvbl9jcHVfdHlw
ZV9pbmZvc1tdID0gewogICAgICAgICAuYWJzdHJhY3QgPSB0cnVlLAogICAgICAgICAuY2xhc3Nf
c2l6ZSA9IHNpemVvZihIZXhhZ29uQ1BVQ2xhc3MpLAogICAgICAgICAuY2xhc3NfaW5pdCA9IGhl
eGFnb25fY3B1X2NsYXNzX2luaXQsCisgICAgICAgIC5jbGFzc19iYXNlX2luaXQgPSBoZXhhZ29u
X2NwdV9jbGFzc19iYXNlX2luaXQsCiAgICAgfSwKLSAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdP
Tl9DUFVfVjY2LCAgICAgICAgICAgICAgaGV4YWdvbl92NjZfY3B1X2luaXQpLAotICAgIERFRklO
RV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNjcsICAgICAgICAgICAgICBoZXhhZ29uX3Y2N19jcHVf
aW5pdCksCi0gICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y2OCwgICAgICAgICAgICAg
IGhleGFnb25fdjY4X2NwdV9pbml0KSwKLSAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVf
VjY5LCAgICAgICAgICAgICAgaGV4YWdvbl92NjlfY3B1X2luaXQpLAotICAgIERFRklORV9DUFUo
VFlQRV9IRVhBR09OX0NQVV9WNzEsICAgICAgICAgICAgICBoZXhhZ29uX3Y3MV9jcHVfaW5pdCks
Ci0gICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y3MywgICAgICAgICAgICAgIGhleGFn
b25fdjczX2NwdV9pbml0KSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjUsICAg
ICAgICAgICAgICAgSEVYX1ZFUl9WNSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BV
X1Y1NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjU1KSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVY
QUdPTl9DUFVfVjYwLCAgICAgICAgICAgICAgSEVYX1ZFUl9WNjApLAorICAgIERFRklORV9DUFUo
VFlQRV9IRVhBR09OX0NQVV9WNjEsICAgICAgICAgICAgICBIRVhfVkVSX1Y2MSksCisgICAgREVG
SU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y2MiwgICAgICAgICAgICAgIEhFWF9WRVJfVjYyKSwK
KyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjY1LCAgICAgICAgICAgICAgSEVYX1ZF
Ul9WNjUpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNjYsICAgICAgICAgICAg
ICBIRVhfVkVSX1Y2NiksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y2NywgICAg
ICAgICAgICAgIEhFWF9WRVJfVjY3KSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVf
VjY4LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNjgpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhB
R09OX0NQVV9WNjksICAgICAgICAgICAgICBIRVhfVkVSX1Y2OSksCisgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3MSwgICAgICAgICAgICAgIEhFWF9WRVJfVjcxKSwKKyAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjczLCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzMpLAog
fTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

