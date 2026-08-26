Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F113BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzI7H-0002sq-AN; Wed, 26 Aug 2026 14:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzI7F-0002sE-TO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:12:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzI7D-0004iw-TD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:12:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHImP21572039
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Njo29Y3Aoc1x+z1mPXeK6T4tR9PoICiU2RZ8beUT3Ew=; b=K21TTc7PdJYohWF0
 6K3KYMUbASsrMNlSWvxC1mFS5Oa85uD67QUjuRgsSYtNwBxMWNePIYUkBf84A+es
 m/VtrGvVjse6HT/qOkoVw6pO83oQ3mPTma/jqnOKAF7OPymFTbzcZPTi/4qdYucF
 RfPURa3BB4uIHc5g7rH6Xx8WLSUn+gnFemVl2Ktf3YOGdk3MY/HDRnv0jTOrKxvr
 KV/PiYE/mjP2dt/mGUQMsbD7huNNfnsQouheesq4VzkUdp5C+rhwU/TH+JCWMVnl
 Hqh2P6Vw0ULLKfdABW2uiXSOIovbqSbw27rAmgunQvAmkMuYwUTPtpQtLidMZJHq
 loNRtw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ec86x6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:12:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso22562791cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787767965; x=1788372765; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Njo29Y3Aoc1x+z1mPXeK6T4tR9PoICiU2RZ8beUT3Ew=;
 b=RRVnyfy0go3xFhT86Hl9JhJPSy9s4ZzZRhJNk2S59yS2Z4gc7ERfJkLvyFgdsWcRx2
 wokpH1paB/LHVcPZatH5NpzQ+rf9hYQMcK5mJEPVy3xRUmluGVSIMfFh8t13ITnk8KRB
 mJeLUnn6dsQpv2zwkstdc3StPUpN02/dJpQywks424/ukJbw+nwRES0dJkpuVm/0LRA5
 3HqyP3ZY0WHwH628IHCW73XanKAgH7UtnxdO1OjyHiyg9VX/jcbO4xam0q9IpguxEAB1
 deZgQKKFP+PZ4mUext/Kwds9CRl8qUaoCztO+7BLbA65gphjPy8N0IqJI+tj721zjihu
 bcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767965; x=1788372765;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Njo29Y3Aoc1x+z1mPXeK6T4tR9PoICiU2RZ8beUT3Ew=;
 b=Dk8DxXj6uI9+Upu7uwzP10uwPVQmrr9o2k9b+znsbc7TiJZEbfeTwoK69k+Be+aSBd
 Q5nTnECUQTqlOCBqfnwVwFmtmloRaWpluoyx9D+wqlRkciabaxob2bictv/xP1prJ4mn
 yhXJ6iYlInNuZueCqTyVDNh4qMMIfywVmUyJk3g9wLLAUYnCjnx5l3+/kG7Xn2XhEphm
 r4IdJzbSvNHTXsSnijo26yn5QpNyjnkp/WSiw2L8jyfBejo/LnXNA0bUCgMJ8m4gUae3
 QWkukEzP19ChhEvFDAzy2fn9y8Vi7BkZYUB2/PfZENUvGaiB0wdUodcpMWNOxdwHp1ki
 NBuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrifhjXhbWdN1A1Udef+x5x3VFoqg7t8BRLD3Ar2h803EOKTyzIDB2OO94SUheaM9LAQV/LYv2O+84d@nongnu.org
X-Gm-Message-State: AFuF++mB+iliYnRRo1/ynixaDIwB1er2Fv6utTBrgUGl4nUXLXpeC9M2
 ILVJ/1SzPTaT6lI1P8ys3Y5yqAt8KxrjtJHy9fY2BbzIou8XzUSh3dI+w/lIA3p8Y3m1lmYoaqK
 2sAjheDZ1VSZMAvKWBCynkQP6Yw1WDHDvkLLAcPcMP9ktWqdlOtaKtzmnMw==
X-Gm-Gg: AR+sD113qkF25ILv1laa9Lzls2tgalxx/fPqIrhO4np/a5wo8JX5TMR79XlhB9P2j7J
 mw+Koo3gYetBbkOeRHPQDreSJY7m2YNl+sG/eLaH9c+6Wc5mEZSWu8GLOMvqIisi8kWGCTPW0dy
 8rifPXQeEKg3Kj11co2xWOYgKN4BucSURWRds38WtdzRcdxLDoBCJYaypZ684vfjVahCjDR7JQu
 tTVn06YUG9xOOmtQlhic4QBnNVUxXYploRj+2Vnb3Uu7fW9nmpKXiVTbreMohdQjHbvzpXj5QKP
 rdHLdMkMc0QRC3+92uKHp0LklnRK4m2Mz+D5/Jr4YP+s88Utjz7QehBAvOArSXv080lqj6EdTd/
 qyz2BAJseXJcdVCYDFCHoseH6NjaWk7q9P7ys
X-Received: by 2002:a05:622a:4815:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-52e42472cd1mr101604701cf.39.1787767965032; 
 Wed, 26 Aug 2026 11:12:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4815:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-52e42472cd1mr101603881cf.39.1787767964524; 
 Wed, 26 Aug 2026 11:12:44 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd052c5e1sm12906096d6.24.2026.08.26.11.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:12:44 -0700 (PDT)
Message-ID: <6a2417bc-4508-49e5-baad-636ffebf6968@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:12:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] hw/riscv/fdt-common, virt.c: add
 create_fdt_flash()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-2-daniel.barboza@oss.qualcomm.com>
 <a434a0e7-f603-470a-973c-c1e3334ea200@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a434a0e7-f603-470a-973c-c1e3334ea200@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8f2c9e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=uCxL1PNzozBmIZ4riZkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: IhN_sz1nsJy8KViLN4j85xDinCjuG-wD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MiBTYWx0ZWRfX/gxyM2sITOek
 /wmAH54fW6ekjtEr6Y0z8UoNRFl34m3jSgHrddz1y93CWONMC6p+2FNMxMBrosYb1KjlGyOfYsH
 KVBva4o68OtO3sovt1SKDQNisbEya+bK054bubP1tLaa9Ihf+QhgAKk+vaBhBpIfV2i3K6VWOOH
 /uhSF3xbyfnTxnpE7Rg0u6hs0bnSfd9lBM3qDTbVcmnUAm1BuLs06b/b3bLIEtz5Ud2p12n59r3
 91nbiCwtvn6NB6e7iazKFbquivK5C4tAgUJH/L8LoaqJ2Nk0/5UlfwnHeAEK2/2XP3cE6jmy4rA
 sYTEoTGY0G1/vSfCHPunt04SqhAjau7ezmqsKYuHuYKKOm+egFRRzKGY4unyoeDIc78D40x26OQ
 65mhTFAXNaAxpbL5StJRBZWlZacG7rJ4OMJgqUg590V6tV+0XmShDkMQJ8mLmWaHiV0uI2ah4rV
 H9R2u6z2gxwK8DnQGkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MiBTYWx0ZWRfXwg6TcZf+7OX+
 ceAlli94tp+h31NYHphzFirEmiIGvgoIODrAlSsEBVOhHuolkJHC52VMiv1DSvO9HwDnQbbv5t/
 O1yUKexxgX0GAsJNupaEvdbpw7B3xGI=
X-Proofpoint-GUID: IhN_sz1nsJy8KViLN4j85xDinCjuG-wD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 8/26/2026 2:06 PM, Philippe Mathieu-Daudé wrote:
> On 26/8/26 18:48, Daniel Henrique Barboza wrote:
>> Add a common helper to create a cfi-flash compatible flash subnode.
>>
>> This change only affects the existing 'virt' board for now but it will
>> be used by the future 'riscv-server-ref' board in the future.
>>
>> No FDT changes intended.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/fdt-common.c         | 12 ++++++++++++
>>   hw/riscv/virt.c               | 18 ++----------------
>>   include/hw/riscv/fdt-common.h |  1 +
>>   3 files changed, 15 insertions(+), 16 deletions(-)
> 
> 
>> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
>> index 1729a6abc6..6e438e0278 100644
>> --- a/include/hw/riscv/fdt-common.h
>> +++ b/include/hw/riscv/fdt-common.h
>> @@ -36,4 +36,5 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
>>                        uint32_t cells_size, uint32_t ndev_sources,
>>                        bool numa_enabled, int socket);
>>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>> +void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
> 
> Generic comment for the whole series, if you make this API public then
> please prefix with 'riscv_' to avoid name clashes when linking with
> distinct targets in the future.

Oh .... guess I'll add a pre patch to prepend the existing helpers with "riscv_"
then.

I'll do a v3.  Thx,

Daniel

> 
>>   #endif
> 


