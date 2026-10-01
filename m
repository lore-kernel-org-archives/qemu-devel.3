Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC9DCA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJnI-00056J-Ss; Thu, 01 Oct 2026 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnH-00055p-9k
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnF-0001ye-3A
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsWY63986896
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oLm7hDQGBmUQQwooE6N5Ed
 TIL4GcdQtnzH0yPX+l44E=; b=QhmqbUxWnOTPRmd+w4wVcmsv1XqRoIRu0ZRfeZ
 Frof0yl9rRE4pA2ee8F3rZRV694zoBzQTBaRbv9GJJ3XdgM9L9QzwIzWJ8M/JuVS
 FqpN4ffjg3gTngPgU7ccgKTplFkxcGay/9ctJkVzazXe0LAmAIeXTQbmtvSz/c91
 RUTvFMsoQArhvaRu515dP0MWdZPwF7hca7/AkLm5eRgs/3mgnJaQUkGsWe7jSSQT
 L14lPFCvWLEdeH9tpqyimClwLc+noX3kYb/tL0BeTnMZ3hD7sD97ppuCUIyX3Tb8
 wrNuYZKWrAXSiS4w/GlAJee9xQu5/j4A2prASi/0QE37iTdw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkjsfe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:37:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so2243972eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790872678; x=1791477478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oLm7hDQGBmUQQwooE6N5EdTIL4GcdQtnzH0yPX+l44E=;
 b=MojbOezDtvVuNtnmkxy8o8I3NwVZOrcTybG4gLCgEAEBFzazIucfDe4Knw+THhNDX2
 yDIe23oRULRoeTAfqB7r3wAHTthWqfLmRmAMSPBHzwtgnTz8vqXwnn2Lo2KPL6MjQ/DC
 ZItx2oN8YEFOA5QrW6EeaP2PT2SkBNFoyyTPWTq/sbvodEMFb9hyHrX+GUvPHgZVrqe1
 uVHf+625dnWYv3WNNKqp6Pyd/EVp5/7Ekf+G6/An39qAi061YpOTtg4CTvl721VOpHdG
 HLN71fMwYYkPM0Ve3rHeiTjmok2zdPespgay2AjpKc+sqW1wbgU0PtZ98VaCiOnvSyxO
 arQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872678; x=1791477478;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLm7hDQGBmUQQwooE6N5EdTIL4GcdQtnzH0yPX+l44E=;
 b=bu86uzYzmXvFH4Ww6U5B+D4XW06RdVLriHijEmDtgD5uBWtFvhh47QHcdqdff+0kDg
 xvmWQVA3AfL0oSs0UqjjLT8dCItEjpkM/98P02YSVkS5jjNPhRfBW3KBwiFh3+B+Utam
 L7rHFq3xhevRil5FzY+SgtF7BOi6IiMsA3zWjxDZ4LG4AZ5hyRFfD+we03j+0LQiFrvr
 k9DyG/uHY3VV4N1QIECspWkh+I8SK9vGDehcpd6M4dfo4LYWgGpbmfYhBO4klQuXYWnt
 kMmM63IUEr0rH/WS0hMf6vmjg633jM1ZePTWp6F8FiDxUcoFrjKg62MlgecODcZspwGV
 +rOA==
X-Gm-Message-State: AFuF++nuYhn+qmH3y0Uu4BF2ZBxmTV9/Hj5guLCG+sWj1fCtlcUx66XJ
 x5wNRwg9X1+fstqv3wh2L3PETfPV4oecDSEbyzfCOYtz5Ae+Y3RDVVXilnAIixw/SrJyO9/6g5j
 h+a49wrlZNbHYDdGfG+aqqq049NAXc12vWrIhlbIvMB4NSGpQTmFjt5LWuIPOkFSwzg==
X-Gm-Gg: AYBFou1vSU7O6eJBmqkSfa6DeCDdf9UUv/WcrSau79kgW0XkaEmF2Hgwp/E7CgvVumB
 Ej4EBsSpKKiahHeO0dUcSM03bOkPC7vKvinD7BFy8XrHSsmlfWTk9RMVzlq6GGQBTc6SkdR9/t9
 2HZE3A7eyXT1lVOcZ8ehecgiYXYyZJLVdZgiRX2u478y7G26Xj838zPNLpS2WpHOWeoq5vjpRkW
 m5DV+kCc3AWSasBcQI8moir5OrdK8R5HOEVoIAOGwHX1XEy76oK61RT0jYr0GhruQ4G5T+0Kkv0
 o+xZY0eG3R0mBS0zytfwicTfuXxXnFfpVxHMyVeaxo9vSYqMxVTRdmTQSelnU7WepT0wH5hAci8
 zI8uhsM51aIDHnAzVSEZBBQeNWvdPiN6NyJfvdr+l1Fhea7n3pr/V3c7v/qPm
X-Received: by 2002:a05:7301:19:b0:33b:b0c8:73d2 with SMTP id
 5a478bee46e88-34cd917193amr5345778eec.3.1790872678109; 
 Thu, 01 Oct 2026 09:37:58 -0700 (PDT)
X-Received: by 2002:a05:7301:19:b0:33b:b0c8:73d2 with SMTP id
 5a478bee46e88-34cd917193amr5345626eec.3.1790872674841; 
 Thu, 01 Oct 2026 09:37:54 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f26bb14cbsm389846c88.7.2026.10.01.09.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:37:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Dominic P <gcc@gcc.dp11.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] tests/tcg: add missing tests after meson transition
Date: Thu,  1 Oct 2026 16:37:48 +0000
Message-ID: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX9qa9xtl0hlb6
 jTiW75LaWL9JnbL38Knn5Zjx/2wn0NFGzAkEQOXl1rl744CLFLe5cfuKFM5pl0NDFxj8TwtYTal
 HeZNqJ/8HpO8x1H9ZOmYYVFCfEKDY2Y=
X-Proofpoint-ORIG-GUID: 80t1P0MAeFHZTZ7K2hRFt2g5tiWvxY_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX6yfoCmCBtrd+
 xHCbLzTWPsnGDTzeVVXrBl6uOvzqWR31U725mluwenQ96cf1TcwFUkpPfUL1KjKczQUgWc3GNUJ
 bE5SRxX8VJg+SJfrwN5mXx7F2m0SHanELi88hrJakVK72EQ2KE8u/0fJhFxB4Yu6uQfHtt/GZ8V
 42wUtkBLhUnLfCUyYxXxj0RDKXIjNK7FHnrbHMR/e9QH46VPXxyJmC+/8kF3Fo1lnTleoEYwk24
 JoNmKM0z1tmICyE3HsxRMxcb3xiA0F1RCkg445RMhhUxxsWM14tOhdkgzAApqrMgCD9hs7ScmCA
 ldPo1FlaGv0Ii6dhtK4r4bIK3CvEZ1MACk9jGWgsgFz+pQYzLOvrXHPWZQ7qDuLifW7507BOphx
 ufGHJnp30Puo/aop0B0UpvkPVwBIeARZ1DddFdpWb1HSEBiicrKkqVvJh6Gf9Cx6SLb8Xf7Wg5S
 6Z40Pq3PDs+qhdLMJZg==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe8c66 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Eaw8A7sTIhzqGW7s0Q0A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 80t1P0MAeFHZTZ7K2hRFt2g5tiWvxY_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Those tests were (wrongly) skipped when we moved from Makefiles to meson, add
them back.

Dominic P (1):
  tests/tcg/i386: Build test-i386-opt-shr

Pierrick Bouvier (2):
  tests/tcg/multiarch: add missing vma-pthread test
  tests/tcg/multiarch: add missing test_pnew_jump_loads.c test

 tests/tcg/hexagon/meson.build   | 1 +
 tests/tcg/i386/meson.build      | 1 +
 tests/tcg/multiarch/meson.build | 1 +
 3 files changed, 3 insertions(+)

-- 
2.43.0


