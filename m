Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D959C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgvz-0005nX-Ra; Fri, 31 Jul 2026 02:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgvx-0005lQ-7q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:41:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgvv-00004v-6h
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:41:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V67Cj4144290
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8GVF2fqPtaAZZQunJVgfpc+XzjmoGZBfAQulPbNZTuE=; b=FxORd4P7F59VMqEn
 xXksCeJZPOFReYs8+5T42EHey3+v67mpaHlBQIOGo3ImwmyFnwsEcttlVXtu+SNE
 uks5GDClIO6kw7pf7r6GNtqZ68pzk7CuBVEzfs7wUwat5vUokdXku9yXC9SzwLCp
 xp4ZThyTFjn01on1b0HRku6WZFlq6xCK7yfPemh08I2gds68JTvIXDbZscSb+ksh
 SBFLigOHWuhzdewV5TeyiRkHfArvlaGcBrq2M6CbWbrpGnjf/5X+GwxQ8lO8eBVz
 CCd796kpCgjv3HSYUbBpaX/mNZhK67gZHPdo2wIQgp3FlhIP9VC7Yow2LowkeW/a
 NWrnsA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5k0435-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:41:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so4600481cf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785480084; x=1786084884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8GVF2fqPtaAZZQunJVgfpc+XzjmoGZBfAQulPbNZTuE=;
 b=JxFbS9Sg//9+WFlfSuD9VtvFHFSjF4cdjibsHtV/tUcH0wTnI8pfTNsPwm8k4mToYc
 0ooimvr+odsph1RiYsbvXlKZa2j0YCOfI2QS2UetPfLwb+UH4a3C0kWIGa/fBCJnh6CK
 QX08ypnnd+ULEyCDygZj1D8I1s+Ip+M4sXJ0+zWmQS5LLdJ7Ca3VS4I/DVImm8/kPjk+
 e9IiRMDEU6A0QdWN9CQZ3K9Wrs7qh4sIqlZqaN6tsqo1Hltg4DWQXbxz8VwMyDiNfuJ8
 AvWF5Z2cddGNnp5QknR7b9EaJRqRF9zKRKAhCAmO1DWnH4p1cTI6XJa0H4P2d3jhGaa6
 FVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480084; x=1786084884;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8GVF2fqPtaAZZQunJVgfpc+XzjmoGZBfAQulPbNZTuE=;
 b=fBXfSMERsFPk6JLrYck12aYfIxuF3JP/cJjjqkk0WbIvMSbbZsF+01wJ99SuPO91Z6
 WhK/va7Bvp+tg9K5NaWiouut4zRfiuSbPd1TuxVLUKiiT53afQqnLTvxCFiUwQG7NKwa
 DZ0IDTuIybtv4zBwDZncFSPJjKwDwDhWyckz1bfuv+sfDnHQZ0fZ6g7Kr9woT1R/SBJ/
 tH3igewKHR2nRZhwrtpuuBuGTyqiveqjq6Lt6L+5uX6Um2wsJQLtWGXyAAx0npDeV8tE
 R0P0FH7U5NZMkQyds+zUHSJFZkdXz7hbEW/W0fw+69Lvn3Yonb/G9N43kGo/X+zPk3Ct
 itTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHXNlL8A9qA83ADEEcLju8a1nSPGFNxiw3ShCY3NBunoUFur5+Aq4lZiffB1kLtj49+JVyEM/fc/zb@nongnu.org
X-Gm-Message-State: AOJu0Yz7z6V7hWuzeNjHJ6aRxDRt3smwQNSK3J5wbi8tzJJZFIJ0+FVw
 qXBJUXF+PaW/BVSm/DQmY1xjwg0aD4cBRh71cCPh/MmHs/S8OK6mHVuc6nnalW0njjlCTxvf34a
 i5wZnyQGYwOKSS8N/pjhDK4dNFZ6pPMoS3eU76QD1tWn3INVJL0g6SspUuA==
X-Gm-Gg: AR+sD12+JIYA22rzQBkhSjVAb54fK4vqImGauFnZugswnqSzPGnEcXPk4qm90sebWw6
 8mslKDvYHP2GRlHDZ2XURf4PNEUnck6+YkfoPtFQyhq5GFwWDkQhvZLCOLPw1DJbA4K8D4CnVHP
 bkZ8mXU5E8HVeDNFSUyEqakKOLcZLh6qHWRTFRBjjQbSkJDl8pJg+pblJxgDKbZrsuavw6zBqLr
 mDs2Eam08B6ZbTrEFMMm6mn+kQIXDgHmOkJIeMU3hnxuuK6Pn2Yh+x3Iy7CFYTSNEzrxOheZUjf
 Fowck/pymckmVTYZ2Vd+wip+zoH3XyLP3x7KSIqKdF5krUyLsOK8AeyWSiAen0p+8VZuqaQU1Ih
 NAW1zRM25l3WnNe8E8Yp/BB7f48ih1CArQvEL7cB/nuR4Ywu4Zas=
X-Received: by 2002:a05:622a:90f:b0:516:d812:c35e with SMTP id
 d75a77b69052e-52b4afa49e3mr10273751cf.21.1785480083759; 
 Thu, 30 Jul 2026 23:41:23 -0700 (PDT)
X-Received: by 2002:a05:622a:90f:b0:516:d812:c35e with SMTP id
 d75a77b69052e-52b4afa49e3mr10273321cf.21.1785480083203; 
 Thu, 30 Jul 2026 23:41:23 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c6551cbsm279294a12.20.2026.07.30.23.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:41:15 -0700 (PDT)
Message-ID: <2a9588f6-7d71-4522-91b5-c015858b0d17@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 08:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tcg: Add tcg_gen_revbit{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-3-richard.henderson@linaro.org>
 <9ed4f5ac-c51c-4fe6-8517-488913ecf50c@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9ed4f5ac-c51c-4fe6-8517-488913ecf50c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=L7stheT8 c=1 sm=1 tr=0 ts=6a6c4394 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pnALmGF_m-dbqv6PJe4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: c4i9cFpj3FBrkrLEowyyXhL5d8LEiWy7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0NSBTYWx0ZWRfX7w2iK9xjcQC0
 g+iA0kTfx/FYs1f5JrkpI4ZCDTD4vcc9JTcrP4+8oJ1qEc2JE3C6tK46rpn7tzUnfYzdoJj835M
 Lt0BAYkv0NeJYTlBs5W9tj3KrFduzjI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0NSBTYWx0ZWRfX49whiJp7XcZz
 SX5Y3oR+5cG4gxjTJlLNvbxmnctTlf7XTu18lRRuPLjxPxffcb4myOoLTamdn2qBncWnUvC0iqq
 Oe3BfeuUZEdAEiSViCHg6TWDgBwwJwbMfNcc2YYRQ73+O3g9AxTR2Kv2UO5emTU6VowzwRiZF2K
 DFwEyp/zeyJhF+NrgywPdwC90SfUTDmno23icQcmYrL7Z3UVBPv+P+87iiS3j5TBZZs+5L7x7Sa
 Shz1V4ejWMmcBwQYHxfMHhsWSl4GEAqZklk1qn1iv7u24vS5b4+7yJIXx4ypGVPXjKsj3y733eJ
 Zbc915Xew+vusAKr5+FuT06XQmulPUoNyqmZycWpc7nosLRqy/AbQfjuogr5cOEvq2dD4p23dMh
 vhcizk2LAfHg3aayK7a0DhVrozBlP47jRYDx3Ti+4y/mbH+sTKplao88P8Sufm3vOf9XDJxoimW
 MKp90mEmGavzGrrqNTA==
X-Proofpoint-ORIG-GUID: c4i9cFpj3FBrkrLEowyyXhL5d8LEiWy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 31/7/26 08:08, Philippe Mathieu-DaudÃ© wrote:
> On 31/7/26 02:04, Richard Henderson wrote:
>> Add generic expanders for reversing bits within a word.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-op-common.h |  3 ++
>>   include/tcg/tcg-op.h        |  5 ++++
>>   tcg/tcg-op.c                | 59 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 67 insertions(+)
> 
> Missing listing in docs/devel/tcg-ops.rst,

I now see that in "tcg: Add revbit{32,64} opcodes" in patch #7.
Since they are for frontends I'd expect them documented in this
patch, not #7 (backends).

> otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> 


