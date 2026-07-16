Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98553C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJs-0002l3-11; Thu, 16 Jul 2026 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJq-0002ka-Ha
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJo-00075c-HY
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiSvc2754590
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3U5w+q5/RVe
 U3CUxIewmMLTwjtkYf3sNkyjj9YwHRGs=; b=QLOAUfh+xpVPFVG8M4ZgunnVvnH
 DKmuYayXGcYEzH4Vau2T2kXrA6pXD5K/LzoWv/aBFnXmUgwTmrgO8OXxrqp+OnuO
 KNhGEgp/z3+g+uq3I6UPK4qskwXRXw/r9bhjqbnYD80Ewu2eturV11AXFrMHEGxs
 wTTWrf0DraZgzu/xUpV8TnL+2V3hl1hkCrEN992+IgKGSI6wBjlg/GMU6YnAJvcL
 sEw9WYcLD+dIzkVSI/uZVjmhI0bjN9R6387ilQI0S1ftMCsEBo2a7+LFflOdNBfm
 crU88kP/BV+guE+SAQbzbBJ7KQ4bRB5u0jxuHZTDixyI5snMwh+AvsfAb5A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10976m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso113943936d6.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205359; x=1784810159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3U5w+q5/RVeU3CUxIewmMLTwjtkYf3sNkyjj9YwHRGs=;
 b=I4VPa3GAbsY5NkoLmiNeuOR0zO8nldm8rvy//AT0VO8hreCZ9CoJhEqo4yKhkUiXmQ
 Zu9wWxgF1GsUyVsffokcn1mdLeGgsOhJX6jOGKgOaH8NSKPHuWshW4GdAXsu/iT0xz7G
 G5U/EXnYEJuJ9X+f4hxC3FcQENQPTOfD/1HgLUUClWyOGbZoF4HNSXUJLUbTjsdLh1jW
 FmjcdeMd6KSDboUNBuED+A9AJw9XFaOjeCJ712dR3b0bfSzmHJQaG+teq9hjGcT+0JxL
 XAPITnHIcs7Ql57hi/bX3jX5J9IDc5yFKQBvsSevx+3DxRIT/7OP8+a+RWHW1i1f2Wkg
 zQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205359; x=1784810159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3U5w+q5/RVeU3CUxIewmMLTwjtkYf3sNkyjj9YwHRGs=;
 b=hivU1c68DUBHsNdq1SFqB5b+j47p/+yJ8pDzQI1WiVUXbJsy4jMJQMemoPXFPpnDI/
 YyJnRLJ8gwzDROiDwFZ8bubef7VnyNN9fy+swbEYPrQ+hcm5hkuOIlhqk/8V/vdxnqwC
 LFzkeKI1SOO1MpDHvVmbKagmwaigH3pG1sUUH7N91IKpSt0ZiJwyrhfK2gWU0QO0LFqZ
 RmJUtgiV/i50ZgpQcnTmaMtD5/wk0OrZGWdbELCRP0cGEhG/gW4qJq/UvJR84tVrnh7l
 brh23Ia9bRN4zfJjcG37qjHtfqliZ9Ut9L18hvT2INJvRfzxcKs4c8IuukTaFnonLwTs
 Jy8g==
X-Gm-Message-State: AOJu0Yy9ST/9lfWbiBGapdhdZpUWmOyv7CN1GA/NFDgDmMzbd7L3bkae
 47lAV+cybhKdT/In2HVBbvsgtNLHG6DGVe2IFKT4yaC7bONIOb+O1C6smtHHBpp8/9OHH3VXc8q
 Lwy0sg4wuphFLl8eIji7faENdHN5XMmjUG2xcDmp0Z4PNF1y+WyabOSUEeSW16j4xNg==
X-Gm-Gg: AfdE7clZsz9bqm6npKaGPvK6rPqOT+SmvaMuOOUCR6GfGXPzSNHQToyuHIub9eW6/a7
 1PAXP8bOXs4aKVYUghLxNgltoQek6hnK7HZ5IBs04jsQ/l0ATLcFetTNG4JUq58r0svP3yfLc4S
 A1oRlObCMqyF/Gcd4su2eO8vmx/gMXQegVzTukeUD17wZsc2vjBpum+F21By7EJkRTk8bPEmuIY
 1t+tifQS6WGBSy86CtAOa45PWiCW6DIZcKdt9+r8zkwTqhFAfkO3VfLgqTkvttgaQAfZOb2z9ZH
 eF6cQJNz1eUxaLY4jWTnsSpmY8CBeyCrSwaVTN9qIP6IXGgVF63t1da4sDkNWr/OSbYBw3C+R/7
 JC/C27duNWqgCWGxsm3+ieJAc1REh6J/HMBA=
X-Received: by 2002:a0c:f405:0:b0:8e9:f5de:d5be with SMTP id
 6a1803df08f44-90758e355f7mr72517226d6.53.1784205358677; 
 Thu, 16 Jul 2026 05:35:58 -0700 (PDT)
X-Received: by 2002:a0c:f405:0:b0:8e9:f5de:d5be with SMTP id
 6a1803df08f44-90758e355f7mr72516786d6.53.1784205358139; 
 Thu, 16 Jul 2026 05:35:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:35:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 06/17] target/riscv/debug: Implement
 get_trigger_action for icount type trigger
Date: Thu, 16 Jul 2026 09:35:23 -0300
Message-ID: <20260716123535.3709148-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -vmFd5GBPIdE_a7mLWEjdmjyJG6EAFSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX3W57lZNSFZDo
 02wpXaplPj9JjQckfl2PpfILS4Ts69jN3NMyx3e8JVklxDS2YHfdEgMrWeGHS3oc+8M/gz2KIVr
 Ayzw6a9fOmZqnyjHEwZX20gR86OwBOURcajXUXNN2og8A25Lf+Y4BLfMyN2fByQbrad40j08B9M
 KbDpX9QKnXGfMAB/lwWev0VvK3PxRWjdREiRFuwshOygrhWrUFRA1fjs5hBHLA8MLFiZT1P7qUO
 GPPps4n1nJJCjN2sp86dfX+XOGdzqEOAmN7SejYQeDNYDDk2NRSNxkWsYuaRTZVuoVhh3O7GuWQ
 8z6bELd6yBaRfuw5dk4scAEMIga5hXm3nM95XTAkskckM/nHdB7BCqYUAhf/mS2l5E0bsQLbau2
 f82mMbM5RtDmnhpMY5tbE9EXcoyJmTTe7HII2mye+CHHE0dmzHnDfoSCIfOzRZyvk/neypgL/SI
 nDYVCSfr+ictETsZnnw==
X-Proofpoint-GUID: -vmFd5GBPIdE_a7mLWEjdmjyJG6EAFSR
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a58d02f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=xP8YGnA5bjBj5bUqXB0A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX6uHZmhE9GeWV
 BGAQhmtNCsp6is/1WjZEvnERKbp3zqp6csCb+HmpuXUOZyKDBPfGJ/X5e5EPOxg7rucnciL6pAI
 ttXOUqFZfjKGIUmdBV+RNP+lOPRiu7M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

ITRIGGER_ACTION has been present for awhile but get_trigger_action isn't
implementing it.

Fixes: d1c111411e ("target/riscv: debug: Create common trigger actions function")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index a0222e178b..6aba7e9e12 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -112,6 +112,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
+        action = (tdata1 & ITRIGGER_ACTION);
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
-- 
2.43.0


