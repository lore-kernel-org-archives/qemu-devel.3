Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AFBC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0z3Q-0001Yd-MG; Mon, 31 Aug 2026 06:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0z3O-0001Y8-6z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:15:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0z3M-0003FC-Hz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:15:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xI9s2460282
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HO8547xVSxtikXd17ilxo4/OoF11NNkptJ4XRGfxE/E=; b=JpCwwkrPPzrV4pUZ
 TnF3VSi2VstHdzTtS7v5dCoD7kdgH2Dd8B1styLa8/Bp8DBCm+khuMJ481tKOu5L
 nALu+qGVIu5EACDXqptd5yMGLDowI+xVxNQ+JF7YovM8HPHA5aFL5xbRsyiN/U/D
 CgNPqi/VSj9dc4rolHltAwPjm/QOm+WLf4KQ43ij1i426JXSnxFMaKLX1nRIr1Ht
 1p3o7pyyFczPTBULSrbczNOij4Kc0NiQH2nmPqMg9lnMeUMPWw7kB8GAKmU9wM5C
 rhYoXs7CMmbaVHy15Kvy9HIhslNRN7IQpE4FRIEZO+x9A5TSVvBCb6VyfT2X0Ag2
 7gzJzw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556rqd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:15:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ef13b61bcso672975685a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788171345; x=1788776145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HO8547xVSxtikXd17ilxo4/OoF11NNkptJ4XRGfxE/E=;
 b=NLqZrxq86OtVBSetDW1Z+MOjSftW9JT4Yjbt3G5OWc2xz3iaRYqwlJcQemNS2wJ1Ib
 axC1OCh0XHU9YF1Pl5aInpwpI+cIPCncjr+dZEopp4I4YTybdnINPJyxAIMPsoIbi++h
 S7FY48lysBaJkfvfqkuVnyDXdp6cFS53C6OBfgCtLP5C0iAKwanjxasP7YYOQImx53K6
 qAB1v6eY6pakXZZ9ekvlk4RjscF+NCVQ387vKeD7vvQswIOKr0sEjL5x/yrEzjY+C/e8
 b83uy4OVWAZ8nr8A81691c2AeBzSTOphPidQz027mA7lFK6af0njLd8poWo0WfaSsGXK
 Z68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788171345; x=1788776145;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HO8547xVSxtikXd17ilxo4/OoF11NNkptJ4XRGfxE/E=;
 b=oZckzJRy3nVsnWtYVFyR08jsL9ujwwrLP2GT0hemw+pAZZGd6x8QQaDJ9DQVIN+Sp9
 y59SHVtoQ3lvGFl1qzEcICaBtg2i3W6SiXmQRc3CvNZ2To7plu+g1ZqfTdWi/VC4eQCJ
 PH770tc4x8JeNxz71MDJZo6mrq+UJ+tqfbUwog+ZnxEKdlQsZl8dN9HOa8wWpxJr9hGx
 Z9/Z9+BxJuWp80jH/Uf71bh9f20hQYusB51DTd0c5X4gpUPF+HaZ1x86AHZoLuSvXmmr
 OR9E0826JzLvrThoU0yO4NYo6jRrpsGhciw3jvFkYh7fHCwCOIGEAYrImlr8pQ28HMt5
 Oy4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2T3Rpst7sursdvRiq0YjQvpoHf6u6ddLubRuneHuNSORhGaoTUApjny6H39TgioC1L8NYmUdSnBrF@nongnu.org
X-Gm-Message-State: AFuF++kJeipeJpImmYc0qACrG1cMuVUBXwaombeM38proG0ZOcNofXIf
 V7Gpkocb0FuinhrP7zrnPqUQQkcsg9DSq/pLZUspr9CA4hJH/B1LS3iikDuVfIDOVuhLjChNQva
 L+DWMAMu6Yv1zZ36csAD5TYuNMJXC0eE+4/B8vNLENEHOBdOGTVpBSIwH9A==
X-Gm-Gg: AR+sD112rrawckAtl+ObvlKyNassqqcExwy3UDF0QQRbYvWUf/oYTPBd4z86Yz5e3X5
 2j06NV+BOREkK5Dsu8MquYb1MwgIO8iaYEIy6gH353J1i8Q1GEKeS0qlBLPs028YNZkfAAEkNRc
 1Zwc2hPYuB6yXyz86qbFKxLOULHYxutIbYW7rYtqsKAeJaEc4E9TMrD5M6WxE/nRn67Vq+m8Tii
 Nejh0gzpqPZCxL40OuL6O8Ozz52JbOh0WOvE1CQcrxl0gPjztUQQ/IensaGcYFP6N705moq0VJ6
 OpuNsHZvUii2s1yI4LQadd1KWMkzapUIkXOeze2zb35RMIvGLSH3P9KkudL9frxOY+p8B5miiIH
 Qi/Or/+4HW3j0sb5M2jPErUagPNqtbsQWBw==
X-Received: by 2002:a05:620a:1789:b0:937:7836:14ff with SMTP id
 af79cd13be357-939139257b2mr2349167685a.33.1788171345389; 
 Mon, 31 Aug 2026 03:15:45 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:937:7836:14ff with SMTP id
 af79cd13be357-939139257b2mr2349164285a.33.1788171344952; 
 Mon, 31 Aug 2026 03:15:44 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dc0f57sm308532155e9.2.2026.08.31.03.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 03:15:37 -0700 (PDT)
Message-ID: <b2d4edf2-3a8e-4d2a-a61b-dd77f09a74ef@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/47] target-info: add target_config_dpcd
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-29-pierrick.bouvier@oss.qualcomm.com>
 <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
In-Reply-To: <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OCBTYWx0ZWRfX3Cc+WIpR6aqv
 rbHiZ71muyO+NawiI9D3g4ju6qzZg7fBrhOZ4Z5UmNYJJWRQBoNhBNqvRoUUVi4xDx0mjezqF+c
 dmC9Gs0lk9PIJc29cK4BepDVyfT1vqY=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a955452 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=L6ItTwvVn_2PqR3uVtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: giWug7y6iDV9P9rEZ09nhUVVmQakX4eO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OCBTYWx0ZWRfX0AQ37C/kfApl
 fLY/RKqMH6it6k1q6sFuHQQzVppkxl+OaMhIQ32BDG8h5xC7Tv99JbFdYxsccWRWLnmsQhWq9Ha
 7N6c7IJrwP2pCmr4q0ckONO9McDOwUtpfjWPvJKFmG+ms/M87krcYJYfanyB6yB+mVYpvd8RETG
 uSPJVm6kd3eqaJ1f6nAhv0ER6cLVfD9NKCimikYF1+PaA+3JNdFEWy9xwMFFh4PHESeWpblXooh
 3lDeEsPfFOQIyzh3X0QBwfbN/2PAqI5vm94bbkYkFGzzZ0I2O2hqmj1tkYueH6kiqB77IZa+BcC
 gYH+KSppmCzYmT2QRp27YqXYX0zi1f0Y9b/u+G1Z9WmZ2IhFHce5a+Vwf+zHzafBXwoHCvR/a6j
 4qDLZp/j1SJIkuc2h47UL6Y5UhfUhq/Iwa0ZwbsfSsJ1V4xUKdgVG0JtUEtQBHfBPviA3Q8p3zK
 V032amKjuuX+ZlxGtzg==
X-Proofpoint-GUID: giWug7y6iDV9P9rEZ09nhUVVmQakX4eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 31/8/26 09:04, Philippe Mathieu-DaudÃ© wrote:
> On 29/8/26 00:58, Pierrick Bouvier wrote:
> 
> No commit description explaining why we need this change.
> 
> Guessing, XLNX_ZYNQMP_ARM is AARCH64 specific and is the single
> Kconfig selecting DPCD:
> 
>    $ qemu-system-aarch64 -device help|fgrep -i dpcd
>    name "dpcd", bus aux-bus
> 
> We want to keep '-device help' output unchanged, thus we add a
> TargetInfo dpcd field. This however doesn't sound right to handle
> a target device config in a distinct way.
> 
> IIUC the DPCD device is plugged on a AUX bus, but the wiring is
> done explicitly calling aux_map_slave(), meaning so far devices
> can not be plugged from the command line interface (maybe they
> could, but the code required to do that is not in the repository).
> IOW we shouldn't allow TYPE_AUX_BUS children to be user creatable:
> 
> -- >8 --
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index 877f3456062..240447598ad 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -317,6 +317,7 @@ static void aux_slave_class_init(ObjectClass *klass, 
> const void *data)
> 
>       set_bit(DEVICE_CATEGORY_MISC, k->categories);
>       k->bus_type = TYPE_AUX_BUS;
> +    k->user_creatable = false; /* Must be wired calling aux_map_slave() */
>   }
> 
> ---
> 
> My suggestion is to simply add a previous hunk as a patch before your
> "single-binary: command line reference" patch in this series (can send
> if you want), and not add the TargetInfo::config_dpcd field at all.

I tested your series with this patch placed before #8 "single-binary:
command line reference" and (modulo the optional libraries you don't
seem to have installed on your system) it works as expected.

