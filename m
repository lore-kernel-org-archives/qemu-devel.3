Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883B4CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP2l-0005eL-K5; Thu, 01 Oct 2026 18:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP2j-0005e2-K7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:14:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP2i-0003KP-5a
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:14:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsZQe2886346
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L4cEwcAbgRkEYvzS5KiPxXyS/YuZeTWyphRRSrHgm0Q=; b=Wy36h+jB6i0cvnrs
 3am05ABR/wN/i02Rkb3FfMrf16t2hIuJgSO4KCkr7QclMLA8Zmm2Fe45WBUpDHAH
 b1J4AOWKvnERdZQdVRlZBxjp3bU7NEnUtpX3rHe5+ZGX7qJD/z8+mhNYufUJvGtL
 V4ttN9CfzxaF5RGsv0SS2SuOny7VSUzTlTymWcq4NCSEnaFVNf09jxopul+JAz/c
 5iEtR5uzlrwh/1Aem22+NqbmQwdJtXkXoMtjMnaXVzaz8xXDa/G0QfCRH1nnwZFS
 09F+gD5GQkPWno7xhhjjP39F8Eovaw4UJaz7kmO6Em5yCYGmBRNg5lHnTpAoFUdO
 xwIl0w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdcj0xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:14:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so6667484eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892858; x=1791497658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L4cEwcAbgRkEYvzS5KiPxXyS/YuZeTWyphRRSrHgm0Q=;
 b=KEGjOLSO8CTkTH+bdAtn8gjeDUoo8DbZbbGcOd10OBrqWGgQL1Bgm4gSR7mR4MYydh
 uLrPpo0GE6OG6pw8GPhJimMNjoOD7MWJUjA38qVNEuBJK+jSCPx+dYESg7V20uzzYb0k
 zcokXHqrWkrva7asQrne89qkrqG+vqNDdeKZ0BuBfoTo1tSIZg4f8k4ed8qTGH7rncFg
 6o5nIQZvbrKR2jgVCBEe2QSbYukP38YFFkQuECYJ+QdCpA2TYTHnNlbnUx92Y8q3us36
 ADRFNJKmf+hvHePEE6ybkLb06glSkzkNg/kcOqm4ph91NZb9hYOo4YGsAiGzQc8q/3Ma
 4bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892858; x=1791497658;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L4cEwcAbgRkEYvzS5KiPxXyS/YuZeTWyphRRSrHgm0Q=;
 b=A5Yn66wIHYBgNwtArDsXbHABrsgy2nbWkOuBtxG5FEBVRdIubHNunl6zTnNzocY+bm
 6Mv5yZ7XaEx7BJbR8dZ17nMWsCns2JDFTZE9iKrUoLX2S7W+TDzbtMqOOClzLELtk4IC
 98p8ngWnf0kJrVjdkBGlb5kIlj94zZ7X9JQ7tCy9+IWln2XfhlVJmHEHNHHMHpSdyE5S
 hXC2YC/qB+AXQDPF9w0FPz8TukELyv+y+KbXg3XOhk6WXNL05DBgwC0wXBV3Za4MogfH
 sIHNVigtqTD7zzgmxgdqqXH1g2iEGRVoAwZw9hyNBv1iOkWQ+nL1tuGvBW38D1mXb+7p
 +D/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/NMbaQwASnS+wyBzIu8JcpmOeV0XayR4cz73g+e4aDpgMstozLcr13/C+RoIk0wSoAsa828IzXHLQ@nongnu.org
X-Gm-Message-State: AFq9FYI94MQSuwiOna7kd32chXtnU2Daq09c73Y4lsTZ9jI/VMmuwFc7
 5bwfTUlgwIhueCv2pwek4INPomaokkjucI7pJmVEf0L+MdApdk3BHMzuDjxerFavJev68ot4xD0
 fJIvNtlARBtbWXL38OUOcDtwfh/asORWhlxtxaskuZFIbp01cSVK1o0uKBg==
X-Gm-Gg: AYBFou3q32oiawt3EA1YQTgXzl1GuIXJFsy01DU9a1YWHUkFAW5xvc1iMYL6DoMEwan
 4NagGQ+7bsjxvhpr+27g2+6I7C/yzgfxswhq3TPffDqPE6WxbYhlLqelNCkfPiULxmz2dmnq++I
 4puyIpw9r90PhHN4QQjr1IJL3s+kDXkdLc45NUOT+AbTBXo0Mj5N9jYQLdjcvFG+Ob++YMOUWpQ
 kL6F/3IaGKWQWQT8k3sUSPOYcF4wN4CsVTX4Vy16d+apQEsWDayAAeN/jQfs6jvdhuDqwggteON
 qV8bTuRLyd/WmazWYnkiVXqugj00t/CS8hQueZCUOwXtlVQaOp/qD/6t+Gen3s+d2XYNlTK19TV
 knS8BGrMXP3jR1VJBxKC9mPC3KaI4ygxAW3qrdd4lf3zzWf9BOBAuL2gN/ShjPeilU3zDSQ==
X-Received: by 2002:a05:7301:424a:b0:34b:55a2:2664 with SMTP id
 5a478bee46e88-34f2199c104mr716293eec.37.1790892857490; 
 Thu, 01 Oct 2026 15:14:17 -0700 (PDT)
X-Received: by 2002:a05:7301:424a:b0:34b:55a2:2664 with SMTP id
 5a478bee46e88-34f2199c104mr716268eec.37.1790892856919; 
 Thu, 01 Oct 2026 15:14:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f15019999sm998535eec.29.2026.10.01.15.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:14:16 -0700 (PDT)
Message-ID: <3d44953f-d6cf-41c7-afe8-47baeb216618@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:14:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] target/riscv: Compile monitor.c once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-18-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-18-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5Iosh94DdaR7DW4UI-yDVbKyhSrv3uWa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX0CMfN4VFhcrw
 XPmIoZIatoU8nqk6zbuWwYglVZ6ZdhYaWeDUAS4wkN/Ma9PU8gXFEp8nx0AQHlPXf2HbiHBfn8h
 fCAU+anZcjVN+e6cMN8+HnOq99J7QWc=
X-Proofpoint-GUID: 5Iosh94DdaR7DW4UI-yDVbKyhSrv3uWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfXxWDMwb2pSMeB
 vnyI+O57k1YibP33UKyFECYJvc9hcrM1t5hO6aKYVnswqYFY8u/ivlh8g51VuVZ5dJHVyJckFkh
 hyMl7LB0pSZz1h7ww92KryySbaVSDv8kpbkjLHfJ/XtmXX/rTFMJf6BS7SpTsh5s3XqY+GOTXOH
 kB28JPZ+Jik2vtE9/CNIeRZGVyggD+NM0p+uMQVmBglNrxnPGTdpV6iA5j11WAn5mU0jUtNf5qX
 VilZYr4HVcSyFPZQKAkoU/LNHAGccHtDRmQvxbZbSwizOyFjxpiYXtSfnCaiv4EIudHsBNCC3lu
 OWhGnQLKvDOzjSaASNgw0SlBIrFyYEBJZFCU0KcY1soX/pdUtS8HqVbANEZ1baPodJ3pSlx0g4/
 sZOg904z1jGhAD0OL2Rd8guGfFvzGRnLEEmr+QucC2iQoXbqdZAgZNRl4IcMP6p9JcX73D8+T5E
 aIiNnp9/mVZpnmWHOGA==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abedb3a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hqIjwPR-xFVZAAzXJWoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson via qemu development wrote:
> Replaces uses of target_ulong with vaddr/hwaddr/uint64_t where
> appropriate.
> 
> Note: This commit will print all addresses as 64-bit values, even for a
> 32-bit target. If breaking this interface is not an option we can
> instead opt for more runtime branching, as done by Joel Stanley
> in commit 409c7d8682a.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/monitor.c   | 42 ++++++++++++++++++------------------------
>  target/riscv/meson.build |  2 +-
>  2 files changed, 19 insertions(+), 25 deletions(-)
> 

I can survive to the change for hmp, let's see if someone has a problem
with it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


