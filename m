Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B2606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jGDhXpoE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MQQjFYg6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6dR-0005AI-2d; Thu, 05 Nov 2026 18:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xP6dF-00059e-MV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 18:12:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xP6dD-0005rn-6c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 18:12:32 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6NWF2529081
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 23:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nnkTYU+Q07s/aQwNCQFt5Fct4txIB93fas/Hz/WgqAk=; b=jGDhXpoEfxDackeJ
 NUDabtoOJAZvWjZi+xuaHC9Lg+Kyq/QgxbOCtE/P84ICi/yr7+ZAHsvxMc/J4wV9
 wpD5TSTob9OaXffa6agxG4t6z8r6FqneGmVyRoWwrNl74Ei0F3GjFyBY+IoQkVlU
 mFcfwh6ptPc/Q+VOpjyxE2NAQLhOhnbtOkpd1I3dmSf2Nouromm3gY/N7y1dbn+7
 yAcro0Sd1erRCeeYArIrTgj5CmDhctaMJnfl1yXRKR10wqKWbRRzqvt6MaBeFlx3
 CKUOnO5t0yT1dG+DC57fTM1DPLFzTj+MuHq9ioTv7ajLBuvYse6VmzGUWeutOObz
 275c+A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryw18u2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 23:12:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c817b56adso810916d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 15:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793920347; x=1794525147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nnkTYU+Q07s/aQwNCQFt5Fct4txIB93fas/Hz/WgqAk=;
 b=MQQjFYg6A5bTBR4dhj8a+zLbT4eDqDmNwdCmrjDiFAgyaqwZd5QKpubGOKJsCPcMdr
 J9E7oa1R5tor8z9KM16Fsz3P1OW23XAzFLH8OR/gqTW+L2ZMsuenLG86iO3IlZYGcptO
 LP1Sd+CR/MSEGYrK7OgWtUst2ur1m19M5HcFrqLehQBHyjmvkZDmYrO2uuBsOrgPEVGK
 zY4oX84kOuJUPV2vZWtD2qDAIttu6IBbDncszvSEBo8W5a03DvlaUr+l7JCc+OXzgpkg
 RPwXVVysMuW7MS37MZLjzutAlYqGvbRgYcHi+u49lsTRUQE6xgfsFoVsJhzFRl4FvhI2
 oCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793920347; x=1794525147;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nnkTYU+Q07s/aQwNCQFt5Fct4txIB93fas/Hz/WgqAk=;
 b=ip//KNTawXBLvpe/PXNPBLTbkNOUPn/zq7xKpfxoBZ1ETLGgLUGF/uq9mYyH1BJQHS
 yweCwqvvobb+djXLei3JZNzAF6Fb9puZorm72CWOm3FUmjpvnTgMU8WfqxHvCmKa4JuT
 4gxzz78grb6DYvl/qBID4fZf3iRR9WbWILTHo1IzQYt3a242oi5IuPs/90EsGMmaT7ln
 FO1HcHPTuU2yhOZnByCp63NP+e/Uw/R5GxtqBKCzkDOywFgxv+B4seTVwCKahkE/LOcI
 d6MEtGSlYmudW4QiEZVaxHGY9CgOHn9gJ/SOP1PR/jxngaDq0fwy4JlpF3qoyP+l3/8L
 jHJw==
X-Gm-Message-State: APuU4Z/tlRF3YNjJuCD1l3P7LpvNe3XMD7oBeEqzFQYk35SA0YyY2ura
 ACpBocG7PKpArK9M1oEMc5cTpH5lxdDLS/qqS2pvOdwo30ojiDm2EaFKxXR1KjdIxuz+vujXpwn
 9M9pb7Wpkksw17CiQcgRyYZLxlnmkQ+vnXYcrNIYHrWe9mBbDgSXU1DGqhg==
X-Gm-Gg: AYBFou2yv7LY4rLBsQ7Arfm5Avj+Ki/mUX0rVbTwLI5F4GGD2SAxz4GU3MflrEptg2s
 nrzhfid/P7yUgBSELx1N8zo0tljHu23fT7zP2C2qYE2g0wfC9/bVcdRKi8i2HbTb3vf0SlHLdoa
 GNR48XAgTICV5UzEHLtb0R8aws7TWZZQozwlshpU1Q35Ho+4/WVt8fZEJ/jcP5zA6E9cpUXaCp3
 JG7rw6G2sYtbZlNYsYEq9ZNMQv2vHa5L2GIuY6FVR91F51axfnfDw36E5OWtHO3ZIw1UZ60vSeq
 TYvaRqOOxElWeXhp8xG047I6FIgXpKIUob8KTFv4C92AWVBzbFujzhjpQcofepm2IP4s042EunS
 aXocPExjV058jTgRH094Z1Z77nDpPlVM+YFFOkJrHK0vdZsnycpFndjAp5vD7lv7rhaeV6Rg6wA
 Sic0xQldjDihs7KbaO/R/CZM9cD1kMmjnsx+TY
X-Received: by 2002:a05:6214:248f:b0:91e:83fd:1811 with SMTP id
 6a1803df08f44-91ea9620e81mr8936116d6.15.1793920347142; 
 Thu, 05 Nov 2026 15:12:27 -0800 (PST)
X-Received: by 2002:a05:6214:248f:b0:91e:83fd:1811 with SMTP id
 6a1803df08f44-91ea9620e81mr8935676d6.15.1793920346659; 
 Thu, 05 Nov 2026 15:12:26 -0800 (PST)
Received: from [10.222.169.242] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6ac8d02sm6461556d6.42.2026.11.05.15.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 15:12:25 -0800 (PST)
Message-ID: <106c2295-daa4-42bb-a58b-e9cf8680702d@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 17:12:24 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/hexagon: HLX, search for .new values in
 pair high register
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng
References: <20261105114633.597-1-anjo@rev.ng>
 <20261105114633.597-3-anjo@rev.ng>
 <CAJ+KCYOjkoNu4aKf+py8GsdAB3aib7uB4kWXRV_L+CN+e=YZUw@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYOjkoNu4aKf+py8GsdAB3aib7uB4kWXRV_L+CN+e=YZUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zLEb2mrpnt-jecBb_IMU7Vu-iQhmkSjD
X-Proofpoint-GUID: zLEb2mrpnt-jecBb_IMU7Vu-iQhmkSjD
X-Authority-Analysis: v=2.4 cv=RdYFmFtv c=1 sm=1 tr=0 ts=6aed0d5b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=zAVUjAM6J51uCqfXcgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA5MiBTYWx0ZWRfX3s28iGdhMFul
 18SrdKeC7b+0SJliczyPSYfB1tJpmLfyD94nycBEJWg4LQsCHooBuuyM3t6roAQ3ge3+4o0Li9n
 +0D99GWVJnJTNz0DChyA11FDHIPtbZxpLm2bm39VVHdlV8hrNQ3DhsCQB6oGp+1FTZOYxW3U0iP
 QvB8HULJUvDis1+1dWeTeIFh272jMqmmITT/70fcRzePcO8qXn/CurKou248yzE9/m6L6GmkbaP
 yCWYNI78z/yewMaIBd8nO0lGx76WtEBKnowpB0hxlYyb0DNMLD64bAwmhhk6CQqVdfB+VbaI5wC
 doQMQ64vLJY20+cAq9QSVNDuplU3AsKORAOr8hVgEVPM9tvZPVNe7JpeM9D0poa0zyWtomwu3AC
 9r4mItvwc/PZyTAIOxaY/GHbwhR6oNOTs4BlNJ8fF5QdY3AO2zq8vFc3E1VS7hYdGxjqII9lrCE
 RoYc2lcadUV120IFpwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA5MiBTYWx0ZWRfX99R27r0sxSUG
 pAA3b1a8ZS2B4+J7H4PVrpo1H37oVGBnHoFNXpeXCRsaDIRDundNWrg7f6y04zGH2a+Qm2D41S2
 6b8vF7SavD3atzSnWfmX4H+SeITO1bY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050092
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/2026 11:58 AM, Marco Liebel wrote:
> On Thu, Nov 5, 2026 at 5:41 AM Anton Johansson <anjo@rev.ng> wrote:
>> Otherwise, the following packet
>>
>>    {
>>        L7:6 = combine(L0, L1)
>>        memw(R7) = L7.new
>>    }
>>
>> results in memw(R7) being zero-intialized, compared to L6.new which
>> would correctly write the lower bytes of the pair.
> The packet in the test is combine(L0, L2), and the store is
> mem(R7) = L7.new.
>
> Also s/intialized/initialized/.
>
> [...]
>
>> +        if (regno == lreg ||
>> +            (GET_ATTRIB(insn->opcode, A_HLX_PAIRED_ALU) && regno + 1 == lreg)) {
>>               return i;
>>           }
> This finds the producer now, but decode_fill_newvalue_regno() then
> overwrites the consumer's register with the producer's dest register:
>
> `packet->insn[i].regno[use_regidx] = packet->insn[def_idx].regno[dst_idx];`
>
> For a pair, that is the base register, so L7.new becomes L6.new and
> the store writes the low half of the pair instead of the high half.
>
> Also, not all instructions that write a pair have A_HLX_PAIRED_ALU,
> e.g. LX_assign_rw (Ldd16.w=Rt32.w). A high .new store from those
> still writes zeros.
>
> [...]
>
>> +    hlx_put_v(0, l_lo);
>> +    hlx_put_v(2, l_hi);
> [...]
>
>> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
>> +        expected[j] = VAL_A;
>> +    }
>> +    check_h("LX_assign_w (hi only)", buf_a, expected, HLX_HALF_ELEMS);
>> +}
> L0 holds the low halves of VAL_W (0x5678), and combine(L0, L2) puts
> L0 into L7. So L7.new must store 0x5678, but the test expects VAL_A
> (0x1234), which is the L6 value.
>
> The test passes because L6.new is used instead of L7.new.
>
> IMHO: Maybe we should have a mechanism that creates an error
> if a .new value is used, but that .new value isn't even in the packet. Like it

This sounds like it's either well-defined behavior that raises an 
invalid packet exception or implicitly/explicitly undefined behavior for 
which we can log a guest error.  If this condition represents a problem 
with the decoder it can just be an assertion, but it sounds like that's 
not the case.

For HVX many ill-formed packets are considered to be undefined and do 
not raise exceptions.  HLX may be similar, we'll have to check.

> is happening here. L6.new is computed, but it isn't even used in the packet.
> Maybe poisoning it somehow. But that's just me thinking out loud, doesn't
> need to go into this patch series.

