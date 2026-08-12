Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA05C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Tp-00075k-C8; Wed, 12 Aug 2026 02:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tn-00075O-LJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tl-0003nh-Pw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62D8x2992702
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c3ei3+/hHlU0bMY6tZtgWn0p5b5F3IfPfKvcDB+LhSc=; b=nrpwVWO7RminYjX9
 U7A0Ix+hgDNMoQCqzbggyvrSqfL9Z63wEBu/B9tgziZldqFMN+/syt+CDb/l2BxG
 p8lG/yM8AwYi2rf7py4nc9fS7mi7RbpIrsvWmlMTO6P56JQgElgCe4ucfuo0f3eO
 7xswdRSCa5IJL8GQ+8JgHG1MEqMVq8fAuaU3pwlEiuBppxcZTCRNS1fa3uZJW3Y6
 UHR/+GQO5KmjCiLaFeUWcQUq8NtuSQG+owGs2oMDYwh8wB9zytKNdgONdUrlHYie
 iK8dpKSuGQOBv8WgOYnPaAuCBoX5g0DhrYRmkf0f8Lhe27GG9zJm8f29nUNaXrja
 8u7cSQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049dkt91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so1031002a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516220; x=1787121020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c3ei3+/hHlU0bMY6tZtgWn0p5b5F3IfPfKvcDB+LhSc=;
 b=O0F0/Siiz8EMPNepyoCfEhT3bKnafXsJnQPbJjwA3XiZvBsr4Raq0CGyiXUOYilGRh
 vmNzvLorAOLkbQY11JUUi3duiagSXe4oHw/bAAzgj2V6wagwM54rueATtvEjCOFovU+7
 tZ8tit6EMfaTkZB4vv5QPiIEgOmY+oj5kwb35a9/5+mMV0+xcg88sMzhHju/Xko7ZOFH
 xHzBeoFiuzQzblMu2GlSUjfUQnpC5s4eLZ4Wiq2dJMaIe9f+7YEqSWKLVtf+CDLtAyAl
 PNHcs9ZxxV5xs2aGdo6cdJp3IM8ot2pf6Q9y8Ph7Ccms70cCgPRkFd9AvSw+fqSXFsAC
 U4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516220; x=1787121020;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c3ei3+/hHlU0bMY6tZtgWn0p5b5F3IfPfKvcDB+LhSc=;
 b=sBsN1k57H5SZCC7msvvZDVvl2pfZB3fncyMOrAcZhvGmFnInI/ksgKMl1KVQU2YpGz
 szK9gomWHktQzYYy5HJq3SWyZCJlH+hUqjyR6CESYAAng4vEZQsZrwBZRWas5qVTicQw
 PgTDWIQ6x9bIo5m9Y/tUh0PFWLfXosWvCUmKQ4rw+YxOuqXaETANa3WDPePlAqmIeGZK
 Qi4ZRCB0IlVhT9Y9b4FbQOyX0c2RhV3UPcnaQgbb5MHlVtPi7Yn11TSJV3OE4J0qOQIY
 dUw/pPDHg+Dm9T/K7+R00MV8CdMh/X9t5cqy4OPJLFTtNl8xYdq2VvgBruAATlKUSXF3
 0szA==
X-Gm-Message-State: AOJu0YzrXfWcauYOrr+Yj4euZsg5h+a2L83ibDiee4MmXTAgxQ6lmMl0
 vvyKBAEiErYTWBraDVJ0irIfbYc74a7u1yxEEIeKfD/UwWe61YAjyKkZwn9BNOM1FqKhXX4dyVv
 5u5BzxA7kkYTmo/Jf74pNp8NVm/xDRq6LxHDOsKsSiBa539HFMDXkjXgxNB6VfjXw7A==
X-Gm-Gg: AR+sD112naJG/IvwavetOQgFkWI+CdBjTTJg0V4J3lhSXavREAkFbEFwQjGPgwf9PSK
 VuPYxUAlkmbdBbpRdyDoaCD6vZcB2touFVpXBTDIub3Ufg4hah9ZaZrSH6wDPf5G4DCjKcQoSGR
 JxAZk50Uzewl9XHJMVnQEFvWrIUhVdQ2BqwI846TA9dAd5ai0a9HxM1iwHwcKTvbY5OfBDsbASu
 2JuCQFIgOB0Y5D9Z6iyF4bZU+TyonSdVDmfAVdoYFqgAQKnpgY+iERaqlLZuv5L90Y1o5sxCR9J
 2F683LzUhPQCpLlOIYkmqOKCf9Du06LDvpoA3PrbT1O+wiCQp/Mw9zPz9cpCwwJh/HxAwRiBAZP
 VN+UfdkBSKuMfQ0VkxmmgO8dagKuRIGV0Qaw8biLLMF/zlLJs
X-Received: by 2002:a17:90b:3802:b0:38d:e0c4:c955 with SMTP id
 98e67ed59e1d1-393014f2d24mr2864075a91.15.1786516219706; 
 Tue, 11 Aug 2026 23:30:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3802:b0:38d:e0c4:c955 with SMTP id
 98e67ed59e1d1-393014f2d24mr2864019a91.15.1786516219177; 
 Tue, 11 Aug 2026 23:30:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/41] hw/hexagon/virt: add l2vic interrupt-controller and
 virtio-mmio FDT nodes
Date: Tue, 11 Aug 2026 23:29:02 -0700
Message-Id: <20260812062932.543840-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX6ps17p9DW2As
 XX6/mJIn1nlYXSY+EAEBjnqvWm7g04Af/4xvWj3Nv7XPqYgbTxyyu3GxE9Q/jo5m/QbI4loq7A0
 L4lfNjDnZ69fP8JC/+UvmDaf+4+YVt8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfXzYno3V1EHZ43
 4714dEvfgtgSaka5ArG1EFNE6sLxcedhdheKcMPm2tfYs45p2ix2XbQkEB5IvbzsGoqof9Hwa66
 95e8nVWfc198YA+KAKkR/MFpU8qwjIfyXReA5ClsDvlHtvgnxQ14IHwxAK+vNhWBUN5cIsMtWuX
 ooGwCkw8GaYpFhqO0GQ9zGFGo2vTBvvWewq5YQr44WhheZgEuQIQfB3N/qpNddqA9O15dk980FE
 nvqZKjqq+i6VDXxfiyluGh0ehCEmnwD9kk+19SDQ79+iS7uYgLe6oxXZnhZfYtf2sXlN7g16ltx
 0pjn66SdXTJFGDvfx1ABI9VLkTQ5MAF9qSPjIAlpNj/Sqbi4j14sf+1GuNRG1fLmx+/tcLbxL99
 KGLkf2xMwubQuK0vD7yCQM1WfyJmgCs90mNQxz3lDd+lyIREsCwRzHrwGCwo6mLGMnzJhG/3kF8
 7a1mTA4YK0cXZzntXhQ==
X-Proofpoint-GUID: wP2qP_8hCmkNmNwbq0VGCd-M0USdhEQ8
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7c12fc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8iJe-459VSUS_SUazGUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: wP2qP_8hCmkNmNwbq0VGCd-M0USdhEQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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

RXhwb3NlIGwydmljIGFzIGEgZGV2aWNlLXRyZWUgaW50ZXJydXB0LWNvbnRyb2xsZXIgbm9kZSBh
bmQgcmVmZXJlbmNlCml0IHZpYSBpbnRlcnJ1cHQtcGFyZW50LCBzbyBndWVzdCBrZXJuZWxzIGNh
biBkaXNjb3ZlciB0aGUgdmlydGlvLW1taW8KdHJhbnNwb3J0cy4KClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+Ckxpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MDYwNDI3MjMuMzc4NTM2OS0x
Mi1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vdmlydC5jIHwgNDMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDQxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaGV4
YWdvbi92aXJ0LmMgYi9ody9oZXhhZ29uL3ZpcnQuYwppbmRleCBmZjA3NzBjZmM0Ni4uZWEyMGVh
M2M1MGEgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vdmlydC5jCisrKyBiL2h3L2hleGFnb24vdmly
dC5jCkBAIC03NSw2ICs3NSwzMCBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KEhleGFnb25WaXJ0
TWFjaGluZVN0YXRlICp2bXMpCiAgICAgcWVtdV9mZHRfc2V0cHJvcChmZHQsICIvY2hvc2VuIiwg
InJuZy1zZWVkIiwgcm5nX3NlZWQsIHNpemVvZihybmdfc2VlZCkpOwogfQogCitzdGF0aWMgaW50
MzJfdCBmZHRfYWRkX2wydmljKEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmln
ICptX2NmZykKK3sKKyAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORSh2bXMpOworICAgIGlu
dDMyX3QgbDJ2aWNfcGhhbmRsZSA9IHFlbXVfZmR0X2FsbG9jX3BoYW5kbGUobXMtPmZkdCk7Cisg
ICAgY2hhciAqbm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvaW50ZXJydXB0LWNvbnRy
b2xsZXJAJXgiLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1fY2ZnLT5s
MnZpY19iYXNlKTsKKyAgICBjb25zdCBjaGFyIGNvbXBhdFtdID0gInFjb20saDItcGljXDBodm0t
cGljIjsKKworICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCAiL3NvYyIsICJpbnRl
cnJ1cHQtcGFyZW50IiwgbDJ2aWNfcGhhbmRsZSk7CisKKyAgICBxZW11X2ZkdF9hZGRfc3Vibm9k
ZShtcy0+ZmR0LCBub2RlbmFtZSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQs
IG5vZGVuYW1lLCAiI2FkZHJlc3MtY2VsbHMiLCAweDApOworICAgIHFlbXVfZmR0X3NldHByb3Bf
Y2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgIiNpbnRlcnJ1cHQtY2VsbHMiLCAweDEpOworICAgIHFl
bXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9kZW5hbWUsICJjb21wYXRpYmxlIiwgY29tcGF0LCBz
aXplb2YoY29tcGF0KSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+ZmR0LCBub2Rl
bmFtZSwgInJlZyIsIDAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBtX2NmZy0+bDJ2aWNf
YmFzZSwgbV9jZmctPmwydmljX3NpemUpOworICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwg
bm9kZW5hbWUsICJpbnRlcnJ1cHQtY29udHJvbGxlciIsIE5VTEwsIDApOworICAgIHFlbXVfZmR0
X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgInBoYW5kbGUiLCBsMnZpY19waGFuZGxl
KTsKKworICAgIGdfZnJlZShub2RlbmFtZSk7CisgICAgcmV0dXJuIGwydmljX3BoYW5kbGU7Cit9
CisKIHN0YXRpYyB2b2lkIGZkdF9hZGRfaHZ4KEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMs
CiAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2Nv
bmZpZyAqbV9jZmcpCiB7CkBAIC0xNzUsMTMgKzE5OSwxNiBAQCBzdGF0aWMgdm9pZCBmZHRfYWRk
X2NwdV9ub2Rlcyhjb25zdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgIH0KIH0K
IAotc3RhdGljIHZvaWQgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKEhleGFnb25WaXJ0TWFjaGluZVN0
YXRlICp2bXMpCitzdGF0aWMgdm9pZCBjcmVhdGVfdmlydGlvX2RldmljZXMoSGV4YWdvblZpcnRN
YWNoaW5lU3RhdGUgKnZtcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQz
Ml90IGwydmljX3BoYW5kbGUpCiB7CisgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUodm1z
KTsKICAgICBod2FkZHIgc2l6ZSA9IGJhc2VfbWVtbWFwW1ZJUlRfTU1JT10uc2l6ZTsKIAogICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgVklSVElPX0RFVl9DT1VOVDsgaSsrKSB7CiAgICAgICAgIGlu
dCBpcnEgPSBWSVJUSU9fSVJRX0JBU0UgKyBpOwogICAgICAgICBod2FkZHIgYmFzZSA9IGJhc2Vf
bWVtbWFwW1ZJUlRfTU1JT10uYmFzZSArIGkgKiBzaXplOworICAgICAgICBjaGFyICpub2RlbmFt
ZSA9IGdfc3RyZHVwX3ByaW50ZigiL3NvYy92aXJ0aW9fbW1pb0AlIiBQUkl4NjQsIGJhc2UpOwog
ICAgICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gcWRldl9uZXcoInZpcnRpby1tbWlvIik7CiAgICAg
ICAgIFN5c0J1c0RldmljZSAqcyA9IFNZU19CVVNfREVWSUNFKGRldik7CiAKQEAgLTE5Miw2ICsy
MTksMTYgQEAgc3RhdGljIHZvaWQgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKEhleGFnb25WaXJ0TWFj
aGluZVN0YXRlICp2bXMpCiAgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShzLCAwLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbih2bXMtPnBhcmVudF9vYmoubDJ2
aWMsIGlycSkpOwogICAgICAgICB2bXMtPnZpcnRpb19tbWlvW2ldID0gZGV2OworCisgICAgICAg
IHFlbXVfZmR0X2FkZF9zdWJub2RlKG1zLT5mZHQsIG5vZGVuYW1lKTsKKyAgICAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgbm9kZW5hbWUsICJjb21wYXRpYmxlIiwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgInZpcnRpbyxtbWlvIik7CisgICAgICAgIHFlbXVf
ZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLCBiYXNlLCBzaXpl
KTsKKyAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50
ZXJydXB0cyIsIGlycSk7CisgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBu
b2RlbmFtZSwgImludGVycnVwdC1wYXJlbnQiLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbDJ2aWNfcGhhbmRsZSk7CisKKyAgICAgICAgZ19mcmVlKG5vZGVuYW1lKTsKICAgICB9CiB9
CiAKQEAgLTI1MSw2ICsyODgsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0X2luaXQoTWFjaGluZVN0YXRl
ICptcykKICAgICBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zID0gSEVYQUdPTl9WSVJUX01B
Q0hJTkUobXMpOwogICAgIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnICptX2Nm
ZyA9ICZ2NjhuXzEwMjQ7CiAgICAgaW50MzJfdCBjbGtfcGhhbmRsZTsKKyAgICBpbnQzMl90IGwy
dmljX3BoYW5kbGU7CiAKICAgICBjcmVhdGVfZmR0KHZtcyk7CiAgICAgcWVtdV9mZHRfc2V0cHJv
cF9zdHJpbmcobXMtPmZkdCwgIi9jaG9zZW4iLCAiYm9vdGFyZ3MiLCBtcy0+a2VybmVsX2NtZGxp
bmUpOwpAQCAtMjcyLDcgKzMxMCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRfaW5pdChNYWNoaW5lU3Rh
dGUgKm1zKQogCiAgICAgZmR0X2FkZF9odngodm1zLCBtX2NmZyk7CiAKLSAgICBjcmVhdGVfdmly
dGlvX2RldmljZXModm1zKTsKKyAgICBsMnZpY19waGFuZGxlID0gZmR0X2FkZF9sMnZpYyh2bXMs
IG1fY2ZnKTsKKyAgICBjcmVhdGVfdmlydGlvX2RldmljZXModm1zLCBsMnZpY19waGFuZGxlKTsK
IAogICAgIGdfYXV0b2ZyZWUgSGV4YWdvbkNQVSAqKmNwdXMgPSBnX25ldyhIZXhhZ29uQ1BVICos
IG1zLT5zbXAuY3B1cyk7CiAKLS0gCjIuMzQuMQoK

