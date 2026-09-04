Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB105C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TbX-0002uV-TA; Fri, 04 Sep 2026 09:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2TbV-0002eM-AS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:05:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2TbT-0003mN-AE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:05:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIJYT4053756
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 80txGaOCQ2QR8GeyFrStLRiv9q6Gah7s5Supl1xcL4Y=; b=RK8Q67bEM1c4zpQz
 k5/DNRUeGt0S6PeQZLpNMBf4yaDVQ7auZMA8gI8E3acVITxNarNckHtCdXPe/kRO
 wUpu03VZUEb71V6TOD31mIY1OatPkQ/Ertwn3zS/rVHPLlRbxT8NsOAlDIxB6VZ1
 YKSq8trKzPjxPD/u4IHErOEG+Vel0eD+0AzSjkc7w1Lxfei7x6Yb5m7EvRjHlIah
 RmUXrdshVKBd6yjz5qYmHY39dreBAwherUiJFEG7TdyVCw1g4nT76lpXYRgokaYj
 mGi8abF6R6VyK1KmJSzwCs1IcxcnfBqxal4oDHEseRRsyTgin+JaynFpXVJ15zXy
 O8spIA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfbyvmdcx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:05:09 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c683ca769dso296916e0c.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788527108; x=1789131908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=80txGaOCQ2QR8GeyFrStLRiv9q6Gah7s5Supl1xcL4Y=;
 b=NRfQMJa6vtAgdm4lhj3iUMr/jb/qNYs4oS/Kzfoc0Q4WMSVPiBwYkVk+agtXARAb60
 URqrK90iMyPLPmGEy/iFWAvMZkNdvAc4U4Fx1Y0ieqOybjhcixvnQ6kOPqycvygskgAV
 Qf0oYsC1qgBR9lKP+oJ1fGYfoHfd16d7Qsu4nSnOxntnaMpdSVV17DElcCT+PXZI4g4j
 QWy1CBigWQZI1r2xvw0Szq5/nHhtMMQ7NrMrRyJdg+swzIL0lG7LKLR3y+QAPgoZsIyE
 WQYQw87+6YVt8uzu5uVM54WFm11aTAxIlR7+k6zEInwse3rsF0KiD9TAR0LfztmblQoD
 ETIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527108; x=1789131908;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80txGaOCQ2QR8GeyFrStLRiv9q6Gah7s5Supl1xcL4Y=;
 b=NHkvM1kcAQBD+/ttZ4Xl9tt33cNFkFq6hR2K1cnsxQonrARGqLRqUr16mrZU07T4GW
 +u1GGgooGE1kfWoLgR/OOIj2xVnmq2FK5QqIAePsa8dwj/s9YprSj3mGymub9MVnWbY8
 qPq7BXPBKw9sUao6qeeGoC6za8HgFMZHe0Y8hCW1IYmwPitnFc0Mwz7JFWKeW199IeKO
 Atlk98aVoQWswKjlhiCtQpnXYds1aWPnZ86BZpgAuUt4YYzbD6NeBHwlAxExbi/D667S
 v0CnCIkqSiX1lbDC1g8rkoNsneDoUq7O+sjYIDkAcF+HTdtxZKqsFo7efE5DB00YCyu+
 QnKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCTNekWhLQgz0e3JZqENHhTFoAcbCTlTaaIwJI05pu9YGeHm88uzQU9mXM+UZU4iagR+aag3+eZPkm@nongnu.org
X-Gm-Message-State: AFuF++lLTbOQuetgxo49QTqY2xh3y5Eg8YVXP4FQBjBk+0sLQ5oAoNy4
 Atu+ioizDveR22Jntfz+UjRvTWfnbZFI9cOZy7YMEqqQGyMis0Rr7INKSIRltS5aSpj6HXd8in/
 tXXc467dt45sNfnu3LvFOXvys7DSilx0gy903i/PdAawIRFWjV6zI/c3vyA==
X-Gm-Gg: AYBFou0WAR7Ci5u1KtNkFGBs4044y1omNmfeH63uEq2VBf9dKO9zhnMpgyRqbo2iSnx
 xA+5mbnkEMATwWg5qEd3Jx0gfFrtqjWpxZAWf4fZKjh6z2v12n7WUc4P5xO9S6Et7WkhZRCOjTE
 fPIs1mWHUHDzb36Vtzz6iteI1oEpldvUL7U48G3D1ZOQ8JXPoQL+Buu79W5C0yy+QJiCV9PetWE
 HMH5fNYPBzd049421p7qg8gPRbaR+q0L8ORLEGfqObcOjiLMw1ce/H05NiOaPOf/Ogp0NiqiIt7
 bKEQp4JMFynGFjGRjvNGWPr+7SEXQMqgf9Ri+zWN48VByg6DlL0Z7OM1/Ce6hYKykh5fmdfMpIC
 cW3YT7Hty8w2aj2roaqou19+QbJY0LXiHww==
X-Received: by 2002:a05:6123:2c8:b0:5bf:b3a0:388c with SMTP id
 71dfb90a1353d-5c7ed3e2247mr2365069e0c.6.1788527108216; 
 Fri, 04 Sep 2026 06:05:08 -0700 (PDT)
X-Received: by 2002:a05:6123:2c8:b0:5bf:b3a0:388c with SMTP id
 71dfb90a1353d-5c7ed3e2247mr2364980e0c.6.1788527107692; 
 Fri, 04 Sep 2026 06:05:07 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm6314943f8f.27.2026.09.04.06.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:05:06 -0700 (PDT)
Message-ID: <0a611e26-9cff-4770-88b6-9eb6429dcb89@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, luoyonggang@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com> <87h5k58ds8.fsf@pond.sub.org>
 <apqrE4dj6WesobJv@redhat.com> <87fqzp6xk0.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87fqzp6xk0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hefmBXPZESbAepkPfwtHApPRhmBx11uQ
X-Proofpoint-GUID: hefmBXPZESbAepkPfwtHApPRhmBx11uQ
X-Authority-Analysis: v=2.4 cv=C8vZDwP+ c=1 sm=1 tr=0 ts=6a9ac205 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=3vyLP1fcN4YtveY7SR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOCBTYWx0ZWRfX1lQxWXw82mJR
 VKGh9JXGivmfHDycVrdRepwNmZLPq5GVF/2ssAUq4ys6/I0gOi8tTklKptOCSdKtlDBLhdt6Xli
 F6340EtdqNKXY/PBr08EzXp93dc+lMTissZJW0dSNhcZCJaomPs2k08X7xrtrHsTO+oju1DBFPf
 ZO3wVzYKFHXZa2uPz37TZYPnSJdHanr4d5kDyswoGOW/44CgPNNrZPUBSn6CnL92uKxNtEkC3++
 IHR8yZf+AeIrxzGxjDoUy5GDhHPHW0pI2z66M2TF58hjB1VUEgJLbRkFK3eBM8/sUXM/cvF84kn
 u7lcfv3SuMafuuOVUOHGgffD5Jl0mX7UN1BnSuKZea3l9KvcayhDY9XVTdSx9rhPXlyeJw0oGcY
 gsDg8YfJi1QJF+FzTErFycfW0cPJUgYhdlXxBpI3d7yup3Ap6Fbz4nODf3buRc5/jayvzpFloYb
 Ao1E+TU4NHLzCm1msLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOCBTYWx0ZWRfX7w1wuUpaCHzP
 3uEEOozzTwxwb891VgrHKQ7e32RTYXgAyhvZ95d9CLyiyXHOpk8wuq6Hm5xPE+zM6meXn+i+uMA
 h0LnnigMm6GcJCsq0jYPCHdUITpnLNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040118
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

On 4/9/26 13:55, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Sep 04, 2026 at 01:19:19PM +0200, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> [...]
> 
>>>> IMHO it is best if our goal is to ensure type names are unique
>>>> throughout the codebase, so hopefully we don't have clashing
>>>> device names.
>>>
>>> Yes.
>>>
>>> Quick glance at type_new():
>>>
>>>      if (type_table_lookup(info->name) != NULL) {
>>>          fprintf(stderr, "Registering `%s' which already exists\n", info->name);
>>>          abort();
>>>      }
>>>
>>> If we have duplicate type names, they won't survive being linked
>>> together in a single binary.
>>
>> If we want perfect testing coverage, then the main constraint here
>> is how quickly we get to a point where 'qemu-system' can build with
>> all targets. I don't that's a show stopper though, as the uniqueness
>> only becomes a real problem as we enable each new target in the single
>> binary. We don't appear to have many examples of existing clashes to
>> suggest it is a major problem to solve any sooner.

The only thing I see useful for a 'qemu-system' binary is to report
"sorry must be run with -target foo" then either have a script for
each qemu-system-foo which call 'qemu-system -target foo' or use
symlink and parse argv. No need to alter the test suite at all.

