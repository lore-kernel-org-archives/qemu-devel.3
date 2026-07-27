Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A310CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLVd-0006bD-I5; Mon, 27 Jul 2026 09:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLVc-0006aq-0R
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:36:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLVa-0003gF-IJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:36:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAM9bk3571257
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gJsdBdB0qxD
 Kx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=; b=SOF9vc6/gprxg7D4u7UPoNpc351
 sqosUlC0N0+eg9rjCV0GUQuLelqUmpsyhIeM+eBExpQJO4IFyl327emeHLnA7oS/
 3OoytRkMLUGpJHhqdzOWNXiBWlobccuN6ZxpY1sB/zcNTmIefH0n2gf18z2Tb9aj
 I0qwMQ8FlW3Dks8QusQb3is3L8jgfOHQsBsOtIiWGP9HhbXarOA9oDWP2EmY8CGP
 vw8uspSh5jzmXYwhlY+fj7T0d2mlZyVKBX2x1D0A+29Ie/jPsv3VHuAc+HREVmMO
 t1Pa8bItkowGj6pvkpDPCX8aEUmvcen58OO9DCPGoiPJoAthXknwEAC6RwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g1ex1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:36:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so64083845ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785159399; x=1785764199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJsdBdB0qxDKx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=;
 b=SNR5cyv9o0lW2lo9r3wGuBZ4X2pb2CfWUydfNVidjgnMZBY0Athx9vCDOrYjAlhkeD
 jTFnLiZtLgPMWjfSLFmgDrUMkt5EaNLgQ/1rz6+dh2lhHAZr2pXs38TCVNJje6QCEW5A
 F1TSULP5xxTmIXeVXvVhJyZJSapJkBBg63RWTZXDBVQtFuMTupop6XWlFF23VFGop9RJ
 QN1hvQl/NCKRnwkeZZVucTMFLhhsjoL5sXLBcltSq7DK1lurG3+cambW7FvtFN/WRvEr
 ciIebrHk8PNVhZW+XCP1xkdAAyKUihLeQKXf6AeOUI+M/wD5CzypQBn524HJEEG5Gk07
 DJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159399; x=1785764199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJsdBdB0qxDKx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=;
 b=A8gptjbGuRe5APg5h+dz7wQnSWfWpLw/z9MjnfW/GcEGsv/Dim3Kwud1dj9FJTpzkr
 bcKLtfXmxxA2f9npB9+FyEd6AZM30T9VzEYtFMuDus+Vg5qgWvT3dwPkYtw9RFx44Tf5
 h4vL9d+1mr6OC4a50GYqhMRSILYd/4aRA2Yt5iQ/mXTKsNVRWpzi0HrVu05mBQmTzd90
 FLQsR9DZNE6L7YnL1601ijvlD8NfpSTLsZ4XdqxHSO0OCx9fCSe2F2MoLCp8tUmWbGlp
 1gSkjCGhpehJ2Y1WcuB/IvjLHZW0Cb87Bx/6g9P5lHtPgxv5Nh+tsJoykAJyoRU2gBLM
 kaGA==
X-Gm-Message-State: AOJu0YyEmPRB0rnW1iPA+A/GsC3tWDmqqUuwmHUtRlYcQcZ8QT9GXBcg
 IeBWVtPc+7Tx2nDuGZmr83tTKdW/HXTfs/eJATHAo8OcAxV4WZ8x7V9zrrsTflPgryQyjZtL4XE
 BzomAGZZl77gqQl5VJFCzkM4D6VYrSYLaAqrkEG0nIIX0dJ2f8YhNeOh8cQ==
X-Gm-Gg: AR+sD11msZx/dnImKOZhNcCD04RGfG58vwT4qZ81zFVCFIFJonFeR3GBNWFgdapcS+s
 93ndZFH/z8D4tv5OssZXmH3VCZYjx/BsIZwC4kVUbDcsK4e1z7ArF5GP11EKwbK2HVNcAIMTcOR
 aCA9aQH8iNWYKY0DheJyQuiFVqf/8eyhxmWfeVoLU6pBL/ZHUAjQPt7wkRtoV3kOvxcGYY8SaiA
 iZF3tl7coob1g/nFSpvEQxzjAnFVnHBoqfYaUmuSan5KvSszvHF+kpnHnKMcsOFr3+I5Q6Fkt/M
 rbMJpZhmHjRD2aqoU5/ylYjynMh3HaVL3JdQnvNTPw5oiMrzU7pvtMpo6HGtqRQd4CFLi80gEMr
 iFEdFgP5MvtgX77lq27l99DedGrxKScMm/fUpRBw46cPJMORzkW77QRvF4hb8U+k=
X-Received: by 2002:a05:6a21:6da8:b0:3bf:7c02:c46f with SMTP id
 adf61e73a8af0-3c67dae4388mr9619298637.14.1785159398843; 
 Mon, 27 Jul 2026 06:36:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da8:b0:3bf:7c02:c46f with SMTP id
 adf61e73a8af0-3c67dae4388mr9619263637.14.1785159398286; 
 Mon, 27 Jul 2026 06:36:38 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc549b11sm34923005eec.18.2026.07.27.06.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:36:37 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com
Subject: Re: [PATCH 2/2] tests/tcg/hexagon: add slot-assignment tests
Date: Mon, 27 Jul 2026 06:36:35 -0700
Message-Id: <20260727133635.2611626-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
References: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a675ee8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=QQwjxq2vsnLLEq96bu4A:9 a=ZXulRonScM0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMCBTYWx0ZWRfXwONVp8gCAiRa
 ltPD6XQn/iuN4dIm0Ir42obqBwNLzx0UwOX/V2wVJrc2dMVPOry5Q66NSva0ndp+utgFy51797c
 4DdKC7bnDILoP4w8ps9ikOzU4wZVs0w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMCBTYWx0ZWRfX7tisZV1dOuHL
 onE4aOaZZzkojWDX7LPmeHcYO+nTvBhBJD8ijEUoWY47/9WO5MBDcTlb0k6HZ9HDgX4z/raXrKr
 GyyEIqFDOEBnnZ8kL9aPEqCxLCnZIYfbWYh0e31BzuaMgM4ZhUi1Le/Ega3TGAlkNwfkc66l3DM
 pTb4TCmKbR5G21moG5P6NrT67RsN25YEz2YwsEsd6rKjGuWl4g5gvHQ58iyH8qEjSy+xgQy0LwW
 vbKxfIODKGqiSPNWxuUsYdft05Uvv5Lmz3lUcH0ltLivqyzk30l/Qt7xuBl2J43FmE+gVfjBM1j
 hnzeA2/YlZVSL2oV64KF38bXNKsN8jQi8986ZgY2L7NE9VLAO/UAMRmTu8nCBQqY0UYCGwF/tQl
 fx9ePQF5JY0xyQQFvowWbsW3T4FQqmFLMOSkEznMfMmB5cG+aDAcD7TflK9hzcGMWkSpQuhhcNa
 IjMGq/jjsEzt+96dEMg==
X-Proofpoint-GUID: mjO8Hoe0ax4M6Jn38wKkuDKFBQf4YB1g
X-Proofpoint-ORIG-GUID: mjO8Hoe0ax4M6Jn38wKkuDKFBQf4YB1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270130
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Fri, 24 Jul 2026 10:18:45 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> valid-slots: packets that legally share a slot and were wrongly
> rejected before the fix (load and transfer, load encoded first;
> dczeroa packed last with three transfers).
> 
> invalid-slots: unassignable packets that must still be rejected:
> store + duplex, load + indirect jump, three logical ops competing for
> slots 2 and 3, and five ops for four slots.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.target |  1 +
>  tests/tcg/hexagon/invalid-slots.c | 72 +++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/valid-slots.c   | 62 ++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 tests/tcg/hexagon/valid-slots.c

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

