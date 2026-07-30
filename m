Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0A7C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZn-0005i8-0O; Wed, 29 Jul 2026 21:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZl-0005ha-3n
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZj-0005b6-ES
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1NiHS3460224
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 npg4+DCIh4VnJXD0MHu/y/UcQjF1MhMogiRWdPyQzlM=; b=InMEhlacDhZ41RC+
 e+1PhWPvdaxqHCR+biV7L5ye8P7z2JszcGY6hLY7uZBezLembAfAQxXzi/ZUtfn1
 0WO9edPafsTpSwjCpDyCwtv0+OsE6Baw55uhVrxlMEeIOrEbjFTwvjzU/y2J2kHA
 6b30biZsZWW4QB5pMPJGCGJSzf24k+iAgnmhv47W/ioD+0T0xyNo4ydOn/idp17d
 T7AOOITglzQb6u/ydJZwBoQFH2jjGknjBsL0WuS0xZFrnmgQ+JOx7VZ4DVauas3h
 NorPqD8ZLS24WDnqT0KE7EVOXb+j1flAnNKiw8TUPuZrgzZ2TXsW0LmO67a9tpA4
 xY+Nfw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvwpg0f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfbf3e4a63so43584785ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374921; x=1785979721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=npg4+DCIh4VnJXD0MHu/y/UcQjF1MhMogiRWdPyQzlM=;
 b=aH6mXzTzBU44L9FXv+Ee+J5txkIAdLQjI3rP87PVTIl7cSJpx50c/ZePXT4lObknoX
 tbf7a6azdDRfHUIqt1Uk7h1xCPgtIVn60ASPSKJOSbbvUwIoCUwf89EDRRB6qEp3Oyol
 hWacPA53gqLgJY9U28EfVSFFQWIOsBGTino97HemmxcGC+HwK0Wuzh2n8HsT9j8nckuz
 Uot7VTuRKb+a8sJnXUA6s2Hr7vNXPqc2BHfkIrh/2CeSWLDA/OHvbBLS+WFCSrJC3wtQ
 FKDcvy/bYHNoo6suqVbvXmRAibQzo5agP/DOoNMVi0fOgu9Aw5kpjj3Xtfa2K6qNaI+d
 3JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374921; x=1785979721;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=npg4+DCIh4VnJXD0MHu/y/UcQjF1MhMogiRWdPyQzlM=;
 b=b6y2GxXCZOdkhKgGkzj5NANGs1ZUOZwOSfh2uSqFuXQP1ja266bSY1CyO+EnUcnFLp
 IvSLbgS5jlErkeu0/C6cDHQ7v+8hcEoexpxvd/rVYHMvT+vcGHhigTz6Apv+vdf5zpEA
 hb1OSFswv217bLY4t+iDG/8P3j3C1yxNjpqibs3i3BI6WIzKK4MtvGuNrhoSS/j3QtZa
 BiixpIZrF8nvOp8+W+9EpMZHAxKuM6kN6sbPFknXSiO5ZvDCf+fR5A2EAlao119mSnZ/
 2Xv4tqN8FdYVFFEx27nW2jthLOERfFR96XTkWLX+JRQwdGSieRY2zENV+x822RHkxSlw
 a3Rg==
X-Gm-Message-State: AOJu0YwHwxibNngO//lca3ftbxpI1GHOQdtKcC19/FXh8dskLvFeKqsF
 RoOL3sKxW9wMM+x5u/DeNU3RYEIgIV4XVkgG0EEvsbUL+BZuV0UPXUalvhWWdPT+BJ+jjuSM7W8
 rGPUUbuRMmCJJIYHH/glg5RJTIXx1yqJHHJ7lyZWBBrBm/1YbpP2+L5GazrYsYvyWgw==
X-Gm-Gg: AR+sD12Cq25RUf07ZTAXfw+7F+d6qTyQb7S93pQ7d2eVNkKaqMb0V/p4mv5sh9NoWaI
 G6irsiVRDCYFnj5pdTP1Dm8xGP6/fyUYYWCszfd2Qf+y6r9UkRfUS2m3c5egApUK50Ih8Knds+p
 wKjmWMjjZMgT9mekL+Au+zxxQSyNjCMUrydVj3XvBZmzsUMkyCCvEjXEAezUdKKu1DVTW1vb7Mj
 kH3k6a/GKwRVd8IvC0OWFv93g/Juqp850deRl8YFO2IGmsdSuk8k7TJZbefY8hT4aHzjazuYtTl
 6ye1xGGqsxHajRyifO9qhc/OwTJM+03bKNTlDXCHDXcEi+ILS4pv4Ndwrv8/C3Mz4vMcYvOPW3m
 2gCkXVeN97Bb/OZqMmP/qc6BCC3QIaXnURrIvjiDQUIQ/Nx+C
X-Received: by 2002:a05:6a21:3392:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3c9004a080amr592346637.6.1785374921470; 
 Wed, 29 Jul 2026 18:28:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:3392:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3c9004a080amr592328637.6.1785374921102; 
 Wed, 29 Jul 2026 18:28:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 11/18] hw/hexagon/virt: add l2vic interrupt-controller and
 virtio-mmio FDT nodes
Date: Wed, 29 Jul 2026 18:28:16 -0700
Message-Id: <20260730012824.1135905-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: w7pG87j8ljFXWGb23KCGScnY7rpAMiUd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX4m82TgmkGrnS
 7Zua4VLoMWolEiOIB+gl9/xfKmedCE9fXaXEjXPPwZtBJiZfPHT3B45LRb8PoS7pasG7PabfeGA
 QAosjJxhg1V3zgqeAhym7PxH4ZNY9NY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfXxlIgznMjQIOL
 jOSKYN4cvQyuy/gXmIpBVNQSFwpX0MDkkLpytzCxht/sZRCGGhc7s3RcCNpeP2G4m4GYyvZrMkI
 CRUGCYY5kQ8/4lohaEf8KW+KxTQx8XVNH2lp0RZ64Ng2S2H6E5tq7DbEUyz3uET2b3Qk1so1ELV
 gpl2JEo8421qyjjsQMCTtccLqLtjMVT9qSURdlTZEjJmsaPU3nmlwASYhL1baf0PNrlV96yzv9E
 VYfrS4Hhr/wXMnssqcqH2JoXzs9rP79zRd5O2p1LO8wiQ+aaRfF7sbLEY30YZK6d4SW0XYsHJAA
 6uCXOcPtwZqrVlzX/DxL05/oIFaK4nwBYXvEBb1uXWwrbLnItjAPDHYiIDutkesOFhLPreA2guT
 Ts+2GOUWzUi/JGi7oTNj+DLPtYJs+jSZyAFx9o9IEVigN0+S9zv2FkY841WnN30w9vPF7RfUb3d
 oKFX7ELISM7yEX7Jcog==
X-Proofpoint-ORIG-GUID: w7pG87j8ljFXWGb23KCGScnY7rpAMiUd
X-Authority-Analysis: v=2.4 cv=WqAb99fv c=1 sm=1 tr=0 ts=6a6aa8ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=a15GVhKgg4D0RywPxTcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300006
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
biBkaXNjb3ZlciB0aGUgdmlydGlvLW1taW8KdHJhbnNwb3J0cy4KClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL3Zp
cnQuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXggZmYwNzcwY2Zj
NDYuLmVhMjBlYTNjNTBhIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYworKysgYi9ody9o
ZXhhZ29uL3ZpcnQuYwpAQCAtNzUsNiArNzUsMzAgQEAgc3RhdGljIHZvaWQgY3JlYXRlX2ZkdChI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgIHFlbXVfZmR0X3NldHByb3AoZmR0LCAi
L2Nob3NlbiIsICJybmctc2VlZCIsIHJuZ19zZWVkLCBzaXplb2Yocm5nX3NlZWQpKTsKIH0KIAor
c3RhdGljIGludDMyX3QgZmR0X2FkZF9sMnZpYyhIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1z
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNo
aW5lX2NvbmZpZyAqbV9jZmcpCit7CisgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUodm1z
KTsKKyAgICBpbnQzMl90IGwydmljX3BoYW5kbGUgPSBxZW11X2ZkdF9hbGxvY19waGFuZGxlKG1z
LT5mZHQpOworICAgIGNoYXIgKm5vZGVuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIvc29jL2ludGVy
cnVwdC1jb250cm9sbGVyQCV4IiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtX2NmZy0+bDJ2aWNfYmFzZSk7CisgICAgY29uc3QgY2hhciBjb21wYXRbXSA9ICJxY29tLGgy
LXBpY1wwaHZtLXBpYyI7CisKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgIi9z
b2MiLCAiaW50ZXJydXB0LXBhcmVudCIsIGwydmljX3BoYW5kbGUpOworCisgICAgcWVtdV9mZHRf
YWRkX3N1Ym5vZGUobXMtPmZkdCwgbm9kZW5hbWUpOworICAgIHFlbXVfZmR0X3NldHByb3BfY2Vs
bChtcy0+ZmR0LCBub2RlbmFtZSwgIiNhZGRyZXNzLWNlbGxzIiwgMHgwKTsKKyAgICBxZW11X2Zk
dF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICIjaW50ZXJydXB0LWNlbGxzIiwgMHgx
KTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiY29tcGF0aWJsZSIs
IGNvbXBhdCwgc2l6ZW9mKGNvbXBhdCkpOworICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMt
PmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgbV9j
ZmctPmwydmljX2Jhc2UsIG1fY2ZnLT5sMnZpY19zaXplKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9w
KG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0LWNvbnRyb2xsZXIiLCBOVUxMLCAwKTsKKyAg
ICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICJwaGFuZGxlIiwgbDJ2
aWNfcGhhbmRsZSk7CisKKyAgICBnX2ZyZWUobm9kZW5hbWUpOworICAgIHJldHVybiBsMnZpY19w
aGFuZGxlOworfQorCiBzdGF0aWMgdm9pZCBmZHRfYWRkX2h2eChIZXhhZ29uVmlydE1hY2hpbmVT
dGF0ZSAqdm1zLAogICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGhleGFnb25f
bWFjaGluZV9jb25maWcgKm1fY2ZnKQogewpAQCAtMTc1LDEzICsxOTksMTYgQEAgc3RhdGljIHZv
aWQgZmR0X2FkZF9jcHVfbm9kZXMoY29uc3QgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcykK
ICAgICB9CiB9CiAKLXN0YXRpYyB2b2lkIGNyZWF0ZV92aXJ0aW9fZGV2aWNlcyhIZXhhZ29uVmly
dE1hY2hpbmVTdGF0ZSAqdm1zKQorc3RhdGljIHZvaWQgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKEhl
eGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50MzJfdCBsMnZpY19waGFuZGxlKQogeworICAgIE1hY2hpbmVTdGF0ZSAqbXMgPSBN
QUNISU5FKHZtcyk7CiAgICAgaHdhZGRyIHNpemUgPSBiYXNlX21lbW1hcFtWSVJUX01NSU9dLnNp
emU7CiAKICAgICBmb3IgKGludCBpID0gMDsgaSA8IFZJUlRJT19ERVZfQ09VTlQ7IGkrKykgewog
ICAgICAgICBpbnQgaXJxID0gVklSVElPX0lSUV9CQVNFICsgaTsKICAgICAgICAgaHdhZGRyIGJh
c2UgPSBiYXNlX21lbW1hcFtWSVJUX01NSU9dLmJhc2UgKyBpICogc2l6ZTsKKyAgICAgICAgY2hh
ciAqbm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvdmlydGlvX21taW9AJSIgUFJJeDY0
LCBiYXNlKTsKICAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9IHFkZXZfbmV3KCJ2aXJ0aW8tbW1p
byIpOwogICAgICAgICBTeXNCdXNEZXZpY2UgKnMgPSBTWVNfQlVTX0RFVklDRShkZXYpOwogCkBA
IC0xOTIsNiArMjE5LDE2IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV92aXJ0aW9fZGV2aWNlcyhIZXhh
Z29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEocywg
MCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4odm1zLT5wYXJl
bnRfb2JqLmwydmljLCBpcnEpKTsKICAgICAgICAgdm1zLT52aXJ0aW9fbW1pb1tpXSA9IGRldjsK
KworICAgICAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBub2RlbmFtZSk7CisgICAg
ICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsIG5vZGVuYW1lLCAiY29tcGF0aWJs
ZSIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ2aXJ0aW8sbW1pbyIpOworICAg
ICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwg
YmFzZSwgc2l6ZSk7CisgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2Rl
bmFtZSwgImludGVycnVwdHMiLCBpcnEpOworICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwo
bXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtcGFyZW50IiwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGwydmljX3BoYW5kbGUpOworCisgICAgICAgIGdfZnJlZShub2RlbmFtZSk7
CiAgICAgfQogfQogCkBAIC0yNTEsNiArMjg4LDcgQEAgc3RhdGljIHZvaWQgdmlydF9pbml0KE1h
Y2hpbmVTdGF0ZSAqbXMpCiAgICAgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcyA9IEhFWEFH
T05fVklSVF9NQUNISU5FKG1zKTsKICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2Nv
bmZpZyAqbV9jZmcgPSAmdjY4bl8xMDI0OwogICAgIGludDMyX3QgY2xrX3BoYW5kbGU7CisgICAg
aW50MzJfdCBsMnZpY19waGFuZGxlOwogCiAgICAgY3JlYXRlX2ZkdCh2bXMpOwogICAgIHFlbXVf
ZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsICIvY2hvc2VuIiwgImJvb3RhcmdzIiwgbXMtPmtl
cm5lbF9jbWRsaW5lKTsKQEAgLTI3Miw3ICszMTAsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0X2luaXQo
TWFjaGluZVN0YXRlICptcykKIAogICAgIGZkdF9hZGRfaHZ4KHZtcywgbV9jZmcpOwogCi0gICAg
Y3JlYXRlX3ZpcnRpb19kZXZpY2VzKHZtcyk7CisgICAgbDJ2aWNfcGhhbmRsZSA9IGZkdF9hZGRf
bDJ2aWModm1zLCBtX2NmZyk7CisgICAgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKHZtcywgbDJ2aWNf
cGhhbmRsZSk7CiAKICAgICBnX2F1dG9mcmVlIEhleGFnb25DUFUgKipjcHVzID0gZ19uZXcoSGV4
YWdvbkNQVSAqLCBtcy0+c21wLmNwdXMpOwogCi0tIAoyLjM0LjEKCg==

