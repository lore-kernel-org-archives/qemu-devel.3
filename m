Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0387C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9z-0005Ea-12; Thu, 24 Sep 2026 21:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9l-0005BU-Ir
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9i-00065l-8l
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1keH54132626
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hqfVicHy6v894bNbcDZGGKOJEk5tlT9bKuiAy6xrO9Q=; b=CMHOhJQrfJQXQyI1
 CEMfIQxsQoq9e5hzYZD22EL0sHkfo4LY75htKoWLoPJg+Ti9mc2ybU/1hbOxXVrs
 9p5PabJah2BGSqJMECwx25MxjJqdJ76DjT57CCTPi9ysCQQE3yy/cELnAxblFy95
 wezxMNkcAaooXdIZou57gC1Gxl69fO8Zd/LccWxUjYTjpEzO2I0ZF+uu+P+/iAre
 qImbU2W47UckSxeWeBcq2EFXgb/+9wAYOWvE2pmfmtsZ4uy9wzGavEUqs6k/uCFm
 Lf4qpDWI8rlnqZyEDsGdM75qlhXpHTi0OLCJmmJhmnvGtoCoLep5D/iNSFZofz3f
 nH7xZQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881sjvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-334f782d1abso1523821eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301306; x=1790906106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hqfVicHy6v894bNbcDZGGKOJEk5tlT9bKuiAy6xrO9Q=;
 b=VGVSjrOUox6kWQnGPfKGM7grBpfMbj5wETo/zluppBA3eUla+xciKDyX03X8N8tT1k
 KS94Qjwn/wrBrSe11+bhC4RWROxaWzt/Sg0egEzmdniWlnTbZNV/Vfq/YwqhUb2K5N+g
 5J7bKGJT6laLP9XIlRcdEcefcwb0YZsXockKGax5WwrhyeumzF/Bv/TdJA0s3AOgAbrH
 uabFdp4OoMzTuar9xw0/4IwMWxDDb8FCKG4fnXw3aHsXNaBsMfBBZk9iP7034tjby135
 +293JGOuNlWXbZ+2fhtd6vDSY4XeLB3qbV45H8rSkn11WVUzZ7OEzVR06Tf0Q3fOBC5z
 +dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301306; x=1790906106;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hqfVicHy6v894bNbcDZGGKOJEk5tlT9bKuiAy6xrO9Q=;
 b=HyZasuy7YtPxkEIe31SV5jOYAx/PUgjWAv3uJbA0ttAIZw3qtCfHYFj8bGsdni/vGD
 foPkkEhxWayu9r7vWAhGOp3a9pb9NrXXyo3JihStLUQV37t4zPrZ5TBathMxp3p81Hff
 ZFBHJvyL114Z7BVfxlsXydBAw3vPsqmcZaDcUET+juyT0yoZsuDitbXmDCdyNsgN+jd6
 /8DAPPGxNKc4fmAlqd9WT94F2Ig4QlbUxkL6cXyTUXAZ+84KsYy2Q6gyUtf+U1r7Q0FI
 fYbBvrPFRuHWbkj7QpyuBSXy7J5vftzjI7s6k4QFhYCH2lnmAwyHkBEItce4C1wn6Er/
 CxVg==
X-Gm-Message-State: AFuF++k2+zBwaNrNd3v2WBNmYGS519fJW79QUEiCmO7F8gjzAz3R1Pce
 ZOXAMukPptxPt1uwx/8zd5zt9GujxUVsm/H1A4W6iMkPcHGO6upkW4D2bIWFGEuSTkGx0S2kR14
 B3tAxuvm/9oNqdTXfCoqm0uyUk0hdZSYZXJOgDY42wyZ2YclGlaLHDVxg1StKboj+bg==
X-Gm-Gg: AYBFou1Bnp8R62zRhj6DtxxgkzuLNmPngNsG7gmrf+5eZ45u7bpCtn7JUJgeoEwjXzF
 p8cGKZJkiX+LTJcyZOWO4ium2oOOKi1s7TmcXZwioLKLO2PsKOxac792BhMk3/H7sa6XwE+BYA4
 IixYgeKQe9cEVZ812FwHKhVTPCY0azdvQLAgGaQMp2EdFMlb4C5byLCYYQ8/DAepzbVQ+ys8AbM
 2PY1wnvIpgvd10dYkTW1nBXOc4YX/PKRj1ijJ5iqZ+4jN2lLNJwG3QckEfmF+o808pEs/fXVKl8
 Ew+UOC20lLxViKQ9NNxZa4qr/gkTqzDK+hup4kfitqc6eo5E5Uq087VZmwhVNopvN+r4MaPaozP
 koFuE0y5ra5+Whb/Yrqaxj6kqZnkyxCINbab6QssJFg/RJDY=
X-Received: by 2002:a05:7300:238b:b0:33e:451e:c8b2 with SMTP id
 5a478bee46e88-34006f826a1mr4496577eec.37.1790301306182; 
 Thu, 24 Sep 2026 18:55:06 -0700 (PDT)
X-Received: by 2002:a05:7300:238b:b0:33e:451e:c8b2 with SMTP id
 5a478bee46e88-34006f826a1mr4496551eec.37.1790301305623; 
 Thu, 24 Sep 2026 18:55:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 21/40] tests/tcg/hexagon: add sfrecipa edge case tests
Date: Thu, 24 Sep 2026 18:54:10 -0700
Message-Id: <20260925015429.2579174-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab5d47b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iLNeMspusdFBM-S5qpkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX6eZlQzflGMrU
 WUYGQKy7SIFJM4gn97FjgKL2VQGK7uTmHdR0rTSC8wqCKPTmlwFYVIaLFbfvz0B8Pm/FEes5pqk
 4vK/aCCsIR7mnlC2pd1bpHthhPwK7yKgiAtIsKnGGPL+xoot7SEUGxjwBMHpEF6LJUqQvlRxrsn
 eXPWLGB4xPIbhHVEfSddILZ30N4Bs8qikbPjJG1YkAJWyDqmXPdRQZSIBmciezQLQobdIDLD9xe
 hRQn80bDNgMdoBe80/yf7ml1oJl8vgzK70yzaUQ9yrSl+qSYuJxrNoKNzsbktWMdZX0ljpjBidk
 tqDiR+e4mXioTk4FfBAcj4gaaoYt+JWwY0Qxj0ckZ+aD/oGwxX1SE/foyUv3ybjDtA2hr5f8xln
 4XmZe9l+KAhf5/UY5S/sdsmPEucmUcl9eqoawp9SXf8rnT8aPkUcobp0V+4BooT0iy1HdlfbsNt
 94XlpWXZTEJaJvbfhhw==
X-Proofpoint-ORIG-GUID: K01C6G46rrIcrGJOWIa7jrS6_T7jFHzv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXxRK3mdGgTC1X
 /BAVCniAALmJgks1/gY917lck+6QjW+8V6rLLytec8flLLY1x0Id3TMOHHZmJltYWu9WRtzLanv
 NqCD6DW0JYvhEYik9XT4KH63uLmfFJ8=
X-Proofpoint-GUID: K01C6G46rrIcrGJOWIa7jrS6_T7jFHzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

QWRkIGVkZ2UgY2FzZSB0ZXN0cyBmb3IgdGhlIHNmcmVjaXBhIGluc3RydWN0aW9uCgpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIHwgODEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMgYi90ZXN0cy90Y2cvaGV4YWdv
bi9mcHN0dWZmLmMKaW5kZXggNzU2MWYzMWNkYzMuLmY4MjI2MmFiNGFjIDEwMDY0NAotLS0gYS90
ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVm
Zi5jCkBAIC0zNDUsNiArMzQ1LDg2IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3NmcmVjaXBhKHZvaWQp
CiAgICAgY2hlY2szMihwcmVkLCAweDgwKTsKIH0KIAorLyoKKyAqIEhlbHBlciB0byBydW4gc2Zy
ZWNpcGEgYW5kIGNhcHR1cmUgcmVzdWx0ICsgVVNSLgorICovCitzdGF0aWMgdm9pZCBkb19zZnJl
Y2lwYSh1aW50MzJfdCBScywgdWludDMyX3QgUnQsCisgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCAqUmQsIHVpbnQzMl90ICp1c3Jfb3V0KQoreworICAgIHVpbnQzMl90IHJkLCB1c3I7
CisKKyAgICBhc20gdm9sYXRpbGUoQ0xFQVJfRlBTVEFUVVMKKyAgICAgICAgIiVbcmRdLHAwID0g
c2ZyZWNpcGEoJVtSc10sICVbUnRdKVxuXHQiCisgICAgICAgICIlW3Vzcl0gPSB1c3Jcblx0Igor
ICAgICAgICA6IFtyZF0gIj1yIihyZCksIFt1c3JdICI9ciIodXNyKQorICAgICAgICA6IFtSc10g
InIiKFJzKSwgW1J0XSAiciIoUnQpCisgICAgICAgIDogInAwIiwgInIyIiwgInVzciIpOworICAg
ICpSZCA9IHJkOworICAgICp1c3Jfb3V0ID0gdXNyOworfQorCisvKgorICogQWRkaXRpb25hbCBz
ZnJlY2lwYSBlZGdlIGNhc2VzOgorICogICAtIGluZi9pbmYsIDAvMCAtPiBOYU4gKyBpbnZhbGlk
CisgKiAgIC0gbm9ybWFsL2luZiwgMC9ub3JtYWwsIGluZi9ub3JtYWwKKyAqICAgLSBkZW5vbWlu
YXRvciB3aXRoIGV4dHJlbWUgYmlhc2VkIGV4cG9uZW50cworICovCitzdGF0aWMgdm9pZCBjaGVj
a19zZnJlY2lwYV9lZGdlcyh2b2lkKQoreworICAgIHVpbnQzMl90IHJkLCB1c3I7CisKKyAgICAv
KiBpbmYgLyBpbmYgLT4gaW52YWxpZCAqLworICAgIGRvX3NmcmVjaXBhKFNGX0lORiwgU0ZfSU5G
LCAmcmQsICZ1c3IpOworICAgIGNoZWNrX2Zwc3RhdHVzKHVzciwgVVNSX0ZQSU5WRik7CisKKyAg
ICAvKiAtaW5mIC8gK2luZiAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoMHhmZjgwMDAw
MCwgU0ZfSU5GLCAmcmQsICZ1c3IpOworICAgIGNoZWNrX2Zwc3RhdHVzKHVzciwgVVNSX0ZQSU5W
Rik7CisKKyAgICAvKiAwIC8gMCAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoU0ZfemVy
bywgU0ZfemVybywgJnJkLCAmdXNyKTsKKyAgICBjaGVja19mcHN0YXR1cyh1c3IsIFVTUl9GUElO
VkYpOworCisgICAgLyogLTAgLyArMCAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoU0Zf
emVyb19uZWcsIFNGX3plcm8sICZyZCwgJnVzcik7CisgICAgY2hlY2tfZnBzdGF0dXModXNyLCBV
U1JfRlBJTlZGKTsKKworICAgIC8qIG5vcm1hbCAvIGluZiAtPiBmaXh1cCAoUmQgPSAxLjApICov
CisgICAgZG9fc2ZyZWNpcGEoU0Zfb25lLCBTRl9JTkYsICZyZCwgJnVzcik7CisgICAgY2hlY2sz
MihyZCwgU0Zfb25lKTsKKworICAgIGRvX3NmcmVjaXBhKFNGX3R3bywgU0ZfSU5GLCAmcmQsICZ1
c3IpOworICAgIGNoZWNrMzIocmQsIFNGX29uZSk7CisKKyAgICAvKiAwIC8gbm9ybWFsIC0+IGZp
eHVwIChSZCA9IDEuMCkgKi8KKyAgICBkb19zZnJlY2lwYShTRl96ZXJvLCBTRl9vbmUsICZyZCwg
JnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKworICAgIGRvX3NmcmVjaXBhKFNGX3pl
cm9fbmVnLCBTRl90d28sICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKwor
ICAgIC8qIGluZiAvIG5vcm1hbCAtPiBmaXh1cCAoUmQgPSAxLjApICovCisgICAgZG9fc2ZyZWNp
cGEoU0ZfSU5GLCBTRl9vbmUsICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsK
KworICAgIGRvX3NmcmVjaXBhKDB4ZmY4MDAwMDAsIFNGX3R3bywgJnJkLCAmdXNyKTsKKyAgICBj
aGVjazMyKHJkLCBTRl9vbmUpOworCisgICAgLyoKKyAgICAgKiBEZW5vbWluYXRvciB3aXRoIGJp
YXNlZCBleHBvbmVudCA8PSAxLgorICAgICAqIFJzOiBiaWFzZWQgZXhwIDI2LCBSdDogYmlhc2Vk
IGV4cCAxLgorICAgICAqLworICAgIGRvX3NmcmVjaXBhKDI2VSA8PCAyMywgMVUgPDwgMjMsICZy
ZCwgJnVzcik7CisgICAgY2hlY2szMl9uZShyZCwgMCk7CisKKyAgICAvKgorICAgICAqIERlbm9t
aW5hdG9yIHdpdGggYmlhc2VkIGV4cG9uZW50ID4gMjUyLgorICAgICAqIEJvdGg6IGJpYXNlZCBl
eHAgMjUzLgorICAgICAqLworICAgIGRvX3NmcmVjaXBhKDI1M1UgPDwgMjMsIDI1M1UgPDwgMjMs
ICZyZCwgJnVzcik7CisgICAgY2hlY2szMl9uZShyZCwgMCk7Cit9CisKIHN0YXRpYyB2b2lkIGNo
ZWNrX2Nhbm9uaWNhbF9OYU4odm9pZCkKIHsKICAgICB1aW50MzJfdCBzZl9yZXN1bHQ7CkBAIC04
ODcsNiArOTY3LDcgQEAgaW50IG1haW4oKQogICAgIGNoZWNrX3NmbWlubWF4KCk7CiAgICAgY2hl
Y2tfZGZtaW5tYXgoKTsKICAgICBjaGVja19zZnJlY2lwYSgpOworICAgIGNoZWNrX3NmcmVjaXBh
X2VkZ2VzKCk7CiAgICAgY2hlY2tfY2Fub25pY2FsX05hTigpOwogICAgIGNoZWNrX2ludnNxcnRh
KCk7CiAgICAgY2hlY2tfc2ZmaXh1cG4oKTsKLS0gCjIuMzQuMQoK

