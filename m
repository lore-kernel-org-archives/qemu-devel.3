Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0291C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53ma-0005Bk-5g; Fri, 11 Sep 2026 12:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53ji-0003OC-N9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jU-0007dK-0n
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF8jTZ170572
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xP2XfQ+/wetzxUMQ/VBD0ygw9qsKWMkl/ULfmMylxDY=; b=hVh9m/R7uLgQe65w
 Z3ke9VObQpCRcxAS2sHIyGGrqjNlecv2/GpcjCvVdZJLnhpZvAEBuz7uhup7DYYR
 fPKskX7ilgRCIK3OggY8LvcsVZ2Qp5i66yu9Qm226OB7TFvwK3dmfJ4wd/hgcIeD
 nu7DtdlPz45Gu0XuIB4uvWRLS+Kqq3N3LMic3EMmcQHv7WXHIu7Tk+agtl6/Tojc
 sxYW5YQ2JTkSRKi+MxGLESngVrcFevb17KsX1DwAJqKfHSDawrL0Q4CuUa7lfwmY
 ieQ2I6QataAc/Q19kVlh8Dj2a3GTJ8CJxXJDb3yKYEjrFj2kfrziwOqa+JIfcPDV
 dX3Thg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e87ew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:04:06 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4ab4dd46ddeso863844b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142645; x=1789747445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xP2XfQ+/wetzxUMQ/VBD0ygw9qsKWMkl/ULfmMylxDY=;
 b=FzMxrZSEH9a8LlXOdKOXQixkV4lbIsD3QmXIR1y9R/QNIIVlMrC2Vu0ALtSCR+8txS
 GbBE9uHEi3hiSdGKBCzdMhE3dHxTXUwbGQm2H/d0bFAOJh+coHoQiervsP3RHrsLGHiB
 utopFC3noObcyQeFlzsuKa/PauN30D0szO2j8uO8R4i/U95/Dhxn5ShYm5APl0fCgmME
 MmkzVDA/nX6pPVOjIAbd1CEfxQ0Qymhf+/X20Uv9eO23EvkOk5OpBiu2LuXpcY1SNF7o
 X0nPE+B7BrtPSejWp1ywLhzOuELjE09nUUGf18OqnE8/y0w4+JKGXIW/BLrFlIOobwjd
 Qg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142645; x=1789747445;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xP2XfQ+/wetzxUMQ/VBD0ygw9qsKWMkl/ULfmMylxDY=;
 b=Hbui+VFQaNtKhCYyuYWgPfo94w4qhVDJDJ083XjMlv+uzp1Z8mo3P9/BRSvzbnnAFj
 YILuNacu2tOQAFS2VspBqfJ4A9mw83Kul9qSmnesehkwe3Rp9sIlR5EGU2x/VmpDpmTJ
 f5wedGJ/wNP3TIlvojQFIzdApVSEuk22KzKxJbfE+GGADRhcyIj7kuXIbmxHo3y0/pPU
 VOLsYV22T5uFvoBufvbTRhTuIBzOy8SsKL+2H5PdJMHpZSCQ4mm9kV30JayOLbUb+MG9
 csUQBRrD8fve2ja08Cs1ghA+KxcLC6d7hBo+rPzyJ+i2IwfTgHUEreDMy1ysPq84imzo
 TIxA==
X-Gm-Message-State: AFuF++m8/VH5uQyu4pPiCl2uZBtXOvZxZTnlTUztc+AUBGdTY/gAp6j7
 QfCVhHqRSMtYVaEknFPNlXxdbns+rgoRnND3B8j7UnnKhNyx8pelTuHFTYE+VEaoGPKSurS7Ax8
 bKe/MNVR1q9qmVh7w1DvxodFyQTSfLa523+K5ay5M4SeptGWFrzaDEbONBBDPdR338Q==
X-Gm-Gg: AYBFou1vOo2+yrWw4nn0x81JYzmHT1U7TpQvYsMS06i8KVEyMIjii6GF30tzS8Kn0qZ
 sNuTgEQ21/wnGHqllNQeY9YcYj6NK3Z1a4+tW8F0DAJ7/18fgKqngot2fqicbE0uBzK6Me84UlL
 Sj31066PzLhCkJYgM4qAHFnM3fpFAZHK0lBw2U+Bw30hR6546axxp6FDBiJxT7e0o4BGkGop080
 wJSKRKjVkqeT2hZyk11HyVa4jSV8ItHrUnDRUeDMSkF5PXtT0zLGuMOAKa6byzNVQCf2j0MrVpW
 RmEMSK1ClXj35HpUcTumesRYCJll1283m68GER8sBfbmIJypKUfmaX9tKup+OF4Y1QEhYLrPoOz
 F83BD8Sq8W3mZVuuu8eJl7sSx1z3NZYShoSKqmTTf4dyqVzyj
X-Received: by 2002:a05:6808:6d8d:b0:4b2:b653:87ff with SMTP id
 5614622812f47-4c319043c68mr4143128b6e.7.1789142645441; 
 Fri, 11 Sep 2026 09:04:05 -0700 (PDT)
X-Received: by 2002:a05:6808:6d8d:b0:4b2:b653:87ff with SMTP id
 5614622812f47-4c319043c68mr4143069b6e.7.1789142644931; 
 Fri, 11 Sep 2026 09:04:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:04:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/10] tests/functional: cover v81 system registers
Date: Fri, 11 Sep 2026 09:03:06 -0700
Message-Id: <20260911160307.865892-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX8uXPWBg2TjRx
 kP4d1LjQ3ClXWyMjl/SrEGvo5jq/sHM5r7u/KJVs3kBFzj+igp2J/Z9azIBQV6lb6FMNlKw5I2b
 /WJNyfGf7sVj5NbFAsgP1aVRu0hXzVXt+0BDZHp83EaQOWHNjrB+KaSdHwRGeVg8a6x4GeraA77
 B5WgBSg/HGJlP1q+aZyCSjOEy2cDFRO0+jzX1vf6gsRzk8R/Y9TmPi3EPRtXktNSVHX2DmFJi0y
 Kl45ONMvyalAWIM5tVIx0ujw9TqRg4ONMkEVF8NnRGvJ0ilBUpMNAJoFZCQAZCz6YxCmuEbACo4
 TUVyq17Q9A5n4NfG4vpiOGwIl2D+b3NLrWOAbNMxMsz4oPhFk1gw+235i09NKbiDnOUqhIcs31S
 vGLOFzYgR6hizBRq03pUAlHSCThWFv0G92EyU2L0yHIepFp8yYmmc1wWcLnsZzqFn3msPkmljTJ
 vvg3JhyO8YugMWoN6yw==
X-Proofpoint-ORIG-GUID: KQ8_pJ5M5dBP0h41nAoxE7XwgdBBiILG
X-Proofpoint-GUID: KQ8_pJ5M5dBP0h41nAoxE7XwgdBBiILG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX4d+MkkfGy4zr
 +qQmJRFUFltr/AqzyQBdvqrNdsMWr4EqOxqnFZHYLhpZhTl7ABorHX/R7BFOPCM/No1AzskwgPb
 xsn05eayneYJVVvGJNzlho1YGniyYak=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa42676 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=woYTvO-ToS2AwZLC9vAA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110224
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgMjEgKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDVkN2NlNDg3
NDM2Li40MGY3NmUyNWFlNiAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNo
X3Rlc3RzLnB5CkBAIC0yNCw2ICsyNCwxMSBAQCBjbGFzcyBBcmNoVGVzdHNVYXJ0KFFlbXVTeXN0
ZW1UZXN0KToKICAgICAgICAgImRvd25sb2FkL3YwLjIuMTQvYXJjaF90ZXN0c191YXJ0LnRhci5n
eiIsCiAgICAgICAgICJjZTkzY2I5MGI5ZDc1N2MxOTQ2ZGZlOGZlNmFiY2VjODI5MmIwOGE2NjU0
NmFjNTFiMmRkNDg2NTBiMDVmYTkxIiwKICAgICApCisgICAgQVNTRVRfU0VNSUhPU1RJTkdfVEFS
QkFMTCA9IEFzc2V0KAorICAgICAgICAiaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUt
aGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzLyIKKyAgICAgICAgImRvd25sb2FkL3YwLjIuOS9hcmNo
X3Rlc3RzX3NlbWlob3N0aW5nLnRhci5neiIsCisgICAgICAgICJmMGNlNzMxZGM4ZGMyYjg2MTc5
MmI4YmQ2MDgwOGNiNzE0ZmQxOTIyYzBkYzc5M2FmNjUwOTBjMGJhNTI1YmIwIiwKKyAgICApCiAK
ICAgICBkZWYgcnVuX3VhcnRfdGVzdChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKICAgICAgICAgICAg
ICAgICAgICAgICBtYWNoaW5lOiBzdHIgPSAidmlydCIpIC0+IE5vbmU6CkBAIC00MCw2ICs0NSwx
OCBAQCBkZWYgcnVuX3VhcnRfdGVzdChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKICAgICAgICAgc2Vs
Zi52bS5sYXVuY2goKQogICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgIlBB
U1MiKQogCisgICAgZGVmIHJ1bl9zZW1paG9zdGluZ190ZXN0KHNlbGYsIHRlc3RfbmFtZTogc3Ry
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYWNoaW5lOiBzdHIgPSAiVjgxUUFfMSIp
IC0+IE5vbmU6CisgICAgICAgIHNlbGYuc2V0X21hY2hpbmUobWFjaGluZSkKKyAgICAgICAgc2Vs
Zi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9TRU1JSE9TVElOR19UQVJCQUxMKQorICAgICAg
ICB0YXJnZXRfYmluID0gc2VsZi5zY3JhdGNoX2ZpbGUoJ2FyY2hfdGVzdHNfc2VtaWhvc3Rpbmdf
cGFja2FnZScsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnYmluJywg
dGVzdF9uYW1lKQorICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xlKHNlbWlob3N0aW5nPVRydWUp
CisgICAgICAgIHNlbGYuc2V0X3ZtX2FyZygiLWRpc3BsYXkiLCAibm9uZSIpCisgICAgICAgIHNl
bGYuc2V0X3ZtX2FyZygiLWtlcm5lbCIsIHRhcmdldF9iaW4pCisgICAgICAgIHNlbGYudm0ubGF1
bmNoKCkKKyAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsICJQQVNTIikKKwog
ICAgIGRlZiB0ZXN0X2V4Y2VwdGlvbnMoc2VsZikgLT4gTm9uZToKICAgICAgICAgIiIiVGVzdHMg
ZXhjZXB0aW9uIGRlbGl2ZXJ5IGZvciB0cmFwIGluc3RydWN0aW9ucywgcHJpdmlsZWdlCiAgICAg
ICAgIHZpb2xhdGlvbnMsIGFuZCB2ZXJpZmllcyBTU1IgY2F1c2UgY29kZXMgYW5kIEVMUiB2YWx1
ZXMuCkBAIC03OCw2ICs5NSwxMCBAQCBkZWYgdGVzdF9zeXNfcmVncyhzZWxmKSAtPiBOb25lOgog
ICAgICAgICAiIiJUZXN0cyBzeXN0ZW0gcmVnaXN0ZXJzLiIiIgogICAgICAgICBzZWxmLnJ1bl91
YXJ0X3Rlc3QoInRlc3Rfc3lzX3JlZ3MiKQogCisgICAgZGVmIHRlc3Rfc3lzX3JlZ3NfdjgxKHNl
bGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIFY4MS1zcGVjaWZpYyBzeXN0ZW0gcmVnaXN0
ZXIgbWFza3MuIiIiCisgICAgICAgIHNlbGYucnVuX3NlbWlob3N0aW5nX3Rlc3QoInRlc3Rfc3lz
X3JlZ3MiKQorCiAgICAgZGVmIHRlc3RfdGhyZWFkcyhzZWxmKSAtPiBOb25lOgogICAgICAgICAi
IiJUZXN0cyBoYXJkd2FyZSB0aHJlYWQgbWFuYWdlbWVudDogc3RhcnQvc3RvcCwgTU9ERUNUTCBz
dGF0ZSwKICAgICAgICAgcGVyLXRocmVhZCBIVElELCBzaGFyZWQgbWVtb3J5LCB3YWl0L3Jlc3Vt
ZSwgU1RJRCBwcmlvcml0eSwgYW5kCi0tIAoyLjM0LjEKCg==

