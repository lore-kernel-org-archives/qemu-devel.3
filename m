Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B085606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HwmvPuhG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T+rEQrbv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFFX-0007Ec-BV; Sat, 14 Nov 2026 10:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFFV-0007Dt-BB
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 10:01:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFFT-0006sC-8C
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 10:01:01 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDk7Th116906
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 15:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TuZ1lADLudsv9paVcQNbKAgP/WLIu2xert64WzH5dRI=; b=HwmvPuhGeWWOw4rX
 R9jhvkYFvc2Sz3WFKFKdbThBE2rv1Sl8L8OQfuzJcEh9sh29VtpFjafauYoMSvgJ
 hp8tYclC/ECVSll8VgaNK8VypHJdkZfDLHZLJaOioAWGsG5QVzkPINck15y9XHhc
 CM83JTEmfc5HfWsoymzL+nS+SxPA6zs2+I4ecwbdu8miJZHfnyutjv7fXPqHh+IH
 /ojf/ZKNnAjjiqEqCJ5y1JfhcHdYMC3B5C/NmhHgWh7ypIxTnOZQukxK6+3gpW7c
 aW5P4t8XQ23YPvmJ8BT4zT/iJHFpYS36w0N6Wys7+PiNl5QAPotjOYWhFogGM2px
 9Mjatg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqh23p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 15:00:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdb8b260bb4so985851a12.2
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794668455; x=1795273255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TuZ1lADLudsv9paVcQNbKAgP/WLIu2xert64WzH5dRI=;
 b=T+rEQrbvfk0XSIFtzDAuIOxifwcRpQCdV2hGFetmckjUeYAJsxyTiKzzMZRDrmosXB
 BacFTHdfJJP63pKBkfcFSdeLZPrSYoq0yWxz2rZBpUmORE+7rjRR78oPbIe+TegybS0a
 uWSfqgRc3csF9jLi3dR9ufuUlfiFldRuznUVAnvCxIrdJjRkvt6noO1GtdEaJ7p0YdP2
 8DeOT2jDs+SHioN0WcqHA3lQB/kxF750n5zEoOesbgvwmdLqnod9bgNpEfSHfsbcq++P
 brGy3QuI/Epx3N+CQdVHJiunN5+3ZAz3u3JyDCoksVw08UGDTUhPm4niUekSB5RF8qYN
 710A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668455; x=1795273255;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TuZ1lADLudsv9paVcQNbKAgP/WLIu2xert64WzH5dRI=;
 b=imuisEX8zjHQ92FVdDz8GbIXXV5LAWOPlX4OCxuwijzWH6WSvsvdbphI9iHhB0bwE+
 9eU7tBrK4ALoYYzCg/ysVa+mtLHUm8K2BY/Ms4qUdOK5Xyyq6xYSPGEkGcuE0RDiWq94
 1QL6jaBJgtNmiNJu8VrO1iEKLRNDbRIkWmUzKMC34u5w6+4M6uweuIY3LZrM66+zn06l
 ajFHNWbVr2BcI/KfBWADN4XmhmZ0exJ/Vnu0jVoIk88kXIdiuLAH0DepxOQKTHIWGMTr
 0yqjlMbcf8Be+cQSE026tlu71Uy7e+r90ttcvB+OsO9y45HCznK3/blKp75g6OU6/eDN
 cNgA==
X-Forwarded-Encrypted: i=1;
 AL+hErHRCd51aCSrt3OBuRSrfD7mRYogeN7fTnXeT3ZJZ1dt3LR29uHqkApXNtqGgyXI/YhCRzCS+h5Vm/iU@nongnu.org
X-Gm-Message-State: APuU4Z+bKe2c/EzHmFuE04n5G1AvZFLneF2lrbH/BIX1ukuB3d6kZyZb
 vZ2ySU/UL2W7iYUICDa8PPY4MztlsZZ3BAr4p53myzdr54mJh5FCMVDEOVbeDigDYxEBh5+yTAs
 MRQSXEzTDz8lOa3BzBKZAIirXgQp3huRs7O58fom1sJLOiVpeBJUpJTeAtg==
X-Gm-Gg: AYBFou0ZohXI/M4vqdFHT1Bu3trgD1IeGAyLg21y59aOm6yPO44W2CLjAyvxteFKSxH
 ZscMkbupYr90DMsXXKzMPWayVyhaBsTPxPn7AO3z/N2nf62qZgWWqV+S3wA0Mu12JnWa8yF7FPo
 YNF2fKx+YWfd98FfgwqH6hWTPkHZ014rGDMBy/Ybk/7uf+P8aN7lNsjTRjVY8SupS0wZKojmq6V
 iX82wvMtRfhdG6wqlud744/NHo3LhFwnEp1FZiHQ9PcXs8iEQ33UTsCl8ufKrgAYRqnKLVS66V+
 VaM4j+61pRa6cY8OmgCa41Ls3oTDCKu8gZt+JFpkq6+TpZUvacVs3IlCrJhgSwWsif2PjmgicIs
 HyUC+4F7RgPUhqvmN8CJLHXECmdUCcQ1N6fDfONib3F3f1WvyAYD8iFh8GGxjTltkSDY61Td3fx
 N9A+reNxThC1pJChY=
X-Received: by 2002:a17:90b:48c3:b0:3b0:b36b:66fc with SMTP id
 98e67ed59e1d1-3b1b0cac932mr5643436a91.63.1794668455038; 
 Sat, 14 Nov 2026 07:00:55 -0800 (PST)
X-Received: by 2002:a17:90b:48c3:b0:3b0:b36b:66fc with SMTP id
 98e67ed59e1d1-3b1b0cac932mr5643364a91.63.1794668453983; 
 Sat, 14 Nov 2026 07:00:53 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1ae8be5adsm9104334a91.0.2026.11.14.07.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 07:00:53 -0800 (PST)
Message-ID: <3dd10d0e-1922-44a4-9640-b779f3114134@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 08:00:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] roms: record the H2 commit in a file
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
 <20261112173901.3748880-2-brian.cain@oss.qualcomm.com>
 <e4a7622f-d87c-42c3-9a36-4e461199fd4b@oss.qualcomm.com>
In-Reply-To: <e4a7622f-d87c-42c3-9a36-4e461199fd4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q9WosJ2Rd95ScURaWmpFARF9VSB4esBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX7qchpSkLBlGH
 2zjbCvcItmKw4zOdNgbJpEwKSCpAEKQynCeWW4JA6aBnOvnS7pMzZCIjN8P68EPgeEA0+IwYO5p
 T32VtMJa7YTLqXdPTWWWhhc67VPg7Gap7//6QqX1JYZL12jUA4tOTt5cMspkElxWYQoY1WvtsTQ
 UGniFNIMx5DPo7WTo4m71qagmRh97HmBAET2wTzU8xgMx2V/aKQ6iMZxnbPca1GwyYbOKwGh8Q7
 dDuZsfX0cfNLvSkCK4VqVkSUWvN8DKZcYngyE1LnybNyGjseahM5494BDyRrJSfI1qpccN+khPW
 6p1U2+9lWVRI6NkN2SlpJ12fFWb1Noq6HmDUxer5s2Hro9pr5eV/E6NuNq5dzLY62wdFtzwKiB2
 3go7OHSyeDuv/wO5d3PSI2uPXGvV9pQKlRRHxffBAtuxPy9h40xpqZQa7iW/EZXXpIfMM3KC3oi
 y01+UAwzUf0S0/hYFLQ==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af877a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=CUr0Kp6l3LonEIE6GckA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Q9WosJ2Rd95ScURaWmpFARF9VSB4esBW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfXz12wLuG6H0ps
 k576/SBVMArPn8RlL3ctA9mSNGQ4plvipRVAT6dj51wTrNto6UPENZ3QiaBloCkHr3yPG5GeKxE
 vtlyyhSuCBS5g8gvxCEWe6FbsJ6avP4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 7:59 AM, Pierrick Bouvier wrote:
> On 11/12/26 10:39 AM, Brian Cain wrote:
>> The H2 build ID was derived by running `git rev-parse`, which fails when
>> building from a source tarball.  Leaving H2K_GIT_COMMIT as "0x" does
>> not compile.
>>
>> Instead we'll keep the commit in a tracked file, regenerate it when it's
>> a submodule.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>    MAINTAINERS                     |  1 +
>>    roms/Makefile                   | 13 +++++++++++--
>>    roms/hexagon-hypervisor-version |  1 +
>>    3 files changed, 13 insertions(+), 2 deletions(-)
>>    create mode 100644 roms/hexagon-hypervisor-version
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fa0c6d0c9bc..df264c30753 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1399,6 +1399,7 @@ F: tests/qtest/qcom-dsp-test.c
>>    F: docs/devel/hexagon-sys.rst
>>    F: pc-bios/hexagon*
>>    F: roms/hexagon-hypervisor
>> +F: roms/hexagon-hypervisor-version
>>    
>>    LoongArch Machines
>>    ------------------
>> diff --git a/roms/Makefile b/roms/Makefile
>> index bae8f3b766b..2cbab2d1993 100644
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>> @@ -226,11 +226,20 @@ hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
>>    hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>>    	hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>>    	hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
>> +-include hexagon-hypervisor-version
>> +
>> +hexagon-hypervisor-version: hexagon-hypervisor
>> +	if test -e hexagon-hypervisor/.git; then \
>> +		echo "H2K_COMMIT = $$(git -C hexagon-hypervisor rev-parse HEAD)" > $@; \
>> +	else \
>> +		touch $@; \
>> +	fi
>> +
> 
> Maybe would be better to always read from the (existing) file, and
> compare content to give output. With this, we can catch the "updated the
> submodule but forgot to update the file" situation.
>

and compare output to *git* output.

>>    hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>>    	HMX_HLX_SUPPORT=1 \
>>    	H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
>> -	H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse --short=8 HEAD) \
>> -	H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor rev-parse HEAD) \
>> +	H2K_GIT_COMMIT=0x$(shell echo $(H2K_COMMIT) | cut -c1-8) \
>> +	H2K_GIT_COMMIT_LONG=0x$(H2K_COMMIT) \
>>    	JFLAG=-j$(shell nproc)
>>    
>>    .PHONY: hexagon-qcs6490-cdsp hexagon-sm8975-nsp \
>> diff --git a/roms/hexagon-hypervisor-version b/roms/hexagon-hypervisor-version
>> new file mode 100644
>> index 00000000000..4aeabdc7d0e
>> --- /dev/null
>> +++ b/roms/hexagon-hypervisor-version
>> @@ -0,0 +1 @@
>> +H2K_COMMIT = 23d5bde4313c1e63ba64dd5d7f542b1055188ef8


