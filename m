Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C23C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjSda-0005Wh-4i; Mon, 13 Jul 2026 22:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjSdY-0005WP-7c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:12:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjSdV-0002EU-Ul
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:12:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNml982845415
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EeteN9GuSGIkSwZSIuYGdR
 SPUa3dS/RxlgGLT754gpI=; b=Ygrw0LP2nKw4FXEKcUeo3KxAo+1eSG8eBH/rbU
 Pg3D4jKSn2YhQRkJHstUui71a17LqRoTMVIfHROeaWG4xI9NU7p3yegYUdoG7iAy
 UxYtKapt5lhyPEZkUA4Xp8qzqme9qg0tWUYGjIbtgQJMPpZu6vpPkBcQr9CSC8ie
 A882LfXCFUnd1E4cTXWUQmrhV8LyZcqvGVY6mdR/pd8SJehkx5SFvhb4igoDafyH
 PsJMVj8YBMTX0ANtpusf5Tatn6FVbssUY+o28CxT/0tMtNXm0yZpUFM6T4QWrNYJ
 F5nuB06KJ+4tq0647U2MTfn0/vwCSZXzj0S7ufUHf6fobs+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd7gvgrmc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:12:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so9672948a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783995158; x=1784599958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EeteN9GuSGIkSwZSIuYGdRSPUa3dS/RxlgGLT754gpI=;
 b=GSXzEEPF+XDoproIoZRW5GrWlPNWBeXVRz/oh3CQTpitPsKR63Y9Q5kgaVlWVr1owP
 vBl/8+g4bIAACWGdeDXTL0OhGdqOs4Kq1IFcdSlwcIg+pkdpaKsUDOm9UGF1xKxZ5+Ae
 feTYrJkEJqfNFYL8rr/0f5XUgTQiVPu0yLMfFPswwnwubIT3bzXOiv6ogwO9ZuFKjWmZ
 mMAaevvUG1f42DpcF4WzsATpnruE9j0iGRG25CjszUtz5m9wHqHCnTUDPoE30KEPPQ0a
 ingRC46CidQjdD7Y7d7skfbFlQIiq1Pql5LPcFizdZmp2rsq5liLGdpOB3lh4dcYmyvj
 A4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783995158; x=1784599958;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EeteN9GuSGIkSwZSIuYGdRSPUa3dS/RxlgGLT754gpI=;
 b=SFC7Wh7z1nAIxwU1xb4XWJ8dr80kchdytKhT0EMU3IQv6L1IgK/xXDUVMp+VUcAs6m
 JSAyJtrgUF3fo6wpGRPgVMGUgF3Nn06pVKe6YwDLA89naMA0D0UX56PlSHCeRU0Y5TYU
 JoH/JhYesU31Q0Xc0/PPcmBmp6ctwQnfo4yTDrv6EcAog/0VgpQ61lmrsKGFMCNh1I4R
 cG7nN8+wMViJ92sg9JsgPc113yQsKmOQEXK4FqOzT1eNAaj/q1Cq+HblgCgQr8C6sJTZ
 fYBmWsuhHMw2k2oHI472HugL11uLC5k2Efwvv8NBJ/GqUV/Qfbpw3a5w4Yuqj69hk2Qj
 W36A==
X-Gm-Message-State: AOJu0Yx38rR1HGmQ8fP8lYkEecqRueluJ+FXElrzvRwQtwhmUk4Kc4a3
 fr8wFBuccRGCtIB9xzy7qb+D0kPk+s2Puc9WtFmQPeYvpKvEOYNbAUKT+rsLiFNl1G4XMK+ZZSJ
 qhJG3W03r0YL2j6CAQXO4noPSlUWfoOXnAYJcykrrbdCTztFj4D0Kb5S//DvlCS0HLA==
X-Gm-Gg: AfdE7cm1RXxWKA8i2Rmy538X7n4ujBmsluFkz5CyK4033x9mWAUTDsiIvO9XuXxhFue
 +S3c3iObelbwdKEAHtYGOQeqBSjumRmaDAHcVs9LFGINUWP1jPwG4QuxVRU4xSC2XxTcexKbtWz
 zBVpjWX9WeKX1dR8F/o4uxI5CjjqUyTMghWDx3GSy8Yp2HqzviqfUkAPeDIIPRjFqXvNeNkV6/t
 A1L4QlSLzoTosFM/Iro6tVfO4xjcvPUvHNu0xKMZfJNU+gy5HeZw1nm8S+670W0rR/ySnqrexsy
 K9Vgr4iztCQT9XFG/lQ9LqUdSYTuIkYw8ecK3fM0pGPIJnNEPqtedVbW/+P8Oj0XOKAgZEeuZm1
 +m5LulWjeGPd4M6IHH8IzXaPXwvK38j31qKSiBrx2eha3Euff/iH5/vYpOgs=
X-Received: by 2002:a05:6a21:329d:b0:3bf:a638:4371 with SMTP id
 adf61e73a8af0-3c357313267mr315273637.10.1783995158446; 
 Mon, 13 Jul 2026 19:12:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:329d:b0:3bf:a638:4371 with SMTP id
 adf61e73a8af0-3c357313267mr315228637.10.1783995158023; 
 Mon, 13 Jul 2026 19:12:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm62706202eec.6.2026.07.13.19.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:12:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] meson: propagate qemu_ldflags to Rust link step
Date: Mon, 13 Jul 2026 19:12:36 -0700
Message-Id: <20260714021236.2361604-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxOSBTYWx0ZWRfX/fBKJpmx8LsD
 uaBsrqS0VAc6cpoNwU+AMPQY7yWYSpHA0k2rS9rzv9Fy3A6pm/DGuM3+oCZKgi0ptaIVR5/hLt4
 Py301LlN1n2ImdcPH+84zahssC4XWsb95MHflObXNJY8MtCvWa3D0p9miDVRBUH7IrLpRvYUIc9
 5TAVFaJ/xo5bqlqNeTPSvPsVLOkr9U6fXGOMF/0f2ot6cdgEqJwj+U3ppCaDlo0Lp/Z2pRrouBl
 vGKtbkJHHjb26r7qGsnbg7xhMDD3vh8Bw2X9hrsu9rNhVWArT4g4VcmxWdieQXuxB8/gmoczJL4
 D69B3fdgfeS7reswA7DsbLabXKAWeayeP8DSqwwJQrwkwgtPciJ85pigAFqLgifg/yhWUMle7UA
 CzBoCUJt2YPlIPJv8wn4qJDmF6yXO9eOS/tpCCJawx3YEK2HI65GhLT1Ya3/dZzMmi5KYlKFBqw
 4HVwg17CG0VX5EhA9zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxOSBTYWx0ZWRfX12TLNzbPMYFo
 kzNJCjBKR+krbNML+iodx0UssEwCT1tEFgw1tEKAiEI6hYKRulrPWR0TTihs/kHmXDssWuiYrw7
 Wxc+k8Ci+0UDptOjVb7vSkamZBHh/LA=
X-Proofpoint-GUID: u_dp2GyJX2yawadSMkcCVJrS1Z-G6wIU
X-Proofpoint-ORIG-GUID: u_dp2GyJX2yawadSMkcCVJrS1Z-G6wIU
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=6a559b17 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ys3snYJLOefIJBQsk0gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

U2FuaXRpemVyIGZsYWdzIGFyZSBhZGRlZCB0byBxZW11X2xkZmxhZ3MgYW5kIGFwcGxpZWQgZ2xv
YmFsbHkgZm9yCmFsbF9sYW5ndWFnZXMsIGJ1dCBhbGxfbGFuZ3VhZ2VzIG5ldmVyIGluY2x1ZGVz
ICdydXN0Jy4KCkZpeGVzIGxpbmsgZXJyb3JzIGxpa2UgdGhlIG9uZXMgYmVsb3c6CgogICAgLVds
LC1ycGF0aCwkT1JJR0lOLy4uL3FlbXUtbWFjcm9zOjxzeXNyb290Pi9saWIvcnVzdGxpYi94ODZf
NjQtdW5rbm93bi1saW51eC1nbnUvbGliIgogICAgICA9IG5vdGU6IHNvbWUgYXJndW1lbnRzIGFy
ZSBvbWl0dGVkLiB1c2UgYC0tdmVyYm9zZWAgdG8gc2hvdyBhbGwgbGlua2VyIGFyZ3VtZW50cwog
ICAgICA9IG5vdGU6IHJ1c3QtbGxkOiBlcnJvcjogdW5kZWZpbmVkIHN5bWJvbDogX191YnNhbl9o
YW5kbGVfdHlwZV9taXNtYXRjaF92MQogICAgICAgICAgICAgID4+PiByZWZlcmVuY2VkIGJ5IGV2
ZW50LWxvb3AtYmFzZS5jOjEwNCAoLi4vcWVtdV9iZWZvcmVfZml4L2V2ZW50LWxvb3AtYmFzZS5j
OjEwNCkKICAgICAgICAgICAgICA+Pj4gICAgICAgICAgICAgICBsaWJldmVudC1sb29wLWJhc2Uu
YS5wL2V2ZW50LWxvb3AtYmFzZS5jLm86KGV2ZW50X2xvb3BfYmFzZV9jbGFzc19pbml0KQogICAg
ICAgICAgICAgID4+PiByZWZlcmVuY2VkIGJ5IGV2ZW50LWxvb3AtYmFzZS5jOjEwNSAoLi4vcWVt
dV9iZWZvcmVfZml4L2V2ZW50LWxvb3AtYmFzZS5jOjEwNSkKICAgICAgICAgICAgICA+Pj4gICAg
ICAgICAgICAgICBsaWJldmVudC1sb29wLWJhc2UuYS5wL2V2ZW50LWxvb3AtYmFzZS5jLm86KGV2
ZW50X2xvb3BfYmFzZV9jbGFzc19pbml0KQogICAgICAgICAgICAgID4+PiByZWZlcmVuY2VkIGJ5
IGV2ZW50LWxvb3AtYmFzZS5jOjU4ICguLi9xZW11X2JlZm9yZV9maXgvZXZlbnQtbG9vcC1iYXNl
LmM6NTgpCiAgICAgICAgICAgICAgPj4+ICAgICAgICAgICAgICAgbGliZXZlbnQtbG9vcC1iYXNl
LmEucC9ldmVudC1sb29wLWJhc2UuYy5vOihldmVudF9sb29wX2Jhc2Vfc2V0X3BhcmFtKQogICAg
ICAgICAgICAgID4+PiByZWZlcmVuY2VkIDExMjQwIG1vcmUgdGltZXMKClNpZ25lZC1vZmYtYnk6
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBtZXNvbi5idWls
ZCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
bWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCAxNjQzMjhkZWQ4My4uNWY0MmJiZjQwYzcg
MTAwNjQ0Ci0tLSBhL21lc29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC03NjcsNiArNzY3
LDkgQEAgZW5kaWYKIGFkZF9wcm9qZWN0X2FyZ3VtZW50cyhjYy5nZXRfc3VwcG9ydGVkX2FyZ3Vt
ZW50cyhxZW11X2NvbW1vbl9mbGFncyArIHFlbXVfY2ZsYWdzICsgd2Fybl9mbGFncyksCiAgICAg
ICAgICAgICAgICAgICAgICAgbmF0aXZlOiBmYWxzZSwgbGFuZ3VhZ2U6ICdjJykKIGFkZF9nbG9i
YWxfbGlua19hcmd1bWVudHMocWVtdV9sZGZsYWdzLCBuYXRpdmU6IGZhbHNlLCBsYW5ndWFnZTog
YWxsX2xhbmd1YWdlcykKK2lmIGhhdmVfcnVzdAorICBhZGRfZ2xvYmFsX2xpbmtfYXJndW1lbnRz
KHFlbXVfbGRmbGFncywgbmF0aXZlOiBmYWxzZSwgbGFuZ3VhZ2U6ICdydXN0JykKK2VuZGlmCiAK
IGlmICdjcHAnIGluIGFsbF9sYW5ndWFnZXMKICAgYWRkX3Byb2plY3RfYXJndW1lbnRzKGN4eC5n
ZXRfc3VwcG9ydGVkX2FyZ3VtZW50cyhxZW11X2NvbW1vbl9mbGFncyArIHFlbXVfY3h4ZmxhZ3Mp
LAotLSAKMi4zNC4xCgo=

