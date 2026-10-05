Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140F8CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDjnI-0003iv-OV; Mon, 05 Oct 2026 10:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDjnG-0003iS-6K
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:35:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDjnE-00030R-Jq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:35:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP5rH2515664
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 14:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yOlB1jYytZR6tJPLyf8evQw371PKHRJPrxYneoPMRVk=; b=kAzp8mK3KDITe632
 UQ3qdD6ctoO6ITb8Dx5vvlhTj+mvhW9yTq0r70g7cay0wJVI1bEueoA5zLx5JDtE
 ypLWVAQojsmuWgKwbrVaoTiFHCvtn5aJYFJqUy2MGdgpwseA53MO6e4d1GKAA0NE
 zYJebszYwn21+l/W2Ea5PwhEDGVkFvYz8PU5w2ZhAVNaOCZy6nC+KMHRqM29U2NB
 tcikdNIOaKPISh/9su9Qe3+dTgZXYiX5wLg1tnVsr5eXwYi4Q5I+ZW6J1SNvT4cy
 i5LYHbPbCKqDJl0HmOORefnGkSX0LfYf+CzEVWNzH3FuW1nN9YMpPeIPW3ZsTDLi
 Ddju2g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg0mhw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:35:50 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c29a61f144so136872137.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791210950; x=1791815750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yOlB1jYytZR6tJPLyf8evQw371PKHRJPrxYneoPMRVk=;
 b=kgp29D8zlE6zusy33QFKv1yQsegamysADSDWEVc4ldrGpyJGg54Oq60aVKhP3jXI8p
 VWyB+QoUcrg0mQtYBqITj7964SImEAXTkk6EdwcEYWML0TPFjSBukyye3DhjQTL3mk5b
 //OJUTIyBhsEEqRERxsFw1FvXFIRk3dKBP2Wqjg/nGgclGF7SlotFcQhwVKQkImNOfrD
 dHgT7VZ54971uqkAf7s2Ni4qkoJVw3anNrszCfg4I/gWzCiUA5F3tJ6lV3rJtDQtcbXV
 vWE55sFfTvIDLpm32WJtTIw17BkR+WfxV1l0qYtNG5LyZjBLeI6OdL+KAAEFcmaHb4cy
 l2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791210950; x=1791815750;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yOlB1jYytZR6tJPLyf8evQw371PKHRJPrxYneoPMRVk=;
 b=woTUfat0qMG/ZjLqqjqsbjoUeV6SYlSnRPzqbeDEw0PV5oIkBZrZ3OcQo6D3prbjvK
 5bwu4avibvqYr6nzHFNKh1AYliaxgEItpmmOqpOWndsUs52lyYvGtS+vobAVl5dF55m5
 oO+v1mMpvTt1mQqsFYEzlp0xu0jMXU3/6QxaUGATY7jHVmjPI3AABZNgwt5P+yx6zX4T
 vtTGwBnxPuQITV9zWQC5iPsVDwgnyZSo/8ZAB99iwIirWjyr/NWPCtRl2NJoZV71r6SB
 5h8Fln3zC0d5GkX2tXf6Yl5iMS4XcD2m5GLlCpa1NeLIagLytQcoxWvklw0F0wGOA+q9
 jnBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvH0SaykkDMumi9wSQkRx/xIsd7RIYIR3QuboSfajdf1Q/Gc3AQX1IFiUrNXXsTjM9aPbaJDw6bJVX@nongnu.org
X-Gm-Message-State: AFq9FYJOTlzaF+3GjcECZSmwhF9pUwYWW3807nqCrx5FquZhj6pBT8iM
 RUOozK5LreA8VUBruC/LFUmhBgnVqOS/CSlRa5vh4D6lHoDBiGRl72bBU0FVc/UsTThTZQhxgJj
 /ZFjDm5uoYt1DPBqLsBZRlCzHYvqtcfl9Hw7NXHBPrN0IHmjEBexOfwdqbA==
X-Gm-Gg: AYBFou07P39QEreadjmUDE47ynsP+KM+Ye8JZMjUB6CTi2SDcjhUjNc0shZbBzVf6Ez
 uaszjavlX2d9ToWpkh7yZgEvOiaEWJTXDdbJmAqN+Sq3DshUGWJUipUIBQwTSpcCWjriHoghuGd
 FAAJ1IiDv/VK2y5jcPecjlNMuSGp4fk2Ab8N5O6gj+/GbVRDQKcx3gJ3lv3AGNgbqqmtMtRykVV
 HX8SnvFxvqXzyNQh8GXLk1jn+HcWJ6Aplbr50yS4eBwlHNG0wavPiJ0xbB3hFC0ctY8oC3WRxxF
 dKdPLSWegnCSlL/J1cbc4XXyv71V8fwFfykyVYNEokvG3zUyLs5ztKN3X2rqs5ZWRsVgmaXCFlJ
 cKulWFACj9v2q0bjr4pEQfw==
X-Received: by 2002:a05:6102:160a:b0:7c3:43cd:6f9b with SMTP id
 ada2fe7eead31-7c343cd7261mr1055996137.20.1791210949714; 
 Mon, 05 Oct 2026 07:35:49 -0700 (PDT)
X-Received: by 2002:a05:6102:160a:b0:7c3:43cd:6f9b with SMTP id
 ada2fe7eead31-7c343cd7261mr1055975137.20.1791210949097; 
 Mon, 05 Oct 2026 07:35:49 -0700 (PDT)
Received: from [10.111.138.48] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17125adfesm118757125e9.15.2026.10.05.07.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 07:35:48 -0700 (PDT)
Message-ID: <8affd0bc-1c2f-488c-88b9-af3fd7a6571c@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 16:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: SysBus reset and heterogeneous emulation
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc@lmichel.fr>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260921214710.29422-1-shentey@gmail.com>
Content-Language: en-US
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CHzu80HMEuQMB5XWF6QAR9PBdfLLWFFB
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3b5c6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ENv9LmeRSArDsNedD5MA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX/s03S+MGc0Jt
 NCrp62jUSZ45D9wZIok+mYemXtWya2C5+kX3tJFmSDWhlt1x3ZPQDOeMCQf/0/I1q/jD+sLa777
 aAnvHPtXvc1Pzsxtz28lRxP5s1tHoL0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX4T//sOVhPQSx
 S/6ZqVdfa8QA60kuF/oXoobYXLxuIbJ7kZqmv6ZRpAkDn5K11lycYYzVEeQv7GU9oL5P2+EaxSk
 ZpLKF/jCfRJN1LCxDRJMEl2nWy3qJGg6nNOhA53zxT4TpKLgrs0fEQ7AJC49GE4p0DzpdPC5de9
 38DAEcKIKuTHdoomf8mYeJ/kCjP31y/nG/JlRbXJy/xzncshwhGNaYCEJf57RfwNbZEWTSUOhat
 BW3f0j94KNKPQrDqOUmTr0X+OHBzeB7HBpuZiovJ4Enz2nzkTQS+yvhHjD0CDmmUDAYvQaQ5SuO
 WZfFMOoZ+jWhliEDoRrpUiDIANWvOD2vgfhfgaz4w8u2RK+y6B3u4AvSSZb1EY6+OEEdVeq2E3B
 yuOf3snVQjSBEfUuub4KT7Y57099n4tKBig9xVp/cQB6ffcBexl7+JElruZ+CV4NpbZJEonOuef
 M4Xa9S1rECvyMgTSwjA==
X-Proofpoint-GUID: CHzu80HMEuQMB5XWF6QAR9PBdfLLWFFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 21/9/26 23:46, Bernhard Beschow wrote:

> Patches 11-15 turn the remaining i.MX SoC device models into SySBus devices
> which fixes their reset behavior.

> Bernhard Beschow (42):

>    hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
>    hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
>    hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
>    hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
>    hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE

These patches are described as:

   ```
   Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be
   reset upon machine reset.
   ```

This is correct for the current state of the codebase. However
I'm foreseeing a problem in heterogeneous context, having 2
SoCs (like some Aspeed boards), if one SoC is locally reset
(i.e. a software reset), then sysbus will also reset objects of the
other SoC, which is unlikely expecting that.

CpuCluster are not impacted because CPU types are not sysbus
based.

Sysbus API was designed for centralized memory bus and
non-heterogenous machine. It is good enough for whole-machine
reset but does not adapt to per-SoC reset domain.

Heterogeneous machines can not reset the default sysbus or use
the current qemu_system_reset().

Not sure where to go from that. Current sysbus eases reset tree.
For heterogeneous machines, should we convert to non-qbus
resettable soc-owned subtree? This is partly what we should do
with CPU clusters.

I might start documenting the current reset scope. Last comments
on this topic are Peter's review on vIOMMU saying the three-phase
model is "not very solidly nailed down" :)
https://lore.kernel.org/qemu-devel/CAFEAcA9ETg2+Xa+e3quJhGG3KsNuH+DW3puuWaJi-q1psUdw6A@mail.gmail.com/


