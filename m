Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AAC10F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV1-0001Tp-Jn; Wed, 01 Apr 2026 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUk-00014C-T8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUj-000883-0C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CS28v1285859
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3ScWNmMreopyHwVdsYRCo2r6szHFVbP/QBl1oIjU0xI=; b=YhO0a1Zd/veBT2vT
 pL2xD/DkP3dSn/HUvG5dK/1JJG4w0Nq3SGVd4rAZ1nLFY8lG1zVWms+negzMHUbX
 eiOiw1YBbaJbn4mhTzcOcaefxU1QJVKIxPtTTybLusK7Cf0l7XPPsaAVWnsYHqLw
 u62dvmg3+snCzutzFS8Zo9bkTvWZo9ENXrQ/wvJBSMiWjs7kwFhFVLnHh2ZhE/bl
 bC46uqj8kXDKotkTP+FRe0K00QB/XejGcTZ9QeUUG/25fUWV8ZxOvumczk5BvcXW
 6xTL2+IUy12qOBOlk7igOlk8xuAoGkyHhD2xbOPu5ufe35hQJfwCdr30cICkkYZe
 F14Trw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2y8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c4cfe08c9dso17796970eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057294; x=1775662094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ScWNmMreopyHwVdsYRCo2r6szHFVbP/QBl1oIjU0xI=;
 b=KDVsW0kntWM2lEIp01eYmTSZcAzZVgb3UqdVhSdFB7g6if75ta6PdnCH72ApDBxP89
 np+rhbQkUGjGF5u2ZhepkTVmnvyIjyUkceTrvoVadJx7y4Yul08K6TH4mdGHBFuzRrM/
 Od1zcy0Ah1JLV0ldN3mXNVgJqIRc7yEPwPMEBeNuBNzc5nDo8fCfmunLoW0UedMXi1jR
 QtxG23HRkPJIWWORv6EkZ1P+RvWJxo2HiQ2Jv5F+9LlCTZXR5UEWu4kcS84VuLXesWyP
 +Wbv29uuol3OVFGJzqA9m6VS4gMEwBXmQEO6c2mHUD9JPG8jHVm7JD+5zCPi+VXOfgsa
 Db2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057294; x=1775662094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ScWNmMreopyHwVdsYRCo2r6szHFVbP/QBl1oIjU0xI=;
 b=sFGXQr103zgqrr9rFdMD1jns4n5Bu0KWdujcnomiRUvbmz1iBiB7JFAb8J0w3L7GG6
 gN2wljUXXkR6CM3ncYljxwaHWt5t9OjnJVeWXWDm1xLzLV0WcQdgfCt/hY0OzsYsuqEV
 ye/b5g8zoQfwf1Uxh9m00cz6rWF9SkZTBaxhu/bbnip6DenZCJ/2WKLftXcO3+vTzNXJ
 O/OXcTh4L1tt6GG1XN7lo6EeF82phPsDUusV6Q62dlTEZjJ3pO8H0nQJLqBozPD+Bphg
 LD4NFNhxYB73/b2+yr9/js0yw7iMoXEr/rZRzdu3UYvBvMlZ5b0bBfb4khnC+sQ+vEvZ
 je2w==
X-Gm-Message-State: AOJu0Yyql34B+O/SIFtUvWgSw0GCIvlhXqbusYavyeRC8rFg+en+Nu4R
 lCBYHSkfRkmPweqd7hA+4CccPXf/JwXU6jtshJFdP8brlLQ5xaqEQZHyMYOLCty1cFNzrtdQ8Tz
 cP6lqZ44l9b0ovkSEWFdfqNMpv+yykEQV6QCsdncl0ioXCENYRBvkKWT+5wSck4j4MA==
X-Gm-Gg: ATEYQzyI5zGJ6+Ql14iuieypQ/nwivThS40jL+Cb4hx4XjVeFJ7on3KRzz6pRfHrPsq
 wuixJS8VFX4sImkTKC0G5lxhNftEvNL7rJunz+ADLhnREdEFHvKh8tQ8YYZ6ww2Y/UDSQfD0snH
 /r0OE9mLdMn3JBvq/LDKQ+FrIoYf+XHZB+BuEgZ+jWRXmkQArvGPuR2GpKum/8J0y9hdSs4mD/N
 44dAjBwdPEXSK7PTCgEENaGK1ccn/5GsmGa5hTFrE+4DJshe6efRjwRWn2N37+jsFk6ruC6rCUB
 FfD4GZ5C2LAvhGT+7+SJD0fufhJeKs0zeLoFGPkckPTNZg7AVlVQXVa9jeb9UhQrIn1vbIU+OhR
 8WliA9w3M4CEPIDnoJZEUJwj+khekSXK0X9twiPegTjpu3PuZcacA80vqeaxKnRknpsDNZw==
X-Received: by 2002:a05:7300:6413:b0:2c5:b23e:48a9 with SMTP id
 5a478bee46e88-2c9328a641cmr2248743eec.25.1775057293986; 
 Wed, 01 Apr 2026 08:28:13 -0700 (PDT)
X-Received: by 2002:a05:7300:6413:b0:2c5:b23e:48a9 with SMTP id
 5a478bee46e88-2c9328a641cmr2248716eec.25.1775057293405; 
 Wed, 01 Apr 2026 08:28:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v6 31/37] target/hexagon: Add implementation of cycle counters
Date: Wed,  1 Apr 2026 08:26:51 -0700
Message-Id: <20260401152657.314902-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd3996 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Bw4caLd0n_0OF-yX4NUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: bN0JWieXwv1FdluPAT7Ryk0ByUuWAjO2
X-Proofpoint-GUID: bN0JWieXwv1FdluPAT7Ryk0ByUuWAjO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX6PqFYD636P+i
 PWUphOz0kSc20qpda044J7e65mi74MWm1knT6YpKVKjsrCQnPQ6Jxay9qRhZ5Akbm2+0O6o/7UO
 yv97SD96MOj0EsM6TshlAuaObJwjXmVDj638pfO9P2lZRtohFM50QFEVswgxpp+p9UMPt81H/4F
 9G7+uNF8nFZZFLi3KMSvErGvltuigAtI+4sFPedKP7YglKX72A/TYtK65bBUe3jCaIciNVM/koX
 j7w7HlmhmbwbK6/xDHnRy7uELXIc5c80OIO4SpkCrkpV7YliJEYWRCfQT50kZYaI19+BpKpwo4V
 wvtPG7M9g6Uye14qXg16yjrD0SqZ6g/JL8pMRJFORGXCFNGg7wPMQ96YQScbF6gKHAIhINOMc1d
 5Cy947HUlOnWi+7XQL37aLaUhs644F9+YW6Qp1RY86TokRagz05jcN14Zq18Vj0IGrOpjXbl2gK
 rHL0eBMWhJOJUSFCKXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QWRkIGN5Y2xlIGNvdW50aW5nIGluZnJhc3RydWN0dXJlIGZvciBzeXN0ZW0gZW11bGF0aW9uOgot
IFBDWUNMRV9FTkFCTEVEIFRCIGZsYWcgdG8gZ2F0ZSBjeWNsZSBjb3VudGluZwotIGdlbl9wY3lj
bGVfY291bnRlcnMoKSB0byBlbWl0IGN5Y2xlIGNvdW50IGluY3JlbWVudHMKLSBSZWFsIGltcGxl
bWVudGF0aW9ucyByZXBsYWNpbmcgcGN5Y2xlIHN0dWJzIGluIGNwdV9oZWxwZXIuYwotIGhleF9j
eWNsZV9jb3VudCBUQ0cgZ2xvYmFsIGZvciB0X2N5Y2xlX2NvdW50Ci0gcGN5Y2xlX2VuYWJsZWQg
Y29udGV4dCBmaWVsZCBpbiBEaXNhc0NvbnRleHQKCkFsbCBwY3ljbGUgY29kZSBpcyBndWFyZGVk
IGJ5ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWS4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNv
biA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggIHwgIDMgKysrCiB0YXJnZXQv
aGV4YWdvbi9jcHUuYyAgICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVy
LmMgfCAxNCArKysrKysrKysrKy0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBi
L3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDU2Zjg5MjA5Nzk1Li5kM2I3YjM0Njg0MSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgK
QEAgLTE2MSw2ICsxNjEsNyBAQCBzdHJ1Y3QgQXJjaENQVSB7CiAjaW5jbHVkZSAiY3B1X2JpdHMu
aCIKIAogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1AsIDAsIDEpCitGSUVMRChUQl9GTEFH
UywgUENZQ0xFX0VOQUJMRUQsIDQsIDEpCiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNl
X2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgK
aW5kZXggN2U1MjgzNzlkYjYuLmVhZjQ4YTg2NWMyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtODQsNiAr
ODQsOSBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIFRDR3YgbmV3X3ByZWRf
dmFsdWVbTlVNX1BSRUdTXTsKICAgICBUQ0d2IGJyYW5jaF90YWtlbjsKICAgICBUQ0d2IGRjemVy
b19hZGRyOworICAgIGJvb2wgcGN5Y2xlX2VuYWJsZWQ7CisgICAgYm9vbCBwa3RfZW5kc190YjsK
KyAgICB1aW50MzJfdCBudW1fY3ljbGVzOwogfSBEaXNhc0NvbnRleHQ7CiAKIGJvb2wgaXNfZ2F0
aGVyX3N0b3JlX2luc24oRGlzYXNDb250ZXh0ICpjdHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA3OWVlNDI2NGM3MC4uNDVh
YzlhM2QyNGUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0yNzUsNiArMjc1LDEwIEBAIHN0YXRpYyBUQ0dUQkNQVVN0YXRlIGhl
eGFnb25fZ2V0X3RiX2NwdV9zdGF0ZShDUFVTdGF0ZSAqY3MpCiAgICAgICAgIGhleGFnb25fcmFp
c2VfZXhjZXB0aW9uX2VycihlbnYsIEhFWF9DQVVTRV9QQ19OT1RfQUxJR05FRCwgMCk7CiAgICAg
fQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMy
KGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVELCAxKTsKKyNlbmRpZgorCiAgICAg
cmV0dXJuIChUQ0dUQkNQVVN0YXRlKXsgLnBjID0gcGMsIC5mbGFncyA9IGhleF9mbGFncyB9Owog
fQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggYTJiNDg2ZjRiYjUuLmJiOTkxYTY3MWU4IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jCkBAIC0zMywxNyArMzMsMjUgQEAgdWludDMyX3QgaGV4YWdvbl9nZXRfcG11X2Nv
dW50ZXIoQ1BVSGV4YWdvblN0YXRlICpjdXJfZW52LCBpbnQgaW5kZXgpCiAKIHVpbnQ2NF90IGhl
eGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50NjRfdCB0b3RhbCA9IDA7CisgICAgQ1BV
U3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBDUFVfRk9SRUFD
SChjcykgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSBjcHVfZW52KGNz
KTsKKyAgICAgICAgdG90YWwgKz0gdGhyZWFkX2Vudi0+dF9jeWNsZV9jb3VudDsKKyAgICB9Cisg
ICAgcmV0dXJuIHRvdGFsOwogfQogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2Nv
dW50X2hpZ2goQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICByZXR1cm4gKHVpbnQzMl90KShoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudikgPj4gMzIpOwogfQogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
X2xvdyhDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworICAgIHJldHVybiAodWludDMyX3QpKGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52
KSk7CiB9CiAKIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCB2YWwpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDAxNDQ1ZmRjYmFj
Li45MWRmZjQ0MmM4MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTYxLDYgKzYxLDkgQEAgVENHdl9pNjQg
aGV4X3N0b3JlX3ZhbDY0W1NUT1JFU19NQVhdOwogVENHdiBoZXhfbGxzY19hZGRyOwogVENHdiBo
ZXhfbGxzY192YWw7CiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OworI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCitUQ0d2X2k2NCBoZXhfY3ljbGVfY291bnQ7CisjZW5kaWYKIFRDR3YgaGV4X3Zz
dG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIFRDR3YgaGV4X3ZzdG9yZV9zaXplW1ZTVE9SRVNfTUFY
XTsKIFRDR3YgaGV4X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKQEAgLTEyOCw2ICsxMzEs
MTUgQEAgc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCiAgICAgZ2VuX2hl
bHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihleGNwKSk7CiB9
CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgZ2VuX3BjeWNsZV9jb3Vu
dGVycyhEaXNhc0NvbnRleHQgKmN0eCkKK3sKKyAgICBpZiAoY3R4LT5wY3ljbGVfZW5hYmxlZCkg
eworICAgICAgICB0Y2dfZ2VuX2FkZGlfaTY0KGhleF9jeWNsZV9jb3VudCwgaGV4X2N5Y2xlX2Nv
dW50LCBjdHgtPm51bV9jeWNsZXMpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBn
ZW5fZXhlY19jb3VudGVycyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICB0Y2dfZ2VuX2FkZGlf
dGwoaGV4X2dwcltIRVhfUkVHX1FFTVVfUEtUX0NOVF0sCkBAIC0xMzYsNiArMTQ4LDkgQEAgc3Rh
dGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAg
ICAgICAgICAgIGhleF9ncHJbSEVYX1JFR19RRU1VX0lOU05fQ05UXSwgY3R4LT5udW1faW5zbnMp
OwogICAgIHRjZ19nZW5fYWRkaV90bChoZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhfQ05UXSwKICAg
ICAgICAgICAgICAgICAgICAgaGV4X2dwcltIRVhfUkVHX1FFTVVfSFZYX0NOVF0sIGN0eC0+bnVt
X2h2eF9pbnNucyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBnZW5fcGN5Y2xlX2Nv
dW50ZXJzKGN0eCk7CisjZW5kaWYKIH0KIAogc3RhdGljIGJvb2wgdXNlX2dvdG9fdGIoRGlzYXND
b250ZXh0ICpjdHgsIHRhcmdldF91bG9uZyBkZXN0KQpAQCAtODIxLDYgKzgzNiw4IEBAIHN0YXRp
YyB2b2lkIGdlbl9jb21taXRfaHZ4KERpc2FzQ29udGV4dCAqY3R4KQogICAgIH0KIH0KIAorI2Rl
ZmluZSBQQ1lDTEVTX1BFUl9QQUNLRVQgMQorCiBzdGF0aWMgdm9pZCB1cGRhdGVfZXhlY19jb3Vu
dGVycyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBQYWNrZXQgKnBrdCA9IGN0eC0+cGt0OwpA
QCAtODQyLDYgKzg1OSw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9leGVjX2NvdW50ZXJzKERpc2Fz
Q29udGV4dCAqY3R4KQogICAgIGN0eC0+bnVtX3BhY2tldHMrKzsKICAgICBjdHgtPm51bV9pbnNu
cyArPSBudW1fcmVhbF9pbnNuczsKICAgICBjdHgtPm51bV9odnhfaW5zbnMgKz0gbnVtX2h2eF9p
bnNuczsKKyAgICBjdHgtPm51bV9jeWNsZXMgKz0gUENZQ0xFU19QRVJfUEFDS0VUOwogfQogCiBz
dGF0aWMgdm9pZCBnZW5fY29tbWl0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKQEAgLTk5NCw2
ICsxMDEyLDEwIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0KERp
c2FzQ29udGV4dEJhc2UgKmRjYmFzZSwKICAgICBjdHgtPmJyYW5jaF9jb25kID0gVENHX0NPTkRf
TkVWRVI7CiAgICAgY3R4LT5pc190aWdodF9sb29wID0gRklFTERfRVgzMihoZXhfZmxhZ3MsIFRC
X0ZMQUdTLCBJU19USUdIVF9MT09QKTsKICAgICBjdHgtPnNob3J0X2NpcmN1aXQgPSBoZXhfY3B1
LT5zaG9ydF9jaXJjdWl0OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgY3R4LT5udW1f
Y3ljbGVzID0gMDsKKyAgICBjdHgtPnBjeWNsZV9lbmFibGVkID0gRklFTERfRVgzMihoZXhfZmxh
Z3MsIFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCk7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQg
aGV4YWdvbl90cl90Yl9zdGFydChEaXNhc0NvbnRleHRCYXNlICpkYiwgQ1BVU3RhdGUgKmNwdSkK
QEAgLTExMzYsNiArMTE1OCwxMCBAQCB2b2lkIGhleGFnb25fdHJhbnNsYXRlX2luaXQodm9pZCkK
ICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBsbHNjX3ZhbCksICJsbHNjX3ZhbCIp
OwogICAgIGhleF9sbHNjX3ZhbF9pNjQgPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTY0KHRjZ19lbnYs
CiAgICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgbGxzY192YWxfaTY0KSwgImxsc2Nf
dmFsX2k2NCIpOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaGV4X2N5Y2xlX2NvdW50
ID0gdGNnX2dsb2JhbF9tZW1fbmV3X2k2NCh0Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVI
ZXhhZ29uU3RhdGUsIHRfY3ljbGVfY291bnQpLCAidF9jeWNsZV9jb3VudCIpOworI2VuZGlmCiAg
ICAgZm9yIChpID0gMDsgaSA8IFNUT1JFU19NQVg7IGkrKykgewogICAgICAgICBzbnByaW50Zihz
dG9yZV9hZGRyX25hbWVzW2ldLCBOQU1FX0xFTiwgInN0b3JlX2FkZHJfJWQiLCBpKTsKICAgICAg
ICAgaGV4X3N0b3JlX2FkZHJbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2VudiwKLS0gCjIu
MzQuMQoK

