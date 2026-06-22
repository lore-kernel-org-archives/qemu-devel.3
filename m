Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B23ECDB479
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9W-0003aH-GU; Mon, 22 Jun 2026 18:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9M-0003QH-O2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9L-0006WH-3G
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJarW42177096
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=; b=Q1
 vDxk71yO87qaPTjuqL8EHabl+C6g2JNcAI3zotXFG2Jkw/ixAwH+B13M2GWAqRnr
 O8TCmSDg8LMhI6y2Gga/9AhwU62M9PJ227w9j49kbdaVHQ+cplb3rJeCF6X8fMQv
 7fulkhRda/IbqW7nVPN4C12D89RdPk6c9I6eY3Mqu9AUG4UpTva18ikKZE2he0eb
 fxeuNw7H99oCbmT5Tm3aHhS1M/lKOoHpgpZ3cpkTJXJG5MK5kq7TZe8U3coJAVUj
 8psmMXZGhy6VD1hGytc7SvrceCbs/Az+cAwpuohyIMde670YFYpuWbIP0GGQK185
 j165RPZyF1OHw0+jhZLA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hahct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:40 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-138acbc0e69so18058249c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167379; x=1782772179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=VweXXIgdIuZz0ls8ndrbuY0rzvW7rOxL3B+k6KKlZWrhx5JEZtPDLvn9BjbcdjHcWa
 MRKHmjWVeX7lYF+4CAi/JUoM1ynrMROhBlvX+PI+faN7DaCINgxT7VgP1ogFA0tisauQ
 oKbysgcK+eeWgLExTAOrcV6RE7VM+gLsVbbBU2CiszxRlB7MnXC0p+g/z97vDyyLiPqz
 ggT4rSFvBUnWs9qNXfAR8DpinC6PXiLJBhfG6JY3TEkKShrE/1XEtqAxFrmsH4rlNoQo
 RIzcAqeZb16soorSr7VfukuBS6knUkYc51o2OpEM2HLSqRKzAVSt8rq2QTjNLGHc/8iR
 vuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167379; x=1782772179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=g8ZQQzezRKVh0LKDXvCrAE4+nHzNRM4MX4ezgq1gevyCVfWyHSWBrXn8CY9aMdpBAa
 jqju/crlUbIU85sP/QjHDVhbBuiu1tvI3Y4ndBfT00padCGrKzBkF0sDc8AKYV1VS78a
 SLfzFEoH6EDC7jVFfPOsvGqDp0Gcw0bfIpUeJZI6heujYXjX3/TNuVp3ryJgN5MZJ4D8
 949HW0kjGTro2KQ2tKi/kPNk4QGxDmLB0neY42PDruXHOW3CxBBkGg3bWhjEhu5s2/3K
 OIPlVTj7MKKePxScgq5ALK3/KAmK07baiYban13yRs761Wj+rC50Ub8YGXxwiUO8vwKJ
 Q+lA==
X-Gm-Message-State: AOJu0YyqalAR32Lmq4XrPWUAGRivBkAxZMrxl7o6PN2NcKczAovfuQ/n
 O4lveZDn0KttRmbgfR1Lev2P3EnqngybEHaXwxUoqZtzIgjgF2fXWASg9uTzxwzZ4+VyXQ/EzcP
 tpEzWfox5FM/VKyiCFkH6kcLKSnJcDbiHHZ4kKx8Xvv9h3gxn3ysqqV27taz9ut6DPA==
X-Gm-Gg: AfdE7ckWAO7uZ68AJAZL+R55InpXKLVMM1dxT5pM8B+C94CUU/ivRnREWn50UjBSZGv
 ySS7nm3tvQvnwD2Dtvrvf710tpKHbXEKmErijTn1+k6uoOB8B98jKtPYexxE9K7or5BWOLRBB/s
 DKIVy6EcnNsqs0acfeq+VMzklQBYED72BMFRJ68HphpkFJE2uns9Rac5qLxcCl5pRgiuRA3Gd9H
 YbCIrpqkt4SXrvW2iS5sBn2vh8V/1Y+YeSuYxbs9PR/T2W3qAdCLDGzrH90yjouZ/CX/Uu8vMCV
 y5K1/egXN6gzNddBa6nbg1A2ZMbrbMNmE4taemEKekNHN8LmZhi60dexvIa0oaZk865m1sWiwWN
 OOMwiv6dRIqYPp5GcdIS0GakFMt+mxvXiIIRtvfwr7KHLWR5Rs6Wq9PdCQKw=
X-Received: by 2002:a05:7301:e29:b0:304:d8cb:841a with SMTP id
 5a478bee46e88-30c1d9c94fcmr7565084eec.14.1782167379060; 
 Mon, 22 Jun 2026 15:29:39 -0700 (PDT)
X-Received: by 2002:a05:7301:e29:b0:304:d8cb:841a with SMTP id
 5a478bee46e88-30c1d9c94fcmr7565073eec.14.1782167378512; 
 Mon, 22 Jun 2026 15:29:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 19/75] target/hexagon: Add vmstate representation
Date: Mon, 22 Jun 2026 15:28:08 -0700
Message-Id: <20260622222904.607771-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 8rBc5twVOisa8JQnJBUijlPxJayrdtqR
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39b754 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX81m/VQrb5ZVI
 kwmeiGKsUXXhIZhQZxL1apabdbXD3CJovJXBmlct9w6ETr2KpXqhIvx6CDGsSrMnT2xjFZO5KxB
 tVEFDZ2eV8jwC+XvLqU1+lBW2j0BjJ4=
X-Proofpoint-GUID: 8rBc5twVOisa8JQnJBUijlPxJayrdtqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX2rDs31gHha9P
 AWc/JlgNdmXqJNow+rqEZ6e2IS5S12SBg6vcQLEgz0doHT6GDg8wLQLgsn9vlGi8uwCCDq1zN8V
 M/l4Oel28swccawWFHogaiHmnzxLU1GFULz0wvLRTDavt1VrmuCT9U6rAB7m7A++7gY1V8qrMsN
 ahhJwkr/DadrZZUGyApqUZfs7a1F6p8dfZF3OdicSprahs0ZZSM7hA5Pck+HeJ0/PKxmCPwj8O6
 hJymam4/9swCoFcNt9PP9lmkt8p+O4VsUhadau8QzzzI+3QzXWf5tY/5+F+g2d3ZnpUJJrv86r6
 psiGQJv+OtUY8p3g0T5OUie8HKt78wPeWMHkgBJJbMy5mE02dIRxkz3R2PDn5/4Qa1og+uTaQpG
 yNTbI1F2cvGEkgahDjpgPP/ztnV8k7Z8AEldMT6dhD/XVWrbdhiTiY9fKWyH3neV9f/rVVNrRR5
 5TVVLgg84+7u/AI1Z3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAgMyAr
KysKIHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYyAgfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKaW5kZXggNWZjODM3
YWUyMjkuLmNkMDZmZjQxZDRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKQEAgLTMxLDQgKzMxLDggQEAgdm9pZCBo
ZXhhZ29uX2RlYnVnKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX3JlZ25hbWVzW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAKKyNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hleGFnb25fY3B1OworI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBkMzBlNWI2NGVhYy4uMzA1
OTE5NmJjYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0zODIsNiArMzgyLDkgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBjYy0+Z2Ri
X3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVlOwogICAgIGNjLT5nZGJfY29yZV94bWxfZmls
ZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8gPSBoZXhhZ29u
X2NwdV9kaXNhc19zZXRfaW5mbzsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGRjLT52
bXNkID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CisjZW5kaWYKICAgICBjYy0+dGNnX29wcyA9ICZo
ZXhhZ29uX3RjZ19vcHM7CiB9CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY2hpbmUu
YyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMC4uMmRkOTU0NjZlN2QKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9tYWNoaW5lLmMKQEAgLTAsMCArMSwzMiBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgorI2luY2x1ZGUg
ImNwdS5oIgorCitjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9
IHsKKyAgICAubmFtZSA9ICJjcHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11
bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7
CisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5ncHIsIEhleGFnb25DUFUsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5wcmVk
LCBIZXhhZ29uQ1BVLCBOVU1fUFJFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShl
bnYudF9zcmVnLCBIZXhhZ29uQ1BVLCBOVU1fU1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Ml9BUlJBWShlbnYuZ3JlZywgSGV4YWdvbkNQVSwgTlVNX0dSRUdTKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoZW52Lm5leHRfUEMsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYudGxiX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYuazBfbG9ja19zdGF0ZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi50bGJfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi5rMF9sb2NrX2NvdW50LCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIo
ZW52LnRocmVhZElkLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmNh
dXNlX2NvZGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYud2FpdF9u
ZXh0X3BjLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVf
Y291bnQsIEhleGFnb25DUFUpLAorCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAg
IH0sCit9OwotLSAKMi4zNC4xCgo=

