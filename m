Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB63AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39b-0001fD-P1; Sun, 28 Jun 2026 23:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39W-0001eA-DO
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39U-0006Fe-Qo
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d4JN1519170
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=BKqZOQju0mdlbtaF
 OjmjQ/nljFg5PIxgSvdEx3VXsbx9eGcNJesjKSEpvH5PoHYMG3TdcCSz5dNV7bkN
 05qh6s3HwHpoA2e3v5AJr52A/3Y+Y+uQ5tMZ51X3MAhyZ/cYNCojOgK+TiiSJrhg
 SIxiXwabHb7Zyl5yJRceOECDCuAaIS8xipu5DvsVGE3ALqFSvUMGYaE4uKK6gNjf
 wvbzPPv+hiqfT0bCN/CyC/sPDOASgo8MWMVDsmHseaprX0QwmIZaSmFnFKhxE69/
 2c91M/PObWaBHlqtX7747IAfj1pp0tV4Ahf+GaWWuIW5p6g96pea5xJ/vq8NVagp
 B5VC6A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734cdda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139c6673856so4500332c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705549; x=1783310349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=fTrxQihNigrSyl7KVXFhmMlJZsPiae3gwdqCJQwNaXoJ8RkDO4SBW7onkDNygfdxZ6
 1H/AKHPEGKlNgVf7KkpyLHnIjAcgo0sYHGPnwGBJtFb+vU/1qTXKG4u80XkIJOAyoOVq
 CFnOgujjRA+X/ZXgLtOidjv/zpWykmtk9VDq6u66sJs76vOsfNlvtAxdxaX8acRTkfxM
 CNCyJWpWr/55UPIDz0N2xrFZDnl/1MbpLhTmkDgPmCKCu+hQUFvn1SgEMa6jYcDH48Eu
 he511aPK2YtKsEFtk4W6N8fkaOsnAWSiTRfVJoIooEer5vSOl27qDl8oy4iaJAnwb6IX
 B1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705549; x=1783310349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=K8V+lJAGGNjoZirNbRBhc6Ha2Erb9WUjHbZwQzh8j1y/uSCu1ML9TEx2QpAyrshnBf
 F58cAkKoeRO/I0bwPLR90d0X9RttqEkt7aQGr7XJwxe1Xbsj/u2n4NXLOF4znbNiRcjH
 MhXEj6W1wpQyQImqGV1uPux4Rvt79B8BqJ9NZiTEajotgVWc5ipJ79e9mzPh0jNfeVnA
 xdrhpuc+Ble7nL/LbRqDgLS4BbxIVdWhrGoNNj2twCIwoNqhXBwBNKoNDtxmO3VVkdob
 pjTSaavxIcpWzsKj0PcO6Ccg7bQUW+3vQ4rJFGKDmC39T1ISfX4x0BIv158317bXcB8A
 HM/w==
X-Gm-Message-State: AOJu0YxRSfXmHRiqRGcSlESxsqZzNpp4cI5beHpMaH9xaagcAkFGECTX
 RKt0ieEgCOgl05QIIHq3nlr8kBm0YOtZL0k4qUF0Ag1Ow6GTUe8vEvEYqQfAjiuGgEZZQUvEhYB
 DoRcrQkHeCw4MlykB8X0OP1hfhH7jfHbLosLK/AtzlV5qtdbqflpgfGtE9TkQksqyAA==
X-Gm-Gg: AfdE7ck/SoHFKEsu0DQtrhuWnnniRrZpV7SYRn3eeMfvbfdN3ECa3Ztp9fwk8IPHdUL
 b0WMo6KfnvcpK1syeUnGJsEA0aA8Ctsz162rZInC6JV0fQhBOg4m66Sp8EDGdZX8RneIFwt4sKn
 mEczyD8G3cgbS1lQ0WR1XrQaZpVMClhdECmfz8OM3HQxrUF+Cs+YEBWM9FC346B8FLWr47FyVZI
 yNC5KxMOiVExW+IAepNas+Vzw/viOFza0WWYzCW8kG6C3mt39xJZ/1nPp3Dod2iKPj/tYlL7o54
 uoa4YwF39M5WQ+PAXrvQebOVXY7lcJ2U93Kv6CTHOHxkqjRmeHBsryy7s1AtFCOesLudbGkUenA
 b+3OHGIi0PhPoo2DVN02A7VMfN5fYDLs+KfwOXdVG81oqjUDgtAuFhN6txjY=
X-Received: by 2002:a05:7022:6b94:b0:139:f3cd:22b8 with SMTP id
 a92af1059eb24-139f3cd2609mr4579138c88.49.1782705548966; 
 Sun, 28 Jun 2026 20:59:08 -0700 (PDT)
X-Received: by 2002:a05:7022:6b94:b0:139:f3cd:22b8 with SMTP id
 a92af1059eb24-139f3cd2609mr4579122c88.49.1782705548481; 
 Sun, 28 Jun 2026 20:59:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 17/77] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Sun, 28 Jun 2026 20:57:30 -0700
Message-Id: <20260629035830.1520296-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 99KkIBdSSrBLNgVAS0CRTweClEKSBsAz
X-Proofpoint-ORIG-GUID: 99KkIBdSSrBLNgVAS0CRTweClEKSBsAz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXz2MNCKnOJkQX
 1tZ8JGINn6/LS6qOblp1KFe51G4RULpBbkgV9yGO1h5JIcI8suk+8byzch9OjMoJYuzox+/Lte7
 UWPnZ5r0mlRWuusesObixKURjhTN1Z8=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a41ed8d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX+LKVJXIIF+a9
 SEh21TWOKIHn9RWXek883XwIgcEpGBZwBtbE6He34oUnBnJ/5zKFG4LMFYKvINI1kwN1WghxVEV
 D7voT/2KBLm779LbllING5o+Kzs1O5eUznv4JhKvi13OVA/dPJjeJgoMjP83NMvcVrlgaNOscxz
 7Rjf8NxzgBVQkxw9c3Gtqfe7XEz2pFUrGpHI3Vv8wvDWxZMUKpoNnN5JPUtm8JIDGlx6U04UPdg
 hToXmhL7ZQojI9zY3Yt/EvF5sRcU4rO5eoUOI5w6LscoHq6IC8X7PcA+34MAF+BktIN7V61PsD1
 X8nNGj69uhl02CrR7UTKfVtmfuzrKUdVIBpzH5zhstVX+N8z+E85zwPPcjYtxEU+eQlxSXV5hNf
 8IV2vpnTV4Okd3/BCe2AnEH+DKN7q6JyxfGWkAWkKMfTI9qzGMtftdx24NzfixHb4JLoy4rGHEv
 YIv67hqT9IFk2uu885Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZDhlZWE1NjE5
MWQuLjU3NzY3YWNmMDAyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDEsNiArNDEsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODEsNiArODksMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
bCBpc19nYXRoZXJfc3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCk7CiAKKyNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQorc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdf
RzMpOworICAgIGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICBj
dHgtPmdyZWdfbG9nX2lkeCsrOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVn
X3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQoreworICAgIGFzc2VydCgh
KHJudW0gJSAyKSk7CisgICAgY3R4X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4
X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSArIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQg
Y3R4X2xvZ19zcmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBj
dHgtPnNyZWdfbG9nW2N0eC0+c3JlZ19sb2dfaWR4XSA9IHJudW07CisgICAgY3R4LT5zcmVnX2xv
Z19pZHgrKzsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZV9wYWly
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUo
Y3R4LCBybnVtKTsKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtICsgMSk7Cit9Cisj
ZW5kaWYKKwogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0pCiB7CiAgICAgaWYgKCF0ZXN0X2JpdChwbnVtLCBjdHgtPnByZWdz
X3dyaXR0ZW4pKSB7Ci0tIAoyLjM0LjEKCg==

