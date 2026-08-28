Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25B7C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzth5-0001e5-N1; Fri, 28 Aug 2026 06:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzth4-0001ch-1x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:20:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzth2-0002yf-De
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:20:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA8CZh3064811
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UogLTM1+UkJ3cc1k+WAT2fC4JPtDZw8GJ88FjCgOzAo=; b=n+ysPE413pCequrS
 IN3189fJuHGGmDLP9nYx2UQPuMQrpOQQB9i3LPoJGsCkm3+J6LsNiqYLwz2+Li5P
 OdYZ3CjOrfRSSNK/xk4L7kxTJcqDnV3eQeTmL+keZJ59n2NIva2iQqwOvkyFfg27
 O9zOq+08kM4PnIptp0qngux1UoBpiG8L3a/ZfJkJrS4KUjvFKl6Pp8/3zP7lHbi2
 pXp4V+CkobD56f6y2jQBOttSLoh+yhcncdN5M7pVkiveVeS1QvasmeFSp2iM28h8
 w1yxdziFHzrRsnJjcHoowMINH2As3SlfXFeKuT9C773cdpqg+N/FG39JVUmvZYdV
 tPY/UA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb47n14ej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:20:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52f9e903b02so17093641cf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787912415; x=1788517215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UogLTM1+UkJ3cc1k+WAT2fC4JPtDZw8GJ88FjCgOzAo=;
 b=jNZNmC2wXFA3uHV0ggwA0uk7GyF5vGDeoPtkUU3ThGUeKn49Jk743jBfencQlyZfGz
 ogCNCyg+3e6rVV4I3crzA+IXyIWKaqkUi5dw/TpL97ujU3tvhQB6iZ4K7q6P6rIffPd1
 H7VZJ0nvr9y28dpw8kGCoyDUe0balmFOam9D9D1wpeslz+guIuHeNBBMLAnnKim0NLXY
 +YHKpiy87U1uX/ZmcZ3Guh6JMLlrIfeCAkbSUWrlHavjVq42eOAnyq1XPdXD0jDPkhrQ
 huU+0shAY6olyilCTlD6GlU1yl/Ih9ziZo+4VuiDI6hl8AjD5/YGOG6/UTYdPHai/hqU
 fELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912415; x=1788517215;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UogLTM1+UkJ3cc1k+WAT2fC4JPtDZw8GJ88FjCgOzAo=;
 b=aCaytHl8EJE772JD5CcTPggbttjU14fVjxPYz1ofp74UczIOlKeyhd+ihWTd8kVeF9
 Q9M8hAhwNBnGjjz1BZebyir8iSmCJZ8OkDmxAoxkpSwwDRTwcnOL8sJKWwfKQjOY1OL4
 CNb8kFpiCx/bZ2kPiJpanMeBe5//IhcJ0enXF2+rhpRLh/m9UGlxTKGiDaE/M3B+CywJ
 uOVwKBe7XrAnzUeB6Jz6Gptvt41tT0ilcafWGD3Vsflq7fstoN6TZs5+oURGNMYQKhAa
 VezUBDxt7EHz7ElbA1U5ofVZ2IgOVjI57DwDTkvkAzyx7EJohvqsFF9/YGT18+uFWTbG
 0LgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOz1TZZ2oif+82mGaExFJBO9i2RSNcaRnaOSvU8dmmTYJioK8mSfMBa3lNzW1gTAJZk+Jde/2vs/5O@nongnu.org
X-Gm-Message-State: AFuF++k2EKE4ZPyCHLjE+dLdCTSanjQ8OCthKgogs7vOYixdm68kMEWz
 RZGdXjkNRig2eMRJbngtgnfOraWFufe+EJe/qHe5riw4+Y5vSoYRCXVNIdvYxDRgPpefo5Q16Qx
 0mK8dWCuriNhXR3uzI14izCRssUNX2lGhkpBkDtMg79G6JBBD0uwoP34UxA==
X-Gm-Gg: AR+sD11lJNSbGjwkGcxtaavF19t2DhguWgb4V0AlbpsfxnKZYbtOij2aUUkTISA0Vp0
 5TdVUB7LFNZI6l/Y+3ujx/nkSC0mDcLAcKh3IiIRH0IlkSUWPfZzGbeufDgmD59w1QAtUW1Xqg5
 FwUsPVoOq0HZNnsOEpTOgVIPMqb08E3Tg3dPdgbw7M81Ru8H70h1ZPGnjHNNCfEXtB97pU7l6/Q
 /I4fu+YHBnorInob+zkUlcXmtM/Weii99XmqiE3eIFIm+9LsU3tX6ZL3Kxqkq18Ps+QwPTC+8na
 vmOvTeQ+smlwimhdZbMbr1o2RBcQqqZNXlcopZHcoOPVx8YEVI/c0cvME4yKMU7Ja49lEkAYkta
 KJqjHBqdQYq8h4QjwgeYd+ALhFtRaeaP45Q==
X-Received: by 2002:ac8:5f11:0:b0:52e:1e5:45d6 with SMTP id
 d75a77b69052e-52fa1a980c6mr145492221cf.6.1787912414843; 
 Fri, 28 Aug 2026 03:20:14 -0700 (PDT)
X-Received: by 2002:ac8:5f11:0:b0:52e:1e5:45d6 with SMTP id
 d75a77b69052e-52fa1a980c6mr145491691cf.6.1787912414421; 
 Fri, 28 Aug 2026 03:20:14 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm3040252f8f.25.2026.08.28.03.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:20:13 -0700 (PDT)
Message-ID: <5a634b03-429f-4834-a6b2-8b85b51fe3e1@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/m68k/next-cube: Replace assert()s and abort()s
 with logging functions
Content-Language: en-US
To: Thomas Huth <th.huth@posteo.eu>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260828095241.118458-1-th.huth@posteo.eu>
 <20260828095241.118458-2-th.huth@posteo.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828095241.118458-2-th.huth@posteo.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8YAM0SF c=1 sm=1 tr=0 ts=6a9160df cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=bgKrIEmzAAAA:8 a=EUspDBNiAAAA:8 a=EydOgeAECieTGnKq6XIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Ifulqbl_J-1aL42CD9IR:22
X-Proofpoint-ORIG-GUID: kDbVhLAsGhrmEwLHxwgHlMAbExrXf2TW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX6aBCM1/nb5M+
 ySls3v91eyXGON9AOWi3mywiSm7ZQER1fhQGdGWUb2Yhvh467g9uSbZGf6/uXQj9otrAs/bK9JS
 UMTpgRDlaI60vwrbs1eslQLMh4uo4Ck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX0UscwjSKLbgj
 WF/98qF+macc9WKACNX+bxhQglkI6AF3ZjYzM09yR2ev8yXxk6GSMMMCDCYBWJ6E1TTPwCgFwqb
 g6mtOByDMAkpZnrnU92F6vSm4wsAwBQYV3JVfU4cBNFWpITMnIfzB4J0jZy5se+ILMKajImXzms
 zj2frXrjIdDoikIdLsL6zus1X4IO5oor6iMk97oEHyKedsRTpU1hHQ+4jjO7mSsaA4PzU2Aefrm
 ojw+GdVXBIEcrwlbIN/rBLE94v1dOX3aIMDzdvtfARmQIdHcbeH4IbJ6qPU1piOUYRZlx0Fzeyq
 5UNe499tqR06GctuCgmGTK0CvFsGI3Rdi+2AIupmxxxWZuQRC9QIPEfVLtUcHn9/sqJTilv62pY
 gYIo/EZssTY5D+2IIxAfkZWBEKzQf3w8/YiN04fOJzdACPxcEQ0iJTkKRCHk8oEsFiEM9b5JgVj
 h0RLBV1w5mjqnTIt6sw==
X-Proofpoint-GUID: kDbVhLAsGhrmEwLHxwgHlMAbExrXf2TW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280088
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

On 28/8/26 11:53, Thomas Huth wrote:
> The next-cube code contains some assert() and abort() statements that
> can be triggered from the guest side. Of course LLMs love to complain
> about those and people are filing bugs about this. Thus replace those
> spots with logging functions to not get bothered about this again in
> the future.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4303
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4304
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4305
> Signed-off-by: Thomas Huth <th.huth@posteo.eu>
> ---
>   hw/m68k/next-cube.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

