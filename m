Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C6FC282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPM-000861-I8; Sat, 01 Mar 2025 00:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPJ-0007yg-Tm
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPI-0008N3-2U
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:01 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214Bom5027112
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kYy1GlhvnXUoK9Bc3kcNAPJXZk5CcLweWy3RyoizGTs=; b=Mo1GQW3eaXQLLvKr
 SD0QEzdSbkVHSQZ/lGwcgAp19E7vXRaVG55sSlkivSWX+h70t8mfNE3fNC5QmLfN
 hK/dUTu0GGlf3BPn6R2cjeagRcmmBZAYqVOnVmXD43v3oSkYxQavBAdKayBjC5Bf
 d+Bjm/9aS+YBHPB1fS2z+/0oliw293KQnk0x0zAG5iSAohgX/OOOC5CH4q+aa8dd
 ykCQFAMlW+r1hOzA8JCCJf1Lc/CskRrmUdOCe+SylhppkSr2UUcZbAg6mhMqpXyC
 T4XkCJ6aD8J2lDUqH4IvOcMbhjAODiCBzz0lOPNZ/cFEDHzXdRKmIzDDbh3Dc8Le
 TGHlMQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d0374-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:28:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fed20dd70cso1135213a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806937; x=1741411737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYy1GlhvnXUoK9Bc3kcNAPJXZk5CcLweWy3RyoizGTs=;
 b=NzeOWnjpXxOA4sW0LFLKWaal7siIO9Uf6us7Kt8sJigS/AUvEOzI8WBbqB2TMW9L8Q
 JVZV/uLcIkmkrxHjkqrEG/w7dSHqN9TMKZzR/cT6dEPh5YNpdO7iYOwlUPxnqfGOKpRX
 Lcki1t5BDiDqI4e4aJvwOVM+GV94jCK4tAhObifFvKbeOZLSKHNQOlu7/snqtOdCE0dc
 /xIGghoAAq8SoefTvuDUJzfJL9NpdQsfhvrxrnmnqgEtcPA7s8/adONJHPjgle064uwh
 mLjL69mJ4vjQ+jMITsGao703qWE25enUacLmvy384EQjbNjeiyeSM+UZs+1reUAI5KGR
 cEqA==
X-Gm-Message-State: AOJu0YxrTPbFRXCq9zv2qwYQwGLE7xN8jTVaQcPubweTzAU6hb+Fm7Za
 UzSLNzM+TPGkvgfUFnrqsq0NkfFSxwbNO26ihI/Zn4HW4pESx22UUaQAewG8kUrU55diDmbRvV8
 vMRGRhYLp84XOF2VLWW7gU4T6vcSB8Lf+0t56BVW153/GEb7u5w5G6R3gJARsNA==
X-Gm-Gg: ASbGnctimwH2HbhlPECxqYS9jaU5sNsbpBfDHBFuMgCgbCTQKltA9ru+1MdUV2tBy3q
 Z8bxm2TiKhjJ5qAYT76jhZET4SnljqRWgglWeMJKxfLcVatXTEld5kJOnSfBC39MnKqRqgERYfG
 LQ9DrspIyt2W2Me+VfKBQgRTvjsMM41JwGW8ZmDKi83vRgGhdtQxysGeMPx3ziZ2k7FyYQv03I2
 wvL+CQ8jWzlYwHzLWiErkFzblsGRLShyTGE6rFHLcMdwC6g82K5atP2aUL5mx65NsT+jlxEsnmE
 fcWbwhYWu+RZrbbLDjvNVmSQ2Ca7uom7RV1l2Z+PB4RNvqQF/skT50WjcGmCBrP6
X-Received: by 2002:a17:90b:2f8d:b0:2ee:48bf:7dc3 with SMTP id
 98e67ed59e1d1-2febab7862fmr10632221a91.15.1740806937378; 
 Fri, 28 Feb 2025 21:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI0mU2PUSnbCokGJHBDFf7KjOyAUkz/fAcXQgRgb5x+Gfn/ikzAw2EPbiKBsiZRQU7FaebXg==
X-Received: by 2002:a17:90b:2f8d:b0:2ee:48bf:7dc3 with SMTP id
 98e67ed59e1d1-2febab7862fmr10632186a91.15.1740806937012; 
 Fri, 28 Feb 2025 21:28:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:56 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 05/39] target/hexagon: Implement modify SSR
Date: Fri, 28 Feb 2025 21:28:11 -0800
Message-Id: <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: HiKTON7Pi42VSIvnlSRjUW1oxfnuFQC5
X-Proofpoint-GUID: HiKTON7Pi42VSIvnlSRjUW1oxfnuFQC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgcGVyLXZDUFUgU3lzdGVt
IFN0YXR1cyBSZWdpc3RlciBjb250cm9scyBtYW55IG1vZGFsIGJlaGF2aW9ycyBvZiB0aGUKc3lz
dGVtIGFyY2hpdGVjdHVyZS4gIFdoZW4gdGhlIFNTUiBpcyB1cGRhdGVkLCB3ZSB0cmlnZ2VyIHRo
ZSBuZWNlc3NhcnkKZWZmZWN0cyBmb3IgaW50ZXJydXB0cywgcHJpdmlsZWdlL01NVSwgYW5kIEhW
WCBjb250ZXh0IG1hcHBpbmcuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgMTAw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDk5
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggZTE1MWM2
MzM1YS4uM2UyMzY0YTdiMCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTQsNiArMTQsOCBAQAogI2Vs
c2UKICNpbmNsdWRlICJody9ib2FyZHMuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb24u
aCIKKyNpbmNsdWRlICJoZXhfaW50ZXJydXB0cy5oIgorI2luY2x1ZGUgImhleF9tbXUuaCIKICNl
bmRpZgogI2luY2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCIKICNpbmNsdWRlICJleGVjL2NwdV9sZHN0
LmgiCkBAIC02OSw5ICs3MSwxMDUgQEAgdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50NjRfdCBjeWNsZXMpCiAgICAgZ19hc3NlcnRfbm90
X3JlYWNoZWQoKTsKIH0KIAorc3RhdGljIE1NVmVjdG9yIFZSZWdzW1ZFQ1RPUl9VTklUX01BWF1b
TlVNX1ZSRUdTXTsKK3N0YXRpYyBNTVFSZWcgUVJlZ3NbVkVDVE9SX1VOSVRfTUFYXVtOVU1fUVJF
R1NdOworCisvKgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgRVhUX0NPTlRFWFRTCisg
KiBTU1IuWEEgICAyICAgICAgICAgICAgICA0ICAgICAgICAgICAgICA2ICAgICAgICAgICAgICA4
CisgKiAwMDAgICAgICBIVlggQ29udGV4dCAwICBIVlggQ29udGV4dCAwICBIVlggQ29udGV4dCAw
ICBIVlggQ29udGV4dCAwCisgKiAwMDEgICAgICBIVlggQ29udGV4dCAxICBIVlggQ29udGV4dCAx
ICBIVlggQ29udGV4dCAxICBIVlggQ29udGV4dCAxCisgKiAwMTAgICAgICBIVlggQ29udGV4dCAw
ICBIVlggQ29udGV4dCAyICBIVlggQ29udGV4dCAyICBIVlggQ29udGV4dCAyCisgKiAwMTEgICAg
ICBIVlggQ29udGV4dCAxICBIVlggQ29udGV4dCAzICBIVlggQ29udGV4dCAzICBIVlggQ29udGV4
dCAzCisgKiAxMDAgICAgICBIVlggQ29udGV4dCAwICBIVlggQ29udGV4dCAwICBIVlggQ29udGV4
dCA0ICBIVlggQ29udGV4dCA0CisgKiAxMDEgICAgICBIVlggQ29udGV4dCAxICBIVlggQ29udGV4
dCAxICBIVlggQ29udGV4dCA1ICBIVlggQ29udGV4dCA1CisgKiAxMTAgICAgICBIVlggQ29udGV4
dCAwICBIVlggQ29udGV4dCAyICBIVlggQ29udGV4dCAyICBIVlggQ29udGV4dCA2CisgKiAxMTEg
ICAgICBIVlggQ29udGV4dCAxICBIVlggQ29udGV4dCAzICBIVlggQ29udGV4dCAzICBIVlggQ29u
dGV4dCA3CisgKi8KK3N0YXRpYyBpbnQgcGFyc2VfY29udGV4dF9pZHgoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHVpbnQ4X3QgWEEpCit7CisgICAgaW50IHJldDsKKyAgICBIZXhhZ29uQ1BVICpjcHUg
PSBlbnZfYXJjaGNwdShlbnYpOworICAgIGlmIChjcHUtPmh2eF9jb250ZXh0cyA9PSA2ICYmIFhB
ID49IDYpIHsKKyAgICAgICAgcmV0ID0gWEEgLSA2ICsgMjsKKyAgICB9IGVsc2UgeworICAgICAg
ICByZXQgPSBYQSAlIGNwdS0+aHZ4X2NvbnRleHRzOworICAgIH0KKyAgICBnX2Fzc2VydChyZXQg
Pj0gMCAmJiByZXQgPCBWRUNUT1JfVU5JVF9NQVgpOworICAgIHJldHVybiByZXQ7Cit9CisKK3N0
YXRpYyB2b2lkIGNoZWNrX292ZXJjb21taXR0ZWRfaHZ4KENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBzc3IpCit7CisgICAgaWYgKCFHRVRfRklFTEQoU1NSX1hFLCBzc3IpKSB7CisgICAg
ICAgIHJldHVybjsKKyAgICB9CisKKyAgICB1aW50OF90IFhBID0gR0VUX1NTUl9GSUVMRChTU1Jf
WEEsIHNzcik7CisKKyAgICBDUFVTdGF0ZSAqY3M7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAg
ICAgICAgQ1BVSGV4YWdvblN0YXRlICplbnZfID0gY3B1X2Vudihjcyk7CisgICAgICAgIGlmIChl
bnZfID09IGVudikgeworICAgICAgICAgICAgY29udGludWU7CisgICAgICAgIH0KKyAgICAgICAg
LyogQ2hlY2sgaWYgYW5vdGhlciB0aHJlYWQgaGFzIHRoZSBYRSBiaXQgc2V0IGFuZCBzYW1lIFhB
ICovCisgICAgICAgIHVpbnQzMl90IHNzcl8gPSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudl8sIEhF
WF9TUkVHX1NTUik7CisgICAgICAgIGlmIChHRVRfU1NSX0ZJRUxEKFNTUl9YRTIsIHNzcl8pICYm
IEdFVF9GSUVMRChTU1JfWEEsIHNzcl8pID09IFhBKSB7CisgICAgICAgICAgICBxZW11X2xvZ19t
YXNrKExPR19HVUVTVF9FUlJPUiwKKyAgICAgICAgICAgICAgICAgICAgInNldHRpbmcgU1NSLlhB
ICclZCcgb24gdGhyZWFkICVkIGJ1dCB0aHJlYWQiCisgICAgICAgICAgICAgICAgICAgICIgJWQg
aGFzIHNhbWUgZXh0ZW5zaW9uIGFjdGl2ZVxuIiwgWEEsIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgIGVudl8tPnRocmVhZElkKTsKKyAgICAgICAgfQorICAgIH0KK30KKwogdm9p
ZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG5ldywg
dWludDMyX3Qgb2xkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgZ19hc3Nl
cnQoYnFsX2xvY2tlZCgpKTsKKworICAgIGJvb2wgb2xkX0VYID0gR0VUX1NTUl9GSUVMRChTU1Jf
RVgsIG9sZCk7CisgICAgYm9vbCBvbGRfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgb2xkKTsK
KyAgICBib29sIG9sZF9HTSA9IEdFVF9TU1JfRklFTEQoU1NSX0dNLCBvbGQpOworICAgIGJvb2wg
b2xkX0lFID0gR0VUX1NTUl9GSUVMRChTU1JfSUUsIG9sZCk7CisgICAgdWludDhfdCBvbGRfWEEg
PSBHRVRfU1NSX0ZJRUxEKFNTUl9YQSwgb2xkKTsKKyAgICBib29sIG5ld19FWCA9IEdFVF9TU1Jf
RklFTEQoU1NSX0VYLCBuZXcpOworICAgIGJvb2wgbmV3X1VNID0gR0VUX1NTUl9GSUVMRChTU1Jf
VU0sIG5ldyk7CisgICAgYm9vbCBuZXdfR00gPSBHRVRfU1NSX0ZJRUxEKFNTUl9HTSwgbmV3KTsK
KyAgICBib29sIG5ld19JRSA9IEdFVF9TU1JfRklFTEQoU1NSX0lFLCBuZXcpOworICAgIHVpbnQ4
X3QgbmV3X1hBID0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG5ldyk7CisKKyAgICBpZiAoKG9sZF9F
WCAhPSBuZXdfRVgpIHx8CisgICAgICAgIChvbGRfVU0gIT0gbmV3X1VNKSB8fAorICAgICAgICAo
b2xkX0dNICE9IG5ld19HTSkpIHsKKyAgICAgICAgaGV4X21tdV9tb2RlX2NoYW5nZShlbnYpOwor
ICAgIH0KKworICAgIHVpbnQ4X3Qgb2xkX2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBv
bGQpOworICAgIHVpbnQ4X3QgbmV3X2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBuZXcp
OworICAgIGlmIChuZXdfYXNpZCAhPSBvbGRfYXNpZCkgeworICAgICAgICBDUFVTdGF0ZSAqY3Mg
PSBlbnZfY3B1KGVudik7CisgICAgICAgIHRsYl9mbHVzaChjcyk7CisgICAgfQorCisgICAgaWYg
KG9sZF9YQSAhPSBuZXdfWEEpIHsKKyAgICAgICAgaW50IG9sZF91bml0ID0gcGFyc2VfY29udGV4
dF9pZHgoZW52LCBvbGRfWEEpOworICAgICAgICBpbnQgbmV3X3VuaXQgPSBwYXJzZV9jb250ZXh0
X2lkeChlbnYsIG5ld19YQSk7CisKKyAgICAgICAgLyogT3duZXJzaGlwIGV4Y2hhbmdlICovCisg
ICAgICAgIG1lbWNweShWUmVnc1tvbGRfdW5pdF0sIGVudi0+VlJlZ3MsIHNpemVvZihlbnYtPlZS
ZWdzKSk7CisgICAgICAgIG1lbWNweShRUmVnc1tvbGRfdW5pdF0sIGVudi0+UVJlZ3MsIHNpemVv
ZihlbnYtPlFSZWdzKSk7CisgICAgICAgIG1lbWNweShlbnYtPlZSZWdzLCBWUmVnc1tuZXdfdW5p
dF0sIHNpemVvZihlbnYtPlZSZWdzKSk7CisgICAgICAgIG1lbWNweShlbnYtPlFSZWdzLCBRUmVn
c1tuZXdfdW5pdF0sIHNpemVvZihlbnYtPlFSZWdzKSk7CisKKyAgICAgICAgY2hlY2tfb3ZlcmNv
bW1pdHRlZF9odngoZW52LCBuZXcpOworICAgIH0KKworICAgIC8qIFNlZSBpZiB0aGUgaW50ZXJy
dXB0cyBoYXZlIGJlZW4gZW5hYmxlZCBvciB3ZSBoYXZlIGV4aXRlZCBFWCBtb2RlICovCisgICAg
aWYgKChuZXdfSUUgJiYgIW9sZF9JRSkgfHwKKyAgICAgICAgKCFuZXdfRVggJiYgb2xkX0VYKSkg
eworICAgICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShlbnYpOworICAgIH0KIH0KIAogdm9pZCBj
bGVhcl93YWl0X21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCi0tIAoyLjM0LjEKCg==

