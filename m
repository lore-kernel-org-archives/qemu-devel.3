Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF71CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcnI-0002OR-Vk; Mon, 08 Jun 2026 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWcQm-0002mJ-J4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:02:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWcQj-0005ax-QN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:02:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFcD53524869
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qfgNdVL6M/39l36yHkBj81Vws2bPG3EcTkPjuAOd+ak=; b=KZan6BKNCm51iRAV
 NaGVRBRL1e0QWsTsPf35m2VyOE+TnyGTe93xnglmUpFenw4SqSqHz5bmRbD+udgx
 i5cFgRrsTI9xFB3dLZunMC1ePpmlx/+U1EH1B1hIV4NMuet1ba58gpNQkc3WXa1c
 jDEgzvBE8lAPQESiYKarDcK5klG+voVKXQpJsoMjLZv6MdU6k5K2ay1HRpmYyD4i
 krEniINA10Rcuk52PcUb/eWtPNlTzEivH4DHtB5zyptzAALDLHSlM9LfyUfJj8da
 zEzqiRjigIWA0el9oDjyEsc+6KVTqrCm6MvLkdogf/Go8exLkkHeNLgVHLOaxz/x
 en1vWg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrksxhr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:02:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c860544c077so4814106a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780934534; x=1781539334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfgNdVL6M/39l36yHkBj81Vws2bPG3EcTkPjuAOd+ak=;
 b=GYdYiCbpgVJgdUtGstVvjWuuCk8O5w/n7grdgEpQph/gkdEyu24lbQcMLGwAnLsUoR
 PwW0qwRq/821cA9mp9lvggXxZFxw0gyH+IsUnIG+nMLAKSTkFUhtX20NYx+GCJSD6vok
 l2B+uqF9zWC/RQMNZHRkEvvvlH1x2zCoea2RDXQLAK748jr5pCdwwLNcEQsa5TCQ6or8
 twu1GgpcajzZySJ2zcmCA0hMROxqpJlthWVpHxpD++sgrvbhNKLsT1chGPi6gFLIgkbt
 EMcOSzGJ59JVKjQUEWPZBVamBGtHyduHUtIK7mVWMhQpZtzWnigVqJbuN/Q6GwjHJtQ/
 CKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934534; x=1781539334;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfgNdVL6M/39l36yHkBj81Vws2bPG3EcTkPjuAOd+ak=;
 b=Ki2S7/NWT0y2k5tEtqSjaxRToMpZ0VnkwdH1QnVhfB83ejvT4kv4R8tKdzILOi9FQY
 mtB7q9o9OGK39QAQE68u8g8MeYbOCRcXR5XZ0EieuYwGC9b0BHOShOu4dmJACrFNevf1
 d8JQYfwhwRgC07lexh9kEE7UABrWqFhYZj+9XgYa9ZAxNh4P2nsA53zBdOxQaPVft7l1
 zYSwlq1s2SHTxo/qZOPxvKfrbZKX+k34G6EO3PVC6OFNeKMjMbULjOd+GTMvBGCAOzHF
 8J1TLtg0o0syiqMMAohXvNB4Xw586onOXKXPwQI9goSfabjO7HCYYdWQaJNeCTS0DnBt
 OMWg==
X-Gm-Message-State: AOJu0YwazNaJeHuHpNdRDSZLVeJxTvhtbxi7TvDgRwYYOgw5b6B7geeg
 OXAjt+432sjUjc7sKK+nhbgbHSetGECaRD2yZyyIrCqqyQpm/z7UXrf9Def6chYjPzpnkYj3Tpn
 xSpJBaV33ifbM+FykdIcQp9OWM7M+QSZcCpJ5vrghg9qXMac/W3ohSISjKg==
X-Gm-Gg: Acq92OH9xYGv2xLoYyXoJVYTkDtwrF5lRlBXMyoO+WatD1g6WRdn3au97WYyWAGEvm/
 eis3jm1ill7pwtRJO0RFq6w/U2grF0AmvIMGFkmKIeJdzNtv2D3zQAceFjGp6wk8X9a+PyuzFz+
 8KwWf0k8sSu6GalPP8TDXElHZDawahmEDxk6O5ILRiGYm5KNyE+7nx7LYdLX2bhjCezbpNbY6Kk
 B5QGenTlxGLalt5avktFeTiLHke0U7AHa46WPZpknx8WU1hHqcYVIvNatrdMb+3WrjnVGu7u3a7
 sQYjmVWnWOlHNVPIQmY4a9vZ7NG3MF+KB4Q57RIzB+tVr4YK/y2boqL9KcLz7cPEk/ZJMyo7FnW
 k1fAtkdi0TRyVZcz1E/zTThqIJl8v2jIB85Nsa9DnkRDfXorp+rrM8nLakf6ooKzlzvY=
X-Received: by 2002:a05:6a20:160c:b0:3b3:10e1:a87f with SMTP id
 adf61e73a8af0-3b4ccf81eaemr18408872637.31.1780934533437; 
 Mon, 08 Jun 2026 09:02:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:160c:b0:3b3:10e1:a87f with SMTP id
 adf61e73a8af0-3b4ccf81eaemr18408791637.31.1780934532942; 
 Mon, 08 Jun 2026 09:02:12 -0700 (PDT)
Received: from [10.156.84.244] (180.171.88.92.rev.sfr.net. [92.88.171.180])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e650287d9sm7562791a12.12.2026.06.08.09.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:02:11 -0700 (PDT)
Message-ID: <d9abaa0e-abf2-4eef-9292-171b55588f4b@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 18:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/nvram/fw_cfg: Enforce standard layout for x86
 fw_cfg I/O ports
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
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
 <20260529174639.451353-4-peter.maydell@linaro.org>
 <d6f30fab-eb87-45e7-bc5b-bd1f97afead8@mailo.com>
 <CAFEAcA8uLpCA2kCzqM2jii+jigd-mRYgpVCfb=qvwZH4SU9Gzg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8uLpCA2kCzqM2jii+jigd-mRYgpVCfb=qvwZH4SU9Gzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ELlWXi31aAqOFkZUKnHjJ-NoXABKZRSM
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26e786 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=MkcZI9oj5j1oI9ZXKOqVmg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=S56xvJB5AAAA:8 a=KKAkSRfTAAAA:8 a=k5iAPTZnm7KAvOaWwCcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=MH9Ivq0PDQRhlrFuIVvX:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ELlWXi31aAqOFkZUKnHjJ-NoXABKZRSM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1MiBTYWx0ZWRfX8812BpOjemA3
 3WzewYlMYVnRIYzx3ixcqyal7WtrtVNsnrJ/HgPe2haLmCWfSNkNNMrzv6dJkyAAFxHrTHsscPq
 q2GSHgWHfg9YN0keMWfBPBmFc4HKC81fRKc4uosPCRXsgnA8P/yq+InvBQ3+hx6KWw3/kVEvAZ5
 x9Z4/HC83tGnWAYZoX2H5gljCJxI9qeUBF5B1R+Appl6QbaGbUIlJzh7CJt4FS+rcy2OFDDTPxO
 aj62Rpbz2BzmCOMofMX25LvDyV0UPhSCTFcHkX7RLt639S8sH0oA1ix6iT7QeYTq2FSf11vFijm
 9LwIZBEwV0e3rlRWlxpa0JIWbE13XbzZzjEiQ74SoIMLxjbEUsfO96ZHNTfxMLbcvboEibr2Ait
 Y7cQE8kJEfbGmRcGXr7lO+6uobxbXJimlQjHxtnzy13tLFTIkU/m9facEFNjzMN1ayqnaXIIQFL
 jTP+cUJpM4yzxtIY/gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080152
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
X-Mailman-Approved-At: Mon, 08 Jun 2026 12:25:43 -0400
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

On 8/6/26 11:12, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 08:08, Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
>>
>> On 29/5/26 19:46, Peter Maydell wrote:
>>> The fw_cfg_init_io_dma() function allows the caller to specify the
>>> base port number of the selector/data register and the base port
>>> number of the DMA address register separately. No caller actually
>>> uses this: they all pass in base + 4 for the dma_iobase.
>>>
>>> To reduce the risk of unnecessary variation in what different x86
>>> machine types use as their fw_cfg register layout, remove the
>>> dma_iobase argument from fw_cfg_init_io_dma(), and have the function
>>> always use the same "DMA port is base port + 4" layout.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/i386/fw_cfg.c          |  3 +--
>>>    hw/i386/microvm.c         |  3 +--
>>>    hw/i386/pc.c              |  3 +--
>>>    hw/nvram/fw_cfg.c         |  8 ++++----
>>>    include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
>>>    5 files changed, 22 insertions(+), 12 deletions(-)
>>
>>
>>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>>> index 45a3747908..be3fb5f8aa 100644
>>> --- a/include/hw/nvram/fw_cfg.h
>>> +++ b/include/hw/nvram/fw_cfg.h
>>> @@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
>>>                                        Object *parent, const char *part,
>>>                                        const char *filename, Error **errp);
>>>
>>> -FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>>> -                                AddressSpace *dma_as);
>>> +/**
>>> + * fw_cfg_init_io_dma:
>>> + * @iobase: x86 port number which is the base of the fw_cfg port range
>>
>> s/x86/ISA/?
> 
> This is specifically x86, because we use this where we're
> wiring fw_cfg up to the x86 in/out port instructions. There's
> no ISA-bus version of fw_cfg. Anything other than x86 should
> be using the memory-mapped fw_cfg.

But this "x86 port number" is really a address on the ISA I/O bus.

Maybe make explicit we want this method restricted to x86 instead?

"ISA port number which is the base of the fw_cfg port range (restricted 
to x86 targets)."

Regards,

Phil.

