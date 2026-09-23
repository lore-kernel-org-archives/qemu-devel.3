Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3698C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9C9s-0005YY-5v; Tue, 22 Sep 2026 21:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9C9p-0005YO-Mq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:52:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9C9n-0004YZ-Hk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:52:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MJCx5e1166713
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 01:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H8nrMl4+Zo8kEBwn3wOF16nVqHfrwEg3/Ek2+5FpBqE=; b=GT8UI+gOMQ4gIyJi
 AWtM1rnYNePLRKyn99pXAUP/tVISlvk4t6FGBTGabAvYOn5Oz+HcnlUQgdGYpRBG
 vlu9SgtfCDV9+nqo2Lf6Wmo0hAIwQiq4knx26n1QP0F+R1eHL8yO3tVtvvNvBsjV
 DdzKENb0+9INjJt7CrMOhpSXCZ7GIRiD2fgiJ92rKO+mjzhKSgXzaIhnQ9/3C/Jn
 VkLZuxfN/d26lYPqjCPD5eJrhU4j26LCN7EMq+7+W82fu3X9QAiyQrRAWVE2OSdB
 sf76kFNY8oks2p7+LGZSmIDmt7guCxES/D7rLGMwYSrYba6+dx0+W3r/F4tJu9xb
 k5P2Pw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guymw1g5n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 01:52:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530f9b8cd29so10788971cf.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790128339; x=1790733139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H8nrMl4+Zo8kEBwn3wOF16nVqHfrwEg3/Ek2+5FpBqE=;
 b=CfuIdpZxxAxE/TUCRn48b7wvkxbQiUwvlng/ihimgNdEcMfvcvhLNB1ZfdXrnPlWBf
 jnnbyI0z2lEiD8+AgzK1QKU8d9wUX7RpGrbQ3U+LqfhWiE3t/dHI27qabAZFsq73dngR
 qOsUfjrCwNljY4VLlUgkYiuhZG4KNJwNYYPJruUT+BLqZ4Q2ClWa3iKofqZpQrZEljF7
 hPzJweKrLtZCzm80HFKlZsRPVfr7F2K9JMwmeCecweQMuPNZgrZ/EKTET0ukyEzw8BhY
 K8cajja4Nic4kBqEnJQ8Ar4hzRaOZtFkHaz7IXuugpP+o2MiL0cuxCfW3ZP5e1QWavJX
 5glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790128339; x=1790733139;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H8nrMl4+Zo8kEBwn3wOF16nVqHfrwEg3/Ek2+5FpBqE=;
 b=d3wjDF0X3J/o4gx5FYtzebuI6r2iOrAZJwwd2CAjgUJTgdw0e5V+qXzBCQ197fONAh
 9dZQhiyFiMo8hTvps2LjcxxYldOhiBVUM7yH7HrdgSPBSR3MayOsokdKSFbvy7I8Q8SN
 zRfTSLqfVrzMw4mEzCLQvBD08YFr4gI+p1odcqhkDfDnKGAUR7m5j3hylvc99gPTodSQ
 8++9MOQoY5TWAGTjxdpd4xCO9SjtbTvVVD/e3ARw+SpeFlEXHgq+AOt82DiEVkmJZ/b3
 +sKeUBiIaZ5qAJ+wm/T0Z3ofFA9TZNaA+I3rGC63SOnKyhTSAeghKFY5VmPkJJg1ozX+
 /sKA==
X-Gm-Message-State: AFuF++kEn9TmBBoTQQ8Z4ysDSFrW9mewavHUP1M1J/jm4lV/m/eDiy9c
 F+ulXa0adTWM+T5TfuGVonAqFCdftZmCMqHiKKbw/RcIe9FUP/BrKCNKp+F9M03KvdvgEiS3VYq
 a8JiEgZz4Yt3/owzYtz4wVkKtISxIsHBf50KttW9hN08XUw+GH/MwV2Gc7g==
X-Gm-Gg: AYBFou0yzHiVVnN+UK5tX8Kv/myB6N5pPZv+oLRa5nwQtEkVA0oDI/fRlyQLNb7alKH
 J3L9nHWr2lhNJlA7w7hxCJF5/AVfRkyDvHQXspoV64vE8MGR6QHpqJGbfgDfPG4AN3xUwrMvsbI
 MHc4eMw5kz/F7q/WZPOOud3S/jmNrcYfbuplDAprYMhJnMNfmzN8bn+c+5lwhpV303jYwhev8Gv
 zMDwkFMJoTWHSnGqP66kFUDKyUOA2tsgSAJ6S31NcjRVXDUpWyC1lAO+QJJ4y7Q2TvUZclqlAh/
 JPujX8wKhG3ES8h5KUXFSIzrYqEk4wbrDxgPEiVUi/pYWVydkQqnkLCIr+Urv6ZKZM1zQ3dW0mW
 zAxNedhAn6IdQCYbtcPH/UVD2VESqiMw7ec/ddGbaS4G+2smyB7aktwPK3Aob
X-Received: by 2002:a05:622a:2518:b0:532:c2f5:864f with SMTP id
 d75a77b69052e-532eaca0c04mr20584731cf.44.1790128338986; 
 Tue, 22 Sep 2026 18:52:18 -0700 (PDT)
X-Received: by 2002:a05:622a:2518:b0:532:c2f5:864f with SMTP id
 d75a77b69052e-532eaca0c04mr20584601cf.44.1790128338541; 
 Tue, 22 Sep 2026 18:52:18 -0700 (PDT)
Received: from [10.248.104.162] (136.sub-174-237-82.myvzw.com.
 [174.237.82.136]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ead2226bsm10458761cf.0.2026.09.22.18.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 18:52:17 -0700 (PDT)
Message-ID: <4f66ee58-7089-49ad-b839-e44a54bda86a@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 20:52:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/hexagon: add directory semihosting
 operations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
 <20260914223159.2735262-5-brian.cain@oss.qualcomm.com>
 <CAFEAcA-BeCMPhvHLG6Jkz9q68ZJUN36diepWvEbhN-+RxZtVQw@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-BeCMPhvHLG6Jkz9q68ZJUN36diepWvEbhN-+RxZtVQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNyBTYWx0ZWRfXzBYkXtc9+8Vq
 6Jk2KvZF8W2yTA1spzlgJ/FXkZQfYCSVPvg8I9SfbNRDGS+t+p9Hb4hxG3tLTsJE9KpG205EEdC
 3wYlSJrdDQDs/JbRy9gI0yBu9njxjuiLcv+hRmnWLYdUWBcfQ1ZhTfJbDBlgL4Y5dHgmu3c2m2P
 jZl8uu91yiZAM8m+WCHzzozD6j1NTab52eoxkd0WoDczu9w6YRzpLF/D/5R7KJHP3B3ioMaT4LO
 VhYCqCcf85lZeITHh9pkHlutGYZfbi/flh7gWl7tgb88SEtsezlbfGY+OvrUi8hI9p685sqgIu9
 RbQnoYfrpR8BLqsj97xsU3x73RenkxkcI7BZopa1KSetyeuV4PhB9wMH5Sz1fXo11vzKqIIkcv2
 O3U/HYCK4C5oByn6UC2LR65ifX4XbwfA/hMlRPIvSPkVAq3gLYXan0rH4kfncI/6oLLg0zViH1u
 gDazpLnnteYOAa7bNWA==
X-Authority-Analysis: v=2.4 cv=feI4WEQF c=1 sm=1 tr=0 ts=6ab330d4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=9PLFPpoJQzO8A2hTliJUZw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aRaKHnVUrTxTMw3V01sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: P4b4kFLNcigK13g3aVP5mVjjUgU3edIN
X-Proofpoint-ORIG-GUID: P4b4kFLNcigK13g3aVP5mVjjUgU3edIN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNyBTYWx0ZWRfXzoFYjkPRDqH+
 fl20+DfsfFxbyJHtFow6TwwQ6EzFxFBmTirNaZIKnZnyp3YHiPB2obtYkI4Phc/7bVQ55S1d2PC
 EBxyV4qdzYHaSeK/hFNLylLmOFMZtEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/15/2026 8:07 AM, Peter Maydell wrote:
> On Mon, 14 Sept 2026 at 23:32, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>>
>> Bare-metal Hexagon programs use OPENDIR, READDIR, and CLOSEDIR
>> semihosting calls to enumerate host directories. Directory handles are shared
>> by CPUs in a cluster, allowing guest indices to resolve across calls.
>>
>> Use lock_user_string()/unlock_user() to read the OPENDIR path from guest
>> memory instead of copying it into a fixed-size buffer.
>>
>> CLOSEDIR clears its slot in the directory list, so a stale index reports
>> EBADF instead of dereferencing a freed pointer.
>>
>> Also add a functional test for the new semihosting operations.
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon.h              |  14 ++-
>>   hw/hexagon/hex-subsys.c                   |  32 ++++---
>>   target/hexagon/hexswi.c                   | 108 ++++++++++++++++++++++
>>   tests/functional/hexagon/test_systests.py |  11 +++
>>   4 files changed, 153 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
>> index 62398eeb359..58bdcabe87e 100644
>> --- a/include/hw/hexagon/hexagon.h
>> +++ b/include/hw/hexagon/hexagon.h
>> @@ -11,6 +11,7 @@
>>
>>   #include "system/memory.h"
>>   #include "hw/core/boards.h"
>> +#include "hw/cpu/cluster.h"
>>
>>   struct hexagon_board_boot_info {
>>       uint64_t ram_size;
>> @@ -159,6 +160,17 @@ struct hexagon_machine_config {
>>       union hexagon_config_table cfgtable;
>>   };
>>
>> +#define TYPE_HEXAGON_CLUSTER_STATE "hexagon-cluster-state"
>> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonClusterState, HEXAGON_CLUSTER_STATE)
>> +
>> +struct HexagonClusterState {
>> +    CPUClusterState parent_obj;
>> +
>> +    struct {
>> +        GList *dir_list;
>> +    } semihosting;
>> +};
> This looks very odd. Why do we need to track open directory handles
> in this special per-cluster structure, but we don't need to do
> that for e.g. open file handles returned by SYS_OPEN ? I can't
> see anything in the semihosting specification that indicates
> that SYS_OPENDIR has special behaviour like that.

Here's where it was previously discussed:

https://lore.kernel.org/qemu-devel/9823f67f-bfc6-40e2-ba3e-cb02e53a4004@oss.qualcomm.com/

It's my understanding that unlike with file descriptors, we can't have a 
host-portable way to provide directory entries spanning distinct 
semihosting calls without keeping state like this.  If all host OSs kept 
this state, we wouldn't need to.


>
> thanks
> -- PMM

