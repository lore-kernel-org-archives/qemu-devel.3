Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F6FD9E3A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw43h-0001VY-VH; Fri, 27 Feb 2026 15:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw43f-0001Ux-Q9
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:03:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw43e-0000Ts-Am
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:03:31 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0Ipv2167500
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pDHL5/sWqgqbrG94mN026T8E4mtZsD47FQXehS9P/K0=; b=WpLIHJ2LhktISaqh
 QtUZv0jswc+bzhE0jFWdc6C7UTp5RcSg6nNkjezFMr6xsNM6k1Jt2l6WRr7sIIDG
 5D+/k801R0RzmsFuttMgDyTVSyulhMeBOkKhmsENLJ746UOe5u6T9cJLiDvr2N4k
 zhq07SBgS+AHumOfONFrR52bmMfsfSZScP7XJpKl5VvefdXM49/EJwlRSEFRcNeh
 64TfkV3j7A1/VdcxKUN3y6s1g/1ACMgkaA6367WfwxGmRDmeIbCV28vhnQGuU+Cp
 ATHf7eNBeV8qjUPleH+AQuv75Kf9To4/9KHuu+883q/dXzhEz160tKeSE2Ub/biG
 PW0rLw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xv2h6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:03:27 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1273665df8fso3838881c88.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772222607; x=1772827407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDHL5/sWqgqbrG94mN026T8E4mtZsD47FQXehS9P/K0=;
 b=BDzvHrLKpoI+JdKQpRv8g1y6yLE+NeQPnGNU+hRM9jcGlTsOtLaDtocgHSzZ6IlUNu
 OFD+W1tAEikelHnO93oFV+7KDdAneEWrYcaGr2Vz1QhDqvrpIv0JXXAxolH5OgHG1FAU
 677niz0Os6if1JX2aN+mXzEhl1uzqXJqSIPoUlKqEW8q9FGGOhcEtpp7EEE4LrePkMkI
 pQuiGFb2C9EQeuw/+Ma56PWjEttwH4b6vEAg9bCp+wZbH+aQ+hrbHO7m9FSBxklZu9+Y
 7dx5Z0xFFbRjeMYOL/4iquIMuO0R1MJtLrzBcKuRk9OdnMPWMp6ee6pZTiCcPgWdL/ns
 c8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772222607; x=1772827407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDHL5/sWqgqbrG94mN026T8E4mtZsD47FQXehS9P/K0=;
 b=Te0YR9GTQqZB5Kgmr3NboKIZDOQDzcUSqtxF1cOyVaFGk6GxifXdwGQYLUdiCgE4xE
 eKd5YVWnXCdgZrlPrHTSjLVujQDq+7DU9jpZI4n2QOthF3G84YXDGT4S5SddtboTuzfs
 BkUTnsnZbj9yRxDEfgMNVkirBAoG8mhoOwqtLgJ7HjsrJJiurYlJY8dyYJU2TMEbV7no
 CaQWH54vndedjFfy5uPdqUYJto2OBo7TYj8hcB74ReF7A3WFcQyheB994kZnGtO8Reqj
 dxvYJRKN9Mj4nvCmSPX9yJhw1ZSMBPlkhDa9Nc8ByqzmOhnOqjrhiNh+OUr40SjYOurP
 XSag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Xu97dwoFC5t9NPJh9FqpiONPDddSPj49+ulVF/2+KAnLlN2gpAlXzwm0zXq/m4ELjoy+nQga3kwS@nongnu.org
X-Gm-Message-State: AOJu0Yw/+LbM9WQTrlp2mX9QPDwZPFX049y5GM9NL7npaNEFSSmRlDAu
 xY+qY5LaMbIEOET0o76929COgDrLnRcLgrJJQtkQFN+gonyp7yyz54mq7B0fki8/0f6YkLc4TaU
 xqnGTVYWF4ql9n0EAmdpcEKqLlt+aHcMwYAyGJvd9oTOyQcXTYyG71kULJw==
X-Gm-Gg: ATEYQzzdjcE28TnWQc2aRCf2HxGCeke2Ia6yO2F8KRgvIre6D5EOCUNUZTkvhAegcji
 XT/Kyr0fSb4N2mqpTr4JnxseARpF2w+gYqW0JR51E6bXNipGEc1XV4/B7mMI7t0zmP1CZirI05g
 JghLaQtY6eMiVLVfySId5FRVGTdol3/PikDShriOgPPiT8w2bcJoHeUmb8Ci5hwni7zY5xNn/3y
 cQs/GPeyvRtwGmJEsZps/PeGRv6cMjnQBS/Qf1dBPn756G6M7bhcVR1UlDwrcEc/lih5c/sD+ve
 IlnpB1X+YMZykEu0t8DVln9l5EYt5ZOIb18oPmqneBBrGhHqqpq+bPg75Ug0lOZrVV83bvOykVf
 LNBG91m95F8Xvvj3oB+VtCiXuVSFRQ8nPxHraUWzcw7fQo9ntIcLTi92msb7euvBLZnp3OsOJnB
 ok8g==
X-Received: by 2002:a05:7022:e29:b0:11b:8b4b:bff7 with SMTP id
 a92af1059eb24-1278fc57617mr1440433c88.39.1772222607118; 
 Fri, 27 Feb 2026 12:03:27 -0800 (PST)
X-Received: by 2002:a05:7022:e29:b0:11b:8b4b:bff7 with SMTP id
 a92af1059eb24-1278fc57617mr1440418c88.39.1772222606421; 
 Fri, 27 Feb 2026 12:03:26 -0800 (PST)
Received: from [10.110.80.16] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899eab46sm5430552c88.8.2026.02.27.12.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 12:03:25 -0800 (PST)
Message-ID: <08e52599-d4a1-47ad-b828-60a6a20673f3@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 12:03:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] i3c: aspeed: Add I3C support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <a19985e2-c9ca-4158-9c64-e0d16ce40c8c@oss.qualcomm.com>
 <e58d1526-d9cf-4f31-b7cb-808a7b0f2c66@kaod.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <e58d1526-d9cf-4f31-b7cb-808a7b0f2c66@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lPuXggawru1TvyV0Fpk1DVj19oWAU2nc
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a1f88f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=3kjpQGTRYXVoOlmu2nQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3NSBTYWx0ZWRfX1nKxVZbDospC
 h89NRlGnakTfLVz7xhW7cIvYa6CE+LVj/t6szasr/Vq7KYKW3Evj9uZprvyznIe6/oXrTC8v/6L
 QQiQaRRvycuw+CzycdVV1o/IOPMn2qUrRqn/eTkc+/uJpbMruBmWMCNXXdx/KldTRnp7arKIChs
 KWkfqF70E4y7KdPoymMxufCeC+rUSlbQ9PnGVyni7Q1kemSR7ONkShOg+zhjSJgiKwmxFmnTRpK
 ubCVkKwbnvIcuwDsVPjoaRcCsB9+t6GfPIbwJ1XVgGHkjHXT9qsZ2o+pzqyoVn3Tl573K0T+obx
 JTwga6DvEyPlvExra4pq4/UfamgPAHRYgIMWaNAi/qUd90XTLJfCf5WwReeGzvw4Tz7S4e93Nn3
 Toh+CcVuyUtzSup4fcZGOcP6bF4U8Sak7qd/nqtDwkBI/9C8MCeRw8rUXGgA8B+N68UbFiCKWYr
 wYkSq86zW2+sOG4/QIA==
X-Proofpoint-GUID: lPuXggawru1TvyV0Fpk1DVj19oWAU2nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270175
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/26/2026 11:53 PM, Cédric Le Goater wrote:
> On 2/27/26 03:33, Jithu Joseph wrote:
>> On 2/24/2026 6:11 PM, Jamin Lin wrote:
>>
>>>    The initial patch series was based on work by Joe Komlodi <komlodi@google.com>.
>>>
>>>    This series adds I3C bus support to QEMU and adds more functionality to the
>>>    Aspeed I3C controller.
>>>
>>
>> Thanks Jaimin for the series, I was able to test this series to a good extent over the last week
>>
>> Tested read/write transfers from guest Linux using i3ctransfer against the mock-i3c-target  on an AST2600 based machine
> 
> Can you be more precise on the machine used ?
> 

This is an internal clone of ast2600-evb which is still a "Work in Progress" and not yet upstream.


Thanks
Jithu


