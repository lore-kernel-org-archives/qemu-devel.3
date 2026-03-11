Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0FBFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaF-0001vB-UV; Tue, 10 Mar 2026 23:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZy-0001dK-LB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZv-0005E7-5w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3VDHM614058
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bU+8/MDl5aUXlgKdePuWGTSIIfR2CYnKAKReOD9QS0k=; b=WNoPdEIadI5yc1q3
 9yoP6mqErCBSl5YXXwWZWInlGlmhCUqABcLyfLi6wUWhplS2mmT9HrzCivTr+fHo
 mU6GGnW48uZWoG2wj8RuKOrYfQmzn20Jxfbank9ccOBUSZkuZzHMW5wmE6z7NtZR
 Mca0yn/qCLodPMVfXcahb8UmtzPxpPI2jnq22I3KHJd6qj0IvJEpJ09S0ht9E6f8
 IkDK7AXZN023wmFELIB58yK65SPjH2PiR2CjXYhkeDeEV/0shLrN7xh3KbiPwI1m
 RGyasz9AWm1lxIr63x/npJV9RzQARKZIFiGmvPGDNmQiRKFLhGRoeHYvKDxt6+tw
 SQkZIg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf01nv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:45 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d7510702e6so19075968a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200985; x=1773805785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bU+8/MDl5aUXlgKdePuWGTSIIfR2CYnKAKReOD9QS0k=;
 b=jGUGdyUbMTFJjWpaw9rPbYAZxBTpVdmJzdFVIW+u2rvnPRQYWRuJjRKlX2QzDtdQG7
 v4i9eT0v3fAEt+6sl1Gb/J3PmFWNRt7GxFRWlaQmNASj3jr9Xg8tRfQg5Q18lTz7RkHS
 0op7A03or4wuIhpshTUOxtlgbnioqlT4699wk3v/aGnx2X/qsF8epOjznKd+HAbEaczF
 QzkhqAKfs57wBg7FY0Dg5FYX1Qg9C2zl5YNxiDuEV+RK3IUtEA2KLbozm4EHYWKgFbyk
 kIm3St+0hR8Wm9aWuoIr9wu1ycU92uqAV1qEj8eS8pWq1n1AZGbPHYnbBq7K5VbTd+rK
 KJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200985; x=1773805785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bU+8/MDl5aUXlgKdePuWGTSIIfR2CYnKAKReOD9QS0k=;
 b=ZVhcUFKheY0fO65g0sNUHs4BxeCBfig5YY6NvE7IFIs1diBnarWYpp9DrvOpRR9lbf
 lMmdMwdmp+yezhQUR9+l8eXcpxqJd+aqwR15z9nFfTyrrDnhvHoF9BMTy+iltGNpjLLC
 GCdL/RqWF8E7j65j/cmZeGAqrXIFpAtFl2Th/hYm5kaFyMmKodYp2uIoNnVamLb9ZfY4
 hVjddqAps0lgeTIGEGxx7WeMJ2ECPCmHBE0Lsr98ft9YHQKYfg+dTrP4IpHQbI7fudB9
 8QIld0/JlRQVJWku35fae7NWOepEXm9PJ9x93SFMSLXIFuf03OntFpiKricuxbXPw1Xs
 nzMQ==
X-Gm-Message-State: AOJu0YymJiEPfkT++ftCBVsiV5nF4a+yidiLIP5mj1jlLz1Lcc00s5ta
 TqvO+2nT7ywQjiC1dDjVCCM93jKk+hOG9UiHK1a/A2pGA2Ueq7FtVZNHI1V7xaTVawirBoZzlbR
 pEeZNWImLamfVYJpq+F/42VbqEYVYIVU4lXk1e6HNMPTnNW4j7Q6dnUV0d6Xr51mFJg==
X-Gm-Gg: ATEYQzzB3MjlBNx9yZHA8Msg7fne768ZyHSLgQf2v/MUPdRlBao+MZmPb0TDQXcpX+i
 9jL8k4iXZeefT0DaA2kR0gipP5jDWdrD6EnVyQxRIkOj7I/SNdExKTZCZXCyz6+TFJ9k0yVqtRO
 rm214HjCWjh7aiJSP121l8NdzrisSZXRtsuWh5YZaO7Up9h/Iyy0ei3cg8hyPHNe2wUp7iPDDH3
 sSgZatWowZJ2fLU9Zp2qLkMPD6FnoVJR/hwc2B319o0DmMWnine2I3rB/9miIQhBeUSYCONeOsG
 AGwQ6WmX+4kwRALeBQ000Pkv5nCMy8JhRlReDZRmoEiViakFSYt/1cMxEngZ63pOLU40BhR1c1Q
 fdm+NQ/Fk9cb/HYNlsGOdLIN4/zfP9YcmDeCYl0+fpBh3HM08wTZrGWXEIy2/vqQVKJfzBg==
X-Received: by 2002:a05:6830:44ac:b0:7d5:a0f1:5c35 with SMTP id
 46e09a7af769-7d76a94f528mr854369a34.35.1773200985021; 
 Tue, 10 Mar 2026 20:49:45 -0700 (PDT)
X-Received: by 2002:a05:6830:44ac:b0:7d5:a0f1:5c35 with SMTP id
 46e09a7af769-7d76a94f528mr854356a34.35.1773200984661; 
 Tue, 10 Mar 2026 20:49:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 13/35] target/hexagon: Add TCG values for sreg, greg
Date: Tue, 10 Mar 2026 20:49:01 -0700
Message-Id: <20260311034923.1044737-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: qWgsvpEmLdusGJ-P-5LKf9p9uBkOUARQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX46OhTODTyLsU
 8HqUwwSeiVx3waWaRpkXrrf62skwFB86EM3mEIHQ0D+JI+ExBgdOfg3vPpAIgeqQyjCckj0+0YU
 foxzBMDd2beuwTxbPpCvwMF35SH86Ah+igdy8IjsGr74niLJbZ+/2u2kFiJN2YogKuWowHHPDH1
 gqx5YUti9Nidt9X77bmwaQxCBNl5EbzklvESdc1k0AyMGTuuG79KNeFQ+2+jY485BXe1HlCX8xC
 eQk9FaLH4+f7xBby9e1JO0GaMjaQ8lAx28eYfTgoJz2y6QdGvCgq+Oer3PahUbYdrCZC8mBMClT
 KzRYWs/GEMcSvScKjW/IhQONvfQ5H/IX4KaioBZbbUFG99rUnbkpkaodLQkzGUuqpVSPOWnvTWw
 3RXHbdi7EGpttBJT/YJ/jNojfaQuIStqlGZBPZFSCsarOChE9aseT2x8Zi2s62Mwkl1vlD5LEAm
 mFqA2aRTEPCyJAPA6wQ==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b0e659 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=md9odPwznpFxaQMInv8A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qWgsvpEmLdusGJ-P-5LKf9p9uBkOUARQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCAyODA0ZTA4Y2U1Ny4uNDBkMzY1ZjQyNTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODEsNiArMjgxLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDU3MWJhOWNhZTQxLi5jZDZhZmZh
MmY0OSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDk5LDYgKzExMDEsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

