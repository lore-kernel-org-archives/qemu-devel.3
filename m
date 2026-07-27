Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED5BC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJv7-00065V-1Q; Mon, 27 Jul 2026 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woJv5-00064v-7y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:54:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woJv3-00048y-Aq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:54:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAM4O93647763
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MjpLSH/2+fydhNy2psqhlGT5vqzfdqQcuqsCt78TKJc=; b=lKJhR/x0wP/rKxAV
 Not+KgAF9VQ31w9ZQAVLPUUJiW/KvbZsJR3UeWJk2Fvsd2Py2WTclwEHqB9hSudA
 ZZzpBTSEiK8ErtFqR/Vp9GSAW77S2UcK7dTQmbGkxq/zmbyH558mAQeXwwjqlXr5
 1dyM+njVScvNOPWN4RyJ0DDt3Hi5OMygHG9mMFY7CnMdg9s3MU3qNcm1hitswg7i
 LX7yZtiAPWinLjzEpxNaKtuYLfQDz5Db8QIKImDbWf6UfNVqqqm+iLOul43bOQ95
 ge+x2VTsVDHXlnH8VT+/ic7znSYSO+RcbJAbFzOAI+1rp5+vi5sfC0wSsv0SIrKT
 mLgFWw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrrj0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:54:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso51308301cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785153291; x=1785758091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MjpLSH/2+fydhNy2psqhlGT5vqzfdqQcuqsCt78TKJc=;
 b=FYqshLI7/rryWcfAHHBUczIOGGRr/pCDeJ1TufOt3YnEylPwj20Wqca5MvDagbfm3v
 HY4uSG8CkY237pYEdF2aRZRXgJvswvdhdw44EjwQlFwRu3TtxI6QCcVBQJKQqe/EgsIg
 HN/QbrrUdgLGfbKRAm+a+UL4M4ISMUlRvbQzLluQKkr/7LDkF9MWPp6m3HX2QvHoP9m7
 XdAW9wXl5zlUXh4XuGvVaLBPcBbLZFn6uq1spX2visIdKauWli78m8Nujs748l4/DM1y
 Sq6OVz/huahh5+xdyL2ywYIhhpBK6QuzA4Y2Xr6N3ScZl+5tRGoHT5pKGdM8QEFZ2DrT
 aH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785153291; x=1785758091;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MjpLSH/2+fydhNy2psqhlGT5vqzfdqQcuqsCt78TKJc=;
 b=WtekDqDl71uXXH7H4ymy0RHYmGCrrO+fbl321ocn4zIMskWHZRp/bH3HgexaMoYvnR
 Jx2eYBUtqEo0GWnWGdtADmZvDp24krBXKOurO6B6MAUJYl90PNVEAcGZXjqydvyfoaJ2
 PmZZGzgbERYby0MnQbZQz/3hhDr4n+73jyZR9UNa62tVS0cti8AcamEBHax5egpER4MV
 Zf5/Aj6csbmLmPK5lK+klXsm8S/pPyp+lHGBV4xczJ1K6UGufeFsvw33fmsFgHSDePoR
 NTo51wYjsw8+NK3OE6cSBbC6hUPyk4w6AeunU2CuT6pTEfktD8vMmBeUbI3f39sZP5JR
 TLAA==
X-Gm-Message-State: AOJu0YwxjweEuchF+7mAbhosgJi0aUzGp4NknRbyTkqyrUOPpH7GgJ/l
 BrCNpK9oiEV9XdRzyrsDE7bM5o7a2hCJgYU7O+6PHFxR0cENxRy2lDbGzvdn+R8E9hrtIs7jnao
 8f5Wj+2uKc6gN7apWKUKGmbUdK46OGZ1tEhqJCYvrFQ01eBadkMfW7Ep1pw==
X-Gm-Gg: AR+sD11zPypB5bp4BK1iHVhPAyPdj0hy4OXvNfrEQS14cQlUpDJTjETqCvj+o+b3wxs
 Q64H5Kanef+1IWwHwhdDsKKAVTJpy9h7w54p767Z+QC2P3xalLJd1IMUKMiZ/y0EPG930s5RbyV
 DdLqydHlUBFAsPkOFWcFJqF4jPrA14aywAE4VIc6rV8eSQQewrfSfdtoedbTwi93Hl52/ARGIU5
 O1EX0VkNM3u65WdOkEoO+JEF8k6HIT3PwLjMYkyK5oy6YOvOTB4zLjNiSGfaqVY1oPAGuq1x6P3
 LaO1C4xWirU075dp7tay65rTr4wSOyb6xoYGpYLxcq6HrFaK4ZAyr3imHbXbzBDG5MKZFEEcvqF
 n83j0xIxz2YL/2rGPBWeVonHdO9B/AjQArazODEhuX1j5Ag5GIOg=
X-Received: by 2002:a05:622a:3d0:b0:517:7188:c47a with SMTP id
 d75a77b69052e-529a8381bafmr80802461cf.2.1785153291451; 
 Mon, 27 Jul 2026 04:54:51 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:517:7188:c47a with SMTP id
 d75a77b69052e-529a8381bafmr80802201cf.2.1785153291051; 
 Mon, 27 Jul 2026 04:54:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb51c9eb1sm2547975a12.10.2026.07.27.04.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 04:54:50 -0700 (PDT)
Message-ID: <a9ad33dc-b487-4ce7-9b8e-d437b6cc5d12@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 13:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 botszhuang <huang.botsz@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, qemu-arm@nongnu.org,
 sef1548@gmail.com, botszhuang
 <22925483+botszhuang@users.noreply.github.com>,
 botszhuang <botszhuang@gmail.com>
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
 <CAFEAcA-q5ihYpgYtEosQ3+SgbMdw7e7=xk4motLFL-A==g1k0w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-q5ihYpgYtEosQ3+SgbMdw7e7=xk4motLFL-A==g1k0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXwew/SBcvSg5g
 BJ2p7DwOzrQbwMuwz931Xq2ZjeZ02H5zT2/gcDAN9FdtC+1cIygNfZ14kMtjOvnIuk0XeyGsuer
 YEQtxjYkupHeEXQGzN6P/6nvIBo50l8=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a67470c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=t2M2atKBCKvtHhSlAyoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: rn6pt4pFDKEa4kG5979pHfJyjuXehdmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX1wCmqLv+VT23
 mh97rnpNEYhfgSKkJ7Th+AzGjTqIixjrM4WSSdsshWhPHBMVgUvEBhQpoK8x5gj4m8OneSdOHAj
 x0fMNcsbARpZkxBkiMeKLRnIKClJDnabNHFaPJX2pGMVThlARCCvEJrySSaH0OC+qgt2lOXc92h
 9DMrVjCsnvjn09vT60/kGqueUaRa7/4db/hAey4z4WDL0OdSklPoD8QASorvvoyo4pzumaszdi+
 9ydp3lEzY5pEsDjWpsfG1vwhg7ZonB6vLMp2XG3h+IyO0OSsZr5W66xXRqZXHjXJjRgtJH6txgC
 RZ9bc7ZaLtTunpsCzkaqnIa3zMtTpOqzk6VOXxQXntt0nA+YIlbJ45EelXR0vWKAUNomSf9G/gu
 U2plVMZfAzvNpVBsNPPJ4JT1wqLiZA/GtvAi2o4yhPku2hOu9juWeJMTvNeWd4rfVF+FPSPSdCX
 eVq/UI69eq/LrWPO/kA==
X-Proofpoint-ORIG-GUID: rn6pt4pFDKEa4kG5979pHfJyjuXehdmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116
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

On 27/7/26 12:04, Peter Maydell wrote:
> On Fri, 24 Jul 2026 at 13:51, botszhuang <huang.botsz@gmail.com> wrote:
>>
>> hw/i2c/bcm2835_i2c: Correct CLKT register offset
>>
>> The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C controller is actually located at offset 0x1c, not 0x20.
>>
>> The previous incorrect value caused the guest OS to read from and write to the wrong memory address when configuring the I2C timeout, which could lead to unexpected controller behavior.
>>
>> Update the BCM2835_I2C_CLKT macro to match the hardware specification.
> 
> Checking the datasheet, this is definitely the wrong value,
> so the fix is correct. I'm a bit confused by your commit message,
> though. The value here in QEMU can't cause the guest OS to write
> to the wrong memory address, because the guest OS doesn't ever
> see what we have defined here. It has the offset hardcoded into
> its own source code.
> 
> It looks to me like the effect of getting this wrong is that when
> the guest writes to CLKT (at its actual 0x1c offset) we will log
> a guest error and give read-as-zero behaviour. That's not correct,
> but I expect for most guest OSes it'll be pretty harmless because
> the guest probably doesn't write the value it wants to configure
> and then read it back to check. (QEMU ignores the value written
> anyway.)
> 
> I've applied this to target-arm.next.

Should we also reduce the region size?

-- >8 --
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index 34de1f36e5b..5f6093087dd 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev, 
Error **errp)
      s->bus = i2c_init_bus(dev, NULL);

      memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
-                          TYPE_BCM2835_I2C, 0x24);
+                          TYPE_BCM2835_I2C, 0x20);
      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
  }
---

