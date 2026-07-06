Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8962EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpoX-00082O-81; Mon, 06 Jul 2026 16:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgpoS-00082C-T5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:21:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgpoL-0004Oe-KW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:21:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE8bM1654904
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 20:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hKiDJ0WXFZthsu4XQ3T8S6sVCouPdnC7K0HVly66C+M=; b=pxdkmvvdIsweBTtK
 p9sGaIsIB3cXDkEKErS2xbx0hsNykB1Dl+4tfbuHzIvja0Yht5Fp/zQW7jVeMKFG
 VyogNXuZ5JcGVr9HEgLp6ZV3LqPza39DNTM5f50qJg0mrZX25JorMh7tjqQC42ZR
 LWY/Wzb7hEFybfXV2B970/EdIhlVesCUS+Qh2PZ6TQPegg2AWzVzJ+B2MdELfkR9
 4sdfyNNDb3wfzrHIN1rlVCPlPheWeiKQj0xTBCl5KcDaGy8Lzqy6oM8QLs2eT5P+
 vHQkPLsW1yD21vflJwoZunNprWzFeDXZOK4+A/vbRLkhM7bZHqaforv1OgQ6L0eP
 MCqyeQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpju7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 20:21:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e55f0613cso273904685a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783369259; x=1783974059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hKiDJ0WXFZthsu4XQ3T8S6sVCouPdnC7K0HVly66C+M=;
 b=cJ2petbCxQaOmkA8C4eF1wAg7kpqSS7o1AOKPpbs0q8iDK6UqQK9Um80wEVQoDwpGq
 7gWju86qQ1vaypMgyH8/4Bk7Fm2gxcgPnPZT0F2XDF/3SW4vSsaIEdhFUlcZtg0iEojs
 sNsw1DIkj3KTccc8PSDYlJxQO8BnKVX4M5bvlv645QaNafMDEc4AAYsqKdciEjYoukWp
 9zRZ0gZN8lJUWcZDyDW2+bXxVGlphrYHNr/qV7OQNMywh5ZZrJaWW/BEkALyPQNvwFdp
 zQUerBpMwQrWTAdlHY4tKGDQMN3Ysb+s5XSohmys/1Zad349mVYopvuZ6ppkAQNRM/Gi
 TSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369259; x=1783974059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hKiDJ0WXFZthsu4XQ3T8S6sVCouPdnC7K0HVly66C+M=;
 b=LAHxAxcFFO1rnOZAQtoHmihGLJ9+kaKj7Gs41ivYr4jPQH+q6idmpqAOxVTEh/U6qm
 LmEGvSPr7ufiAHZimWWCsUwIqQHu5uW8RKu5BXU3ns4LQVzGmwZb/QcLOozaMh1xrVvz
 M2MfHOq1UVw9R35x/G4WqpegDYlxsKEzPwGo/wnGiCinDQIaFmygPwU0p9ETPGx5BeIF
 7+fiyGAUJXMrlUAR0YO9V0G0cHSjfc/VDGR6+dP8kPLMlCmr75gYM/Iics0ll8sx5bBM
 w2PWgxwMLZ2evTtRr3GLRkg1njILtJM+spWXwzAy0IrRjanD1ymm6hsQ78k3N9qLAwxI
 kW2Q==
X-Gm-Message-State: AOJu0Yx6iutMn7VsiOstllD8VMTrcCNwSh5ImH7L8EYXn332t4PTdvY4
 bV7xh4Wj4fKA81gYgcO4KwHd3azeKkh6VeLdZPGFGeISaeqc6mxH4JEo/cXut25fwpJmFAmS9ff
 zxAMN6dZL0BqFG0owPNd9Ed/9R0hzVx+NHE+nv8H0DJ1CicjDePzbwkQ+1oBEX8o7zA==
X-Gm-Gg: AfdE7ckcBfQEXOJJNiVvAtkqmMcmyw6wHKfvNKpB1Z+9UZ9LnMsdteAzh2HweckcLBa
 Y5NRxpYVKk+a4Q7D6dPZhS1+1tKkC4ICtsa7kB+9A6GngvZNvr0zdWVENETYvaoePL/pzGJJML6
 QICWDi6F3LlLd6dvhQBLk7YkTmDoy+MttL+5XMiKLzWpDqsA6HCbJEP/mBppqlWp+n1bgK3+NbP
 yBhi4GxW8eh3u4ceWfdfiSH5EDLEIyvEUKRybhzpcx9H8O5KGcstRx/wWTqPv4MQGKtRylRaPAm
 8Y6SVRpZvDFw97pfRtYvbJa/lPPacz4sfoXkA7r57oCfIzjM4nTNYLoZ1UbvQmtR9hlHLnXuIBd
 9951/EnhJRO+C6oA5WtWHMVS0pLGPLqu1Y8K04Jbv2ZZ5DzpbOFzM+UiPtnsR7g==
X-Received: by 2002:a05:620a:3188:b0:920:6061:816d with SMTP id
 af79cd13be357-92ebb3a6413mr290355585a.0.1783369259300; 
 Mon, 06 Jul 2026 13:20:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:920:6061:816d with SMTP id
 af79cd13be357-92ebb3a6413mr290352985a.0.1783369258874; 
 Mon, 06 Jul 2026 13:20:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm32053782f8f.17.2026.07.06.13.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:20:58 -0700 (PDT)
Message-ID: <1b1bfcd3-8fb1-4fd6-849e-870a3a67d826@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 22:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/edu: restrict dma access to dma buffer
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Torin Carey <torin@tcarey.uk>
Cc: qemu-devel@nongnu.org, Jiri Slaby <jslaby@suse.cz>
References: <aQtAotYvzFY0Vpft@tcarey.uk>
 <CAFEAcA_ZDvuCKGrGZuUYFQKL-7cG3dcNVgyo55P-WRMas6e4VQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA_ZDvuCKGrGZuUYFQKL-7cG3dcNVgyo55P-WRMas6e4VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c0e2c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=2XLBikMUVQ9jIhc4Fq0A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3sF2L0eU84w9-n1UYd2-8AhU3_UZB_r5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwNCBTYWx0ZWRfX9QFTflWJQU8y
 7danWwRV84pmRzDZ+Q1B2lrAIP02545i7dbzg+fmtXZSusrAS9DtbCFeLYS9Yd3ELJSAYYIZBy6
 P98w6U9Qaump2dwsvYhRGyUFb+aICizIYohTfxxjoGP3fqftpOuSNWhtjECATRqcJoRpEe4bOHv
 urtgQYR/xVDxi2u5W81x7fjeiGKw0mzl4Vsd3ocdOumq7EvEiWUox5oS15vxnZEcok01d4Xto4i
 0YzyqFABsxVTlk6AaZ76rvL+9pFb0ZZoJ1AFI7C/DcnfW6p7xWC202jvY/qmAb4O0FPZXjAHxSe
 mqcGofocLAk7IevYFBOe/JqWEZvOKdV09HWQYbOsQFt5NQZOWtUCrLDC4HigdsUF3FqM8af9fws
 2n59bbPaD6mmicPobjT66shfnyFZmkvgCUeamGZpg646foDPFJsNvhU8szlzsGKQyuvulP0o0fd
 wwg7ms+NkTfQF6kFZ1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwNCBTYWx0ZWRfX/Et4emOU0SnX
 CCRmwTS6SZuMuJjbbqAx9ASaIzgiXDUtjTmEj50V0exGXkBUzcrHV3nFnBfcBoDAJTXwK0m0Jtn
 hYbnVTbk2c2cDMhHoztfI0xcQZgMHdo=
X-Proofpoint-GUID: 3sF2L0eU84w9-n1UYd2-8AhU3_UZB_r5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060204
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

On 6/7/26 20:01, Peter Maydell wrote:
> On Wed, 5 Nov 2025 at 14:39, Torin Carey <torin@tcarey.uk> wrote:
>>
>> The EDU device doesn't enforce any bound checks on the addresses provided,
>> allowing users of the device to perform arbitrary reads and writes to QEMU's
>> address space.
>>
>> Signed-off-by: Torin Carey <torin@tcarey.uk>
>> ---
>>   hw/misc/edu.c | 24 ++++++++++++++----------
>>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> This patch got lost because of a tangent conversation, but the
> bug was recently re-reported as
> https://gitlab.com/qemu-project/qemu/-/work_items/3852
> and I think the patch itself is good and we should apply it.

Patch queued, thanks.

> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3852
> Fixes: 7b608e5d6c1 ("hw: misc: edu: use qemu_log_mask instead of hw_error")
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM

