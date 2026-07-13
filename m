Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E55BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEPM-0006rK-EG; Mon, 13 Jul 2026 07:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEPI-0006q9-8I
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:01:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEPE-000588-Ds
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:01:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9MDVH1090738
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHLYgZXx4F2EiEl94pL3Y/ifs4akldbpnxStmfbCiOc=; b=bNUyM3Bv/Kx49TO+
 qijMulbymgBfiHfDesxBSSRZZQLaLSQbQW0BEkHgzuXoNsReJiwML/UbY60Xbham
 /D3UQSCsEpedd3umRWyiG2spbtkiXEV/kHo87dLy/YCAprQVGPHYdj0OhN57TMg4
 Ey58YoQwc5UTSnj9nh/kWu/6QtOXjXqYmnzWjbvrJTj8J2E5E/9Vx3QS8bPoUvr6
 99l4I3oalYrtXxYOaAQhcx5oPpKGQNX1UlBfU3UNmkqI9DXusl67a7IAkxkIhcW/
 SJu+jf0YVv2rnKpyPnStGWie+8ZSFSIxBzVc8nR9ATZdklYYCr1x6tF2tbbaZm9r
 /+A5uw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrbew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:00:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so60164281cf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783940457; x=1784545257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QHLYgZXx4F2EiEl94pL3Y/ifs4akldbpnxStmfbCiOc=;
 b=jR0R2zDrRoU06WKfKBT2m+UcU0hyUonoJyAtNblOY7Sh2CuEwRpsPfTposqHL2zlvF
 l2dPnoE5MFcnWgacMN5bKGjmTMDeIfmUwUNYsT/0cV2+cI8PsD1yv4M2GCEBZY2VNHO4
 D2duWmodAPEeIvmgO4fKMDl9cKcfCllSLvsBDj1gxNoS9cQvUEd6ibiviUTzDWZ+i5TW
 uZNAT0YToW1RaFJ2MRoqlGen9/Q8BAZmIb7TCCtFCutXUmvzfH881BvgDK3LiIKqp0hS
 It3qQp75XWSrdNuJYP6ESf71Cw2ShbxFdm2oNKGcV7/CakSkQuFrCGank5Fk1n4pKxCf
 SUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940457; x=1784545257;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHLYgZXx4F2EiEl94pL3Y/ifs4akldbpnxStmfbCiOc=;
 b=SVd2bg+UDMIMSUO8q5+PhkX7MtTYwUvu+ianEXNsBd7tNRjHCtpihxO8sKEcWd1pbO
 wm3D8uYCcRiNJKAaYsOHsLP0Vgtb+/G/69RvT6Cy66H/R2xfEtKBfPXjQ9TI4h7WQ8Ba
 +v6gbMPodLnx0gOjZNv7vTJc4wo0Myt2jtUI9ighNKPGaYnobbdyEh0GBYIkLVsp5Jht
 gzpqM8BFDtvdv8kF+EOXyQ+QHxa8epbZFOqOG5C9JrEgrmpwGgy13QchnGZckIx8esTQ
 np4YnZOe+WZj1Qm9x8Ems/nWQVfzeZZDmdSbQsyKbL0kgW4X3rj2cfsrzarKizxCHGrm
 tJGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkgaZDn8Lpe+0XkJazAFN7+EPa7s0U1dBpA8nqTLvt9/TWSclQL56V1HXcTk7tEK3n645007VRMs08@nongnu.org
X-Gm-Message-State: AOJu0YzSUgmj38GoFu+0lqH5IvzJTwdHc9/lZSugkYQopDoMYbnczppa
 56EY8We9GE8X8+8mb6CuAWbkaCu5hiwT22gM29QxosqtRT5FejBEXTn3jNS0nu0QIgp36P+/Ap4
 rjB8S5bUVEimMzTzaUXNliRS/atgrJTupC2HXcK0juT2YRvzj8en3iPzUyQ==
X-Gm-Gg: AfdE7cn/Tos9ia4fQl9sD/9t5P68b9DiGcJLcSnAJQo4945wTJvuIvH1Q139NC1lQEa
 /mrZPEiKRbk6m8c/1IxaRGjc1bo4mi+xeuEHvSwheTHB98eKTxyMIcdo3G7s5JyXarWID2O6/eA
 m5RYJVWuRu1otFu+bazJHwJAHBfpaweYjItl7o6ecW/XEqL+UTO7+E1Pe+vDYp/6+Dzkd20UWgE
 PWIxzB/lILnO/fmcO58eVfTzjtubkv25qTrfbhma7xYsMWgLQ2B6eky1AgF2ePOQ9TzI1lxqUiP
 hPZd8KO1XC8LN2oiDUpl8Qpc+h6X6Lz52xcntLSh2RK68LizcKVY98ibQHlz6BbUgljDycIqf60
 tI+654Z6t4/7qvrNHWrU5+UrhbgnWab8/qnkePa6iTpKPWtrUTGP5/5Y3CYmFRg==
X-Received: by 2002:a05:622a:4885:b0:51c:120a:91c1 with SMTP id
 d75a77b69052e-51cbf0df51fmr83474711cf.17.1783940456884; 
 Mon, 13 Jul 2026 04:00:56 -0700 (PDT)
X-Received: by 2002:a05:622a:4885:b0:51c:120a:91c1 with SMTP id
 d75a77b69052e-51cbf0df51fmr83474001cf.17.1783940456257; 
 Mon, 13 Jul 2026 04:00:56 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69acd1d32c6sm7635535a12.31.2026.07.13.04.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:00:55 -0700 (PDT)
Message-ID: <36a1713e-7e20-4ec5-a4c0-61dca348d72e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/dma/soc_dma: Use physical_memory_map() for mem2mem
 transfers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105907.2570621-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yFbcl4C1V_-iIAJYYoRiyCDpcnJmTSpc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNCBTYWx0ZWRfXzfeFvT4Im4kx
 szL6vghnthSC7XZ78McrbdWqmqaKzOP9UwrN939Zvq83p6l56wJcHsC7UM5Hrrm7O1P+HdrY6px
 3vMtuEcIcmqABvGiLIKCClO8fSXZ5CrN078Kjg5wJEqQQQF9vEwvDfBrNo6xyv5Fx7dXwFUHZNg
 OMCzJd2WyLI15Ef/FfIr0+Da1sD0ENGfBzItG3YcIimt9H0DHJEcaak0OVTVgRqcdqXOLylo1RE
 l7LMqfREEqEQuUCO+WCFERq/FNtu+OTCHRM9Fcikl3uidBZ3see6VTxe6PvWX8dxlBWnNGA2DZe
 Rfec0wjwlQaxJMqGxvTd/0zE2WeVdqyxouK/qUUL5qEu9p3Hdj8XuQ3Fh/3+LMmRizASP58sbbi
 5B8TkKxwU5muk+sylHExsIsWMkHiex9E4f+fwUzg/x9kJMxgnHqv05Rw5f9Y2FuuJ1VeXykQ2so
 Q+ZZH3cJ5sEQwwnYMtw==
X-Proofpoint-ORIG-GUID: yFbcl4C1V_-iIAJYYoRiyCDpcnJmTSpc
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54c56a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ds-11klTjMdCq2ka3PUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNCBTYWx0ZWRfX58fpEAR4HpOB
 h3XjqNeSkZmz+nyQ0M8yPV9aX8OOv/ThTsHlatTqXRnSWMnjc/EooRQP14KMJlJVDCbqEzxGa8q
 tBSbBFO7EBE1lD1fh9sLpxMQMbdUGKc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 12:59, Peter Maydell wrote:
> The soc_dma code has a fastpath for when DMA transfers are from RAM
> to RAM.  The current implementation of this has the caller of
> soc_dma_port_add_mem() pass the underlying host address of the RAM
> block that the DMA port is connected to (obtained via
> memory_region_get_ram_ptr()).  Then the actual transfer function does
> a simple memcpy(). This has several problems.
> 
> Most importantly, no bounds checking is done on the address and size
> passed by the guest, so the memcpy source and destination might be
> outside the backing host RAM entirely.  Secondly, because the DMA
> access is done via this back door, there is no updating of the dirty
> region when memory is written this way (there is a TODO comment
> in omap_dma.c noting this).
> 
> Fix both of these by making the memory to memory transfer function
> use physical_memory_map() to get the host addresses for the memory
> copy.  That function will automatically give us the bounds check that
> we want and return a short length if the transfer would run off the
> end of the RAM MemoryRegion it starts in.  Since the OMAP DMA
> documentation states that it's a guest error to misprogram the
> addresses so that they fall outside the range that is valid for the
> particular DMA port being addressed and that this can result in guest
> memory corruption , we don't need to loop for short transfers, but
> can simply log them and continue.
> 
> Note that we don't need to update addresses or bytecount here in the
> transfer function, because when soc_dma_ch_update() selects
> transfer_mem2mem it also sets ch->update to 1, which tells the
> omap_dma_transfer_setup() code that it is responsible for updating
> all the guest visible fields to match "transfer completed".
> 
> (We use physical_memory_map() here to match the use of
> physical_memory_read() and physical_memory_write() in omap_dma.c;
> making the DMA controller use an explicit AddressSpace would be
> a separate cleanup task.)
> 
> Together with the preceding commits that fixed some integer overflow
> problems, this fixes the "guest can provoke a bad memcpy() operation"
> reported in issue #3204.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3204
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c |  5 -----
>   hw/dma/soc_dma.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 48 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

