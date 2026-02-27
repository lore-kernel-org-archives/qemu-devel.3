Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C4A1039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4b7-0000Zk-6e; Fri, 27 Feb 2026 15:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4ac-00080W-7T
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aW-0006uU-Mn
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:32 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0HY13944640
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YodTnD6ppu2DH51r6DbFKbb1zgfn589zceRlGO5MluQ=; b=RUzEBe183cGHFVYc
 2qjY6nsmKhKB6htBUEF3+U6HnBNAXHChlxy90iOOptdr5P67PdIp85m3SjJ7KVER
 /WLRrpTsRxc8M0sUS2O1B+XLwUOG59uI8l9aH0r2Qxt5LFO/Vy6VmMYXxclZ/b6e
 MTPFk/s8EpJ05hC4sAhga3MtXkwy0K4pWWjHqHixf3qum2hPF5OZrWRjdhWi7pfd
 ifGo4AF+jC+Ggmf8gvRiC/ZodUgJRIWhGg9Ev+jiXvxzQHBI/yisbfqpPsQ3XIZB
 7xGG5w+M+x0IGYLYzIPJImIxUlNOzT/9AE5pLiPqhKkLgaEEBDAUX4FJpaZb3yOF
 EbkQYQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q2d7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:16 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d4c1b2651fso14980409a34.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224635; x=1772829435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YodTnD6ppu2DH51r6DbFKbb1zgfn589zceRlGO5MluQ=;
 b=EeB+avTrCTDf6ljhA21To+smoTWyV777rLT51SevTYIPE15edIiQHb552vkG8+bqPA
 eAo3GqScpYPSm3N67zXMcOcAt0vGLh/5sNqHSGm1PjSCH1ssnTAIz9LjK2UNUJN5SI6Z
 WYzTu8cA3psYIEr83jCqbNmjQAhP0pqYdzfG1E/h9zzXabnxIKhzc73VB/nNYSSyesJf
 4T10EaKed5YTR2vxsG7pSiebN098JMDhIveOSBdwFD4sWPogmG6yxhAfFya/rmAXQ+my
 wc51u8VwaaneBU08FuZmE/zpljjXZ+Tkh2p0rUd3uqHjjAa3pLKstHqg9It/bnRyL3Bb
 UG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224635; x=1772829435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YodTnD6ppu2DH51r6DbFKbb1zgfn589zceRlGO5MluQ=;
 b=goPA0Jig9hHnM2VN4yUSTiYeMztQ5QfN0yyqBRwsLi59/eGoOtURWkJ1C4td+5o6OT
 C7eEIxD+8awUetSoJuV+O4lDtKRpQT+4DUZ3x23sc4StkuQDvVW39RJHxWEGVqqT3Dy+
 cpoWKWjBVO9rZTFKL+Onj8rmJA9M7ZZuv1MLrp8VjdCw6xAPPYLA4C0QhSleO9Q/6agf
 tWLW4Utuioeq/zikMuW1PjbufyHJT+8tRlCAyx63XtYarSecyz4YS7xPlC2pSJNTZbp1
 6w39kSWln+UEgRCvII9cuw3/HelovutFg5BTwiaPVo0i4xEhHD9Cf1PlNJFa+aDiTeR+
 Pq8w==
X-Gm-Message-State: AOJu0YythZJ1opPAAwxgLatpHdWhZicCYjChrqtJfr948Q/f0/cBSPZs
 JQyFIbYxkOnHIkWT2QW1rmC0TmOslYPcX7eWtnUHSKU0k7PFD7Gj4DB9ZtuAe0zJpI2V7Wb7xlv
 XOBJh1IUBDFF6Q2xKoAJWLvYmICyo8wzxGZlsxFBIJ7aGbs+cVFkQbyxYfBICnaaHNw==
X-Gm-Gg: ATEYQzys7t14aG432j88yv9Y0EKa70KJKbbvDaNjwuOeRbBqsX0CV4rpFrQMKbs6+Nz
 7wcjiAOHaqciYrOEGjfxhUTGvTL4VghSGMGMrxGJeq/mg41WKv/ycbe9hZKltVqOxGgvq0xmZ8i
 JxwwiOY4rQUOF1mdy5FDgN19eYbaTgTcmUw4bs1RiEH9Zi1EZCS05BCEwR/GCoVac2CWxXBV5bk
 3y/PzGDTo4rSUNZxZOCLdGyNh76HldaOpytZzG5waHVKJ+x0bqu/hLxjsgl7J/FnnvbScjmIrcN
 F9PlW/2losq5DG5K4yVROI7I1qoIfmxyTB90i080GErFDSLYch+1itNB7Y4Ji8ZUr5KpU1hL66/
 Yuclz+4nk9W1gIYsIcesWGjUAHL9xpKwge3qxHWNUJP5S/Pj2ysmjJsOnzxI8Vhp98Je9BA==
X-Received: by 2002:a05:6870:b30f:b0:404:3ecf:9ae5 with SMTP id
 586e51a60fabf-41627093766mr2746396fac.40.1772224635405; 
 Fri, 27 Feb 2026 12:37:15 -0800 (PST)
X-Received: by 2002:a05:6870:b30f:b0:404:3ecf:9ae5 with SMTP id
 586e51a60fabf-41627093766mr2746382fac.40.1772224635005; 
 Fri, 27 Feb 2026 12:37:15 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:14 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 33/37] target/hexagon: Add {TLB, k0}lock, cause code,
 wait_next_pc
Date: Fri, 27 Feb 2026 12:36:23 -0800
Message-Id: <20260227203627.932864-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX4Gg5piZ09fnO
 cRjemtkpgkypuQNYGu9COgNXqbJEc348bDKgs01csQA1S+tCu2lqr5O2LLNcedzQlfWF5XMQGUT
 9zAU/9ok/xMDcVUvsamxj62cCOqkQC2k0OMnzwbPDHHJd9ETLVLTf9yYXhT32HGmUPbT2dnMm0A
 lcPbbtDZ3bXRo0kQRu2v5YORT3RdPX6sb4UtVCueGwuHFkJMenO9kj88cFqqWTTYEjqY+D0RcER
 o/nX9ULE/OntLevDCek+I96uSs+PotEgA846DhKu1NmZD9hB8rj5BvVkGG6ZFdXhWeOUZPdc11m
 WCqXTLi+H8mnfh1Q2WlAFcqFM/3qRF1oawyLvSmGL8rI524khlCjed9oca5NwrrRS38N6DY2ywL
 HIlXILuHaNdwM2nVfNH99joqzbtnRtzVmL/CaY0jV4RR2LdsTanDOIRdfTijfh6Pn68fvr4YwQ5
 WZWN8oEie7JNPoYtR8Q==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a2007c cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=u-CS0nqVCHpLmCmQHcYA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mB2UYlTQGeROqXLXuN57Mvp7qj08cW6d
X-Proofpoint-GUID: mB2UYlTQGeROqXLXuN57Mvp7qj08cW6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7VExCLGswfWxvY2sgY291bnRz
IGFyZSB1c2VkIHRvIHJlcHJlc2VudCB0aGUgVExCLCBrMCBsb2NrcyBhbW9uZwpoYXJkd2FyZSB0
aHJlYWRzLgoKd2FpdF9uZXh0X3BjIHJlcHJlc2VudHMgdGhlIHByb2dyYW0gY291bnRlciB0byBz
ZXQgd2hlbiByZXN1bWluZyBmcm9tCmEgd2FpdC1mb3ItaW50ZXJydXB0cyBzdGF0ZS4KCmNhdXNl
X2NvZGUgY29udGFpbnMgdGhlIHByZWNpc2UgZXhjZXB0aW9uIGNhdXNlLlRoaXMgd2lsbCBiZSB1
c2VkIGJ5CnN1YnNlcXVlbnQgY29tbWl0cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgIHwg
MyArKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFnb24v
bWFjaGluZS5jIHwgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4
IGUxYzY1NGRjOTNlLi40MTg2NWQ4NTNlYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTEzMCwxMSArMTMwLDE0IEBAIHR5cGVk
ZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdGFyZ2V0X3Vsb25nIHRfc3JlZ1tOVU1fU1JF
R1NdOwogCiAgICAgdGFyZ2V0X3Vsb25nIGdyZWdbTlVNX0dSRUdTXTsKKyAgICB0YXJnZXRfdWxv
bmcgd2FpdF9uZXh0X3BjOwogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5k
ZXggaXMgdXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHRhcmdldF91bG9uZyB0aHJl
YWRJZDsKICAgICBoZXhfbG9ja19zdGF0ZV90IHRsYl9sb2NrX3N0YXRlOwogICAgIGhleF9sb2Nr
X3N0YXRlX3QgazBfbG9ja19zdGF0ZTsKKyAgICB0YXJnZXRfdWxvbmcgdGxiX2xvY2tfY291bnQ7
CisgICAgdGFyZ2V0X3Vsb25nIGswX2xvY2tfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxv
bmcgbmV4dF9QQzsKICAgICB0YXJnZXRfdWxvbmcgbmV3X3ZhbHVlX3VzcjsKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggYTg5MDRi
NjUxYWMuLjc0NjlkOGExOTY2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzE3LDcgKzMxNywxMSBAQCBzdGF0aWMgdm9pZCBo
ZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBl
bnYtPnRocmVhZElkID0gY3MtPmNwdV9pbmRleDsKICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID0g
SEVYX0xPQ0tfVU5MT0NLRUQ7CiAgICAgZW52LT5rMF9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfVU5M
T0NLRUQ7CisgICAgZW52LT50bGJfbG9ja19jb3VudCA9IDA7CisgICAgZW52LT5rMF9sb2NrX2Nv
dW50ID0gMDsKICAgICBlbnYtPm5leHRfUEMgPSAwOworICAgIGVudi0+d2FpdF9uZXh0X3BjID0g
MDsKKyAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKICNlbmRpZgogICAgIGVu
di0+Y2F1c2VfY29kZSA9IEhFWF9FVkVOVF9OT05FOwogfQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vbWFjaGluZS5jIGIvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCmluZGV4IGU2ZTQyMGI5
ODk5Li43ODE1MjE4NDU2OSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpAQCAtMjQsNiArMjQsOCBAQCBjb25zdCBWTVN0
YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9IHsKICAgICAgICAgVk1TVEFURV9V
SU5UVEwoZW52LnRsYl9sb2NrX2NvdW50LCBIZXhhZ29uQ1BVKSwKICAgICAgICAgVk1TVEFURV9V
SU5UVEwoZW52LmswX2xvY2tfY291bnQsIEhleGFnb25DUFUpLAogICAgICAgICBWTVNUQVRFX1VJ
TlRUTChlbnYudGhyZWFkSWQsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlRUTChl
bnYuY2F1c2VfY29kZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVFRMKGVudi53
YWl0X25leHRfcGMsIEhleGFnb25DUFUpLAogICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkK
ICAgICB9LAogfTsKLS0gCjIuMzQuMQoK

