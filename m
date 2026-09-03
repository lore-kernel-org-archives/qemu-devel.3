Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3744C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DFW-0003Di-MS; Thu, 03 Sep 2026 15:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DFV-00034L-1c
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DFT-0004Uo-B9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G37752088773
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dw0J2oIi7o5UffYhcv6InY1oMKM35P9zlkcSPUDPX+c=; b=edguigdiJYGu/iAo
 9ZriqSpOl+W/4wyoseaisuIkxLU5mN04Iye8il+1Sd5/0iptVLJ9lu/urzU2SGlx
 2QpSNYn1m525ixc5Zoo6bK3Y8GsyYBSHsS7FEx7jG+x0idksRnp3l8Ge/N/5PGQq
 e6zql5R7WRbcu4N8sXzH9pRsk7fsPbu5l3oFsQl+r4XKUUXEgT5nAU1lIQW212Fl
 /LstcseIc0MuLi6MhK/zbZOvV8PHm6yWghkFLvIQfVvDY4O+cU1872SJ7Ufp9p1O
 jf83z7qbfkEudSoYkusUZpF8MwvA0V8KPfNv1I9/cxpLSipbnS+5JxawxIlQdp7F
 RvcgVA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b19whb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:37:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so229584a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464241; x=1789069041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dw0J2oIi7o5UffYhcv6InY1oMKM35P9zlkcSPUDPX+c=;
 b=FuJSbLaOAigS0aPWSx3AKmXLwJnIiectdDQ7MwzCrZHJd8G6UuoSpNam/7WH0Uhh8t
 D1ckDQYRHworMvX9guZTLmyOVNkLRr0CREh690VTYYmHkwcc8W4oDSNOT6PdF7V7owhH
 O7nRQaIaFrkql8mYFjEHFpjvJQgKtlWNeMgm/5Pxn/3yohK8QyP2puWZlS4aamSj2EZA
 0tBjkKQ5wEfcRI8J/P6AfND/fCkQE7dGf7PCwwkzU9Fz2iGYWikYrGoWa/uEpIsCJxxL
 +ou0vXbf5owE/ka5oQnWIe/NNFDuBoGnZ7qgruFMCUOVVWD4Rl8RHHxHgk9Wg4eTfcQi
 Endg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464241; x=1789069041;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dw0J2oIi7o5UffYhcv6InY1oMKM35P9zlkcSPUDPX+c=;
 b=RMxdjxTAw1lMnlCYeQt5u+vE0sVNCvrb5Gn9QtCLneoU6MXuDYcTfZLzkZ6mvz8lwn
 1C0o7GdZc9E25xR1uc/alU3StbfCNxy7HfV/j2vdFAJYa/9zn5CqF04UCEA2HXseLJ+f
 BPzTD312zJWXJHEdlPAIHbo93ZMCX7F4kDthbvDslMkVVfTp7agr7OZZmOvlrx9/pGAA
 hLPDBUOfRLhdU90MPl6HTVykj4jiXyCPPhtk+SPZzW2TN7l2wbMR2WPrfXt/lcR520et
 JSL7uUM++OEFzf01FtVo3I1UckFj73b8f8p2Xsc0dQizUAcObjCaMHzj+6x2+F+G0V3p
 rKbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBycjiUTkg8KFXfVOV8JJ/B52tFSU+895a2l7OEKyYL3eHDvJbSKHjSOJIWRG/nw6oEdr8PZ4Rh2QeuL@nongnu.org
X-Gm-Message-State: AFuF++my1kr5noOZvnoPv77hIhhxu5w1c0MGV43Ipzk382PvyWc/hVYc
 mHxA9iBUreCyTCrMgEw5veZCJXaGLL7ND+XOAm80xNHV1pdQ8rtA9WkqgKC9hX4RGg0J6exlQC5
 S943atMdV5qUDF7sN5vPuE+/OpxHlN7AaFRyr9D+iO5cC3QQ+DYoS3Uc1lA==
X-Gm-Gg: AYBFou2xZTX8jvLtWWXz8AcItqxBppbF/m/BF5WFq0JHDOn4HP4TZpWkcvgv2HopMtC
 t/gxMMRQIbVCjWuMOhOGWvMtVHa2L4YMv+P7HT6psokDx6TTLhXimiIac/ac9l1N1mNQVydgc4k
 IL93FRpwNvztkYew2209P/K38hjZt4iPKe40cXMy1WLIbMeiT48Q5q4AosGJ8ZV+cUs9SIiROLI
 55VN4V8vkehXZIXb/HR9zBFVtp530xufb6H8XmqvCH1AXWRb9pmmsac5xO1FYm6RmNXRFR9vxML
 ft371scYREN1XhfBWzeDTttHy1a68oE7y3eyX1UB8fzOhyB5+++5LPmN659lvx/dtpecr+gXlyl
 c14qzmjtIrHdAN4+cQzh7+W7dw8y1XAGXLG6ev7CfAs1Xfi8YBxBhu+/PW9tfY50/RBpK
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-39b26273a40mr1189830a91.21.1788464241279; 
 Thu, 03 Sep 2026 12:37:21 -0700 (PDT)
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-39b26273a40mr1189760a91.21.1788464240774; 
 Thu, 03 Sep 2026 12:37:20 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339befe870sm1057509eec.30.2026.09.03.12.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:37:20 -0700 (PDT)
Message-ID: <9dcd3fa5-8f26-4c0b-b007-c778349ddc12@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:37:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/hexagon: assert guest register pair alignment
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1AVQgMwfN9VJAVreR9OykOCZEX2QHh73
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX98Rg85TwM7yC
 hgPuraZ3iPZOVUXpSseB9XyksYFk63tlT7bOa+Sqh/R/LTRTcTawstaa1OuugrTGKc+1pUqDkBy
 WecZqORpbodgHSqdtqZ+Yy/n9WM3dXQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXzBAsAgrTysEd
 e3pY4EAjqABXsRKQezGMEKMtdVs8ttedwNNpDY7bbZuvuyjLtFNRC9Mi4upzfO2csyeq8sTKN5E
 s39Zj/YhouH2Kv0bBoNWYbGNheuTDIy/caapJDqsQebT5dwe5RJmcecWlQfvMYJ2W5U7WSdGc9y
 /UoIaU3Kxc37NfEsKeUM9tGmnGX4LuX3F1oQuPWh9mU/kZcDf9pX8pxvsl4R+VVirV0Y0O2blUA
 8Kt33TQYzYQ4ByIob7kY9s9M9Lsm/8GupDnL65uic5hrov9axGvYG4rB1kv1cGgqEOlX5yK8EgY
 ED3llKVpqVleVLTcgfDouTjfTLLnHU90CoAIvRxiHvrM3rV5cowaQQl5r3ks0vuD/eVkvF5GbqL
 hYBoESA4KgwGJ2/2htsYMHsdMO1hnwiK1rBFACpKF3OY6B3xcBAzNGmInesFjimvzK94YTCS84d
 KoMK6FZd/cB9l46LVVA==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a99cc71 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gHPne6YqgEI5AgDLG5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 1AVQgMwfN9VJAVreR9OykOCZEX2QHh73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030170
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> Link: https://lore.kernel.org/qemu-devel/f7f34a43-c1cc-4dd8-a859-9ab72e1b015f@oss.qualcomm.com/
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

