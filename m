Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AB2C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1odM-00050A-27; Mon, 07 Apr 2025 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odK-0004zR-6J
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odH-0002gJ-M5
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dpZ4017451
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 15:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X6WsiV3WAnDhq6R8jZFhwXEKmS+scYU94YlEcS5TmFs=; b=klpwq1B7Lt8p1LG4
 +6oAE/ZRw380r/B2yzMtLnpTPkrB6B75MJtBpeNxzjbt4kJmnldShWUVJG1zaaoj
 QzjADyQLXSIl+I4xY44Zd24lGDNLztmDsn9rV0V5LxWfwOoGgD+fTVxHAWPE0dKZ
 ggmFvhVPUZxGTR90z24BigAwZR4nqpIVfADKijMbRxRSHROcmYb+X7iHdL7s9HVg
 fcjzLQ1aoIWDAVSLdl9VAWITGpzDDe0jc2pzFjVE9Ol9nYEeShcfjABCqzGMcNKG
 /kKj/INrIlbB/6ZPjV0CavIP4JR4vwG7ZvF8L5KZPrlIprjleBA7SFN02F97SBQl
 kEz72g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3cpk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 15:43:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-736c0306242so6161588b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 08:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744040609; x=1744645409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6WsiV3WAnDhq6R8jZFhwXEKmS+scYU94YlEcS5TmFs=;
 b=TuWBNUuwyZBflVbUe6UTRJpfOA691Rk3wKvfQzVRiXvznBws57K3H7gC7sdckBEhFu
 tGgw44DyjSAjlridESSOS0eT9uxlaGv/KMn3szAZcgRw8J2VVaTGie/ec5uFzro0ewTH
 PKjMdXj42ZBS1AjDt4wqk3a7XLaCpQGJeaq0YQoeBzpyMelNhKX+tgwDYghoPUuj5+gP
 zxLpWeJnHBwvfLdSW+yr+XoMgGmwajR/u0irggQKcXQBzUzuEe0eUsbt57CPYl1628g/
 dm3OEvDPr3edM8BW6nAjdegjt0Abd/sbwR54R3X9VC/0rkOTygsrbJLLZcxypuzF1xvd
 WcMw==
X-Gm-Message-State: AOJu0YyfAIYAuSS+LAtPSZpOD4Ohiolxkg+nYUhx6KrtR3R6RJo/LifH
 0xGf8LOvLyoOtb2ksX6M82clLcwof3QXY69a9YLxCJr8JuQfNcLScTg/vjjav6rBWwFxbzjLmAl
 7mUQJvZgvOKVDttHxaCWWOpl2juEFr6nl7bYsVoe0cHy1xju1qkGAT5xXwzqwJQ==
X-Gm-Gg: ASbGncuZouQI0xYlzBoI98EAr9YGJKbFW5Tv5jPO3G1a0FRBMM7dm+0L0i4WFRCXp3k
 tR3zqULa8zUjMdE7XZUgd9sQRFnb6XPFWBEuc5mm5w0q6A+GfxL0VyCxK++DsmknK5jS5C0j7fX
 amZkyb7f0NpEhtNt5RELMGjkoYeK0QRJPcqn71oDJcWxRlNzqRI1t/YUh8tL1VeX3DNWD3+JuXk
 QBhbe1pNWzjWo08H92Ts14O6UVmMB9iFpBliP2wvC/hV+k4BS6jt/sn7qwIdIRXgKpKG0k/yW1/
 C5U6WU0hPW45LSW5X1AVcRD3yIKWvsevc5AKCjqMXHoI5u6eFNZAbEFHIq7sazJX
X-Received: by 2002:a05:6a00:b8b:b0:736:a77d:5412 with SMTP id
 d2e1a72fcca58-739e4b49c5fmr19988753b3a.12.1744040609139; 
 Mon, 07 Apr 2025 08:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQeAr9ajGrDQKjNop7jHbF4ikCA4GizpaCnuI6zn6rmXOdH/x0wk7LMm+cdDBS4j3G+VLh+w==
X-Received: by 2002:a05:6a00:b8b:b0:736:a77d:5412 with SMTP id
 d2e1a72fcca58-739e4b49c5fmr19988706b3a.12.1744040608741; 
 Mon, 07 Apr 2025 08:43:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee3fesm8681651b3a.37.2025.04.07.08.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:43:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 5/5] target/hexagon: Remove unreachable
Date: Mon,  7 Apr 2025 08:43:14 -0700
Message-Id: <20250407154314.2512587-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
References: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: yLwZWNWBqq89tzbMczP_ddhT569_2MdF
X-Proofpoint-ORIG-GUID: yLwZWNWBqq89tzbMczP_ddhT569_2MdF
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f3f2a2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WeWQB0ruK5ITHrmzxTQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=706 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpXZSBzaG91bGQgcmFpc2UgYW4g
ZXhjZXB0aW9uIGluIHRoZSBldmVudCB0aGF0IHdlIGVuY291bnRlciBhIHBhY2tldAp0aGF0IGNh
bid0IGJlIGNvcnJlY3RseSBkZWNvZGVkLCBub3QgZmF1bHQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
ZGVjb2RlLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0
L2hleGFnb24vZGVjb2RlLmMKaW5kZXggYjVlY2U2MDQ1MC4uMWRiN2YxOTUwZiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMK
QEAgLTQ4OSw3ICs0ODksNiBAQCBkZWNvZGVfaW5zbnMoRGlzYXNDb250ZXh0ICpjdHgsIEluc24g
Kmluc24sIHVpbnQzMl90IGVuY29kaW5nKQogICAgICAgICAgICAgaW5zbi0+aWNsYXNzID0gaWNs
YXNzX2JpdHMoZW5jb2RpbmcpOwogICAgICAgICAgICAgcmV0dXJuIDE7CiAgICAgICAgIH0KLSAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKICAgICB9IGVsc2UgewogICAgICAgICB1aW50
MzJfdCBpY2xhc3MgPSBnZXRfZHVwbGV4X2ljbGFzcyhlbmNvZGluZyk7CiAgICAgICAgIHVuc2ln
bmVkIGludCBzbG90MF9zdWJpbnNuID0gZ2V0X3Nsb3QwX3N1Ymluc24oZW5jb2RpbmcpOwpAQCAt
NTEyLDYgKzUxMSwxMSBAQCBkZWNvZGVfaW5zbnMoRGlzYXNDb250ZXh0ICpjdHgsIEluc24gKmlu
c24sIHVpbnQzMl90IGVuY29kaW5nKQogICAgICAgICB9CiAgICAgICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CiAgICAgfQorICAgIC8qCisgICAgICogaW52YWxpZC91bnJlY29nbml6ZWQgb3Bj
b2RlOyByZXR1cm4gMSBhbmQgbGV0IGdlbl9pbnNuKCkgcmFpc2UgYW4KKyAgICAgKiBleGNlcHRp
b24gd2hlbiBpdCBzZWVzIHRoaXMgZW1wdHkgaW5zbi4KKyAgICAgKi8KKyAgICByZXR1cm4gMTsK
IH0KIAogc3RhdGljIHZvaWQgZGVjb2RlX2FkZF9lbmRsb29wX2luc24oSW5zbiAqaW5zbiwgaW50
IGxvb3BudW0pCi0tIAoyLjM0LjEKCg==

