Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEDCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5E4-0005n8-Bs; Fri, 29 May 2026 17:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E2-0005hG-CH
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E0-0000uW-Sc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Le82998046
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F0cep0TaF14MbTHyoNohBMjmTyEDCIMV2M5fWWT0+KQ=; b=VuSt6DOgEuVlmown
 l7XyWQtm+xocG3g4rGxungFxd1fpWq2knK2CJT5dtKt61WfEA9QSAlzHBhRZ1rKo
 ZlbQSKaJcvmDPnJvHkglOlJPBbyCzH5aOVtgm4qk2LVi3bU1faITpscPWy9Y7EQA
 yAc6T5+PhZ0IfarkWlApPfD3cGXCUMYwDu5VDdcLiRM6btQiPR8XK7ghwnJBI72+
 tnKJufl9jxwvMVdrSIPfeY43j7/QbhXPxT8QqPKgGV1jHTvVgXqsddiQrTR70HHt
 5enlEc1oRPPpKRiJsbqrIEFKNb9rN96lacQU1h/uLAyNLmCc2A7P1jpU7/gP2XkE
 dHPv7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4euv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so6174337eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091909; x=1780696709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0cep0TaF14MbTHyoNohBMjmTyEDCIMV2M5fWWT0+KQ=;
 b=HhCdoGv5RKzq6ZIE5In+YWoTe8MkV/P2HUnHQArKIAngEpwR2+GR2AJpJ8Y8gKYmyX
 YhzqKb1dQc9WVzK/KFDvjiukkEDngJRGb3Ywl1aLcNXW2m82/YMX+PrYfHi9z/8Z8b7E
 iKP4ulIV96H+Mt5RIAQCKTuPqCQ77zdnYf91/87Xc0Sm3Q5l1Zai3Nb4HcWodzxNo9kW
 8Lh2TAewVGwfTb0cgMUXs49NkuYcm7HPvSiyCosJqq4Vv7AJcScNcTlQH1Vs/tX03efO
 7xzrYHLuUVUyD7yk20mtBHwVzHLmn826C0OPNwo4i0xd0uQNMORcI0E0tpKowPBlsOJq
 RsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091909; x=1780696709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F0cep0TaF14MbTHyoNohBMjmTyEDCIMV2M5fWWT0+KQ=;
 b=cE891m1iZK/ZWOhpcTu8JtG0X91JWZXLW+KE2hv4EDFDM6bzpRmmWNJgDB7EHaIDgR
 jcFZl7m7Odr0mXpOygQJsyXLxFJVxJKNJm4OYsCTHx/Ok7BKEb2mQVMbq/9JyRnCV6PY
 mrz8zs12J4wWHXZTTvDVvEWhlh/GyMrqQTwsgtsbrj7SVIk6IRkYaO2EMkywhTuKG1hS
 K+iuVpCXS8gsJnDyeBezqbsoxQw9qH8Gf2/sj2h4vYzzcwUPCVqNR5Tdev64TNPVTRUa
 725v5ka3FqG0RUR1cKK3P5RtEzlKAFjnr10wnp0UrdI11Ba8xe4PFnjbpLh1slBVngJz
 kJHQ==
X-Gm-Message-State: AOJu0Yw5g9qzcnZuP7VMEh3Yu+ymhPNhNIbMx2TW9hu8kzNT0RTEE3Fu
 n4kbn9wK+QC0dBn9KyfY5GVBRdz9TSmDGDUZrVC9CWuF1M261C8wd20HqAg0dHhGggv9rppUM50
 MrZJj54AJNi1xIxhJgQbKcShJdVOZBieGM5w20bXr4+fHWALupFJXeFN2OOZC6wje2w==
X-Gm-Gg: Acq92OFojz+jd+h7NxCQ97L+6N3gtrnX7nqPza9LmS257j87eNYYkD/CsLGR+WDEP+x
 8O2gYztVPKz7Zb3FWJ5cUcY8TJ10f+t6yULNOIkX2rvcuHOcvQJ9aNhbgtQEabowDTSpY9BKiQr
 AQzmumJxtCQNIvxl93p5RliMmcJV2aSIsbNKRFDIJsXI7Xk6axbmWYmLAqBHtZclGUTAXQnSdE6
 g1Gi67N6KYlFz/jTR9U0sevzUC3faeCxJehT/iGb6j4Bc3Gu8bPXuGWysTgt8hbf+bHjxH6xfgJ
 xCdzwrAvT4IJkhluZ7xNO7M9oVD0iFcLGtnirv4L1e7QgCCFuJ8MAzalJH9pW+iPCdAOHUtlsoW
 FN12pJ/fOu7YUz+SKgSsAerYLhdedG2fFtiFRM/ui3vFOvLZzQbXtlj6HOTYMoC4Wf+scuQX3z0
 6zK9v6
X-Received: by 2002:a05:7300:2201:b0:304:d8cb:8424 with SMTP id
 5a478bee46e88-304fa546886mr819741eec.9.1780091908791; 
 Fri, 29 May 2026 14:58:28 -0700 (PDT)
X-Received: by 2002:a05:7300:2201:b0:304:d8cb:8424 with SMTP id
 5a478bee46e88-304fa546886mr819722eec.9.1780091908232; 
 Fri, 29 May 2026 14:58:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 13/28] target/hexagon: Implement siad inst
Date: Fri, 29 May 2026 14:57:51 -0700
Message-Id: <20260529215806.608770-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXx6Z4ls9hIP50
 yD1YY1UT9w5nBfN0yO89Yr1KCPr5yQdYnKTKFtN/2h1HwZ2jhVaNOBhDovAOw+TKAH9nNXV2DeS
 a3tSB3dgUS0wLJKaZFEfhpNrC15l08Fgbb18URFxpyTHB7NsPRi9lI3Np9TNcsYnayFSDWzq1JL
 FXF6eE56fjK76XHZD+XyGEYB7vIIhpWKS0c47V4DXzkAe6/Dg3vMtkEzfA3g8GjbEGoYgEPa1mX
 xfb4Ml006lqxeCkUblODlNAChXYum+AJlfEvpP0qmYgXtVCa/Ewxv6F4x7cNvB7yQdSQxjgUvEv
 e5soPWiK57fqa3kDA1dbVQmB8l2jtu0lpHmS9dpyGVk8Y0vpWAeh3qc11Q3nRGdvtc9H0E5BzBV
 MoIxr6Hx4bX4kb9AvZ/BkOJt6kayy5Fa2eeaon1mSQkNyiqMpxIB2WHoL8RZVQWvSzJ7iVPqFjm
 lc9HBcyRqH0cVGor+BQ==
X-Proofpoint-ORIG-GUID: NRlGtk9tZCMxqJvbsRw5BgM04MyLE52L
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0c05 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NRlGtk9tZCMxqJvbsRw5BgM04MyLE52L
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNmJjODI4N2U4ZmUuLmUz
NmViMmRmODZkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNSw3ICsxNDM1LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

