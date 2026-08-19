Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C70BC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUSe-0006db-Oz; Tue, 18 Aug 2026 20:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUSd-0006dS-4u
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:47:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUSb-0003RZ-JM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:47:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkYVN2345575
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SFRUYpuF+46L75ZXavF8gCuKQLp25Qyc0t4gnuxebcs=; b=i4ILILS5TUejLa73
 a/XLlNOZbtLPONunLFQFaTSPf2cIbuAVgzNvtwund8muvU/4aLXMlHzHgakOAYlx
 dAqz63UBvX4Rg5u6LGfoIP+Zf27a9NrqwIOhj/U+8aga6dJxbVOBtuRrz9ftCK2x
 XFXv8Ztr8qTFDPDckdGYZ4FQTZUy17Y7f9JqBUh1aZhxV7A5txhg4rRceclL6nkg
 XY0EiFzVUVdWEKVpjqLFlvdSDk9jzTCAJk7tQCiBXRMCao2L4eZaGYJGYzrQ62Z2
 7ztkvkWWAxTnZgogiDFZcK6RyAIjdJxcsCNIG572nlQVjWY212zhtXcvS9MKOKI1
 YIzm0A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm8k1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:47:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso46115785a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787100434; x=1787705234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SFRUYpuF+46L75ZXavF8gCuKQLp25Qyc0t4gnuxebcs=;
 b=ZaROlRpkUEw0EFKMrAJ8BfzEk/qALUXGm2cP1L7vrOyIUjs43H7XXmbWNRp9QKJxr3
 TJjkXpnqw554UXa1e78eE1a4Soylq2imby/aBwwJQMhMjNtcejz+7gb7OmKh4VwR8cNo
 HMq0cBsLpfz1meV8yzN/xmoFPiAV1qL8pz5c41uW5ECfBkgHYW4FttcLZ5/BcI7WsEw4
 1DCvr0Ws5jyvTZtnh5jiw1I74hwdEHQnMztoDLyCCsWMeAMhmqXEKXoIvH2on61MFHBg
 1LnLQFdKAJ/nHDu2nUjf/uyoVjjuxBBXoIWppRv3AJJhEZObf/v+rp2PqL03+jj+7CBt
 AVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787100434; x=1787705234;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SFRUYpuF+46L75ZXavF8gCuKQLp25Qyc0t4gnuxebcs=;
 b=XyBLqxcTC7+/vpjpOprWyKVLHMS/xy+WJq0Ole5s9E1Oyme7H27Uiw7Af/b5OXnU50
 1/M/bubrdjmzZl51YY9idGF2qlNK74MACURu8YMTs7kpRXQNiJ3aTNNfjDw259Rfkd+q
 8B9YxzK/PcsErlSgaZWAM251oCx1fLm2yAgVT6NfyneU41nHUCKf7g7h4fFWrckQbJXX
 RwfaGjIo4ttpuCGjDSR3/XdyJZdPV8MOlNAl9w0Ngo4FhTLLwjCTZVqMrAVzjKnVgWdo
 JYyvcA45/oQY2wLBtreac3M6C8c5NdFL4wqU36UJ+J8wXeuFAPzaeUOLM26KWi+x6nMz
 akhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2jVdVzxrKfs8kKGt+aWLPabuUHME364XYQKoaFLGQ5vtWFK2oFjxAGABNpQEaQeM7jdsRpqiI+ZUg@nongnu.org
X-Gm-Message-State: AOJu0Yz7u5YovjfrNjVK8RJXBF+0AZmLPaKnom/Sg4f/LX9HM5QIBw16
 UgRs8HncAGcLbZ2DxTJzLu1+GGGzPgQ9C4H3LXNV8ispzwqzDVhV9ENRDsrIMTqXo3+FnpzMpm+
 v9HFzdJqiQo3bm4rsQSCr/prZDcMdTUKyk5R4WV3XiPyBPYy+voT1T83oKA==
X-Gm-Gg: AR+sD12PI9VdXenmPj1mqqRRSFgKQOtEKdp24wIeXrhliE2gjPKF2XD3qx2N8dz4f51
 /yMhIyJHH7P2xrzL3AxmZqCCJtTfOwcVwVjEdbeCWIXtXE36MmXuLda0CCcQN1tQVoo5wo77KlD
 cUAo0tjC/WRmSrSPARbi1RcuxmAsDdDndi/Gqt3gNVTxLYD7BWs4kyA+ltP9ULIRYFgRFXA07ip
 0gHIgcIXYZErXLk2UqxPmBIy2HlwaLX1peR6l/3c2loHH2XKzjF1ghlZjgvwjW9mvSHAJVvcEcH
 YgTjQaucEiNwnzVUy0G2m2v8Zcyg8Y4kqjxj7rlHzYxkkAObreSCrnTHCCCMcayj9X9UOpiv7kT
 D5mKloXg9Wz49wKWvlxuUbE+Q1icnTwUpZJQ=
X-Received: by 2002:a05:620a:2a12:b0:936:e4d1:fa2b with SMTP id
 af79cd13be357-9371e6b762fmr122222285a.44.1787100434190; 
 Tue, 18 Aug 2026 17:47:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:936:e4d1:fa2b with SMTP id
 af79cd13be357-9371e6b762fmr122220985a.44.1787100433794; 
 Tue, 18 Aug 2026 17:47:13 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441725sm1177389f8f.3.2026.08.18.17.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:47:13 -0700 (PDT)
Message-ID: <831a8f18-4bbb-43fd-ad7c-3698bb3ce7f2@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm/aspeed: Drop ASPEED_RAM_SIZE
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-8-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818172012.3052821-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX8Xougn7MKOne
 7HclQn1eiuUFNdFqa7CUVcFXU6QgIiR7iXlkBpdHPFVTz0MX5bZKyuA2cbahPbM1dKwO/9dz2dU
 8DMQe6Y2bjEfyx42ejWM+9+JUYxgV2sPu/xuLpSxQkMRTMw6eFROSqAQRePjWrBwF1Dp07xJHCp
 Zmvx9n7bAdGpg2/BzQSA4SBBe1Pw27U6D3hHUkcN7pFVlfo7NAUVkQQRgDQyNSUNatbGyYHroUz
 O/115O4a1YUOUj3K8X4MOMsCW556LCgGXC3k8V+3b9ZGvkWcXUActaTiQfRkNzne2swtmPKr+PU
 ZT74nfeeUkVq8pFHxvClMMG4Yg+sLrGtn8gL2elVj6jKb85YRM4aoCUF+CKrwLQyJPXjLs4mZt0
 TDpUO7oYh9226Ls7HjImxDAXhc0Z5ojxHbq7FysKHWnTYeGnAwoge2gHeIW8r/UOLeXk9I8e5lf
 f0uUDZKhhY39q1+LZdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX2X8iEonrXTcu
 v0Zjwf4gl4ATjqrSlyzU1JhZkS3iNGwhv2CbwoiolvdSWknQ2tEKxjX9CwC0nmeEAR8Or5cQ1dI
 qL8FJ4jvXxvUwaCkJI0nZRdR02TUIOY=
X-Proofpoint-GUID: Bp2_66pHwrE0oN2o0vBIxPUcvAWY2_jp
X-Proofpoint-ORIG-GUID: Bp2_66pHwrE0oN2o0vBIxPUcvAWY2_jp
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a84fd13 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1AjSj14cB3F92Kw2XrgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190003
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

On 18/8/26 19:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system/user emulations.  It's
> not needed anymore.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/hw/arm/aspeed.h           | 7 -------
>   hw/arm/aspeed_ast2600_anacapa.c   | 2 +-
>   hw/arm/aspeed_ast2600_bletchley.c | 2 +-
>   hw/arm/aspeed_ast2600_catalina.c  | 2 +-
>   hw/arm/aspeed_ast2600_fby35.c     | 2 +-
>   hw/arm/aspeed_ast2600_fuji.c      | 2 +-
>   hw/arm/aspeed_ast2600_gb200nvl.c  | 2 +-
>   7 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index a00238ed74..7a012d87de 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -25,13 +25,6 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
>   #define ASPEED_MAC2_ON   (1 << 2)
>   #define ASPEED_MAC3_ON   (1 << 3)
>   
> -/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> -#if HOST_LONG_BITS == 32
> -#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)

Indeed now dead code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> -#else
> -#define ASPEED_RAM_SIZE(sz) (sz)
> -#endif

