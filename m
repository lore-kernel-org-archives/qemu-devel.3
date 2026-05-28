Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6426CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgb6-0003hN-2E; Thu, 28 May 2026 15:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgb4-0003ga-5Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:40:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgb2-0006JU-Hn
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:40:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGwBT82753552
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j8ime1biZirUjyeyKkGw9Xx0PStXRebc7H93D37wgRc=; b=HlZ90Zb2GDJhmI10
 O1TTb+1qx7Bk/5a59Q0HfM/Y9wzxfpE2sJyzM3056dQog2mGjdqONHcigQDCXg6P
 /S6huCSgBC0GSVisz+0FgYjt6MVDxNcj33oH30CG4W5fpyFBBZbxAzz4yiZsqm+J
 jC1TT24MiqXkx3J1Qucfz+AdXvFHwD8L6gJmJuZ8EOhpbuRYoYm0rHBPCEyzu96c
 a2IOZdGocKgTlnsmSuoBhY+/JOXlJKMsLoBPP9QLDnEgtLCCSOySQ9kA+32mCWAn
 RQJlCJ5iNyUCN72V32IbgW4r87vp05HYtiD2FjPXntyNtzRNfUopnHAdY4MmK3WN
 IViM5w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eespn0q96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:40:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso388342eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779997246; x=1780602046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j8ime1biZirUjyeyKkGw9Xx0PStXRebc7H93D37wgRc=;
 b=S9urOcCobiZ3GiB7EieHKBaY7B45GcvU59sfnwsBNOcrpzrtK8cEZgOL5an8ugNfC9
 G5iDqA/zjwtqGkUqX4PVhmXuVSxH8h8IkNTX8fBQvO4xhTlkHg5I7Wknuybw0jcqYBI2
 17PCYaVsoerWLKphLZvaPN1XQw/B50BxebrGKa4HT+k03g0VUvEJWvkCXcQksl4KJq6h
 ApJAC+1+XIXUpaocQo6Ta6XKcddTgg7vJYpCOG1LmnCqSlBtru8jpwOvC36vjjM9c/Iz
 tOhaqeU5omYpK5lMHKmNEwGPbY3LZvJjy8f6GK1ibmLreOGBCN4kn019PKRNEIctsOcP
 mLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779997246; x=1780602046;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8ime1biZirUjyeyKkGw9Xx0PStXRebc7H93D37wgRc=;
 b=hjgDniZs5NRW0WEOFHCt49i91RMdMjxZcl0TAWjHEfPm8UIxD8bXYvnSoqQ5Ts8APz
 /6jZWTf2pjuZSJbDKn/5YTVt3gYZbRj2tc9AJwTAYFzFe/5hTad0du2OWLmJuZB3z2xU
 d/lOJuL3y4fXE8DrfwHfOqGDDj7tyMCvNWB/RR7LWO57G56GntZ1h42FU+KtvOb/oc5R
 tHXqZrRntpxwc8KAs9Ug1aTC1KH/0LcYaSn8r1F8Jp3mLqEGMyeWFjq3OyqQHLcXXJe+
 dpHoDeVZVL27+1Fq/vTaPDRyt2qOVMM3UX+oT1d2kGV9mtqV4wHFkRiTCJH4q8RBNv+m
 1EnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3GqqpVczJaEolbuYgxbIbjuhSNX+uRGc0T7//JyUWtd9EDV7jn0rCFY7ClLBCkryzYSnf+tc+MTm3@nongnu.org
X-Gm-Message-State: AOJu0YxF2BlUixrTuUDNqf8JJERBn3+hXElKMw/6CbAEglbkTVmOHjG8
 lKQiLxl+5IWN51VuPWxK4okMzD6W3/fdAQrAViqiM/vShwAIcdIH1xO9cKH0e7AJiSnGokqIW/U
 Wl1OFbLAsVdKv+XB9uXKqwCEiKBAbK7zdEPvb/+ztyBIJ3IZMwy7aemEGrg==
X-Gm-Gg: Acq92OF/v+1grlJQNwqNwAqk0SE0WFlyp8d7PZ1P+ObEsML99c5bufbAcjnluazPP/8
 ulpxVjrBMNTmSaHoq/aQ2KhahUifKLZMWupS9U8BkE2RWekRsgCxzShH1jjqcVXbx6kEHa92Vws
 iCGuSnf204FOlH4kFB92Dn9caBGOo716gyEAwD+049vH+rcC0i5+yEUnmzQi5UAyAbHx1Nu+9MI
 F3KzOtMUhK/pwI5uD7TaarXBh0Aj8TGYWUFXHad2FjxVEMGdqNb10Qevlm+EYIM63ivojU+RU51
 2l+bE/0XaHxVgkyZeftzmOQdvuiflD7vy5Ca6Ma15D0+dJ0gDf9cuRTxXvtrpdaQU2l5bRYM4pX
 QFdm6G15Xfjiac/WcvdW2K3DNqwmkwUCaq20xKlVOW+MU11mcLO6I/7o1MAJqSpYU3rxLl6AvQt
 lG7f6cfnonbsYdc60g6AIfB0Jf
X-Received: by 2002:a05:7301:d19:b0:304:6782:d551 with SMTP id
 5a478bee46e88-304e8d8b277mr182654eec.32.1779997245881; 
 Thu, 28 May 2026 12:40:45 -0700 (PDT)
X-Received: by 2002:a05:7301:d19:b0:304:6782:d551 with SMTP id
 5a478bee46e88-304e8d8b277mr182632eec.32.1779997245360; 
 Thu, 28 May 2026 12:40:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e990f413sm236094eec.20.2026.05.28.12.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:40:44 -0700 (PDT)
Message-ID: <9d0853dd-5c22-4c46-9c42-a76d18230271@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:40:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() ->
 const_le32()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 91tLSC9asv_P6yjChRuF5bG8ZzbB1VXb
X-Proofpoint-ORIG-GUID: 91tLSC9asv_P6yjChRuF5bG8ZzbB1VXb
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a189a3e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YlDpDrQhXjdAcolmsdkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5OCBTYWx0ZWRfXzqxc66QNVfgU
 hNjCdMDARrBuoNWaiEX05PCDvkdXw2FVNBl5vtCrSp2j++GrNHd4dDrtLl9WeWqcoyiHzCTcKhf
 DZGiZ7g8/GrcdSMCz50OE5w6XEzwPRNEnugAaafJYYJzWOKoEU3sJekW2SB75hzN0b+uWH2F9Sw
 SAvfAIrNZFjBhakxB3m0CeE8vqDr/lKwMseANVmAuGWuu9nn+VP6HGCeNzxWT0l9YnfjPM+i/Vv
 h5pK3Mhx6nzeVcEAaKgwkh4ivsPlOPPVqeVa+cimRyABkWci0Tw9aasgQSEdP0x4cH1UTO2MOjS
 /+fd0YLNjyqqZG/bcV3fJAnd626fePtV9hJ4HytxjHmEJW8IvT5m1ir3FS8OtU6fOjrB3auYDVz
 ZF6xedx1SPGindecY3KMDGcLDEAC01BqV16Y7hPAgs04AqX4/rEmAOUDJmGVlw9YvyA4wbnAXjz
 FBXxXTRPA1RpH22dV9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280198
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> Rather than adapting the array endianness when it it
> filled, directly initialize the CODE words with the
> correct endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/riscv/boot.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 

One could argue original version is more readable.
Any specific reason for rewriting things this way (performance, personal
preference, other)?
Not a blocker, just want to understand the original motivation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

