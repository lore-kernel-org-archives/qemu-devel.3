Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E652606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SfNs4wjY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HdjEdmC7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZP5-0007KE-CB; Mon, 23 Nov 2026 14:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVZP3-0007Jn-8I
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:08:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVZP1-0000IU-Fb
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:08:37 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGHB091094045
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tc96+HNUF4JP77eSDXbwze5P6m6pHsRagu19594Xwv0=; b=SfNs4wjYrAcVPDyF
 XEb7o2hh+pYCGmMeW9kB8vC0isow5r9cBJDDn+tVIUTBPmUI+4KTCXPMxPGOpkDJ
 kXaIXDCN1kpiaPsQyghJTavCjIdShCKWWmPp8/yJY85LaUNuUBqsuiXgLGvVRbfq
 2MHdu6La1FmsQLMsxYqFcxFg6SfPiTVo9++jbArTzGo0Mo9fltKcXTciTV2JAzt5
 ifOasKjlY9QAkNsG+uDBbk7oLHVMoYxLrfD3Dy/0PBt4x1LCC2FoRoFcXGaxp+ue
 A74QTU9qmR/w4bl5XHaBOHIJ34/owBok4d+v+2VRAI5BZvMKJ2smPCNQdgP6CQYq
 Vx/T0g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0sxwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:08:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9212335e257so75179526d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795460912; x=1796065712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Tc96+HNUF4JP77eSDXbwze5P6m6pHsRagu19594Xwv0=;
 b=HdjEdmC7bq31oLuCh3/z9ut6zu419HbsZBFrsh66eapz6d++h3462LNUEyVTQQv4bu
 rP2YUnDE6UYA4+ofiVBNuvgpGp24GM60vkQLA9QJVUQ6++3yStCVeegVhyMMAU8NVqGs
 CjJoO5JNwA+yDHRYHrec+TMohIl3zxjKaN9Z4IlEjIATAW2OLUICC27GcQtlipplbdZX
 2THUePXdB5I8MdcjQ+I3OnJNnNs0GduzdM5j+nU/Tw6ircoMFXaLVL0a46fzDfVE+LME
 2C1pF1CvX7J81nDAHhCBB5/j75NKej26/m4KHB2BkBRH8+xwjStpuXZT4ZFq9Fa/gk1g
 /fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795460912; x=1796065712;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tc96+HNUF4JP77eSDXbwze5P6m6pHsRagu19594Xwv0=;
 b=WfeL+Eok4wFDTH4YBc+2Cm9tniglUkYhjTyovJR50jSUhuZYQnp/vuXkiLAol46cjv
 iAhmosJSDxI9zz6OSQHnE2598oT8SkB+xuWqcpo3nOkFdA06qdQ31LySl1fTZXkWgMjZ
 vhVOs9v/bYLmXHku+s91/gmWI2rjXEhBifwuS72FXnu1juyo67aLsdhcgdZfO2/RI5W3
 Nshq8Ty02NIh8zvWVxj+hYWNNPJ2Oh9UexsLEjmYczooKYd0CW3eT/VJhLsNtjXG6WCw
 UgwjM2L85mzy3/KIV7h2k/aj35bDaw1TVD+5Rk5Ugklendkc/VJLFfeExH2YaF5ev+r9
 cq2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHc5yR8FThGQzyuCUmO7ejaYRckV4xwJMuOl/sikU+kOP9cERbtaPV2zS5wr1ULMPXsWpEVlOd4msJp@nongnu.org
X-Gm-Message-State: APuU4Z+6mSH8OQlvkO5MP6nP1ll1baX8VSmsoEj8Tt3FIZQ+ITYcg77k
 4nuh+HSakJeHVY84yli2AWeKJPVCOEXqeNe5sj3LmhGdajpe7ClLPyyKbMMYqEtyUgkIzZFiX8N
 VMTmbvfd/93lrs/i4YQEAe6Fj56E+Qxj94Wxz/E1tSs0znQGCixgBh5Vwww==
X-Gm-Gg: AZFdTZdN8cjbJtI4KhWlrh4f7yD8ppixVQoxeo2pYH1XutRGzhyBihToLOWIrypESNb
 YT/P+4PQnLMe6+nGo42T/P8jH1ADH2ViMjyXfJZ2aQ2lh8tlMepa7aR39jFFiuVNPWhzxY/CW8p
 sneS9SCV3/T01Bo004FX41CA+sAP/K9c8Bc/umeiHXphHSUqO0MHnPQ2mstGg6viKQexpo/3MLd
 i9TOqQY456RpROb5TwBy/ZANfatxcPrqOhicY69Ihkcw/SavCUKF8YSHnnz9ch2STT6dADBv3XE
 hvjtBpp2vdEPOsBc3ELNmQgFDYHjUY7FkGv55uXdvWpDoxgClxLSyCLqR6pOsa3v3aGdYvlKxFv
 8R3LIwbARaw+YU7+ICFHg6/uMkWIgOnTzFm1TtUW78qb25bvc8YKd41llFetccDKVPsz9E7HUmy
 bkfRJUdPt39ydVbPzcVIlM5glslDSMaTB8o/1/IQ==
X-Received: by 2002:a05:6214:3107:b0:921:404d:f460 with SMTP id
 6a1803df08f44-921404e1bc5mr176469716d6.23.1795460912224; 
 Mon, 23 Nov 2026 11:08:32 -0800 (PST)
X-Received: by 2002:a05:6214:3107:b0:921:404d:f460 with SMTP id
 6a1803df08f44-921404e1bc5mr176465526d6.23.1795460907920; 
 Mon, 23 Nov 2026 11:08:27 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349cdfbasm113526676d6.17.2026.11.23.11.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 11:08:27 -0800 (PST)
Message-ID: <bee23a9f-2779-43b3-94d0-4169ff7e7ed8@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:08:26 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 10/12] tests/tcg/hexagon: packet and COF
 corner cases
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-11-brian.cain@oss.qualcomm.com>
 <c64c3c72-ce3f-4163-a8a8-bf655391c10c@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c64c3c72-ce3f-4163-a8a8-bf655391c10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8Mch3Bws3JBdEjQUBugzOpr-a02thZdu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3NiBTYWx0ZWRfX2xYkQQzy9w4e
 1cVaj4+l7Ypmd3G4FBeoaW7DA4JYHd5SGcAEIsbHao1vYrExg3yxOFV+9UUel/vpZxqfh9n6IRf
 yafxvn4IP8nO7ZdUZgerRlnSp/csZj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3NiBTYWx0ZWRfX8FlFjbT+Hex+
 lQs+dxsjPSV/pHoNXz5UDQM/xZgb71cK3gGuS0/M5eD0baZ2T4EuizrOOz0niz4wghC1gvZmk+8
 ExA49e4YN+RWbMRKH0wncCFoioRCIq0WbrzMOyU2hMc17OEmlG7bnMv7GGp0QB5QTDhbDTMwy63
 E/+dO0sE6ZFiVsZjSLjc4BszxHWznJ734pm6Wvywp6KSu9FOf6PB3eJqIwgpq3QVhO01FVKejuz
 Qvz0iPMER8vdAbW3o7J0O3f1FnJDYYIQ60A85Ciu74QIrLoHXRI8c7vE2Fzn2/llZhRs/yrJ07u
 Xi/vRuF7D62fOMXCDuBlbPyjxUuS8tjlvAE45Qw6cJh78jWx3A3V6xcWBBylkiX+Mz/LNLXTErm
 0qbsI7gYEz6gjSaygsj882yNzEiqZ2wllkdmEXPiItCpCKckeDthN5ZU965GjHucRJHvrUleMAp
 yFlEobI2lieD+oku8vA==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b048f31 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q8NG-HKG0uLb35l276YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 8Mch3Bws3JBdEjQUBugzOpr-a02thZdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/23/2026 12:06 PM, Pierrick Bouvier wrote:
> On 11/20/2026 10:20 AM, Brian Cain wrote:
>> Add tests for subtle packet semantics not yet covered:
>>
>> - Register, pair and half-register writes commit together, so parallel
>>    reads see the old values; .new store data may come from an extended
>>    or load producer.
>> - Packed pred reads see the old bytes, auto-and before .new
>> - Aliasing stores, cancelled ld/st does not postinc
>> - Dual jumps, callr through LR, an overwritten jumpr target, and short
>>    sp3loop0 loops
>> - M0, CS0 and M1 updates in a circ/brev packet apply to later packets
>>    only, and a saturating add reads the old USR.OVF before setting it.
>>
>> Link: https://lore.kernel.org/qemu-devel/20261117183629.2002840-4-marco.liebel@oss.qualcomm.com/
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/tcg/hexagon/brev.c             | 25 ++++++++
>>   tests/tcg/hexagon/circ.c             | 42 ++++++++++++
>>   tests/tcg/hexagon/dual_stores.c      | 34 ++++++++++
>>   tests/tcg/hexagon/mem_noshuf.c       | 58 +++++++++++++----
>>   tests/tcg/hexagon/preg_alias.c       | 58 +++++++++++++++++
>>   tests/tcg/hexagon/test_cond_branch.c | 95 ++++++++++++++++++++++++++++
>>   tests/tcg/hexagon/usr.c              | 33 ++++++++++
>>   tests/tcg/hexagon/test_dotnew.S      | 34 +++++++++-
>>   tests/tcg/hexagon/test_packet.S      | 46 +++++++++++++-
>>   9 files changed, 412 insertions(+), 13 deletions(-)
>>
> Should be split, ideally in its own series, with details per patch to
> explain what each new test does.
>
Makes sense - these are not critical for 11.2 so I'll omit them and 
include in a future 12.0 series.  Thanks.


> Regards,
> Pierrick

