Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E50CC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEa-0001LL-In; Thu, 03 Sep 2026 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DEZ-0001JZ-7e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DEV-00047f-Hb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:26 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3fLw1209697
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 agcNxP5OLUcImCl9Hm4LtHNpLQGmCzfxliI0NLG2h+g=; b=BJE4DEhNjSOjfahp
 fdvEMavICdUMGbrUko0AAdRZooi/Nhuq+DgdA2eQ/g6G19pzkjHfdgjqxTPhPFzk
 tH+iuDNwVABdNRtQ+bwkkq7T0S5uJCFKqQBida2nmMzRUhpJBHiXvT1zcMEvNxSJ
 DEQQgAzZT+ahAMbUYfUrReY1q7dskucbEX0TwuYV9G7Ypk5krCNvFmzfTYyFn/t7
 +1cDBfTXtw2AwyDma8wdIIm5v3yM4Js84oHZeKyCaTgTQvGc2RSSkPkH00wtRk/K
 w79x6CupzOmpVCGP7V7Gm/mPSdKBTjzgU41RtrKfLLCsYvAOGviKwads4a5NCgUQ
 N5upWg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p72kmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:36:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so228256a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464180; x=1789068980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=agcNxP5OLUcImCl9Hm4LtHNpLQGmCzfxliI0NLG2h+g=;
 b=YEB1b1ZynynvCTcVJmW0WnRQ4/p203cnmMnP0xMktcyJ9/FBLREzenDRNZpWs/5pSL
 EkKloIoLxQM5BJMZRxCcqmxF/WTYumeQl0d09A54D9a/7vFO4ul1zPaA6tGyQcHTYwMb
 oV3Ymaz9yCj6Pnem+4nSdAjwUNvxM9GNSRxMOqhPe+McvjhDjbeBuqAF7x5YYRkM1JyN
 /SBE0wxB26ws2qZO0RgcKGlhhFzzHcC/F8Azlfe1WsgwlpR4t5SjFRmUHMFtSWUge8d5
 ZgNvjSnXaBlXEGepN5wsIUINQbqNB2ckTswz4ghFkt2dKkLYwFdivSUpQD7qLmNIMpuF
 EI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464180; x=1789068980;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=agcNxP5OLUcImCl9Hm4LtHNpLQGmCzfxliI0NLG2h+g=;
 b=KwG1rPe9rZIcgUiP/BBNJXoVeDECLQYvVPHdsaIcdGjYsfyeSmaGRJP7/ORkm0vYIy
 GZzpnTvQawoBfbKm23su/dZ9n1Qxz9chrkctI9GfGOcdEF0qOG2EO/rf/kjNqmqSov4O
 zMuNNOZKj9OPGKsiqM1F8zRpr42OUBQ5ELKyEf26P8iDmGcQVXwrUjQUESbA6c8uoUij
 OhJqlK1XoPBw4mNSTvdNxaTeXu7O9lyt95fwX1CJmIGp34PxOQaJw7MIa3WGThll3hUx
 tn4JLYiHpzRUZJChlKCvK7gS5ZedetahfU9to2vemItXp9akBllxYwb8H3xErfq2wmrU
 CLXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfHh+GY9RSTpc5lvFuAVsFdMRZdYmttpTg5PVvoH1jS6Gc/t7pJAC6kArDx7FqeGxUx2IK/fPheqbD@nongnu.org
X-Gm-Message-State: AFuF++nfSXBxOC+v8uJ7On/tbxYsDULOJ924JxmWnApfWh1Wg1VVGAI4
 rTTOq1tSbPhvMCarPy4nPEsYdJPqRR0TxKsGJ8YVQGh3wx6aLPQPl8vPvd2tflYCgu5y1kI/xre
 qwaSz9ni7gPebwAQx1rYeWqfH6uJzYYuEHmrkwKcboRu2Rumf8hC7iIPq7w==
X-Gm-Gg: AYBFou1Jk2tFCqFS1IuwhnfJg9Ge/y8lvkx3wxXq3bU/5kh0fccqsFRDAgV+/V2/Kw5
 TzrHKP/53GU0zjWL1Q5f331otvPiTU0LmLP/4iPrqEipqQ2YgQ+2Ye3GIYqwiqy9Z0NMytoAyJe
 VesuzUivNbzBlpb4saUvU9jp5Kh6mE7HjGfYIJYgxhBK+V8Q/xcvdHW7HjhDlrcsWlmv1Qj+AuQ
 PTCG8y7Cmw7Y3pzETqiKJzz03hkCwguOuEJ42g+LealQiG8AnJNUWkgW+wYjZ44c2G9t5Ka7Iaj
 pp0fkrKbJLpna4QSqf3IXemMHGxLQH5Xob/cNAge2F5KHjAi9fCDVTLmyBLV9LoPFpb8fuknMJ+
 Bmn5mVdJq8GpEdT+2hNId2CK8lMae8tMjqfthBApN9fmG2mZVe3e+FN6pgC10674CK0ho
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id
 98e67ed59e1d1-39b260dda6emr966985a91.4.1788464180514; 
 Thu, 03 Sep 2026 12:36:20 -0700 (PDT)
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id
 98e67ed59e1d1-39b260dda6emr966943a91.4.1788464180098; 
 Thu, 03 Sep 2026 12:36:20 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm1128358eec.31.2026.09.03.12.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:36:19 -0700 (PDT)
Message-ID: <01c05d32-c7ca-4b1c-8eb9-550de4c3eb94@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:36:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/hexagon: register the V68N_1024 machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JKIu2HhQU11lbooxu6FukAiZA4noq7WG
X-Proofpoint-ORIG-GUID: JKIu2HhQU11lbooxu6FukAiZA4noq7WG
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a99cc35 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=5glRtx7Q3XNOfFeiq08A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX3zed/u85GpRU
 5yQFoxPvvIr5Vkw7+ZbvnWp5D3esFEYKYppdtgty0kHo77ecxggqwrxWnvD5DEfdKmLAl5wEEY+
 kRjfaXcVERY7vH/Gmrebsjd6WdSR/yY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX8f8BhNCsOixN
 Mn57CUrnDLBF24v9Jknw5QUr3o5QrYS83rz5dKjL/U+GOjoW0v0G6iIzqLeCTY+6JJ7uTHlbndE
 vm244OSVtjwzl6nwrC/AF+6cdZgF+KyiaqTqfWCfdvkBm8+snxXx3MOnX2PkBztTMhYCUggzCrd
 TqlGpOQxuuq7eWgQz4oqhbFuWUiK4zM2HEXEI1FZ2iOpZ/NxsBGHy1Yy3/IuhrQeuFlUNb5LfgU
 vd27KGqRXFkjYj1c1fVdpCUGif/5r3ufXF/pJZVRmOQhMLmplvkQmrsLcyBsaAa2Fcj4FM+XrGZ
 e3IJHpvkOuggl2u0Tgz8GqOGxmDGWosD7Cli8WkuC1bfVkNPYH9AfywaHy5N14LqG3nmmARYrss
 LjXPfMMUQB5eDhFcbAPKgCkdd7slb+6Tid/q2sF56Rq1E9yzuwUdIi1+5HS0Sq5nyPPlx6OIZip
 Z0+8KfCCRpZDNdhgjvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030170
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> This DSP definition file was present but not referenced.  Also: add a
> 'sim' alias for this machine to indicate a recent machine with
> memory-map resembling that used by 'hexagon-sim'.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_dsp.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

