Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554FACD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT25i-0007I2-Of; Fri, 29 May 2026 14:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT25e-00075y-Md
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:37:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT25c-0001TT-1c
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:37:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2IVd3915232
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ZwropHTkksAm+IeaLomlXgfdTiDpxYD4pyUXh3rILs=; b=BJEt+fOQXXigmyum
 fA0FC3DC+QyLuXpV7/vS3o0iXI2bA0F9mDSMu9gfHk8aRnA0Fw0Fi/LUqV8rGurh
 2RuSFk8z+qfIC6KDO1zLY0b4+mrWIvzpDiEKwNl54agsMybmic7VpIL/vIbvJNXS
 cjW1qobITnmxeCvARgaw1JwnUxe02BxiXyV2DUXA28zDTV5/5yaWDQiD5PKONSkk
 0CE+dGSSZP+nUzPCj3j6jJkDDyBcB+5VMFhTYMt6KMhqyj9qLaQSN1oJkzwSmi/G
 RSyVCawJUt84GLitpT9iZkX6Bvut8QMVn/pemzCzKqqNtcSavJs0qed+7IEB7DFq
 ay/lRg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef015cn51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:37:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so4901839eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079865; x=1780684665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ZwropHTkksAm+IeaLomlXgfdTiDpxYD4pyUXh3rILs=;
 b=K+lmnsflZ5q1kYjTShK+yFnDagG+mz+7bAmlyBExSrk7AmEuSc3IXWBdKGMrDgmUi2
 FD5Zk7dXjlz2gGkvwYqMSgkCYkXAg049sS/WcfSBJ5hG0C3EPqiXEEkgtwXjfO3wOvH+
 ELEYZOOREvxrzYuvVJoPMU+NsIe2gBPLy6hteIfk8HjNJBHTLAqkcQwv6A85P+7DogX4
 vlqaWmCNdhxV2IejguMMzYxbJ1vtL0H6H1fM3+Y5MUBKE95UKdWRd2/dVw8JhsHOtQGU
 0b+rkjGCR18gp0zW281oiIYwda/kXNPCcgwdQTpo6J/8AM3Xpz2TS4H54OD0hadToGlX
 qZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079865; x=1780684665;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ZwropHTkksAm+IeaLomlXgfdTiDpxYD4pyUXh3rILs=;
 b=FQ+npZJvVP1N1+pznCCVvh8HouctG8JremnLEavZEF1V3/5yCEEKfzIYbv05syw1kr
 oDl2WBCBT2P4AQGIkKWzwbodIkQalq7tYaMF8lCR4HGBdlIspyaP9LRGP/LDkQNYH0il
 qEEHMVp8+o1jaHrzt12o9MvOZo8JU4+JWE7nQuBijRT9Ni0G1b0qAkYQEGSw8LPWjOvW
 iATVDYH0m6dI2kDzvzZOAPmSPUxU/TiD1F09sG5T1DopewUwHSxSoii8maIT14Gor0ZR
 5SHGysXDSFOOB1MVMDdRsNfyGJcmfZGcCj+QoUUjYBA/0CkzkSULMdIePiQr4AmaDdcP
 e6aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7gYPBYAdwihuopSUixWc84skXG80O2JjoscBmvWlh/V73Iz7RAtLi8tFIoC7wEkpOZWFmLaQNT5EJ@nongnu.org
X-Gm-Message-State: AOJu0YzFnqpIyfvMzeIJdSba+jt6zX/+yX1S6XF6waZtr1LHJ2TrpcEh
 iNixTPBmkVN5Zme6C5x+6gIZiLLWuFqm363uAdzVcAXhQhRrmY2snPjRJUEyp33qIlTHI8uicdq
 VujKHLFuDrlWSwihNGIqpcws1gJWMTlXE7NtotHED4/hOUMg3OpRyE8t4HQ==
X-Gm-Gg: Acq92OEARfHXDUdCsin9/cJHQPCdiRca3E74hvDaJJME/V8/Qd5nZbCfHeJGrHepnqf
 L6KD//k9ojhUHwvR6zx+dSAfZHY+z52Jw5g+vVzR/UB3fWpDaMUimCe7nw17tuckznkrI9tawbd
 7WV0d9z1cnx/6g9N8kJJIYKft8JrF7yaVi3HXc0zTWOJrXeiO/E768mn/D3SondRIu9/QksSqPj
 ClI3I2TQEBld0rpSEPa+CWMlCu918HEX0hn5vhhcE70Aom2fu0BiJ3sA1vNqnrz5yRep/6S8DVD
 3ynYFJ8BUePZRBP7/j9g+29qGjeYR+ZOjelMTVquE6GnNUMnW5cCIeqeOAwwOo43bIWB8U7Iy+n
 mfbNp49gxUEAqVNLiK8WpVAiKWjauRlgScnUMwxH3Op+erVK6uZTV3Y8nMEysRZuhwySqpqcaf0
 se9aNFnZ1f9CMu6EaGMgoNxhxO
X-Received: by 2002:a05:693c:3b09:b0:2d2:d7b7:5c61 with SMTP id
 5a478bee46e88-304fa4fb79bmr538862eec.14.1780079864957; 
 Fri, 29 May 2026 11:37:44 -0700 (PDT)
X-Received: by 2002:a05:693c:3b09:b0:2d2:d7b7:5c61 with SMTP id
 5a478bee46e88-304fa4fb79bmr538833eec.14.1780079864302; 
 Fri, 29 May 2026 11:37:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5b8fbbsm2025089eec.26.2026.05.29.11.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:37:43 -0700 (PDT)
Message-ID: <9e0d9d36-1109-401b-b514-f7011a8ee7bf@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:37:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] accel/tcg: Convert AccelCPUClass -> new
 TCGCPUOps::cpu_instance_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ow8u86pg213uR8S8FhAgVGA_rltmUkCC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfXyx1QTy2dMlZU
 mRkPHgV6UySZYuIM2aHMvJ6703E/XuyZY3NBYKgziGkZA245V3ifYfbrO8liZcsXQenEa7KjFUM
 5T8mQrCqwaMRQchEhVdyjSZNJQm4GLAch0L1caO8MXR0aqTCHAX0XgRvgWwH5Rgc08xunFL4QkW
 t6bXiSQ2TnInwoq7A0e14nqPrZSRwTPioQ1WCIgYxmsWdJ96dfcKxBXF/u92qJMvAzSWj2pzIk9
 /KQluIBCB0g2mNIZngmm1TuAQUm+D1syxMr/MFT7eP8AN4a3rDVqZT47WSXgE7k5uhdwyZ3OreU
 9CfdUQedvkKslkdYEVY//PPrpEG3ajbA49kyIJhbzKSY9jtcv28Ktgi4jSWm47P0miFidh3A+/2
 XR1VdQBIXjcAr5+HN5mZONVVqwL1xDkGVlTvelf0KWPexZjaF/STBD/S444hE0vCW1PNlHNGNiw
 hdHKKgJPS8/oa/qsgKw==
X-Authority-Analysis: v=2.4 cv=DIG/JSNb c=1 sm=1 tr=0 ts=6a19dcf9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5L1J3GIhLrxbTrXAYmYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ow8u86pg213uR8S8FhAgVGA_rltmUkCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Introduce a TCGCPUOps::cpu_instance_init hook and call it with
> tcg_cpu_instance_init(). Register tcg_cpu_instance_init() as
> AccelOpsClass::cpu_instance_init.
> 
> At the same time, convert X86 and RISCV AccelCPUClass hooks,
> after forward-declaring each target method (to avoid moving
> code around).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops.h   | 1 +
>  include/accel/tcg/cpu-ops.h | 1 +
>  accel/tcg/cpu-exec.c        | 9 +++++++++
>  accel/tcg/tcg-accel-ops.c   | 1 +
>  target/i386/tcg/tcg-cpu.c   | 5 +++--
>  target/riscv/tcg/tcg-cpu.c  | 4 +++-
>  6 files changed, 18 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

