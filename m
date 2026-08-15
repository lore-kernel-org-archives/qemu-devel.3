Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE119C5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEmu-0003NB-Ga; Sat, 15 Aug 2026 09:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEms-0003N3-Fc
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:51:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEmq-0002P8-Ts
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:51:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDN76B569401
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2hHIf0Evs9y2RqP76Ve5u5Nea+AFCDJ1xv2CmBiIkSc=; b=n1D4SICL9yUfg7YN
 hFzMhXxoyW4rqY4U5SneTcJ/t54h1Ahb03sZQJL7tv6hxFYTf/aN56EIE7OHMV7m
 PSt6a35Xo+VOCy7XK3/JZHaHU7GXFSWphB/QD710iUH7F+oVAQETgMybxcIXCEMi
 eSN66FiPMLRHfdngnB1Zx8yMBkvJQMcsTsqzimouun0c9NtponA7lPSVN/cSyaSr
 ogp5TzFrcD4WoY0u1OX/5VCW9hJUe+CoO+knKVZawFzXrwq7jvMH0AmaUWGtqqfk
 RpE53qoAk/m4KyIAdZmrfgNDmrPYpJYd6YyYpXVfcuT8WojnwLD9p0qGXSxdE8tS
 hq04yg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf141q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:50:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934979ee9f1so252690785a.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786801858; x=1787406658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2hHIf0Evs9y2RqP76Ve5u5Nea+AFCDJ1xv2CmBiIkSc=;
 b=NQjPE+TaAP1LUD7Lk4th27bMLiGv6Mgev5iEfVruL90SoyXAj0lfC40Zy95p+13m8m
 TMVCUCladZGtSTmwTOQAxm9i1mtTNOpset+4e47+WbdOTJM1E/wREQ0Sp4XGfGx0qIdN
 Gvzx3Jrbe/gU7quS8uQTz79ETTP6sjmMZ5DrrbMG0K80egD9JAVMaH/1duFFVUOpr//6
 1YhYH4yTG0h48766YZJp5wFkRUyBZuBWm+Q9g8U/qDSiySTKWrG36UWks8T5IKPJR7XJ
 7QvTd5zn1P6BaaWH2AwkEkJwmC7nf9jWR7793Ei0G5ApNSYJ762JjStQqrXBIlxH22QE
 +q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786801858; x=1787406658;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2hHIf0Evs9y2RqP76Ve5u5Nea+AFCDJ1xv2CmBiIkSc=;
 b=TQO4ML2rD4VFcLrLJEkbBrAI4IEpXH3b2IqnSrx3BeHTmTehC+QAYM11tCqNA7SwJ0
 KkWL3xUtW3H0/PTRu+fGqHpNQuy36YigY0I8WRvkmSbh1OiHMta3blVSe0M7vrsjaoAt
 IkZgyR2x6Y7K0WdpaixFPMXQCxIZuavB6ph6L1Ue8Z6qLKSbT00sUmEzSQ7an95CnRPp
 eQ3Ds4s5UzEzUIKIJcSdvdSgPAkllkXfPvKJGBVkhZvolNQsneLiinTc88qgoPPudIAF
 Vr9RYJ+ncmDxcKgetljemEkEm8QB16+B3pONXA57zqimt5yvtC3CdujdxRK1xXMK6Xpe
 xR6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmUfq2wSgRKjWbgRcy8BeZlddcLbcUeIgLbuXrIDOpjW3V5/+LBrp990Tq03jBEVRr1hXOKsrhOSMu@nongnu.org
X-Gm-Message-State: AOJu0Yz95noJQUOFCzOSsbI/C7HjDa9CjnPxAl/9jZVhIMU+LSvjyjno
 iqqM7qHMjtKIYomELZN9BuLOMPCzAm5Am/U/LfoR/XmoOMsHE1Xtr4i209m3d+CAwoXOLV56V8S
 Al5+u7mhaDoH6RZcEKmoIckirduGdblnlAbWjxHh97zVJthaBQposML7Ang==
X-Gm-Gg: AR+sD10c8JFVM50sIxfKJ9/zEPYeG3vgOhzrlNUjHu613GcP4OS4sDxQQGQq3cl+Qsy
 KgR8A0aHo6o8eMXpPxcuNyv6kIkgMzL7yX5Mh+pH4vtt8mVUlgw79F1dMeJ/8m2X2dJMC8/rw2V
 C1DONRwKbzuLdoZ+huk60+PyLD4w1JFnKERk07TagXGeGuh5ObyWqM+twdOvXrfh51JWnQRx0wq
 UgDCTyt/XBvsQUBZ5jRuYTsQxOYW4oUlCUUWWQD6sREQ6UX5mUzCcUCyxjIKjttCznX9Qbs676m
 3Qj1tMCDtcZTc0Mjf/vvKRllst6w+9XgaPgWGTeCSv0RZAZ1YRIopahCBY8LkVv8I00Aaa9RKxg
 ZawmDRzzmweeISdosR9dv/5uYs+nmR0oeKdM=
X-Received: by 2002:a05:620a:7f2:b0:934:97c1:ca5c with SMTP id
 af79cd13be357-936d2029273mr1108398185a.16.1786801858043; 
 Sat, 15 Aug 2026 06:50:58 -0700 (PDT)
X-Received: by 2002:a05:620a:7f2:b0:934:97c1:ca5c with SMTP id
 af79cd13be357-936d2029273mr1108395985a.16.1786801857556; 
 Sat, 15 Aug 2026 06:50:57 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm15852137f8f.21.2026.08.15.06.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:50:56 -0700 (PDT)
Message-ID: <8b3a71dd-2595-4110-b435-67d6bd3e3655@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/net/rtl8139: fix vlan tag related bugs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20260731093618.2961031-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731093618.2961031-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a806ec2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=oSZQzSOErPGJnS8SOK0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 43lBCgRr1uNlEMD5RX6i6WcT7lOvFJqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX0j4bZf6vcfQU
 aC13JEHwi8uBWwVySScDHPsPJXU4F5LK1oQKd4nZu9vwy5MB6Ov6LJWfXEpU3FN1AhdZlV6yf8B
 ygKuBjGm+AlzjEKbLa+PTBU5MaJRz4nAq/nnWgVBjbzu/M1fpYem05aBJML37Y+2BJZdBfAsOId
 qm8LToJfrKuGNHy7PX2ICXWrcVlU22bmFWQyvh+VzNcQSD7/VI6zUfZSSPrJv55jUe5DzfeC35V
 6mM42hhW4JVSRe/eSkhwfnhybTdW7L52vx/0Nnwoy8j7Ma/ZUCZS/SFKMkviP+uouSgQfvbSDpd
 DQQcJDkE3TTdcJ8yjubqp0/76NU9tD+38BpsVQfP18DEgD8c2YBwT7UHijqCYWR0Mc3uEsOqOq6
 s2flFSUeI3RBfR3Aq+PSGKdZH4cxe3lLR8f17lT113x4CykUss0NfehYvGq6BoQniAqbp/bS325
 ZgMlJNtT8Fty8/p4Ixg==
X-Proofpoint-ORIG-GUID: 43lBCgRr1uNlEMD5RX6i6WcT7lOvFJqH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfXxrPH6vE7ZCYH
 Ym9AfA9LP4x+pM3+WXMAmAHoXXRLacYcqbeel11VmAicBKahapqSflcQITMFLzailvLzCyoH1sj
 lMVorC6kwd9g5Kv8X7+Ys6FDL3lkEhA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150100
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

On 31/7/26 11:36, Peter Maydell wrote:
> This patchset fixes a couple of bugs in the rtl8139 device related
> to its handling of vlan tags.


> I don't think we need to be in a tearing hurry to get these fixes
> into git, so although I've tagged them for stable I'm expecting
> to get them in after we re-open for 11.2 rather than trying to
> squeeze them into 11.1 at this point.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
>    hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback

Queued via hw-misc tree, thanks.

