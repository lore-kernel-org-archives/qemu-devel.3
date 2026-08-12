Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DB8C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6s-0004Vf-VQ; Wed, 12 Aug 2026 11:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6a-0004MQ-IX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6X-0000Gy-Pn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbpGu3641792
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c3ei3+/hHlU0bMY6tZtgWn0p5b5F3IfPfKvcDB+LhSc=; b=oVFdpc/wNMYHI5wx
 TQ+IO2nJ3XXro50UNcQ+wlfUymcDRtfkDY6m/lsJaq6GGajq3TjrW3QQuMjQkpno
 qEjBfv7fv9GSPdXUC/MQuOjfZ1bLOcdqCajRJlvJbTPKM64GwhTpnaFJ3UnDNKde
 3JJizgDDp1MgGqXVoNSJUq59niStBIPXNM7Y6Uzyt7ruySZf9m/im/yTyMcoDZg5
 Ecpt4hIZoLwl1Y2mQUjaQxGs3G0zfFveL8Di2jJ3AMKArHkWA4llQ8bI5NwZkKwI
 AnMDl3I8VKDvReNPQX/idx75jtJVGd6KR1vL3AwDwmMZ0EPt0U5OeIC1DjJg3wFW
 Vy0t7g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d1p3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so8632a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549376; x=1787154176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c3ei3+/hHlU0bMY6tZtgWn0p5b5F3IfPfKvcDB+LhSc=;
 b=JAcN+A0d0OPGvP1T14p3VGU6TxsbSAv+hZhLlT22PVnm6S/ExAaXxxBnMxwGHO5AO0
 tv5NAntKq92eo05f6XJAUBbxZquJJUJCiAes4aibVzRCRQZgpRw4EPG9aXSeW+9svouo
 xyUcJZje1Isncf64VSo+3y8d5JSzmZoG38l2Ql+K5yfMZ5j8leOHAqloIz1+FGViqMVi
 KelCyfIIRKw+hWC7AXUmnCZCfG922okTh2V8lw8a3mJBepp2tLkKvlVRhNk4IC2N6T0N
 tCGtMoEZ3cj6111XEufN7WWfEpv8VjG8MlTpOX/S7BamEy8uc5sx//5Sh8WDXHN4OYVC
 vyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549376; x=1787154176;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c3ei3+/hHlU0bMY6tZtgWn0p5b5F3IfPfKvcDB+LhSc=;
 b=eFShQzklM8HcxH7UOE1mvEKyxS5OfSuPA/nRlZM3W9G1gKPAT1uiBGgj+eKfCs/n3v
 heQclopm0P/RizeAvF5LmsnF9FzGJSfyMs5pl1ZnWKToXzuvJH1IsoyinelB7pSyqu88
 jZlN6i4au7Wvw7Dy74qZ8McGU0NqxeyEnC3YadgAKoYf8KiO+091jjbw3UTZ/xoZnzNH
 lz2ISqjQr2u2TlYya9h8wfD9THVJKz21UJ1SxkUXwtGEN/t+SXTCyHl7VjGk3zSpvOeX
 eFxUbShEXqi/brNIPVXQq9j+SSNZLU3KUC87HnI9wPlYOHvtp7JY5WqCRVVHZ5/XOcs2
 dzhQ==
X-Gm-Message-State: AOJu0Yxa7U8C7APIahFkP9UCd6aM1c35JMBXresnofP2d/e+NSBPHQ10
 Maba8XziNoyiceKT4l3XdNDlPHMHYXoLvbw5XlwfgV/aH5HYLU4NCaGsmuxBKYiMWOcBZy5J9jq
 GstyyXO1MHzWKcY970iHu+GCf+PAoLyAnMWG5GNYsim81z/sxzpSc+6Ax5a810SvxnQ==
X-Gm-Gg: AR+sD10OS5yBsRrojIUzvEYFSwJHaSdUg5ycOYG4+oVqW5YYPsqewFf/s/T2sKfTIBD
 Xrjdm2qBmu66LIyc6+TZLldpClxuOGxnLJcd+mWdvNuVlwbpsUHit48WkUgSqzGUtPltG4lydRW
 BtCxAoKm9SPJkoR1BFhI5qMvZ9StN2RaQdRL9nNBqoXFFwIHhZkheaImpV/0ppbrxgY3+i/qZSU
 KfgkSFfPFO+louizm8ZPIWT/WdAPZTPF4e0FPOPGIO7kBOFP4vJGPly1Xwy57VYQoUcuWgPqcfb
 LVUmoH7/A+1SinzFyzVyOYzBqQ2ziiwp0qKd7B4tt63r3ObHmXOPA41ZdnCQ/HcGjvT2PKufn+/
 xk7AtjY30IWQpsIdZud1GwgmOtbbu5QhAWsbQpdN/B56ImcKY
X-Received: by 2002:a17:90b:1d02:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-39319945306mr57612a91.10.1786549375722; 
 Wed, 12 Aug 2026 08:42:55 -0700 (PDT)
X-Received: by 2002:a17:90b:1d02:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-39319945306mr57570a91.10.1786549375191; 
 Wed, 12 Aug 2026 08:42:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 11/41] hw/hexagon/virt: add l2vic interrupt-controller and
 virtio-mmio FDT nodes
Date: Wed, 12 Aug 2026 08:41:50 -0700
Message-Id: <20260812154220.1029828-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: wDavqHNgHLZJOtak15J76v1-seIRdbQm
X-Proofpoint-GUID: wDavqHNgHLZJOtak15J76v1-seIRdbQm
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c9480 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8iJe-459VSUS_SUazGUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXwkY3UGoKZfI0
 NUCIkz5kfcXlSG72CnpO+AbDYElz+AQ3/914bTlGynHpEz/h4iCKE1mrPnIBI474319NZg9hPYV
 4tyZMzmuCvUWkokD02ywWkItGr6/c/cp9rAiBVt43Pnui9UeiZ+tSuCkZqw28q9mpGSEbhRlCQl
 JM24QDIUaOXQHCL0IQk7qHdP9ZzHUDvzCRIgtodKlFirq0S0GlFTfgIEV5E7PKRq2r13/DIxYCE
 ud69x9QMQaipG1vuwDGAp3K4RHVkwW/vwVq1UnqguGrqKaRY4JmyhsjgTylUlxe+2aHNK46a6k6
 cRRGnZzq5WUJ/LhIfAW681mKBelmjwwuacVZvPWnmTM0o4SkPs9HqiVqs5Xz6dUhrfW9wOl7niF
 +QMhKdxGqd2SUWPgroXdwdoT/iI616u80iQI9mO+YNsIJa+A/UnO6YQrI0pFeee4MAjlf6tPCDK
 NHn/i3jo1k0WpWvyEPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXx5edsSh6ve9u
 sCXBu1x4SP/+K6ZL9ouK/xUdKKggQ26YuGnw8ImWD/NFn1eej45qQQHrnQYTGn+760Xo/W20q8c
 K4X3p63qiSIFUmwIMOhScbfnedbkMY8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

