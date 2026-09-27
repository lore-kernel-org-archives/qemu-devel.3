Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C9DC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqhK-0000Vw-TL; Sun, 27 Sep 2026 11:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqhJ-0000Vn-CL
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:21:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqhI-0000EX-1A
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:21:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QMnFVR945518
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xqtxkwVNOeNgBmhUNDKNWAA6p1hMTwv9TPv8/Pty3oY=; b=EJWYxHSJpyMMIXcg
 TYYkjPhEF3o+urrs2JuCKdZXk3jrFI/VTVxvRLpQl62WIkyk4dYo1ZXjvL1lAVl2
 ZB90DQOvCmuoDYc/Us7E8ueTSf3wGdGDLE7OZV53dD+PmjGLjRHOJH3RGuM7Yn3C
 E5FzJ5dyX0H8bWresiXu1v0bErdWmLtqvTo3jmH5SYOyI+gG3omlc+L4zmohwVmr
 e820SaRLjQlgZBeMZCz2n7HNFd37rjFNSQtBECtbgvVpAzgPcffxxdcPyUYk6syF
 qhJ+41jXBUSfq62zjbl6u+UP94KK8MJl5dLLqdp+/7Ygu2Yyjb3twLwPfBTzlnHd
 tOwePA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp3g6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:21:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso439755285a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522506; x=1791127306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xqtxkwVNOeNgBmhUNDKNWAA6p1hMTwv9TPv8/Pty3oY=;
 b=fpPK/ZyOx3fFIhb1GstxD5moR4cImZAJO+Hx0agD1Fe5/LDpfPTKLYHnYa7wthrQzY
 90oKXe3CTlBswu0DDnvyJzShUP4cfIADhi4Inbo80ry+N3SvpYzzKXK0UzIrjCqZ0TLf
 vQ66Pw4iv8UtFSr5Tuv9yWPE221rLotNVUiaZLMvNx50r4qyJ4xLZvfk8WUPrV46/e/J
 mRLlqi47aqwsBBmsiuzDCZReYXIPq65p48Pid75Ki5Mf3LHFaIMSBnL29heT/My0kOfJ
 KVX+5ki7N+AQdbUgRHPduyaaDSZLKnP8Yw9Kule+CO8qJQqSsa2/+6lcXTJVq+bEL4g2
 u6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522506; x=1791127306;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xqtxkwVNOeNgBmhUNDKNWAA6p1hMTwv9TPv8/Pty3oY=;
 b=G9Hoei3DuwA44ALJ+y3UnHMdQGD4dyqTthGftlRfHxZ3AurgqYJbd2ZEx2B/Of3lF+
 FkAvI0Qrv0jfeYF2Oa/rpfqrU3McVZ7AvMfeiiu9VKiycUBGQ9xo3m71w+POh2G090IW
 HVL30grXjqTly7b2tT09bdIHQIvXD1LwScNhY8ldNl8lsKTrawpX01gs+38LePMZmowu
 YSezJcLcjVeIfAKGyCQ9X2iWB9RlmjvTWe0FRrbVvXFh0FD3+jFJRmZl4+VGS/pzWzLr
 tPM26zyPfkyv+KODi/z6zLTyEuqHGG22ngS0MeYxlvz1+ct86hEdvKSA4fUwICnJDc+t
 P+og==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9eI3bWzQcT5wY2VvqTIp5Kl/SbBQsKyRCDx7NTgHaAinR5KflHD4ZkOL0P6UAlQiQ3p9ZDkPtj4jY@nongnu.org
X-Gm-Message-State: AFuF++kvpybEmn6+VFbeog75V8lTvrJfUd8AwoDT3At6Bv8UcxpFCri5
 9cmH/QMXirEwRb9nBYJigY719k1Gf9ugu3anliF1+3RPZr6c6CkMRI/cwzJUP6/ujkBbvN9CpEG
 smA2ztosE2xCn0J7iiep119FmNBrlFc+PaQVMTEPHNb+rXwIWFdxuKpTBfQ==
X-Gm-Gg: AYBFou3N75EsIukXAOzG3Sfcxavb4eKDmQLW2VkS4HALKyWN9yVQ16vUY4BR2bsK2vb
 mtb/3xsKa55IpUi139ISkTCiYmd8558wKE0hlomM368dv5Jr4reUo3c3khAeB5tzt9Kt2PbjNnX
 dTxjeGTD3bwKzYrXKvKDOHJ8Y0OF/ip4pYzF3joWMnlZfKSdHud8JPQFrLELwv12c1K2LXavQjE
 XOXdnQBYAxnJmW8uPc4C7f0YtEr/3L8m3frvtl0Uq6MOMEa2gU4xcqhyg85oiqlrZms0ie7qZLD
 CIOnAPdp8MwDWOWS85We3Mk+I7SoF03w//XZNKQo/PFPTQmWYbTU3DGBBfQWRY8012FFb6DuXuH
 qluEh4JzAvbh6bB5ooRKz2ocNv3LVZoI/Qw==
X-Received: by 2002:a05:620a:6485:b0:93c:6976:e3a2 with SMTP id
 af79cd13be357-93c6976e5acmr539216185a.26.1790522506209; 
 Sun, 27 Sep 2026 08:21:46 -0700 (PDT)
X-Received: by 2002:a05:620a:6485:b0:93c:6976:e3a2 with SMTP id
 af79cd13be357-93c6976e5acmr539211785a.26.1790522505742; 
 Sun, 27 Sep 2026 08:21:45 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a314sm21892412f8f.6.2026.09.27.08.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:21:45 -0700 (PDT)
Message-ID: <27e77103-911e-454b-8fa4-8720b7d88e3f@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 013/101] tcg: Generic expansion of tcg_gen_addi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX6ly9zsg709Fr
 q/3vePY5hcfh5RnyklBf/cg8FGZKEVYxYHq94NOi1f78zFnLv7NU7R5NS2F/aLQ/3c6s3fLmDGm
 xqZcCU0BPvpqhWM0gDtHMnIRq++gDGFmkNUtB9AnIFZe0DiTuFVF+ZWYrkNWhR+hpeB6+rA/5ZF
 VNQtee70jMFnRuoOMSu/Lo3yU3v0vU/o76wtsiIIrZfDY8wum+gJl/5RhcnlA1ouUOKMOJlfa1L
 N2bp+fr2rYsThDy8d/orGiqZC2fCqrksIuOMMiUpmD77AeYGrJF2zt1AlfkVM/M0R4a3Oy/Hxs1
 QOl8RjqSHab1LnYvhmZ/osUd/yyO5PghFX3Z9DlokV/2M1azttje04+mcThSS4Y6xFhxYNQvPbU
 Km7vUFCGgC6r5kXsl02KzuGSxxOfSGZV42BFMKfZg1yybIilK13+yHOEe0QKutwQE89GnwGoOmI
 jV8h2vxMTxzNxOCo/wA==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab9348a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vo3qTjQSL8MJBGgZkTgMvv6oT1b-PyMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX4NZDaUTt4jgf
 zD6Dvne9GqQ5BAUjeN5D4Mg0bXOV9AwBG7qvVpSKCbrbCyGf+FyOATVBW63EbDIBL3/3lSvTF3j
 cr18AykisFLZUELOC7B2WQAtPRnlslU=
X-Proofpoint-ORIG-GUID: vo3qTjQSL8MJBGgZkTgMvv6oT1b-PyMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 29 +++++++++--------------------
>   3 files changed, 10 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

