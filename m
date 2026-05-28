Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19485CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgul-0004NA-Cz; Thu, 28 May 2026 16:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSguj-0004Kb-AF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:01:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSguh-00044M-6I
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:01:09 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHEKoo1469334
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MP5VBO+u8jAu0uA/6DL8d2gWmpW1A9XLqRwutN2157k=; b=eMbxqgD7rkoqnLV2
 Qgw4wn5XF+Fcuv9d760Cy2LwHPcdSC5P3/zpx/tPoTmhMkX49EiTJ2QaGsuXsmIM
 JGImplZZI8fvZUuyxDnJc5sVlm7ExQG5xlowCt+gfpEAvOMbVAC4tohp2Gs7qXsJ
 yzUSbz3+jFd4LqfW18JD9vvObi4DxJtdeqMLV9lRI0oVsjAyvE+ub6e32wFK0I7C
 xGXY1F9/IpD5MNGu1me/gV+PjVjUlvyHHCdwq9ineC1ickWRavHGVoO36CPoGWqn
 6wfAMpw+LXTJWuKSQE9Q2nlAxZvvG1U51jDBHxPgEP9MQjV2sGvchR/H+Xj+Uvbi
 OwrJ5A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eesxa8qtk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:01:04 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1353a6f29deso623319c88.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779998464; x=1780603264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MP5VBO+u8jAu0uA/6DL8d2gWmpW1A9XLqRwutN2157k=;
 b=kKQNM1rY4wxC2OtdhAb+TOuB3bcnvw/55U+yn97qLQZQ5YnV1TKUz4yOQWn4t5ZQEI
 MwLgGh+B2pPAadPGQnK7vtJZHeNIxyc6Sc8UPHyVUIDC9aLawi4e70Bw501Got+kQsiy
 AMvTJMAxtI6FcZwGQFVXX97Gz43yAMzd8uldk6eCOuk8I8udx5Kf0wVSKMOHBsYjX/lN
 1Lo08GBI0GXdNHrprN2Czn70lItlsLI+wP6DrnlJQWtwBIlKWPYaEABtTlYZ+Ta/YV06
 jAg4DuHTR5BtDrA6ATs5AalbzIGaVsfNZMvJKeELSbK8SUA+pnCLYoGksTXg6Gbd0cdM
 IaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998464; x=1780603264;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MP5VBO+u8jAu0uA/6DL8d2gWmpW1A9XLqRwutN2157k=;
 b=Kaq8RJFQjIniMMG3kQvj21BSzlrt0Se0rsXMpJ716ppGtJUKMCmKelkjrDLV/Qfput
 0/DJ8H3NVr5xYIroG0AiFTHHSe6Q/KF/cQYUJB+pjSpZ+d5+qKuAgfetDLyWiHyrJN+V
 2ZyPB3l2YangecQeyiK1qczIGzLQrjSZ9z1/9bb6KVWCrSnORe0f0+aQ5xbrXrTdOvJu
 3RzLybd+k8zmr9HBbRFjCeRHqO7X6ujBAqH6jbLHVcmVboO5TkxSbwF4WejS8b/zrS0W
 F8wHRpvfxE5XGq2FfOPItLkqQBEODeQ/5j4nB45wbSU13n9Zvm8vP6cD7+gi+M2ggC0B
 2XQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CDPKSMYH5n83B60RQUaSGlF+pREOmhm54VXxj/azol6gqLk6DHhw/O8fZqs8rI1KgSAs/fjOgyjS1@nongnu.org
X-Gm-Message-State: AOJu0YzasdCDdb//zvDVzol5F86Vb91uDQwRGgxbtctLaQYBllE7Dlhp
 BFjfMN2+okZpJBN71B27YLnRoHFduB5YF0QB0ch+sIMX7mlQYYkxx5iN/uU1ridgtvUHuIjY3FU
 kfBezPPT0Pk/PRO7M0YgW9Ku5gXgd9UazwfXvi8ZtPPfq/qMcGyCZIlf9dA==
X-Gm-Gg: Acq92OHXb4k0FERVY8fJv1kL0GeilBd9xVroHpniW9ZAt6qdSYq8WfgcgX5b3zSOAsy
 D0SpxWtlDxanz/qCHR23VKc37L81IRRlrkxXHjXCNwgxmGpkt3V7pxkm63p8aQ7Ogtq+Bfr9LFO
 AwtZWkHpdh9anB86bNG4vwLKEFwdI30iel21xvbIZzkukeFJAxzGykm3IaR2NKb70+DmAcholF0
 IFFcj0zA++Tohf/BVlHV5TBeOqLVmwaBwNEOKBPH/Q2THsF84wyjMKq2yskX+J2BIvG61ZNvvkR
 yKp5QGrle4Zx5KY+bbOPIE4eHq7ltHD1apatFu2NVq1psF5WMYYDGSvfNpZQk1CyZcExa2GEYOb
 iJefW86VzMzPIZVVgbaw5HC8L3BLn/4HoMX7URVCSXGtLWqN30CkLaheM96Cj5OZ3MNOTwELXQ3
 vSpuRvQmhPLPvFh7uIM5qyk+4n
X-Received: by 2002:a05:7022:45:b0:11a:e426:911a with SMTP id
 a92af1059eb24-137a8372614mr271147c88.15.1779998463934; 
 Thu, 28 May 2026 13:01:03 -0700 (PDT)
X-Received: by 2002:a05:7022:45:b0:11a:e426:911a with SMTP id
 a92af1059eb24-137a8372614mr271123c88.15.1779998463317; 
 Thu, 28 May 2026 13:01:03 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a9594ea6sm174050c88.8.2026.05.28.13.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:01:02 -0700 (PDT)
Message-ID: <595550a6-7efa-4e6b-b025-ae1253a029ed@oss.qualcomm.com>
Date: Thu, 28 May 2026 13:01:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() ->
 const_le32()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-9-philmd@linaro.org>
 <9d0853dd-5c22-4c46-9c42-a76d18230271@oss.qualcomm.com>
 <e636c43a-a613-4819-a272-61fef832627c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e636c43a-a613-4819-a272-61fef832627c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ylAQKH5OB4rzHojWNoZYm_ZHpajV3Kem
X-Proofpoint-ORIG-GUID: ylAQKH5OB4rzHojWNoZYm_ZHpajV3Kem
X-Authority-Analysis: v=2.4 cv=ZdIt8MVA c=1 sm=1 tr=0 ts=6a189f00 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Nh7W5AI8wlZR7lFJBwMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwMSBTYWx0ZWRfX5rk+7vdQigjx
 HDuPxEeGBYrg2QEx8a/W4HwLX4lmfSr75q/8TUMWDhPsugZoYm1xylcM2tyPNsVWNhCKUfW4DNl
 3JrRIjJDOQZHIkFZQjfl8tNsl44FzBRBq10UEt5EH4NGrzH9OjMJrKruZhf8QK+RmL/8apUmYrh
 FRHqvxmb00W08dR3pMaVxuQRMdrYfqLKdpAU/e/Nth6caJnUZxFadeEFiwg57X8IHZ9kSDB1vYP
 dvZTBK49etGQOW8poDRoVIisDxr7hV4vFI0NEb8StzznfsKlTZCfiFsdBoZWyrXqoiMuscr0Hez
 XNm/1ivXZ5xvnMPI8Oh3dXbR1DuOUW6/byF5B7Pn1SSjFrBwP8z1Vjj60k067INFwwOF4rOurZm
 Wuk9G2sX3cxDqPImJ+3vmbJzUu4UQCHey23llVpvWHmMKhAGW1hTjOa5nNifQIpp0IRQdnuVl7m
 BygiCFFs1UvDDKACsCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280201
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

On 5/28/2026 12:56 PM, Philippe Mathieu-Daudé wrote:
> On 28/5/26 21:40, Pierrick Bouvier wrote:
>> On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
>>> Rather than adapting the array endianness when it it
>>> filled, directly initialize the CODE words with the
>>> correct endianness.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/riscv/boot.c | 30 +++++++++++++-----------------
>>>   1 file changed, 13 insertions(+), 17 deletions(-)
>>>
>>
>> One could argue original version is more readable.
>> Any specific reason for rewriting things this way (performance, personal
>> preference, other)?
>> Not a blocker, just want to understand the original motivation.
> 
> Looking at the following changes, I think it makes more sense to
> have the CODE section const little-endian, while the DATA section
> is swapped. Otherwise we'd need 2 distinct loops.
>

In this case, having two distinct arrays, and two distinct loops might
be more clear IMHO.
The function is called only once, we can afford this.

>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Regards,
>> Pierrick
> 


