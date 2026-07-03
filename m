Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8748AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTf8-00086W-2X; Thu, 02 Jul 2026 22:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTf3-00084r-1Y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:29:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTf0-00033N-Nc
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:29:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319s532355724
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 02:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8AUUgL2Ga707R8P695pB0ZXTJUdV3wBCfxA2wPZFmro=; b=jtgBfnE4kDBYmHMZ
 MyvJ+DOTNXk/79QXDumZJ54VgdZas0vPG+YS2FT9+QTprj8P0lvp7g7ljKFWBwfV
 c6Iuym9zlQfeXxBJLYymeWo6yCeOQd3YwNUeUCN+d7ft00Q0fVG8Yn+VOq68Lej4
 +Omlc1jGjb7szV/ja+f2TCt1bNL63Ajnc/eyukVuJjzXpvolxKqa9tKTZVAGt1TJ
 x5gF1VGw6FFPZj3mF0cRGkSL3Od2fCsbOB63J/u9kpswAADWTqcdwpJdHKB4nH8B
 WEGO2RlfIz2YijjEytpyc7jQ6MacGpne1DjukvzLyshBpXRxy7sRecwtkQeueGTh
 anHGjg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnj3pu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:29:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ef8249f73fso1142636d6.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783045784; x=1783650584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8AUUgL2Ga707R8P695pB0ZXTJUdV3wBCfxA2wPZFmro=;
 b=LugKstB43B8hIix4aunvVOIpe7+MFZLbTqsPlhBGw8MGsjJoN9Bn2RzAdML/5SeBa+
 YStAgfWrOc+qGlOVgGrpbCPbpyoJ+ExnU2UQHFhoN+Nt+wzSiBW7yd7uM8MfmJitbN47
 wYGrEbHEpOGZmrZHt1eBAlsYereBToL8aHjSWVn7bXBVWf2zRtJH+NuHowhRm38ebcmR
 m5ct+PBm6ohX8PgKziVyxxfe3ojRwkHJ4IZxmO0P2GtFJoL5RdUzSO9sAU97q3BfmV5C
 LP2+DU6B2wz2j2Oa2zE7XWqqGnDKHjxz/9pNNhjL2P9wG76OfYBTCQM8nbAOFOfJeArx
 Vpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783045784; x=1783650584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AUUgL2Ga707R8P695pB0ZXTJUdV3wBCfxA2wPZFmro=;
 b=iqFDrbQ+0MSNb+8noQBhJ3C1HK8rppU/AAkSQTOWFJP2J7kp7x8j6kIr+5JmcRdcJI
 DbjDy3EoGEZuxwajWWj9BIJyEAwGSGkTDEo8tB5uTNG0gTDA6DCTtSrxps+m3Mc5RrEG
 hZ4EZQjKAdVs/9g4knLCneVHAZWRg2x94etqoc0I6rwdNGsM67frjjOa5saTn4Am8NHK
 EVaoeAD3a6/n2EtvyuJjMnxcNd+0rvnAgKNeglrFqyy2H+LUYyvNZ6GyZ2AONkPhRL3s
 zydv6skQ8mY7xjIwD9glVzS8TtP2//uI1Ppv9m15J8loT92UfiZT2V/4r4nn41aqyFTm
 lyVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wIX63yX/jHGG/wUpFsaDwxm7CVjqHREFBJEcs1Hk1Kt4rS9XMU7Im2HzLvW+yDsyPcjisvWYl8WQJ@nongnu.org
X-Gm-Message-State: AOJu0YzzT5ROczjmsVqakgWWs1elw/PRQkW1ZW4AFCuAo8xz4l3idVtx
 p4CF2+CSkmkCDy7rEe5njKn+KYb6HT96Ixlv6vfSvjpNVHZNih8pqHVOk7UlsQu8OR0i5aD53UI
 YsHBbVN1wLpv/ivYgCZXHZEzwXd9XEvTe3VsLgSMT2wmx3Y5CbX2/iCUhUw==
X-Gm-Gg: AfdE7cnpsJUN5JgyKKdGy8VO/5PIdKNwF+XDM9CbfKOwKqvW1f3Gtw/BS7S8tmDhj+0
 Fy1ujXQuSzy9zSDU+VtDBJRIXzeUKwwIIgaVuo/owe/u8BXlNpDdBAe6XfL3KBLQ37n71Wyufdh
 PuS/+bH0kSyn7fWpS/HhjtJzppFxJDoiz4SiQrECDUu0etDfBujlnAtpJLU0aTu3xybp2zjiGM3
 oDLYbsPOTOWmUACdUDk0SME0rEA5eUO1z5jFy+RKGF0GRRccrZuIcGWUxPKvRchl+ytw0HeKPD1
 I8ve68l4y5tHueEpzAL7G4Nvml24zy95Sy6jpD03lr0KEbURhhBpm3/255blVqtcoQfrnrUAfXS
 kTGd8Wd6ds8tbGlzyOq+/qA9vxG6JVXhZovE7+wQbAyP4JYeMg92D0womT+I9aw==
X-Received: by 2002:a05:620a:2255:20b0:92e:7cd3:e5ee with SMTP id
 af79cd13be357-92e7cd3e8b3mr769900685a.11.1783045783898; 
 Thu, 02 Jul 2026 19:29:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2255:20b0:92e:7cd3:e5ee with SMTP id
 af79cd13be357-92e7cd3e8b3mr769897685a.11.1783045782758; 
 Thu, 02 Jul 2026 19:29:42 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477de3dc77bsm14546551f8f.33.2026.07.02.19.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 19:29:42 -0700 (PDT)
Message-ID: <1909bdce-cdcb-4cb0-96d8-fc23d2505923@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 04:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/34] target/arm: Update contiguous first-fault and
 no-fault loads
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
 <20200511133405.5275-22-peter.maydell@linaro.org>
 <e9cdc625-7ded-4678-965a-a98f18150ade@oss.qualcomm.com>
 <58d000af-4213-4600-83ec-e418ac8682b8@linaro.org>
 <8c5eb29b-57df-46cf-8678-36182e052afe@oss.qualcomm.com>
 <529683c4-db23-44c7-a4e9-6149ac2e9ea2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <529683c4-db23-44c7-a4e9-6149ac2e9ea2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 48rrbHUx98JCgxu-d6o0S7eLOmcTvDT5
X-Proofpoint-ORIG-GUID: 48rrbHUx98JCgxu-d6o0S7eLOmcTvDT5
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a471e98 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=2RjDIrC2Lu3Pek01wscA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMiBTYWx0ZWRfX6cz7zV+sSvQk
 wHap/poKPLS+5OuMw21kzVdUVnb0SoANMOUOFMO/4ueNwDoqDfn0SdqFZ+RJjVD/DvPmG3fcFLJ
 GU95be2E9SIuz1HjnVmJ1nxGFJT5ImE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMiBTYWx0ZWRfXxumU6XxwD9jN
 toA60tmwY3H1c+mFHE9/hJVuqF7Mg0tMe7+0IJ2+X2Wg52dGziNTAGq0KoktPEGzVakja9CVhbr
 jlnz7malvdPUiHLQazH6bcvX6SqUoDm0LFPEOxYCQYed57VYGvhFNsQ+tP94Zl9CjocpbLO64El
 eP5sIERp1Sy2LuvXMU1xdl2tWTbwAYZOqg1OJLmAc+c4U+yJbmi3a6NUMqeNeTk4gkPvPJMnplv
 Qq2JDoWiwaWU4TlnMBku73G+S5eV71krTXu95Hgz4un1TGBefIxV/QSU1xU7ol9BEOtKk3V2nCp
 d9RRB+fDtgOfOAFsp0Gxnp1OSHk7/8rhgqtTwTeCfcLqMx0bB1SNMi1ze5aNq349ODd/J2BkWs5
 DuG084UhYBIsmMJXkBuxzG0paLB1ACxrJXAWboT8zMIPpQqiF9OhaupwsdLWXlgGIQxAuU+WlK3
 FxtXqdKKJ2mNLYN+BKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030022
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

On 2/7/26 18:05, Richard Henderson wrote:
> On 7/1/26 07:08, Philippe Mathieu-Daudé wrote:
>> Sorry for not being clear enough, I meant the TLB_MMIO & TLB_WATCHPOINT
>> checks just after:
>>
>> +            /* The first active element crosses a page boundary. */
>> +            flags |= info.page[1].flags;
>> +            if (unlikely(flags & TLB_MMIO)) {
>> +                /* Some page is MMIO, see below. */
>> +                goto do_fault;
>> +            }
>> +            if (unlikely(flags & TLB_WATCHPOINT) &&
>> +                (cpu_watchpoint_address_matches
>> +                 (env_cpu(env), addr + mem_off, 1 << msz)
>> +                 & BP_MEM_READ)) {
>> +                /* Watchpoint hit, see below. */
>> +                goto do_fault;
>> +            }
> 
> We still have TLB_WATCHPOINT == 0 for user-only, so that won't actually 
> fire.
> 
> We set TLB_MMIO to non-zero for user-only in 6d03226b422 so that we 
> could force slow paths for plugins.  These days we should probably 
> rearrange things so that TLB_FORCE_SLOW is used for that instead, and 
> make TLB_MMIO be 0 again.

OK. I'm still stuck by this function complexity, and have the
feeling some of this should be handled at the lower mte_probe()
level (maybe extending it) up to allocation_tag_mem_probe() which
is clearer. But I have no expertise here so my comments might be
non-sense, no offense :)

> 
> 
> r~
> 
> 
> 
>> +            /* TODO: MTE check. */
>> +            /*
>> +             * Use the slow path for cross-page handling.
>> +             * This is RAM, without a watchpoint, and will not trap.
>> +             */
>> +            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
>> +            goto second_page;
>>            }
>>        }
> 
> 


