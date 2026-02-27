Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D555FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4ab-0007xr-Rn; Fri, 27 Feb 2026 15:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aN-0007QC-06
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aJ-0006rp-Nl
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:17 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RKEvX42595614
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9RZyc2UsUqKVP+qIYyd0htB9SvGTLxy1o1epcMNgoWY=; b=QqxmdQn1qSlOY1+a
 FrmrYU9T0sLrPfIyNrpZgyMB20py32pQZsBFpNk0rcqP//xcgWTPqzGQQlojsV+L
 UWv3rqCTX+asxiWv44gHKma+CpzPzRvuUAqXufalzWcha+ehKj7+2sfmMbsy+nMd
 jMbGhMwjWChq4rfMJDEPAGUnhtS9WQDpDBN5sPUBu9CDom4Z89XrHTapcjyfRING
 K8pK+6+afBGq3TRPhk7xpYZcIAsU6LthqwOUH2Pd0rrBUkvFfm1NRpnYjArXyHe4
 sIf7Lon3zrwl4Njesv9Vr4yxYdZoT7+zqzfSFUYiyWkwGFo6dIgsJ/9p7bODREYL
 8rxAtg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckj4xg1qr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:04 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-45f11f18a89so25104804b6e.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224623; x=1772829423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RZyc2UsUqKVP+qIYyd0htB9SvGTLxy1o1epcMNgoWY=;
 b=BqyUBTUbBHTlVos8c5kT1bexZtY6KAaziOGnXBSGMEdCvR8G/RVN6nBG5E09oX7ykA
 Z1R4GsvD29+aLo1pbbcwhVoso+kp/Xc5BNkfKpAbs9sGiqgtMaENyfD2Xj/39deIwfuy
 uHRog5f3z8YJc2nmLqBJdLc1cXkDzcgYtZY/jJVkxoJwWUu0lyQBh9Hj/b0Lk7Xkx3HW
 HpY3XfMIXe8HFagBHUvLCeeJD+aDoH4GOdtWpaQlB6vNksVEI2Xh7lQUHZDOrmiqElR3
 RfRBY3Bs8gC4RQJohVmQyXc1ULEtn+SKyv6Wn6Nbu5qtss4ky+qhHrmInCdofQ7m45i+
 JmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224623; x=1772829423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9RZyc2UsUqKVP+qIYyd0htB9SvGTLxy1o1epcMNgoWY=;
 b=X03zD/qKesdYKYn0atS8167gosppWVJgVOqXgrFmA/LWyVICv2LuK9NlrURENz7I3j
 VFzcjAksRvxPHh0OcVHg2p0KR0QirwM/zxZRRR5RWSfv0uGEiDgNIc2lSN5DrYR0RXR2
 EmrrMibmhhPJgVNcvdmS7Ou5gb5pP3dtOEDzdTxIAdP9xQTyRY4BYQx7Zsa3tROuqxsb
 64AdZ8ZwS00y5vm/EthG53ZyX4CVT00TX7G04E+9VmM4E0fTSx+KZTgNz1u9a42SNSdi
 0zAmgCCetx9ZRiR5G9srdXbrgjH8imgJINdHnkCobcjMtmiwK8SzqmKjDIcllDQu1CCd
 Glnw==
X-Gm-Message-State: AOJu0YwdJ8pyFwOQ1wx1fiPOpowHkFrbJT0FSIcB1qjMZ9AuZk4wQCQn
 BpJXi9aBp9QVZKQufPj4Is1SCVKU4wBQBtgGav/CO68xZhYk0rquvO/COMOPnm4QO/+BZ0OT4SW
 hdkzHC44j6TM6SpqMaK9zAqTYldfkcWF9PIZS4RcHyTLgLo0slIN3rppJYfRqSZI1YA==
X-Gm-Gg: ATEYQzwjpEvSGl9xBfIfZMyBHzNDZjJBLBBDYXWjezyBgGsJAGbQBKmNrKmlzXlPEij
 xP93AfW5M8HWSrvcOCaVcMPnEFXNNIJRxfeGdvcKuucY11eRbbN14Y7MUrCi0s6E5U5+oP3A0BP
 dq6dVsWoSx5/oyHwbXamoY8MgwCqq7KaSGNlqqc8/MiscSD4Us6e/OW/lfBTh2Hhxaek3IpTOad
 AifgAGBc5pDL4fUZgPSdwTdiUNRDZ+itJEaGHjb3+D4v5MDVSt4c8vB4leYfoBTcQRL7AJQj5EF
 rG4mr4kQb+aAP3kdDfcGKy6BVWJGbqFpi3dmeCOZ1DeVFRqiGJI+YX+k+HihoMK9bE12UI5Xw9U
 riKu7hdeVkDjEfS6wQLsLU0cXAbbPsyMoSCoLlYsFFzcGDGTKRJ/COaoY4DVGbP9EQNm/qA==
X-Received: by 2002:a05:6808:1a29:b0:462:dd4d:7679 with SMTP id
 5614622812f47-464bea41239mr2371370b6e.7.1772224623509; 
 Fri, 27 Feb 2026 12:37:03 -0800 (PST)
X-Received: by 2002:a05:6808:1a29:b0:462:dd4d:7679 with SMTP id
 5614622812f47-464bea41239mr2371351b6e.7.1772224623146; 
 Fri, 27 Feb 2026 12:37:03 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:02 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 23/37] target/hexagon: Implement do_raise_exception()
Date: Fri, 27 Feb 2026 12:36:13 -0800
Message-Id: <20260227203627.932864-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX1AMYVHDwNgl4
 Q3lOeZeo+Y5/erG84RRH9yVXx2+fGS01iaiYFCtpf82MinEWWye+yyCACahYVqJCReyx0prfKKO
 RpL0R+R+WK2YOK9CkoMUpDCkBu9n8PaXzDDCWrnylsjY71TP/Tf4k8Le4xUT/0HwNcAOV4mzp/4
 5DORMc9Bv7DJgT5JTEMiLLqxEZzyFKaaMqM2ol6mx1kM52udA2tN5wHQl/QS4vtGVLVdMY14FVg
 RJpP+9VKc2GKmA7oKApbhlX/tcesV/TwNYiCvidadWHyfo5ybMvl2BL27flK46xWVMMAyFywmFQ
 smvGPo7gEKay16YKDcqmpNmJedX2hsCZQFNOZ7KuLQLxN313zzsZ0W5pIy3rX7gDs0yJuydKDYY
 N2culCuoUigcZfxXYeCST2gQyYejL44AIb5w2y+K29eNDP0SMrbQUSZcLfvVpS4hWTwBqfrl/Nt
 c0wNiu4WIcb9dmr/uwg==
X-Authority-Analysis: v=2.4 cv=QppTHFyd c=1 sm=1 tr=0 ts=69a20070 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: z2Q76NVu4GirgZFe1DuDP_WiEjKIpAba
X-Proofpoint-GUID: z2Q76NVu4GirgZFe1DuDP_WiEjKIpAba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aW50ZXJuYWwuaCAgfCAgNSArKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAxOSAr
KysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oIGIvdGFyZ2V0L2hleGFnb24vaW50
ZXJuYWwuaAppbmRleCBjZDA2ZmY0MWQ0Zi4uZDk0Zjg0YjQ2YTcgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2ludGVybmFsLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaApAQCAt
MzEsNiArMzEsMTEgQEAgdm9pZCBoZXhhZ29uX2RlYnVnKENQVUhleGFnb25TdGF0ZSAqZW52KTsK
IAogZXh0ZXJuIGNvbnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX3JlZ25hbWVzW1RPVEFMX1BFUl9U
SFJFQURfUkVHU107CiAKK3ZvaWQgR19OT1JFVFVSTiBkb19yYWlzZV9leGNlcHRpb24oQ1BVSGV4
YWdvblN0YXRlICplbnYsCisgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKKyAgICAgICAgdGFy
Z2V0X3Vsb25nIFBDLAorICAgICAgICB1aW50cHRyX3QgcmV0YWRkcik7CisKICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQogZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hl
eGFnb25fY3B1OwogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDEzZTNjMmMzYTQxLi41NGIyMmYy
ZmVlNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTM3LDYgKzM3LDI1IEBACiAjZGVmaW5lIFNGX01BTlRC
SVRTICAgIDIzCiAKIC8qIEV4Y2VwdGlvbnMgcHJvY2Vzc2luZyBoZWxwZXJzICovCitHX05PUkVU
VVJOCit2b2lkIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgZXhjZXB0aW9uLAorICAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X3Vsb25nIFBDLCB1
aW50cHRyX3QgcmV0YWRkcikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7Cisj
aWZkZWYgQ09ORklHX1VTRVJfT05MWQorICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIl
czogMHglMDh4XG4iLCBfX2Z1bmNfXywgZXhjZXB0aW9uKTsKKyNlbHNlCisgICAgcWVtdV9sb2df
bWFzayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOHgsIEAgJTA4IiBQUkl4MzIgIlxuIiwKKyAgICAg
ICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKworICAgIEFTU0VSVF9ESVJF
Q1RfVE9fR1VFU1RfVU5TRVQoZW52LCBleGNlcHRpb24pOworI2VuZGlmCisKKyAgICBlbnYtPmdw
cltIRVhfUkVHX1BDXSA9IFBDOworICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNlcHRpb247
CisgICAgY3B1X2xvb3BfZXhpdF9yZXN0b3JlKGNzLCByZXRhZGRyKTsKK30KKwogR19OT1JFVFVS
TiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgZXhj
ZXB0aW9uLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
cHRyX3QgcGMpCi0tIAoyLjM0LjEKCg==

