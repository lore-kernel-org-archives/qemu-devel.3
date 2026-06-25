Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66174CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktT-0006pc-Px; Thu, 25 Jun 2026 10:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktR-0006jW-Lg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktP-0008Tq-44
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvpA1723469
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=; b=Jq
 qRtymc1MnspgLZmlJBibc8/YxCEtyZu8ythjk7KcgWV81o9PKfe/0Bn0KH1DpzGg
 BETVHe6IZbLESrzk8PpYf4ateYo1QM2zVvrfXbgFzrfvqfyem1BDBLQqL03Jk5RL
 TOlO5XImf18X8Rq6pdwmrGaAiTuXjqvCd+yuHBjHX+NOZAd9BP+1vUdj6wyBuxeK
 iXq/lAfDKAtyPq9ZwcpBh3I3xp5vTLhRsYFwTzT/g9e5eoSXGvrNOk0BXJKwmioq
 zidzv/Rw9f+GWplOSVKV1OjC/+7eKWSShfRBRzqwTSisrHyr4DMd0kiXR+o1Mjfx
 Z5zaSou6wLAvpPeGXlOA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvnr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2672142eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397030; x=1783001830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=JnPdDEJKkmuIpxiGmAdvGNTUXIHowt+9KaNNpDVygvFBBetk9FvPjPNeaviQ4UBizk
 pLERj0dm3MZZxSuKNtapda/EL5Inc9tPEmRB2W4LFvriaH3IDbWmXq1RBX6zbg7d/j6N
 3cU7XOGIlbck2q9E0yAFNWynfs4IV3Et6ef/qzyFMTFA8QrqFo8GXuMM51rAIWMQUmG+
 w6oftaAS2qL99j3HJaCbaxl/eMKsbGplw5/g+UyBTVr2WZ8iuKx2fMzoNmol43NsYc6Z
 9tEFdpJzy7f1qBfaph3Xdg7bUxmIHGaZxqtk5f+N9LNuLvdv5BS1lYdeK1njZ2FU9ot4
 s9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397030; x=1783001830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=XtuHGu5W9DxmdUa7XmFaLZaCIZi2tnmiZY1M9BsgWh8IenZuqa1Wd+NyM6y/sn78rE
 hb6Niq/QvzyJ7PuX1s2sT8reJ9y/WOH7AVq5PQKuorIgmHOTaatMe/zp9ypt7U4jdgQT
 WTtA7kPRo6qwNz/1p67QgfpRFdFR3UXfUMByZN/LZ5GxSPeUzhpCPrQIVnqrwpq4SYyC
 1m3jdoBNTV8GlXV25GYAgbOydZwGU0y/kIggs+d+IHiGjyn3SiEoV6Zd9xqSO4zbeMgp
 l/cqkxZzopR4nI8yXPNLlj/lDyWLs0UfmC3wkfq+NlT4ueJKAj633WYVZzwI57OhM6hb
 1ESg==
X-Gm-Message-State: AOJu0YxVd4zJjB+iix6D0P6jBHJBDo1OD9vN2KzT/D0mqyjgc2Z40v9h
 gxAOXPhlFrxpEi6DGOe/05apKHwBRKn1dlbf8Fy5wbtbS9crunwKonILkxqeXRIupIf0G+HKqV9
 5fE5v7Sv1PEVVICeNLHE8DwNF9iy2ku3MdqQ46S+QwbkMiacW3hfExcfOsEK41eJfJQ==
X-Gm-Gg: AfdE7cl448BsPSdk2msL8qE0VHwsPoJHxL1PQRh46069GZEiAKeU4mpPi4RF5ngS/lL
 z99hboOxn4XSYInTbdcQzTksJmIls+VwfQdimtW04d4ukxYiClXnNAnvWa+fkI10CaN9mvBZlDu
 8J3CT+6Ykq1/4ih8/hWXDSHWrVAArsOQpKYHC1umGgBkVdC77sLVX3boePgo1/eMUZbpmO+mI4N
 92baSmVGTnvNHa5QwlF3DA3s5EDnXtGdLkI8lJce34es8+XhcPY8v8yTjc+q7Zx9HwZplr8wEgK
 Tb3GYVpLlvhFvZjS9yMUtKs6i3b1ArBV0DjYCiC5reMv8Vt1493wBIuBNrD7v0fT4NeN/5aKI9c
 CpoFjK88OnjM71v+Jgp6lXFpZDEdzTf9eCaqGX4Zdnrl0/X9EBSrQplM9PC0=
X-Received: by 2002:a05:7301:60c:b0:30b:e14e:b5e0 with SMTP id
 5a478bee46e88-30c84d9ba0dmr3108226eec.34.1782397029651; 
 Thu, 25 Jun 2026 07:17:09 -0700 (PDT)
X-Received: by 2002:a05:7301:60c:b0:30b:e14e:b5e0 with SMTP id
 5a478bee46e88-30c84d9ba0dmr3108149eec.34.1782397028898; 
 Thu, 25 Jun 2026 07:17:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 15/76] target/hexagon: Add TCG values for sreg, greg
Date: Thu, 25 Jun 2026 07:15:32 -0700
Message-Id: <20260625141633.449487-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: QifqRYEda-jXrY6ejatNoZXDYUaMwdrN
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d3866 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8kp5zrIFwsha1M26KQwA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+1/rGtyfjpnn
 H29HgSiGcSeWFoG+CnVQc4urnmP8K1MaLutiqei0ksnZArRwHYFAaHxhH2rE6nMmnNCDhxk+Mqt
 lLzqvhpuylFUyXoaY49QsfeUZrTBO+Q=
X-Proofpoint-ORIG-GUID: QifqRYEda-jXrY6ejatNoZXDYUaMwdrN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX1gEx4lhom+pP
 WhASMh24h5KL0bIFZAjMnIYEmRh7VI38pXIB9mFtbf4HWApPhhzSXRsqphurW0n4h7EnZGk35Uf
 ihgRmfMOwsf81mBQS3swbqWgD119yGuhlOHSYz/xSl9GQTz2jJu/tpy7rVXHPXyoVjd8RPXkxJ2
 VP/andNFp0QXR9tUI/mMFF4+YdK8EMG2NnzmRzeW3dAlTZRx98Bw9p9AHdQM1zy5ByWA8FJqP/d
 GByrSQwG0o+4nAhFlUQjOzn/uWDee3/DjaXRnZPkfXBBRiVu7yNFU65o+klUpoma5TRFOcvwzGV
 6rAHSnQNTBlFA3QBHWZ5cXLvBFIYn/F6EhviQfdYglwThnGJk3UCEHwM7CEUKoSe2oCfGwQSQ+x
 KKnQCabBsFQIOPpSz4425bHWDPB3BEL2rO1ZZg4UkqOOYaFC6Z/dIs6p9TzrhzwixSpEayl8n4o
 qR+Ni39L8kNRDDrK5Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
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

