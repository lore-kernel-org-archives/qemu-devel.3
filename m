Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E8606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DZF7WE5O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ClNlcCMh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJeOJ-0003UP-Np; Wed, 21 Oct 2026 18:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJeOF-0003Tw-Q7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:02:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJeOD-0006Bf-Qo
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:02:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LLQ2JO1766469
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wmkxM8628670kBKYDy/MoSv/plIyiVLWpL+68NWk3qc=; b=DZF7WE5OFInhhXUl
 bLbhBenOQdgcdmG+F7ug0F5FuwfIeTKKR5WaPlgFkQfmPspq7olD3Pj7govt55Je
 ECK8YN8zC7r1wFIKVyhi3vvjJQ0qdY9v/UKuy7hFOZxdGDEs9zRoz9UKsBYWZnI+
 pFiSuRuqKEu2pJQ1fL/P265zfF62EeoAMIR1IHNlv5lXvQtcwg/lCiSLkFUOB6/s
 osal8cajDWAE24UsvXl+dAav4ZUL6hopruhOsS2fkdSni5nEPJglAWWTKQYbic6R
 Cr9BzuaR9JZUWiXMC7/6X5s6wineMYS7/BWYUVynSLXsmoLVnxAxXpa/wNk8GmwQ
 I64HSA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf2cq0rvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:02:27 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso2206081eec.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792620146; x=1793224946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wmkxM8628670kBKYDy/MoSv/plIyiVLWpL+68NWk3qc=;
 b=ClNlcCMhjDzVrVU5DW8IRNfNnrikiDoTR6pikdstdx/kOkd+6rVRZF3X1DcJY3DQjh
 gztINpcgdINBY9kOyKkO9OTEbF5m4lXaK8VUj4ZXQu//yKSFKMbypUwdiOu+OTwFvFxC
 ZnNnIW57ZqI5Ya9S32Jkm38je1dzRMUvNXi+Kwzdree9n1hat+H3oD1h4z8eSgwbSY+8
 UVlG8jhAZaGQGiYeAP4U865Is5VO5bolyln5XpUMWCwiMH7KameE8SEwf/nxE02R3PKT
 2iaUFXbqX2b4X/9MEvR9vfrc7Ms39skCh5PpRuLrAlqoRD1mNXYCLcU4JzVqw68ZWGWg
 PinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620146; x=1793224946;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wmkxM8628670kBKYDy/MoSv/plIyiVLWpL+68NWk3qc=;
 b=Qg0uuet7dQjhsgQ9rTxIycOT8zWL5QFdBwaKQA2aMT/JJCG6RUEaF83mKunjXRZwCx
 f8uPZuXOa2JmQQAkcE8QTI/5dBzK5EItWMdqpAR+RtwJ75H6lHHV7RzV1Qn42A8lm7Pb
 O5LWSoliqOatGPsi7xJ1zO5kW6PRRN83/eCUhsW27jiZiIdC/8L0957afpgCqmMNUNNO
 q7fdVFMjT4YJOo+ILTfZGMIGv0NPBooe2yvTvhnlX4ZQvPvbWvPatEjfTdsZeM8hDYgE
 qBnWE1WKUVmnV2SeaKypRqF0uL6OJ+Erag8c1pEfT0mEaqFVwUMDL81WKhQODnbxwcYz
 ilsg==
X-Gm-Message-State: AFq9FYI4TvMjBJ1ql6XWSRHz8fHYz15bVmxa4FL6G18haAxCKkGUQGhU
 jXn17fgB13pN3RuFV8J5IPQY9LD5w02ByMqs6te/DGpOFEBWz03Po0F+Nt5rugjcf1IjwssfAJB
 KsQ+vy4bUL61LZqiGuimTKW7bQrH1RnwpPlryzYNWPJtqHg+iFLqIC54kOw==
X-Gm-Gg: AYBFou01NtmkzuMMrqquQFIm0Tme6VaGxVm0ZyOmLgODhYk0vVv6oVaZz/3laTy5PFs
 EQryct1lhes/RRiZ8iIflAdt7vE74birGsOufh9+WTihyMl1J++ieZprQuX2AUtjInWE6MxKZZ6
 kSFA4e41O69u+j9qcjAP5xY5rhmANCwGwJ/s7669/Md1itcqrHijUZ+hv54rO38Ga1IJOof6OTn
 Lsr9Vyi2G6jOJkmtD5jA+hzXhJCv2X/p4mxvAsCbCVK7BAlfolkFqzMdOhlT2fw3cJPKmIoa1mf
 mb2rzFNiNuKVREITuqO+8U6wZiYcmlQ5r9gt58+CIKf8oS+1Pw0g46NgzYR+Kjs7fIqTEM7yN5Y
 l7B5NobwABDMIMOD6At/t7vQo97UMuPjnWN4Git7ITN0sprbzO6uxJmWaWNZBbSdtAfzYLg==
X-Received: by 2002:a05:693c:8804:20b0:360:ca2f:ce6f with SMTP id
 5a478bee46e88-3674a515048mr4900583eec.1.1792620146062; 
 Wed, 21 Oct 2026 15:02:26 -0700 (PDT)
X-Received: by 2002:a05:693c:8804:20b0:360:ca2f:ce6f with SMTP id
 5a478bee46e88-3674a515048mr4900526eec.1.1792620145434; 
 Wed, 21 Oct 2026 15:02:25 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cca3d8sm10223648eec.14.2026.10.21.15.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 15:02:24 -0700 (PDT)
Message-ID: <e5c61cec-24eb-49a5-b9df-81cf4072635d@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:02:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/21] target-info: add target_heterogeneous
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, anjo@rev.ng
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
 <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_78JWfKfs+5ek=6E50gjGpeRsoVe1meu=gi7FunKcjAw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_78JWfKfs+5ek=6E50gjGpeRsoVe1meu=gi7FunKcjAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HLhWhYtv c=1 sm=1 tr=0 ts=6ad93673 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=G7MAsxoASZJS_0Ijl7IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 2-OkAM__rfYmZRf-5ZCwUEvTVue5JzIW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4NyBTYWx0ZWRfX63GwStTxhjDn
 OxGCWf3yrtKr8Ou04OfFehLiL6bJTV+Q6X8bCyTcoK14e3TH6B4teJynE+GQGpi9SvzGo0kX8z1
 RbMBudKATd8q1Ffct8KIpcI1hrgvak0=
X-Proofpoint-ORIG-GUID: 2-OkAM__rfYmZRf-5ZCwUEvTVue5JzIW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4NyBTYWx0ZWRfX9Lp2KjOGkp8B
 EZCkWu04fdh28ryqpU8a0S095gWQHkgWCcNsZdO5I1alIPCUXk6gMuheyrdsrI5Qy/0NOilQTrs
 KOCA6mqA/cmHoB5gkT4YPh/Xi3uFsBRgTZB5Qe+G1CT6Vh3Div4vYBUOMIPboXJvr88lIWvB1q2
 a605RpFnZmJspF07mBy6e4Ncz05Mui++hv0KMk5xqtuDypJ29PssYSR7sgdqKJLUcuh5xl1a9ZT
 /cWo0fClA/QE4B/BJ32wE68gZ5RFAPGwYeTTufd95RQnYQa4sP5gqguYndrlcAs5uAQFNolkDW+
 0V3mUqdYDa+ZXwpSxz452cf9AwKfRzT9FCHH1awEhey3tFp11dOOTUJR3TzPNAiOfMZs9Fzom1Z
 ykRvF3XIfnsAgOyWtuBiQu4lSEjyT5fawDmtCVOAXsXnz14mXkAj4NzJUBijuC4RtzPKk/ZDRVJ
 M3Q5p9OV3nnnqh3SWvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210087
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

On 10/21/2026 2:53 PM, Yonggang Luo wrote:
> On Thu, Oct 22, 2026 at 2:14 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> For now, this function strictly returns false. We'll turn it to true
>> once heterogeneous emulation in supported. Meanwhile, we can use this to
>> add various checks and asserts over the codebase as reminders about what
>> we'll need to modify.
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  include/qemu/target-info.h | 8 ++++++++
>>  target-info.c              | 6 ++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 862097c6c63..923c00c917c 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -42,6 +42,14 @@ const char *target_cpu_type(void);
>>   */
>>  bool target_big_endian(void);
>>
>> +/**
>> + * target_heterogeneous:
>> + *
>> + * Returns true if current binary has support for running several target
>> + * architectures at once (heterogeneous emulation).
>> + */
>> +bool target_heterogeneous(void);
>> +
>>  /**
>>   * target_base_arm:
>>   *
>> diff --git a/target-info.c b/target-info.c
>> index 254530d8ea5..b8a4a7ebf7a 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -42,6 +42,12 @@ bool target_big_endian(void)
>>      return target_endian_mode() == ENDIAN_MODE_BIG;
>>  }
>>
>> +bool target_heterogeneous(void)
>> +{
>> +    /* For now, we only run a single target at a time */
>> +    return false;
>> +}
> 
> How about place this in stubs/target_heterogeneous.c
> So when do multi-target tests, we can override it with
> 
> bool target_heterogeneous(void)
> {
>     /* For now, we only run a single target at a time */
>     return true;
> }
>

At the moment, even though multiple targets might be supported for the
same binary, we still run only a single one at a time (same in
single-binary), so this function will return false until this changes.

Why would we want to override it today?

Regards,
Pierrick

