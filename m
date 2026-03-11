Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0757FD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa5-0001g1-OL; Tue, 10 Mar 2026 23:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa0-0001ei-3Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZy-0005ET-D6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3G0YS303893
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z8Us83zLUbX2M9VvBxeV8Cr0l/114WWLghqDSjaR9/A=; b=pkMjzO/OnP45BWbH
 FFbtmKgLDhhzFf+RSF6S9XQ9aDubH6rfUYC301I6EGXLGLitm6r7LEiLQhyTicwn
 5W6SKK6VfSkhM2VmmHzw6vpCtgEVHPVZafkZzSGcanlAWYAVFQdIdv6eBCxNWDaE
 P9EY+WCPSETN4kASOCK8NVOzH7We2u7Dw1s2KAaXdSMpug30Tv2bUqaRcAYqEDKE
 yugKMP62Hm3fIKK+KI+D6cZg8a9dtdabd8Cylgw6ZrD7+Id/BUwHW8P8Zmu/znfQ
 lFt+dQcEERL1iro9vCdGD5uqcIhIXQPasD8Tbx2jLjzAr+pLAugMcuAP43iVUDt6
 87j6iA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf3h39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:47 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d7536294fcso4614087a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200986; x=1773805786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8Us83zLUbX2M9VvBxeV8Cr0l/114WWLghqDSjaR9/A=;
 b=JLfGDF88oBM8o1Z9iBwcUv+NRG2ncKuKbPar/XblE33xtgiJkte9k3pSV8CmIyrJBT
 0U18eO3UG0cQ9r1z3Krp3xdymD69COgP+EOKm7Ric/OhJ2DX1aSKAbrsZzri0GNIF7wo
 6cECKMV42dNtgy29WbOP1Zl+zsI+v7iAB7FmzBkqqRpJUe8S3lWdLIZlfdo9WcjFDcg2
 hPfHtZ+DxR8aSmaAqBvs9hqEYkymzgubFuqHCO0MC36pql5n4wHcPeFxQhVfhDvZtPSE
 ELdiyJuamg3wZuxhLq38y7guNWzspwtPqmIAHXgqyGHmFmyqc/VHK+qqtbvTJOsVXEMx
 X4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200986; x=1773805786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8Us83zLUbX2M9VvBxeV8Cr0l/114WWLghqDSjaR9/A=;
 b=jW6MQGW7D3UWplE913YllUbK6JRX7NbmXFOa3f71RVrGlpadKRTFJKZX1t4by7CMG8
 o3hyvs3NqzHuUkBUrOAUFVzeu1LYFiDibGJF32+3rExPFps4JHxaKd+d+MMQee4r1YiY
 1otFOv6yaOfB+CAkEuUrGx6mYZUmYEPXokfgH60cHHfpqilfN5Jz1DxgYJ8z18BVBMaL
 t+lnEAqOFIs5ZUHfZWUbVBO7uVnmeOOPfL3yKu4td3UHRzImvN4W71PfLqEc5em9OVHy
 g53JzgFo/K8P6RwrWUsBYV+/h1fJa50E7diG6+bm/1A1eGImj9RjZ8qPmUNE0vpqZ13z
 o96g==
X-Gm-Message-State: AOJu0Yyv48AIGQ0k4Or7XEnrAjuKcyb9ncdRBlvMV502EimQCyOhWIMg
 3RsRPTWSlw1UpLEMrLA5bvvDcBjtjFrN3ieRuJSOwvJCw9iSSLphy6MgatWOMnCxyE9gjk0uTte
 kV3juJuqmEZTK8c+nxw8aQrkOM3oKD4r4iILBnfBMYrvvg2JQYCtGqdYt6Eai3suuDg==
X-Gm-Gg: ATEYQzw86ws8rky1wLRlvhGfR8KhW6WbkQGqt6Q2A+yqauBrJBCaexpRMrRzbPujZBY
 zfx/buSzWxq/rYDM2tQgClSRQcna/HM/3m+I3c/MKA4QxA8UJkSNF0RtCdodWa6h48NUqK/pWqs
 OOo61NDr1m6apfxBlpgQupqEbKg4YACDo6NN5P2nNzcyaE3YjQrFRuC/wp+CNYp1AWTBqzM3aQt
 8tsX7ANgDLC/PhboMuaT7uJPozkOvRBNX58tFyQz6IeETqt8wJ8kr2r7KpJylzc9poLU/6+lkKs
 X3ySsYU0SZHH9TAr04YDnGsrI8VjAmQcDz9Jh+RTYMyx8z6l98Fj58dgL5Hf4QIl2UOtbuUo6hn
 J0R5sRs9VBOk1ZuPHsaspkGyDLabhMJrf1vfJOh78Cu8zTHtV8unbcKO9lrVTneUhdCHgVg==
X-Received: by 2002:a05:6830:8290:b0:7cf:cd27:57b9 with SMTP id
 46e09a7af769-7d76afa8c52mr812897a34.1.1773200986111; 
 Tue, 10 Mar 2026 20:49:46 -0700 (PDT)
X-Received: by 2002:a05:6830:8290:b0:7cf:cd27:57b9 with SMTP id
 46e09a7af769-7d76afa8c52mr812884a34.1.1773200985826; 
 Tue, 10 Mar 2026 20:49:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 14/35] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Tue, 10 Mar 2026 20:49:02 -0700
Message-Id: <20260311034923.1044737-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: o5bOxdCr3fOneFuvVJGjOtr9q9HxUGRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXx/O2th7qCc58
 6XZj6Irive7m6znEMzXw+LVV8vC8oVL0ZWz252lxQNfM3Ps0OGJft4Ub0RqN6NmCtJURx7P0wu0
 Und0qq5ThK8vDrUdkp7q6OlzDJoXPiFAJ8UiB24QJ/ICODxPqJ9hlpE2PYP/aL2AlsEgb+TBdK7
 mw69NWwppQYSvzRnCIVLg9j5QJ+7HeXuzeKrqMptQsfbpcgMnhzyo+Ew7fJly5x8RWtZ/cMD5ox
 3rQfRX0oX6yRkBsRvHiEUkwdbyBEZOF44Prx5XwedynkL6ZjG/6VNOf7Ba8mqyddPg0t8cT+J/m
 wxJYR26f9ZXXoVzwl4Wa4OETzvKyathXwbVRquXBBZ+2dF7UdVx9OUwA6V2ywdmmnyD4mwtLV+A
 iZogWlehTqYvWHx0Eq5QarY7msfDy5pATKxsmrx40QcO4Fdn4FmfQzxZrux+ItdUdnGo8nfPfg3
 zoGrfV8FlQJC1ZepP8A==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b0e65b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: o5bOxdCr3fOneFuvVJGjOtr9q9HxUGRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggNDBkMzY1ZjQy
NTAuLjdlNTI4Mzc5ZGI2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDAsNiArNDAsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODAsNiArODgsMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
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

