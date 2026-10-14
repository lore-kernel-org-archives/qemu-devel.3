Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE52C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5ZS-0008Ju-M3; Wed, 14 Oct 2026 16:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5ZQ-0008Fz-KL
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:27:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5ZO-0005qD-Ti
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:27:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEafOg500299
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y7ofe4vj3Q8H/UrogJVHBKCD+KULCOUQZT51bxf9IRo=; b=TJH7n4qMIzS8Bcmm
 8HW/AXeWUL0VPIvZmtt+f8q521cXVvtK5pOI5BI7utGOEgrpzjf/As3Y7Lh2+3Sw
 Bz0vwttkFxTxbKsq4keG1sXt8R5q1Y49XfLbh5alq3m929t7SJmooHrQX08reLYu
 PGGgo9GzBMgr6mO5vVrO/A28NkFCmuJP4cSL8u/jQfs/Vr6xcPlh80KknybYsrQr
 P3fthtBLB1uyUCryFGA1V3TUwOLBYNdvTbVUZnxE6d3vkrFtSf0qENaBfEkIPWXi
 XEFGAW++6NW1DnVmL2Uj90MdnP6TBqpC69qxVIgf1LqH+z4nbSEj5qmKR4IYutYX
 CX547g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1n73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:27:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1663fb7e005so5837342c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009645; x=1792614445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y7ofe4vj3Q8H/UrogJVHBKCD+KULCOUQZT51bxf9IRo=;
 b=N30to71Q+aW0oCWkR+y9SdEq7w5TscG95pJnR7nSe60MrmjLIPWd77glz44nWMk7se
 DTIYBTSIp31cBTUQKrRKp0IfKOWZq6kBYGLyEluAEZTugCSISzmypuMKBwFpmFAixjLC
 Qbs4LEqrmg2VQMyt1yfvgRJU2NBD1LKliF+AoHjQX/W0xeBdPWcDWeOq8SzfnzDBG5Vr
 mLXbMVD0OqM8HTdnbueF6/tC68ivd+hH6XXYpuUmG7aLx0BfU0NSX4jq03GHuT5Wg1uz
 8locb+ihIh0FKoXR9iuTZHST2fM943XfJZ5ptYzJLA+xKbpra13d6eV2x34607a0YIVN
 BgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009645; x=1792614445;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y7ofe4vj3Q8H/UrogJVHBKCD+KULCOUQZT51bxf9IRo=;
 b=kSF+Sm7OP/hOSk0vM1nAvkH0xrFocmt7XwuNU17CHYk2rf3oz50KSoOFaOk9ZvgfQ+
 n3maik2oe8oUZqpOu/6qFD613xWeIJpJaCl6Qr9f+j6d0lIszTSElZZv5+FKOqEcO/gB
 opUK+PD3uhKUOCLek5D8DFJElJZwE1bOs++FyFiO4e/auPjl5yAQbvRbpwXPQvU7M8TX
 Sk6xfbr0GycjHjFg69wvLCFonHrGJGi9j9MoAdD3SbOswB5pRM72GGnRlporJCKtlPe9
 LXB53rhx1ticZVzBgSuq14G1wafsymRllP2j5q5nZHJSDeAXA8OuPJ1rRTpRrkWSbCFW
 YXAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy31aQPZwauJ6yZD+sUIdme1qw5FxwHTPnGHr4KY0VPZXfz2y0qWibPzdQD8QFsaBTZfBVl74pV8Thf@nongnu.org
X-Gm-Message-State: AFq9FYKebs/cxK5WIjQx1efI3u2Pt8yQBfHp7OFTT1Ikum7S4ghw7Q0B
 xfyb0qUWkKHd8eiU5yWJDE5OYzZl1IMRsCyVjH7j3Evm6oHqeXQcSK+fX7COvXvRQzO89CzqkfD
 84HXDPWhNEHsiIoQsliYGji8nTdILBey6P5DNm9WeBvXRcC5DSRWPL9QYdKluIdFrZw==
X-Gm-Gg: AYBFou3zn3eyfIoBeZpb3of5hy5CKIAHZhzyzbvayt9yh+n37fsEjjMVkIAd6wHelIs
 30QRJrrn1sNmrOOZJRIsMAh5n85UVJG+Q79L4zdu4vjne6qKbSrD3P30gE9RughRletfSDBsU0G
 FSe/1wsKwyRe51yOwVZNnAC01GG3LGFw6b/Ap35tII7BfOeltZCSIBx6WOK94P8b3Ts3MOaHLRD
 SIU5j066SSHF6ZoyNe9J7VbGho35ouh65PZCLI9iMQs7JckI3JVWHw9c4PTcLgNQN7F9bg5UZpX
 N384putVTnphk5UkQJSBB0U3hXXGxp7QBWAGIf86x10wuzkiu+n/esF6g1TCWC+ShFoIFp+vgr/
 T3+yJFtmRH9GoFf++BnGDHSiFC4/Wd9xWL9+lXS6VVRkBJpYr+o1D415JNERmN2Yoq76hFw==
X-Received: by 2002:a05:701b:42c2:10b0:168:6ad8:e88c with SMTP id
 a92af1059eb24-16a63757d80mr26904475c88.39.1792009644778; 
 Wed, 14 Oct 2026 13:27:24 -0700 (PDT)
X-Received: by 2002:a05:701b:42c2:10b0:168:6ad8:e88c with SMTP id
 a92af1059eb24-16a63757d80mr26904358c88.39.1792009642785; 
 Wed, 14 Oct 2026 13:27:22 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a3f6186fsm52061620c88.14.2026.10.14.13.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:27:22 -0700 (PDT)
Message-ID: <ff8f7bca-de0c-4f3b-af3b-b8900ffb0f4a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/hexagon: model PCYCLE with virtual clock
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261014194106.3205338-1-brian.cain@oss.qualcomm.com>
 <20261014194106.3205338-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014194106.3205338-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX2e9MqLszudNr
 tK/aJviSgkbb1VSI68d4ugoMDme8IWBupC/0ddDI3IDmaUJzv3x26YVMWtIIiEJv7aH42E1XxZ2
 RemadV/hpsRE6VolXqckvqsjwQedsjj7WgC2xmg68mS+hnrDCtZfdCgUgx7HkvlIq01e4IZnVSD
 3xFRtvnhMv2C26kvcguq4YrfZeev87/RB82RQVobXNJHaQT9v7Frgx8zrtYbgZxJ7jhdKjAJOMW
 kb0aJnytgNboq+MZKhSLcYOxpsrNn/Hm0P4FGgo/JI+tnNKD06tU8Ke9WTG5clEowZwO40P4hvp
 u+FVmocRwwaILqlFnFjarocp4auE3KbhaXdq2uQrmcaTuA6rrgYe+cncVPFKFNYOwwiM+Y9wUCF
 JxsQ2e+LwG2o+ErwqtDQ+xT+YZLroKfhGcybyC0PnYxae4HbiAKGEfmIUnJyIAw/h5Sw49xzCGy
 QpzlnbOAtZ2fanXUuUQ==
X-Proofpoint-GUID: 9Eil2GHqeOyfMiGF4fW62Y210NGljUzM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfXz6MIcNmHJnUt
 CHqr0RuqB8Jgcy1cmr9eGNBELnhnPeUafPsGiNShy4xwHmgLkeg8/7Z//BgR/5+hFBgRLoWLrDV
 6OzhHhf+FDZb2G8qGYYEyRyCbOJd6Hg=
X-Proofpoint-ORIG-GUID: 9Eil2GHqeOyfMiGF4fW62Y210NGljUzM
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfe5ad cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Tgi5fKKNRp869BBpDpkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
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

On 10/14/2026 12:41 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_globalreg.h |   5 +
>  target/hexagon/helper.h                |   2 +
>  hw/hexagon/hexagon_globalreg.c         | 129 +++++++++++++++++++++++++
>  target/hexagon/cpu.c                   |   9 +-
>  target/hexagon/genptr.c                |   8 ++
>  target/hexagon/hexswi.c                |  10 +-
>  target/hexagon/op_helper.c             |  45 +++++++++
>  hw/hexagon/trace-events                |   1 +
>  8 files changed, 205 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

