Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D77C88E79
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68yW-0003Ht-C6; Mon, 14 Sep 2026 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x68yI-00034Q-56
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:51:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x68yE-0003Cb-5F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:51:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0KhP4090474
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CCJBLjUSxWNoEqq90BDvaDZbICdK1NjUxSbNQgTZoSY=; b=kc7+/EPAh4JB7PpU
 SgqCKJxUfb8c49pmCqdBbV8dCpNjRbgtv2EkAWJjAk5QnzefNG/XmTkbSJ+MyFTy
 z69L0+xrnnwBdtjdKCBlUqGta8pqieGWDY4op2hEbs5NYqYoC6HxwgliBmRFC7Md
 hYHjFAXG6HnIcrIutG79Awk887rLrqYW78fgw3QITj9dEam2Wm/VioHyQX8zX24g
 EgzFHaBqU1bLQ3lW/dPE2gv9O38WTYBH7YhQfCI84DJrX4MV03W0qWNKGBFKKNAl
 4bUOD6Eh4gCuSkxZA4i91QWM9lwqxeYE4M9IoZp76HNQTxijGeB84lB7gEf/kHcd
 /s8J9w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg1yqw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:51:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso4599229a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401108; x=1790005908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CCJBLjUSxWNoEqq90BDvaDZbICdK1NjUxSbNQgTZoSY=;
 b=Yf9v7EFaQ/GFymTjNgXVi9ZKLNhla9/Jr0dNNCCeVc8H+2ix6dV7sEuRcw+avXZm/j
 oG4Yq+4+3gic7leyxZQQEHrUtyS3wHKmdGu+vbsugQsUuL25U3t7ccEesHmsLDb6AFTz
 HSz4rbLrInuTzbHCMqnLMsKvkTIIWB2kSMKrxrCcRPTQWHHTjSEFShhGbI6kpZ5G1Mgt
 2Ko5fz8Wh3BwWdHFossHRfetvnn6zNgypQSbiShc5gOPYjrbIgoWAXcOCGkYFu7xM7C3
 SzabxOuU9dP8d3dn3KEScEdjVJLGGYDl1Ljma3Sd1ziz4fTgyxNVKPt+60r+7OKlpn2h
 EU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401108; x=1790005908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCJBLjUSxWNoEqq90BDvaDZbICdK1NjUxSbNQgTZoSY=;
 b=U1nppYWNeoSQITZjuQHPopDHpUjMH0RJs2mpZLC2Goh3gYig+A+A6yJpxSBDeUVSKz
 ioRjKLlSg99OWM0zITTNaCNRoRwooWio/4nQH/L3GeB6IPS22BJ90FWLWCTrYaLP9EcS
 DeoPZmamk4h4mj2vegmGnAwktBjxeQXCh1YrDuXPvQccsdOxcHUHuiAq9aaKHu9HhLKI
 ZZRh5s+LTg4MWb85DbpMj30XMdRBvu/Yb5yPQ1JV8I/ez7LIW2s+42OB4MC63a6Y6YaZ
 cmEY2O1S4v06zKSrNxQ5gEy/fSrxCo9ucNbDGOYU14HwOBlvhbBdLEfwswbZLUYrb0Ww
 23IQ==
X-Gm-Message-State: AFuF++mrZ55Su1LFU8jhv8tHiSet5KM6iP512N3b+lwv4QmyQWUqBipy
 kpzFvYNP2AB6gEuwWvAc9etZo2ZR8Okn/GVJHvhqJVyywRfvT6lcpxC/lqpWA/ssaeMuw1aYfiw
 5xe0ABWJrnLMo73uRwaHK53KDyBeJIZcveCglK55/rbC6hy+LEuG9zws3p0wZFJqTuA==
X-Gm-Gg: AYBFou2u6Ex7gItfkeqZ8/kw4APi2873eCMBOhCl7YvfYxk6vFOmM2tZr89yXR7I9lP
 P/jZZe1Fr9V9B651fbtqUm0Frk4dwkObOxMF54KSjvC0/qeqsqD81qKIc3d3EbzAoerkIYoPEPk
 yNBkjHIrOLH8AVJKuHnBQxM3R898Lv2UiMOcif3ZuCp+PshxZQ+G2K2xISpQ06YLFY50gGn/5GF
 AJYY+jMFSoKSuIESZBB/+qKVrJwRe2yoyv659GwbPP8XcKMNWKt3LZyp8PWKENsvwn0YcWKCWt8
 yaM0thRM0JFAqviVMmnuXxUIUCgnBuRAsSsjorXHRFt705UOrVGgDaxGwFy+OEwHYHwLkkfPoj4
 OZZ3ZHjrMGqLepnjo1uTvFj/FaRhXwmcTIgi9HGPgJvfS17sC
X-Received: by 2002:a17:902:ce0a:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2dd6c5ef145mr69569705ad.8.1789401107823; 
 Mon, 14 Sep 2026 08:51:47 -0700 (PDT)
X-Received: by 2002:a17:902:ce0a:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2dd6c5ef145mr69568865ad.8.1789401107273; 
 Mon, 14 Sep 2026 08:51:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfcefb6sm51824605ad.56.2026.09.14.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:51:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, marco.liebel@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 6/6] tests/functional/hexagon: add HVX tests
Date: Mon, 14 Sep 2026 08:51:34 -0700
Message-Id: <20260914155134.2191912-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914155134.2191912-1-brian.cain@oss.qualcomm.com>
References: <20260914155134.2191912-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa81814 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=eq6FigJt9aAjue5lDr8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: nmQDQX6ik7IAkoNggUYJNW2ZM1_7CrHQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX0mSJy7G3bdbY
 WdxbEXQdy6frUWqLJM/eHUskog4AmzF8L3wxB21xDFOu5D2W0p0hju84+rZRzbjnodWHucJD6VT
 3A8ahbSDjlyT3F7gfNyOlZCGOCxHCQ0=
X-Proofpoint-GUID: nmQDQX6ik7IAkoNggUYJNW2ZM1_7CrHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX6+02fZOAIJ6V
 90VKYxjgcFnoKdJV6+rmKmIqLWXzpDVfiXkoS7rc13RAXRDpIvTHUe0qoIYZ6WNc7cKIRoTtN3F
 v/J/xdtKgJLq0X1VG9crYrRLJg7DhlsBHfY9543Dp5VkXk1pBXIAzw18yyL7x/eNaMg73b7VQXv
 fR/6LSIkcxhyVLeqXEmT1axbq10Qf8eOjTpeyHmmWaaoaZh/2PP/6xZxHQJwHr4AVPLgR3lFwYz
 6cu38vMYFZAXTOvZ9BiTWJAfcsMUhp0s38dhplvHyILjbabxQIEbQa1GWQrFv0xSRqk5zoFQKrl
 3DOpxroqU7TUDfGKdx069NCacDiAxh05zq3rymMYrOb9Hz8Iw9qteq/+NHfYyRvY5Nm7FyvR10B
 s4r+BDF4m1+RoN5aEPPd5krONqomfLrLlTzm+P1JXplBxnKnlsm7z3e4YBHSLPKhwl3m5e+M4RZ
 v5WVnacZYVytlDxjaEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140226
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

VGhlc2UgdGVzdHMgcGFzcyBub3cgdGhhdCBIVlggaXMgbW9kZWxlZCBmb3Igc3lzdGVtIGVtdWxh
dGlvbi4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwg
NyArKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSAgIHwg
NiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDQwZjc2ZTI1YWU2Li4yOGJm
MmYwMmQzOSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5
CkBAIC0xMTksNiArMTE5LDEzIEBAIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAtPiBOb25lOgog
ICAgICAgICAiIiIKICAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3VzZXJfbW9kZSIp
CiAKKyAgICBkZWYgdGVzdF9odnhfY29udGV4dChzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJU
ZXN0cyB0aGUgSFZYIGNvcHJvY2Vzc29yIGNvbnRleHQ6IFNTUiBYQSBjb250ZXh0IHNlbGVjdGlv
bgorICAgICAgICBhbmQgaXNvbGF0aW9uLCB2c3BsYXQvc3RvcmUsIGFuZCB0aGUgTk9fQ09QUk9D
X0VOQUJMRSBleGNlcHRpb24KKyAgICAgICAgcmFpc2VkIHdoZW4gU1NSOlhFIGlzIGNsZWFyLgor
ICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2h2eF9jb250ZXh0
IikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0Lm1h
aW4oKQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMu
cHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQppbmRleCAyNzc5
ZWZhOTE3Mi4uYzgxMzdhNzE3MTMgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5
c3Rlc3RzLnB5CkBAIC05OSw1ICs5OSwxMSBAQCBkZWYgdGVzdF9tbXVfbXVsdGlfdGxiKHNlbGYp
OgogICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKICAgICAgICAgc2VsZi5ydW5fZXhpdF96
ZXJvKCJ0aW1lcl9yZWciKQogCisgICAgZGVmIHRlc3RfaHZ4X211bHRpKHNlbGYpOgorICAgICAg
ICBzZWxmLnJ1bl9leGl0X3plcm8oImh2eC1tdWx0aSIpCisKKyAgICBkZWYgdGVzdF9zdGFuZGFs
b25lX3ZlYyhzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzdGFuZGFsb25lX3Zl
YyIpCisKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3RlbVRlc3QubWFp
bigpCi0tIAoyLjM0LjEKCg==

