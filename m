Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20137606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HWHO+VHO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SkgLSK6o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumJ-0000d0-89; Fri, 30 Oct 2026 18:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumH-0000cW-7n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumF-0003pH-3J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtKCP2926925
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SbXmQwLEJDzXxae6LnGdzG
 l1ZC2Z27scPuDHZSHotYo=; b=HWHO+VHOoU6M3FpD8dMB7ynG6wrbLaf+J3j9W6
 ejKReWo2RC8mN9MgPxmsmGGrySiQQdAuu4R9++JxMJshdPGFSx/Ho3aQe75u7yF5
 V9THIQ1xb7gEaW30rvXLxEWL7xKCLR7HC5moh+epe/6qQT3RGNbb4BFYLANJxi3+
 5Vtw3jUQ6vJWPdVHV3oxxqbBTf/r6rK7Lz64uXP8i8UzjGTaGi/UejkuioOHYTDr
 F1g1aBXPBqJ+66a4BbENDrNUVYlH1UDO4BndO691nxVkqQYmUdyfO+Jpzdj/dBef
 YtYddR0Zokb3vdUHFRtCL1dtwNPqszsZJkW8yZc1/bj8r5tg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x18558-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so4420464eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398123; x=1794002923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SbXmQwLEJDzXxae6LnGdzGl1ZC2Z27scPuDHZSHotYo=;
 b=SkgLSK6oN01hFqM7o69V7OPjVXAZTRqvnH3fnYn/XDyTBRnCrt1ORTvUiiWSXZo/ig
 ngPDM/q7iThgY9IHaoAq1bWx5+dVjRyqsK7yo5foy4dCx3YyNyy8DuxnSWCXTwsQ9nah
 hz/ly2BdacVI6cDgFANH4H1D86crOzAJjfldk9NUrorbet/f+z4uPWYa/r4to8lwQ1bU
 nE8Kz+C+FBJ0MtguZqBAsiFm7RLyngp8Ml5UZKtYF6BtPjwpwXLQ78k/eHFeAX4pSKjz
 t57HmnO4hcKzQdQ3oIks46qmwsPoQBHVMKdgZ/LCGfe8dFTqc1SETCagfo4B5KfATRcK
 FN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398123; x=1794002923;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SbXmQwLEJDzXxae6LnGdzGl1ZC2Z27scPuDHZSHotYo=;
 b=Gl8C0ueRpp/yx9iuq8USJsugkOzr55o+apIxbteBToJmD5P4Ywxq/P6zfX+EOumzcU
 nDnJY5MVDp32Kudpv5jXc/PY52XgNQEp2LOK030zqXwga630W0JVHgGoddmJHST1s0U0
 zJ0enuTND/Dn+CiLPB0czoEc4K3+CTufQW5TFRZ4TDmh8uk+rWbh1tEec3J5G9+Dakzh
 6fEwitNNWnnw4myFyINS07wexpihCK48jbSZYGhAe9itXSnQN+6B8e45NIMF8HRaW876
 P+EiDdqK0WHwBRmm92G3uAbmcYvBip1x5jHXiI4to0/q3nOD2qUfB4DQ6zfweUcMXgne
 X3Ag==
X-Gm-Message-State: AFq9FYI8fozeSPE0umCxYDbTbKltS3mQ0he836DLeGoQyAJuUrAIX7NW
 bggDHW/uk2i2hPpFNdHC61t6DPQ5s5RS0nIRlx5EZAlaR+cDyRlVEDgz0VYgw9PWWnjAEEyODf1
 JEekg/MXyjsjpJ7rDMjW5pvR2U3BbsGiloL6XlyfulxLrZnzU1Fo/seWqA7XJNhluXA==
X-Gm-Gg: AYBFou3U89IdT3g4WbEiqyyHSAeqOc18EFDDEJ8q8Gccqjq/a/OoKVNeIJqPwchNKOo
 2vCwg4JYsbvCTAdIzBgF10GuKosP5UrdjVtRWlIjQsTYiwZawDVOzEMop78FHELFfwgzeqqjclr
 +HOc13DzXJqkomQcXkmMax+3dlRoeoI8/juQh45BsGH95/G0jDZirLocDtBH6pTqiTpfINc/8f3
 suZiV71pskCbeZlPCIIBLsM10sXLbFCjSs03YRyK5+nPY7LwfQdaGTPNG8zrwsNTNrakQyHloO0
 U6m5mBaYLqRbSYWpwmoCywUR5Jm9m3sAKSFP3+wtXfFY/vMCILRK0VYcSXEtaEpvo1UXhDdjgH+
 DqwDQ/LkNWYrSE+1FR7QcBCBLmfLAmW+WyjlHBy2dofOurtUbpg+O6bRe4a8Px+RIMf44ZL4fQD
 15CJ9xkVGf2YblLJxr+5pj
X-Received: by 2002:a05:693c:8803:20b0:369:f0de:259f with SMTP id
 5a478bee46e88-36a424085bemr5616547eec.35.1793398123539; 
 Fri, 30 Oct 2026 15:08:43 -0700 (PDT)
X-Received: by 2002:a05:693c:8803:20b0:369:f0de:259f with SMTP id
 5a478bee46e88-36a424085bemr5616510eec.35.1793398122938; 
 Fri, 30 Oct 2026 15:08:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 0/8] Hexagon: HMX system
Date: Fri, 30 Oct 2026 15:08:32 -0700
Message-Id: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 0e8vPlaBAluVNAP_wX79XqsJ2b4aS-lh
X-Proofpoint-ORIG-GUID: 0e8vPlaBAluVNAP_wX79XqsJ2b4aS-lh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX7bqB3tP6BxvB
 16S3FKc4UnSoDT8nQtDeXp2WWdT19XqeELaPUcJdjhWFIkQu3t+njilhevKjFCaDORqJOz5DEBy
 kskQQ8vgrZ9L06tUh51M4iRYHlxItFvBQAeiqNQxTrdBJlKyF9DDHFkkC0Ka1GZgheD7kaq3mU1
 szSuw0Vl1o4QwPVoeXgSqBWaJ7cTUZdoswgPPmtq+ctHOwC6s6F7ABTJLBBoMZEquSFGiiJjpTH
 N8NqV22U3cqAGqoa7g+hnbE5jliNc70ho0rj0wMsFjHFZF/6z11M+PbyaYLK6QjoPtIrZr/6m5N
 EQeLp492ditlvJOK6k5ipMpnIRZTlx7zs0KWoufWiPCHmbwlu8WOSPiCuEM9s/Khr8dgrBnBS4M
 KWoVdQ/CtkETzZjDOXyFSv3YcJAD8JRTSEN1CEsrerbPLL39wKUggnGrQGQKLzb4XGookeL65Kk
 ItvA48zEBsMEpnKGX8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfXxZEGsLHgKg46
 N7jIt5g8CUnAjEPvbUziYCz+YhxSfpIJA+CPvWpD+qlzV6Rf/RmA35nmXjfPJyCIahwV7NWcSpl
 E+5HYI3F/4p70C3JRlsymnuwJDa6ahw=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae5156c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q-fDB7BCGwsXZ7gRVSsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIEhNWCBzeXN0ZW0gZW11bGF0aW9uIGZlYXR1cmVzIGFuZCBsb2cgdGhlIEhNWCBvcGNvZGVz
IGFzICdVTklNUCcgZm9yCm5vdy4KCiJ0YXJnZXQvaGV4YWdvbjogaW1wbGVtZW50IG14Y2xyYWNj
IiBpcyB0aGUgc29sZSBwYXRjaCB3aXRob3V0IGEgUi1iIGluIHYzLgoKSW4gdjM6Ci0gTW92ZWQg
bXhjbHJhY2MgZWZmZWN0cyB0byAiY29tbWl0IiBzdGFnZSBzbyB0aGVyZSdzIG5vIGlzc3VlIHcv
cGFja2V0CnJlcGxheS9pZGVtcG90ZW5jeS4KLSBGaXhlZCBwb3RlbnRpYWwgbnVsbCBwb2ludGVy
IGRlcmVmIGJ5IGFkZGluZyBjcHUtPmhteCBsaW5rIHRvIFRCX0ZMQUdTLgoKSW4gdjI6Ci0gRml4
ZWQgdGhlIC5pbnRyb2R1Y2VkIHJlZmVyZW5jZXMgaW4gdGFnX3Jldl9pbmZvLmMuaW5jIHRvIHVz
ZSB0aGUgY29ycmVjdAphcmNoIHJldmlzaW9uIGZvciB0aGUgSE1YIG9wY29kZXMuCi0gRml4IHRo
ZSBvdmVycmlkZSBmb3IgbXhjbHJhY2MuCgp2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI2MTAzMDAyNDExMC4xOTg2NTM2LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tLwp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyOTIzMDMx
MC4xNjMyMzM0LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoOCk6
CiAgdGFyZ2V0L2hleGFnb246IGFkZCBITVggYXR0cnMsIHN0YXRlCiAgaHcvaGV4YWdvbjogYWRk
IHRoZSBITVggY29udGV4dCBkZXZpY2UKICB0YXJnZXQvaGV4YWdvbjogYWRkIHBlci1DUFUgSE1Y
IGNvbmZpZ3VyYXRpb24KICB0YXJnZXQvaGV4YWdvbjogaW1wb3J0IEhNWCBpbnN0cnVjdGlvbiBk
ZWZpbml0aW9ucwogIHRhcmdldC9oZXhhZ29uOiBnYXRlIEhNWCBleGVjIG9uIFNTUjpYRTIKICBo
dy9oZXhhZ29uOiBkZXNjcmliZSBITVggaW4gdGhlIGRldmljZSB0cmVlCiAgaHcvaGV4YWdvbjog
bWlncmF0ZSB0aGUgSE1YIHN0YXRlCiAgdGFyZ2V0L2hleGFnb246IGltcGxlbWVudCBteGNscmFj
YwoKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAgICAgICB8ICAgNSArCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5oICAgfCAgMjQgKysKIHRhcmdl
dC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSArCiB0YXJnZXQvaGV4
YWdvbi9nZW5fdGNnX2hteC5oICAgICAgICAgICAgICAgfCAgMTMgKwogdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2hteF9j
b25maWcuaCAgICAgICAgICAgICAgICB8ICAxNyArCiB0YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUu
aCAgICAgICAgICAgICAgICAgfCAgOTIgKysrKysrCiB0YXJnZXQvaGV4YWdvbi9pbnNuLmggICAg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAg
ICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jICAg
ICAgICAgICB8ICAxMyArCiBody9oZXhhZ29uL2hleC1ib2FyZC5jICAgICAgICAgICAgICAgICAg
ICAgfCAgIDYgKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAgIHwg
IDIzICsrCiBody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYyAgICAgICAgICAgfCAxNTcg
KysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAg
MjYgKysKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgICAgICAgICB8ICAgMyAr
CiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFy
Z2V0L2hleGFnb24vaG14X2NvbmZpZy5jICAgICAgICAgICAgICAgIHwgIDE1ICsKIHRhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICAgICB8ICAxMiArCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgfCAgMzYgKysrCiB0YXJnZXQvaGV4YWdvbi90
YWdfcmV2X2luZm8uYy5pbmMgICAgICAgICAgfCAzNDkgKysrKysrKysrKysrKysrKysrKysrCiBo
dy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0
L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSAgICAgICAgIHwgICAzICstCiB0YXJnZXQvaGV4
YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkgICAgfCAgIDYgKwogdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2ltcG9y
dGVkL2FsbGV4dC5pZGVmICAgICAgICB8ICAgNiArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9h
bGxleHRlbmMuZGVmICAgICAgfCAgIDQgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvaG14L2Vu
Y29kZV9leHQuZGVmIHwgMTQ5ICsrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvaG14
L2V4dC5pZGVmICAgICAgIHwgMTc1ICsrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9tZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICAgfCAgMTggKy0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90
ZXN0X3N5c3Rlc3RzLnB5ICB8ICAgMyArCiAzMCBmaWxlcyBjaGFuZ2VkLCAxMTY0IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9oZXhh
Z29uL2hleGFnb25faG14X2NvbnRleHQuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhh
Z29uL2dlbl90Y2dfaG14LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9obXhf
Y29uZmlnLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUuaAog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5jCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvaG14L2VuY29kZV9leHQuZGVmCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvaG14L2V4dC5pZGVmCgotLSAKMi4z
NC4xCgo=

