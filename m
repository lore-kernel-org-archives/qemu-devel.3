Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93287C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WYo-0003Nt-Ce; Fri, 04 Sep 2026 12:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2WYn-0003NT-3V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:14:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2WYl-0008MS-CG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:14:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684EiXMT195986
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 16:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1HFPbKiE80mDQy8kEDQjv0PdzGlIQNYz+icz2F9PvRU=; b=onGqD46mQTNLK4Mv
 zzvD0EzcVzT6xpZ4UQk7FEHEv01Qdvou4rlZQDD0VwrRyJiX0/L21zkKfTwD3gW4
 fNhn9sIOBAeJ4cF/rMKfdK39j9VeG5Y2yLM1XnX+Ao9C8bVTHZ5zy+1ghoq8DbT7
 4/5wWqsraanAcCtyS+zWQmgXMMKOhjnaWMpe8uD/3U73oxI0XXRgwfjjYDj1KDrj
 H7LKlmmsJFPItmx1CDZgUU/eyMfz3fk+l+FTzCrXzbZ97qxnnyzR3G/+VtbkoVnf
 FZeGRASbBCbduUcP7UQwklGGQjGBsfmGUQ9nwnowWkTUUOh8wwewC8PVmjZIr9Vd
 NeyEWw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg0120r46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 16:14:33 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-744e7890eceso254067137.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788538473; x=1789143273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1HFPbKiE80mDQy8kEDQjv0PdzGlIQNYz+icz2F9PvRU=;
 b=GZXsqMXZkw20Qbc63u5378pRxaJ2+4S+hbR+iEKxh78GuMW9jcTXs+M9aINAQMg4Pm
 +mfn/aJ16GVYg8OoEkR22be+maT+pYamouW9p+r6K+51CXlY+v8weOz8bhwk4jWrwG++
 G6RC9atuBc9xKPZWqgYIsoJKpgpgl+p5d+/i2arCoMFl9lrkNatd//dNE6Kp5k1Ic7Iz
 GPbE2norPePxZhwpSzXbkfCoIcHRYuSWgEniH1cnJGR7HQPR9Gtinon0EdtSxZVGRh2k
 2BayQBdMHWESPoXkYqFu4KCwwHyqbCuROgjrcOjfZCFPxjWVT9GAklmL84GO6/X0B37S
 52Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788538473; x=1789143273;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1HFPbKiE80mDQy8kEDQjv0PdzGlIQNYz+icz2F9PvRU=;
 b=rwhUH9CNCMr1CoSsjBiLY1XUp+cVDHhEI7H3RiFJTxEyGnUk+RBHxmyJJPFMbZiyz9
 iic6dGLPvV7WUFUHKt6jEehmOIsZHbcl26b9aUcCPPiubqnfZmRVyn55mLkLpFQpA66Z
 pA204lMyPT4iL1GrqjQ0Gjs0N/V+dXdg5xEc9OSO7a1eIiURvIMc6akF606U2xXm0C7a
 bBTxqzTeyBMN7QPx5PNLqm80qFODkRfyCdUxGDgTz1exdbfiZZYYBkZGUZd2rmixUrwt
 XtB2yBOQ/SxgeRfSkphB7Nw2lpEOPWtBSstrgzvgFeEMLvFNVb3gODgmWsRaPTapBNws
 8T3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm4OP1ugymJF/cPODq/9UD0ZzcJCBxqJ06aP/nUt0o8wohJAqqSM5gMxrEPkIwnydv5qj+T1LzRlbJ@nongnu.org
X-Gm-Message-State: AFuF++kxj+aa3CtdoZi3e4Rqqzxy5YsxRRHyj/ge24RknOXyDEy8ZxZg
 YKwirNy9ucxpr8EqFwMXb+RnpFrjhRqAB/hfO531p7XVUIYL3CMo+ivTnyCRTnZgzjz86hMvTu3
 dSeskS6SKQ75HwSZJWDQ+ZhT3+GoKdF99PF1jxL/iGoiHYtMTOq41ylNs6A==
X-Gm-Gg: AYBFou1Wyi/0bo12LsbbvdB5bajYn7r6VhE0HXCuUoRcYyd+NkpWjgk6Gc69R4KrO1X
 MgIefPEn2HTObNy3NMaO5p87JZbcIU5FpRe7teSx4LxfcmxvKJjAASpZ9oYxCbjbfkb0OArfCZi
 bHNYDiUkLFXB2V1Ylpr3LOVg2hRrwO7x3gdTcvQAZ6fY+xHQXJq1WT2jmOy7ojk0DzoV7339q7r
 I1U6jwYKiVJJfuxxBOHdB5BoeeJwIXKQACggO3XOFpqsq3P25YbkUWCynXm2LobjhN8ATe3IYgi
 DpdIUq+mtfGyx473g4zXw12Enl74jy7Cny97BTThlKAGqTAP/PByjzS0DofWFBpQnUIy7FKM2X/
 Ib4T68Ba+cYCOFB/e9yl1V2Rgtd/8gvmw0w==
X-Received: by 2002:a05:6102:160f:b0:781:210d:28aa with SMTP id
 ada2fe7eead31-78a4a8be7c5mr2390182137.2.1788538472993; 
 Fri, 04 Sep 2026 09:14:32 -0700 (PDT)
X-Received: by 2002:a05:6102:160f:b0:781:210d:28aa with SMTP id
 ada2fe7eead31-78a4a8be7c5mr2390155137.2.1788538472508; 
 Fri, 04 Sep 2026 09:14:32 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5952560sm186017105e9.3.2026.09.04.09.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 09:14:31 -0700 (PDT)
Message-ID: <f41f98ed-d33f-4863-a9d7-b9fc72220a20@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 18:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/pci/msi: extract msi_message_address_register
Content-Language: en-US
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
 <20260904-jmac-rme-da-prep-v2-4-fb461d78bbb2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904-jmac-rme-da-prep-v2-4-fb461d78bbb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX6JmntYHeNyRA
 a7sCPiBh1FLj7cJiPvtfKpGEd3cuKT7MQfFgUwbQIaTlceK12KGNlh3jLP6//MzWBFADRLLPXLB
 OtWBK102JE8FnkSmax/+SrZc1F5V2Tg=
X-Proofpoint-GUID: mAaSRB_SHtmwMdGAWI1hri4He3dGZqbX
X-Authority-Analysis: v=2.4 cv=LreiDHdc c=1 sm=1 tr=0 ts=6a9aee69 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=cpUaK4s9aEvszEVTPDwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mAaSRB_SHtmwMdGAWI1hri4He3dGZqbX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX8sh627BOzbuf
 kAyDpWK+EbfMq+xuofIAZpo0WeHhcKitHorvD5LWZGaSZ9zQVeLGpds0XZLDIRXAiOEWLzPERa0
 YMbPht1LiQ8UGdj16DQGl2jprKRq01kCJqRE2pJ1BW+Eplr4UVOyXg++8CtQ7pi6DGQ3LCIBCie
 GpgHxEOUglwW+DBH4RKSw0J+hA4auAlQtk2YGfAS0UeuSQ882qyaDPZqPUR9qZadgFkCx85m6aY
 VylgN2mSddJdDwO6bet4RuXZOqkfHUdhFx9wT2v7CpaWppiglbc5RGHJkjPwqNCkWGhYskjim2P
 dD2LC6oWI+UspePvzxYrZWHvUjbZmxU8+xGMHEojJ2za7ZDU+VSvgWueDm1xGShxPdO0ans+qr5
 3CsRU2UmRmCS7OVfeGsKFcV0WjnlIfCsQoX8HAi/wjnKxAwFwn5NK5QhmoiiutkJCWBgyY0b5Jw
 2FNjdNTCyaA07S3pqWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040147
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

Hi Jim,

On 4/9/26 18:05, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> We need to access this address from smmu, to know if we are translating
> an MSI.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   hw/pci/msi.c         | 19 +++++++++++++------
>   include/hw/pci/msi.h |  1 +
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci/msi.c b/hw/pci/msi.c
> index b9f5b45920..7361776ace 100644
> --- a/hw/pci/msi.c
> +++ b/hw/pci/msi.c
> @@ -137,6 +137,18 @@ void msi_set_message(PCIDevice *dev, MSIMessage msg)
>       pci_set_word(dev->config + msi_data_off(dev, msi64bit), msg.data);
>   }
>   
> +uint64_t msi_message_address_register(

const

> PCIDevice *dev)
> +{
> +    uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
> +    bool msi64bit = flags & PCI_MSI_FLAGS_64BIT;
> +
> +    if (msi64bit) {
> +        return pci_get_quad(dev->config + msi_address_lo_off(dev));
> +    } else {
> +        return pci_get_long(dev->config + msi_address_lo_off(dev));
> +    }
> +}
> +
>   static MSIMessage msi_prepare_message(PCIDevice *dev, unsigned int vector)
>   {
>       uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
> @@ -146,12 +158,7 @@ static MSIMessage msi_prepare_message(PCIDevice *dev, unsigned int vector)
>   
>       assert(vector < nr_vectors);
>   
> -    if (msi64bit) {
> -        msg.address = pci_get_quad(dev->config + msi_address_lo_off(dev));
> -    } else {
> -        msg.address = pci_get_long(dev->config + msi_address_lo_off(dev));
> -    }
> -
> +    msg.address = msi_message_address_register(dev);
>       /* upper bit 31:16 is zero */
>       msg.data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
>       if (nr_vectors > 1) {
> diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
> index abcfd13925..6f0e02c0fb 100644
> --- a/include/hw/pci/msi.h
> +++ b/include/hw/pci/msi.h
> @@ -32,6 +32,7 @@ extern bool msi_nonbroken;
>   
>   void msi_set_message(PCIDevice *dev, MSIMessage msg);
>   MSIMessage msi_get_message(PCIDevice *dev, unsigned int vector);
> +uint64_t msi_message_address_register(PCIDevice *dev);

While this file lacks documentation, it would be good to start adding
some for new methods ;)

With doc+const:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


