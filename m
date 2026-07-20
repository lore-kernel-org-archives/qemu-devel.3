Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E034C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljLt-0007TD-GZ; Mon, 20 Jul 2026 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljLr-0007QZ-EK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljLl-0001o1-LH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:27:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7retW2979868
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AtcipE+L4qE3mzbEqfcbIU8yjjGVG3Ie9Nfn+3tw+Xo=; b=QT/TNIQycPOBIBIx
 kzhLYpbKgMuJJj4PNVY3JKqwSeraZrdOr2BpcGToiq6UeVOTJrBHFKE3yitfRLoD
 0VRZUbxTTA0Z4cbwJ+lwPz3kETS5eZpTLZTOh1vAx3UFIF5GXUptL1E8gkPC8WTJ
 qJDNPczBk4MzuBOLabW7gpDCIXobqGtW7OtTLOW41OAoXx2B7JfOdlWHD/UJZvMB
 izB80d4Ye7SETGePzf4BFFMf0iRofRPaoKptiWvJ8GgO1XU457fD6uqqnoEpEkGM
 DugwVYZlQR6Y7tqYWPMTGl3A9wGI4EP81H/aTAr3UixDNTSNPDaQEj9zihaUxiPC
 CjJSFg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg042k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:27:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1852a86fso138986321cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784536063; x=1785140863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AtcipE+L4qE3mzbEqfcbIU8yjjGVG3Ie9Nfn+3tw+Xo=;
 b=UhjgsE5dtWtVK1K+OB3ls1rfuynvJC62kirU4x/pOkG1LIMLgpVr9NNxXQqdUlqdnb
 rEkJiLqauDtfiOAmlASunW6F3AjbxyIRAFWc+r2NnojyQROS1fjcujTs9DtPDYqkTkBs
 2U/fVFAejdyHdetnnUMqbzv3R2yDDYEvJp8HBMygjMXjLbfr2RSl/xOQig0GgP4j5vCo
 UYfFKSBJqcx+tOkFTcvcQHA6xhzgzvaXqe0P2fJL/u50PZg+a7t+XXExjS/l69S8lnCy
 12C0ls00B7MP+bSakC2gmciRwUSmQUn7ckSoL5xEc4w52VOuhgX7cbjXoIg9erJ88AUK
 TjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536063; x=1785140863;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AtcipE+L4qE3mzbEqfcbIU8yjjGVG3Ie9Nfn+3tw+Xo=;
 b=nG2DpQjNEjuTf1BrGo79P6WLKyLHNxAPFkFk18ENOXo07HTRRqi7I7RfVM1/7kx4rN
 gPTyoe2smysWanNhpmWeDY1WcYGaJrHegWXj8VeoMGJDy05OC7nXBhNQWNtlEPLeYLj6
 mJOOVW62w8mKiiosoJHcJPZBjbUvjlVvO74fgpyHWaGd65pJ/akDY2E4O/bvPU03QtdE
 TL8ilN9xMRlK2KVSduczmiUJo/2reqvsZ12XkgXwHq/hwv85Zfqw4YKVPaFl709CLh/e
 AuEJ6kHTPDMTIt+uzcTL/Yi39xdSkPiblsRLpZxjmrXVgg+E7n2whmvyTbB2m8Jipf/+
 gDYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRJRVTOSqsy7iUWbHyFNZOgl32Kbd3jjQyRV7yyqHkRvcqV6uYy/3Sgi3LFXp3Je4f/N7ppJiDO0fa@nongnu.org
X-Gm-Message-State: AOJu0YwjK8JgzIlt626FN3kqZdXnmsG8e81fSGKs6Cgb12Lz+c/JiI42
 D9QZFsX9XifiryOhA8kZG65sMm639THnlKosIbxK7iuV8ZY71BsNkTK4JR95YPG0wCJMCUABgur
 jQnul1BFy25Lg3FFdzhe5oXHT26C5e0wPCZ0fwUoPZn2qPvUVV01WMUgivg==
X-Gm-Gg: AfdE7cm/NAtd6QhUUpQndNJxh7amqKG25H1qoTMJadxS+kM26GAFiG+pXeGtb4cJQC9
 1WLsudIbDPt7vLBOrjhoEg2uVH/3RwBX4EycPUDgDndpx/Ph4GwwUozy8CyO9mzSIWbHbUY0cp/
 JYots1Spzm7J2CdKma891bdKjf6FF0g6IrBL7TmUfsZ+Dl+3CcIUZhnfXrdBAVlDhdWguj8wXPa
 jYFcHHfIQk92EbZd0GPPnZlMLI72J8TDsge4u9vmzlMJqICfzUEKsQHry8O/TYlW3+qT7yC8zpx
 X6GWivnz/1M+/NtEMrxR+yl1LRfMZ7SU4+dm/OpjUxXXrsifssl28Tkn47Zixkl22Vawaj3faFp
 7IW2uQNp0/dG7aDkW5O4Jjj+35vLV2Qh/IwuhC31nv0sJUz8Hlcc=
X-Received: by 2002:a05:622a:5516:b0:51a:8c97:9378 with SMTP id
 d75a77b69052e-5213ea7e8b0mr120439841cf.64.1784536063136; 
 Mon, 20 Jul 2026 01:27:43 -0700 (PDT)
X-Received: by 2002:a05:622a:5516:b0:51a:8c97:9378 with SMTP id
 d75a77b69052e-5213ea7e8b0mr120439731cf.64.1784536062697; 
 Mon, 20 Jul 2026 01:27:42 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b893dsm232245575e9.8.2026.07.20.01.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:27:41 -0700 (PDT)
Message-ID: <8ec921e0-1055-47a1-93e5-adee92a469a7@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] include/user/guest-host: Include exec/abi_ptr.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX7o3YGGmZjEwN
 Esre6rfZA+RAHUasRHDzWhR+8dIAP8tPdNErY0UcdM8Fz7vswCnU0RPxkXHXUVPY2bAFmPPWXmN
 1Yu+2s93qvGlWdPI47uu9RA/zzK9V3I=
X-Proofpoint-GUID: nBIipNZL4BGb_dSrQPo3sR6zE-ZJ2mR1
X-Proofpoint-ORIG-GUID: nBIipNZL4BGb_dSrQPo3sR6zE-ZJ2mR1
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5ddc00 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX6NpVZRYfJ/dZ
 EO+P8RD3WoMxQDdCnWdvvdFkaTcIznsHRjR1vEOiI45a9PpBwC1TDQMIKIUJ+RXv4F/dCqLwTOq
 A1E6M2ppIIGnL9I8tNGLjiSdt0SruT+HXPSGE0L801ILL/9rJmt+NnWKS3LPUvOVyVc9jytqxVq
 qLbpGu5wgY4rP+jlxkoQd3vovVBuwZPtBQV5mnJBFZGP4Nf/SdTFYT/ZL4cEU59XwzwWmwmst+1
 sCB96UrgJZAr7v4aSi9JLEhJ1utxN4MTRY6N3atJMnEInLjifBtvpLT9feZUQfMERQ8cxuJN38x
 CQQ1AD2b2jQ+osKTXjqFZW9AWo+J3M8EoUORUpCWQnxYEyJoPXBsEJmsUo+hZPKmyL0dZvbmtyG
 I5hO9cftJS13KvzbuLCsxStc+XIWnrhGNFqcClSDBkOgEoqCTTDL/FcYfrXfY1FZbeie1K9MhPS
 ECwIiZ3RnO6FnRx3cfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200092
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

On 18/7/26 01:22, Richard Henderson wrote:
> The COMPILING_PER_TARGET block uses the abi_ptr type
> without including the proper header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/guest-host.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

