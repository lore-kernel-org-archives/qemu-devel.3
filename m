Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7713410F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXhl-0001yK-Rq; Wed, 08 Apr 2026 14:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXhj-0001nt-9s
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOn-0005ZL-3R
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6383E1BX2411813
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=m2URMhcwPb3YfqO6
 nY1mg/yiFf/hqjezE/4kzm70fMq3YOfc6as60eCe2WMSchC4DUaWAVhK/rQUmlpc
 SC5MxQbVR/PspaN9ODMkKWARHAkAing6yvDU3J3UAtwSvM8mgEEOahUJ3eo04CDg
 zVyWERzUlu2Y40Tp0fPbRJPLHCAw2Cmxi9ZYQO2YIAWIZGg196BJQgLohzp2Hxc+
 kwLVn2OCVPZANdVUC5qiPUItigqYCz2ElhZ6oDS8LA48CbNhhWWeLIDxMH7uaSud
 kM0FZjxNHTP5rKId5dyElI1VVxxCS5HfMDfbMsD08hz/9fcPEXJoS6ErXiMK/3UM
 Zo4XRw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61v9x5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1279caef718so9082750c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622015; x=1776226815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=G5tS/AEqTZt+iRAP991NKAzL624ONzokgVglJdiMNXDd1x9/hY5zG/dpzqkW+nuthh
 RuDWFP4+LSFWeauZ2uJB5D1kTnoQX6ROg+lwMRdPus3gADH5vqkW0Mr/YBccs5dwAmMK
 Ub+S+7kGPIZH0Mvjn7wBzHKUYojl3tiuaX7uf/ewHMwqYXJLU1pNQTH4C1L6kWoub+Ir
 mF1U8KaqOtKApgXlUNe9RRRcqghD2kLiaYNvlq60SVoSxurk/ubPj2haEyxJpLHmzvxf
 TsO5dxDIXcKVGMmhjqcIKY6mPoeC9Jz8iibPZHuxOcdSPvvIJyyjflhXmIEcFRD+pbce
 V0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622015; x=1776226815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=gIPxI1L0PVSgvcetMjDED41GoiefkvN1Qk2pOl9X3HmeCOjRuS52s139dK5nN74etL
 AGNIG/ndBB4Cgzy8870UfZzp+Jd7Q/9sbmwQsfrosGalA0YYnCJBZEvRbRdmuSviur60
 Wf9kHwRALz7RMKowchQYx5KookOrwa1ciQdsyjPerj8uUnUiE6KAGb+Q7SaD7FauALjH
 /oggPRBtT2stTfIysxQirOeh4ImWibgbS8vz0Kys9hMpzKj7gUl4zLrIyjQeDuBXAVq0
 howEOBEAxZYSE6MT6k3nYnFwNZS9ri4ZqZLjZdPYpUtBg64Wo+Ao1yA2MkU2DY7wABko
 Uiyg==
X-Gm-Message-State: AOJu0Yys4ekPUShPxW+VpX+NkOYyH7lgEkUQRonNzIMY3CPwdyTarb0Y
 moQDEWCRczCSJ7ZMYSdNxCM/ZfvISCL+JtuyboVa7ovWMi5SEaFGR3KA2wJEn6qds2TW1gteqQH
 ea1wjKrCAy6eva9df4pyvn7TfaahGlCH9eAZ0jUuvs+VV3c6aIMZX4G2ixoH8lFZBDw==
X-Gm-Gg: AeBDieu3pTkyBRJpEPuSBDAYGByi1OEF0VrYKCvGaJHgSoLSd4QBBgp492oahHDxwSy
 bQ6VnjpR05i3ai1gB6+lEZsCpOveiYuNKAHi10a55MXwBDZW+YEhqb7IMc0DH2eEy8RbRD213nd
 Nz/cPEjmwWNCvMAvzFWMDmAlZMuwLaQHYEUokTAt0nR/dJZitb29bAwMQmDkTi0E9qpBrjd2jek
 8f38CXvC5brH/C+q8iDkABVrgusDDjSJ+3KIibI09xfP0e6axMsIJJV07+gUD2Agnw9yglKvzN2
 PuCFheqIPNLqEhKx9JJI8orPXuTsIPxSE3kFmU46rKv+kFnLBgTRNE/gjn4IUTjWx9UQooHWWG0
 mZ62AMHrSSKHTWLVxYH/AhO74KaJr1o9p9zlRkqgjlEA8geHrumdc5xl2iY3FZs0B2bwt9g==
X-Received: by 2002:a05:7022:6b85:b0:12a:b932:81fa with SMTP id
 a92af1059eb24-12bfb6fb367mr9975065c88.9.1775622014904; 
 Tue, 07 Apr 2026 21:20:14 -0700 (PDT)
X-Received: by 2002:a05:7022:6b85:b0:12a:b932:81fa with SMTP id
 a92af1059eb24-12bfb6fb367mr9975056c88.9.1775622014392; 
 Tue, 07 Apr 2026 21:20:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 06/28] target/hexagon: Implement get_exe_mode()
Date: Tue,  7 Apr 2026 21:19:31 -0700
Message-Id: <20260408041953.1899532-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNSBTYWx0ZWRfX9L6PZ14JAd8P
 Qrvlz8vrQljNNNGfI/gaQQLaEj8k2LnkVM1sLyX9IfvCCHJJouefWcxeIKBhKWi+vHIgUoW08FZ
 ziqUcEdnsl1Ispw5La4QUftp5B3dpCGRCYhtLDlVua4mdaQPq5t+3EAbikjlFRxHmSCP19kc7U4
 Ij70PSZvSA3tlTMWxMKM8OD+VqFaYarzgXditYK9ioa5G5/UvsRZQH/WXBBWEzlPwqhNfT3NIdM
 vEUca5MNZs+5LKykgdxvb++CPiu5yHZzEtg1VGNulpOArGmNHs0TWfA83gdB2r711A6V5VggJqg
 x6Vcp402T2i09HD04YLK71ii9L6CbG/85KS4FmV/UXimatFA5/8g3cf25FLp2Mv2rhbTiEH6wBV
 BKDTHiLd30YNDjAa0d/YXYQj+QveoMOs5fT1NhN9B9FcfAJMFV7GVWpMG+qntYD/CzpP80KDbSS
 DSCWA/6p3yphJtlMXEQ==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d5d780 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: D7yEqzc7UKxM6uTok0DIRqd56JmzBtPf
X-Proofpoint-GUID: D7yEqzc7UKxM6uTok0DIRqd56JmzBtPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

