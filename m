Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqPz-0005QM-7z; Wed, 14 Oct 2026 00:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqPx-0005Ju-4j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:16:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqPv-0004zY-IE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:16:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E20LpC1592103
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nexmR9uuz+Yo5243WPYUrLLp/2RtZEQ2lFOAsXGzRhI=; b=ScOr420Fgx4EcBHO
 l6t0fon37yPc6gyN8Ec1534V1Tw+voHrbAjfh9EMRaT2TP6+/yyvh/dmyEd5zjub
 WiIcqyGBlwAhGGnboRB8E9+qtRNhgLsKVEhp6sV4D62+PuiCJez44n9Bj3ZQSfeW
 ADSvz4rjXnFLfUSf1XMfxrmDMa9RPZ7cWViUkCieIkIa3ib0CdkJDUl0S2sPviTo
 cCSEZC68hjApXdTD0fd0nzsxfLzCn5eHzroWzLCOrDcmbbkWSXeM8oyWUU5Kcqz9
 jOHx3Q2joyukCedE4x+kHBIlL6lAbcNT0z79Ff3/VdYUl/ADuXwXyEvpE8e1qf7u
 Y3bg/A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1tj9cu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:16:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ae8e7e546so782378285a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951397; x=1792556197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nexmR9uuz+Yo5243WPYUrLLp/2RtZEQ2lFOAsXGzRhI=;
 b=VG2Zyrw3XxXPJL0IvfIaCeUfjajiNCFGPkKoA9UQ2jfUJTARUC8htjinFnfqxibxna
 4oqXHuMU0tk1Iiu7RatgksyZMDcy4pwBJ5sCAh+Kc5Bls3QY0ukzV2+Swj2PaDO+rGHZ
 kwjlJUj0WcM1GNKSSDIfUdGxkGEnAWEZd5Lvexk81dvWLqOVNcdfMXUGVacnUOIqs3Kk
 xXQ4vpPGtGEQqP/pGRYdCC+C5tcCHuMMtOkkLgckb5M2qmdrZ6bfy8EMBUr6cGfDGqii
 IZTxj/Upj4Zvc48yyLqFXf00eCa96ESYnNROHFHL96tjbnY8cVxlpem/P4A4C9HkGNUk
 aw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951397; x=1792556197;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nexmR9uuz+Yo5243WPYUrLLp/2RtZEQ2lFOAsXGzRhI=;
 b=fVkwwN3boiZ1f83fwfbhDNu5OyaMcWBEwtY+JCYmKU3wrlF2Nx4XI1jAcAev2JXJaJ
 zh2GcY1h9SYlh2ObDBAwOhR2at/ZB8slyMlbyxrgchWx8V50AghfHCX2fwE4LK9psL3l
 Vu7lwZ6RqP1bB7RZnq63Lsol2cF+1/3zGYlWD+8cMCsDTExAFqxP2zP91YvvicuP4dLO
 dlZq8dG4efY7kNkLs6/P8dUy2Xt2RWoCRdOxL2KhOBVb9UOjhLx8h5YqPnqgHVKh0WQu
 QPiba2+bPRcKp8s5M8V8Ztrkhf7C/COBVdRGyuJaR31YoBjzW2LXq4DjPqUqisgVv3gL
 Wagw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnWnclLBdT+9HfPC9HZYlU+9lG6j3T4SzVvej4P8/gVGHgsD/eMXQLEktSpckYKQfJ8120ZKJ8TjJc@nongnu.org
X-Gm-Message-State: AFq9FYL081DARNd/7fLb/3vhgQg5OwYm8cHQXgvMphyLmwDFM7Sh8thd
 s++GcPUaAHsZpTQWDnIoBgREvmyD8QuS+Wj6yCwozi6ZBwidrPAtxyPyLE5QPvIN1BokC15xeEV
 hCyWT/U4NnQp80CFJ0rUgt5zY4T8MBe1ZAAJtdeSOqv3cqbYkgFEDLEXrkg==
X-Gm-Gg: AYBFou3IQ59I87sbWxz0wyzFlUMzGGkP9PhY2No9ANGy9aXk0QIRwGl2R6Ea+sghvmx
 4Gt74TBB2bTGJExthvbpQLkppu98+G5u4AGNRelxL76sK8I6N8PDGAOkf3gJ784GX/Mce/9mva+
 1ZD4/o/0m56RU2wZYBOTA/KR4MbPBaGymk7opCCw35lS1Ipaw2nPmAI7JDHW4G94SJYTW7TdWrK
 fK7rye9kItTVRKHdYZefrHm9xQrtnwNZVtNVX3w8fVm+29Osy4outVm31o9Nfg7ATlVbbbFJIYU
 O5wSkjT7HyZ4JHNMc74x8sVhf1dhFx4iGhMr6iRjeSgES6pUF/2Whm9K2QTGqIUlOc2veSXmzyt
 9xfHEf6nW6ZHhUjLj3lZJkcE47cY0xaEwDtwHV34Ri8YqxzGT6JXE5Iz956v5pxHkW8zze4cWDA
 DhNYg=
X-Received: by 2002:a05:620a:17ac:b0:93e:5cf8:e5a4 with SMTP id
 af79cd13be357-93ebd27554amr2256097685a.58.1791951397362; 
 Tue, 13 Oct 2026 21:16:37 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:93e:5cf8:e5a4 with SMTP id
 af79cd13be357-93ebd27554amr2256096185a.58.1791951396970; 
 Tue, 13 Oct 2026 21:16:36 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef502608bsm404291685a.25.2026.10.13.21.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:16:31 -0700 (PDT)
Message-ID: <5a222b51-4475-4301-8e80-a74320329a3f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:16:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: mark clock-backed register reads as
 I/O
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
 <c7c38763-5cb7-4e4a-b841-5e52b1800b70@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c7c38763-5cb7-4e4a-b841-5e52b1800b70@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acf0225 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=nyf9QCHYL22wS-ldU5wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX78KNCCIkylOe
 GsuGIYQGYxMIxR70iTdlJQ0B1zR7bJajZUfuqGMmv5c8dcUZ2nmuHCdz5QJ3PPfQoqAXfA5nwmh
 Jygzjl7zdgpyzhbAEMtVS6HwPXI/b8bUXDhRzhXy9ShYIMLadcO77ebr8TpsaezmK1qF2LvNtfE
 NiTfM7ycmCwfzpco582CYHLgNtslY8BkLzMTSQxP72t0C/gkJw5ZU/iCFnJP2hGssAZQg2kc6YH
 G3Eo2KkV5eN739P4HL2eMWCyoX3FmWX6ouuO5jHxCd5mH40NYsM8g07mACtByJjpzsEIo6lbq9f
 4ODX7eCPgj1OZe0aYPD47o0CdCIohNfNlxdrOmULVHqSywgONf3q8WwHcpiFpbHvXxInNrMiDMM
 9W8krSkfCZ8n477124YF1w37txFZBsB0bjv0VAEwjeJHccn/C22mDo28eW4DBSf9n5y93Yv3bqp
 kbJ9ELYqn2j8Y9knTNA==
X-Proofpoint-ORIG-GUID: 1CvYTPo-W1eYcAqbfRWROZwp5KBtHY8a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX39scGL9TIVrr
 yJDRltDHfBDkxBz2l3axONG5Yu0HAnCy5ECTBrpI/xsNFvOpAnr5nn85ulvsaIVIp54yNiqpO3o
 GRZKbWlbWPSXetFV0DCGkdfiFqOF4h0=
X-Proofpoint-GUID: 1CvYTPo-W1eYcAqbfRWROZwp5KBtHY8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140016
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/13/2026 5:10 PM, Pierrick Bouvier wrote:
> On 10/8/2026 5:35 PM, Brian Cain wrote:
>> Mark scalar and pair reads of *PCYCLE* regs as I/O so icount synchronizes
>> before reading.
>>
>> Cover the read paths of {U,G}{PCYCLE,TIMER}{LO,HI,} registers.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg_sys.h | 12 ++++++++++--
>>   target/hexagon/genptr.c      | 30 ++++++++++++++++++++++++++----
>>   target/hexagon/hex_common.py |  8 ++++----
>>   3 files changed, 40 insertions(+), 10 deletions(-)
>>
> The comment on translator_io_start seems to be out of date.
> cpu->can_do_io will always be set transitively, and not only for icount.
> If I understand correctly, calling translator_io_start will simply for
> effect to end current TB, and start a new one.
>
> All that to say that I'm not sure it's needed.
> Did you find an issue without this?

IIRC without this change we get a "Bad icount read" when performing the 
I/O side effects of instructions like reading from the cycle/timer 
registers.


>
> Regards,
> Pierrick

