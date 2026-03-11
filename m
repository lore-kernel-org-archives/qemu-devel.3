Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C81CFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa9-0001iA-0H; Tue, 10 Mar 2026 23:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZw-0001dA-EE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZt-0005Dk-4L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B39cEQ248940
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 otPPk5ra8XbrJcQ4KUod9esGuz0VYNxYDxdeHCKqdDk=; b=JURDIw26Lsz0/rLS
 iGEfURtPA1ou4LRaPPOd6fs5UlhuDHUO8f3HuwZo04bJq4sclzGmGa5mwk5MgXj9
 HGcXULGFTaijxOntUTVEU8pBzjHiJCsMbGHP8wki2mhHgFa3fsHvvkzcxjwrPjf3
 SfK4+KlCy0l3CiPgI3dSLqMlr3CNSEC5MscbMPA0Ee1NgY/NaBJNRMyGmsCcDkan
 JkrhJ4UIkQCdA5oy8EaJDQo520TUyYiLsjJHzLavkewSwTyrlYUF/GC3VQwA+zit
 qZRYoaB4F9OQO0RhdzBoP1RMBbdd7Lt/tkok7g+j4vArr4k4sMkrTVB1y2tr8nc2
 FT80VQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11ra6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:43 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d73bcdba71so39000079a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200982; x=1773805782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otPPk5ra8XbrJcQ4KUod9esGuz0VYNxYDxdeHCKqdDk=;
 b=HFy0nDq91DBLCrEYEacMqkfqb73tnZrEGH/KHmm65OLZa+ru5aE0laPADORPLrK0Ly
 qo4JgBRQ3fD0NyVL851mZQJzgyVF+uZN8RSNQdCZPtA/mzPNu3G0Rj/YRrBNiRs05tNL
 VqfiDR9ZaUYUThb1XG254Qrm6/2HQP2klB/8a8QtthXRZmDwZCPzePMtKnLZGin0MrN4
 tcWveGhZUl208xsm1qDGfrR3HHuuCauBU0lDm22Dd6MaKM+sByLqLKufqnDst3nOtfhb
 Xan+JqSD9orQkpedMldLii3dKn+ULCuOFCDz0ROfptNmOdWXnMy0zDqcixXJ5mBPfF6e
 DO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200982; x=1773805782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=otPPk5ra8XbrJcQ4KUod9esGuz0VYNxYDxdeHCKqdDk=;
 b=xRnFleYj3mnijk7H6c+3lhsJH2StIVYaIT+ec3p2C7rMK0z9gWy6azEu9dvOkuUz47
 RhluLCpGi7bN5hVei8F+FUV1TL+Hvh2cGPx/hSaCoL2NSOtWD20b9yYfJ8yo1fyWFTSM
 KJJUaZ8XTehiSfDI3fb0WpQ/Z7G5gGhCrL7HNn8GBLPq7FyP9ap7fpVF54HMlnJV7a1J
 8RLz2O8h8aTOZ/jeTDfXtm8as5h1iiCByP5PYU51mmo6VnBV22LvlsrbKYy/S9if5vGc
 pn7FQdWxyycLx8Wh3GSfJyvlhREKZsnHbceWX9jfPggTyHzgjK5QE3LFaOS5n6sAcTno
 EdjA==
X-Gm-Message-State: AOJu0YzkytAVgvaJAoybn+HF+k+9+GzzxA0cctOs8s2XvYxDR4BHXuw5
 CjLzpDs7QB0AKAmeVhOCJ5uYX4Fi120yfxyAAarExnmadtBjrsuVvpZX5nhVayF4lslEBIJ8SV+
 cIGCuUyfTyLU+MuJ8QKtKrE0TI+pQuhAKOxnbDbxq35ETNo+W0B+C8+rJj96TeRnlsg==
X-Gm-Gg: ATEYQzzgImcCxcIjwWZqRJ3W7beDNFNI88WtWx59lT2zmWIp7bwW2BKZKyQ1uG7kG76
 7yy/0jcwOIyrMQbJ08DWhRs9LUd6W87NR3z4Q4ecTmw4QCibCRNS/u2Rrw8vVz+shwO94hxYgCr
 eS2n90o6XL9rbgqfkfpN29Q+oqQasmzzAkmQtkAZ9zl06scVyW5w/I9pzb2L/Pq21AEK6XyVCqF
 T7CuhnL2gIira1iYyMLmmR/a9Hq+UMDdikKQtWVGd5TCtma2cf9ixXei8h3JPXWu7vhb2VFsYA2
 Rg70O82grgFhQ5xoeXYuZsymENELlPlq6I0oXw6nOfmiOUKp43LidMfNpfGj79FDNkrIUiCGQWa
 U73mJ8aC6U16wZkQbH115gtxDsGOPitNVigzMEM7pIxQznv1s/LzI+Wwk+AvP/4micn46Lw==
X-Received: by 2002:a05:6830:3113:b0:7c7:6558:277a with SMTP id
 46e09a7af769-7d76a7a487dmr926098a34.15.1773200982742; 
 Tue, 10 Mar 2026 20:49:42 -0700 (PDT)
X-Received: by 2002:a05:6830:3113:b0:7c7:6558:277a with SMTP id
 46e09a7af769-7d76a7a487dmr926077a34.15.1773200982417; 
 Tue, 10 Mar 2026 20:49:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 11/35] target/hexagon: Add guest, system reg number defs
Date: Tue, 10 Mar 2026 20:48:59 -0700
Message-Id: <20260311034923.1044737-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX+SeQxQVLJpsh
 7w2cAWNCOuyP4tJLRGq3cjTzTl7oIuffd3pPT6eiNUwZbU1wvbz+YS+v0KutocPYyG8zkJMTi4r
 GhMu8AzdbawSH0BNMajLE2bGFDPdTc+8Yv3h3CRDkVVzYU6g3UCqztsFzpV2wsl2wT6hvXoui7Y
 VFT5MaByjHkH87ZvBI3rwiksEyWJHYYAZTyA90Eo5VULjcs9Q7G/kbMxVt2zCrWMpCxEta8aSOo
 C5PWACaAkOn1xEOy+wIDe52+oRe9IsO9IcEDSAxu1kq/K2D2DJtpXu/58S8K1xW9a+s+GMpJGUx
 eTV6DUq3u7HMSdda4mnguwRvfJp2Aw5yUaT7vO7CZp3pbmGFv7fPUFEPSMsC12frVrfNB/rVa4a
 1KjdH1b/AaerxbMuDhdlHUsKekJ4fKOVqBa5zFs2+kjr5B2aQfBM9E+iNGne06+0f2Gm12ATKyb
 uiYwnM9QAgYn84jW4ZQ==
X-Proofpoint-GUID: NNOiHP5iJDN73dQtulT2YT9RarjPlpMF
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0e657 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=pUoahe-fvFp-T0RBf7EA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NNOiHP5iJDN73dQtulT2YT9RarjPlpMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuaCAgICAgIHwgICA3ICsrKwogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCB8IDExNyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmgKaW5kZXggOTM3MTk0ZTQ2MGUuLjM4MjVkZTQzZWU3IDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMjAs
NiArMjAsMTMgQEAKIAogI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQtdHlwZXMuaCIKIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE5VTV9HUkVHUyAzMgorI2RlZmluZSBHUkVHX1dS
SVRFU19NQVggMgorI2RlZmluZSBOVU1fU1JFR1MgNjQKKyNkZWZpbmUgU1JFR19XUklURVNfTUFY
IDIKKyNlbmRpZgorCiAjaW5jbHVkZSAiY3B1LXFvbS5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWNv
bW1vbi5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWRlZnMuaCIKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2hleF9yZWdzLmggYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCmluZGV4IGJkZGZj
MjgwMjFjLi4yMTRiN2I4ZmRlOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3Mu
aAorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCkBAIC04MSw0ICs4MSwxMjEgQEAgZW51
bSB7CiAgICAgSEVYX1JFR19VVElNRVJISSAgICAgICAgICA9IDYzLAogfTsKIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCisKKyNkZWZpbmUgSEVYX0dSRUdfVkFMVUVTIFwKKyAgREVDTF9IRVhf
R1JFRyhHMCwgICAgICAgICAwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0VMUiwgICAgICAgMCkgXAor
ICBERUNMX0hFWF9HUkVHKEcxLCAgICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHU1IsICAg
ICAgICAxKSBcCisgIERFQ0xfSEVYX0dSRUcoRzIsICAgICAgICAgMikgXAorICBERUNMX0hFWF9H
UkVHKEdPU1AsICAgICAgIDIpIFwKKyAgREVDTF9IRVhfR1JFRyhHMywgICAgICAgICAzKSBcCisg
IERFQ0xfSEVYX0dSRUcoR0JBRFZBLCAgICAgMykgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV8x
VCwgIDEwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzJULCAgMTEpIFwKKyAgREVDTF9IRVhf
R1JFRyhHQ1lDTEVfM1QsICAxMikgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV80VCwgIDEzKSBc
CisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzVULCAgMTQpIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lD
TEVfNlQsICAxNSkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ0LCAgIDE2KSBcCisgIERFQ0xf
SEVYX0dSRUcoR1BNVUNOVDUsICAgMTcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UNiwgICAx
OCkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ3LCAgIDE5KSBcCisgIERFQ0xfSEVYX0dSRUco
R1BDWUNMRUxPLCAgMjQpIFwKKyAgREVDTF9IRVhfR1JFRyhHUENZQ0xFSEksICAyNSkgXAorICBE
RUNMX0hFWF9HUkVHKEdQTVVDTlQwLCAgIDI2KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDEs
ICAgMjcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UMiwgICAyOCkgXAorICBERUNMX0hFWF9H
UkVHKEdQTVVDTlQzLCAgIDI5KSBcCisgIERFQ0xfSEVYX0dSRUdfRE9ORQorCisjZGVmaW5lIERF
Q0xfSEVYX0dSRUdfRE9ORQorI2RlZmluZSBERUNMX0hFWF9HUkVHKG5hbWUsIHZhbCkgSEVYX0dS
RUdfICMjbmFtZSA9IHZhbCwKK2VudW0gaGV4X2dyZWcgeworICAgIEhFWF9HUkVHX1ZBTFVFUwor
fTsKKyN1bmRlZiBERUNMX0hFWF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisKKyNk
ZWZpbmUgREVDTF9IRVhfR1JFR19ET05FIDAKKyNkZWZpbmUgREVDTF9IRVhfR1JFRyhfLCB2YWwp
ICgxIDw8IHZhbCkgfAorc3RhdGljIGlubGluZSBib29sIGdyZWdfaW1wbGVtZW50ZWQoZW51bSBo
ZXhfZ3JlZyBncmVnKQoreworI2lmIE5VTV9HUkVHUyA+IDMyCisjZXJyb3IgIk5VTV9HUkVHUyB0
b28gbGFyZ2UgZm9yIGdyZWdfaW1wbGVtZW50ZWQoKTogdXBkYXRlIGBpbXBsX2JpdG1hcGAiCisj
ZW5kaWYKKyAgICBzdGF0aWMgaW50MzJfdCBpbXBsX2JpdG1hcCA9IEhFWF9HUkVHX1ZBTFVFUzsK
KyAgICByZXR1cm4gaW1wbF9iaXRtYXAgJiAoMSA8PCBncmVnKTsKK30KKyN1bmRlZiBERUNMX0hF
WF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisKKyNlbmRpZiAvKiBDT05GSUdfVVNF
Ul9PTkxZICovCisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZW51bSB7CisgICAgSEVYX1NS
RUdfU0dQMCA9IDAsCisgICAgSEVYX1NSRUdfU0dQMSA9IDEsCisgICAgSEVYX1NSRUdfU1RJRCA9
IDIsCisgICAgSEVYX1NSRUdfRUxSID0gMywKKyAgICBIRVhfU1JFR19CQURWQTAgPSA0LAorICAg
IEhFWF9TUkVHX0JBRFZBMSA9IDUsCisgICAgSEVYX1NSRUdfU1NSID0gNiwKKyAgICBIRVhfU1JF
R19DQ1IgPSA3LAorICAgIEhFWF9TUkVHX0hUSUQgPSA4LAorICAgIEhFWF9TUkVHX0JBRFZBID0g
OSwKKyAgICBIRVhfU1JFR19JTUFTSyA9IDEwLAorICAgIEhFWF9TUkVHX0dFVkIgID0gMTEsCisg
ICAgSEVYX1NSRUdfR0xCX1NUQVJUID0gMTYsCisgICAgSEVYX1NSRUdfRVZCID0gMTYsCisgICAg
SEVYX1NSRUdfTU9ERUNUTCA9IDE3LAorICAgIEhFWF9TUkVHX1NZU0NGRyA9IDE4LAorICAgIEhF
WF9TUkVHX0lQRU5EQUQgPSAyMCwKKyAgICBIRVhfU1JFR19WSUQgPSAyMSwKKyAgICBIRVhfU1JF
R19WSUQxID0gMjIsCisgICAgSEVYX1NSRUdfQkVTVFdBSVQgPSAyMywKKyAgICBIRVhfU1JFR19J
RUwgPSAyNCwKKyAgICBIRVhfU1JFR19TQ0hFRENGRyA9IDI1LAorICAgIEhFWF9TUkVHX0lBSEwg
PSAyNiwKKyAgICBIRVhfU1JFR19DRkdCQVNFID0gMjcsCisgICAgSEVYX1NSRUdfRElBRyA9IDI4
LAorICAgIEhFWF9TUkVHX1JFViA9IDI5LAorICAgIEhFWF9TUkVHX1BDWUNMRUxPID0gMzAsCisg
ICAgSEVYX1NSRUdfUENZQ0xFSEkgPSAzMSwKKyAgICBIRVhfU1JFR19JU0RCU1QgPSAzMiwKKyAg
ICBIRVhfU1JFR19JU0RCQ0ZHMCA9IDMzLAorICAgIEhFWF9TUkVHX0lTREJDRkcxID0gMzQsCisg
ICAgSEVYX1NSRUdfTElWRUxPQ0sgPSAzNSwKKyAgICBIRVhfU1JFR19CUktQVFBDMCA9IDM2LAor
ICAgIEhFWF9TUkVHX0JSS1BUQ0ZHMCA9IDM3LAorICAgIEhFWF9TUkVHX0JSS1BUUEMxID0gMzgs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcxID0gMzksCisgICAgSEVYX1NSRUdfSVNEQk1CWElOID0g
NDAsCisgICAgSEVYX1NSRUdfSVNEQk1CWE9VVCA9IDQxLAorICAgIEhFWF9TUkVHX0lTREJFTiA9
IDQyLAorICAgIEhFWF9TUkVHX0lTREJHUFIgPSA0MywKKyAgICBIRVhfU1JFR19QTVVDTlQ0ID0g
NDQsCisgICAgSEVYX1NSRUdfUE1VQ05UNSA9IDQ1LAorICAgIEhFWF9TUkVHX1BNVUNOVDYgPSA0
NiwKKyAgICBIRVhfU1JFR19QTVVDTlQ3ID0gNDcsCisgICAgSEVYX1NSRUdfUE1VQ05UMCA9IDQ4
LAorICAgIEhFWF9TUkVHX1BNVUNOVDEgPSA0OSwKKyAgICBIRVhfU1JFR19QTVVDTlQyID0gNTAs
CisgICAgSEVYX1NSRUdfUE1VQ05UMyA9IDUxLAorICAgIEhFWF9TUkVHX1BNVUVWVENGRyA9IDUy
LAorICAgIEhFWF9TUkVHX1BNVVNUSUQwID0gNTMsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHMSA9
IDU0LAorICAgIEhFWF9TUkVHX1BNVVNUSUQxID0gNTUsCisgICAgSEVYX1NSRUdfVElNRVJMTyA9
IDU2LAorICAgIEhFWF9TUkVHX1RJTUVSSEkgPSA1NywKKyAgICBIRVhfU1JFR19QTVVDRkcgPSA1
OCwKKyAgICBIRVhfU1JFR19TNTkgPSA1OSwKKyAgICBIRVhfU1JFR19TNjAgPSA2MCwKKyAgICBI
RVhfU1JFR19TNjEgPSA2MSwKKyAgICBIRVhfU1JFR19TNjIgPSA2MiwKKyAgICBIRVhfU1JFR19T
NjMgPSA2MywKK307CisjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8KKwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

