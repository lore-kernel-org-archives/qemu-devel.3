Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43315CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgV3-00016N-0m; Thu, 28 May 2026 15:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgV0-00015q-OE
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:34:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgUy-00043C-MJ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:34:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHENxQ1469564
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ytCBxV/n78Ld1PHl7J1fny/SI4XVuwn/ERnJZNs4QX0=; b=ZDfJp0kmKORggtzX
 Tm9KnlEXQEeGHiPiEJHZkx8DyC7D6F2w+HeKcZCM1eGBlaTtCUZXy3Hteu5tR6Ev
 px+D/wt6Y1l6K6NIgSGLpPBVO5b+JWY9QOocc1oOZyruf1IH6glEs/cpgf2xuDBS
 fe1aCinDg2JLlHmFjnBtiT8Bmc5eLFrwOWYAmkKFU427olsZD5OlOm1VlSAbJ2Ig
 UfNYced4C6KZcrZg4u81KpFbFvIkllMDX2VGP4X+8NQYealRLmC2djm7ECBbIGdZ
 OKlWThe/F92Aw+g/Iu9Ied3mrkmSYLfFupkaipXEDuIP9WNQozbGlSxHY6EHEmG/
 IKDXPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eesxa8mmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:34:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304448ab58cso10440255eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996870; x=1780601670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytCBxV/n78Ld1PHl7J1fny/SI4XVuwn/ERnJZNs4QX0=;
 b=Cw7wC5whNS/0+PdBcLBgM4cpgmHyAXnpZhdLy2NoKEtpOV7MY3oz8ePI72HkTboM0f
 yu89I4t4oBOpyzerrxVRJxCSDryr6CYrj69/qJX4DrUuRLrxTJyGd+aNdnWmMFKCR3Nq
 X7K7+YHOD34tSydveJUx80k5Te9877Gfbh9OZbWMLTMjv3oNJ7NGbMReclyTJ9WmeWzn
 Mr7xA3XOqT6MQhM+UnhCnIL810JXu/wTM5Q3lKvXxyblisRqCwvPRhaQKFKTbgQzKehq
 vNCVoz84Fd795ZWt2obMASGBdIx8MDYlc+DkuwA6welgaF4++PgAjYTGhTB26LEKrTLH
 szfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996870; x=1780601670;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytCBxV/n78Ld1PHl7J1fny/SI4XVuwn/ERnJZNs4QX0=;
 b=JjfAPC4KarC5dLNK+12wvBRT/c4wuhqs5LSuqMTlG2nv17My8actYyMpcHFNnLzKDl
 merzo0tbrxt2JcCdcq73newKt9xTtd0RE4TPvv7amWJHKaNpMzYolVlcbKw0qmCY7lz0
 HonEyOBFzQPeB1t7+S3urTwlOysfuYpw2pSerMpSwmkIrBBNcYEyxGvfloyyH0h2Lafc
 8NCOVWB+xEChdbkdKBtJ1qhDaac9oENp8RdNftG18it4cRholejRBGBan8S3x6Kav4HD
 Mswp4gD8PNDQiL3Ze7JtBLYSd6QizOk/Huzyyg/kN5/CRJ8dXQrU4UxUlKWjG8bTOw1Z
 mzMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FBTESnaoblALyVWgSMKS6sBoBx4/bgoDUFnbfprPLQB+56tCFbTb+k7k3U0bEcofsrs0AI+/R8wVk@nongnu.org
X-Gm-Message-State: AOJu0Yz1+DXx1Qxd7DlyQpfFM9DdM7Xc0/VwML01g7afJ9XOFfd/OZm6
 eNWFdjlBnDY7OfIJI19JHWrRhbpS3veJ7v9X8h7D0dIy7U4sSAS+As2jNWoB8j1IUg+oAvaqadr
 4rXdH+m93CG8oDHxkAfK54zWWCkPRFHWhOwNm3Cp3XCbMfA25HOfX6zLyOw==
X-Gm-Gg: Acq92OF/e+9WYM9O1QV5+3+Kva39o2ugLaZ91Ro8IphEbD6WsDMpFTSPnpwNUydqvFq
 SYMtfIGQZXhKCSIRqMuTxQTK6KUGsW4AzSloHUeKFqC4UxQlDIge0L/9ysD5270oitVXCf57GIy
 7KC5kFv9p8v4qxWGzVq3cZ37jC5rlC0lwLpDhjX++bJP8tK3wtvyEjLY6sWPtG3Dk49+RZh4bj+
 EEb2rdPS0R29OikbKTgbBSnvMIC222fpTY25CX6shan47um7+jXfRSyz3nxMJq5pEfx7ZzMNQoh
 0THMyKlqc2WVytJtzhejv4DP7rlEhm+H9XpYXZ9leGtfe4KmMEMVgWja9RYME20tqf7mrdNFP/O
 5d1QZNK/uipH5hZe1zuG2zuWw8lZJkBysgOVhQX2oAJXxVZ8sTJTBljNukPjrouilLkxeeZOMvP
 hagipoZObsxLvJf12oAAytJ6Ka
X-Received: by 2002:a05:7300:fd09:b0:2dd:5641:ef2 with SMTP id
 5a478bee46e88-304e8c66510mr237188eec.25.1779996869752; 
 Thu, 28 May 2026 12:34:29 -0700 (PDT)
X-Received: by 2002:a05:7300:fd09:b0:2dd:5641:ef2 with SMTP id
 5a478bee46e88-304e8c66510mr237158eec.25.1779996869221; 
 Thu, 28 May 2026 12:34:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e98c7969sm124237eec.14.2026.05.28.12.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:34:28 -0700 (PDT)
Message-ID: <7fa279b1-d030-4d1b-8615-77dd838eb92b@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:34:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/12] target/riscv: Expose and document the CPU
 'big-endian' property
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
 <20260527201348.29511-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iJjEN9gzj3k1ZSvJvjW1MPppQji_xqF0
X-Proofpoint-ORIG-GUID: iJjEN9gzj3k1ZSvJvjW1MPppQji_xqF0
X-Authority-Analysis: v=2.4 cv=ZdIt8MVA c=1 sm=1 tr=0 ts=6a1898c6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ALku5c8DAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=iDbYgPken6ucnqvU8AIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=Skunnq644UPbuD6fT1yj:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NyBTYWx0ZWRfX00PdWehdPzU0
 CP/i3bb40bZ6SB7E6aLbrHmNqmWeP5vGNX1Xiqk82GUmDQ69FCgRIW9CAVLiLF+UOkymoYhOCY/
 uGRaZU8Dejy9g7+Ec8cj+TTMivl4x3ms8VQdzLGLqcz/DfePqvQtPvu758Zm/aG6mdEkB/y5CLZ
 8hr9DCEHaAE40XXR9JivKxqDzmTuiFgrg/uM0C7yV99P/u1j2izOwnd63l4tmWs1vOGBOn408Az
 F7TQZwETWZyTbIZUhYM9ohb3b9QwfNO9eEwQx1ekBqDAFPOOtgi16/W5gN1wVRY/JuNEeSQ1pLW
 OczwCRtagtJfqsdC0y+JhigCF/Uz31mgpJSBm/yfOhN8miv39pfyqGFk1C8wz8WV07m/s3bDxZO
 UuiIzn9JKY16FEvTcs03GovyD4f7f0baEnp6lfVFPH18sTLqzlZdJEOK7DHuVocw5WkDtcvZSNT
 BPwpZWZJyf6lH9Tlt3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280197
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
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> Now that the full big-endian data path is in place (runtime MSTATUS
> bits, boot code, and page-table walks), expose the "big-endian"
> property to users via DEFINE_PROP_BOOL and document it in
> docs/system/target-riscv.rst.
> 
> Document that the property models fixed-endian hardware: it selects
> harts whose MBE/SBE/UBE fields are fixed to 1, and it does not model
> a mixed-endian implementation where software can toggle those bits at
> runtime.
> 
> The property can be enabled from the command line, e.g.:
> 
>     -cpu <cpu>,big-endian=on
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/system/target-riscv.rst | 29 +++++++++++++++++++++++++++++
>  target/riscv/cpu.c           |  1 +
>  2 files changed, 30 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

