Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF236C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ys9-0006EA-64; Mon, 31 Aug 2026 06:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0ys7-0006Dc-Hw
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:04:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0ys5-0001ry-Og
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:04:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V9Igju2026910
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CAvjhrTWIDlxuDsoV+PXY8FuaILNHNxf/CszDeM/f10=; b=RlFzVGrmFo5UjK7u
 Sdssm7gEJJ49yhJ31CNQBhnNBnxwZot/5zgdArS1K6cfO7BgdrYx5z81fkypW2Hi
 MuXSYGXVaXbY+kf6bFYLkAWk6TalxX+Yg8JJBUfx+Amyi4Wn2VV46/+TNlyQ4BgS
 ku0QG8APkt0QtBHNcl0qjw/85Y8J+C5vts0uJQhxwOrZuJmZ4Z9zJRPBVaBNCJs9
 GefAEDl7jPBztS68zEspnk0zAH+LyoX0RQiVR8PEmoKxQl4NiYIeC3kiWbt0AdXg
 wmwe+setUI3aARugxU+Xt6HY2fSgPTGw1Am+8XcAFFpJvdwW9Ymr7mY4lX9N6tw5
 N6ggQg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vag5qn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:04:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b571432fso469710785a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788170647; x=1788775447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAvjhrTWIDlxuDsoV+PXY8FuaILNHNxf/CszDeM/f10=;
 b=XloVb2PW6xD6nX45Ll4D6UZSalHp/6nSbSm2qLjqvpba9QRPn4A9Ik5p6VQe42+Dh7
 9lVvUk88rizjcsn+LKmZr2eczU2DBAz2VjbnfC/mCiXYSy23FHtioh4Z8nDC+90pNQaa
 KVps7osBMO+oR45/i9uDBcE8vYeh3m58YlG2EOEVuDKTJtnW5Zq2tRIjh9iE5vjitd81
 rXDX4pQKIC6+BuqAjbwXK7n6kioaguILO71CT5xtDsjRUyB8XI+VWQCCERATxjyhPFcK
 xOqDjGNjw7Zkq8BXKwv9YseSHxp3CzDYQGtRVAUGTp2+CylNduVFnUCK07kxVes1YJS9
 8WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170647; x=1788775447;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAvjhrTWIDlxuDsoV+PXY8FuaILNHNxf/CszDeM/f10=;
 b=FcU1NCvcEKzxeubjorjzr56msr4QH70usaNCpz7O88Sj0SgrJ3R/S0DxAs0kMvujAz
 RKOIHTvQEG0RU9464wu4goQpkcAXT/sOfxpsIwKnDA/t0/I0La70P7ndFJaKaJFGxef6
 WuT0Y2Pcpy+OutkV8oPxkmFFcvAfD0GH5/KQK04gw9NaEiSX2+7GC+wYVjSRUY2iYJ6q
 3FihJ4uCJcxcDSdNW9jXb7+obp1ids1t+dOQnJ23C2b97qwnHzKrwcEU4weKaQHntTXr
 AOr0WuWi/OU0OF/QrOzsXD79GptA4+U2YR2iciufftW2j2pEG7d/8ZtNITKVxZBSDAnI
 V2Cg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4+HyNhAKJUFCTYFmxS1skUe15IRyHlKuXK7/n6RkiasykZ0UUJdEtFbQjwMRQ+/ChBEjqhuSDptTP@nongnu.org
X-Gm-Message-State: AFuF++nRSbbXkczPBmdB9yX8I2QiD0h0IXi91W5U4spO16SvU9iwwrlh
 XEdxAwEQDJ0k/TTymr7dxfmISPhfPxnD5ujCnYGXH/HAu8z+O90t8L6s8OsAcKPGAM3wHBlevVb
 D/dIs8gIARgT34MzoKP+XsXHM0sX6vk2VaU9pwmF3xirqQtcMdO9EEUmgDA==
X-Gm-Gg: AR+sD12E7sxMAPZeKPUISZBC8sYSz6lF5DkoL6ixkDA1zDnmIN5siiNAwuTj06t56Bm
 cIcIaR7olEN+lmPJZzmaqKPw/zcVFNSqZ7NUKRp/gOyuxO9HlhOwSJRf7ROQ4Ow8dyVAhdDtntH
 uvoSyTS4BF0VAP8hdYC/vVvfPfdzIbxUld6ETPtjAtoOwKyZ1bzVkwf/TlEsMv/5XeRetfN24sN
 RbHPNYZzTMmz2gnPgr+HG8EKAOfi7pgeOgE7/Rp4NehHo/r0bO1qSd9veRbycJjmacu4d5HdR4X
 5rXwVUpTB3pBkBcSZfd8FvyGAp+FltQFr2T+RENphMasJve1NVIsNOaiUPuoaVCySH1UwG5yIjw
 mdd9oUYxblg9LPoBBZlU7VnlCvgzsN58J2A==
X-Received: by 2002:a05:620a:1787:b0:939:957:ed2a with SMTP id
 af79cd13be357-93936cca294mr645185685a.15.1788170646778; 
 Mon, 31 Aug 2026 03:04:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1787:b0:939:957:ed2a with SMTP id
 af79cd13be357-93936cca294mr645179085a.15.1788170646308; 
 Mon, 31 Aug 2026 03:04:06 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b497fa9c5sm335200445e9.4.2026.08.31.03.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 03:03:48 -0700 (PDT)
Message-ID: <ff5c148e-d187-4d97-aeb4-6ab5448f79e6@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
 <20260831092125.1022201-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831092125.1022201-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NiBTYWx0ZWRfXzeqLTY9ODu3K
 wcddjadFAfvdI97kyn5nMvH/h18YLJjwlHmZQmKpqbtvWg96jXoypU/WbAbF7a+Qnnvn4U7xNyD
 2yRN87indfN0Xm4zlX+cnmHOgGIH2zfSyXQBALYypqr9aq7ypc8mAV8zAN6bPeyf+wjq5c5eqGm
 aMi8/KpXseAwH940N44goVVd6+Noh7OzX8Uudqf0aBrfQFLrdeFz53MKObDuYuH+wCropkWaiOu
 i/1QsuhHw8tGEg3E1h+F/ccxLH356DDkZFRh+ArdvIoQp4qydyltpagzP3TBUgnec9fFcmxY1KZ
 FJYR4AXQJ4hdnZ5jj6RTNEpIK19K0U+GpKk078GwMr1VSMk6A+D3UGxyzUTTnElDKebf55HAcy/
 jwkpeNGdGWdcvtUaXmGshvGIeBWUsjMcpDmpIZG2cLOhqnfU6zFsk4uC4qxaV3TI8CiUaeDQLTB
 FG5AB34zbQioA/3KchQ==
X-Authority-Analysis: v=2.4 cv=YYmNIQRf c=1 sm=1 tr=0 ts=6a955197 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NiBTYWx0ZWRfX7mdWgSDqMIBC
 Yw0FopXHyKZXX0TJAsmbLjaZWo+2kNoPpGxsZqNzsSLfKtqfemzLvpAaOEyp7VQcfm5/S0h0uaW
 GIHSIq6gzxHHIZSStZUJZ8CrLhHcOpw=
X-Proofpoint-GUID: P78iUm9OLfdaQo0cY_vX2jZZ4J6bfxn-
X-Proofpoint-ORIG-GUID: P78iUm9OLfdaQo0cY_vX2jZZ4J6bfxn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310086
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

On 31/8/26 11:21, Jamin Lin wrote:
> The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one
> control endpoint and four programmable endpoints.
> 
> Add the controller as a sysbus (system) device: the MMIO register map
> described with the registerfields macros, the interrupt line and the
> soft reset. This is only the register/system side.
> 
> Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).
> It is not the gadget USB device (TYPE_ASPEED_UDC_GADGET) that a host
> controller enumerates, which is added in the next patch.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/usb/aspeed-udc.h |  49 ++++++++
>   hw/usb/aspeed-udc.c         | 236 ++++++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig              |   1 +
>   hw/usb/Kconfig              |   4 +
>   hw/usb/meson.build          |   1 +
>   hw/usb/trace-events         |   7 ++
>   6 files changed, 298 insertions(+)
>   create mode 100644 include/hw/usb/aspeed-udc.h
>   create mode 100644 hw/usb/aspeed-udc.c


> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index de95686720..e8c00f813a 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -146,3 +146,7 @@ config XLNX_USB_SUBSYS
>   config USB_CHIPIDEA
>       bool
>       select USB_EHCI_SYSBUS
> +
> +config ASPEED_UDC
> +    bool
> +    select USB
Nothing depends on USB so far, so "select USB" would be
better added in the following patch. Otherwise QOM/QDev:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


