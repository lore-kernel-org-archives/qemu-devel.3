Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CF6C36018
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 19:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1s8A-0001jD-Al; Mon, 07 Apr 2025 15:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7p-0001gR-Dg
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7n-0002jm-L7
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537I3ah8015633
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 19:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=M1A262U7T2dEykVaSJOg9n
 xib35GvoWlzoxL7AoTDnA=; b=frBXxAqS8j71gLKi8/IaLmOtIru4JxXH8Al+ks
 U+I9oR1jkho7jBeDGa0zrxQgy306z2+yPfYzdn3yTXnLEuE9193ynNWK1YSsew1n
 k9VD8CVSNMSlCgES217dqxsGnNxBYQkWJnRQDOV7g8s28c/j+D+gP8oEuwIT9Q1M
 b8/CZUWr0WoQMUbSa1r1x62SzneJ6NRtKxWB0vmQu2pybKXe5LJD7rSHBPUlm6ba
 i7UlUUQJeWyV5TSZYdPNPLJZh5u5GjmgyXYOSNX92VZ9Dbx7eTQrF1iBidspjrTG
 nAqQlMt/tojG+w8hJD+2brvoPFQrhJ5G28BuayNkfbhzQRog==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe5bkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 19:27:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-73009f59215so5649046b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 12:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744054032; x=1744658832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1A262U7T2dEykVaSJOg9nxib35GvoWlzoxL7AoTDnA=;
 b=DWRV7rco0Mpc/vGACNiBcwPfqXMjCsHBy6lE3tJdYPSlmWnv926Q0skztRIBVF4/Ck
 iCu+AH3tD7MVm4+IJFWQg2hTzREBQtojG//w62DGyMLmI2q2JkSaxzJMqvBVDxkzUEwO
 GtPa372t4XPb9AoyfxpibA6efWWL5CtDvN9WJIBhsD4iGPD24Vii3KyyziLkSBbi2qcE
 3sQTU0hNiJu9dj++gVsUWXiU2IiBoQFQgjC+KBLFuHLHnGCrw2jv2wQjpH2tENuw2TYv
 zutmSEI0VxM3pVnGTKwkeW0ntKjp8HZIuQ748K+CKj15+ynaTyMwsZOEj9pPdr97JskF
 DgKg==
X-Gm-Message-State: AOJu0Yx61fghodnZaYYpRSIimRoe8e/u925kcTdbSL3AJt42H/clpSkl
 4U3drGyoqC5G5bdipgiYG2C3kvYCnZgd7Qxc/95hIYRy5gk63gGI9j+ChmAQrBygvDJXwY3WGw5
 hS8RQXs8JCj8oIYcMeQO8jjdtwXpEdNSXj68+/b1OWPOvtZw9X2ivf6x6zOq6Hg==
X-Gm-Gg: ASbGncs+qDCn0nR6b86xOBxnQAvniwdk8/jQTtIO55EzOOekykQsKR+lzsQWU+kfSWJ
 pvnSm0SAk01LU9rk2K0a0RKT3CHllLVPlwJyw3lNE5Cq57KZAVReSIyCFS+kjkDWEYX4sp9gMaN
 biQgKRRokEp+dYj0kFZZDzWXwecH2iNG/27cS4gAPCFCtgaNGwmZmfVIGzt9SiOfuWw6njcsVDF
 QRf6R1iDRpd4GbXe6H7pWlA4zAXKCHMve7UybE3JqdOmphMiYoeL1NlEhAIK/aapeHkdbvp0/ct
 BQGp5g8ShVdkdeYdBCC10spqrYlxqoJu+M5hB7qlmXrmbQSTcFA4+Xpge2jLEYR7
X-Received: by 2002:a05:6a00:2187:b0:736:3fa8:cf7b with SMTP id
 d2e1a72fcca58-739e7058e6bmr15068089b3a.13.1744054031865; 
 Mon, 07 Apr 2025 12:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR7CSKxIjnLsRAJXfht3nlvqJYo7VC3TKO4fSpeJ1ruqILPtSK+MSAF3xMTWjMDbwFBItOqw==
X-Received: by 2002:a05:6a00:2187:b0:736:3fa8:cf7b with SMTP id
 d2e1a72fcca58-739e7058e6bmr15068052b3a.13.1744054031367; 
 Mon, 07 Apr 2025 12:27:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee619sm9206559b3a.52.2025.04.07.12.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:27:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH v3 0/5] misc hexagon patches
Date: Mon,  7 Apr 2025 12:27:00 -0700
Message-Id: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 456Gwra6isULfA9dqhiAV3llClCpuchg
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f42711 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=H0ak6hV333PAyDiPeksA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 456Gwra6isULfA9dqhiAV3llClCpuchg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=858 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Q2hhbmdlcyBzaW5jZSBwcmV2aW91cyAibWlzYyBoZXhhZ29uIHBhdGNoZXMiIHNlcmllcyAodjIp
OgotIGNoYW5nZWQgYXV0aG9yIHRvIG1hdGNoIE1BSU5UQUlORVJTIChJIHdhcyBmb29sZWQgYnkg
dGhlIG1haWxtYXAgYmVmb3JlIC0tCnNvLCBmb3IgcmVhbCB0aGlzIHRpbWUpLgoKCkJyaWFuIENh
aW4gKDUpOgogIHRhcmdldC9oZXhhZ29uOiBoYW5kbGUgLm5ldyB2YWx1ZXMKICB0YXJnZXQvaGV4
YWdvbjogRml4IGJhZHZhIHJlZmVyZW5jZSwgZGVsZXRlIENBVVNFCiAgdGFyZ2V0L2hleGFnb246
IEFkZCBtaXNzaW5nIEFfQ0FMTCBhdHRyLCBoaW50anVtcHIgdG8gbXVsdGlfY29mCiAgdGFyZ2V0
L2hleGFnb246IHMvcGt0X2hhc19zdG9yZS9wa3RfaGFzX3NjYWxhcl9zdG9yZQogIHRhcmdldC9o
ZXhhZ29uOiBSZW1vdmUgdW5yZWFjaGFibGUKCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9S
RUFETUUucnN0ICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAg
ICAgICAgICAgICAgfCAgNCArLS0KIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oICAgICAgICAgICAg
ICAgICAgICAgfCAgOCArKystLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMyArLS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgICAg
ICAgICAgfCAxMCArKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAg
ICAgICAgIHwgIDMgKystCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVy
cy5jIHwgIDQgKy0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAg
IHwgIDQgKy0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwg
IDkgKysrKy0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSAgICAgICAgICB8
ICAyICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAgICAgICAgIHwgMjkg
KysrKysrKysrKysrKysrKy0tLS0tCiAxMSBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCsp
LCAyOSBkZWxldGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

