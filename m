Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6D8FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aJ-0007KQ-A0; Fri, 27 Feb 2026 15:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aB-00075Z-Qm
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a8-0006qO-Rj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:06 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0Gg7702145
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ipGTmwBUIHsvO9gHMp0sw4dbfVX9NwyZgocijKBvqU=; b=g0qJzIIVwh1jmrjw
 D2BPdE4BfJvTl3lg7Ri6BG62rNYRVdzEjdy2VU58by36pHUQmDwVH2hfnIrhmlHu
 Q5qgc5nYjDFwqA0y8Qu2GyQ57vHiQ+mt1Ivi/FEqOYjLjrQb4kDA+MlA1F6WhVIV
 TXn3nDiZQhqt1NociL9ZmDbpehs/Y/RgztuXGnkI85aX5avYjGUdONlO1tE5bwp9
 7lbu4eDbrvNKyzla869oMzxunwy8503wn+uP+KM0EBlJiHHixHMHgRCiHoy9i7+5
 1QpFcL38/pCGQQjYNm4ImGDi//X3V1Suvwk4E1R43xM7Cx4clFVIEOCWmGhrExgY
 PFRGUw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck8x8a318-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:53 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-679c51b2d6cso40568719eaf.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224612; x=1772829412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ipGTmwBUIHsvO9gHMp0sw4dbfVX9NwyZgocijKBvqU=;
 b=SzpPUWy5cUaShzsg8FGvtYITB7fNlNWUlRjqCEWaMAdEd5QcAnqDpFYtf2EcAUwxv+
 qQfFpymPE2h6X1owfcfyFSJbE80V39akpEW9cIekmSLKhY/2rhDcUENUDHJQAXQYmfLe
 NY1E80i97krSuPORqhExuhMmSYa6wezOpuatMPyqtN3thaYiOxmpFPk+rj6aHrYASQ9l
 Zp1DdWPBxg0KFXAOJdlagvoX/Vs0Xjqv//ZEs67jlnYaYkzSAKBVP9Rb7owhFYphNpki
 nLOPbEklPlO+WvW5vHVrQz9JOgqhVCsX/QCAJ20lRN6zNq0v9FHwFmgB25XWMqsWIe1v
 sMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224612; x=1772829412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ipGTmwBUIHsvO9gHMp0sw4dbfVX9NwyZgocijKBvqU=;
 b=tNWeSjr9waZ14JRv7yBuXvG7nBXNAIlEFH7UuOAxaKxpH416Dh0CajBwzrsMNYgruZ
 qzSo/c8UF6I8t1zCuKIlJbpGgIFXoZDeE5++yHI+H8EwkUGu7XHdjNLEVV/LjZamWaKb
 rvlziRoTVSyhz3o1rbUVkCLqMGjVwyPA7eJcu2J+wDyeA1rRucTZl0MD156a+HO8d/wO
 We8N5hdEuMqv+tpSgNUJgEKzsIqzJ1zzn8F0Hk+El+ZMzZs7bCFnCwFF+9b+dQnGp31w
 hmya33zwH+rY28sPzMwsJvgVv0QPrLm592+w1mg9kSX+nD9C8hyYUGLORc7WGdXZAbWH
 N5jg==
X-Gm-Message-State: AOJu0YwA+IFjQd6t2HZRyussHTW31Wq8zFrp5wiHw9iTRBLtczV96atJ
 Q8viCWQNoTWv4Lh2TvqtR+v369wn6C8cgVoSoZd0p5GTGj3bbhRqIpt9rGDno4hUmKpZosH3HUQ
 goNOWW5kLhbivAuNQTbDH5A0mn2CavZ6K+8ugKO2Oa+0E04qXZRh8dT7s7k73bt2rmA==
X-Gm-Gg: ATEYQzy4oNTiyocq4XpdhX4AqpfgM2Mf4mhT89QHnpyTOhyqFbkg/pRbaBYk7x27BGk
 oY0qsN/PPHhY+i7S//hvpTYAL94iW6R1c/TUmnPPkFSDJNL6mEXj/NF11f0deudYyVnrlBWJEkO
 KNJ2QyucZlulthu9stVbGD0fRIro5+NdNqddfoai8XzhOrVjaaQQiRQKYcx7PF3etRrJsFhQEVC
 m0jl7/VA/6GksRXB9hAfN5nlGqpDszLp9sTL9d31wyvK3YVtKX9j3OS6JdubAY2LbOspL5O8LDs
 xjfGvEjtgRWxHerSgla4RjHqs9ThcW6EVkLvA/DOGPNufYiDby2YujS8+6UtlnPq9v1vg98aO5M
 IgoBJWbNdgfglZW5juDM7SGny6DHDyrOp5A7dXgyoe7oGqFDxS4LEmQex7R9vMRy4QODiSQ==
X-Received: by 2002:a05:6870:7207:b0:3f5:694f:9362 with SMTP id
 586e51a60fabf-41627069b67mr2734444fac.29.1772224612582; 
 Fri, 27 Feb 2026 12:36:52 -0800 (PST)
X-Received: by 2002:a05:6870:7207:b0:3f5:694f:9362 with SMTP id
 586e51a60fabf-41627069b67mr2734433fac.29.1772224612176; 
 Fri, 27 Feb 2026 12:36:52 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:51 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 14/37] target/hexagon: Add TCG values for sreg, greg
Date: Fri, 27 Feb 2026 12:36:04 -0800
Message-Id: <20260227203627.932864-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WZwBqkhX c=1 sm=1 tr=0 ts=69a20065 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=md9odPwznpFxaQMInv8A:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX8C/RbpU4QfrR
 3YZpYQWhGU9fsANM5zSPcJ8DqUKsKzMKETwo42Bj0DBy3Nr2TcfFbBxI39PgJu+jYlCcb9MSkUm
 su6L//Lcgx/Y9w79uZOvwk8Ekn/Kt2o5bmPYZ+0WYxh/coZr55J15c7UNd6KbPc2S9BvIzJpEoH
 V0OYa1WBydSDFpUAPitiPDsD74FR9qZTcLslsG63Q4Wplw9kFkBoUR+ver2Kwol3E05uzk2Jhez
 7J7l/m8gEGGsD1BupomJDZ6vbuBv975iZnrg1QFiyDtQFZJe1u0uv8cKxqCbR18/ZrN4hJrEKcN
 nWyHg0v7aQzCZ2fnMA//7KCt+h/MpkU9kSsmwqd7pcH7/TyjcCLRDfXK/OXOfS2NQxNSfsLiU6U
 kazQJ2VR4X/4RYyh8ovJtw9r2Zc+7aNleRJRVXLB8t2IlyD8RfipPKgn3pskW30o86K3rTn4NTe
 9mU8m6JvV2KSPl+G+Tg==
X-Proofpoint-ORIG-GUID: EgJJ_6Y4N0TVc5X3ZHJ3CERIN5ByNVgv
X-Proofpoint-GUID: EgJJ_6Y4N0TVc5X3ZHJ3CERIN5ByNVgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
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
dHJhbnNsYXRlLmggfCAgNSArKysrKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAxNiAr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5oCmluZGV4IDI4MDRlMDhjZTU3Li5mODA4MzBmNWYxNiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAg
LTI4MSw2ICsyODEsMTEgQEAgZXh0ZXJuIFRDR3ZfaTY0IGhleF9sbHNjX3ZhbF9pNjQ7CiBleHRl
cm4gVENHdiBoZXhfdnN0b3JlX2FkZHJbVlNUT1JFU19NQVhdOwogZXh0ZXJuIFRDR3YgaGV4X3Zz
dG9yZV9zaXplW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3RvcmVfcGVuZGluZ1tW
U1RPUkVTX01BWF07CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK2V4dGVybiBUQ0d2IGhleF9n
cmVnW05VTV9HUkVHU107CitleHRlcm4gVENHdiBoZXhfdF9zcmVnW05VTV9TUkVHU107CisjZW5k
aWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCwg
aW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0NDA4MDYwOGI1Li5mM2RjNjJjZWMxZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3NpemVbVlNU
T1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwogCiAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3YgaGV4X2dyZWdbTlVNX0dSRUdTXTsKK1RDR3YgaGV4
X3Rfc3JlZ1tOVU1fU1JFR1NdOwogVENHdiBoZXhfY2F1c2VfY29kZTsKICNlbmRpZgogCkBAIC0x
MDk5LDYgKzExMDEsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpCiAKICAg
ICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBmb3IgKGkg
PSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAgIGhleF9ncmVnW2ldID0gdGNn
X2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4
YWdvblN0YXRlLCBncmVnW2ldKSwKKyAgICAgICAgICAgICAgICBoZXhhZ29uX2dyZWduYW1lc1tp
XSk7CisgICAgfQorICAgIGZvciAoaSA9IDA7IGkgPCBOVU1fU1JFR1M7IGkrKykgeworICAgICAg
ICBpZiAoaSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAgICAgICAgaGV4X3Rfc3JlZ1tp
XSA9IHRjZ19nbG9iYWxfbWVtX25ldyh0Y2dfZW52LAorICAgICAgICAgICAgICAgIG9mZnNldG9m
KENQVUhleGFnb25TdGF0ZSwgdF9zcmVnW2ldKSwKKyAgICAgICAgICAgICAgICBoZXhhZ29uX3Ny
ZWduYW1lc1tpXSk7CisgICAgICAgIH0KKyAgICB9CisjZW5kaWYKICAgICBmb3IgKGkgPSAwOyBp
IDwgVE9UQUxfUEVSX1RIUkVBRF9SRUdTOyBpKyspIHsKICAgICAgICAgaGV4X2dwcltpXSA9IHRj
Z19nbG9iYWxfbWVtX25ldyh0Y2dfZW52LAogICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdv
blN0YXRlLCBncHJbaV0pLAotLSAKMi4zNC4xCgo=

