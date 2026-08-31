Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9F2C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uN8-0001b4-N4; Mon, 31 Aug 2026 01:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uN7-0001aQ-9m
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:15:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uN5-0007Yd-Qw
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:15:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V53LFS3028624
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4abdHuCghocnmQou+IWzJfYizbkIW9tksfED/BxXfuM=; b=LC1cixDmq9sqqXuN
 DmChHOLlU8RSDZ/bM/YlvABFOCAIzakNmS0EZtbB2mxzg3wNwYUKEA1R5kuaz/v/
 4Qrvz6BeTDNpOOBdSU68SM/rvhIN6dkPUpPJ4bEvtHAIneaCfvN4GMHOOvZrsBS7
 B+EM5sugyYNJ1tEyNvraf4rbFKTNMK2MCqNAp5P0of/kO7M2ZEEr9joLxRVZSrrt
 qlTiac3EfNEYPZGFdjo6YPRgOSgoqJlVk3I5AoLCj52xMaoWzAeF673GOBls2yfU
 WvsUGGOQdDdNpMsUla1UsHXe1mGYeMs/ZPrzQPAmqeHrUuVvwgGAcHP44Worib0S
 wTY4ig==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqdvmndg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:15:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e53b8a302so412081685a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788153350; x=1788758150; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4abdHuCghocnmQou+IWzJfYizbkIW9tksfED/BxXfuM=;
 b=H6SmmU9+j9ycI8qWV9ikixDT/wbkoJj+bNwJorUFvhkLrG+fAedSIR45Sz5J+4OeWE
 m60XJKpd+cWgRQOPdW+hNyeKLk6u1lZeW++6xDdE39wxjJLeQMHgboByYC4zzVkd0Slj
 Z04bosSXRpdVZL/Shly5uy7pjwQQomB451EUyNFnNuwGcH5CPizlfLwjPiZwATsKRfHf
 ZkEvVKh9ZcLbnp2U7BEfR/+XgTD/UfPVtwrQp9ek3kU8ZEDNPkBfh/wbcmHEgbP/QHmQ
 PG/WoW34a0Y3AsxCFSGTPKj/M1xURKm25KSAoCfTZJ0w5rhwA4ZSPcwQJEOc5Jc7PCDh
 KzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788153350; x=1788758150;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4abdHuCghocnmQou+IWzJfYizbkIW9tksfED/BxXfuM=;
 b=UuTSycOZLUjTQamc9xhrnmb6XYmDtaLvlBu1jOQ/jlkM/pV9bot5ahIEF207u7s4lT
 8g095+Mqtt9zlK4xtzNrKnLG4ewyBGyPOGKCPwKHI0dbjzvDUbOKgwqumm7l6pkI9FSj
 0SMQ7AtUvKCCcOzf2ho0oJqMjn+x5iSJ2/8p+rvsLlhftYrC416qyLtZY5yZHVqWUBlS
 dsWmES9mjgZE9D800Rgfpp9dWUgMoNAXa9ODECTVTT+PKtLEgoqbvDMAE9tXCmXgsAO8
 vQyFJNSsKdcDGvYfGTUMbcLIp4gzWQbmXL2dexHyidGsJP4ueRWrfpF8vpVXsiVpoGud
 +MoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RouMLIC+VTkgLsmWCuVjL8DEfNi0R4lLn45QZ+urkhmISMI6aI1bpqwMqlypw1aBcjtm6XR0iPVgxS+@nongnu.org
X-Gm-Message-State: AFuF++k2TkZnzfy3cohgPuanWD6AZ3eJxmUu5iO2w09pUIZwTuPLH/HK
 cYVSeie+DY4OUNZYsZAdp3UwNkj8pCWnM5YUt+6E/qLqEXm5UOdNggwaHfeH7itz6RSFaJuZsRK
 4O2K7Td8E3J9yjgVhMJF5bGa8fMZ1jkUI/Plj2sD3GR1MzqZTcXun9Dtkuw==
X-Gm-Gg: AR+sD11rWEM9lFRK1qH+pkKyWOysxUYvRUDMdfCxGsBP/Rcno+FbDwVfvxy5Mder/eq
 zzYprU6YWLvCwe9pVJ+S0MrQfsRpC1e3TpMOMVKxM0rEmDf+5YCecWQEIZjCvhmS9aP3sfkftPO
 IdMMnljm8XzX5l5W829y4VLL/U3UL7gCJTvBtGC4zRTpmBkrqC/szdgczXxowf1m64Fs97QiZhx
 egYJhetKwajCR6jYAgULpBlNWbSM/+0iWnrqOB2NSuzybrXUGYMYS6gC7FC1aHtpJZoEI3Z9f/g
 dDK7L//DZ7nuILmin5pQn+PL4y18M1MuYiMGlBBUKKczeZcVDUPR2CAfABNHN5v+jMGcKnoSEz2
 McbSDZMOx0qWhmtOFtSpP+3cjVAJiIGVwuA==
X-Received: by 2002:a05:620a:f04:b0:92e:6a33:7118 with SMTP id
 af79cd13be357-939138df202mr2468637485a.30.1788153350061; 
 Sun, 30 Aug 2026 22:15:50 -0700 (PDT)
X-Received: by 2002:a05:620a:f04:b0:92e:6a33:7118 with SMTP id
 af79cd13be357-939138df202mr2468633185a.30.1788153349607; 
 Sun, 30 Aug 2026 22:15:49 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm20953325f8f.25.2026.08.30.22.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:15:48 -0700 (PDT)
Message-ID: <3107fb38-5319-468f-8dfb-91b8364ae584@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] hw/riscv/atlantis: Decouple RAM size from
 MachineState
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
 <20260831021500.82565-13-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-13-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z70q_L2jt5-jaKofwDPdFP_4Vq5dwRw9
X-Authority-Analysis: v=2.4 cv=P6EKQCAu c=1 sm=1 tr=0 ts=6a950e06 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MiBTYWx0ZWRfX55jTmteaqG02
 kr8160hqK5YIOFd35c9bL32KJgiIJK9wqtgqvqIM8b4f1m6yKhYwLXpgrqRL/EZXGvzvla2i4NT
 W9RKlf3VB/Kv64fOAqWp+GLqfzZAh5fHkU2iNSZWDGgTicfkAuKMyf9bUsnGPemExUsp1GHDg7j
 KjkXfTvFve/TN3ISsJkt/PM/+MNeYWrL826TLnUkT9Oe6yXe7K2ZotdggyyjDIIBMLhhBoTOyxf
 qvroZG4v7JmtgKUZ7Ov2rloCaCnPzqRFNlIAW+YuzN3JWQQlC0NjAMaohQrJnCUqvCKtT0bhE0F
 1NZ53RtosHq7gKl+1WBKdmzMi0VSTVLPu1ZFQLPYOXEF+x3Z5rhOz7OGNgn9zp2dhhqGNNlipEx
 gsDNOlsxQqAmSetXcjTBDxUnoTVq/DWlim3rm5KJopVSVn/EqnbqXlA4JaLFJazlNfIOKuFH8QL
 X72Y0rbyaDnvqGXiVPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MiBTYWx0ZWRfXwcy4waDqefH7
 yaIJSi5mR814Pw8pxfzbSJP44fdLbO1lxM6F8yjYFa3NCnbQ5posgiuf41Sm3+B1+C1HMwijWI+
 ZTtg5PRvfj5E+nJRwNYH5VV81IrXY2k=
X-Proofpoint-ORIG-GUID: z70q_L2jt5-jaKofwDPdFP_4Vq5dwRw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310042
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
> Keep a reference to the machine's RAM MemoryRegion in TTAtlantisState,
> and get the MemoryRegion's size where the configured RAM size is
> required.
> 
> This allows reading the RAM size without needing a pointer to
> MachineState, decoupling the memory layout setup from the machine.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/tt_atlantis.h |  1 +
>   hw/riscv/tt_atlantis.c         | 20 ++++++++++++--------
>   2 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

