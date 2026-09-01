Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3C6C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SNG-0005dF-1s; Tue, 01 Sep 2026 13:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SNF-0005cq-9G
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SNC-00083S-T7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H6QCq2033274
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mqNoeHtdFOV/gb6ZNLRhsaJUt3UTdl0o5mgBjZ7nPM0=; b=Hn8meDS3lw70dlvB
 mlAds6KH14gBn5KISkhdrFjzkEiS2RnLmjuSPUlGHdd5PteVrfdO4k1bmVe0L24Z
 vnYNToqV+NRb1xeqlUpG9kG9K88gQzNjHoiS+O32Kx7y7srfeLsa+/paJirDxW6T
 X8Cth/fPcJCF/XLLWL3F2FyZRyY/sUlFEzhhTzLFBhzEfMmj3+1jnbcdt/8b+gNH
 OnHInymnbwOAMlBCtoNjLOfiTd6dsMiPp1z1rEyfmqgdbsCoBF0R3QcYqsmbk3oh
 WUEiKfPuF0NijL/uGa4diL4VmRlW8nVZBctzaNyy/mCeu3J4OapEGVWcyu9X7Kdi
 Qp11sg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcskd6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so109182a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284052; x=1788888852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mqNoeHtdFOV/gb6ZNLRhsaJUt3UTdl0o5mgBjZ7nPM0=;
 b=MaWVmwMfAM+bLrRL7rBuNCHutE2zIQ8f4FSic93KqMo9uvoGOahpc6Mg7X+6RSet9V
 xuf/5XH3N75pK/5gjqd/AWiGgcOQMghh3HbaEFiJX8niBRTHfj7Ykw0tz8vzMoxFVd0T
 RU/9lsobQ91n5bQ+9r8ajet+5CWGPxtJ9TiwUkQALQ9MgkCawn6x0p4mNWxI3/bnRZUq
 rQw4kr0y+AVeKllTwlmyNo+59E1g2RJQufvGKeimEkGTSHlNFMtpSbKzZe1wJXZboHFR
 kboHfU9K1+1lIQsC02ytcIrbIz746r8KrPp/VyF1dwGattPvrUq2+hSW/UPGRMlgMNAf
 /3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284052; x=1788888852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mqNoeHtdFOV/gb6ZNLRhsaJUt3UTdl0o5mgBjZ7nPM0=;
 b=ASR/OgxvymZiOfELdOMpyWqrhLRVIwYr8+KQq2iDMScsqyEmzEg+v2VxgH8cZmgayU
 B3EJdzsCvBGO6ihHD4SyLGOeHh1fEq6hNm6TdgAdg/juvT3KutQGZslBi+9I0IlYTCst
 +vPOCCp1IocASukWO1a8k+sD2AgBPFd4080uv/a7uXPxDdQXXxn4he1cA71FPnPzhBoz
 GqLdPNqkjO+23hZFo3K4GpZuWf4mK1MKs2yT1qZCA6WB9RKl3nGuUOwC0oC2Z3IpAKKs
 9Zz+3qVR3bG/qovKQ1UcrnUjljFMMt3KCYDuJcWW3VkRpzoA1/6rglyeVYTCmNS9jZhK
 Q4EA==
X-Gm-Message-State: AFuF++lEsWOUZnRg8b0YM54jel0eGGl41HCTCw3VYdnM7DBarqkbBco2
 j5dQnj4IYG+RHcbFTF88c2Nj3N8c2ucDCB6BSPtPx+ovL6DpEy3xP9jbqdepkTdUBmHNuMiBzzc
 wFwQJGB9qYQcMMVc6wyK8LBq1piy+EUEJAnlz3XOWHWu7NkUNLaHxaV2S751pIhfUKg==
X-Gm-Gg: AYBFou2I/bnR2GMfn1s3tMTUrf5Cn68YYP71+fIhhkp9EEUNAx3jpvg6g57CVQG8Dxr
 E7Ke6VW4dUmxPqslUU7yu/SXjOXrDnMPtzT6/+Y3I7AflnLHZ83J7y7a0ztZ0ZKQDLwNCkQh/3A
 Qngd9bOrOG+Zf0d6/bAYqfqr3PQsrGH15mKPc3QcTp3kRqv3iH7lpEH1iJP5Dcfnc7nR9plrocB
 7qg6iTsBd/oNKmkCGJD4gACokb7Ds1vD+tQ/RbYWzaZC13ZDZP+uOOt2xRYh5NuJ0k680tMzGmW
 eG5xhNEjWueCzuIJXbqlmNnT5TLrVUKk1HN1u/I6dVUtryXBwC6Fp9YBt2udSEcidAOGPpb4uxw
 TFf1iDOICML+nu00CRbaZTyXhItCy47uozWC/BvMM2rBbl0xJ
X-Received: by 2002:a17:90b:17cd:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-398ba9e7753mr30142431a91.21.1788284052441; 
 Tue, 01 Sep 2026 10:34:12 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-398ba9e7753mr30142373a91.21.1788284051976; 
 Tue, 01 Sep 2026 10:34:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:34:10 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 11/11] tests/functional/hexagon: update to v0.2.12,
 +test_{interrupts, sys_regs}
Date: Tue,  1 Sep 2026 10:33:53 -0700
Message-Id: <20260901173353.200474-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX97gEKFhv53EC
 y9QVvtaJWaZaQQI9+9y4qdrobv0z6mH8oGcWTZltnfAuf/EJwtTBMeKQVJEsNVZOQXrMd+ZimeW
 kZfgogykZZG6ONPolSuf7LdzkgSe7SA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX3q792rvHC7AZ
 WMltUx/11cE9i/vXmCb/IlpvNJpfhoFIJx2RGOKZF7yRZb1oD15RIENETG4qxoMLU6nEXJh8nB7
 +aQ2mbSIc3f+vS6/x+0uxDoNjVIluwX6jHPj6EcyY7kXr/FtlnxLJXHygtJdE0cTraynysf6386
 YGVbV9XGkNXX+14s7mSJIwHN/5xNriRv7n3+74Nt6qOHUriagG/hlLI6Mw5OODcuwz1Xv6OAjbo
 rEa/WM4y6YHUVsfivaOFx5hQJ01G3QnyjPOm0RqHNJFzRPYwc1f7qlycYdS2XhXXXB0ylOm15/s
 45AEy9V42/7TvqpK9+0MPWlgkpPN6eZBekB29vdS/7Gvzw5xhOJe5IKBlxov1QtdOamVDS+6R+Y
 6umerodvwEp5d+VjevJIV9MQ9BD+palB9I22IXgCJFOvaufGWchGxP+vUl3PNUoZ2CsLSA7SxH4
 9N8bK6bv8SVcc0Hj2VA==
X-Proofpoint-GUID: sxyPGs3XGXlK6vMxmUzAdsLT_3s3izR_
X-Proofpoint-ORIG-GUID: sxyPGs3XGXlK6vMxmUzAdsLT_3s3izR_
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a970c95 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=zjiCbJeFjdgwON9hqt0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010155
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

dGVzdF9pbnRlcnJ1cHRzIGFsc28gbm93IHBhc3NlcyBpbiBmdWxsIGZvbGxvd2luZyB0aGUgaWFz
c2lnbntyLHd9CmZpeCwgc28gZW5hYmxlIGl0IGFsb25nc2lkZSB0aGUgb3RoZXIgYXJjaCB0ZXN0
cy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3Rz
LnB5IHwgMTIgKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVz
dF9hcmNoX3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0
cy5weQppbmRleCAwODM0Mzk4YzNiMS4uOGU3MTM4NmMxODYgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25h
bC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMjEsOCArMjEsOCBAQCBjbGFzcyBBcmNo
VGVzdHNVYXJ0KFFlbXVTeXN0ZW1UZXN0KToKIAogICAgIEFTU0VUX1RBUkJBTEwgPSBBc3NldCgK
ICAgICAgICAgImh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9xZW11LWhleGFnb24tdGVzdGlu
Zy9yZWxlYXNlcy8iCi0gICAgICAgICJkb3dubG9hZC92MC4yLjUvYXJjaF90ZXN0c191YXJ0LnRh
ci5neiIsCi0gICAgICAgICJlZGI0ZjM3Yjg3N2EzYTcyYTBlMTA5MjA0Nzc0NThhNDNiNDAwNDVk
MzQzOThmZWU4Y2I3NjNmZWZkMzQyZjRmIiwKKyAgICAgICAgImRvd25sb2FkL3YwLjIuMTIvYXJj
aF90ZXN0c191YXJ0LnRhci5neiIsCisgICAgICAgICI4NzFhMzM5YmY3OGNhYzBlYmFmMWIyNTA5
YmZjZDViMjQ5YWQ4MTkwYmUzM2UwY2Y4NDgyODNiMmY2OTE1MzIzIiwKICAgICApCiAKICAgICBk
ZWYgcnVuX3VhcnRfdGVzdChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKQEAgLTU4LDYgKzU4LDEwIEBA
IGRlZiB0ZXN0X2ludF9zdGVlcmluZyhzZWxmKSAtPiBOb25lOgogICAgICAgICAiIiIKICAgICAg
ICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2ludF9zdGVlcmluZyIpCiAKKyAgICBkZWYgdGVz
dF9pbnRlcnJ1cHRzKHNlbGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIGludGVycnVwdCBk
ZWxpdmVyeS4iIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2ludGVycnVwdHMi
KQorCiAgICAgZGVmIHRlc3RfY2FjaGUoc2VsZikgLT4gTm9uZToKICAgICAgICAgIiIiVGVzdHMg
Y2FjaGUgb3BlcmF0aW9uczogZGNraWxsL2lja2lsbCwgbDJraWxsLCBkY3plcm9hLAogICAgICAg
ICBkY2NsZWFuaW52YSwgY2FjaGUgZGlzYWJsZS9lbmFibGUsIGJhcnJpZXJzLCBhbmQgZGNpbnZh
L2RjY2xlYW5hLgpAQCAtNzAsNiArNzQsMTAgQEAgZGVmIHRlc3RfbDJ2aWMoc2VsZikgLT4gTm9u
ZToKICAgICAgICAgIiIiCiAgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9sMnZpYyIp
CiAKKyAgICBkZWYgdGVzdF9zeXNfcmVncyhzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0
cyBzeXN0ZW0gcmVnaXN0ZXJzLiIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3Rf
c3lzX3JlZ3MiKQorCiAgICAgZGVmIHRlc3RfdGhyZWFkcyhzZWxmKSAtPiBOb25lOgogICAgICAg
ICAiIiJUZXN0cyBoYXJkd2FyZSB0aHJlYWQgbWFuYWdlbWVudDogc3RhcnQvc3RvcCwgTU9ERUNU
TCBzdGF0ZSwKICAgICAgICAgcGVyLXRocmVhZCBIVElELCBzaGFyZWQgbWVtb3J5LCB3YWl0L3Jl
c3VtZSwgU1RJRCBwcmlvcml0eSwgYW5kCi0tIAoyLjM0LjEKCg==

