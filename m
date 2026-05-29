Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63C0CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT2AZ-0003FZ-Jt; Fri, 29 May 2026 14:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT2AW-0003DF-SI
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:42:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT2AG-0002rC-T7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:42:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIer7F117810
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U0GiKqxYGVho9sHc5JGqPJeipnbnaqHt+fQle5nA3Sw=; b=Nt4eux0de3HIdqtK
 wE6YHD/2Vw/7sImEKFD6We2XUGiHDbU8aDBaY5nBqnfbb8yPSicG0LMgO8bvf9Zm
 EpTd0nLydmZ+w/zgg99UnPBefMu2/jGZIFo7pZke7VmZAIm1/EnbcurP6sHKCqZD
 sYLI/tl5/KMC07xho3ogHnzwTwxdRcDOq4a9nZQMnpeXD8BxlZTrxP6GI5Ss+YW6
 ujnS7BogI/WXTvD5oaO88bX7yWXxI6FAb/e3i/5pZpneQftiT4egojo2bVp1CS9v
 1VHwZSArcC8DvX2HVYZWjkvCLLeyU76wnSs1K6/Uj9+mrHb70sdwaD5tBvjPLuRA
 Z3h7og==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vr06b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:42:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so5579035eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780080154; x=1780684954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U0GiKqxYGVho9sHc5JGqPJeipnbnaqHt+fQle5nA3Sw=;
 b=hbg1G7ErujwE28iVMGql3CKwbvJfsNLsV35tpi4qjjzr34rgsq3KQdS4k4Jp7Q+fSm
 Kmz13QuNPJu/wYfBdvFgN/uqL0P2dKJiKR9E3LufOH+tmfoVCCXnEUmLaLsrgoOVvXYr
 l3vbHFISI5la713gYW3O/khoO5lpfuV7Dg0NVx64/Ir812qdj4aPywQAsPetf3IU88r5
 lQrLAMtNJ+9eY8tBJhed1vdgZmIeu08E6QskjN7uXah9Fg/KIpjBRCHiN3NHzZAoo0VR
 HzY2CE/p0A60YMv5F9te3Tz1PaxCDBEp9WZOtqkdywO12aaNjZbOV1WveolAL53EC+Vb
 5agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780080154; x=1780684954;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U0GiKqxYGVho9sHc5JGqPJeipnbnaqHt+fQle5nA3Sw=;
 b=PGOorPY478l33STDR4DneDoPBKpVnc/pfVu9vYEQui1qk86lW3F8xP/dNba6AwdedU
 QKJYAF8clkjoD1/UZbbvotTUObEfL/dbXqwpXlqZQeleaA9k045mfB/Q1Wz2VU1ckchN
 BT/g/S2TAnN6Hq6pqSn1DMAIHaCaOnwacadVwTIagEQK3Afv6sOuqL6VGM3/fOW6MVvR
 EgvE/33w63YPxD65uy3muHULK13Z2hUbdoRx73/dNWeMobzMtgX4i6EokcpTchwAVZx7
 jlIjg97UNs8/BM4D6PUbdsvj0JjC3O2QXCVSr8HoE3P4JFMekK9gOncfCFCnS35xxzpQ
 V/WQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SGsPsGZ0mcjErESBgGZrpYPC3yVOVASn0Jh5BPDfGRqsldfAxPRJf/pq0VmTXCBkGtnMv/T7jSvnu@nongnu.org
X-Gm-Message-State: AOJu0YwPxke4ngO5Opw92XAkDhrcbRjTuiEP88djCN7dQYven4VkukLj
 Lg9Th1+jP1Cv3iPVzZhw5zcftlGd4TggYFegeyyy1E95Iq3D47gT6oK8d9j5X83krPg+1g1l5ub
 cShykkAsD46UPHsEJDhZ+LxrAm1vqREVhU2KjRG0RcVptTFxDKYiRHVJIyQ==
X-Gm-Gg: Acq92OFQ6ubrz7wDgRxfHpSUTVtGJRufyrjSzrHeyeCXp5froTw97OgsIXyYC88/+zT
 2BR1c9zwfigmK51CeMolqAbzh6vax5VSaVFQPAkar0AtlN11EbS53/DiwyyBQ+eF3LmViofCrSj
 mCqAnt206Lmp7MIHdbq8f7Pqv8WfWW0vj5R8SCzPGLgsT6y8nBq7HQVXMw2r2sl0bfjHFLptfPo
 e3GAFaY94CZpNPoNjswqyMFHmOgOOpTpKIPIqwcpfKGsEGEJd+tLiQrs5uU00SQYXabQulSjJ0+
 2rapAnqWns97FuvhMXep3CYV6h3S8VM9f+aqh2GAc4+sKKoC0pTL8cF4Wrwz3bV4STdAftxwalF
 VBYkta3kgHyNilfTBf1E5E3AW35FjO6DVymBaNCW/i2QpH6yqOe+4jC1Nxvs6NCNXhY0KqMfNez
 JGGQpkuswft33di1oeEjsdl6wn
X-Received: by 2002:a05:7301:1f0d:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-304fa6ac22dmr503377eec.24.1780080154141; 
 Fri, 29 May 2026 11:42:34 -0700 (PDT)
X-Received: by 2002:a05:7301:1f0d:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-304fa6ac22dmr503339eec.24.1780080153617; 
 Fri, 29 May 2026 11:42:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c154fsm1883835eec.3.2026.05.29.11.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:42:32 -0700 (PDT)
Message-ID: <062a4596-25ab-4f4a-accd-4157a58c0fb9@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:42:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 17/17] accel: Remove AccelCPUClass and
 'accel/accel-cpu-target.h'
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
 <20260529142434.87880-18-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfXwg712dchaV1Q
 qy79KFxyjFXGdvZGX3VLe8FGujA750sqhjNrsqBeOUahRwvgm4Oo/rAlfe4+FKUD0oZEkP52UI/
 oPm/saspxV5g7kc4pKHv+7Pid9VXMRaygClKIkbWXYHqD1BoSIwUTQrzfeiDg6Fb6au+V7dFRU8
 bcAkWPErFLzsFU19arWEEDQwyUOthtU/k+Lbux5KdS72vPxmrTUfg95EtqC4j0rzzjSz1egiD0u
 IkA39V7MpDYDrvzCPQdw1EQoRPUG878eyhwYgYI2Iz15ggabugqKSjx+zW8MaBKEema+KIxUh8N
 xucI+75baXFXA3MCkdv21B5kucC7JHd8iwLntwdTi4ja0lvBE1B1zMoJergVRdSp0SzlLdsa98F
 hKoyedsJu/ekGi7iD4Ie9UeewMPGGv3a3PwVOc5bNzME+hAYlhk2EZoPSP09ZRrG5NpBZsX5mR3
 LNkpb3rtKtGUgppVjzg==
X-Proofpoint-GUID: NHPDNd2IGVO4TD0_Veinzf5dxW5HUarL
X-Proofpoint-ORIG-GUID: NHPDNd2IGVO4TD0_Veinzf5dxW5HUarL
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a19de1b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HiizW7Cylt4g5avhvM4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
> AccelCPUClass is now an empty class. We removed all uses of
> the TYPE_ACCEL_CPU definition. Remove as dead code, along with
> register_accel_target_type().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu-target.h | 31 -------------------------------
>  include/accel/accel-cpu.h        | 19 -------------------
>  accel/accel-common.c             | 16 ----------------
>  3 files changed, 66 deletions(-)
>  delete mode 100644 include/accel/accel-cpu-target.h
>  delete mode 100644 include/accel/accel-cpu.h
> 

👍
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

