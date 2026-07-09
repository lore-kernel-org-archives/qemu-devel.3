Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7932FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpiE-0003QQ-FM; Thu, 09 Jul 2026 10:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whpiC-0003QF-ED
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:26:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whpiA-00085z-Ju
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:26:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Dw52H1972516
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 14:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mA5FJTBh4LUwOQC+bMFFy8j0ZaIpRZcYQ7dNTG0BCns=; b=bIokluFTX9QL8MB6
 uVS1aaNnv/GPUCac01GazkV+VTwlp8y3m1i4OzA3j+PIbyZbU9M1sg29NFTAWCq+
 TdJcXrBtTuDxYxSFRauLxdYDRY+qQdGnn3acx7TC6NSkdV4x4jAqAPCjZrNR0iOu
 tn7hiVo25j+lHJmas9sNyQHq6WEl2IsISDZoz7Rxs4Kuk9TRjBzcGh7tTqVnwU6W
 ZOXtzJhDNXWsIRHkf2VIj+5p2Dn3w+mZB4dGbwce7AGQdPSdqgh163HUOODRpkXR
 vqTzhOvkulrfJYGbBX7dLkF2HiFhpJQJiDY5tto3m9tTEGAds/TDXipHYrtQeja1
 fEDOQg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvv5he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:26:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38869800848so1981971a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783607203; x=1784212003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mA5FJTBh4LUwOQC+bMFFy8j0ZaIpRZcYQ7dNTG0BCns=;
 b=AgMsj5g50AsYv8yToY0LJ3wqA3FKeZbtJ8Tw1cNFO8NAXxgKOcLcDtjpYt2R8Eadz+
 203L8dN6lSke3uUJyat4gFqBr6kRPHTeuotAz8kwCJ5RRvnq9Q+yYdNBTx17qYR0keh9
 wmLu8NE1AZcnrNEHeoto+Bse9JiMmX1mJos8EtGK/dEq/RjF1mnSDAOV7QYxhDnYruqw
 V2bC/y0Dbjq4Gi3arPPymxPGD38Lq5ugOepTpZPm1rNut0qHzw/cr7w5QHx4WqiEq15t
 7IiUpeWrJxvDUOJbFcOWJn+gT4LOMZrq2/0/QhrCFmqc7lpCYjYminFzCXnvPUHJJ1sp
 Lqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607203; x=1784212003;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mA5FJTBh4LUwOQC+bMFFy8j0ZaIpRZcYQ7dNTG0BCns=;
 b=q7AfiRp7Aw2qFmdUq6ucK51syWqpCMxCXDYkpO5FnigbieVmMCKsbM/CAAfpql3/85
 roMx/3cQg/HZdKFXfoXMieFjAJo5pd6ZIwRbt31X3htZtRygVS74XoU7ngKdYhRAa+V1
 t2dJ2Fvo5Lvb9SlsxkIS1kGvhxDIDihAey9WXXRF62cSwtBGjISz78SpDmsubdcsoeEL
 jmiOmqodhzu2GCkbDqrYsTZUdyE7NDv1yyajimoi8omOL4W+49TC53+q46SbdiJPyGcx
 pTbKMMLhbdux4BYtBJInN0damD1eBSuXaDhK3KLvtYFUvM42l1alJCbmaM7UWO13pJ9G
 Sqtg==
X-Gm-Message-State: AOJu0Yzz4BDh7molJ/2nGzJKe8snUQSDNqWp4eelv4QYxHCgY7+G5mBc
 5N9ITnu4Hx1o3wOmyaAPfM6I6UyPXjuPM/rQA/Gp5W7/p+5tML+AguJrHMQh4O1tk7QDToy37hv
 6TILCE7id+Xhg+kieq8BkUB5WGd3GQt25PZnB+GULO9zxVPV95nZxDBuvZQ==
X-Gm-Gg: AfdE7ckgDC5+SGkL77x7yf8o3mbikQNpDZFzpua6J58roxrmiOqeAp8do+aQvETm9pI
 6quN1xeOveonPGKGVtzQSFNSl3XX87R6Cbr+CT8Af7/nnUug8UsdlU3Xd1ouwGycp3Qci5Qbmmj
 KVKzFsj0dt0i67j/gAsMQb+jigktvQXsk1jG9UG9OnHMpHIhIpECfMFCaIv83Ns14nmzpy1hZ6b
 lJ9G/6AMm5KtWlH3USHOODHYSdP//OcRqMIqcNZa9mgXDgkUuHuPltQafrD/IhubIGXAdsWbk5Q
 yT+L496SlKUJnQ67vuzVcgHt2vb4jOTxb+1FtoAjraMAo+QkzeVznxhzO1fqmjJWsXQl1meGQu8
 Ho/lMXtfeEqsQqB5etFMoGZ5QF6esRvcRCdjEg8qsdS6x2InZNWlj/YHB0b7fIOs0vi56t+H9uB
 MTU2s=
X-Received: by 2002:a17:90b:54cd:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-3893d23ed48mr6637931a91.0.1783607203108; 
 Thu, 09 Jul 2026 07:26:43 -0700 (PDT)
X-Received: by 2002:a17:90b:54cd:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-3893d23ed48mr6637899a91.0.1783607202537; 
 Thu, 09 Jul 2026 07:26:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31198cb2b99sm13435716eec.26.2026.07.09.07.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:26:41 -0700 (PDT)
Message-ID: <3ec70ad1-4467-4c8f-b9c1-40acacbbfdcf@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 07:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 90/91] tests/tcg: remove Makefiles
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-91-pierrick.bouvier@oss.qualcomm.com>
 <87v7aos543.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87v7aos543.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MiBTYWx0ZWRfX1fL2QqNOgpEF
 xCEY9R0m03jAoyilGc0rGc1ivag2Sx4EYAfgBdPijM9HbFXKsWD5u9PoE4riab6XRgD1kZjNtFi
 per2XHdRlqmcBh/AquSNMmTaNQndBKw=
X-Proofpoint-GUID: HNXRShrJFm27cKrrY-77QmnmZ09U8EsJ
X-Proofpoint-ORIG-GUID: HNXRShrJFm27cKrrY-77QmnmZ09U8EsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MiBTYWx0ZWRfXymsxqvbj7vTz
 4NlVm4SeG5itXFWPq9Rz6nfI23qS/t/0eRtQP/Ga8yZGCRmW5lzfLqmWb0OYnOWYpa/QkJf58Ds
 GqBw9PNwg0IAU9/myG2urLrFO3rfJAlWsf+Y88moqS7ciomnQzyXSDHTyvOWDP8IyDY0SeNC3hS
 zkKcVBPerhMRLoH1+mye+V6rrwvkUlnBYc5yyYRGYU03SS23EkLdEENOwiszRcEf/WgQs1QrnqV
 qJ77dhIpWc6Dyo80waSrSS6IixRV4bIFwxGBKYhO9b2jxgYuELC0lJ3ULJrNl5fkqRp3neW1D1M
 mxud5QIoTQ9LmQYDjoU3IGTm5gg4dPgvPko04Gwf6ctGgrJ8bloEg5pYR9kjCdHlcZV7jgWSIWk
 8p4Pr5jjFrxiLnlZ/SCqdONqsBtuaQOo7dEZfEScBOKKeNrD9e5Vu4DgjdmXkYZwbF476X8TIw/
 kX3V2jbKjehvewHH9ng==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4fafa4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mE5gyKH31tUdCNqNN_0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090142
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/9/2026 5:46 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
> <snip>
>>  tests/tcg/multiarch/Makefile.target           | 232 ---------------
> <snip>
> 
> There is a conflict here, probably because of db6b71f1ad7 (Revert "tests/tcg: skip the vma-pthread test on CI")
> 

Yes, also a conflict with the new aarch64 fprcvt test.
I keep track of those and add new tests as they come when I rebase.

Meanwhile, the series can be applied on a commit matching it's
publication date.

Regards,
Pierrick

