Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B28F8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVvN-0000lC-KD; Thu, 16 Apr 2026 19:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVvL-0000kY-UQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:15:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVvJ-0004Lz-Ig
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:15:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GFtWv14125029
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=XTGOogkbx9g/fa7NmrQM4G
 zqtBnHYYrq1VWtgzXTkAY=; b=SClb0TKUAnsrtoexinll6pnOqiv5+MAt2MjpV6
 VpuUxTG+HSWImalJcjO7SktmOe9Ui0wL9t4OobByyUQQaiNxMzBXfzGAa1diFEHF
 4V2MweUHtNfP22pQ7pFxRbYRerjggBLjtaQnOwWvqDle3TUKIXctenjZKD9SKh3l
 rOgESNI1UJtAmP/LyZASE1j7V5oiVAynMfP+EzbULU7aN+04pBTCwjJQmq/9c6Lz
 msjn79Xuqncqplpb6A73gXSrAStuVeIjGMOnd7SjQwEUfLcuyDLzDOEOEZQ/mWO+
 /lS3OJsXibMun1wYk2l/Wq5B8TaBqlChzrghADOJZo4vZj8g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djvrfawux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:14:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b249975139so1597355ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776381298; x=1776986098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XTGOogkbx9g/fa7NmrQM4GzqtBnHYYrq1VWtgzXTkAY=;
 b=DFYWeqK3c/5YYcVXX2Z1gSFdPawM3hoAks2Y10J7jcPPOn2FU9fzvGwIiabuCNsZjn
 ZmwxDbgoTlBkx/Yp+0gmx7SPbbIYya6bHjHSnaFlfnEMqwEoO6TY1EM/F/wPQzQH8Kc2
 NMiYlUdrsEynWn2X3BLYU1cjmFWbu0lTRbLAIHPlYdoIPuuL+voSfdDRYT5szyAuwHS5
 gtMU765zhTE42Zsg1zC2Nx8o0zxVyGV7LU8bbclAPlVVmu+O3p0wJXtQaUEtbb82HV7v
 aNXYv/NI70aITGNq6sd1FkU8QQvjnpHNr04cPl0Gt7sz1QFgoUp6Ueg8pDTJPiPmmv1f
 Wntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381298; x=1776986098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTGOogkbx9g/fa7NmrQM4GzqtBnHYYrq1VWtgzXTkAY=;
 b=qLQ43XWOVX/9aT2Hz5+kOjhDgTBXDQzKYboxfpbjCjwpczPdpXqgEViuL1cmwbEQM8
 ri9b5LlCWTKtunxMcbX2bsyQ1JEkRpVfjp8YtRq8RnbjOurVMj3rQKv7mwtn5u8GFkZB
 xD1wCBgCkcsTKcS1YY+PP1GO12d2bNswNqsuaCVk7s9VpRTtzZH1cK0U4JKmbnAX63i5
 dSMu9hGwnGmjR1ugcd05EVwL6yda3KuIQ6Kj530gKOGkyiKq3zIFCTXfgPQTy7uOB/Y+
 fDTpzJGdXOZ07oxaSjBPZIvEZgATBbaQd/eL4/qJT/iliTXqXRMr5Q1Q/BVutsAmUbWx
 nm2A==
X-Gm-Message-State: AOJu0YwpMYf8/g4rlZC3WjpZitGQ/Z4x1mMWatiXasu0INHgxThNj1T7
 6i9wgPtGVm/QcvBAlO2TRRxW5XaEHyBCZGNL7rXxpUKxCwdwtxTsFoMGWaO21X6wo8OOCLgtVYT
 XxVYNewk92Wr3QxhNAHvQ4nS3bBC36peYAe2SEfC4ka4CAu17w+zsWSVpk3wloU/ARg==
X-Gm-Gg: AeBDieudLn3dxQsGRbdVcUcvgVRREvScAAA8S3qvdkWchp1zTYftSHD0AzpM9FN6N2W
 +ncgr+vcZ+VVH7VuT/nlwQvDm3nAPZodI07oCpHdxZtduWqAliSdlLueW6/VPGmz+/iG0UXoLMd
 llj3iCxxVpQS5hRakgAZ+xu9vRbrBtLCE/jsPWIQRupc5ZdD+JK3LdEga3YvMH3A56HkSm+n+LA
 pHXr1UeQ2DGPnn0Ph2bfgTIf2uh/jU4gyZEwUh3cJrv+TKTmgPhiL2Gigd/c4e/h/CoGg1ar3za
 mcMByo8c8s1JkU/Q7TKUBljEgo68V07QgpcUg9Op6vQ1LNPkyMngGwVDa7352xlRhVnArRDitAZ
 zJ1dHcyRHkrctfwavZA2q0mRTs+b4jGT/M5WU7Q2Yuym0/zPt6HsC155wL+S/4D99s2KAb3ac8c
 +KY24YjeBEscph9xDILw==
X-Received: by 2002:a17:902:be10:b0:2b0:6f21:8289 with SMTP id
 d9443c01a7336-2b5f9f7d451mr2255325ad.25.1776381298401; 
 Thu, 16 Apr 2026 16:14:58 -0700 (PDT)
X-Received: by 2002:a17:902:be10:b0:2b0:6f21:8289 with SMTP id
 d9443c01a7336-2b5f9f7d451mr2255115ad.25.1776381297963; 
 Thu, 16 Apr 2026 16:14:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff8d6sm11615ad.1.2026.04.16.16.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:14:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 manos.pitsidianakis@linaro.org, Mark Burton <mburton@qti.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/2] MAINTAINERS: update address and add Hexagon reviewer
Date: Thu, 16 Apr 2026 16:14:52 -0700
Message-ID: <20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Q3l9ON2givprUnCW8Uc3loXVuHVzmhTE
X-Proofpoint-ORIG-GUID: Q3l9ON2givprUnCW8Uc3loXVuHVzmhTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyMCBTYWx0ZWRfXwYr7sOV7OXwW
 g2eC6ZbHVIZ68wNdSey6rWYI+kbyFy2yd6yYrZWQmt+8dlyX7C+YtH7c4xr3cKiZzoMRKiJWePb
 WW6FrAMjdVFAXlrRa8EuDd95Z3Yauq9Gj/DnswDpdbz/LWcpZ+rrPGyic3VEgFNbh9NnBKxJeyR
 AMIqq2HzyBR24NRA4OAjMG8xetnR/21RzzaDPO4nx/9NJp6XMXi6+jMiqSKtitsfJSZ3BPoFeRH
 IECtXwrdT9zpEezJqATxybyDyNDg4ISdarzPehUp/r0RewQQY2slvPGVFS2rB3+N4uYxMwpR295
 TOR9oJjzr1tye3kDE11wfxzJoQESu2NbXV+uwUPbMoAehpid9sxOEHrKRxFIZY58OZeiLqIJPZf
 N2IyxSemVGhieJazThYYavuqtfMuGLf5jZEbsn9fQJt2N5Wkx6DOXK/Q5sdTl+swuxEyYoOrXXU
 +f93kf6pggdjB7FJZ/g==
X-Authority-Analysis: v=2.4 cv=YtE/gYYX c=1 sm=1 tr=0 ts=69e16d73 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=csrHGirYQKKlO5RPXs4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160220
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This series updates my address for areas I was reviewing and maintaining.
As well, I would like to help review Hexagon target.

For top maintainers: I sent my updated GPG key in another email.

v2
--

- added .mailmap entry for previous email

Pierrick Bouvier (2):
  MAINTAINERS: update address
  MAINTAINERS: add new reviewer for Hexagon target

 MAINTAINERS | 9 +++++----
 .mailmap    | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.47.3


