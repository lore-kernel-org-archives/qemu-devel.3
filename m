Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE0DCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRN3-0003PG-Mu; Wed, 24 Jun 2026 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRN2-0003P8-AV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:26:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRN0-0001iS-IH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:26:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfIqh3293831
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aktBDcjx22QZa2HbenOKUuvfvQBk5+fnNxUTHpZYdgE=; b=a1jB31zK8/ffhWy6
 q0IB3/t7hnOwGEaZ3C4GX1cpK/3oLEXlFoPi38kc1knqIL/321CC5vpyeZCTB30p
 hvcr3VBNVyDuP765t2tf7ln116zPgy+ceXLhfV5l7rR/DbtRToZ+b6WFlnuijcWu
 VX1tq+XylrxrSVHvewr5YhAjPIZOD3th5aigL4d5jw/N5sJco8ZfI53SrZx3vTEi
 naE18asxZAN9ezQQZoTMiQxpvDmmRyOtTOM8Q/lSYY+kr8OO9wZBby0WvzbN+B3y
 FjBi/5fFhdL9L3FbxvN+vh3XCePrHjfqoDcv6FL/oWM2TSBJ0zgWLX+7tMK1d0HC
 ebDEbw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00evcb61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:26:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c5794db0eeso1264088137.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782321994; x=1782926794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aktBDcjx22QZa2HbenOKUuvfvQBk5+fnNxUTHpZYdgE=;
 b=BE0QMDVPr5deACr67lSDpCbBga6eMEsmcNw+Y/QkUlcMEdjP9JjAlYAmK2Ld3V1ltH
 XPd5MSTarZcl6vodBNz7ye05OFv8iRDdxfeVEfQFw9clxlRjI87qxj4lsWRuXynrU7Bp
 7tMGzx6EV03rcEsuW7mYkOEHnQ5c9SB4Cr+P+IaC23VoUGAENbdkBT8ArBxJAHR1POcB
 55eG+RYCmMCNozULHFOu0jxvWVh4gec2/+zfrV+/r4j/y/ffCWYqBaZ7js12VXS24SxQ
 3+T2SGXD+2WVru8F+TvBwHzLJkRSQ9DmRSGNJrR0Pt14V7mDnMJYStnUUCV/Awov0vi/
 JzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321994; x=1782926794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aktBDcjx22QZa2HbenOKUuvfvQBk5+fnNxUTHpZYdgE=;
 b=k/pVkNQaK15i/gCFC8GRrYaHxhX5XkSA4bhEgGvIbG28pCh5wz9sbT5+K2IYwE2UdM
 x4bR322YmFeGrfZe9NsqD77odeB/ZD8y4IbYvhObbPljmW9nnF7Ie8C55LbE9+q6JMb1
 ZAWqnWStN9RHa6Y8JhDxyl7foielF3sowflkVR0BGYTUl4B/9lZTSRzNsF2Wo9LeAwe+
 HjEvjRxjXFMruG9iXrp3WyXWdAg2T9WnLOH3xladyMm57zsOw8ELh15/xzHYtKlJHrv/
 /0VIdtmCKrEpOv5bt6/2MX5TiBoz9tGAJjo1TxgCB5jwRZdA5j20ayii9mK+IfnxmlMZ
 1GCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpm5KnJPMP/c+htWs1oL6rN24pDrb7oG2m36WpNECbbLCMKQXUbUiwP9d95Km+j5/kevI0YD2wyZ1ry@nongnu.org
X-Gm-Message-State: AOJu0YwveYykZRuNK2oTJf8hylGBcXrf8xuLGmyWU2M2FGzuvF2a4Fti
 kLmn+IrgPqSDOJd0ROnmJ9VyMxXoztBvpxSq5Fbde3cqSFKoggBpcWJRVB7QMpeTV3Wo0vf0Tgg
 taKz0h3kSTW4Oe2cb96SP+F8vwxP9o8tN7D3uMt5F8eIlRdvX8ikyRkYiBQ==
X-Gm-Gg: AfdE7cnNISKozLb6Qo4e0EC9CQx3jLF3So3WxOFOr/UENmXv03PZDXuFui/aEUnUU5U
 SmaBCuCAwYS/IR/EJKlQ5CA13YizpdS3g9ei7JVeJ/1asFIj2Y3eVLFLDfHE6/suyxsKTibF5TO
 d2teyOUj0DKJN+yBMaSnzHSNaYDhaqEq5fCp2nsodz7QbX7XDa6B9Tqnz07+z0vOCFdShmCVU6t
 xguFbgl79AvT8zpEIOQrk62MAYIguXhAIq9Cp/WVMkFYO8yhgJ03QUEg6CHZu4krhOb7Eerj6tR
 Tb6ghOwuUbIP5vvkD6/m4NTZ5p+i+jOiIfGTONDlYVcByw8nlNiRMHsFXombTndzUA5coeb4Tf/
 Sl+xw1RMeGM4gzYwj7LkII6d8nVlspoAjvUNbItqLOEfX1a6tr4CP2cZFwiSIWg==
X-Received: by 2002:a05:6102:2c1a:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-73114f0d03dmr2414431137.18.1782321994417; 
 Wed, 24 Jun 2026 10:26:34 -0700 (PDT)
X-Received: by 2002:a05:6102:2c1a:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-73114f0d03dmr2414415137.18.1782321994023; 
 Wed, 24 Jun 2026 10:26:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee018e8sm8824508f8f.11.2026.06.24.10.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:26:33 -0700 (PDT)
Message-ID: <b51d117c-a80a-4122-8ef1-a8b6c780c724@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/nvram/fw_cfg: Enforce standard layout for
 fw_cfg_init_mem_dma()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260529174639.451353-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX0t/Po8oXk5z4
 B6SeAT8ukI9iAKqgK89k3p4cOXdxdu0XsNYgTlWkYv+w4ABKlQuIw70gj4I42kDNDKDQv8DRwlG
 mOuYGwggEuJtvkEFZhnpn+DyC4fGvHU=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3c134b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=IIRpaH2KrgeeHQje89cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX9y2XRTU5PQDK
 /3hrYx8hCBTSPBmcJjOiRGpvaS0phwTAjWSQWFFRy/H2Dn46hGWb4F8+A9YX/eqR9utQvfIBiKK
 B2IMUskDYPc9P66tk5jYiygXfN/ye1CCfMfdhjXY0JLsIYflJoIcSwGeigRcawVoiYe51UUcJcp
 fcAdihle0ddc/lvr60Os7Q9fb6CxD8IZIqpmVgyWag4efc0efv9b/NP6YT4sbPojGMDcZfScjnk
 k937Or4S/Z21TDOvMOlbH5lyhVwyi1WCndDioJm3zEeAIdIOxrQ3zUwHUpSVrbgLgbhc1oDrJb6
 hDSkfNwwEKkyb/rd3ZoQdk+qd8YR/+YiKHbQmXmKaXWPM2AavDg5IVHrqOenpy3vq8BOETijXS6
 eu+C85eUG7MK1l8WZ/LFzUM3vaylnQ==
X-Proofpoint-ORIG-GUID: JwzlHDSf972PGRp4I20sHQSnHguqmWKo
X-Proofpoint-GUID: JwzlHDSf972PGRp4I20sHQSnHguqmWKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240145
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 29/5/26 19:46, Peter Maydell wrote:
> Currently fw_cfg_init_mem_dma() allows the caller to customize the
> register layout, by specifying separately the offsets for control,
> data and DMA registers, plus the width of the data register.
> 
> In practice, all the boards using this function specify the same
> standard layout: "base + 8, base, 8, base + 16", meaning that the
> data register is 8 bytes and the registers are data at offset 0,
> control/selector at offset 8, and DMA at offset 16.
> 
> Allowing every board to be different is gratuitous and useless
> variation which leads to code in guest OSes having architecture
> ifdeffery to cope with it.  Avoid potentially introducing any more of
> this by removing all the arguments from fw_cfg_init_mem_dma(), so
> that the callers only specify the base address.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c             |  2 +-
>   hw/loongarch/fw_cfg.c     |  3 +--
>   hw/nvram/fw_cfg.c         | 10 ++++------
>   hw/riscv/virt.c           |  3 +--
>   include/hw/nvram/fw_cfg.h | 23 ++++++++++++++++++++---
>   5 files changed, 27 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

