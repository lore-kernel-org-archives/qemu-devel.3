Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5843C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1crK-0000BF-09; Wed, 02 Sep 2026 00:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1crC-0008WT-75
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:45:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1crA-0000u9-L0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:45:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTbk53849570
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T1/56+2gPo/BO/KS2lkPYAHl5waAwi734gZZr//K8aw=; b=mdl4HeWaclnxwcO7
 PArc6tBJimjiXXQ0HaucCzDYj7i62g962yq3CTWnVB5zrum4yaH6iFMD9KG04uVU
 JuzA0p/2jTWpkkWOecEqC2i3MxD7Gca0EqPsDg3HGDMcklJwoBkfLxoqg2SbJNCp
 uw74k3YGlt4WOy18gE3HY1adAnWuz1lS/URNsbDNxT1aJtwqF9sEpm5LKp+iXVOc
 eLIsc2jEbSi0wHMMLX46m9Sb8cekmI7jJ9EJ+pVTmylI/MweQVoihktyGVwl0VSC
 sM4as41NE0k2ei9BdNj+AezIi3TeT+DVUPUjSfGdoCqBaXAE93P7/1wTEr76qr7s
 JIi/8g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3n0t4yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:45:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9393ac4961fso85798785a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324351; x=1788929151; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T1/56+2gPo/BO/KS2lkPYAHl5waAwi734gZZr//K8aw=;
 b=BUb5NA7mMUYMXfry8d3tVkZtvvb4oTThaJt38ZbUE4+xXRnqxl0B2DK79D5d1sEVw9
 YD3ZGqIxTPyOiW85xMWY/4sncUlSvNtw2+aMPGGuwYL2SWE1jmTE2OxNrK4ggBVyR7rr
 iZaSk6XGsl8ZS7+LWOZ2gJZBkWqZi4HuOE/lOqmRA+AMhP/CK1rtg4cWc/OXE6McTbqn
 Tvqcjk8jGyIgGobQNHgkIjkxIfH4R+/f/LYzUsHhb65w9b8yDLI73Vw/JLjjAJiJt/a3
 PmlrXItFTmYJEB1V8PRhizDLOYpZ1PiSP6nm/p0uAlbnWx5xqcqafzc6v36um1eE1LdM
 pTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324351; x=1788929151;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1/56+2gPo/BO/KS2lkPYAHl5waAwi734gZZr//K8aw=;
 b=poJEpDauR/5xXyKK4lvf+TEFG4drH7Hhz2FjE2T0jCsEn3/PX49EwQ1XoOb9Za4vT7
 Thq3gX1F0nzXipX1CrW9rhlRdC7yyQCR7UVEjYsApo93ZLSSkrK2uTZYQ6/inZOrBAty
 RF6+U1lDaeqvQMQNdcCC4CClq/R8clPxXeGdAb0EkjwXbXHyE/VkVnQy7BoqSmT7/2PI
 BIPKYJqmsNrft1zEEYBWtyNKSlUFCV8vfbpHrM9w3FJRlW9rls0bcD4JJWzxLrPJ6Znt
 w6NP1a3c5awWUvdrO9zEZpLqy5JyZoM9WkHJUW1RWrYGDIs+KcvEg7FXCIP16jATj5WS
 m52A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKkttsSOBNQeWyUE+zXN4L2qpcozrqHJ76jaow1NIAEqdhCetkogd4tvpHXIG1sGkqjcW35uh4wQV0@nongnu.org
X-Gm-Message-State: AFuF++lqScqRtPFrMf7G589sjqcXQhSU7fOcm/TwBwjvmQSfER9Hwkj0
 jcVXzXumPBOVvXFZUUDP7yyXtYwkAF342CsTnAIogRqeqOFeQgxUSXiDQv+fUIvvpiypUxWBmzO
 UkakBg0tyzEEi42O7XeKp8pTaxgRBlnhbWzOVZjRHsRbUDrXajEMG79D3vw==
X-Gm-Gg: AR+sD12Ol9+b9SHA/PdANfbJnC5wseU0H654HDiNSFryNorXmdwUmq5K/V3jgu6aUNN
 AXXK8zQQe2yV7wg1hemG4s2ApZSOTLc80xgFfdOGqDDQsG+gtzkkrGgxlGtNCQ486snMAZ0HGFT
 sUFjKvIU8bQ/mHMq2wVFjY6kn6Vp5g0Nrd/Pc08oxSHwuEt2QMBx57L1tQOhnkKXO8qOnZghArZ
 3wsoBuN7JAxBxf/Si08qvDWiX/emwV5XHDciyd9msN77PBLlxzETONl1ujg58V+KA9+F5JrZ//X
 o1rfP9/FKea4ucUHC/oftwUdoe95VrUrtUmcZszYLDcB9LN35h0bHqmjAstq8s/UWz7IyPWtzaD
 G7pnHwk3+V3kxoZrbOrCvvqI7cZhhB7RUuw==
X-Received: by 2002:a05:620a:6892:b0:938:fd60:4f0 with SMTP id
 af79cd13be357-93960dd7e05mr306037085a.10.1788324350628; 
 Tue, 01 Sep 2026 21:45:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6892:b0:938:fd60:4f0 with SMTP id
 af79cd13be357-93960dd7e05mr306033285a.10.1788324350119; 
 Tue, 01 Sep 2026 21:45:50 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed2e9fsm3614215f8f.20.2026.09.01.21.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:45:49 -0700 (PDT)
Message-ID: <f0091e7d-ff8f-4578-bae7-bbf40b831110@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Content-Language: en-US
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "balaton@eik.bme.hu" <balaton@eik.bme.hu>, "mst@redhat.com"
 <mst@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "berrange@redhat.com" <berrange@redhat.com>, "imp@bsdimp.com"
 <imp@bsdimp.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
 <b5f31ec6d8de83847f8ecf4e8ccc07ad1b9677df.camel@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <b5f31ec6d8de83847f8ecf4e8ccc07ad1b9677df.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX/iApyojFV6ka
 vfde7CLqPOHTLCvyViZukODR1p4ApCTN5ezAB2QrrEPrhrtXLIZuh+oJ4BzDU8bUbvxW7MPRSYE
 U17RBA7tzYHib8YuX7Ai4cGUl8lzGms+88jgdnwmkUljBnHTJH6xQBOWwqAsauq4TvhEagvLMRF
 DQqbNbiEGf0sNS8+x7cxntp+NG/So1O7KJWi5LSOblu0oHzpCcj4XVYJOXokve6M5MsUSs7X9sj
 UPYecKkqu0pxoWx3R/g7QEq6qJUyxSw+gr6okA63+fx9OcOHvakO0fbrKHZMBCke8p0g0kE7soM
 fJB9ST/fh4qDiFAbde1TShz9CCbDs+ROsnw3dFIuTzrYWrnrGZPIgQBJYvUBEnxVrYinubNuyiu
 GJZ0c1ueeBigwUB/IYjXQYNGw1rNsrcF4LLR6+iaKd9n+P14vdRvNyrUW9LFF2LMgbCn1Vl6juE
 sANXNr4Hr0sNd5PRotw==
X-Proofpoint-GUID: 6YZWdQtjOzN5w8ZZuQL3GeXd0Zb2qenp
X-Proofpoint-ORIG-GUID: 6YZWdQtjOzN5w8ZZuQL3GeXd0Zb2qenp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX60HLAgb5XzTC
 hXKEjU+BWFu4/5PxZDjenA+1IebrpBXju/o/FygTWnLGiTMgwaNA9PjRbrXctOPF/dt8vBnhS7B
 XpmAc7AjTr6InWYvNd2MVnEPNjOJNxQ=
X-Authority-Analysis: v=2.4 cv=R9oz39RX c=1 sm=1 tr=0 ts=6a97a9ff cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=JI1JYfJhAAAA:8 a=20KFwNOVAAAA:8 a=5wQ8-i9QzQFU_gx9KFcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=dooCaz2pC6urxjHRPqlL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2/9/26 03:47, Alistair Francis wrote:
> On Tue, 2026-09-01 at 18:14 +0200, Paolo Bonzini wrote:
>> Claude Code and Gemini CLI do not read AGENTS.md.  Reluctantly
>> advertise
>> them to facilitate following the rules.
> 
> Really?
> 
> Now we are stuck with these extra files, which are product names :(

Isn't it the point of ignoring AGENTS.md? :)

> 
> Alistair
> 
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   CLAUDE.md | 1 +
>>   GEMINI.md | 1 +
>>   2 files changed, 2 insertions(+)
>>   create mode 100644 CLAUDE.md
>>   create mode 100644 GEMINI.md
>>
>> diff --git a/CLAUDE.md b/CLAUDE.md
>> new file mode 100644
>> index 00000000000..43c994c2d36
>> --- /dev/null
>> +++ b/CLAUDE.md
>> @@ -0,0 +1 @@
>> +@AGENTS.md

Would .claude/CLAUDE.md instead work? It is listead here:
https://code.claude.com/docs/en/memory#set-up-a-project-claude-md

