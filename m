Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59527CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9V-0003Yi-0Z; Mon, 22 Jun 2026 18:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9O-0003TQ-F1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9M-0006aH-Sd
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZwIE1541909
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=; b=Za5O2uIVWFqUdTkB
 asOgH9kqfm64esWOovfXcpkIdEseHaj1phEGv78Gf8gAsaG+YTeyvrwZAbT6RdfN
 XWjVTKdhbwdGjpfm3jqv/qyUGk0woyrW9Fbvqz4dBilvL82qIaEEW+9joEznotWT
 K2WLVpD37ngmuRHg7tpBFOuweSk988E4GR40j/dfrb1M0W1kyh03KycHdVOilMmH
 rNbGQbiq7fOHixeYncEDSwZyZrYifvaeM/5gaq2ASpLZ5w05+QAf9xcYP//6zc5C
 irBtkdvVTeyb3e34//4PP0YJIx9MihP14klIJ7FM73fojQnHn42QSXoZ0EkEdCZy
 PL7Gdw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0tgbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bfe262ef0so312209eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167391; x=1782772191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=C+io33v25L9aqNH5FJlPxE9UPcBhBPPPtbla4/mTYid5LRFm3NGdMCvAwhRQ75LczN
 VHBcij/BXlbJBjOyP+GZMi49P1wEmtXLVxJIRIZkmq4dQxUwo7EeMZG0fxH5fOYiknxe
 odXjR1lC9lqgU7Uce2mYhtNvz0h6woylEQcAvFcDqzS1aRqlfnDwPiYGNfPyeyuEyPNZ
 sj4jtmpoTMIf9Dv7VWajgyjH2YgqWuQnom2lqs2krnviQ95DrmPPhdYCpwjxicoVi7y6
 uum6d0xYU3YNqd/owSfRL3YKWXUm5reZ6LN02bbdzWtdNWIJTkMJL+8hbdwWKyrzeaMU
 VWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167391; x=1782772191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=TUEm+PqFhXlU1ouwJPtsmwYNxGJt/y05h4V1hDgEuqHjVgutG3htdxw1Ko1rmf4x/z
 +iE+X3L+EdpfnVUrlhpL+yu8aQWc7RblP3dicdutPOQLf7DruuQTWMiNGCevrOKp3GPJ
 Ziv7Al1QoA+BLmOTV4XzaTj7j9q5CZXZ+VpkbJR9F4NrNF69vtqQFP1QtojwRoS6b0wo
 yzX4pyvfE86SV7KDFew/6hNx/l9amAU7e00dZHmgzmwFP7e++oLKsXPlW0jsc0TeNij0
 mxTzUDb8VwIa1t6pZTKF628vAoicCwFqGmvEPx8rEwf2481qCGe/gfW6j0hm/dlzJSi+
 DudA==
X-Gm-Message-State: AOJu0YxkmkyGsSZf26Q6vRoeW6+ED/e9BgenvHip94pxSAfgbqdk9NRr
 2IHSTCCh7iVjyc3SAfgHJeY8Rl0huBz2XP71AGZhXJtmXPQQcZjel/hHKvWBF+xUouIv6qLHz9B
 4VlJBvRDvEpHQ4K3SYuRVY1+VNvlElSH8gBNoCsDsYsQTzvJ2/PsAMfEuP5y4fNJpZw==
X-Gm-Gg: AfdE7cmd0Ib0xXiwn6PZDfKM3paxiKj35EagAO5sCiDuEaBrGPbhisrQIAb1IP4r0ZU
 63JFgHXSR5m1LSYVoFDGlqkmJCMK54zhYNqC3GZMoHo355N2a8FPL2PkKqYBDB8xEhehCsfIXPR
 YccSsh7M/VkAHly/f1frFJ/wz7SYc2A3CuX6G0YY6K1XK/ClQ8Cxl3Ny/Ym9X153ouyrCn8ORth
 VsTa5caM0lFRbWvB5RFtio0vgp1ereypdbudoFw371mSm81CwRe7RZHStV5CjZjZMO3xOmzCree
 zhpRjH9GnyTk8SDB43dCWqJzO/IzjdmeLZt6kzbGx2Aeg6qREbmIN8Dv9f1Bn9v/ym/XI+4pYcV
 kMQR/L6Jh/qNNOHoxoPOZVHhNNgwtvf8T/Ywv3s05jnAa28vaJNj9GzAyyW8=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id
 5a478bee46e88-30c5553b105mr698660eec.7.1782167390465; 
 Mon, 22 Jun 2026 15:29:50 -0700 (PDT)
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id
 5a478bee46e88-30c5553b105mr698645eec.7.1782167389929; 
 Mon, 22 Jun 2026 15:29:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 27/75] target/hexagon: Add TCG overrides for thread ctl
Date: Mon, 22 Jun 2026 15:28:16 -0700
Message-Id: <20260622222904.607771-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX+KjjizXTqV78
 BjPNegZxCfz1wxtvKq700HFAiDAJFUnUaYYLiQbxtFMW1iIqI0VuAQ1cDVDdUe4d0kem3v7a3d5
 oYEbd4BllzVXGXNbsmbjmbUrpgdF/oA=
X-Proofpoint-GUID: ar8Wjf4Dtog-nsObLgm1-Gpac5zYwH7D
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a39b75f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1JCjwIay07Af
 4PyHJIWgCuq7XDj34RX7UVHOk/Vv67FWZ5awYKCeX74UhicGQhWN3l/kQk3CixJ26EvNhBCCFKA
 111FxiXHfNAl14a0a38K9d9dkkV3TR9qONrrRSoPmQFSI8+7k66YbfZ+eXxW0nqv2/z95zIdOO7
 i5vUmLRNkHv/eb0zNnhVFuC3Rw+Q6SzAybdjLw17m4CW+CK1bbNuelhXFLyySmOB7pHN9cHU06l
 AshLwFDJ2SrQB/Xy4rrw7Hqa03lVmrbv6gj5ALtSoo7QUm4HL3iiOipw7LMUBQpuqhMp/aazrAR
 1LQ2Ixhnbs+BZhhGu+1cdO/5JHfO57R5ShBtNZAO6b5vlPO0kMvodahYSYfRvXHzV6bDwuLk2oe
 6FPiTRi/X/XZucEhyM17P0cwpeFKBaOMd/5s6i7zvztsQLT/tlDmnIJwm36Kqklcf9bDkvp1oH6
 2eutF8ie+lPchit3E8Q==
X-Proofpoint-ORIG-GUID: ar8Wjf4Dtog-nsObLgm1-Gpac5zYwH7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgpSZXZpZXdlZC1i
eTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggfCAxOCArKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAg
IHwgMjAgKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDRjYmJkZDFmNzBiLi44NjUwZjY0YTZkNCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX3N5cy5oCkBAIC03Nyw0ICs3NywyMiBAQAogICAgICAgICB9IFwKICAgICB9IHdo
aWxlICgwKQogCisjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCisgICAgZG8g
eyBcCisgICAgICAgIFJzViA9IFJzVjsgXAorICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2Vu
diwgdGNnX2NvbnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgfSB3aGlsZSAoMCkKKwor
I2RlZmluZSBmR0VOX1RDR19ZMl9yZXN1bWUoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9y
ZXN1bWUodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX3N0YXJ0KFNIT1JUQ09E
RSkgXAorICAgIGdlbl9oZWxwZXJfc3RhcnQodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX1kyX3N0b3AoU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFJzViA9IFJzVjsg
XAorICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKKyAgICB9IHdoaWxlICgwKQor
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hl
eGFnb24vaGVscGVyLmgKaW5kZXggOTU1Mjg3MTMzZTQuLjY4MmYwYzZjMjZlIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApA
QCAtMTIzLDQgKzEyMyw4IEBAIERFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CiBERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCiBERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCiBERUZfSEVMUEVSXzMo
c2V0cHJpbywgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RFRl9IRUxQRVJfMihzdGFydCwgdm9pZCwg
ZW52LCBpMzIpCitERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQorREVGX0hFTFBFUl8yKHdh
aXQsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIp
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYzkwYjc1NzI0MTkuLmM2MjBhNWI4NjM2IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTQyMCw2ICsxNDIwLDI2IEBAIHVpbnQzMl90IEhFTFBFUihpYXNzaWdu
cikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwogfQogCit2b2lkIEhFTFBFUihzdGFydCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IGltYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB0YXJnZXRfdWxvbmcgUEMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwor
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
K3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB1aW50MzJfdCBIRUxQRVIoZ2V0
aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCiB7CiAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKLS0gCjIuMzQuMQoK

