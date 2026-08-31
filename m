Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93F2C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0u6m-0004uh-CQ; Mon, 31 Aug 2026 00:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0u6l-0004uL-1m
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:58:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0u6j-0006AT-IQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:58:58 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bgtM2322444
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a357t67CLA6DvsGXbZaLMlm9wg6KFtCMW0Qj8jJpIlA=; b=WxZlqmrBVRUBROXc
 2PUXeVTfjLBMjIiO4OKbiHxdo07dVJVPGFPXofIiG0rQGZlpbkQAs+V5LVP+E0S9
 bgB8b8Cb4iL4huLdaWsfpjW52r7Y2f7T8FT7BQkpMc7WqSHQxvMNw/XY7fPj/UEr
 9VCVuVk7gBkIwCEJln4t7IBffXOLPwLozCR0gnCmg56XWoHNwaon0FgxAkFlr0HN
 ca5spu11de0HyIJfMzNFzDyYFREfGFUAy8HjJ/aj62pNCScyD1sAFLkvORGkRu3T
 EA+MLZaIyWXF6/JFtvfmguqU94zhAZfmhhE9+RK/x2plWMxZ8kL8cDdcz080+Mw+
 1HjPOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgymmsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:58:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so836000385a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788152335; x=1788757135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a357t67CLA6DvsGXbZaLMlm9wg6KFtCMW0Qj8jJpIlA=;
 b=JxbltNjHvJaqtv/oHSbFf3gHj54CekQoW5iAP+C1/T7IDgIltFQfx3qDyQMw8CTTGJ
 kIKTq5p+bbMdWnpa2uJ44XQR9Xpuqm9DkBY3npiDRNuyfQ+DQXAsYCtBYHlH8u5fgUvk
 JvUPwddq6A/8nnMp20e0BxvnYg3940uidiQHEF2FMAQBu3HH6h8JikYWa1mPvLvlSPrE
 nL9236g2LSAyXuxNwx12yNsKPxUxKCbqDxsvSLodrU/UCRWN4kSkuaL4+PcbWtq5TVSu
 LchoxNvDEu7EtLu1iMSgm7/4+6uV9ShUzLds+2ZLpdq6sil6hcDMe5WWwTGDch+jowRE
 ufZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788152335; x=1788757135;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a357t67CLA6DvsGXbZaLMlm9wg6KFtCMW0Qj8jJpIlA=;
 b=A8o8DItKqZfCvIuzmjPk+7Yo00E4GJxJPzOxqIrYFKi+5mv4n1ClFzuFBx/fUilDSC
 Xmzec+KMX/Ck+SskMGXAnOlQpojeWDOJXrHIOFAbjXHhWGvJtxJwPjkWJHJFIdu075ST
 1li1znAlv6/rhvpbS/1ENTP+I9lNe+SdVdZFmsdLwggiFh2yIxCkMYa2y/2swO32YiVE
 0ui3PsIxOzozoZQAhVOUxpP8x8fsHGdTGmZvd4+cwhlfUdbCIriyVZadLrd41AtUlSlL
 FrdlXJ4w6oGZPii67dt9Tfqtn2KVWOC9sA2VRx34AKo0hjE4E5CGb/bF2vS1wN5Ql3Ut
 6/Bw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj2+N8jJLyRpoRKIuHO4ySTwVYaFq+LYpJzojIh7nA4aXvOybO5OFmr6XqysoUoUBYm7ozSt0t7rGw@nongnu.org
X-Gm-Message-State: AFuF++mSGfCv1v9PHLIMoRhB2m1aB0IXgWQGS7ymHWPph+Ex+zcQbyR3
 ZIy0oQ0JQAUxtKpMK9tjV4PODakpHQkYoMJiJGRTNT64q6d72kgYG645N64u3s2P3z/W/TJu5Us
 BSpwap9I1nrXQS5eIswX7FuLJZwwJ6PYMWBE+OSoilNFbao2H2ZqYrffQQQ==
X-Gm-Gg: AR+sD13SsQP9RzgCx13KU4Z+H4HrVHwfoghL4H6a59FJoq91L/hVqvceVenRGnJzkaZ
 nzTjn3UdVaYNtQJj17COFI0vMlfj4TmdxG5JlnPz6bWIz3NHLOUGfywqiXp+hpK5r9fd3cBaDSd
 dSJfY6FQ5kzlCqtNJiXbM8EXD9fBM8L6/aIoZ1HDlCsv6xDV1QXCLXPpacgipGfjgZp7RtG3h+A
 JOu67lcXYKl9PP7m8UCLgkicgEI9EJH9ppanfCjDjmjBEEuNM1adGL27LZIIavyZwtHq+Bpq0cK
 vGiv584m304s2rkLjIdwnCOIZLE1IS4/JeD7bF3qUGEeT1c99aeYI8ch84ZJf1ceeoJ6rdhFPnx
 LMVs5tb7NKcJFcePlQD6eh5qM39W3NdTE2Q==
X-Received: by 2002:a05:620a:601a:b0:939:93f:3b41 with SMTP id
 af79cd13be357-93942856abamr64660685a.16.1788152335386; 
 Sun, 30 Aug 2026 21:58:55 -0700 (PDT)
X-Received: by 2002:a05:620a:601a:b0:939:93f:3b41 with SMTP id
 af79cd13be357-93942856abamr64657985a.16.1788152334934; 
 Sun, 30 Aug 2026 21:58:54 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc61cfsm373683545e9.6.2026.08.30.21.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:58:54 -0700 (PDT)
Message-ID: <9e581d4b-cb69-48c8-a9ae-08af2d98aad8@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] hw/intc/riscv_aclint: Take a MemoryRegion for
 the created devices
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-3-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfX/w4ge1KRNF/9
 HyD30cWvp72gj5MMD9vtKqXBpWoi24LSf56gZlT2ff9jWWrry066ZqK1v6wDRdF/9IM9baaEj8G
 ND4LruZJ+kNghhxwCvDEPbm4zO1uR7g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfX16mHnZISI7wD
 +gCOpTJgDBVAhIxSDQdfpYp93df7dISjvlvzXIXH7a9mBOIh2AaASqJqMgjsPAmQjlo3gglQu4p
 U5lvfnOays4kS20CKleEa+C3TmGq+8eoqQ9kbdYUbGnqEFu25WXIzfAuMlno1aQGkyt61AVna88
 XW+U/GKZiXbOvbeYVRMIndx9ZcjARpqDM0rnwRKtk3N1w8bv1AR0V3z1kLykTvaGFxs2g+RisBZ
 u3M/xYVIH0JXNO77pku7DaT/t1XdvWEB4acy3sJ3b2c7X3uBN5u8uEnRYbutbX/N3D6JqPTeI3R
 N1fSyE+p8lo675BS7+5JTsw4tchpQz57tfwQRlARvjOKo14bXza0WvzL2Ufqxnx90FOo5b7khC+
 ZULPrxt6G1ESAg84P/8rthOgEWUMMbeR/Luwr9IVPfaOJnjuz0Hg3NhpPvfNjQsSpsyNxKDmb8I
 tVLhlXdfBJdN7eSxkdQ==
X-Proofpoint-ORIG-GUID: jmO67437cdPSQsiFkd8RAJKdqbosG9I-
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a950a10 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bdjt5dVApZlQuLGRqioA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: jmO67437cdPSQsiFkd8RAJKdqbosG9I-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310040
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

On 31/8/26 04:14, Joel Stanley wrote:
> The riscv_aclint_mtimer_create() and riscv_aclint_swi_create() helpers
> map the device they create into system_memory, which prevents their use
> by SoCs that map devices into a memory container of their own.
> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/intc/riscv_aclint.h |  7 ++++---
>   hw/intc/riscv_aclint.c         | 12 ++++++++----
>   hw/riscv/cps.c                 |  6 ++++--
>   hw/riscv/k230.c                |  6 ++++--
>   hw/riscv/microchip_pfsoc.c     |  5 +++--
>   hw/riscv/shakti_c.c            |  7 ++++---
>   hw/riscv/sifive_e.c            |  4 ++--
>   hw/riscv/sifive_u.c            |  7 ++++---
>   hw/riscv/spike.c               |  4 ++--
>   hw/riscv/tt_atlantis.c         |  3 ++-
>   hw/riscv/virt.c                | 17 +++++++++++------
>   hw/riscv/xiangshan_kmh.c       |  6 ++++--
>   12 files changed, 52 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

