Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C153C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sV9-0007zg-Mj; Tue, 22 Sep 2026 00:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sV3-0007zP-1y
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:53:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sV0-0000sO-Cm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:53:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M4MaPa3382589
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sdVuaHwnZ6wSsPBiAOwmOm1hCxA0T2q4YVvfcNgYJho=; b=GYzSDvG2ray/BuQS
 SXQVRQIWecJEixLNEtvnlW5lcHvDrUtpZ5BXY7zWUjIis+n7kwWMhUa5iaTgUmxX
 b1s7hZlXE2T9upobRnVW+B0g+Y+TP9LRUz4rsP6pKdAF21LhjiUZA2Ge3Hw7utQ9
 3pXuqi7WGB/U3rTQpWjArz6qDT5/+BIXKrkPahJgikXfkanMwWXm7zOe4byQCzX/
 vbX816BiCBd/BwEUb3CDd4dmogy3tFprb5fEgdLqvTj+7En/zEpOAfb+lRMTeI2Z
 4tLe6zjigjSLdgp8SUMRSg5D95SZAUWWI13dHyanhBD0PrUO4h98ErGMAYqqDrQi
 ZrDEBA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gujkj82kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:52:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-912348a0ffbso40603706d6.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790052775; x=1790657575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sdVuaHwnZ6wSsPBiAOwmOm1hCxA0T2q4YVvfcNgYJho=;
 b=Vp9UQa54wj3UKwxLu4hoqvkY6tg9wgbOe4qGu13RyEwFmzfB3sENmUQB+LzgLNGz2S
 ImzItda6bQEsDHTRwVPKQlS3yHCVNPHbBobMKoWewkfnOUnr0WuYyr+Y7Nkdogb2TeOq
 MdP587INwQyr9PL+DgFO/UIdZtuFwNRKRxbh+4fnlOVN27/eeIJu/plAnr7UGuRA38lE
 O+kPJhXviP0bZ9G9c0HDQN+gfNW6MIhwnwW9c0UmBxylnI1ZZNu+hmgT78YE/3Z3DJaX
 jf2b78YWdIb6NSFIpVxJWnOYXTy9PwXCBx1utGcm30U9z7i0edU733IhII+B2IBik+ef
 M8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790052775; x=1790657575;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sdVuaHwnZ6wSsPBiAOwmOm1hCxA0T2q4YVvfcNgYJho=;
 b=NCMC7wnbt9kcfYmQpzJWllSbxskuyiAVwK1246jOWDXO2M48kpa8aW1UV3AZqz4CPh
 aoC94PDz+nhCwE9roOedSZlWF2pJV1EWaqjjgDJcJmWkdCCr/zBR32ugzX02R5NE3eJA
 F12FYbBBy8vNbAhVMC8pCYlVDeRVrKkebi1VPWyh8UXsUEnGfr1ZG7kPei1HfXe51dVU
 ddKDharo3hxhVgpAB2FgMqGdrnZAbRdHid+dg4MKyGcw/q8e9kiVq9TyDznB9ap+PUqG
 AeOgnRS63ry7iLAxotiGtxrOF5ykULx9KD6ff5HFUftI9d5WunEIjdmWEo1rHXD8jasy
 0klw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+dXfXKpKe+gD4Z9vlYNjWQVtv5rvsZ4405V8evRWIyaDxnJI+KT6NkxKE5ej0MOD4e+pECZNqD4ux@nongnu.org
X-Gm-Message-State: AFuF++la6m1LL6kehPEl4o2TjG3yWIaSbAjUswrCyObiyy+YjYwExy1O
 V0osRDW1Rm3Z7Dv+4/Jsi5c7AYI7qKqDao6+I8kWjZQZpbPrGn4BNtLpeoxaEj/N/EC6ZUf4ZAd
 Cu888sTDGtBtWyarSHFGTA5FBXHSGIW8TT2ZPINnyIypVYBypLttl989lFg==
X-Gm-Gg: AYBFou3GUMhstA7KuDsNr0RPwooX+y6CpUtc7/hng5gShK5G2/fgizRWPG61DOi90eV
 4UbW/rAla/yhdmn4TbbbL5LiyofIiWslQ8xG70CKGgH43+/SfL+YSFdSV1QhoFZKoWIC2V7DG5B
 OjbY9kABHBOotCUZBAmLu2aN3m50EFVPyeAhb+MZ2hh+Xru7NWb8DE6dWAjlithvdB4bXjBfZFk
 oDIuL5ZHod83Nv4hkC6OsmZXlyJ/AjDzrRn6HEUwq9pWIqFZlyZjgCFuymKTSZty/O0CNDrEV/+
 VlNhea7Zao7oB5Tk3lvwzwA/uFeZq0toMU9FO5ITx9Z3WVPmhAvM34xRGX3jfXc6vXUM4EvvcPi
 S8mzqdR/su9tvlBwqFYnfBFoHnZqTbZbzeQ==
X-Received: by 2002:a05:620a:4388:b0:939:a2f9:537d with SMTP id
 af79cd13be357-93c15d9c6b2mr380564085a.26.1790052774896; 
 Mon, 21 Sep 2026 21:52:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4388:b0:939:a2f9:537d with SMTP id
 af79cd13be357-93c15d9c6b2mr380562785a.26.1790052774461; 
 Mon, 21 Sep 2026 21:52:54 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862785b97sm1676149f8f.23.2026.09.21.21.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:52:52 -0700 (PDT)
Message-ID: <2a5309b5-41af-4166-ba03-67bccfcdea18@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: synchronize state for individual 'p' register
 reads
Content-Language: en-US
To: Boden Randin <bodenrandin1@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260920023640.1861-1-bodenrandin1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260920023640.1861-1-bodenrandin1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SCcIBNhmBaKWVqtwFaMupZNEt5ho_454
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2NyBTYWx0ZWRfX4DcObP07/CVF
 TAzPW5fjbBx0v/TAs8YPE5Mj1S4iM3oqYU2RCDlUzoN2llKf3j6ogUnmactkLSRDpk2pjH86kBQ
 2lKGVPBu837Vn+EdqaiHXycyyw56v91/rl6ik8+QWFXssqp6kFMeImOe/+SVmnHLCelUJrJOfYE
 3wgKffCFuvzIEL4Rz/RG1LPnQxRr0WJhhLiOHBWCf21lsF7J67idbqAoDKJgCUyuzP1xm7kk0Tv
 SdoayYgFhhYnBzU85neJYPWfnasjhahXKEcu4stZW0sgEDR+/K2xkQ4mA2g61Jfkm2WNjEhJgCa
 MKcl6ueIuRfvX3efTV/SChV5z2RzIwW307W7EvDxzkbHOkqs1nngQZaP1wPTdxuVpAWB9tj7SNw
 T+6BEhai18chT5Ty6sIwwBwdcLNu/yTdXSgrdxkPRbMrUmQnRJyIUzJf6XzEcKtUqK0WmBJuz6V
 vI6J0NrI5woeIg5qRcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2NyBTYWx0ZWRfX2ARZKgZJHJZl
 aL0UAavnF+RIoUUjDJjj0B9d7JzOzIqCAhAF6st938hJ7K0j48g3cdHLhA0er5+zM7n/IC49rpS
 B9vy6a4aE9e/uw7bMSPf5o//fwTCKdA=
X-Authority-Analysis: v=2.4 cv=SuAFe/O0 c=1 sm=1 tr=0 ts=6ab209a7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SCcIBNhmBaKWVqtwFaMupZNEt5ho_454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 20/9/26 04:36, Boden Randin wrote:
> 'p' does not call cpu_synchronize_state like 'g' does.
> 
> Accelerators may keep guest CPU state out of sync with QEMU while a
> vCPU is running. After a vCPU is stopped, an individual 'p' register
> read can therefore observe stale state until something updates the state.

Yeah, I mentioned that to Alex few months ago and have a similar
fix but put my work on hold to avoid clash with Richard series in
the same area, waiting his work to be merged:
https://lore.kernel.org/qemu-devel/20260710205401.836304-1-richard.henderson@linaro.org/

> 
> Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
> ---
> 
> Notes:
>      I found this while investigating why LLDB was showing the RIP truncated to 32 bits under WHPX. LLDB appears to use individual p register reads by default, while GDB primarily uses g, which is why I noticed the issue much more consistently with LLDB.
>      
>      This is my first open-source contribution, so please let me know if I missed anything in the patch or submission process.

Well done!

> 
>   gdbstub/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 0a328b0dd4..31a845cfa7 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1246,7 +1246,7 @@ static void handle_get_reg(GArray *params, void *user_ctx)
>           gdb_put_packet("E14");
>           return;
>       }
> -
> +    cpu_synchronize_state(gdbserver_state.g_cpu);
>       reg_size = gdb_read_register(gdbserver_state.g_cpu,
>                                    gdbserver_state.mem_buf,
>                                    gdb_get_cmd_param(params, 0)->val_ull);

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


