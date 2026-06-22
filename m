Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B508CDB476
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9W-0003aA-Bg; Mon, 22 Jun 2026 18:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9O-0003TN-6E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9M-0006Wd-IJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbCAV2122430
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=p5lM/IzOtDfIBFLr
 ljCni5huA7nvpkmp1rVr/lrcY0+P37vuAyLYeqZyViAw3BRtAI4hCeaglab97xnT
 CY9s8Bzrz/v0a5fqFcUtf4S+1pEzFRIEI7He22upVNWahipHW3LbzgB3gYEcr9Wp
 ugndbWdsAiLQFKXLFrvNX287F9FoMsDLsAnlksnIZVMDxdpOFGVWAXw3qn/1hQjp
 50kwJFPDHmz8OWjTa+Ch5Nq9DAg/oChbG85d0e4z5ZNl3MHIlbYg84IMdKI591If
 vUAKYBxqGThdBXOOK2B94tzSyLlsJQ6DT1zWFZIuhrAX6+Nh1xchOa/yB2DrZ2Bc
 cIh0yA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41xww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so11726163eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167380; x=1782772180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=F3cTKOYdtq3uz3KqWSXEL9XJwRBcvfsjPMrfykOrJx2MikA1CR/PcVNloorgN/hKYo
 sJ8EXwq8yKEvrtsfQzuD6xfsMgQrDdXlk3cVuhfDPSXuk7LE8d7r9PCiJldTrhAUG1Pa
 zoxrFd91B/SoMBEfYw0ZsSqYEBhS+TUaG9AvqyonRbjU4/zkG17zpnEZMD3eAFlhvZYg
 52eLQvR2wmLmyuGRMF1rG4aKnR8VKAdAZJxwqR+8mRjON/dERrtpu8G0LOd1QTcHptJG
 cCB3XBPL45IKHcFJm7IVuJiDcH/M5Zo/YAfdCCfHM2a5pmSkqdQ+IYUKCAUR36VdsUGW
 hW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167380; x=1782772180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=ZedBQqpvX4s22QAEAVzGrkmUyB17H7fjDFv/CIeQ1yrV1ydd+Qs/moLrixWcSkBa6D
 CvdT4+VZA8LcAhxMlRU0jQQPrgQeX2iXqE5TTSvVsHastBxlsrQxK1cAq9oAdHuQDqz0
 TA/nN9a8n+lzL93GHDKLy60ZYOZzfsslygHVtrWTgoTuxWFe5WF3Ga+73op5MX6E7tdn
 J6GzuNy+DPz2+aSYbmq9hXGY9qCgofvalFF4zSHzEWp3fMxG7o+K19ZWt9kcEKc3irHt
 GdHtr/nBhsuQmdeUeLbF6SpwkPM8b6bH0Qt+bXQkOYB8z8zPW1VzqHl/wq/k8XJnmY+P
 KXqw==
X-Gm-Message-State: AOJu0YyqAXANwrbK5LpXx1tItDadlfytJrisH47isz9budSaBed4ZNgx
 N9UCUetGQK0zXCOdd2e/yBAWSQmXWVMt+djc8fNdmZYeJMJLHYyVNQOSJ4HmdGXUNxQPIPT6e5h
 eL6SuHj3q4FtV2ALUq56rv05rapaq34FWgr6WSErn1PyXaOsjI0T1Gz8rjYEOYS3/5w==
X-Gm-Gg: AfdE7ck5FpWyLyuc8TP35L6zi5C9srlimjlGVehPdVuCui5dH7420ysFYx8Bl1UX+ZI
 jP3VozimgmV9zqtHRHkP1moT9VXe0okFMvTQZ1c7CU94EDOiEKkws8908N+ntiUF2+UK23tZP2n
 +HCys/sSu6kaHqlxsm/f26iFvd8C04BojBpCTEBN8iOnLNzSYKllqDBBuhJAUU4aa01oIWxXkLI
 lnpIHfRZ95BuPyXoUTZkhT3zZ4eoH/OwRh+0S5AFW2b0Wx8dk3aMX/Fja0Quni+37ylOY77nECK
 BiORJwpsuUUqWOlcP/y9qpCOG9eG7p9ptfRQ07fDBJTxlHtFJ9sJsiOyz4TA3KV9SmLY2ws26bc
 t4fuP9goEw8kvcuz4y/PdHa2uRFJhfswK0TF1ZutSvSHU14lnY2n86LfqtI0=
X-Received: by 2002:a05:7300:6ca7:b0:30b:c502:23e8 with SMTP id
 5a478bee46e88-30c070057dbmr11440581eec.21.1782167380464; 
 Mon, 22 Jun 2026 15:29:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca7:b0:30b:c502:23e8 with SMTP id
 5a478bee46e88-30c070057dbmr11440568eec.21.1782167380023; 
 Mon, 22 Jun 2026 15:29:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 20/75] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Mon, 22 Jun 2026 15:28:09 -0700
Message-Id: <20260622222904.607771-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXwzkds/QfU4Rv
 njpk+X3ta0Og2hUyfsCVxdW+6vPjactGIebxJwqNcGWVqmKwmo4VPejCnpQYtDLARZaHOZBGM/d
 2rO85CGyrv5rfT4/2TFJ0u8gnH46mHQ=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39b755 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pE6T3r0mPR0919n6eCuuPn_dC7v6Ky-k
X-Proofpoint-GUID: pE6T3r0mPR0919n6eCuuPn_dC7v6Ky-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX9QEn+tx9Wnql
 eoVrPhoypn67lh/ewZJpBYEEOAFfj1+Jwuc6A729NO5jFjrxk8NhDvehZ6zqIIOE6lqs5vC6AnM
 hQF1gFknAV0E6I4FqcJm1M56J3/cS3H56TiC/iPnx6QsaNl84Oyj/LChU3lZuFVu9B3hD7iey1z
 fhyUEiJGq1eAWgdVrUrLT+iE4nBbp3RcSTUiRDXIvA8xVWtSx4TPmV9A+7QkW2soenn7IS0hjyF
 hTLvibqDSKWFGeDtEt/48THKB2xKwFLlGObi1gVa6J8duhnB5Mipz++VAbgXIegj0wF7mwgX/d6
 WpXQs5greHQQtp7cFB3C2aeK+GqfibqNO2e5y6IyjrDfHV7zfTjdRtGgKGYSLRLH6pPKTKlRa8u
 FoBwWHewK2y8H+rlQB0hv4huYWHyxd3pe1m+WywfjsHERNJInogQSkPeIKrPqnPyhyGWmFeNQ2s
 Sq1c2QbFHAfXJltQ7PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBkZjhkM2JhNjU4Ni4uYjU1NWUyYjY2
M2IgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

