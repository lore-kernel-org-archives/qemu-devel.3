Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4942AC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUZd-00084P-5f; Tue, 18 Aug 2026 20:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUZa-00083B-Ui
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:54:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUZZ-00043N-FC
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:54:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkXmX3326041
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c7kS5ETvM/LD1aT2hURF32ZpzsmRUjDX2sliIpYsoDY=; b=ZD1Q790IO+UWIwF2
 2LP35vq9uCyzgxctfFAOUkaKICHCH/qj2P3X9zLqNQ31ZhD4N+GGyUU8pjh9UH0T
 HHUXw6Kh1uhglR6FWEuLPErU27BAVNKeM+inRcmqYVTIk19K+3kDNT6TFCDmjBaT
 vI9UvlXFnGNlHF7Jl2MAFkgsHQTTdREsnIA2mKj9dd7uKIJh628vF1iewtKLQlCM
 9eNBtZlmcEi6q2Ed8BoGIl1al9/KlANTCkUhED9azzjK7o3GLaBuvd3ih+XauO65
 XBO0Z5kubuV8Y7JjLtD/LXgJdA64dB92BACO/d4EfIqem97MIULoQQ/HjA4JxJ30
 Gt4MJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfprkgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:54:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so55115485a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787100866; x=1787705666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c7kS5ETvM/LD1aT2hURF32ZpzsmRUjDX2sliIpYsoDY=;
 b=KoJBzB/ctjC0bION2/oXEtPK1xeXWQdtCstZWoYFXFSloVD2V3PVg0gZ3dZBBukrV9
 oBrdeMrUyKPX5TSePYEGQtW04aDVv4QN40gMJ5MGpewDQAtxKRZlrc+Z4XLl7wHGRc0O
 cTnzu5WBRVSAzKnxCb4ijFy2MkjWXUfr8I8/0o+IE3C9Myn9L6O1erJI6N+2hFRWYJGC
 HEKnf8p3PPRsI1UVSjPNkbku/VBLhK0FVM3emiEjUdE3im6acHGM6Awt5ozoyBO+Ob70
 gJe3GfmwjLdnCv/FpndrhP+RAEiDl5be9TZc34UrrD2BvDsju+wairDzMprBWgh0OJXL
 7Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787100866; x=1787705666;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c7kS5ETvM/LD1aT2hURF32ZpzsmRUjDX2sliIpYsoDY=;
 b=IFrwNuCe60OtBDqFZMXvEP4fMiw17OZRExGPhsB3vAL9uRerbNvnO1lcIBtMcXWVTE
 jNVQZmm9z9nxVu20MXJ+bo/TW/Z1o8kyhRhQHEMgViYS5H8AbN2vkb0EvFqtIvW6u2hy
 YzXnLdZ8RXB7cUYk6gUQ4DUuPXIC5diDfgtTnpzYClKKgmxfs1ygDofT3nd+UlYXSczv
 U4iXvRQhXRBDTRgctVeljxz6DPFfRAyaWDRJu+YKIlZ/Q7oN97YYYsfKsBA1gMSya0kM
 ilOV/xh2p0bDlQFi2KmoUFL4BNQOf71tVKWHHKpn9jhJf4T6OCBFQ9X0HdeNnQmPB41G
 Cwzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox67Xa8IT+zcTkaMCQDtcQ/bMS/hc7UkIME+2TfggFWlYbubzLmVYi0QolD9AyYOIMp2IlFt/5UAX9@nongnu.org
X-Gm-Message-State: AOJu0YwH+aLB4AHc1LRnerupsFMYW+Q/vxV2LoHsdCdAH306a8iMevGp
 P/Zb9W6cw1RVDL29XUu60cY1TtmuVtrANQTsnkv0WlcwIMMqypIfpubLGYThJoZFEVP5owJE4yt
 rIWWTlyP3z2SqOS5Hyr7c5OvugyMshfz//InXRcNxWXoi1mebMCdIDf6/6Q==
X-Gm-Gg: AR+sD102CAPj57R+RPcMFmcFl87fF3hyTkzT4M1PjEymrCOjMwpRQ23yd5LeEJk+COf
 cMF/em4OzQ3+aCUwkdXE3jOIsSpyeWMBjqNECeBdPNfJv6mMaTuZi6ujzaOjqhTii55wJc9Ivdx
 qfIARjWUyPsDlwz1L6Li3xIMxI//i/zpO63vNyml7vpYs/8K2YzUREaixv+9iCYBumrhgTelwdn
 qXK/3ZlZbEaToDunyZ8QTkFN+N0O4s6Kf/mgkkOp7KgUx2bVcwcwXzQ1SUfVi133MTFJ1NzaJli
 JTXtdXPblrkoo5qQovr8jZOmdAL5zLkmHpuzz0QFdYd+vlRRqoIJZRp1EDJvvRYu3RO+Qzmeg8n
 wRGtAve5X98fYhz9j76D8siD+oBDDatvslEI=
X-Received: by 2002:a05:620a:19a2:b0:936:b923:4832 with SMTP id
 af79cd13be357-9371e301496mr133378585a.28.1787100866043; 
 Tue, 18 Aug 2026 17:54:26 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:936:b923:4832 with SMTP id
 af79cd13be357-9371e301496mr133376485a.28.1787100865627; 
 Tue, 18 Aug 2026 17:54:25 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17f202sm13387865e9.13.2026.08.18.17.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:54:25 -0700 (PDT)
Message-ID: <c5e8b837-5921-41a5-8314-d61a629c7057@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] hw/arm/raspi4b: Drop board_rev for 32bit hosts
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-9-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818172012.3052821-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ap2EtbUFFSqDv-_ZLEqi_ruLmdyzmqLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX3oXgLP99qjsT
 LlXvJisimhUWp7KewznsMFLXOpdKSA1mUm5HzxwSdlhdQKmdXk84Nh/IMP4fhEO3RdX4atUvnn+
 tQIprE0/naf5ynl1/mLnvHfQZD5CoIDUsQYwVLeaNKhUxpNit+y9SqqAbjqU0AAYHM7laAvaeXQ
 P1mxb8Ti8Ysig3WyJ4xFaocx5K0vR2EKfEuocyCermKNoazHhKkM9P4Y2trK2mB4g2Vzgqnz2+R
 S1hNcFVz/eoqk41bDZ0xjqh5yCVacohvjIPSh3ULOnSVShLF0L/a6RPrGjXGUOS7HX2iQaxazHL
 vuAbac9yopVqcQCtM7Fds6Bqlx1AOZwabAryb6tmxCPJnXabh2J6YMpXoVeEZNJ07qZytuJNHQQ
 ycXmYgNuNLytzPah8lF8Wnx/15iiEKF5SfqUzk5mxAa89H0/n0xLyPR7gQh7xKKS2dGjG31wxSS
 jrSBlDJvZojBcXQ9gdw==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a84fec3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Ap2EtbUFFSqDv-_ZLEqi_ruLmdyzmqLO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX9rBotieeiaub
 gNXaJDMIFbqLW5mC2RWf2Z2veIFqS3V/DzG9jK8xAYVrUyCeqkD6lIDWRCcgJNPFRwv9rxUuP1e
 yL/3YbVXFpP7S8nfxQ+fGZrOulfnEM4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
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
> QEMU has switched to 64bit-only hosts for all system/user emulations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/arm/raspi4b.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index e1595a875f..5f7abbb4c4 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -111,11 +111,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
>       MachineClass *mc = MACHINE_CLASS(oc);
>       RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
>   
> -#if HOST_LONG_BITS == 32
> -    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
> -#else
>       rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
> -#endif
>       raspi_machine_class_common_init(mc, rmc->board_rev);
Here I'd rather keep the machine. IIRC someone already suggested
to adapt the board_rev with the CLI provided memory size.
An improvement for tomorrow, meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


