Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA96CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C5-0004PN-5B; Fri, 29 May 2026 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C3-0004FJ-86
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bx-0000RH-MO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2LvL2998027
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WXHTQGJ2zJWbtOqokS2jHDgTZvavJrn46Uslnsw7psw=; b=VMgi9uI4nd9h/VCn
 iJhjZegPyvBSNpYzKmyjmQgaZ12nJ27rFpGD7fJjV8uhxi/Fql2q7jy05nKrFEo2
 1B0uhLTAwtSdf593CyuHwBWdUjPOztbbaa4ysFqrB+YyKfhNhXYNrpum1X8RQUXi
 4YUC3MjUQxnIMUeIjEdxZFCsSHagQvRlt/ZmHl98PvJird3NlZnFpEvsFCjdRVH1
 rQRERNgD80uB53U2VtHTSOspifVha5SP8Pr+QQ4nGD1kG5vae4s240ConaFZ0toO
 7oeweYgSuLxCklca7nO3ORZm8NixyOUe2XRKfaucYl/AfP8R3kyHtEb12FcrnybL
 l7m3KA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4ekm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:22 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135916eefa0so5166579c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091782; x=1780696582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXHTQGJ2zJWbtOqokS2jHDgTZvavJrn46Uslnsw7psw=;
 b=XMtJEPZiWB5vK6Vr2ltaofP7cCr1Ar9l6jW3KJu9emYkTB6CppwC7+i13gzjPm9ydZ
 APrBZK+Ysw7RhVPAts+3Epq7KUCIO3UXcbi7H/Zebaj/cuQncmo4KrGeuqv4hMix5LID
 seCgzKJpr9Xr+/Vr+98wqVKIrRTcM58n7GDFATftWOYHKoZJhV7DE2BG1H0/JH2yhUie
 N6rRoSHTQvKAihh8uGw0ruo0XDJIAkegjuAo0cqh2QA1rasfohNlAyk+Pd+smtljbJXN
 P5K+6zbm4nQM5n8hqHOR5+QzYVL8mzQOGVlOBM64wHiwRV+jVJJEBZ7ZExzYxxZKmB87
 q8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091782; x=1780696582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WXHTQGJ2zJWbtOqokS2jHDgTZvavJrn46Uslnsw7psw=;
 b=sRm93N9zCVC7Z4X7gSsgNB04u1w9701rP+CaFvlGMXQX7iCM+SetStXZpIWMrb/L1c
 n5XBvvfjjusNX1T6GAFX51rJ7/Jr3/CwSNXDwD2YWK/dFSPT5r/Exhxsnm4UqEEGfMXc
 ir6unnubPctoMPDSnQ8tQMPEDiQujvHwJO/BnTkiClZ2y/FdVDydkJXVE/LAw4UriHRY
 wlMPXl9Vpd1aIbv9fyO4O7ljjY5lqAPnyBEQTQxfGuCpGHcMe8HgTZkqrY+a477ipp8L
 RTtJkqtL/RKuizw8CyrANXhYYhDD4cShL+2mJbHQiwNmpis8cko1fEQQFC3uri6sxEQT
 QYVQ==
X-Gm-Message-State: AOJu0YxJp8mVWqUQYi/PQPtNF6hkZzOwXgMSyNJE0dMx7N8ArgT+Gz/s
 rXB0IMr+H9Tf6G7NuOfOqwmjwnYTiQmVTH/DcyqE20h92za+frQ+ed0Csq+WjWCjGCg8YyCsH50
 itv8RZgKLXkiNqa+mebLLOdvdDxeTOYTUI6y0C9+w2tpN/+cAb2220IPTUuHUcjfSwg==
X-Gm-Gg: Acq92OFjHzlWCHjlgadFaFdMEfZFhtW901CU/6ComH4CSFDI1V8PfFp0qQsqazRk+i7
 8RU8TTHBlO8aYDpN2xGBs8cGH2LJ6HDeiua29k96TODqBTlN0IeqTx5K3pH1hauZQcY+b6thl6G
 qwH4W2BA3tfZ46hmSdu3H5tBKv5FpZ0uCjaGnTW2+mEMUkk75HSla/mNfHeLLeY+kW7/jGYbipa
 O3xYg8ufkc4v/jaIrs1O6ujHnLI7jQfiUbDirfpMGNCGsOUEL/lyCqVL9TA4FTkzZ1OKhI3Sa/E
 O/7AR6VmPwNGGYef0MIB37SW9d2dq+wtj6FLmTuPCh2whWR2GvmMqT4JtxGqOkr01v5wXIfQeuH
 qhLwfQ57JTu6lgXFQdSiXddsdGetXK8LSDj6HKgxTv+MWbVDKMY7voKwwJ+EWH42LQ8SB3e8nsr
 p51fwP
X-Received: by 2002:a05:7301:1698:b0:304:e865:f7d1 with SMTP id
 5a478bee46e88-304fa74349amr993051eec.25.1780091781666; 
 Fri, 29 May 2026 14:56:21 -0700 (PDT)
X-Received: by 2002:a05:7301:1698:b0:304:e865:f7d1 with SMTP id
 5a478bee46e88-304fa74349amr993034eec.25.1780091781204; 
 Fri, 29 May 2026 14:56:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 13/38] target/hexagon: Add TCG values for sreg, greg
Date: Fri, 29 May 2026 14:55:29 -0700
Message-Id: <20260529215554.606133-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX++4/GMKvibDF
 n96KMVOUxAtqt5o2VBvIBtVNDrj69qQw5CPeSDudgw/yIKLy5lZycJNl05LAns+dBDZWB3vQstd
 HoZRQ/e6pZCodd6e03HGbzdc7+faAEHAV2l3dSkxKExkx5x+wt/gTy30H7pdlkuNGka1+f5RGZ8
 xEGwkNdMAj7h6OQtmOE1aV83C1USAWj76EaWs++RoxFEEProvUQjNlducWV+KDBBaKN80lJ1wgY
 30F4QEqyPGX68d61OTMAulLc4o1VNHDfTsCkOPz/tJn3jwqCtEK2ec6yJBMci0UfNMR8+rZBEEK
 57OGcVfxMGs5nJR2UZptlkm4qM0dFdyh4zaBrXA2lG1USEI3V1/wTPu9aLDIuUCFu9Mf+w8u99d
 YgWjPTDO8F3ZJ7l0IIh2hyxelJHLOhXtFk5JcPXlvNRQol+75wH/Y0qkF+IIEOCKG6UDlmOI10R
 Uce2miHe4M1XNWd0kMg==
X-Proofpoint-ORIG-GUID: kDk1YbaAoHWhLIXQ-gYHMMijFW-fyc-U
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0b86 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=md9odPwznpFxaQMInv8A:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kDk1YbaAoHWhLIXQ-gYHMMijFW-fyc-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

