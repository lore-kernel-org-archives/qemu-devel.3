Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602B2CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5a9-0000OY-4h; Wed, 14 Oct 2026 16:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5a6-0000O3-Ui
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:28:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5a5-0005s0-BB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:28:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEafOo500299
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Nh9qxKMV3urhG1Ohyd8tdclhkuWBLv0Mf1xDRzTt/c=; b=pbTsCYAYHldTw167
 3bw/0JhZMJNdqFcQvqj4s43vk1a+JKbY84O9QUkqiT4KVhchl8ys37xozU/hTvp+
 c3QFnRtIRZqpalMAtIrUyVBjAALXSNkHzzTvJOu/mCBV+h9B1svCBBoaqVNmVNfj
 g00/TksXMsCzNzS921E1JoxZVYX12ZevDKHjcBI3Et9fA3syzVvzodZuTByh12MC
 HaIcCQrbbmWrwU0X4zH3G9Emj5uhSQhDk9HWkkBC3UssoN54AHP77JD64MtebHtJ
 cNjtqDGLeOtCRYVbTMSrnsI6TEiv8XX++cXMKmlgsbESkZUhd5oCPH8m2kW2WVNi
 e22RMw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1n9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:28:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so12643703eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009686; x=1792614486; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Nh9qxKMV3urhG1Ohyd8tdclhkuWBLv0Mf1xDRzTt/c=;
 b=T5O56DEN4oSHpAR0Ox9ouDEJ3KnLjpDvgqcx6b1XowbAFeW+Kj2UQeEBLRf9uOKfnR
 fG4gEwCE/skmu7uegkH7s6TmbOLvhpgzL/jaod9NP6F4EhhgFtshJwV5BmBGt2OhKgJN
 jfpwRJXmyHMtesoPuKcwGMP2M4cDxRSAa6sUg9DF29BIm94hLSoG/l2mdFQ2E0u8oC6G
 p9jCHwiM8lJKK+8iklBihOy5E9dQh54fP8ya+MUjPStEoPgBJsLKJGgHYg+sxn/61fra
 GqzyC1cKS+WM8p5anMX/lH/k6mNlw/KJkeO2oiFiaYS4wBkNUGPDWHmmOjzQBvhqmqvx
 ZfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009686; x=1792614486;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Nh9qxKMV3urhG1Ohyd8tdclhkuWBLv0Mf1xDRzTt/c=;
 b=VT1URpbG35iGF72J+tds6xN5oRwDkqbcXJXjLYl1dPJWBt14UQCG9Inbge5ONgY6Ml
 DdKmNSYkGuEDvQ1EkAMfIFEP8wmdHa3WDbqegOUl6JqjUgV0y78jNh9ZS5rghsjo3Vxe
 W3HLqol6hCfG9aHhPqVKB9p0FWAHQ8YBTuB+lVLiUDP3pmPLuKfdIVgivMxCkvhlCdfB
 RY7U8DeGFDanS6WBOC+hQgq0YfYS3t9PTQ5JgHKPS7VkagRBVn4CMXJDwY1B0dZrKLg2
 y3YoL9UPORJ3os3IC5HNS79pWS9CSeJMuHYAemRvvokPFtBTOblIjF+vrmqJEVv5ROCf
 zRBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2oC1wo+lr+KX4FO+76uJW0rAeoK+ekMOAWmQ1k66bLU8miWv1MF96+c74vSqBzQUykeTq4WkUARui@nongnu.org
X-Gm-Message-State: AFq9FYLgGd6UAowgRs3ZqreaxopgDGNFCGM3X6QPyOYGteoH7sqkze4+
 vIQDD/LJ8jABYphhW8zKkCEayvbd24rEfJJjAc0duzFKshA0mGBH670fFOL8sajIIxNWAA1vlyT
 YCiM07mRAZanBUiTO1ZAf8NHvLsi9RwncxjwAfIKwinA4WUD51fuV9s1FcP88Io9inA==
X-Gm-Gg: AYBFou1Wg0IbWOgtGBB7jATBI1tLDD+ehrXdNv4Na2vJT6rpq9v7UzqqgIJyOc/x0kb
 +xZNGSMjcenLdM1kYYoI0g9rU0uOAFmY3QV1o6yzGGWOypILRQF/dEcvjo9ILytqebHfDIqSk6z
 WYx1s1zThQIFPcKKllpLYAF0p7v7nIKM0NkapzEKakG5z6R5WSOpzetgimQ+iSzRO5EV9H1eE0z
 uHcw1KsnTvNF6APygyZbtbNoII3mQqoA4A+U7dy8p50pNNGK2w+nHbfEnUJvD1N6XkuIt/9A8V+
 ahL/5OaIFqvvwuQtux2YMUOeo9r89o9IS11cd73+x10NhmtuLWnDc0+XQI2/oiD8rf05mRgER8e
 fF4TqQn3HvFZpoX4Mk74F0jhJB4psJ8zm9i7D7qyRMpat11qnYc/wlJRwfQ+Cpq7Pw2eWXA==
X-Received: by 2002:a05:701b:231b:b0:14f:5549:c1ea with SMTP id
 a92af1059eb24-16a57a16d44mr24775291c88.1.1792009686399; 
 Wed, 14 Oct 2026 13:28:06 -0700 (PDT)
X-Received: by 2002:a05:701b:231b:b0:14f:5549:c1ea with SMTP id
 a92af1059eb24-16a57a16d44mr24775248c88.1.1792009685650; 
 Wed, 14 Oct 2026 13:28:05 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becefdsm49641960c88.7.2026.10.14.13.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:28:05 -0700 (PDT)
Message-ID: <35becbe6-feba-4f3b-85b1-78961020253a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:28:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] target/hexagon: sort tag_rev_info entries by version
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfXwYD0Y/Ynacx+
 kTtn1OhT4d7HujwupoF/v8GPcIYRAncUQBL6EzRs+TWCp7OcVkoGMurp45bN4kjU0svj3gCMQ1m
 iJNQuLCFkS4YG6MJgXQavsokFXEOYPtY+7uq7wnHbyO4kUqbxQvynxRQDxDsxBuBv8lt11HQHU7
 bYn/U6asNgpbYg2EkQdlXrLvDnHD6sjSkxCKbBby4bnJa5Cu7pgGmqlglMHRsjhJJktd9m4WYYi
 PBXocGwDcQijDI+sqbBGbI+yoJ+yMvLq3FsiA+2qE19uDc09fAe7vsIAQmwBosBXjeA7EDoXIpL
 6O6aHMc2OI+NeqFTCfVqZkHuFv3wA5dUbLYWMuKyaxbFgvAvwxdZO5ZI6l46yRcg2JrrssKWcFS
 rmUa1l8eYSN7GpI13OifQ6d/dKsrbv33f8fPsljE5IqmXohThcIrjmCFfIP7L6Fnm0djkm7pdmP
 myuQ2NWrOpL+DJe31kQ==
X-Proofpoint-GUID: U8nclZ6lQdZFuf2EoJp3FDK1nATHXQvK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX0BBkcI1xDRja
 6bQdYbVmGlDpBytNSyBDbvr7BBoT/qz1jQUNPLcKeAfyJwpMyBiMLeHe8w+aNi7XfWdqgYth9Aw
 HWFz655hYohwcBVYsUEgKErDxdwAe3k=
X-Proofpoint-ORIG-GUID: U8nclZ6lQdZFuf2EoJp3FDK1nATHXQvK
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfe5d7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=UnMXWJzsRw9nUPKWXdwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> The V79 QFloat entries were placed after the V81 entries.  Move them
> before the V81 block, and group V6_vconv_bf_qf32 with the other V81
> entries.  No functional change.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/tag_rev_info.c.inc | 32 +++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

