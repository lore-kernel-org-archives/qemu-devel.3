Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834EEC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16Pb-0004KW-44; Mon, 31 Aug 2026 14:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16PY-0004JK-4P
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:07:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16PW-0003Gz-4h
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:07:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFqDKw4079245
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zku/9KtjxDFMfovRBLPbml0uKIOAdVtAq7Kc3s7TdGY=; b=WVi8Gv1XigS63nDj
 4H75jdcqGhqNb9GR5Fay4xVj/9cjKfgtp2DbQjk5BNI7RTrEc1zkYWFrbepCofb9
 AdlRzqng+Xlz86RdIuXsZNB5qVX8rj2DCLbotDiEhrv9H5dRe5LgWmZ8uRIPhKzM
 R5huyqA9MGyJpqYe/81FPPk+s1zaajutB6raue9VaktnOsCYVNgXNmt66mOfbKsy
 zag+eCTzL5mCcTDQUba/QbYU8+ZKuJSx7cMP5Xprd2acZFrLzAzKoeonWnkmy1Bi
 umuxDmvARhmhAZQN4Z+3RWFSVK+BrKKlhS5tpnsvXri6wGoSPG5oQN1QM3cLsOrc
 01k7wA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rbad66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:07:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6f710f066so1398845ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199627; x=1788804427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zku/9KtjxDFMfovRBLPbml0uKIOAdVtAq7Kc3s7TdGY=;
 b=Ilc/jjWDf+oKGKSWku+iEz0kOVS6ivffQKiZ6tpdLKtEeE2iuE2vrq+g1wZOPiX70S
 nobFbdHEUogIdgqhlv4C/JgHKb2ufxLOvhq0Sa8a7fHvcdqa3choqtb78z08jw7O1G7g
 FGvd/YiJmLahBSX4OD/kHn7le1RhTZOHT+8X9ypbbWs89NIps4SvONgrFpC5vNT95Rza
 FasklzbsdEYrrbOxA976XPSsGr0OBNY5TfhsP0UCnky3VLEpSdTlM2n0NnLY8dzYYBdl
 c7WB6/tdzbnmRwdicdftMsIy1sQImS0iwdseaJDD/RvYBF9UCy40bp8R3tumpslE5d2p
 m6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199627; x=1788804427;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zku/9KtjxDFMfovRBLPbml0uKIOAdVtAq7Kc3s7TdGY=;
 b=kB+LTXjBZT1pPXf9PMzixvnhzBd6AXZ+NtJHMi7nZOh97jQQx+5AtFTQr/SWnQwovi
 91BlpKJ7taceLFRXaH2fVyS+L4xeJAcgDIsDgF9rkAdrm29wKNFGlFLWBd9xcvVADSeo
 fvBS2GfMxyLNQqv1ox44vkrWaIlbuD3cRhJ7ln3+An98cbmFImXlbzQrm0kWFVorR6GZ
 fIR8qX+bCT9M+2yrYZfU5F87rh701OBw4tvnT+On+vOdlg2rI9UDHeR/y6r8p0qo2B/w
 v5//PhlEulAKuiBk6sOyovDjLDkPZv303I+AvFzWWLtf/ckWvByHpUAZtSqZPsCnvbur
 DM2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ8971JnPTyijcUpTLMDd7qSVzJ5woSPLOew+nuKGqokBNBCK4ZJsrtFAk4+Wotlq4/8pLHemal7Hn@nongnu.org
X-Gm-Message-State: AFuF++nvBMF4zrrEBf4aZuBAUwaELCcpi5+Bwk9zspT2nCopou166aPA
 13KTH/vx1T7gFtKdyHvtWwBniTikN/vP2uGmH8Glo+qfXqSy4K5sBa4zmu07EA3cYFRa3aD5Hn5
 SGeUktRZAO4CfkdJbnz6x+N70ayZdRYulZ/ma7we4NSkou4KVb92Bf0cl9iDobGEoBw==
X-Gm-Gg: AYBFou2Nf04iLAseMUoE+EorzMwO3K9xmo6F5h3FqxYxA1R2B8K9JkYpCaNXnyC6NkQ
 aiKGElN8OFqYcvRLD9ivvmFMR6JlZmumDklPWddFIAH+RHMUio+uW+rnGkGpYqxMP7AQSuk6Geh
 Ylx+zXl8uUlw7vW+QqlQv+Rd860VzlORvgo5NrpM7h534nqUkDmWgUngBfn1a0BtzQ4UxfoLWc5
 1eIaHGYEgY0nYWJ4LbCbjTY+6m5iuVSw1Xp+H6NSqj+RdjKDG+cYNkhNjQK+3Odgl05dE4Qbg5M
 vnO71/clT+76mGqnLI+jP5z8GgFlgwqQSPVcleTXdWz0NvkvgGeCZgC5fMO5sicFkhU9AcdDeSE
 jN/AsrGwWU90wsc+GOA1pXV1RXqwud/3Q7/12qcMMFo779F6TQUWiZinJpeoK+mUacWEK
X-Received: by 2002:a17:903:3d10:b0:2d7:5da6:2af4 with SMTP id
 d9443c01a7336-2d95268a8f7mr1173625ad.4.1788199627123; 
 Mon, 31 Aug 2026 11:07:07 -0700 (PDT)
X-Received: by 2002:a17:903:3d10:b0:2d7:5da6:2af4 with SMTP id
 d9443c01a7336-2d95268a8f7mr1173075ad.4.1788199626596; 
 Mon, 31 Aug 2026 11:07:06 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b4bc05416sm17084543eec.6.2026.08.31.11.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:07:05 -0700 (PDT)
Message-ID: <7f750e2a-41df-4674-b14b-4e987d57628c@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:07:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/47] target-info: add target_config_dpcd
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-29-pierrick.bouvier@oss.qualcomm.com>
 <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m5V0g3XrWkJiU9nyGxWa-rlG3U_S_B7a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX+tk8P7uDC4LX
 /xWuvOy/myYPeVw7pOxCL/tloOkqp0Ya5N0mhxOC5gwcnxD4/NJtR4WyfX08i6AvraXYhgdKGaf
 vE/SSqnKD07Zr4GduoeDUyGUclRLcV0zSMbjUHYF98Az3k0rgyDRphBDIdSbjwQOZKZfPt7o93Z
 dOiykuvIPJdJT+sT1HvNx1k9Dc7qZSRKvhhc+4FLjC6wyPm2VjJcfmMAXrcOT52e5qLFo8P/sjW
 VIyTmvRsv3hBrTZOOqmOBVbK97EgzdMEw3i4jVIkUDAXNahZzlidyGEHi1iEINlbaoYyZiMqKEP
 Mv61mkR+SUEHS4FcSpLS4UjE/YBv2cPzJ5+SeHgxvsaDiy9fdo3NnDPTbeUwA6DvtYKtmmppA/1
 RoxfIqULrIEhDmta6INx3exN5VRyL1nvHkh53vDvDqC3eUVTrb486MkUO81gHkFBi0qwMp7a4+7
 XdmeG1RiWgfB5gQRG9A==
X-Proofpoint-GUID: m5V0g3XrWkJiU9nyGxWa-rlG3U_S_B7a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX0Bgf8Z1YQGkN
 3LNXuRie3AmUrGfKZpi5b5+Zh8sL+M8wnFTclxND38WlbWw7Wv28o0tKCLcmXYEuUQ/8u/4kLqC
 xX8PiLaz4zsxRiLIsgqKe+TfGP1us6c=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95c2cb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=FLcfh3u1gqY6JxcPP7sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/31/2026 12:04 AM, Philippe Mathieu-Daudé wrote:
> On 29/8/26 00:58, Pierrick Bouvier wrote:
> 
> No commit description explaining why we need this change.
>

See next commit in series using this.

> Guessing, XLNX_ZYNQMP_ARM is AARCH64 specific and is the single
> Kconfig selecting DPCD:
> 
>   $ qemu-system-aarch64 -device help|fgrep -i dpcd
>   name "dpcd", bus aux-bus
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
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type = TYPE_AUX_BUS;
> +    k->user_creatable = false; /* Must be wired calling aux_map_slave() */
>  }
> 
> ---
> 
> My suggestion is to simply add a previous hunk as a patch before your
> "single-binary: command line reference" patch in this series (can send
> if you want), and not add the TargetInfo::config_dpcd field at all.
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-impl.h | 2 ++
>>   include/qemu/target-info.h      | 7 +++++++
>>   target-info-def.c               | 3 +++
>>   target-info.c                   | 5 +++++
>>   4 files changed, 17 insertions(+)
>>
>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>> info-impl.h
>> index 4f6c898c707..045799a771a 100644
>> --- a/include/qemu/target-info-impl.h
>> +++ b/include/qemu/target-info-impl.h
>> @@ -31,6 +31,8 @@ typedef struct TargetInfo {
>>       /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
>>       bool page_bits_vary;
>>   +    /* CONFIG_DPCD */
>> +    bool config_dpcd;
>>       /* CONFIG_MULTIPROCESS */
>>       bool config_multiprocess;
>>       /* CONFIG_NITRO */
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index d775c94d1e3..a60751a4ef6 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -42,6 +42,13 @@ const char *target_cpu_type(void);
>>    */
>>   bool target_big_endian(void);
>>   +/**
>> + * target_config_dpcd:
>> + *
>> + * Returns true if target defines CONFIG_DPCD.
>> + */
>> +bool target_config_dpcd(void);
> 


