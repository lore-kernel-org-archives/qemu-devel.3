Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7267910F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqS-00046M-9H; Wed, 08 Apr 2026 14:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXqO-0003c1-IN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOz-0005aY-0q
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6381tMfN1795453
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wav1l4wl9Z+37xe7YwL+2nrdPy9SuIu6zj/PutumVNU=; b=i//3P2VW9kG4af4n
 eUu9OlyWlrmKLW5dDyugqeaC/CAChntodFWDgL0pEkbJUG43HPBluFunahFzDkRD
 BRtVm/6Zssiw2CdPs/wtfoji/wQlPm2eD2LU0053B+6DT0O4jIN4zyDMqhRtBU9B
 xZexVZ9J0RKtob5q7j9fDLHuvHLqFE+194j53ApbO8DqJ6nWP+p/c5ixfUbLcWDG
 BdyzkZG9lkKfeeUCEq1ch96OTt2lpwkxD578cT7PJ9Fb/A7k+76j+iw92TH7XfND
 eXfjo5LCjav8b3VJKygLx3NWWzVeOJ9kBopCFAY/gQUOwBCmE/QYdmHSzaZ7c4SF
 1pA8Cw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51da8vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c06d061abso4630000c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622020; x=1776226820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wav1l4wl9Z+37xe7YwL+2nrdPy9SuIu6zj/PutumVNU=;
 b=iMiXDSR19QNXXfB0GhbtLEDcDUSfUj4nSVr4f8scRamTuCe0brTRSpSEDDzR0CTk6/
 6N0MH4SRzTesDwtiwgFoj8idl+GlQ8xgTYI8PJ4V87sHhWucILIBvv3LwLD2Sxr5qur3
 QR3soy6PHe3DdPGJIj95BY1isTJL7FkBsWazhobCo5bL1/SB7sVkKxf0DFfLXZIfPeNP
 tUCy6gVIP3PZF6Gj7EKbQYlL0kaIHfUzydx1Sq8u4PShUrccMUTJSXDEBZg/6f0cPT4w
 zApOWP/K4CDhWtuUfVQutCt+5gGlKlM05h0rBpKWT6U+CORrzCmZaOiZx7KnEQPDnuTe
 fBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622020; x=1776226820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wav1l4wl9Z+37xe7YwL+2nrdPy9SuIu6zj/PutumVNU=;
 b=C8xTz6H6uDHNuzOzYGdZ6CbiL0stAPnbwxaBwa8QMosAVjbgn8brZ8oX8zSXdvPDOW
 rDuIAgr9KjJAJZV7u1GkBRY4DifRNN+ty/zQniMADM7LhnFzSgJqNW1L5ZLnAIp2+dz5
 64A+JDhcjjPIr4ubz0L77a9yPxSA45IZWhnvdvXSCpXXl9dzqDi+YWKRvW8GzIxe7vEU
 X4WXALYqDMxlHzbWpoDMPK7TASc4ipxUrQAKwznXYmD8XIaZmwtknWOUVxkWRUBCi2x8
 kZNrEX1wWB5x73YI9Zv0LlqXDqrwnZrmcvgVcvRWzEe0OtppoWx/kEYE+52Wu5HJ/dAw
 4dtg==
X-Gm-Message-State: AOJu0YwKKuQ41wg3oQ3gAt19/yZEt/d2XEyb5098+REhf92D9kwFD8NA
 oMV3GuTFr5i4pUC17NjmVDKS82uevTx7mxJV8jePqSHjTT4MBVuxzmhcUAsgeT8ujldG6S8Z8u+
 DV9t/lB58Ffro+1MAI7jWhwVCjIhJEMovHKd9sDRSI+eVW5MfPVMy6JON/5aF8cnK4g==
X-Gm-Gg: AeBDievi93gqsT9w9MQB43kpMn1m5ttkTmiBFyIVmUSCWbIIrZJ936+hSdBeezFfdh4
 SeTC4z2V20wuQB9jl/LRs0MyLaWy02MD20vPueytGkWShqAKnypeVr3MiePYnGOCjw+PChY53j3
 6GK11X4qF7sFW2F4suUH7EoSFJt5aZU8tRYlUPLd+a6YkPRRyBsd1RaAklpb/sXEcvvWMRH/Be1
 B2uZqRiwtVGtUvxdEALXr/EmQCeGoiC9BkeBaTgFjV0EZST47XNLgOTYrN8LQULZwxCww+FLx29
 0pPNNVk+0Vc7xhawPyqrZSVj8Tk1hQifOCGjhmqEeJR00Qfj2AZF1hqAsJFQxqQ4HOO943gozC3
 u+JE91cXgUo/CvD0p1GxmXuZiyrG9akJ8/EChkDp6H/cj0Sx/3WEnZFmiz6qzdWXInuEmRQ==
X-Received: by 2002:a05:7022:6b85:b0:12b:f899:717f with SMTP id
 a92af1059eb24-12bfb6fb68bmr10049627c88.9.1775622019995; 
 Tue, 07 Apr 2026 21:20:19 -0700 (PDT)
X-Received: by 2002:a05:7022:6b85:b0:12b:f899:717f with SMTP id
 a92af1059eb24-12bfb6fb68bmr10049615c88.9.1775622019498; 
 Tue, 07 Apr 2026 21:20:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 11/28] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Tue,  7 Apr 2026 21:19:36 -0700
Message-Id: <20260408041953.1899532-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: rjpDAg5FYjAhpbWU7Pfmkpk2Nu741qCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX8YjfIfhbTZAB
 oC4GnkOjQMgZHBRJ1hUWGdDmah5Gw/8c2KPFDrGX1rWqLBO1aRbrkdGHevX9ZrGstc5LOEUoZwC
 wSriyJWPR54Ww7TYYNXwXyXE6glNfG82U2KIWOlmS2w6NLGn+8iBS+IaWW42JCbhp5nMkWH0iXT
 rX0GKpWJ4DNWfMORTi8N4f4EBhUX+4JUckG2WP8/Bz6wr6ml1id+hf4z6mswvXSz8WC3rzsVNGa
 1aGpxWMOne5DOhh6WGqgKZb3oPdR+l3UXbbJpCr7tEHp2k+R+dTwY5OUYT/uhopLS+YHz4IvX1l
 52iGwf5ESSyEoalfm3+EssrTgyIakZdKMkf4501TV0BcahrrwHOHvRHAhSmnbsnudJSIAVkJdJN
 ub3orQ2qzesa8AicyFdR/P/Hv1ApQ+aNjIr9q3J9ewvXnOgb/SVY8P0N32aDqsiL5Z2LDcR9DFp
 dVtnkBrucjmXsnvkXgw==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d5d785 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: rjpDAg5FYjAhpbWU7Pfmkpk2Nu741qCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4
IGEyM2NjNDc1YTk4Li5hZGFlNjY3MjkzZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQ5MSw2ICs0OTEsMTIgQEAgc3RhdGlj
IGJvb2wgaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJy
dXB0X3JlcXVlc3QpCiAgICAgcmV0dXJuIGZhbHNlOwogfQogCitzdGF0aWMgdmFkZHIgaGV4YWdv
bl9wb2ludGVyX3dyYXAoQ1BVU3RhdGUgKmNzLCBpbnQgbW11X2lkeCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2YWRkciByZXN1bHQsIHZhZGRyIGJhc2UpCit7CisgICAgcmV0
dXJuIHJlc3VsdDsKK30KKwogI2VuZGlmCiAKIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdv
bl90Y2dfb3BzID0gewpAQCAtNTA1LDYgKzUxMSw4IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMg
aGV4YWdvbl90Y2dfb3BzID0gewogICAgIC5tbXVfaW5kZXggPSBoZXhhZ29uX2NwdV9tbXVfaW5k
ZXgsCiAjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKICAgICAuY3B1X2V4ZWNfaW50ZXJy
dXB0ID0gaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQsCisgICAgLnBvaW50ZXJfd3JhcCA9IGhl
eGFnb25fcG9pbnRlcl93cmFwLAorICAgIC5jcHVfZXhlY19yZXNldCA9IGNwdV9yZXNldCwKICNl
bmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLwogfTsKIAotLSAKMi4zNC4xCgo=

