Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6269C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFxg-0002W2-VM; Sat, 15 Aug 2026 11:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFxg-0002Vq-18
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 11:06:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFxe-00036U-7k
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 11:06:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMpk83616405
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 15:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 no7/fs0S8vO0Z/Z+v9lzcr8wf+1vxXUpB2mXE1VG4Ec=; b=DXpMsDQ9iL4P1ZFC
 75G4qPYeNJ/NFnkympNHqs99NbZP1olBaZ1f48QgBXtTyd528r3QvBRgPz0a0PT7
 1JouMAoq7xTgAtxfLg42i3S+KaB01yz/z/fcgX1hplVW8e4+geOibf2bLGfpfYNA
 AzwOOIkOPvaaWI+2gB/PDxVzhLbu1taLorXNUl3xl3y5t1yKuuoh2YX8+azmeiLi
 3X6UGcaJPucbAEfq6IX+MRdzGtbkSbHHb1nG+iGLgEq8ynbE2YW3+Z/8vp0b0sGH
 R4f/6soLbay8SpmjjTlX1vccK8+yn9UeJ6FiF73DiJ72mqmEHKLWIugcHVPMU2sa
 tZFf1w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq18fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 15:06:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso39894571cf.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786806371; x=1787411171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=no7/fs0S8vO0Z/Z+v9lzcr8wf+1vxXUpB2mXE1VG4Ec=;
 b=RkcjeulRz5u8yR4s7eAyLfcu8DtD0JplaZhsN6UpZLXZC7koJ8lBXwkFA028NBot85
 5Jxq8Qph3gFAdBT9X4nS82yVkfSkyqkJWyRi4H7jMye1DfX7hmRhaZNSQLIs7lD5xPRp
 TsRQM5lpFdSRpQChdvglNWQY/oHXZTSStOCKJMfLjMK46ZdIx59x/eHM4I7Ch6TP0UE6
 2EcvGRe5ARuMj/ShyY3h0hPgfuI2yT6Z4Qydk8vqF188eg4Zv3SF4P4zNqXo4XcjtKjC
 V9mEp7cRJowXtQ3G/Onf0IPRVSbAbADDH3n07F4zgDlwfpOCGpn2aM54iYhRy7H1LU2s
 zHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786806371; x=1787411171;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=no7/fs0S8vO0Z/Z+v9lzcr8wf+1vxXUpB2mXE1VG4Ec=;
 b=cT9UuxAUgKuCeucXVchd28/8j3LHz643ilxHxRDuQxvXDkZTthy2wFPGZ1+mX+wUpX
 ZUbrn0zPng6QNmiPtj94x7zCr2BMx9DqCbgZBXYrPGNGKIl3iV8M0CW6wkEEAC6vPJvO
 9PifGmInXey7BHOTMOaZIkpFjr8yt8CaCBBsQ4PqTTBRWml7s2ArhYn6DapjtJWhUo+c
 GWB+T4rnQi9qaZJ2onlIb/x0RwkzvJLz2C5avppQPt+1APnzgShjPc/txIAFtmQaaQ9h
 HYjStPPvjmjnUh0sWzvjM9EWmX5CJ9oNZ6PbiXBm9ZcNV0UjRAVTucUuBiCCy7pTD+Nb
 Sv1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+vpe7Aku83yz9DlBZzugTkVZZQmzFykVFSbeyP2x7CvvxGZ5FjUD2dqsJIWixEzrk6mm9NgfV9vAD@nongnu.org
X-Gm-Message-State: AOJu0YxrjJpgLjQKNsHxaFXZR5YSpVb05go/6gRbG/BbICf6vgCGWfE1
 2j/dOn6QdTteEVWXihsqei8ANJwJcl5ysHstVTai2yqpEWlP9aoRBilaReWSneALbGhRCCMHR1M
 8gexJRC7cu7lm1tqcy941y5zaBbw8o1vyZOpNRzmqLO8no86wNE6i9bXsTw==
X-Gm-Gg: AR+sD11q6KhM5HuI5qylzW1c1q6HxFuqYa3URoAhZi/WjV5GmQ27K/ss26gqgWsfD5i
 g1/6Janfk2pxo68l19zCLfZOeaHlAyDTZlbChowyItG6gLwMi9Puwvu56RdM9VrmWlCcEyUwoVf
 XDY6sa7qmQDmvET4fQzNOXEIb7MW+Efw86KkmccK9gu4k2HzNTZHWbOO+8RAjne1CQGBQR2XNYo
 E1dSMQn62QMKrg0WvKeXSgjTaJKgJhFsFTkHwcbsO9rtTek5iTOQckzte08LPnKOhGgIf7+GdlB
 LwHaCEJp+H9eB0YyaYxyTKluLKS2CtAqRaVC5EleqedJOUX3q8JWcrpaKBwIrov2Vgkbylp3H9Q
 7UjsyoMj2Z4Q/F7huE8BMtGYH5i2DVy8PPAA=
X-Received: by 2002:a05:622a:40f:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d8534dafbmr150585621cf.17.1786806371492; 
 Sat, 15 Aug 2026 08:06:11 -0700 (PDT)
X-Received: by 2002:a05:622a:40f:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d8534dafbmr150585031cf.17.1786806371102; 
 Sat, 15 Aug 2026 08:06:11 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998b1593a2sm80620225e9.13.2026.08.15.08.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 08:06:10 -0700 (PDT)
Message-ID: <828329c0-37db-4214-a6b6-904299bf21f7@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 17:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] hw/sd: sdhci: Run ADMA independently of MMIO
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-13-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723151853.2143177-13-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwOSBTYWx0ZWRfX+EiMyPk1buii
 K6Nz4s0Ju7yc5GjbKix8cSDW6vWwCc9ZXxr3oJGBEJSuFfU6T2PtPZTTohQof1dVk53KdH/xFXb
 2k3CzBooH/HcnHGxu4wLGfqGxXDRd8DdwkMDEp8vwxWdEqU9eNj2kvyJzfbIZOyQDLl76v/DHUa
 KCRUZvqAJo4G8jT3CzqFDK+5A2Kp8HBtbq8hzTNRdjoTI9V8aIniL9utrr/4WkkJMjw8MgSIATd
 75NdEo8eG5xYZSrcz7uGT6chZC8aWHFb0CiJ2qp3ayAr2xie6QiP/vaoNLiOm8gn5Akh54h0HcT
 hfrtsMeET8RsAxNulzNhTHIWjhu+XjFsIno8aR6JScsxtkJHiwG4FYTWYY9FcNCzPUZDQD8dmvh
 +4h7dL8vn0ilp3WC6b1KF5gcxD6JlAxOSCxdxjwlPMj+hRyBk2pNwilYxpTuA9Vf/nymZKI6Sgb
 sfFdENN+0cpQz+6Yu1Q==
X-Proofpoint-ORIG-GUID: CfPmoc9OsoCiCsh0tYEZ17KplBPWIklU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwOSBTYWx0ZWRfX16vdQrkZPAKr
 olRG4l+nUTLuDUhseEKFEIhsNAyR5WnDqs4IZakAMcz9nrYMiDdIBT3HHxO4pmP+ghqDHu6Vt5O
 hJ7KBbOGXpIXErhBOcO0Nv/wXt4WwdI=
X-Proofpoint-GUID: CfPmoc9OsoCiCsh0tYEZ17KplBPWIklU
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a808064 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=l_AkSWkuJA_cJr-88wEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150109
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

On 23/7/26 17:18, Bin Meng wrote:
> The SDHCI model processes the first ADMA descriptor batch inside the
> command MMIO write, then resumes pending batches before every later
> SDHCI MMIO read or write. This makes register access perform bulk DMA
> work and can delay a status read even when completion bits are set.
> 
> On the Icicle Kit, U-Boot uses ADMA2-64 and CMD18 to load a roughly
> 19 MiB FIT image from SD. It can report:
> 
>    Timeout for status update: 00000001 00000001
>    Timeout for status update: 00000003 00000001
> 
> The status already contains the requested Command Complete bit, and may
> also contain Transfer Complete. However, reading the interrupt status
> first executes a pending ADMA batch. The MMIO read can therefore return
> after U-Boot has reached its one-second polling deadline.
> 
> Turn the existing transfer timer into an ADMA-only engine. Starting an
> ADMA command arms the engine directly, and each timer callback runs one
> bounded batch before yielding. MMIO reads and writes no longer perform
> or schedule ADMA work. Keep PIO and SDMA synchronous.
> 
> Cancel the engine and clear ADMA activity and error state on DATA or ALL
> reset.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci.c | 140 +++++++++++++++++++++++++++++++-------------------
>   1 file changed, 86 insertions(+), 54 deletions(-)


> -static void sdhci_do_adma(SDHCIState *s)
> +static void sdhci_adma_run_batch(SDHCIState *s)
>   {
>       unsigned int begin, length;
>       const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
> @@ -956,12 +990,15 @@ static void sdhci_do_adma(SDHCIState *s)
>               }
>               if (res != MEMTX_OK) {
>                   s->data_count = 0;
> +                s->admaerr &= ~SDHC_ADMAERR_STATE_MASK;
> +                s->admaerr |= SDHC_ADMAERR_STATE_ST_TFR;
>                   if (s->errintstsen & SDHC_EISEN_ADMAERR) {
>                       trace_sdhci_error("Set ADMA error flag");
>                       s->errintsts |= SDHC_EIS_ADMAERR;
>                       s->norintsts |= SDHC_NIS_ERR;
>                   }
>                   sdhci_update_irq(s);
> +                return;
>               } else {
>                   s->admasysaddr += dscr.incr;
>               }

This now reads better as "if block to handle error and return":

-- >8 --
@@ -999,9 +999,8 @@ static void sdhci_adma_run_batch(SDHCIState *s)
                  }
                  sdhci_update_irq(s);
                  return;
-            } else {
-                s->admasysaddr += dscr.incr;
              }
+            s->admasysaddr += dscr.incr;
              break;
---

