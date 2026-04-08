Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CA010F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsf-0000vV-9V; Wed, 08 Apr 2026 14:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXsW-0000LI-3Y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP2-0005bA-NA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M3Jsl1619682
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KmLI/i8A+mCi29CsGc0G0ndA/gMGjKWNIKX8zxNuABc=; b=cmyG9EJWGlaOI7CH
 Dz36wM5wR4QaU4E9ex5M1aWvGEyJ/o1QCgsgcKbpIM/uuSdKWJnF1FLQRt+fBY/2
 EdB12L1+EOmUn8KqFahAHwliGtQlEkoKE3WChGgi0DlWgeJo7uirshwVihg2bCSu
 irX7A6UAi7auaLZegbjPeUy9+p7bi6buy44pLUvz4qj6h+7n7empYbmWSgNw9MeL
 x5xEZTQphf85zP+DIuGyI2ZBFBMeovrKuZGUADlRxTEnfHzvbJFa1qCAjWneaME3
 iPBMG1B4VHvoUr6f3+snRrF/msFSOeww4kz7d2zwAUlR5263js83fLXivLpahVvD
 gbQsPg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrgxj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:26 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12bf9974587so27824703c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622026; x=1776226826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmLI/i8A+mCi29CsGc0G0ndA/gMGjKWNIKX8zxNuABc=;
 b=HadKBqRDzyPmEVdUif6JVNRcMA0aFDTCDNuhzayaEqOM/MiTsSHVGE3sJEMBcMgpIx
 p2HW83Cyrxbf2fu02fpuwvIUXZqi5LnCObukTVw9KfrXO9dtJgXjKaDKCd5s71TnBRbD
 WZEU4bpPxorPilpBh0JQojL6sYBNil3LRyUjyj/rQ56viWY2RCChvTz+VRUdwHuXq5zD
 dRqHO8RjDTSJQ1GDFxXUrk++p0i+EOOSPZtY6vYRTkLOAXJiWfQcAihL5lRcGuJJ2E9I
 XzU0RqFmF+Gd6nTsf0VlYxFGdR5dIFZFvb20p8PBPPrbXZETtZHlndzOVdXIxeqI8fZk
 YQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622026; x=1776226826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KmLI/i8A+mCi29CsGc0G0ndA/gMGjKWNIKX8zxNuABc=;
 b=Xzuul+MC945DxHyhb4rY2YY4c6wTHeAD5U10j5ina/mIQKZr+rKP/mEWymvWWuTAzZ
 JcJt36fsCk7VTfWCzJVBf+mHPs6Mi2lE8EcDJld+PBavvRhAQKfGFPjrd58rvSXmInip
 2NRd3Lp3QhYs2kJdeTaxoqXP3CWQ1irQ9knt0jNsSuE4OtOXfpw521hRDDSSBWPZIU1X
 HJF7LPVuMtB7fRYPPeIlQyhM01WVpDCWlzVW92kMXH5KaB6lLwsSsFlUuHz90v4jfQ7w
 HwWcolYqh9A1yaX6ANJfc0+AAv7QMu4+HDETqrcx4NZgTl6Z84XNJPjfNhnw1186oWGq
 9edg==
X-Gm-Message-State: AOJu0YyXlm7CWAiSaNsdKdgpqa7MMRegPBZiKT8x1HoALfQoTg2VToq0
 6wGpWvsy6B8HHfoncqqF4WVrjiWdYz4QhdWBOPGd49lnWrhhAn6dEjokM5S5fTZw/4ZKwD6dn32
 TAq7+S50gVRbTv5PcseLMJXB++pwH6Rjua6+ZfP/xsyjZ/oUHwAotrAGkXCW7g4w7AQ==
X-Gm-Gg: AeBDiev/1i9i+bjPrr5ElPPYLsBZQy6PivLuasNOt8Vl8sY7t/PQDvVXjuelgDYZ7+P
 LcCSJV1CPNYPQAkkQdqShz9zFv8wejxs3RjZmAT7BzBI+WDdZTMMlfBB/skjkBXLoRU6TA41WVN
 2JQEXvhTOc4NrHujEol+PUjvi4HVVIMdnJ01LaYh4CjNo+luhRsnS621cBy+sQLDICQKXQnwFIJ
 SIhigNGZEc6tWZLAjU5eYRmUmTU1DAo0rSR6yvxUfVwXHhQe6z4Tdlz9LRaN6deNDNwcRuRnRj4
 UCnVvSbYqzWXR6bqhcARy0HMWELv1HmsRTgA/JagINVz+jCVCtErgHS///7/sLaaocvYXZN33eV
 Brwtr//u4Rnekb2LT8wt6AwGBa33EPrKF59otgn1ICvAkcy5BFVIxc5GqdR9MTs2OyCCbEw==
X-Received: by 2002:a05:7022:6713:b0:128:ca6f:adf0 with SMTP id
 a92af1059eb24-12bfb74c93fmr11349249c88.17.1775622025607; 
 Tue, 07 Apr 2026 21:20:25 -0700 (PDT)
X-Received: by 2002:a05:7022:6713:b0:128:ca6f:adf0 with SMTP id
 a92af1059eb24-12bfb74c93fmr11349225c88.17.1775622024933; 
 Tue, 07 Apr 2026 21:20:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 17/28] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Tue,  7 Apr 2026 21:19:42 -0700
Message-Id: <20260408041953.1899532-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: QAY74xXZxgsrogORLxCux2HnW7XLWRXk
X-Proofpoint-GUID: QAY74xXZxgsrogORLxCux2HnW7XLWRXk
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d5d78a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX0mvC6LZPv+fO
 d6l6JfOjJA9Cjf2rwBuud5ERrLR66uMQP6XI8E2zc6ql92in/Rf3pUfPbIqt9hGCjGeOtbY6dsK
 z8oZxPQp5OSA+ESTw9kemVAnFaSgWErdSfOZpftX4pqk4un9gf7g5/qtkBNsuo2E38WYWwHHvML
 5l5YzMyZl69ss+n9NyMryw9C1UrYCWOBQ2iJ11+nq8YvfV7T21zFmPgBdmBEQsFBpv2KdVg1Wti
 E1GDjrDhUiyGhSO+GK/zfopS9efzf3FFiv2KjQezewD0aEBRFNTkxuqfZTqPb70AAHYQFL/OA+m
 QUilJgaku6UkHL//yoVlqOSce2UfdOGuRMMKZMymBuJz47UMlKh0XJQOeDM+5xhO6KhWJlYPxli
 fwi331hGQ9874cgB9HsZ5X482PWbhDylC7e8n3lko1CGhW1NXl54uXoZoUZUu1g7b0eEQGUlfS8
 mruRkgZjFcaCR/T0AIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZDEzMGEwMmY1ZDUu
Ljg5YjQxZmI3ODUxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQyLDYgKzQ0MiwzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

