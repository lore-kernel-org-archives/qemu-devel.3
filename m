Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB76E10F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV3-0001dk-9D; Wed, 01 Apr 2026 11:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUy-0001Dy-8N
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUw-00083k-3y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631EjvKs1579405
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QXV/60pOO2kpG9+5multo3d+Hi5XgUZBxzn9kXs+jwQ=; b=oU0HsGJqVb5UDjUf
 OYCmNRE3OYzkqR40xaIK+GV3UpGvfpDFYs88eGPk1oCXFDfSQTUCGkRzo7bD3nVu
 sKaOI2Dc5QVfm+09B4lAjy6o4li7yjJs9/JPIsKh0uaAWBxEMrg1cpyFAfmneHBz
 N12uVG15UQxCxFXBdDUqJJnat54+PUdz4QlQAEGbgCWE70nahl5/qlNI975eJIX+
 IXSpMxrMt3n5c2OKBtkStNqsgHeudojkkWG+oiXlT/27aMS2vWEKh3xqNoCsxXle
 hJuUPBZSct6Q8IudSGvR5F2IltroV5kBeFDgmOY7rV+HivgADo7FfHWPtMInSTZV
 ol+zzg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2vbg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c72849f648so9363285eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057282; x=1775662082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXV/60pOO2kpG9+5multo3d+Hi5XgUZBxzn9kXs+jwQ=;
 b=HVjHBLFayimlM46cL81GnGNwFdBPI+IpjgAS94MQGb2KFyGFf+OfR4vaNC09DRQGRU
 eDMFoQSiOmLna2/lpLkPjvd6gzItr/6LaR/mjoR1Yne/X304KicRnbnfy+MnfvO3FvxC
 xF/RU+FXcAkMJKAZNXYbGhbGSTG4oM94+u/f6CWHZev5bzeWQkC0C+sJa4mfQHMI2oZp
 VXmCtkfDwJniDqa+t/L2q/xbyk+NQoaglyLLty0ayYqWMGdwgYwGdFAfjVPkuvgcmJ2V
 +7wFmnmSGqbbB9IXL9jvLV0VanviYaSuDjbqDWwYxHMks01XNbSnFpiZEXbo8glzJ7A6
 WjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057282; x=1775662082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QXV/60pOO2kpG9+5multo3d+Hi5XgUZBxzn9kXs+jwQ=;
 b=lrA6sSKgHvS9aODlGC5Fj3AoC0nywEOXPq44m8HCuunHV4o/kjTqDNKpOEcPiMuthe
 IJbKEBsdbERSC0sz5z4Rok+9W8rWtqvwgW94HvMy8LWonFIp1HEAhSU6Ggg+Mc31jPMp
 eiWdWYwXXH30JJZ92gU/yQjzSZpTpw/9FET7DZ4Bv0640CqEY+sUYyR+dLzRI1UQeVzu
 a/Yi0xbyTx05WRtukAYJJJSKVp8vOkPoNcgcTrEIs4CoY7BSh+9Tj2T5ofGVGWG6TvxL
 3cEQlhCi4lFgjp+IubzszNUescC7Q92br0LFI7+MEwaylwkiEQqvO4amRhT2oRYoONT2
 mAHg==
X-Gm-Message-State: AOJu0YxxzZalIJStK4WfoOmVqc+1ILdZiG7TjqAY2k15F7poGIwYA+Z1
 2uGDyAL/WVvxxNJr6izsIIgzC46g9VrIF/DYkAHxcZcjpYN6JnfUhJfcm/CIId69OoQBlROumpz
 BKBroTxKt4I6A8gN1mPt0tOILml2sdu6FQ+ZjwkZ62Av+z1NarauzpVvTTv0/U0lEWg==
X-Gm-Gg: ATEYQzxRqZ+nvOkx8xTtU5FEHhRlsbbHBhlUks1JOixnCLmjCDX3gDRJA7Mcv0tVG97
 dXHG+GXLQxT66Bm0DkfAsgWmwpXxkaQ/HjepONzAGyHEiDRKFNWCQnrmLhHQmVl7ynIbEGTy4Dm
 r+nt9UslJt8rf2k3RRxG8MwsOC4LBVG91gZKlqMtfGwuGm5nixqpoqYHaYeGCLUdO5wM7u/e7h1
 F+leSd9sZ5bcXK0ZQKbB+OEVcz42+n7W/QRgVVxShQecHi8cmjqRVL+fuvEQMXjbF9ujpLRpoMv
 3WrA5Iu9MpL6aBdrdnwujS9oWd+VNZ2eL0C6108z2ZyfzYbTg62KONyGPiVbtplTFuRvGN42Vmy
 KI17+gUT4G2zJmk7wPUk78MLmCGdzYE9vz2qzM0ybHhkhgAlQFamvnFJziDLHosu33vta7g==
X-Received: by 2002:a05:7300:dc8c:b0:2c7:3a7:c7af with SMTP id
 5a478bee46e88-2c93088db6cmr2328150eec.7.1775057281944; 
 Wed, 01 Apr 2026 08:28:01 -0700 (PDT)
X-Received: by 2002:a05:7300:dc8c:b0:2c7:3a7:c7af with SMTP id
 5a478bee46e88-2c93088db6cmr2328140eec.7.1775057281425; 
 Wed, 01 Apr 2026 08:28:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 17/37] target/hexagon: Add handlers for guest/sysreg r/w
Date: Wed,  1 Apr 2026 08:26:37 -0700
Message-Id: <20260401152657.314902-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cd3985 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kFhime3ImIDmaAvYXo1iK1i0344__TZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX7wVE7SBGm3kK
 asc9vgyZXdFbnY/m1ttvKd6FOx6TMuMF84+fW0nuiccPSPjGJ1J16n0879tYnBGV1NH7TgdUg/g
 cU+lYVR5HpTbSpCHJkeKT12zG5iRGKuBieOCiOZBfVbx07mDQq5i4IaWHzBEjWsGFlAdh3CCD3R
 /ZSfm4uvSvp5jCp5fUB57OO/uJ5BS+jNDfL4X5VD8SMxSfHoxCQ48MRvY+ANhxxjO6BWfGKgeNl
 xC/iXKV4NhOw+w+Ku4WXrI4q83JScJUNHRaKWwwdf/km4Y+9AQif/z+rmUW3zNkRz/RGv973d26
 qOWtClChZSdvee5U+/AYRRdltY1J7Was3w2K01MqYyvGaauSfmIsuwW8idYVhUsFFYyCBnaTefx
 Lw9mEiRo1rcNVkHP5FliVcasR+oSfymHxarvecji5i8HYQgy933Fsa/rkihHpIUNI/Wa92fifAt
 wgJS1wrH6E3QgD75JvA==
X-Proofpoint-GUID: kFhime3ImIDmaAvYXo1iK1i0344__TZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010144
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGlzIGNvbW1pdCBwcm92aWRl
cyBoYW5kbGVycyB0byBnZW5lcmF0ZSBUQ0cgZm9yIGd1ZXN0IGFuZCBzeXN0ZW0KcmVnaXN0ZXIg
cmVhZHMgYW5kIHdyaXRlcy4gIFRoZXkgd2lsbCBiZSBsZXZlcmFnZWQgYnkgYSBmdXR1cmUgY29t
bWl0LgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDE0NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQ3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dl
bnB0ci5jCmluZGV4IGM3Yjk0MzZjOGQ0Li5kNzFmYTU3OGI2ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTIzLDYg
KzIzLDcgQEAKICNpbmNsdWRlICJleGVjL2hlbHBlci1nZW4uaCIKICNpbmNsdWRlICJpbnNuLmgi
CiAjaW5jbHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRl
ICJ0cmFuc2xhdGUuaCIKICNkZWZpbmUgUUVNVV9HRU5FUkFURSAgICAgICAvKiBVc2VkIGludGVy
bmFsbHkgYnkgbWFjcm9zLmggKi8KICNpbmNsdWRlICJtYWNyb3MuaCIKQEAgLTEyMCw2ICsxMjEs
MTUyIEBAIFRDR3YgZ2V0X3Jlc3VsdF9wcmVkKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcG51bSkK
ICAgICB9CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorR19HTlVDX1VOVVNFRAorc3Rh
dGljIGJvb2wgZ3JlZ193cml0YWJsZShpbnQgcm51bSwgYm9vbCBwYWlyKQoreworICAgIGlmIChw
YWlyKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAgIHJl
dHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLAor
ICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdpc3Rl
ciBwYWlyIEclZDolZFxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAg
fSBlbHNlIHsKKyAgICAgICAgaWYgKHJudW0gPD0gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAg
IHJldHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdp
c3RlciBHJWRcbiIsIHJudW0pOworICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKK0dfR05V
Q19VTlVTRUQKK3N0YXRpYyB2b2lkIGNoZWNrX2dyZWdfaW1wbChpbnQgcm51bSwgYm9vbCBwYWly
KQoreworICAgIGlmIChwYWlyICYmICghZ3JlZ19pbXBsZW1lbnRlZChybnVtKSB8fCAhZ3JlZ19p
bXBsZW1lbnRlZChybnVtICsgMSkpKSB7CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBndWVzdCByZWdpc3RlciBwYWlyIEclZDolZCBp
cyB1bmltcGxlbWVudGVkIG9yICIKKyAgICAgICAgICAgICAgICAicmVzZXJ2ZWQuIFJlYWQgd2ls
bCB5aWVsZCAwLlxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAgfSBl
bHNlIGlmICghcGFpciAmJiAhZ3JlZ19pbXBsZW1lbnRlZChybnVtKSkgeworICAgICAgICBxZW11
X2xvZ19tYXNrKExPR19VTklNUCwKKyAgICAgICAgICAgICAgICAiV2FybmluZzogZ3Vlc3QgcmVn
aXN0ZXIgRyVkIGlzIHVuaW1wbGVtZW50ZWQgb3IgcmVzZXJ2ZWQuIgorICAgICAgICAgICAgICAg
ICIgUmVhZCB3aWxsIHlpZWxkIDAuXG4iLCBybnVtKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVT
RUQKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fbG9nX2dyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpj
dHgsIGludCBybnVtLCBUQ0d2X2kzMiB2YWwpCit7CisgICAgdGNnX2dlbl9tb3ZfaTMyKGN0eC0+
Z3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2
b2lkIGdlbl9sb2dfZ3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwg
VENHdl9pNjQgdmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigp
OworCisgICAgLyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIs
IHZhbCk7CisgICAgZ2VuX2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAg
LyogSGlnaCB3b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOwor
ICAgIGdlbl9sb2dfZ3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK3N0YXRp
YyBjb25zdCB1aW50MzJfdCBzcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10gPSB7CisgICAgW0hF
WF9TUkVHX1NUSURdID0gMHhmZjAwZmYwMCwKKyAgICBbSEVYX1NSRUdfRUxSXSA9IDB4MDAwMDAw
MDMsCisgICAgW0hFWF9TUkVHX1NTUl0gPSAweDAwMDA4MDAwLAorICAgIFtIRVhfU1JFR19DQ1Jd
ID0gMHgxMGUwZmYyNCwKKyAgICBbSEVYX1NSRUdfSFRJRF0gPSBJTU1VVEFCTEUsCisgICAgW0hF
WF9TUkVHX0lNQVNLXSA9IDB4ZmZmZjAwMDAsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gMHgwMDAw
MDBmZiwKK307CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9sb2dfc3JlZ193cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0sIFRDR3ZfaTMyIHZhbCkKK3sKKyAgICBjb25z
dCB1aW50MzJfdCByZWdfbWFzayA9IHNyZWdfaW1tdXRfbWFza3Nbcm51bV07CisKKyAgICBpZiAo
cmVnX21hc2sgIT0gSU1NVVRBQkxFKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX1NSRUdfR0xC
X1NUQVJUKSB7CisgICAgICAgICAgICBnZW5fbWFza2VkX3JlZ193cml0ZSh2YWwsIGhleF90X3Ny
ZWdbcm51bV0sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIHRjZ19nZW5fbW92X2kzMihjdHgtPnRf
c3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAg
ICBnZW5faGVscGVyX3NyZWdfd3JpdGVfbWFza2VkKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIo
cm51bSksIHZhbCk7CisgICAgICAgIH0KKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRp
YyB2b2lkIGdlbl9sb2dfc3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51
bSwgVENHdl9pNjQgdmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kz
MigpOworCisgICAgLyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFs
MzIsIHZhbCk7CisgICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisg
ICAgLyogSGlnaCB3b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwp
OworICAgIGdlbl9sb2dfc3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK0df
R05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX3NyZWcoVENHdl9pMzIgZHN0LCBpbnQg
cmVnX251bSkKK3sKKyAgICBpZiAocmVnX251bSA+PSBIRVhfU1JFR19HTEJfU1RBUlQgfHwgcmVn
X251bSA9PSBIRVhfU1JFR19CQURWQSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChk
c3QsIHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOworICAgIH0gZWxzZSB7Cisg
ICAgICAgIHRjZ19nZW5fbW92X2kzMihkc3QsIGhleF90X3NyZWdbcmVnX251bV0pOworICAgIH0K
K30KKworR19HTlVDX1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZ19wYWlyKFRDR3Zf
aTY0IGRzdCwgaW50IHJlZ19udW0pCit7CisgICAgaWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJf
U1RBUlQpIHsKKyAgICAgICAgaWYgKHJlZ19udW0gKyAxID09IEhFWF9TUkVHX0JBRFZBKSB7Cisg
ICAgICAgICAgICBUQ0d2X2kzMiBiYWR2YSA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICAgICAg
ICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkKGJhZHZhLCB0Y2dfZW52LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19CQURWQSkpOworICAg
ICAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2NChkc3QsIGhleF90X3NyZWdbcmVnX251bV0s
IGJhZHZhKTsKKyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHRjZ19nZW5fY29uY2F0X2kz
Ml9pNjQoZHN0LCBoZXhfdF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGhleF90X3NyZWdbcmVnX251bSArIDFdKTsKKyAgICAgICAgfQorICAg
IH0gZWxzZSB7CisgICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkX3BhaXIoZHN0LCB0Y2dfZW52
LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQK
K3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sK
KyAgICBpZiAocmVnX251bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICB0Y2dfZ2VuX21vdl9p
MzIoZHN0LCBoZXhfZ3JlZ1tyZWdfbnVtXSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgZ2VuX2hl
bHBlcl9ncmVnX3JlYWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsK
KyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWdfcGFp
cihUQ0d2X2k2NCBkc3QsIGludCByZWdfbnVtKQoreworICAgIGlmIChyZWdfbnVtID09IEhFWF9H
UkVHX0cwIHx8IHJlZ19udW0gPT0gSEVYX0dSRUdfRzIpIHsKKyAgICAgICAgdGNnX2dlbl9jb25j
YXRfaTMyX2k2NChkc3QsIGhleF9ncmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaGV4X2dyZWdbcmVnX251bSArIDFdKTsKKyAgICB9IGVsc2UgeworICAg
ICAgICBnZW5faGVscGVyX2dyZWdfcmVhZF9wYWlyKGRzdCwgdGNnX2VudiwgdGNnX2NvbnN0YW50
X2kzMihyZWdfbnVtKSk7CisgICAgfQorfQorI2VuZGlmCisKKwogdm9pZCBnZW5fcHJlZF93cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKQogewogICAgIFRDR3YgcHJl
ZCA9IGdldF9yZXN1bHRfcHJlZChjdHgsIHBudW0pOwotLSAKMi4zNC4xCgo=

