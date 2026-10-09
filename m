Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43A9CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGEC-0007Mj-IC; Fri, 09 Oct 2026 15:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE8-0007MM-BR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE6-0007dW-Lw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZcfd2144338
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e2lTbLsq2k0/N2eb6rjI97sjHa1wyyn22/E1UZ9+fNI=; b=XGHP91OorySih0T2
 cbb30x//KyFRu/rxn9gETwkFLour74nNh6pf5YTxHnE6IrPb1m1tAqJy+6uOoS9y
 4HnTGN1VYjDAEHawu5H1jJjkNFfCxBa3/cpVWaMkZbGOfKGPbjZU6kb6R7PYgSbq
 NBGALHzgDeYR4aP4MPNyhHM04NI6JH5+wGVyVUwhGnbYNxWiZVltjxNJxlUPilPc
 EMpa2BetOV5IUJaWQ5AWjyHmhrfJ6aBonfNSsThF1LCQtmlNoGF79fz0FZbq9qrS
 ldX556Bsw5vQpRCOzyu7QiWv5L8dc3g/VHbTk2K4E+wZhdqUEso3u+rUvP7LVL3r
 2ga52g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7rdtk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so69775eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573952; x=1792178752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e2lTbLsq2k0/N2eb6rjI97sjHa1wyyn22/E1UZ9+fNI=;
 b=bBrm2QCKzwethRilpAYzM8MTh+KhEkVOzNV0gvlSRlc2wMRJA8oydhP56Fx76Zf+eo
 uOMw4QcVD0A69LtEIYGjB1Zi3HB13QBYpLIiGJDZcN4PVNaUTNP0vvkb6xXqfJ+SdLfR
 o6/KGK8BZYho5pl3A3FlqsOfNS8Mcl3yfGeRBv5LMeIfryM1Fo506dXwnLVTk15nRNu7
 /XZp+WWT7xffikpl8f9/QHqEWuvnVyDhF2IQsm5xIMtR6Zm7IAvzFILEKGJRFBD6ZYMs
 3W7JAASZioHrXUNxEP3ujrPrCasXP+2fXQigQR+BTI5Ol4fRX6vKiMtGwwpJ9lAxk2tD
 0IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573952; x=1792178752;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e2lTbLsq2k0/N2eb6rjI97sjHa1wyyn22/E1UZ9+fNI=;
 b=nWDugCQRG0cinRSWR4qJpXyeBGI7ikAVg2VqVCEV/2hcvj2PtFPv5k/tENukwcMjre
 JURvAes0Z4cD5JS+IqHzVvihmvWsb+NevswEJ9XGWD12z0iDZ0X4oRVfZ1nXjhro/gs7
 HWyu6QNI2HAvGoL0BxB7gpCsPAgtMHIBd8Bgaqi/ES+WqgwZWxVLoqg1figwAY4wmg+v
 22ajFGCvYFMI+eyz5hkCTVgwVr8PMS2krKtAgf4OzsX9g3rdePrz33+/9qzNUwpIBMiZ
 iocd7vrym5L5+dg3eYdY8vmTU2J7f//ugSPSa3RXKvcLYd5S1NXFBzCfwUQKL0gx1rsQ
 8AJQ==
X-Gm-Message-State: AFuF++mQH6Kz6MTFo/YOqV+YuWwqq0ExePCWHc0vjZu8dZl4Y8DIg21P
 SO4ezk5a1T+zebU0vyog8p1z9kQsh1Pu7owH7wv9VuGQR0Qf6LFvroQi19yZEKO5pQgUNlk/Hm+
 vD9bwUXJrwRo4JtzNC7qR113hhrx3QhFcUrULajHQARFVCfTofuloF4lDpLyma/sU+A==
X-Gm-Gg: AYBFou3DrHmKqXkaVTZFV5UxluJXoMBOA6IRdcU+D/UOkPQfe8xfLGqbJ8VwqupHap2
 HLOKJ26V1J1SYabRHDRkUnXR6dC7g/rwkgWGm+z6iNNxlnzTWXvpE9qwkc4GzEb0878SGAixFS8
 XRBjnZrek+i53HvXtsm07Q3C4jXxkCxELXXIeH9NC4unt5YpdE+FwEaibPU3/TsL3W/XMhY7flm
 xIL9uOlyvBYbnSkg3g9DzByKEMDg+sGSROEQ9ZphtnvoReQF4cvqvU07kmHlEfBxhSarJCV+F0e
 i7WfA5SGww9IgxSYdMSTtDAjZLePvlp9W2limWS9uPL4jY/r6JwlwCA76mBw/w6nJSIVO2jEBF/
 VfeOsye7FV+3aIdRonEK9A/mIgt+Or/sr4ANFmVaNMvNROP8=
X-Received: by 2002:a05:693c:80db:b0:353:5d25:1de7 with SMTP id
 5a478bee46e88-3537e0abb18mr4364838eec.33.1791573952288; 
 Fri, 09 Oct 2026 12:25:52 -0700 (PDT)
X-Received: by 2002:a05:693c:80db:b0:353:5d25:1de7 with SMTP id
 5a478bee46e88-3537e0abb18mr4364781eec.33.1791573951502; 
 Fri, 09 Oct 2026 12:25:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/6] target/hexagon: wake K0 and TLB lock waiters
Date: Fri,  9 Oct 2026 12:25:36 -0700
Message-Id: <20261009192541.4163758-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfXyelf0H/+4C66
 /8rndyZDd5g/ieqq8OTJPbPw2RGy8ZlHNe1gu/q27gxQoSCtcnwafS9y5GcS1P/jM84XHcg9PIS
 BslJKEej2y3jZH8yXlWVaC6QEFlfIrexNQZbFdKamkpsZOd9fEADafMO3xJkg2DzaG+hYleWJtF
 J6qfS/pZ7MVT9MfbZjnczar9/ZW4L4ZZcxwrteLFOThWhB9Dt0iYCTCxPwjfkzWp8yRji46DBu+
 deQa01vdpitxmjM9rn1TXsYtQezhEs5lN14s11UxRwzxD6Ud2h42K1jAI/0qZ6zEjZCNCkF3Kf3
 ZH8XGeDRQPT7AugK8QpRZoMinLPaKh1Kn07edrbHLRkXeaS5C/cPvTJkvis1hqnGog6fNJruTEL
 ZnS/3Cdc/R2mehG73hO4N68QNYW5pZgzad33x3WLUWAFfjzyfO4az74ccvKVo5Oy7qhy/s+cP+8
 rfWCHy2r0UEyKkVJRAQ==
X-Proofpoint-ORIG-GUID: fUlKSfYVUbJzMv-9gvOV9_8S_m8tQ9fG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX7o4IKJvihcPU
 yKbl/GH57l41CxGl7u+4QEGMwY1HEmxgpPNLIDpWe2mAw/JxUxyOx8RtF7IUEPKj6WN1zhntL09
 6vlS8KeHeJrdhd1zJQVJ/4U6iXe4wms=
X-Authority-Analysis: v=2.4 cv=PaFqFShd c=1 sm=1 tr=0 ts=6ac93fc1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=B3wVGE7vzLrs5E8uOrsA:9 a=Qc5_LKlSlzfzbCtC:21
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: fUlKSfYVUbJzMv-9gvOV9_8S_m8tQ9fG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090077
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

V2FrZSB0aGUgc2VsZWN0ZWQgSzAgb3IgVExCIGxvY2sgd2FpdGVyIHdoZW4gb3duZXJzaGlwIHBh
c3Nlcy4gVXBkYXRlIGl0cwppbnRlcnJ1cHQgc3RhdGUgYW5kIGtpY2sgdGhlIHZDUFUuCgpTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQog
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICB8IDIgKysKIHRhcmdldC9oZXhhZ29uL2hl
eF9pbnRlcnJ1cHRzLmMgfCA4ICsrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMgICAg
ICAgIHwgMyArKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgfCAyICsrCiA0IGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBl
ci5jCmluZGV4IGNmMDc2MmZmMDVmLi4wY2M4ZWM4OTBkYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAt
NDYwLDYgKzQ2MCw3IEBAIHN0YXRpYyB1aW50MzJfdCBzZXRfZW5hYmxlX21hc2soQ1BVSGV4YWdv
blN0YXRlICplbnYpCiAgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RM
X0UsIG1vZGVjdGwpOwogICAgIHRocmVhZF9lbmFibGVkX21hc2sgfD0gMHgxIDw8IGVudi0+dGhy
ZWFkSWQ7CiAgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX01PREVDVEwsIE1PREVD
VExfRSwgdGhyZWFkX2VuYWJsZWRfbWFzayk7CisgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZW52
KTsKICAgICByZXR1cm4gdGhyZWFkX2VuYWJsZWRfbWFzazsKIH0KIApAQCAtNDgwLDYgKzQ4MSw3
IEBAIHN0YXRpYyB1aW50MzJfdCBjbGVhcl9lbmFibGVfbWFzayhDUFVIZXhhZ29uU3RhdGUgKmVu
dikKICAgICB0aHJlYWRfZW5hYmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExfRSwgbW9kZWN0
bCk7CiAgICAgdGhyZWFkX2VuYWJsZWRfbWFzayAmPSB+KDB4MSA8PCBlbnYtPnRocmVhZElkKTsK
ICAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdfTU9ERUNUTCwgTU9ERUNUTF9FLCB0
aHJlYWRfZW5hYmxlZF9tYXNrKTsKKyAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShlbnYpOwogICAg
IHJldHVybiB0aHJlYWRfZW5hYmxlZF9tYXNrOwogfQogc3RhdGljIHZvaWQgZG9fc3RhcnRfdGhy
ZWFkKENQVVN0YXRlICpjcywgcnVuX29uX2NwdV9kYXRhIHRiZCkKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0
cy5jCmluZGV4IDBiNzE0YjczODMxLi4wMWZlMTg5NjIwMyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaGV4X2ludGVycnVwdHMuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0
cy5jCkBAIC0yNDAsOCArMjQwLDEwIEBAIHN0YXRpYyBib29sIGhleF9pc19xdWFsaWZpZWRfZm9y
X2ludChDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IGludF9udW0pCiAgICAgYm9vbCBzc3JfaWUg
PSBnZXRfc3NyX2llKGVudik7CiAgICAgYm9vbCBzc3JfZXggPSBnZXRfc3NyX2V4KGVudik7CiAg
ICAgYm9vbCBpbWFzayA9IGdldF9pbWFza19iaXQoZW52LCBpbnRfbnVtKTsKKyAgICBib29sIGxv
Y2tfcGVuZGluZyA9IGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19VTkxPQ0tFRCB8fAor
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19V
TkxPQ0tFRDsKIAotICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQgJiYgc3NyX2llICYmICFz
c3JfZXggJiYgIWltYXNrOworICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQgJiYgc3NyX2ll
ICYmICFzc3JfZXggJiYgIWltYXNrICYmICFsb2NrX3BlbmRpbmc7CiB9CiAKIHN0YXRpYyB2b2lk
IGNsZWFyX3BlbmRpbmdfbG9ja3MoQ1BVSGV4YWdvblN0YXRlICplbnYpCkBAIC0yNTcsNyArMjU5
LDkgQEAgc3RhdGljIHZvaWQgY2xlYXJfcGVuZGluZ19sb2NrcyhDUFVIZXhhZ29uU3RhdGUgKmVu
dikKIAogc3RhdGljIGJvb2wgc2hvdWxkX25vdF9leGVjKENQVUhleGFnb25TdGF0ZSAqZW52KQog
ewotICAgIHJldHVybiAoZ2V0X2V4ZV9tb2RlKGVudikgPT0gSEVYX0VYRV9NT0RFX1dBSVQpOwor
ICAgIHJldHVybiBnZXRfZXhlX21vZGUoZW52KSA9PSBIRVhfRVhFX01PREVfV0FJVCB8fAorICAg
ICAgICAgICBlbnYtPmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfV0FJVElORyB8fAorICAgICAg
ICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1dBSVRJTkc7CiB9CiAKIHN0YXRp
YyB2b2lkIHJlc3RvcmVfc3RhdGUoQ1BVSGV4YWdvblN0YXRlICplbnYsIGJvb2wgaW50X2FjY2Vw
dGVkKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jIGIvdGFyZ2V0L2hleGFn
b24vaGV4X21tdS5jCmluZGV4IGQ2ZWU3YzQwNzk4Li5iZGNmYTA1N2MyMSAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwpA
QCAtMTksNiArMTksNyBAQAogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRlICJody9o
ZXhhZ29uL2hleGFnb25fdGxiLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5oIgorI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCiAKIHN0YXRpYyBpbmxpbmUgdm9p
ZCBoZXhfbG9nX3RsYncodWludDMyX3QgaW5kZXgsIHVpbnQ2NF90IGVudHJ5KQogewpAQCAtMjcx
LDYgKzI3Miw4IEBAIHZvaWQgaGV4X3RsYl91bmxvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAg
ICAgICAgIHVubG9ja190aHJlYWQtPnRsYl9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfUVVFVUVEOwog
ICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKHVubG9ja190aHJlYWQsIFNZU0NGR19UTEJMT0NLLCAx
KTsKICAgICAgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsK
KyAgICAgICAgaGV4X2ludGVycnVwdF91cGRhdGUodW5sb2NrX3RocmVhZCk7CisgICAgICAgIHFl
bXVfY3B1X2tpY2soY3MpOwogICAgIH0KIAogICAgIGlmIChxZW11X2xvZ2xldmVsX21hc2soQ1BV
X0xPR19NTVUpKSB7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRmMDBjYTc3M2YzLi42Nzg0ZWZkZGM5ZiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKQEAgLTEzOTUsNiArMTM5NSw4IEBAIHN0YXRpYyB2b2lkIGhleF9rMF91
bmxvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIHVubG9ja190aHJlYWQtPmswX2xv
Y2tfc3RhdGUgPSBIRVhfTE9DS19RVUVVRUQ7CiAgICAgICAgIFNFVF9TWVNDRkdfRklFTEQodW5s
b2NrX3RocmVhZCwgU1lTQ0ZHX0swTE9DSywgMSk7CiAgICAgICAgIGNwdV9pbnRlcnJ1cHQoY3Ms
IENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKTsKKyAgICAgICAgaGV4X2ludGVycnVwdF91cGRhdGUo
dW5sb2NrX3RocmVhZCk7CisgICAgICAgIHFlbXVfY3B1X2tpY2soY3MpOwogICAgIH0KIAogfQot
LSAKMi4zNC4xCgo=

