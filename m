Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB64C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80o-0007Fh-9C; Wed, 12 Aug 2026 08:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80n-0007F2-3h
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80l-0001ys-KU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4XB93311415
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tSP3oFOhSSJwH2wpIPExnupwUl69LTj1EeNGfJfr8IU=; b=QjCpXv4sCRl4pIpS
 zkhsZKVtEEXhSrBluETIXPxvVDdRVaemCH6ZjCkqFzH4UYuT1W4u90hWl2BGdGfE
 zTT9UocDd+nZyGcXUGOSp44dvE4MZ7j7FSL48Uknn/2EbOei7V7AJDJnaO+Xc2za
 olMa20moTzawko/KcZLG1W4nddD74lLvEUHMwHlvj9kc1cgPsmF1atTAESJzhiR2
 ia2MEN0eqJKnSs4BJzJi1P77nDd9A/XVXpaEGGEdN6u4czqZSqHAn/ekxkOkN/jF
 tvCy6/KogC10LM11m5oO+1eU3VhzB8MwsGsY357pv5I705BNXX7nZ8tsaa0F/mTt
 BxHb/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d0nem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso12362501cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537486; x=1787142286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tSP3oFOhSSJwH2wpIPExnupwUl69LTj1EeNGfJfr8IU=;
 b=Rjzvls7Krn39rwlPUbBuxveYjNHQWoWOkvWltpoFbGcFm9yEuzP4x1HkKFUMoEH3ai
 xF9NXzMrq9Xbf3WnSz8+ACgNet3qtVIfNftcIEqScmG0TCxaUk4OUZWINDZ381UDHI2Q
 P4dGegNQpz6AWcfYxa4xK9Hwb9MNicFlNQgPB9OS4fSBkhvO8mXC93SgwW5by8SqJIKy
 dplNz1EUN6YiXfIIqgrjB42MzY55ueMDRnovP9/M0FUCq5KNXd+Djgds/QqRTBOx/hbn
 O6vr9GjuaT/ZxVgIEqOdS57/x0FCztjXXmnzdDhy+COIeEVRCZxq4t274K05DVSF+xgD
 Vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537486; x=1787142286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tSP3oFOhSSJwH2wpIPExnupwUl69LTj1EeNGfJfr8IU=;
 b=pSf6dDYvNMpZH4jocu3XnneIaLrVDf7mNdrRC7KouQqcGkkKpECxolAWQlFOO8N6AY
 bc9Fa4QPoNUqMQdxA3DDSn9jokjLfUnxaatui63BjFl7xPpgXxLPWIEPpV/rXJPs04CW
 PgnLA66149pb/0dKZO9KouwNNh5Wimt46aN/ss9fcIZqJfJckCa0sX0yMvVWEWrtyDFF
 Kl5BGDxoIdU5Up5tIexzwRMzj8Zd+7112JX0KP5sR3Q2cJjQ2n0dbTtvg84Z0RTbSro+
 VQiRgIiOKeT0v5wY3FPDdG6cri7Qa3tTmV0ePuWEwoKTX72o10s+zlATqw/opx3Nxh3M
 9HYQ==
X-Gm-Message-State: AOJu0YwJdCqXrq7voGHORetbeJWfchip6JWirux1VQwV8BMJ87ev4PeZ
 8V69guh2OeTFBqKyl+AkVjFQXwQckjL8cJIALcgn/dAPI1S08SxLNdUFI7/kNX9DnoUNALD6fDg
 PYSHbN9vMeYOY3OtXmBR8zyq5bLJjp7ZBVcdpWLJX4yLNXwJ2V6HgJ8QPuYupq9ot/g==
X-Gm-Gg: AR+sD1271F9CbXeQHctNwbK9Wx+dEuQVKJDls0Ma7h9hWxZSgaqHcXs3DmnSEtPrxhZ
 80imBxaLZ4i1LBnS5+BVh9GqMBkpytWls8eaHtAZS+hVmEoq/2arUojIBCgSUhPjaMZdBFacssX
 36onNhtDK272TkP3wn86bscqIaTpIMkeVg6XFFLuubOjOv8W78ZB2yKgbIDa9gjsyNCmQU2kjsk
 63dAGDjz9Irf6uTPWujkXNBa2qx9uy4n8vlHzQCpLmNPcVfK7TbeAIvo4cRmG2cr6LhfXBsST7e
 rhaUqW9pLm3psKp5HmpptuoYz27g7ovfr9yHbxx51S99EbEntc3uwPU/SdAVyL1rxxbL/XuGhHw
 YReqn6SRwYpfaFpn+9gID5msk/nr27nchBTuaanjtbg==
X-Received: by 2002:a05:622a:e156:20b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-52d6afd8517mr8439121cf.29.1786537485926; 
 Wed, 12 Aug 2026 05:24:45 -0700 (PDT)
X-Received: by 2002:a05:622a:e156:20b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-52d6afd8517mr8438671cf.29.1786537485490; 
 Wed, 12 Aug 2026 05:24:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aac48f7sm66518265e9.8.2026.08.12.05.24.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 10/14] monitor: Remove unnecessary 'block/block.h' header
Date: Wed, 12 Aug 2026 14:23:27 +0200
Message-ID: <20260812122332.72975-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cC9vOehu97ecL4Qb7y0yUqXA9_kvXS16
X-Proofpoint-GUID: cC9vOehu97ecL4Qb7y0yUqXA9_kvXS16
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c660e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=neFa9O3qn1L-Jj73aAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXyKpEXHfNK94k
 PHR1awjNodgCyvRpe/MZf9wq2NFdZcj4NzEXYppQAUwF20WjQWKGbH8FphYfbSTTQG204mozJ1u
 o86a+p71mS4odbw6FPgKN9Hf2LfrFt1hOqZR8y39OpFOVQNFOHnalWpDm3f2UO1Wzm0AlQV0apq
 QVykA2l+2Sn2XWXoLx66tV0Vd6mIW3z8Sp/cP9TwDjgcapsElhfvCoDKFZ2dNW8ZiaGgVc6jtiQ
 wPmIjdMdM+zzCoVyZgaeBJS6BgtZCf/UfwkLhtXZOkvq/29tINS9u84K79hHUPeirRdXeZs8Qqi
 rqvv5vV/JWEBVBuhHFfACtXt0hw/Zw3czH2DTOSTnutWgNtd044X437fxv7MI2EG0MXgIQthRS6
 YfaJVJOtzCTVJgceM6RRbwABa3saXHo24tfhO1hIfvEuNj3CBa7YIrvxh+XxH7JgPeb1LEyKGFN
 vTzXEJdoV1neFhxu1uA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX6Vdz4Wimdrtp
 g/5wUwHPusFM5Lx+kGfiL2PX5nUw9MZjORktpMYw7NlOP1TLzmu9cxkKEU76UMWuZWHvVWjmAJT
 8aeVYn5CRI15VzzvmTaC3W6DPOX7hGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Nothing here requires declarations from "block/block.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index fa9f4a8a75a..fd98ee2c71d 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -1,7 +1,6 @@
 #ifndef MONITOR_H
 #define MONITOR_H
 
-#include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
-- 
2.53.0


