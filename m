Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2E5109878D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bBp-0006Fp-Q2; Fri, 20 Mar 2026 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w3bBn-0006FI-4k
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:51:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w3bBl-0007KX-4U
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:51:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62KElucw989742
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CzV1xE5LP5frPMIb94o5a/qKxfcUAvsY4yhrqKF41vQ=; b=QeOpn2HKClPOgmNI
 qP6iAFAMDQrWvUON5YlLuJMUgAHwWAByLiz5xldXlYR9czZxZl5pITvcNmLyWgGe
 t9CX9aYTvE/HV7HRgyTqd4ccIVTvvUz0ySEizTuBRwODo3gsIy3Mx3U3JPQ1beBK
 UcEOmoDPMUA0bjMpZ61so8gUN0cAx7QLSPEtJFz7Tn09RtzsZQ+7laHPvdTKvShs
 9ZPN7BgBg2B7QbUKCNXB0Q4WaUV1XZdKW0FZZ18+bj+yNwjOXp7uru8J9UnXr15H
 0d59lcuFIB7zhqBxZUZfjemqOBKDwF0Kmtm/TvE2ZnxHE6L/5CUifSxmkJR2tSrX
 41XM8Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vbq0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:50:57 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-128ba70cc99so1344261c88.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774018256; x=1774623056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzV1xE5LP5frPMIb94o5a/qKxfcUAvsY4yhrqKF41vQ=;
 b=G+JNVKkGcrc2W5tEeXwWbDSuKLqFD9EamCN6sOMP5XIJomb1x1qtI1F9G40xNnPGIc
 zm4ZXsq34EXet1vi2c4YxhRvs7jZOnaYpQcFItQ70zIgwRX2da0/3eh0paoqZDEHucZw
 T6bQPzypWSRn5YwRhGX9OANSm6MFzs3R1dhdLCAPI+ZOatWtrOTqyTMzTvNrzdBLKAwm
 VjQ3ckxXhvJhBAe4DBZxruf2g0/F0FwzR6nlQ0RgmtowII2D/pzz33k0eHQ1C9ukS59Y
 vg0O+/wklSHRyMLmGNKFxj1gftE6ipUwR66rnaoPE3yzBcQymn8yDiz2Pvc7YA4TRZhN
 NgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774018256; x=1774623056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CzV1xE5LP5frPMIb94o5a/qKxfcUAvsY4yhrqKF41vQ=;
 b=Qd9lqF4yFwuVNFKLiZEx+0dmMe7D1rg2tRiYHsOFsY3rOtkXytGK7Zb5OmfdHHVJ1W
 0tnohM0su6StwoecZ234BKOdw95NeN0d440tVj2w9kgmzYsWGQAAE9NXepSdyj/sVlhD
 Vckyevh830WtbUF8ZNzkfdCo1hx/FNWHH2rjERCsr0J6z4vsAd+wiM5m+Uq7Iz/VgaK3
 0s+jLpflH5DRdouxz6OOGeoC4H3yCK0FOrDxzWnmqTbdCotpVXOADQzZRU1zOLMDl3jr
 0fsJ3r7cOVn0YdIL7+wDEUhXUG1r/sFSoY+ItK/sojrsSN9layLUuAx+n7km5aAC+Y0a
 k/ug==
X-Gm-Message-State: AOJu0YzHkDb6IFzRi8KLEAygb/xGuU2YI5jxhmfsVLSMgCTFvfu6O//f
 qZ53lUMDr4u45rH5TEBp1TDYYcfI8apinJU4amSszXsQUeFlqeIXzKiTH83qXUp7y/NBrDoawxf
 r8EFUgLjH/GY4YCcwOkx1f3XClPqliQe8ijTC8C3Pjlxi/GvKtPGIzcNL0AZbfGNpFw==
X-Gm-Gg: ATEYQzwFTuXJvSlp4skb5U/4tW1DJcrfiwGVjq8/YrmG5lFlf1vKBWZ+D202M7HCYKv
 5f7j04otEycmeheqLtKGYn4eLGwCvrYHtOqImwvvBvrmx6nJWYqfys1eugG4htpuiYaCyI2uJyF
 V8MT7wfzeM83U5Gl9Q51VrICLN0zuaz8BfkZSQLROwYdcTeaIrj2NCZVUaBoj9W+TrI2KRXDP7Q
 nmPTSGzH0G/0K9BJmhHY+H5xHJ1dg4dGrBxR5fr9B9OPx/w4qWsw1Rji0rfW+6RERTVUfikcdhe
 AmoqUBbQ9ZluGv64vbu/HJ3zftUAW5BJVkQTSjF2Lmj+FiGo28ihOF0C+EdBu5GFAuJwfy0B1Pf
 JYn8zRMTV28RkWX+kU+f9S8EVar0fWmLdislc1EzizGaM+Aqiyxx6YhdACNmNY+DzcJXycw==
X-Received: by 2002:a05:7022:45a1:b0:128:d375:f1d4 with SMTP id
 a92af1059eb24-12a726dad97mr1554321c88.28.1774018255936; 
 Fri, 20 Mar 2026 07:50:55 -0700 (PDT)
X-Received: by 2002:a05:7022:45a1:b0:128:d375:f1d4 with SMTP id
 a92af1059eb24-12a726dad97mr1554302c88.28.1774018255300; 
 Fri, 20 Mar 2026 07:50:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733e794esm2473061c88.6.2026.03.20.07.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:50:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Alexey Karyakin <akaryaki@qti.qualcomm.com>, 
 Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PULL 1/3] target/hexagon: fix J2_jumptnew/pt predicate check to use
 LSB
Date: Fri, 20 Mar 2026 07:50:39 -0700
Message-Id: <20260320145041.3027130-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320145041.3027130-1-brian.cain@oss.qualcomm.com>
References: <20260320145041.3027130-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Pdp96hTYxN3hZ1hBm6CBVBtBZkMo7MeN
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bd5ed1 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ivnBtVQm4APjhFw-y08A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: Pdp96hTYxN3hZ1hBm6CBVBtBZkMo7MeN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExOSBTYWx0ZWRfXzOlzPGkzAcNQ
 hwkR5dp7bFZS5RstY9duEa6BQ9UNYzeoV4Kf1Y1TWS99Jg9286qTj3F+v1UabSgmohciiml811u
 XXEbiSCRFujAd9xksHtMiXeKyCNizl1VUcPdbAZjX4W//Groc6OK32U65iRvDIXqF7aZsN05tmk
 dTlvxK6LV2LOqbEg/+6jPdhNaZpZifUSBuZFO/6NvTrwFotvVjnC1iDUwSb1kfIZHAFTHfgu1ze
 XEUjqa2F5jWTAirVW/pZ/5g1fLdI/A/gqtRALinTV+eEUcqkMcrZ70Kyxnmi+VDsJ5gNG41tTZT
 0RjZTzhE0g5srO0WFUvZfdAtCWMLZXRZV2LAhebHVmL7/FF7eQKWaxIRKu3PwYXmwaAOrZDeo0G
 WMFGCXnP2rHDKJw1JmQjsEufBMgKttADD5Vhg6OXHh18udwySwd/dpRdxgO6xHHaO8FpQUv1EvF
 +QLWW1zb+Rv8bDR/qtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SjJfanVtcHRuZXcgYW5kIEoyX2p1bXB0bmV3cHQgcGFzc2VkIHRoZSByYXcgcHJlZGljYXRlIHZh
bHVlIHRvCmdlbl9jb25kX2p1bXAoKSwgY2hlY2tpbmcgaWYgdGhlIGZ1bGwgOC1iaXQgdmFsdWUg
d2FzIG5vbi16ZXJvLgpSZWZlciB0byBQUk0gU2VjdGlvbiA2LjEuMiAicHJlZGljYXRlLWNvbnN1
bWluZyBpbnN0cnVjdGlvbnMgZXhhbWluZQpvbmx5IHRoZSBsZWFzdC1zaWduaWZpY2FudCBiaXQi
LgoKVGhpcyBpbmNvbnNpc3RlbmN5IGNhdXNlZCBpZiAocDAubmV3KSBqdW1wcyBhbmQgaWYgKHAw
Lm5ldykgbG9hZHMKd2l0aGluIHRoZSBzYW1lIHBhY2tldCB0byBkaXNhZ3JlZSB3aGVuIHRoZSBw
cmVkaWNhdGUgaGFkIHZhbHVlcwpvdGhlciB0aGFuIHRoZSBvbmVzIGdlbmVyYXRlZCBieSBwcmVk
aWNhdGUtZ2VuZXJhdGluZyBpbnN0cnVjdGlvbnMKKGUuZy4gMHg4MCBvciAweEFBIHdoZXJlIGJp
dCAwIGlzIGNsZWFyIGJ1dCB0aGUgdmFsdWUgaXMKbm9uLXplcm8pOiB0aGUganVtcCB3b3VsZCBi
ZSB0YWtlbiB3aGlsZSB0aGUgbG9hZHMgd2VyZSBza2lwcGVkLgoKRml4IGJ5IHJvdXRpbmcgYm90
aCBtYWNyb3MgdGhyb3VnaCBmR0VOX1RDR19jb25kX2p1bXB0KGZMU0JORVcoUHVOKSksCm1hdGNo
aW5nIHRoZSBwYXR0ZXJuIHVzZWQgYnkgZXZlcnkgb3RoZXIgcHJlZGljYXRlZCBqdW1wLgoKRGlz
Y292ZXJlZC1ieTogQWxleGV5IEthcnlha2luIDxha2FyeWFraUBxdGkucXVhbGNvbW0uY29tPgpS
ZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKaW5kZXggN2I5NmRhYjkxODUuLjQ1
Y2NkNTE4ODgzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZy5oCkBAIC05NTEsOSArOTUxLDkgQEAKICNkZWZpbmUgZkdFTl9U
Q0dfSjJfanVtcGZwdChTSE9SVENPREUpIFwKICAgICBmR0VOX1RDR19jb25kX2p1bXBmKGZMU0JP
TEQoUHVWKSkKICNkZWZpbmUgZkdFTl9UQ0dfSjJfanVtcHRuZXcoU0hPUlRDT0RFKSBcCi0gICAg
Z2VuX2NvbmRfanVtcChjdHgsIFRDR19DT05EX0VRLCBQdU4sIHJpVikKKyAgICBmR0VOX1RDR19j
b25kX2p1bXB0KGZMU0JORVcoUHVOKSkKICNkZWZpbmUgZkdFTl9UQ0dfSjJfanVtcHRuZXdwdChT
SE9SVENPREUpIFwKLSAgICBnZW5fY29uZF9qdW1wKGN0eCwgVENHX0NPTkRfRVEsIFB1TiwgcmlW
KQorICAgIGZHRU5fVENHX2NvbmRfanVtcHQoZkxTQk5FVyhQdU4pKQogI2RlZmluZSBmR0VOX1RD
R19KMl9qdW1wZm5ld3B0KFNIT1JUQ09ERSkgXAogICAgIGZHRU5fVENHX2NvbmRfanVtcGYoZkxT
Qk5FVyhQdU4pKQogI2RlZmluZSBmR0VOX1RDR19KMl9qdW1wZm5ldyhTSE9SVENPREUpIFwKLS0g
CjIuMzQuMQoK

