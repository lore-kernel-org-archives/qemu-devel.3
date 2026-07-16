Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8D0C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkRZ1-0008Al-0Y; Thu, 16 Jul 2026 15:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkRYz-0008AL-0A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:16:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkRYw-0002xX-UM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:16:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGT2p03002766
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=; b=Y3EkyjnWSDiUE0o5
 ZKdxzLBg7U48oH0PkU4ZeRsigb+bIBasiGgCeX0Lr3Ot0DnAuWRou66B2Cuyx4NV
 uNThs1wWW5jOrt2Np7BfNILF8OEZ0c7refVIAFsNDkxW9hX17MI9obOFQCfgO7j0
 lSVf3EmaiqqfUwqrF4kHGHKeplC/QjwIayw9Gvowsc7k3ZshJ2CucwOXXYZxClJs
 8oNCBuOglDhmO340SwhyQ/N4LHCkhG4G0Z/sgXF4qEq3MBcbCtJh+FquCFrRhaf0
 /jDp7z7Dvj/ISa9xORxty/2gRpefeM/MhhIn8K+TyTuPfoprF9Z7U9Ik2PYpxqJq
 yltaGQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9h2g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:16:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso269645a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784229360; x=1784834160; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=;
 b=BOeAHs/2TS0D6g7hxbDnoIyjQYq+lzi5aUqs0ifPWKxTKkQKg8yKg5NdtYWo4BvvHy
 xIo0KL4+EW0lxzFUqDruFhwFbaKfvvcCGPy9InMO5irEEom2WYpllIJ9xcK0t/nun0zt
 Ia+xb1ETXnMlLxiRUotZtvVtDJ7GH6OWYpH7Ry87+oP2I9gslfn1Ook/03aj6EpmLSdu
 a97nvX9aMnWZb1iXc1/rV4eCT0BUJv/Nm08GTuBMFFGZ0Jj0+l7FqrDBAGWTohN6iqVG
 QybKx9XtdRWOhuwl+Ni/ZeDisG2u8YIQzbj88K2MX284u00n9StqP1tA4VkJk/oKx03p
 BoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784229360; x=1784834160;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=;
 b=PxwFz44/dY/H1apwyKkQCNDXtcXbdek3CDT7fxMHmC9MytxXStvmSTRrc39gX7MboN
 QUhdIGXGzHuiyAmm0Ft74nz679MFhNVmBn/hwfKAzn85z+dQAbQ7q76yV/uNiglJ+CZQ
 QPW4TVNL1MoAQHnQhswNCbMX6BLjxbToH8vG2vufICvBViDtgKzgSiL6mPPTcG2lkeH6
 aVh6rPo8VuJJwlmkcazCogfXzoH+LpxU4IQhKGFZ4bfMtNBbyKUvGZX028MOFqwS2Xxq
 Zb13r40+v2JdxKAcRpIIVZyZwstaT84TbYW6y8DkJK1WlWTt6hyTn3z6UN6i0zZxdUhL
 +j2g==
X-Gm-Message-State: AOJu0YydTk+rZOhAYfyh1W311b6Ih1RwsBPZoO8Lf2eCemVhrffo6FHa
 YlJrLNL1Takj4RXOyGHTyKT43dycQb6QY5GrJMmUtAeQ7m0hw1ojP8jkrmB4qK95FkWOf2RTL1z
 MnVtFtRFwnssMbt8J9zn4toyQ0xAPF70EEQ7KDdnbUm72WN0qfNIOuM3F6O08zpGLIQ==
X-Gm-Gg: AfdE7cnxIiAGRV3u450sAiUI63ahY6SjIr/1YmLpfPCm6srEdWp8TPRtQrQIupKSdnN
 8mirW/Uc+bEj1LDUL717STjzn1f3Jsdd1tf3ksbohwXl3uwQJW2zRQJtAHEpKr8tqjmlagqF53x
 K2TZXVpfXFpXWflo5XdPag40STeCVgPhDKgthndr3BJIgBHbMpmTsHzVIlosJBfla550RImDyPq
 Of35CZSIii7B/fcC0LN5wIKPtYlz0AjU7cG9yJE2rYzKMMxX0hpgdQwCR7T0S7DmUw2fxZ93EWG
 bnUJsZUc+PSCuW1ssqxd5h2NiSx43Zixmar5fYMCAtRASfxqEyID/zEnxg2wHZOt0alZPDFt32k
 B+tmJOlzOhuwJjr0alAFbwVk5j38nDSbwIs0Dud5wB8AHW7pp
X-Received: by 2002:a05:6a21:a393:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c38d90d347mr4729470637.14.1784229359571; 
 Thu, 16 Jul 2026 12:15:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:a393:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c38d90d347mr4729447637.14.1784229359099; 
 Thu, 16 Jul 2026 12:15:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4344b8bsm13143885c88.13.2026.07.16.12.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:15:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/3] target/hexagon: initialize deferred sreg-write temps
 to current value
Date: Thu, 16 Jul 2026 12:15:53 -0700
Message-Id: <20260716191555.3397687-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716191555.3397687-1-brian.cain@oss.qualcomm.com>
References: <20260716191555.3397687-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a592df0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=IlOZXNdbeIrMSDKviAkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX/PmmGGwHBHDd
 IBt4Z5JugCuHZEJqjKafzmWpry18NQ5OJh69zzr5/xyw/UKKaEM+VmSd1MuFiHyuROlHS7ZdBmj
 Nr5XLKb6hAEMGS1Fy0A81RPM7gQRuVdoNyRQ3vU3RPBReNEOFpurJZAPusTecNCfRyEW/h5K1u3
 zpRt31YFhsrxy6YyRXwZdH706mJif3y367Q5sWL+ggx8yRU3IYNnYcBpJDhqKelXIW/bH198vtP
 surhHMWCAajkQ4LLb7hudifPX+EA80YSZiTFxll4GqFLjpvz1Rs+5e2xkLGmhhFWwrCurn0UzEE
 6+MS++uwifOrWhvEC6/+nRyRGhSDfbdUzLHorsYigBuSreEkGDftphEPGEBWuhKB4r7WMNb4Ryu
 BS7HjommkAILVLQDR+VrCaH3rl3rnXfvlc0c7/DYUa/XeujBecw0367jMmAAbwWbbk08gHGjj2M
 2P75kW89BI/a5RYyQPQ==
X-Proofpoint-GUID: BcX6O23lCedpOww_2UNwFnr_BNOCl2bF
X-Proofpoint-ORIG-GUID: BcX6O23lCedpOww_2UNwFnr_BNOCl2bF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX/A+4bCKzZ4v8
 6UrRD2kjpks/ziYS02ZjQTfOTe7cTQLbb1GylDJe3CRQ9pN2tM8dZ65nD0VkJoA65DghAalkAWJ
 IVRl+TD7xEl+OvC1p4VpwLU02kI49H0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160197
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

VW5jb25kaXRpb25hbGx5IGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSB0ZW1wIHRvIHRoZSBz
cmVnJ3MgY3VycmVudAp2YWx1ZSBmb3IgZXZlcnkgbG9nZ2VkIHNyZWcgd3JpdGUsIHJhdGhlciB0
aGFuIG9ubHkgYWxsb2NhdGluZwp3aGVuIG5lZWRfY29tbWl0IGlzIHNldCBvciB0aGUgcmVnaXN0
ZXIgaXMgU1NSLgoKV2l0aG91dCB0aGlzLCByZWFkaW5nIGEgZGVmZXJyZWQgc3JlZyB3cml0ZSB3
aXRoaW4gdGhlIHNhbWUgcGFja2V0CmJlZm9yZSBpdCBpcyBjb21taXR0ZWQgY2FuIG9ic2VydmUg
YW4gdW5pbml0aWFsaXplZCB0ZW1wIGluc3RlYWQKb2YgdGhlIHJlZ2lzdGVyJ3MgcHJlLXBhY2tl
dCB2YWx1ZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDUgKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYwppbmRleCA3NzIzNTkxNmY0Yi4uMjhhMTcxYmY2MjMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBA
IC02MTUsOSArNjE1LDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnNyZWdfbG9nX2lkeDsg
aSsrKSB7CiAgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKLSAgICAgICAg
aWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQgJiYKLSAgICAgICAgICAgIChjdHgtPm5l
ZWRfY29tbWl0IHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSkgeworICAgICAgICBpZiAocmVn
X251bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgewogICAgICAgICAgICAgY3R4LT50X3NyZWdfbmV3
X3ZhbHVlW3JlZ19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgICAgICB0Y2dfZ2VuX21v
dl90bChjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0sCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIGhleF90X3NyZWdbcmVnX251bV0pOwogICAgICAgICB9CiAgICAgfQogICAgIGZvciAo
aSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkrKykgewotLSAKMi4zNC4xCgo=

