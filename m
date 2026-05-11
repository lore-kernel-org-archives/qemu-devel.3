Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBCCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU3g-0000by-B9; Mon, 11 May 2026 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMU3X-0000XG-9G
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:04:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMU3U-0007Uw-10
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:04:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4ITQ108024
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 17:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oX9q171I43TMVnRvgwPuya853t8wl87XNUmYrbNiCIU=; b=dJnuQHr0GbROFzlx
 Z4rJkt00xKXGPFtulN8KfqCto5D9odsQgDFS6Zt62jPx1TwjIq/OgeTObyzdt+RB
 VXM3pq/FIfAyVuUqjbtFiQcusVmDGxRFHHJmSVEI6Qz3a++fdSHVkbx/erEyteMm
 3cOLSRP6Rl+Duc33Z4bnSpK6LFEZYiHwhPLJXdUYcvF/6fXGAnVLeWe0CBbpMQ9c
 tmBn8a8GsoB3EpopbrgjPsi1LYBq8g+EGYKd45Bavc0WC0gzMnBe77bTM/2Mmrum
 bJMzTnvVB2Jmvph6qUaR1CWo7dwaUnb3mttOUZj7yZFpNi0/N9PcuJkGGyddMATx
 sdtSzA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esysa2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 17:04:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so7264538eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778519068; x=1779123868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oX9q171I43TMVnRvgwPuya853t8wl87XNUmYrbNiCIU=;
 b=eArN/SaTegWmjjYKUw4/pvf2260FtVcomUZOuG4cNm1nNMKBvyUxA0mmplHt1urPZL
 wubyKpv6mt0VnFqWl5dsbxl5qIkk2ML8yT3Kg0Dv3D8Vxbkldz9vywur9x51wZOusp4V
 aqb60RUe40MHEO9q/dAXbfZDvEBqkNqF7SvISMlmYC6muyfETUyiX8RqgU5POxxpQzMB
 Vul7dBdr49/+Rc+BeBH/xKaZFTS07aBLvvqVZXhrEu8JfLNYHymO0mOdRrzSZ/xGx5hh
 T5PKN6XiEnRdUZrfJ4RDMWrQmW2nNOSSKqG7PvxE0saxdjCiJK1C4gIfg6WLaowD0euc
 Kwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519068; x=1779123868;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oX9q171I43TMVnRvgwPuya853t8wl87XNUmYrbNiCIU=;
 b=EiPKjJiHRjDY8sIYzLLsvOrKErCXX0Iib3E9wXD5bxkQEHY0fvxoZybNRpC2FrBtcN
 e9Ko+kTNBEHB2UzdtptfSte6vTxtrMbCOqT5LKYzduUhE9ElvOct3J34DF5VvYi1sM1h
 8MiwHp9w/jfpSCM0wCEMYyFTbTQEozvMru0k+CxRhI+2qg7BWVq8lSbHBgud/7LUjtZb
 n1Hn4xHzm6cdYU5SKqHtOZuahNvOMxMiKcncopRLAjPLtHT6qr+PxpyBkAhEUPNcygoh
 FEwgj55PAQxTToMxFK+RkNjHrB4L84BS2VRh6g3qBZcqqIQWjYsSErq7hhGzGy0vdsK6
 Wxxg==
X-Gm-Message-State: AOJu0Yz3S1FadG6kYGrYfUBeXN8nKQYbf8RjUc1FZCdy+TcYSKbnFKbn
 zB4shCT5bY1z7zao4q5lWGn7LATysEPHM5eD2dGwP9XmiZUJSVQJ5Go+KN2DY/RffiiW3I14eHp
 fA9gCyzBqFrkXxXFrZbBJLyq91y8XMUwgeqvoksgn+FM/fiht4qP3yhlU0Q==
X-Gm-Gg: Acq92OFZ31MX8HCmSc/2mvVXtuadroQac9V3Yu1LPR0iggx+/CgNeDsvUeStO8hHJUr
 xhBeA3UOrjuSbBB5EMhbL+Pr5G3fBplHvuOue8eDe9WGEQHsz6s/PZn79bEYb6EZ/y2GEM8HCPP
 DyhVdmnVF8UcF5wg4ChUP1SxJgf4KxPK67eV3Q37NOLU8BzZbGcp10LCJgsMNZgiMHbiP1IGkg8
 jMHPDju2k/PyiZjRBoUb1bqoIq/TW/dgwxrG/jcu6fpKajQxcyBgjuwQv55S2npk7ojWXo/Dwrf
 xnUpd7U29fcsRV9qC5PN5gIZX8i1Z8BcWjqi+s6lOpJjwiKXV1C7prZe8m50rKJl8lPt1HKx7rU
 r+Sj2CmJ6Eq1u+28+Mob/gcuec9Oo66tVVMtjtfaO9w2Qy5xhyR7GYb6nzCB/SLgpc1gD7TgJGt
 DeIY8K4QhRuXQtcbgz2A2aoBFo
X-Received: by 2002:a05:7022:f102:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-1319763be96mr12322735c88.11.1778519068116; 
 Mon, 11 May 2026 10:04:28 -0700 (PDT)
X-Received: by 2002:a05:7022:f102:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-1319763be96mr12322705c88.11.1778519067458; 
 Mon, 11 May 2026 10:04:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13277bb2b14sm19456945c88.0.2026.05.11.10.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 10:04:26 -0700 (PDT)
Message-ID: <58035175-4613-4339-8f9c-da8d48197ea4@oss.qualcomm.com>
Date: Mon, 11 May 2026 10:04:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Document TIMEOUT_MULTIPLIER for raising test
 timeouts
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260427161132.1463385-1-peter.maydell@linaro.org>
 <6f68014b-e3b5-41e7-9474-b2964661d19e@oss.qualcomm.com>
 <CAFEAcA-2dOmcryxWVh-uRJ77DNy-vCZaHvFm+KACPCXbuY1ruA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-2dOmcryxWVh-uRJ77DNy-vCZaHvFm+KACPCXbuY1ruA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE4MiBTYWx0ZWRfX6q8DnxYsSzmC
 VYloiyFuZiQ8J2PUQNg/xWFsfCQQCCx5q4fWqSMkZRwGZcctRdyWEuDXvrRSO1MUPvFjyEHrZ3N
 tW75l0babPRBjvG4lfpYMws0hjvFwVW8UAqrshTaMJk4792VXqtcGdXdUKnTI6yPbpREzOAbl4g
 vpKGoJtGZtZ6FjBOI9ydZlnYGeRAGtsU3gdTRT8L+dTH/5Vx+GH7nfTEp95tf041j8xijFBWV7R
 yCall+nIQMUcBu0Xni/YcDkohbAKH6CR/SHmuktV2R5G9q2Wz3nLb4VOgJjIy+I4px2pFcnZpGW
 rrh/Gj6rD5jUVeVHDFLmx8pOb5SN6eCnvYiOw66ScAdpQllRd9/EVjyKpx/61vuwLeZCHj04+O8
 BJgHbKmn3N8qlxAnXA2aIZhdk1gxwTl+kykM/6pyu8b9st5K6wTHm2pT4/Ji92HGG7/FvYYQZIO
 sZJcR9DZttfwgiIQWDw==
X-Authority-Analysis: v=2.4 cv=AI/DAN7A c=1 sm=1 tr=0 ts=6a020c1d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FFgmPYQXL1i-er1nr6gA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ohmwN1G7unm0eW4qpp-S11K81-0MGZiU
X-Proofpoint-ORIG-GUID: ohmwN1G7unm0eW4qpp-S11K81-0MGZiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110182
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

On 5/11/2026 7:42 AM, Peter Maydell wrote:
> On Mon, 27 Apr 2026 at 17:17, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 4/27/2026 9:11 AM, Peter Maydell wrote:
>>> Our test infrastructure allows you to set the TIMEOUT_MULTIPLIER
>>> environment variable to raise the test timeouts if you're building
>>> for a slow environment.  (scripts/mtest2make.py reads it and sets the
>>> meson test -t argument accordingly.)
>>>
>>> Document this so it's not a secret feature only known to a select
>>> few.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  docs/devel/testing/main.rst | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Thanks; since this is a fairly minor docs update I'll throw
> it into target-arm.next unless anybody would prefer to take
> it via a different route.
>

Sure, go ahead!

I didn't pick it up because I was expecting Alex to pull it as part of
testing subsystem. That said, Philippe also transferred his maintainer
rights to me for this part, so next time I can send it too.
> -- PMM

Regards,
Pierrick

