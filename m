Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8195606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PllELIHf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jNRmydhg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFFj-0007GS-VA; Sat, 14 Nov 2026 10:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFFb-0007FA-Hp
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 10:01:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFFZ-000748-SF
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 10:01:07 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDkOQq3630459
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 15:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tYRRvhlTGmK9LvhqCN3V9AAQ0ehnGMdXN/PDECjKhkI=; b=PllELIHf+UN9Uf15
 Rm9Md6jNn589H1nY09xpkIzyUMKM5BF2ovQj8YMeFYFbo8LsoTkZwZJ8HtBjhm/K
 1UJdb2nAKdKP2G9Sw5pBtA3mV9vuIHfXzsYqGw0MD4c+/ixTRDblyC7tkeKRLv1Z
 JyJRCjMLgJXliM2O/cb+60XQNFC2hUCUr8w8RfKhwAPN4MGhU8szH7np/mEof+Pt
 RRpamSU06PHVP4f5KDY7su9Ny0FcH6LqV9blXF003Tnepnn4OeA5OIfLcKJ1vlnU
 ZMJeTHe2tac5KYiMmLggCbvPH84Cct+wlsUoJHLzxuRr4seWq7gB9xAsobgVQtuT
 mR7qPw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkw904h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 15:01:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdb869327e7so1821037a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794668463; x=1795273263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYRRvhlTGmK9LvhqCN3V9AAQ0ehnGMdXN/PDECjKhkI=;
 b=jNRmydhgKDRmcvpTS9XDAz8NxleLq4zCRZotJVMCexMKob9jsZbE5OTlfLrbz0871B
 +VgCWTvUBPtNclWX1Nk9L+/U5WA4T4d/15CBccU8TzgByPKPXA8TxQK3YPm//EQ/x79n
 3C78c6NvXrFfH3BUFJRcRrtWt5ArcXYA70kxeIYVQU5GKfQnZypr1HnEPNL7qH+TXqQj
 Ig4xLwjGBTjvQehIKhgisEg0/xSSjF8nKOwQT4oEOSAuYpInXoP46Zj/mvg6ffe9vEfU
 OymbR917Tmf71pyqT6TCuYcOVo3g2xF1NzmrxK5th9OaPkutYu23xTwTiax+qpPUchs+
 bBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668463; x=1795273263;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYRRvhlTGmK9LvhqCN3V9AAQ0ehnGMdXN/PDECjKhkI=;
 b=pQQFneY6XmBLKZ6J9PdWjJ72e0Xod1q0GTlIXtqGF3QLhNSWqca+3fbooVkJra6Pud
 ot9QvvxBXTYvgOmVCEiAmtBMZtfts/y2j6qyFA5H3Y6hAK4E3q4JtL2d1NrOEfIyTNHr
 fsDAYtMYx2vxzFWDY+3xnEVf+oQgvq1GKkx/x0E8zW0CTxMTaun12diApebgZu/wY7eT
 KskAyAepvacb2F3RHDUlYDPLI+BI9kmn1SZXDkrjO8Nmf1Wcz37QbNwYR1lEZBw4mTG3
 Y1lErCCpqjTg6ws8AZGosYruHJjv/1QDb/7foEB6BoAo0ISmwuSRu2p+rC/EqqOzD4l3
 JGEA==
X-Forwarded-Encrypted: i=1;
 AL+hErE9CyRXp4sVW1Pu9dqnfXanrJpSGJdrcGnGIYs5LuEmDBmL2/+4VKze2tuq7IQ+Ca+91VKm5l+HgeZF@nongnu.org
X-Gm-Message-State: APuU4Z/PBCT9Uqux2uq8te5SWSaZkWp+fYCAwPrzzFE12HM7VCKmAAlw
 VA81VYzQ8IupPo9fyfo7x+vMl9/4ehi8wYOcslVUJqUXbQK1chO0uSN7jhw+MNR9ZD6JGgYC1V8
 4eo7vSo6AadCcpTLlrevM8iyA+30prZMJHsU/7otpIOvRtpZcEiU+AGhJFQ==
X-Gm-Gg: AYBFou0RvIu3RJmem5Bqzkn06EYbOx/KXaVA87xuE/xEwMKuebB+cp7Zm1IvQlH6GFB
 4F4SlxN+WgogZiAu97qNae0+E+dTJ1/NM23Ch7GZO+M/h4X+qf0jOGpTIhTzT0X/4GyJJpj1qtU
 TslO7cAFSJStXal4SsRqG2UIHxib+iPaZE/XZAdo88dABsi8IdCHdhW8ExVjPwQYiM6liqY1v/m
 TpW3Lv7YwJuFcoVFZDYRdvSTGx5IsCFOJPto/JtdDLuWWzM+pgJmyzZVS+PE0NLF7LKgKZPP6+H
 bZIU5il2O2jZcc6CIig4J17Q2PPq9n56yDhuD3WQ97HVbz8rkTeY4gLyT62w+sUhE6CfIw9uPdM
 liaX85zzQ3+CBc2pjxoZp6A88PDfPI1q3lNwixsNx2frYQHO6fCMuI1YBU1tyExK5d44LiYCzOM
 VeTqh48C04ttptYKeDCUKYapOf/dl3Fg==
X-Received: by 2002:a17:90b:1b06:b0:3ad:aa1a:312e with SMTP id
 98e67ed59e1d1-3b1b087a639mr5935993a91.3.1794668462641; 
 Sat, 14 Nov 2026 07:01:02 -0800 (PST)
X-Received: by 2002:a17:90b:1b06:b0:3ad:aa1a:312e with SMTP id
 98e67ed59e1d1-3b1b087a639mr5935932a91.3.1794668461749; 
 Sat, 14 Nov 2026 07:01:01 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce460csm13991955a91.5.2026.11.14.07.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 07:00:59 -0800 (PST)
Message-ID: <0a20e3fe-74d4-46d2-851c-f14cde22c842@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 08:00:58 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX5mWKk23D7lX7
 DH59VjQGiGTTUeAIX24Vx2Z/wgBp2iFxpzcK6UG28gBfrDsnn4QyBJo8tjj7qk/M7iOUKq5OJUd
 EQI3s9XR4dgBvfZTuDvVgAerCmcAXT4/s7JdOhMcXswrkQf5kUnN8jFjiDHJStDWSp4aOug/t2I
 SsNWjdnJK7UquO6i4S8THv4OIzR8m0HhyntL0RtuFGHkNpLPm0r/fj4L/CV4Di9bfTKrkcCMdOO
 oQwFa7iNFaqvHier8ccosjicnq6mwBI8YQl10HyqD+FBeDua+PoGOMUcokjWeGRFqH7PazQA/nU
 694rGZsx3QdU8S3BGZoGQYUnb0G/8p0+p4h6Cj3ikp/tQNxs4TGkXK5oxydYyvrhj55JnREJefV
 /2WEt9YpEZkx5Gvum+ccNX5ADkvXsL6J8vDdJhVj1COxBJ4GmjIAPGJLyuX8ruTdddS6Bqi42Ks
 YYQBGfTe2q+S8rDvN0g==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af877b0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CUr0Kp6l3LonEIE6GckA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: gdM9yeFsASH_ZDlXYSQjHWFdIDOGL5lN
X-Proofpoint-ORIG-GUID: gdM9yeFsASH_ZDlXYSQjHWFdIDOGL5lN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX7zZj6YLsRdKt
 E7Rusv52ZncAe8yCfI/2nrj/ExJ8AiKS48zxGv0jYKAXU9dYACJL70C6gaiDeflcBq5IytOOK5W
 5MHYTB0R/D8WK0nfertZYgMcsAw3SKI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
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

and compare content to *git* output.

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


