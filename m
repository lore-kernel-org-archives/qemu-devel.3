Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2038CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckta-0006u7-Cz; Thu, 25 Jun 2026 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktW-0006sk-Mz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktU-0008Ub-Vy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jspe1919005
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=; b=doQYDXbrJ5npWNTT
 ZSTJXjiW8c7n9qALOlMYFsN+/SsxjLCbz6SDZnDVfoEz9zZzGevRcwmMluBzn4AS
 jckiDGIfLRqN0FlilSU37DT1I8t7+jqrM9F38hz2j4fZUCjJvU40kKUGw0hNEV6L
 MvWrRjde7rvOT5333cERg3rQdY0EKfBBWb09QHZilMANP13DeVX+2yvzYmQtuLo8
 2yUoeJgEj9aM64KGhTmW1DFIfp3o8KE83viIOumcp24TG/dlrfobMW5NZVgdm6f3
 EKc/ZPRjPDo2zu4it7ZT1RzHhyUoUzT4tg311kuuSdJtGztDOrX9RlB6vHhlAxAj
 CFV6gg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuajv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c84dc3574so997894eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397037; x=1783001837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=;
 b=Md3UEL65ISzzMjh+tSOKqaU7wWv/8WQqcyghmxM1p5lE/QllvHA1Y25IeU4za34Bxv
 Kl/W07nLi/6yy6dzQk3wLxf9hSukrin/XylQa9RG3XVl1yOg6nUsLx46NjvQyPPd1pJv
 iEvUUe/YbExQoqVQi8TW3n5IPwVvE/tJsFW4jF3kUe0SumK4xmK6PXlTqsOIDBUffwY1
 CUmLkhIQwXBm2BKQHiX7Ti4cWPu/xOvS1F/jgwQ5ho88zD1P6Z4K+bZH8CRFpANnrWTE
 8NT0qvUfSXGVxChVT5E3d0lDlAv9WTcouZzs9eVey0tiLBfk7G9HteSCqeXKdS4fMaFN
 Vj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397037; x=1783001837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=;
 b=eybGW6GM62Brj5QNt+ARPXSWCygf8XsCRDDKRDYJLgXzKYnGOxI2Kmn5NKrgiVGz5g
 zdrhmIxbplKs7bPpm1pDlbZ0CmM5+2jaJlhJiM9lkFIjfiM3RCfx0yqRUDSwlYv7lOUR
 L4uNnzti+J24Fr0mWe79RnFYTWdvSGeNIJwH1klkE/bKtOR9WI0g0LaN9+Mal7NNHuGJ
 EcBjUzh6Nl23HjcBy3GTMEEcSbu8fiCwBBiImZXjM+ao91gSVri3qb/ra4l4rEr5vWlP
 q0FzsW/kItkENGTfeWS2bGr5WLHx7KqbmXBjOw+zph+24LbAQ0wdYCTeS8ey4IOxFZiy
 uxig==
X-Gm-Message-State: AOJu0YySEC3VxpWzPrpDdJDq4EtGqD+3GkJTg+Ajx39Siu2CpqNo5yKx
 RIK3lrFibTocpw3iQcnmWjDCOVT0muSZ0KXCVozX6kx2AIi3n0JenWSA1Zqn69gNBgm/gpMVj10
 sbNcRJTHPr1BJaRkpWlROXLZxOwZHgFf1Zc4NPFx/goUSTFeArP+onbGP9Bk+H2rWOQ==
X-Gm-Gg: AfdE7cnwY8rVPVXN+19JsQPFRC8PB1r1MmhCulqHNBIGSJ9XFiFgCa7kO/g16YDv88f
 c7Y/kU1uYEC8rTq+VUq/S9WBkb+F17Ek+lXFISlANfIv8TjS0PceauCrAkyHtIK6P30h7MtfkNB
 3iqffPTjplh7/TRoH6Gp4kk1EtqNjVMJKaYH28LRLwgF/gf14vimQtdfAhFlb5D/5pe3ESCaLp/
 7xpO4ZLVXf3IEeBjYq2Q2GDSTUhrjnxxdOYkNC8U+7ET5jr4Ed3if6wkvUr491HGFZCZEp9NiS8
 /bpbuGpvCCt2hgE2K2Gm1s5YMgNM3IZqhIIE7PpYZICRwogX+DMs8ol+oWizD//MPt3qVscJP/d
 IH1Wytss8RnmoTXQfuiSNs3/rC3FNgoDBK0KxeroY6BjGn2Da8psqChAWPMA=
X-Received: by 2002:a05:7300:d517:b0:30c:5254:787a with SMTP id
 5a478bee46e88-30c84ad6d1bmr2905776eec.0.1782397036803; 
 Thu, 25 Jun 2026 07:17:16 -0700 (PDT)
X-Received: by 2002:a05:7300:d517:b0:30c:5254:787a with SMTP id
 5a478bee46e88-30c84ad6d1bmr2905722eec.0.1782397036197; 
 Thu, 25 Jun 2026 07:17:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 19/76] target/hexagon: Add handlers for guest/sysreg r/w
Date: Thu, 25 Jun 2026 07:15:36 -0700
Message-Id: <20260625141633.449487-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: IYPNwF9w5sz-KuzY2Kdzpp9YvfTQhhVM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX0y+IS1BffVXY
 96KN3LK1YqunOHM0KPL5ST3i5BEbZrlPcoWwV+FJC4mfJLuPL8YYdQduf0w8sVeE8x87F4CCANe
 P7nm6R+X3YJS3xdhSW/ZI2nEuRP8Vw8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXxdeqhoCBEq2a
 kfjiP+U186Hd4KmYfA8Li0TkDSDy/q2QPNikCc9FJ1JZipVuVs0y+U7BvHU6g9SMCvSUZNy2H4U
 +JuQ+YLw8K4CgfpOjo8ZsqsVS4Outdhnt6ttZ9QLn2fXHkRf4OLTRiOdKVCw3KBHguCGkJGVvSU
 F+SDipNSFZqypcM+MZvOEau/e32boLZx2lNu5SXbncJcjBMwZMjq1ZjLSSm5nKDgCSpKliporst
 yZEDQUdXss5AoMV+/g0l6IXZe2SxSqJ5U6PYYW2olua0YRjjBZ6pC4+g34FfCis5NO/Mjb5L5Oc
 0PabjJJogUjAwIVEfWdYuaz4GZQIAYOPwh/htLnV4b/hBuTWdHKVlON9T6OPge0U+EbmOuSZFZX
 QLyOP/rvCZABqkLqCQhdUMIEZyDTUmtNa0ehbW3RLUEw8djpna9hXblpjPRHIIrNDjl653d5UtL
 yTbgvmQ14Sxi6Wm8+SA==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d386e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IYPNwF9w5sz-KuzY2Kdzpp9YvfTQhhVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGlzIGNvbW1pdCBwcm92aWRl
cyBoYW5kbGVycyB0byBnZW5lcmF0ZSBUQ0cgZm9yIGd1ZXN0IGFuZCBzeXN0ZW0KcmVnaXN0ZXIg
cmVhZHMgYW5kIHdyaXRlcy4gIFRoZXkgd2lsbCBiZSBsZXZlcmFnZWQgYnkgYSBmdXR1cmUgY29t
bWl0LgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDE1MSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dl
bnB0ci5jCmluZGV4IDVkNWFkYWNlNGIzLi44ZjE5MWY4MDYxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTIzLDYg
KzIzLDcgQEAKICNpbmNsdWRlICJleGVjL2hlbHBlci1nZW4uaCIKICNpbmNsdWRlICJpbnNuLmgi
CiAjaW5jbHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRl
ICJ0cmFuc2xhdGUuaCIKICNkZWZpbmUgUUVNVV9HRU5FUkFURSAgICAgICAvKiBVc2VkIGludGVy
bmFsbHkgYnkgbWFjcm9zLmggKi8KICNpbmNsdWRlICJtYWNyb3MuaCIKQEAgLTEyMCw2ICsxMjEs
MTU2IEBAIFRDR3YgZ2V0X3Jlc3VsdF9wcmVkKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcG51bSkK
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
ZWdbcm51bV0sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIGlmIChjdHgtPm5lZWRfY29tbWl0IHx8
IHJudW0gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfaTMy
KGN0eC0+dF9zcmVnX25ld192YWx1ZVtybnVtXSwgdmFsKTsKKyAgICAgICAgICAgIH0gZWxzZSB7
CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfaTMyKGhleF90X3NyZWdbcm51bV0sIHZhbCk7
CisgICAgICAgICAgICB9CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICBnZW5faGVscGVy
X3NyZWdfd3JpdGVfbWFza2VkKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIocm51bSksIHZhbCk7
CisgICAgICAgIH0KKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9s
b2dfc3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwgVENHdl9pNjQg
dmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigpOworCisgICAg
LyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIsIHZhbCk7Cisg
ICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAgLyogSGlnaCB3
b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOworICAgIGdlbl9s
b2dfc3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK0dfR05VQ19VTlVTRUQK
K3N0YXRpYyB2b2lkIGdlbl9yZWFkX3NyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sK
KyAgICBpZiAocmVnX251bSA+PSBIRVhfU1JFR19HTEJfU1RBUlQgfHwgcmVnX251bSA9PSBIRVhf
U1JFR19CQURWQSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChkc3QsIHRjZ19lbnYs
IHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOworICAgIH0gZWxzZSB7CisgICAgICAgIHRjZ19n
ZW5fbW92X2kzMihkc3QsIGhleF90X3NyZWdbcmVnX251bV0pOworICAgIH0KK30KKworR19HTlVD
X1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZ19wYWlyKFRDR3ZfaTY0IGRzdCwgaW50
IHJlZ19udW0pCit7CisgICAgaWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgaWYgKHJlZ19udW0gKyAxID09IEhFWF9TUkVHX0JBRFZBKSB7CisgICAgICAgICAgICBU
Q0d2X2kzMiBiYWR2YSA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICAgICAgICAgIGdlbl9oZWxw
ZXJfc3JlZ19yZWFkKGJhZHZhLCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19CQURWQSkpOworICAgICAgICAgICAgdGNn
X2dlbl9jb25jYXRfaTMyX2k2NChkc3QsIGhleF90X3NyZWdbcmVnX251bV0sIGJhZHZhKTsKKyAg
ICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHRjZ19nZW5fY29uY2F0X2kzMl9pNjQoZHN0LCBo
ZXhfdF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhleF90X3NyZWdbcmVnX251bSArIDFdKTsKKyAgICAgICAgfQorICAgIH0gZWxzZSB7Cisg
ICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkX3BhaXIoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3Rh
bnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lk
IGdlbl9yZWFkX2dyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sKKyAgICBpZiAocmVn
X251bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICB0Y2dfZ2VuX21vdl9pMzIoZHN0LCBoZXhf
Z3JlZ1tyZWdfbnVtXSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgZ2VuX2hlbHBlcl9ncmVnX3Jl
YWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisK
K0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWdfcGFpcihUQ0d2X2k2NCBk
c3QsIGludCByZWdfbnVtKQoreworICAgIGlmIChyZWdfbnVtID09IEhFWF9HUkVHX0cwIHx8IHJl
Z19udW0gPT0gSEVYX0dSRUdfRzIpIHsKKyAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2NChk
c3QsIGhleF9ncmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaGV4X2dyZWdbcmVnX251bSArIDFdKTsKKyAgICB9IGVsc2UgeworICAgICAgICBnZW5faGVs
cGVyX2dyZWdfcmVhZF9wYWlyKGRzdCwgdGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihyZWdfbnVt
KSk7CisgICAgfQorfQorI2VuZGlmCisKKwogdm9pZCBnZW5fcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKQogewogICAgIFRDR3YgcHJlZCA9IGdldF9yZXN1
bHRfcHJlZChjdHgsIHBudW0pOwotLSAKMi4zNC4xCgo=

