Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02818C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6t-0004Zd-Pm; Wed, 12 Aug 2026 11:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6a-0004MO-B8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6W-0000GN-Nc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbquf3875558
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=BcRGjPqnpCJA2RaIKm7HtO5E9vmLu6p36g0B7rd/ZWY=; b=h8
 uie+iaMtQEB5It85vYxgCjpc5wyCNA5ZA69EBv3F6uQV+CHYN+Q52PKeLPAFAyOR
 XwgrnjlTdpsKZnO+PYl+sEFyqRWDkWKVt6fVJTJnmXcu+YjC3x/LN2G4jtN/Kvv8
 xHqhP6Zhbx5fdjxZdKG74D4QPQTvKYaiOnCG+qMWN1onVXmvMVRIMrQGMK5+g7vj
 y5x9OCZdgRH3MIszy312c4qngxHKeCGS14iOxunpM6IQ9rFDWCb9HigcshHOHbbl
 WeXI6BLggAl0fyPaHM6mKIDS7d0gzEiqNddiMwtGTg31hGuY11OoZG4gvP7f+ufP
 ecfFyHNP1Fx1U+N5G3pw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1jsr9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso1232681a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549374; x=1787154174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BcRGjPqnpCJA2RaIKm7HtO5E9vmLu6p36g0B7rd/ZWY=;
 b=QcO0NkXXxzRXt49Ass/qEj+3WqRajOlA1xk9y6sZK0Kqzqj4uNWU332mFqICVrCcNv
 XDXmUpu2pbex9OD9/CgEOwOK+ikbWMptLtkHVJ5/UNJ27/Tx/EeiCCdqmVM2Ve6poyB9
 Jdhnf2RPlYE011z0RdnMc5IZ6Y43wfd3h7NhPAmFtecAlBI/ankMNTHHx74dYc6p0N2G
 xj8/oeCUIGmPeB/22zzs7a3jPAf1n0OqA0hEg87HBdCn0ZjlaCiw5TRdxLJf1DSs39rP
 sEW+mgbq8fYo7pcjx1da4lIwG0lI+lWJvijhVQO32Kv21xF+x4+yl6AHbVREgg+0EO9a
 Fi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549374; x=1787154174;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BcRGjPqnpCJA2RaIKm7HtO5E9vmLu6p36g0B7rd/ZWY=;
 b=K0PLUXrFXLv0qMFDqHzJ9YY41OlGGvS380RiKGea1KS/gXqzm43fUFLTYZBL0SgKTl
 J8mVShqMfQknRGcf8ksPdMjGkKD95klgy/oBtzezJNObOuzElbPV59CKAnCu3xU7bmmE
 HOIcchXEpEGOkfJL9UKYC1SzDvgxuvDoVuesKY2HzSy5QIOejVzvQbeq3CK47iRBntXp
 nHQrN7YaJWXVm9/Fh/hfQErjUrfHoXAhce9v+TzDTwKvVxh9GEzwtZFdalv3qccLZgVK
 Sk9gAzjfFidMevFy52JxM96Iyy+ebWAYmrfKuTm/GBP9TjZxN10QfvUHngCCDAJGyvoE
 JPuw==
X-Gm-Message-State: AOJu0YzDCN1BXCTtIY2QNovm7VBKfQ0oYYD+eRtJT2QcewAfceW6iyfp
 KnISV9M34EysNgSQkB1DvVlczWr+h9ZJ6WQ5xQmfjbW9iTqWLktdPHTEvta0vmYujlcjAsgaObt
 qaBiajKLs+hv7FfomnugDEv1IAJxG1UnncRvRR5SeqhU9l1JGF1eEc2N1wDT379mnlw==
X-Gm-Gg: AR+sD13zlpud/LA4UwAu+SeP3Kl5oGG4nqxKwfuBzDWs3qWjPXb8BfczoD1QS0L9mOZ
 4JqSQXtp9EwxlFwlo6H61zzooqKUCL3D8LhDu0fWKIXNCzJ4amlDs5QTNnxIUz5BY4uYS6DMtaE
 mpBrR0ndJxQMn0BIul3KpKDX3Wpps/7JHW6j1R/zCIya2Schn/s5ks5QyPHudi0DvF5B/EbxcXp
 Oy2epmu59ZyQWHup1KGc86HA2DLNJeAgemfxIb6QNyJxOAbeuSpj3lGCdSh0O/ihsHnS0ZdoKjP
 mB9s5Ce5p2q4dTr0FwO6y8rJErutm5vXsl9QD6QjNp0qqyIfcAV7e5LdJRonhw7X5J4sHoR6AAm
 fC2Mm1BkDHDUxwQZnQjnCBWtcMxIPvQ677LEofSdJxfXkQ2bj
X-Received: by 2002:a05:6a20:918c:b0:3c4:36ef:3dc9 with SMTP id
 adf61e73a8af0-3cc3f6eb96amr6243822637.17.1786549374315; 
 Wed, 12 Aug 2026 08:42:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:918c:b0:3c4:36ef:3dc9 with SMTP id
 adf61e73a8af0-3cc3f6eb96amr6243768637.17.1786549373791; 
 Wed, 12 Aug 2026 08:42:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 10/41] hw/hexagon/virt: instantiate virtio-mmio transports
Date: Wed, 12 Aug 2026 08:41:49 -0700
Message-Id: <20260812154220.1029828-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: UlQLwt9JCA4CIhXQbvLQx67UriVRedyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX5V4OtAixLPJw
 d9aaMkwyOmfhuDHLZLjLzIdRHarvBeNieK5GS8hzclJHRIXUONR2VUGVi4+cpsKT330tarZa0Ya
 Eyotiu3kKFmWDfc8rUlmBVm7+Kie9d8JEE1C3Bif2qbJHOU3FqlynlL168uKKkqiTLfZTi0cp45
 9yWMGdh3Tcn2NCndZkli/egNZVpdDJMQEgpDiCN4JX2DtAI/Dc8xcp3tr9LnXO9mxAdR/M3KMcE
 wjQNRx/FfzX8+rA8gRauI/0AGGsJO7aqce3C+S+cwm7GGIb7AHji4HBU4GVc5wDMaL7/OXnbM4t
 JfeB3+8E8n1SCt61DPpiQJ4rCsl03unO+UbUextmV652q6t4nQ3YXMRvFXYcIOewGbZVoWNbnCq
 MTIB84MJZ9efCj9YCvTEeqpS4WZ7yIOUCekpXeBq9aUcNyyREhAPbPuzfF5Shq16RWrY/ABhuIj
 y4HPdlARIyRRnCk0Y3g==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c947f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qfYuoNLC281KTBfHwCsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: UlQLwt9JCA4CIhXQbvLQx67UriVRedyV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX53BbIFmrXDVp
 QBGlDnnMwGe/x6+i0yoCnlwtz5E5vvTWxX0NiQgI0felDfRGzI0MteuKdM/x6fzyUnjYwenXZwl
 V46e/rh57Vv+aItG+GlcuR3AL6W2T7M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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

QWRkIGEgVklSVF9NTUlPIHJlZ2lvbiBhbmQgdmlydGlvLW1taW8gdHJhbnNwb3J0cywgd2lyZWQg
aW50byBsMnZpYy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QG9zcy5xdWFsY29tbS5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjA4MDYwNDI3MjMuMzc4NTM2OS0xMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggfCAgMyArKysKIGh3L2hleGFnb24vdmlydC5j
ICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24vdmly
dC5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaAppbmRleCBjZjBjZDJmOGYyMi4uNGNhMmYx
ZWY4NTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKKysrIGIvaW5jbHVk
ZS9ody9oZXhhZ29uL3ZpcnQuaApAQCAtMTEsNiArMTEsOCBAQAogI2luY2x1ZGUgImh3L2hleGFn
b24vaGV4YWdvbi5oIgogI2luY2x1ZGUgInRhcmdldC9oZXhhZ29uL2NwdS5oIgogCisjZGVmaW5l
IFZJUlRJT19ERVZfQ09VTlQgOAorCiBzdHJ1Y3QgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgewog
ICAgIEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgcGFyZW50X29iajsKIApAQCAtMTksNiArMjEs
NyBAQCBzdHJ1Y3QgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgewogICAgIE1lbW9yeVJlZ2lvbiB0
Y207CiAgICAgTWVtb3J5UmVnaW9uIGJpb3M7CiAgICAgQ2xvY2sgKmFwYl9jbGs7CisgICAgRGV2
aWNlU3RhdGUgKnZpcnRpb19tbWlvW1ZJUlRJT19ERVZfQ09VTlRdOwogfTsKIAogdm9pZCBoZXhh
Z29uX2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKTsK
ZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXgg
OWE2ODA4NTJjM2MuLmZmMDc3MGNmYzQ2IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYwor
KysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtMzAsMTEgKzMwLDE5IEBACiAKIGVudW0gewogICAg
IFZJUlRfVUFSVDAsCisgICAgVklSVF9NTUlPLAogICAgIFZJUlRfRkRULAogfTsKIAorLyoKKyAq
IFZpcnRpbyBJUlFzIHJ1biBmcm9tIFZJUlRJT19JUlFfQkFTRSB0bworICogVklSVElPX0lSUV9C
QVNFICsgVklSVElPX0RFVl9DT1VOVCAtIDEKKyAqLworc3RhdGljIGNvbnN0IGludCBWSVJUSU9f
SVJRX0JBU0UgPSAxNjsKKwogc3RhdGljIGNvbnN0IE1lbU1hcEVudHJ5IGJhc2VfbWVtbWFwW10g
PSB7CiAgICAgW1ZJUlRfVUFSVDBdID0geyAweDEwMDAwMDAwLCAweDAwMDAwMjAwIH0sCisgICAg
W1ZJUlRfTU1JT10gPSB7IDB4MTEwMDAwMDAsIDB4MDAwMDEwMDAgfSwKICAgICBbVklSVF9GRFRd
ID0geyAweDk5ODAwMDAwLCAweDAwNDAwMDAwIH0sCiB9OwogCkBAIC0xNjcsNyArMTc1LDI1IEBA
IHN0YXRpYyB2b2lkIGZkdF9hZGRfY3B1X25vZGVzKGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0
YXRlICp2bXMpCiAgICAgfQogfQogCitzdGF0aWMgdm9pZCBjcmVhdGVfdmlydGlvX2RldmljZXMo
SGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcykKK3sKKyAgICBod2FkZHIgc2l6ZSA9IGJhc2Vf
bWVtbWFwW1ZJUlRfTU1JT10uc2l6ZTsKIAorICAgIGZvciAoaW50IGkgPSAwOyBpIDwgVklSVElP
X0RFVl9DT1VOVDsgaSsrKSB7CisgICAgICAgIGludCBpcnEgPSBWSVJUSU9fSVJRX0JBU0UgKyBp
OworICAgICAgICBod2FkZHIgYmFzZSA9IGJhc2VfbWVtbWFwW1ZJUlRfTU1JT10uYmFzZSArIGkg
KiBzaXplOworICAgICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gcWRldl9uZXcoInZpcnRpby1tbWlv
Iik7CisgICAgICAgIFN5c0J1c0RldmljZSAqcyA9IFNZU19CVVNfREVWSUNFKGRldik7CisKKyAg
ICAgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChPQkpFQ1QoTUFDSElORSh2bXMpKSwgInZp
cnRpby1tbWlvWypdIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1Qo
ZGV2KSk7CisgICAgICAgIHN5c2J1c19yZWFsaXplX2FuZF91bnJlZihzLCAmZXJyb3JfZmF0YWwp
OworICAgICAgICBzeXNidXNfbW1pb19tYXAocywgMCwgYmFzZSk7CisgICAgICAgIHN5c2J1c19j
b25uZWN0X2lycShzLCAwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bp
b19pbih2bXMtPnBhcmVudF9vYmoubDJ2aWMsIGlycSkpOworICAgICAgICB2bXMtPnZpcnRpb19t
bWlvW2ldID0gZGV2OworICAgIH0KK30KIAogdm9pZCBoZXhhZ29uX2xvYWRfZmR0KGNvbnN0IEhl
eGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCiB7CkBAIC0yNDYsNiArMjcyLDggQEAgc3RhdGlj
IHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAKICAgICBmZHRfYWRkX2h2eCh2bXMs
IG1fY2ZnKTsKIAorICAgIGNyZWF0ZV92aXJ0aW9fZGV2aWNlcyh2bXMpOworCiAgICAgZ19hdXRv
ZnJlZSBIZXhhZ29uQ1BVICoqY3B1cyA9IGdfbmV3KEhleGFnb25DUFUgKiwgbXMtPnNtcC5jcHVz
KTsKIAogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbXMtPnNtcC5jcHVzOyBpKyspIHsKLS0gCjIu
MzQuMQoK

