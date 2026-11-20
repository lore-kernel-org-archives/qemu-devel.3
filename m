Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD5606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvcWL6wL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y0vt7JBs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhW-0007uv-9q; Thu, 19 Nov 2026 22:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhT-0007tp-Vz
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhS-0000iA-1J
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:11 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3Uj4L715512
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FreA5euFZxv9XpyzlVEw0N3ao4R7GaISpvF4KEZeK84=; b=YvcWL6wLC7nhxjfH
 SfE4MiwFzeyGvbmxfWE80BE5MhJ0rX9h4NidWXN2NLxRYcIcSQNxXgMNiNoN8dor
 XlnRaV+NbgfBa5U9jTWBKzquHLAIcWJE09c5OwHHmZPZDs9wlbzldw/HfLL06/bm
 0HFwEEW1MEIYtZ0HVRdPsaa0QX77b57VcMKrueskKT70uZgmThkWh9O9bJ4ZccmJ
 dpieLXmcb3dhOVXBLNsUpvbqvWszPA36WpKQ1eh/nit9OvSFGKNGuIQiwnTBfytq
 avslYVi0Zct+YA0c2hKXsIQYWuoWqGkvuFC//gAu8ntfuZ8DcEA500vPoZ69TRng
 tNgdHQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1rfds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-383f2d05c73so1363579eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146848; x=1795751648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FreA5euFZxv9XpyzlVEw0N3ao4R7GaISpvF4KEZeK84=;
 b=Y0vt7JBs9wNN0DtspjcuEzqqPAypYPSoOeGTtVI66mn/pWB2mEwFmaNoig+Om0Yu5L
 665GiztJXAVGv0BMKWocNrN9eoJthd4AslKQJeY6patJ5JaXBp6I4L+0VD6jvWOPArpi
 4KtMhlFUZmKiI1Jp0OvB/iDDX8dj+wHcmXtQp+IyVCF5pmaJGjRT7o70CHQu+6U/c0l9
 h6cbp1h49mTd6cyOfIs3wqm+lHoO+yVCyFlepXfFYYdAUQpAac0bvyyOcwRLZuwlRfEN
 kiIWzTsbVNXFoHizu7SedXpb1gqI6hKFPFevI1Hvavnu/CtX3QhUHGZXwG99dYFKV4LX
 LjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146848; x=1795751648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FreA5euFZxv9XpyzlVEw0N3ao4R7GaISpvF4KEZeK84=;
 b=QIlPS+psbxnwGM5YA4U3mlRtTNj1u6lWNVl5qvpgUP8wABp4EOACS2hw1peboh2lu7
 2QUQHlpuk/a0ws1USkNKQlcWXFu4eFcUlRfqS+g6nixe+gYZFQPNAYEw93Rgzr9TnNdB
 Vcfs0xXw3tKpsn53k4RtGff4DkYrzCaP33Qfy0tlpJ10W3ekbp5U5eU8NesOfJGYPM2P
 jigmyotuM0+zbS82pqye6/vmXYsBUHDgl/QjI1z/lKeeJ2ZhphNi87B5FT12NwN+C3Wj
 /BoudFF8JwFTU6sPkGBageA9aRQv1dXOZBwGlhYR79qZpNbGeuegbb4py6cSvAvitOrH
 DWoQ==
X-Gm-Message-State: APuU4Z+XDy2ELmuqqKm5sP7E/Wy8LrT9zUkyIxssK5TDoLDfP8GoQN7U
 guUImCDoYD8HPvDypeH0jBHwYahMX0d817wZccbgM1aoWmVtynlT01ItMB6ErQF1haSL8Ofbid4
 6Hz9+Qzgw+oZfT4K+3ZyQOkx3yxN3QBaj9WdAQVxsHSAWv/p8mpC4C9t9pub0YHfeZg==
X-Gm-Gg: AZFdTZedMvKNb2kuOO1e3TnZ/tHHFlo+cFZTTPc3fZan9IbAHb1Sl1a7Ws+OjmNsKJ5
 KP6LQbY35ND9SdqWKF3iM4HMxfcOLZ3Dg9Mb8FOiaw/Tz8R2QZK6IHApa7+7Xzj4iz4z308FtfC
 1m1gKg6Sd9GYN6hwA0gH9niZpMjSddn85SUNDyMWFS60ZS8kdYDavX4Ffpn+MUaBCzf0s85CNpx
 S2dDmzxgAZD1RQi2X60e0VugR7vhbyyCC+6odT2OBAw/5xOQZYJ2vxYVv02jbTUDzRDxcIP5RWW
 dGNAk373KKNOjiIP/2Td5rsfrL1JWzNe48JbME4COJg8/JFd9L0ak4cOexxFen5QNPDO/Zji8hD
 Wco4GfqgYheNRGJwh11ZWY+Zd9v6c0eb6DukHQqyLgEppSu0HhKuJUNw4u5AEQyonLa3qGcPeQp
 cfbLBnGBQ2PyLATYXDrc2A
X-Received: by 2002:a05:7300:c3aa:b0:385:c28b:a4d5 with SMTP id
 5a478bee46e88-385c28baffbmr721375eec.17.1795146848017; 
 Thu, 19 Nov 2026 19:54:08 -0800 (PST)
X-Received: by 2002:a05:7300:c3aa:b0:385:c28b:a4d5 with SMTP id
 5a478bee46e88-385c28baffbmr721355eec.17.1795146847481; 
 Thu, 19 Nov 2026 19:54:07 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:54:06 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 6/8] target/hexagon: Forward return address to HLX load/store
 helpers
Date: Thu, 19 Nov 2026 19:53:51 -0800
Message-Id: <20261120035353.3215703-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6affc460 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Yq6BhLmQ5-znFeYHT4AA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 3JtDLbfy2ShsxwyzLmfaCP4nh8mHLeVd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfXws+LV6qVxHrR
 HzP/rrqGvu4s2tMFccgferQAGpQfv0P9Kjnm8M6y+HEbjS2gQG/VexSHWMg5hacXmJ3f8P+kHis
 ehzkFNYrRFYDpL79CpfgNz6C9C1VeEBGmpYmOUicB22M7EkimWYrkjZuQRuB7jMyW2Dgr2iPujo
 uumycHZTs9AxoibZDijiTB2wrhfwuNm/ObALEckZwpW3oE2GtCLAuSTySS3wlzgsxMEXyu0mCYL
 o2WcoBAKzWniXF6ArC0DbA8emWbedqmBtuhAf/C9sU0l2ywuaCy6PRasIC7RzosIR5xvoZkrLco
 CS048VXzjB4S9w40zCk1cwAteIS6OqaixKK0fxCDJpT6O2dgGUXHAD/QNUf6B7cPZM/k2KDS0ib
 Cpi2dK7xkX/09INTLTD+5wkWEcOxqd8sGWDArE25TA8+5cjTc+TUe0FT8tvyxzm5lOF8a92+kCN
 HoWO+qfvdYRl7znqAcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfXykLxaSOdQ9y/
 MujE3R0hIlmcMPlf6feUcrJfeTOtwz8o0L9k4yv7DCHYm18SyGA2r+aqyouGIS8A/aHL80yeJS+
 X0mbYW+nqN3l93LLoogOFKClJqxw4qo=
X-Proofpoint-ORIG-GUID: 3JtDLbfy2ShsxwyzLmfaCP4nh8mHLeVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200015
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCkZpeGVzOiAyZGIyOWEzNjE1YTVh
ZDJhMyAoInRhcmdldC9oZXhhZ29uOiBhZGQgSExYIGhlbHBlciBzdXBwb3J0IikKU2lnbmVkLW9m
Zi1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KUmV2aWV3ZWQtYnk6IE1hcmNvIExp
ZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9obHhf
aGVscGVyLmggfCAxOSArKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3Mu
aCAgICAgfCAxMyArKysrKysrKystLS0tCiB0YXJnZXQvaGV4YWdvbi9obHhfaGVscGVyLmMgfCAz
MSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDUwIGlu
c2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9o
ZXhhZ29uL2hseF9oZWxwZXIuaAoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hseF9oZWxw
ZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hseF9oZWxwZXIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwMDAwMC4uYWIzNmNjMTA0OWMKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQv
aGV4YWdvbi9obHhfaGVscGVyLmgKQEAgLTAsMCArMSwxOSBAQAorLyoKKyAqIENvcHlyaWdodCAo
YykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgor
ICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLworCisjaWZu
ZGVmIEhFWEFHT05fSExYX0hFTFBFUl9ICisjZGVmaW5lIEhFWEFHT05fSExYX0hFTFBFUl9ICisK
KyNpbmNsdWRlICJjcHUuaCIKKwordm9pZCBobHhfbG9hZF92ZWNfcmEoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHZvaWQgKmRzdF92b2lkLAorICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X3Vsb25n
IGVhLCB1aW50MzJfdCBhYm92ZSwgdWludDMyX3QgYmVsb3csCisgICAgICAgICAgICAgICAgICAg
ICB1aW50cHRyX3QgcmEpOworCit2b2lkIGhseF9zdG9yZV92ZWNfcmEoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHRhcmdldF91bG9uZyBlYSwKKyAgICAgICAgICAgICAgICAgICAgICB2b2lkICpzcmNf
dm9pZCwgdWludDMyX3QgYWJvdmUsIHVpbnQzMl90IGJlbG93LAorICAgICAgICAgICAgICAgICAg
ICAgIHVpbnRwdHJfdCByYSk7CisKKyNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
bWFjcm9zLmggYi90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaAppbmRleCA5MTg3YjAyZTZjOC4uN2E5
M2EzNDQxYjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL21hY3Jvcy5oCkBAIC0yMiw2ICsyMiw3IEBACiAjaW5jbHVkZSAiaGV4X3JlZ3Mu
aCIKICNpbmNsdWRlICJyZWdfZmllbGRzLmgiCiAjaW5jbHVkZSAiYWNjZWwvdGNnL2dldHBjLmgi
CisjaW5jbHVkZSAiaGx4X2hlbHBlci5oIgogCiAjZGVmaW5lIEdFVF9GSUVMRChGSUVMRCwgUkVH
SU4pIFwKICAgICBmRVhUUkFDVFVfQklUUyhSRUdJTiwgcmVnX2ZpZWxkX2luZm9bRklFTERdLndp
ZHRoLCBcCkBAIC03MzIsOCArNzMzLDEwIEBAIHN0YXRpYyBpbmxpbmUgVENHdiBnZW5fcmVhZF9p
cmVnKFRDR3YgcmVzdWx0LCBUQ0d2IHZhbCwgaW50IHNoaWZ0KQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVBLCB0Y2dfY29uc3RhbnRfaTMyKEFCT1ZFKSwgXAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoQkVMT1cpKQogI2Vsc2UKLSNkZWZpbmUgZkxP
QURNTUwoRUEsIERTVCwgQUJPVkUsIEJFTE9XKSBcCi0gICAgZG8geyBIRUxQRVIoaGx4X2xvYWRf
dmVjKShlbnYsICYoRFNUKSwgKEVBKSwgKEFCT1ZFKSwgKEJFTE9XKSk7IH0gd2hpbGUgKDApCisj
ZGVmaW5lIGZMT0FETU1MKEVBLCBEU1QsIEFCT1ZFLCBCRUxPVykgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwKKyAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICBobHhfbG9hZF92ZWNfcmEo
ZW52LCAmKERTVCksIChFQSksIChBQk9WRSksIChCRUxPVyksIEdFVFBDKCkpOyBcCisgICAgfSB3
aGlsZSAoMCkKICNlbmRpZgogCiAvKiBUaGUgaGVscGVyIGxvZ3MgdGhlIHN0b3JlIGZvciBwYWNr
ZXQgY29tbWl0LiAqLwpAQCAtNzQyLDggKzc0NSwxMCBAQCBzdGF0aWMgaW5saW5lIFRDR3YgZ2Vu
X3JlYWRfaXJlZyhUQ0d2IHJlc3VsdCwgVENHdiB2YWwsIGludCBzaGlmdCkKICAgICBnZW5faGVs
cGVyX2hseF9zdG9yZV92ZWModGNnX2VudiwgRUEsIHRjZ19jb25zdGFudF9wdHIoKGludHB0cl90
KSYoU1JDKSksIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X2kz
MihBQk9WRSksIHRjZ19jb25zdGFudF9pMzIoQkVMT1cpKQogI2Vsc2UKLSNkZWZpbmUgZlNUT1JF
TU1MKEVBLCBTUkMsIEFCT1ZFLCBCRUxPVykgXAotICAgIGRvIHsgSEVMUEVSKGhseF9zdG9yZV92
ZWMpKGVudiwgKEVBKSwgJihTUkMpLCAoQUJPVkUpLCAoQkVMT1cpKTsgfSB3aGlsZSAoMCkKKyNk
ZWZpbmUgZlNUT1JFTU1MKEVBLCBTUkMsIEFCT1ZFLCBCRUxPVykgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwKKyAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgaGx4X3N0b3JlX3ZlY19y
YShlbnYsIChFQSksICYoU1JDKSwgKEFCT1ZFKSwgKEJFTE9XKSwgR0VUUEMoKSk7IFwKKyAgICB9
IHdoaWxlICgwKQogI2VuZGlmCiAKIC8qIEhlbHBlcnMgcmVjZWl2ZSAubmV3IHJlZ2lzdGVycyBp
biBmdXR1cmVfTFJlZ3MuICovCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9obHhfaGVscGVy
LmMgYi90YXJnZXQvaGV4YWdvbi9obHhfaGVscGVyLmMKaW5kZXggYzA2MzcwNmNmYWMuLmJjNjM4
ZjY0MDMwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9obHhfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vaGx4X2hlbHBlci5jCkBAIC03LDYgKzcsNyBAQAogI2luY2x1ZGUgImNwdS5o
IgogI2luY2x1ZGUgImFjY2VsL3RjZy9jcHUtbGRzdC5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVy
LXByb3RvLmgiCisjaW5jbHVkZSAiaGx4X2hlbHBlci5oIgogI2luY2x1ZGUgImhseC9obHguaCIK
ICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25faGx4LmgiCiAjaW5jbHVkZSAiYWNjZWwvdGNn
L3Byb2JlLmgiCkBAIC0xNSw0MCArMTYsNTIgQEAKICNkZWZpbmUgSExYX01FTV9BTElHTl9NQVNL
ICh+KEhMWF9WRUNfU0laRV9CWVRFUyAtIDEpKQogCiAvKiBBbGlnbiBkb3duIHRvIDJLQi4gQWJv
dmUgYW5kIGJlbG93IGFyZSB1bnVzZWQgaW4gVjg1LiAqLwotdm9pZCBIRUxQRVIoaGx4X2xvYWRf
dmVjKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdm9pZCAqZHN0X3ZvaWQsCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgIHRhcmdldF91bG9uZyBlYSwgdWludDMyX3QgYWJvdmUsIHVpbnQzMl90IGJl
bG93KQordm9pZCBobHhfbG9hZF92ZWNfcmEoQ1BVSGV4YWdvblN0YXRlICplbnYsIHZvaWQgKmRz
dF92b2lkLAorICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X3Vsb25nIGVhLCB1aW50MzJfdCBh
Ym92ZSwgdWludDMyX3QgYmVsb3csCisgICAgICAgICAgICAgICAgICAgICB1aW50cHRyX3QgcmEp
CiB7CiAgICAgSExYVmVjdG9yICpkc3QgPSAoSExYVmVjdG9yICopZHN0X3ZvaWQ7CiAgICAgdGFy
Z2V0X3Vsb25nIGFsaWduZWRfZWEgPSBlYSAmIEhMWF9NRU1fQUxJR05fTUFTSzsKLSAgICB1aW50
cHRyX3QgcmFkZHIgPSBHRVRQQygpOwogICAgIGludCBtbXVfaWR4ID0gY3B1X21tdV9pbmRleChl
bnZfY3B1KGVudiksIGZhbHNlKTsKIAogICAgIC8qIEEgMktCLWFsaWduZWQgYWNjZXNzIHN0YXlz
IHdpdGhpbiBvbmUgcGFnZS4gKi8KLSAgICB2b2lkICpob3N0ID0gcHJvYmVfcmVhZChlbnYsIGFs
aWduZWRfZWEsIEhMWF9WRUNfU0laRV9CWVRFUywgbW11X2lkeCwKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByYWRkcik7CisgICAgdm9pZCAqaG9zdCA9IHByb2JlX3JlYWQoZW52LCBhbGln
bmVkX2VhLCBITFhfVkVDX1NJWkVfQllURVMsIG1tdV9pZHgsIHJhKTsKIAogICAgIGlmIChob3N0
KSB7CiAgICAgICAgIG1lbWNweShkc3QsIGhvc3QsIEhMWF9WRUNfU0laRV9CWVRFUyk7CiAgICAg
fSBlbHNlIHsKICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBITFhfVkVDX1NJWkVfQllURVM7
IGkgKz0gOCkgewotICAgICAgICAgICAgdWludDY0X3QgdmFsID0gY3B1X2xkcV9sZV9kYXRhX3Jh
KGVudiwgYWxpZ25lZF9lYSArIGksIHJhZGRyKTsKKyAgICAgICAgICAgIHVpbnQ2NF90IHZhbCA9
IGNwdV9sZHFfbGVfZGF0YV9yYShlbnYsIGFsaWduZWRfZWEgKyBpLCByYSk7CiAgICAgICAgICAg
ICBtZW1jcHkoJmRzdC0+dWJbaV0sICZ2YWwsIDgpOwogICAgICAgICB9CiAgICAgfQogfQogCi12
b2lkIEhFTFBFUihobHhfc3RvcmVfdmVjKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vs
b25nIGVhLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqc3JjX3ZvaWQsIHVpbnQz
Ml90IGFib3ZlLCB1aW50MzJfdCBiZWxvdykKK3ZvaWQgaGx4X3N0b3JlX3ZlY19yYShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIGVhLAorICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKnNyY192b2lkLCB1aW50MzJfdCBhYm92ZSwgdWludDMyX3QgYmVsb3csCisgICAgICAgICAg
ICAgICAgICAgICAgdWludHB0cl90IHJhKQogewogICAgIHRhcmdldF91bG9uZyBhbGlnbmVkX2Vh
ID0gZWEgJiBITFhfTUVNX0FMSUdOX01BU0s7CiAgICAgaW50IG1tdV9pZHggPSBjcHVfbW11X2lu
ZGV4KGVudl9jcHUoZW52KSwgZmFsc2UpOwogCi0gICAgcHJvYmVfd3JpdGUoZW52LCBhbGlnbmVk
X2VhLCBITFhfVkVDX1NJWkVfQllURVMsIG1tdV9pZHgsIEdFVFBDKCkpOworICAgIHByb2JlX3dy
aXRlKGVudiwgYWxpZ25lZF9lYSwgSExYX1ZFQ19TSVpFX0JZVEVTLCBtbXVfaWR4LCByYSk7CiAg
ICAgbWVtY3B5KCZlbnYtPmhseF9zdG9yZV9kYXRhLCBzcmNfdm9pZCwgc2l6ZW9mKEhMWFZlY3Rv
cikpOwogICAgIGVudi0+aGx4X3N0b3JlX3ZhID0gYWxpZ25lZF9lYTsKICAgICBlbnYtPmhseF9z
dG9yZV9wZW5kaW5nID0gdHJ1ZTsKIH0KIAordm9pZCBIRUxQRVIoaGx4X2xvYWRfdmVjKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdm9pZCAqZHN0X3ZvaWQsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRhcmdldF91bG9uZyBlYSwgdWludDMyX3QgYWJvdmUsIHVpbnQzMl90IGJlbG93KQorewor
ICAgIGhseF9sb2FkX3ZlY19yYShlbnYsIGRzdF92b2lkLCBlYSwgYWJvdmUsIGJlbG93LCBHRVRQ
QygpKTsKK30KKwordm9pZCBIRUxQRVIoaGx4X3N0b3JlX3ZlYykoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHRhcmdldF91bG9uZyBlYSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKnNy
Y192b2lkLCB1aW50MzJfdCBhYm92ZSwgdWludDMyX3QgYmVsb3cpCit7CisgICAgaGx4X3N0b3Jl
X3ZlY19yYShlbnYsIGVhLCBzcmNfdm9pZCwgYWJvdmUsIGJlbG93LCBHRVRQQygpKTsKK30KKwog
dm9pZCBIRUxQRVIoaGx4X2NvbW1pdF9zdG9yZSkoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7CiAg
ICAgdGFyZ2V0X3Vsb25nIHZhID0gZW52LT5obHhfc3RvcmVfdmE7Ci0tIAoyLjM0LjEKCg==

