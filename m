Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF48C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqc-0002wh-Cd; Sat, 05 Sep 2026 14:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqX-0002vJ-OD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqV-0001hc-HX
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbFOk3287754
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1MXLvXdTZUOvyFJWz3OwURhZ/931BfIncu9eQqQAJ30=; b=pzVns5/yhiuL0OqT
 2c+h2zaZoJCnT97Y8ELhuugwj1BFOj85c9LQjwXo4N7yFzDHZUTSXEz7r2eYUSl5
 gRdlXbcvwWKCQHmwWkh5QrMjXjmkGjfpyCiVLCjIrjY6to+cfuN9Hjrd5FSf6Cej
 cXgtBz6IGq12BqeBlkuzzfjdS36jhymY8J8N5glk9t/9sSyf79P+638oRnIvqRta
 QQ8XQ/Y4e4OJ0bAf0IsIrExKGlPJ9gimpV7Vb3oKmlDXFFrXQuZyXnFe0pgUj1LZ
 dwiog9xUkWHyjE1MYDVdk5HPcLL9yCwwbSOqFcx6ZvEb2+FQP1hbCEhm6ew8kp68
 xgqp4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga3721ud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cec4226c70so25043275ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631829; x=1789236629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1MXLvXdTZUOvyFJWz3OwURhZ/931BfIncu9eQqQAJ30=;
 b=a5EMcV8clRiKr+y6NASjk/T+EM9x1pEaSmSShMTnraRSoWyQjH3Vzt1qjBDHD0Fv4t
 Uv25krB+WkMQGWbo6zp1+XhtydqHKEBOOrsa/hg7hjIc7JJgoyr98d2UqDnobDOY/ELW
 t9q5dn6mR3E7mKvShwAAPWAUlcl7nQgiXLiaAjo9emDTUjWOv0sxPfRyQYVMFVqhtWvH
 49bNTSaGzoqINCfG9gjOvzLRM36IOhyH5DWXwkLUn+wsSXe71IzTJZd8n/xwtH6SW45R
 zws+iBEi9JYCdH+gg6syRIngUSiqUp/iR57mBmwz/KhXngLWMYiHCd1fQmFyMmjtiyNT
 DArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631829; x=1789236629;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1MXLvXdTZUOvyFJWz3OwURhZ/931BfIncu9eQqQAJ30=;
 b=MtrzLuM4PdDmb9aOgBcUAAPBj0Q7zXNGEWVyriE6CkP8H798BLNPlX2KPJ7kLPfJjG
 osIiSFxlfkq1qXARb5L5aZAAO5mLHhbk983jcbN8P0w6Ew7knSSRDcQ1acOxkYuKlj94
 wBPtluBxvfm5n4b+CdPsbo9r7AF27grjGcJ921Ra3H5Ai/+2QR1itSf5pb8gqXzEzKAm
 8w6GvJvSScpSigEfiF0wZr1E7GTXnVslTdisMcbNuPG1UetNRt19Z5GN4YH8oLqSanZe
 bqxLYpEH011iEKOVlcxcKHtZHzaubrHmIsWa1eCfT7Mmt6AUf0zcderSy9do9tujd4gM
 WJBg==
X-Gm-Message-State: AFuF++ltM7OQML7WddnBMe5EsKdJk4qfuRsJYCdd4RrkrCndlCIHO57x
 0+bLuJ6UdMhPQn7qxACC00/BwfNKXnRBRb2FCsmR6FW5DOat/MvnmSLNbdARH6/h1VjIr6C4GxR
 kXunZU/b5rDbp63MWbVfR8Bid4RHGy3EWDiTZ4Y8DqBrgQyCN63+KUN6UrmUTlB+Kng==
X-Gm-Gg: AYBFou0rFk250mG94vHvuDY/Dk4yKMPMBj3+kRIkC9VhXUmm9uS2PpRWjSq9zh1cmpd
 cxx7GW8M0F6qwE4pMazrjZsQPdMBWqVSCZwz0fIaCUku2Xjhsul1FLvbbETnjQNSvczie3AkDWU
 xNlzrSr7zZp1ENK1LOFfgr2UMGibNPvOnx5+gaxCFzHqwTmxkmZTGrMMbboHZFCzrPCPyfKDrmL
 l8EIP2QLR9AnIzdjz/s1EUmmslhTBfP1E1Hez3IAI+gbytBCN2WGrNjPnwNcUtuOHst6WK3VJow
 PieqseUnp+oDgDw0Ls3kwbgUstU5vH3QQ18W4wlwOSN//SsBJFwpLoMsyF++0nwJW98VQMfS7be
 hkJEcqW1jnDlzdXmWMX3ifHqapwxzBhpdSmGd1WTsEakfac9I
X-Received: by 2002:a17:903:3905:b0:2d5:2f49:b3f4 with SMTP id
 d9443c01a7336-2db1231fb56mr226188385ad.2.1788631829107; 
 Sat, 05 Sep 2026 11:10:29 -0700 (PDT)
X-Received: by 2002:a17:903:3905:b0:2d5:2f49:b3f4 with SMTP id
 d9443c01a7336-2db1231fb56mr226187875ad.2.1788631828744; 
 Sat, 05 Sep 2026 11:10:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 14/17] tests/tcg/hexagon: add predicate register transfer test
Date: Sat,  5 Sep 2026 11:09:46 -0700
Message-Id: <20260905180949.1852673-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: yakgpslW_H4Vo_vw4a12GsP5KRpDyYfS
X-Proofpoint-ORIG-GUID: yakgpslW_H4Vo_vw4a12GsP5KRpDyYfS
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a9c5b16 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=yBA84NwwydepxRIuKt4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX8AfrWBlYTLhB
 ANOWBZXfhHL7YxwGTrtnQVwD4TWarJkDWAS6nnIWZz+hZfHfYG2utcUW7EBgqH0ZRQYQNFNE+cX
 wyLWR0ankUA90Itzc+e0U78HPhtoUNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXyqudOeQEBW8p
 5f9G96MIkVm7LfyQrrjr+lsLa7lKyQUMVaNxUnQDWEnaOlRnb2JqLXWPZ8D27omn4LWQAAcz0co
 HfUrLEJ5KQNRTSZXLkrTaN2kOsd3xsANU3PVyAuiVUF0JBJLgxgsue0WNToXNc9j3pcC8XiruUe
 SO8w+Ez4PYV+NYn5Nef3S0pHWneieo/wuxPNupzzKfVm+ZAxRrj+IpOP9cKneYSU0uPQbvLEF6g
 tlau3zOD9pnNpZK8Uhg9inB3BxlDM8TdCOLh6pwtYdNZ4n2vtZet5uxtfD8kkRmdqI5MsKglSvs
 Vul+zIlj723+4C7hm0hIEuZpviQ8yvS10l4fAsQzBkAAtEx2Ce827dq8kwh5HZqQov2cCzfJbQ3
 YbNNBHAfARXXSfA5VtQ9Ok2RdlIcStwCqE0phKn9LxnNoDFJtIIB/xf+IZm6AY74cZEG+P6HFyz
 lA/pbnDsPyXrh3Ewoeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050201
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3Rz
L3RjZy9oZXhhZ29uL21pc2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYwppbmRleCBjMDc1
NDdiNmY2OC4uYWJiMzRhYjZhNjUgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2Mu
YworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKQEAgLTQ0Niw2ICs0NDYsMzEgQEAgc3Rh
dGljIHZvaWQgY2hlY2tfc3RvcmVfaW1tKHZvaWQpCiAgICAgY2hlY2szMihzdG9yZWltbV93b3Jk
X2FycmF5WzJdLCAweGZmZmZmZmZmKTsKIH0KIAorLyoKKyAqIFJkID0gUHMgLS0gdHJhbnNmZXIg
cHJlZGljYXRlIHJlZ2lzdGVyIHRvIGdlbmVyYWwgcmVnaXN0ZXIuCisgKiBUaGUgcmVzdWx0IGlz
IDB4MDAgb3IgMHhmZiBkZXBlbmRpbmcgb24gdGhlIHByZWRpY2F0ZSB2YWx1ZS4KKyAqLworc3Rh
dGljIHZvaWQgY2hlY2tfcHJlZ190cmFuc2Zlcih2b2lkKQoreworICAgIHVpbnQzMl90IHJlc3Vs
dDsKKworICAgIC8qIFNldCBwMCA9IHRydWUsIHRoZW4gUmQgPSBwMCBzaG91bGQgZ2l2ZSAweGZm
ICovCisgICAgYXNtIHZvbGF0aWxlKCJwMCA9IGNtcC5lcSglW3ZhbF0sICVbdmFsXSlcblx0Igor
ICAgICAgICAgICAgICAgICAiJVtyZXNdID0gcDBcblx0IgorICAgICAgICAgICAgICAgICA6IFty
ZXNdICI9ciIocmVzdWx0KQorICAgICAgICAgICAgICAgICA6IFt2YWxdICJyIigxKQorICAgICAg
ICAgICAgICAgICA6ICJwMCIpOworICAgIGNoZWNrMzIocmVzdWx0LCAweGZmKTsKKworICAgIC8q
IFNldCBwMCA9IGZhbHNlLCB0aGVuIFJkID0gcDAgc2hvdWxkIGdpdmUgMHgwMCAqLworICAgIGFz
bSB2b2xhdGlsZSgicDAgPSBjbXAuZXEoJVthXSwgJVtiXSlcblx0IgorICAgICAgICAgICAgICAg
ICAiJVtyZXNdID0gcDBcblx0IgorICAgICAgICAgICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0
KQorICAgICAgICAgICAgICAgICA6IFthXSAiciIoMSksIFtiXSAiciIoMikKKyAgICAgICAgICAg
ICAgICAgOiAicDAiKTsKKyAgICBjaGVjazMyKHJlc3VsdCwgMHgwMCk7Cit9CisKIGludCBtYWlu
KCkKIHsKICAgICBpbnQzMl90IHJlczsKQEAgLTU5MCw2ICs2MTUsNyBAQCBpbnQgbWFpbigpCiAg
ICAgdGVzdF9kcG1weXNzX3JuZF9zMCgpOwogCiAgICAgY2hlY2tfc3RvcmVfaW1tKCk7CisgICAg
Y2hlY2tfcHJlZ190cmFuc2ZlcigpOwogCiAgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIp
OwogICAgIHJldHVybiBlcnI7Ci0tIAoyLjM0LjEKCg==

