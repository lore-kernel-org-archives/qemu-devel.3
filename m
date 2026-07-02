Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHrW-0008BM-C3; Thu, 02 Jul 2026 09:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfHrU-0008AU-TI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:53:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfHrT-0000Bm-Hh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:53:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ZM6522875
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SKtuIaw8+pXrBg+ju4oks4/KMKPskyO8AGzbefkFZFE=; b=d+QmYT6fK85uFAJk
 O9ZsdpcjRgrRmt6fhBqeAPwO/PALs3hF7agDuh89FBLWhnt0NudO86aksV100gkI
 DlXaJ6xnf8B/TjNEG3cSf1SflzfOagwq4nuYReTQaAW9jZHp4l5CV5UKIDbGr62M
 1V9Wep/aQ41YibnMCp8cBAYBlfLcG+s1R4Q2dQTGyACZ1li0q9z7CvWF42w5Z+Ih
 AlzcnY4s+viaXKnD2cT2VMZHkI1yXGw6oxSLHtSiNGt74ItBWGzgVZGS893Ho0rf
 jiFK4LcaWyiqmaz1Fv7sGRy8+Y0pjZK1upJ+akpy0QLvZRpfvPyFkZItj8cBkB8v
 tDcAbQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541w1fu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:53:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e663c29f2so82632385a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000430; x=1783605230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKtuIaw8+pXrBg+ju4oks4/KMKPskyO8AGzbefkFZFE=;
 b=FX6GGqgV+yPsLEroIXhFCpEaRROe3lUHTn7ZHUucvTISVBBVk9x0SyEO+juZNjzlPe
 aI2ArwBt/7eEzRvvnFqVsgySmxw6dvt4/3oPVDgTh2v+Y6Mkas21PS8lZ/Px6spjUicr
 GJ3VYrN7TV2ego91rRky6d5AesMNzoaO9hC1MWCPNdLAIFktZLP8DXKDWxMBDdfHkGTy
 EQ9K3S0rHWqnNyw5qbCe9YEB776Znuq9gZYwEYhpc3QaIicVPqXGcm+8fnPHA80rtzfY
 Tn+G/JbcVtnf3t+3JS8KKvWvod6U5njAU7+4i2WYzqR+m1wC/v56v6YdocJ8hKNLpKCC
 CRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000430; x=1783605230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKtuIaw8+pXrBg+ju4oks4/KMKPskyO8AGzbefkFZFE=;
 b=mqx3eA0E/wawPj3nOfRreEwZwfywsWcP0PJob9L7RZIjc8ucqHJRE9H7UpaLQk1sLo
 h+87XF4iq1oybFrue3RMzW2awsTcyWwM4pxETxE/YPtzg9smkXwJtrczKIiS0EbYy1CY
 LzOi5aSRxJaEGKbj/BzAFmPv2buoHkugOk8gcyekzmxhQVEk2uI0N/IggSJLIE+yF6UG
 wVvSlX8v5FD2CcqwCg4449coA1Nm/et2GQRHAl8iw8VK3sCPH2YG6+0CWQmysqRqKdJP
 9VkWp7U2DSnkgKiSSy+H2XXnKFTkk7oiU0zaHWm9J1w1zNpUkOCswfnSVVFDS3iOVjL6
 pKIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eeXzFdI2qMKIafGw9mKQvpxJERQnw6rgpskeMeK6NNxP1wIgIFd7JS/VSpFWc5uL9IG9RqEetoahM@nongnu.org
X-Gm-Message-State: AOJu0YywVuTyJ+zsNQ3WQ+VA+0XK4h3Acq4y98TwEx+D37Q17rsdUk7L
 1+ToPwDuU9profZ2NoDRS5WFoMPV1UNbXFjU9MCfKaioPkC6K/8VS0wrpGiFeGWlPkgYBElGv60
 Z9jQzE224zulXVwUUFtZ6U5jbg8+7/l6PPydmWISJyIUAq/bCdVOVwJ+pWw==
X-Gm-Gg: AfdE7cklkmW1H5gcv8MW2OkdE44tfu19Q0Toju54VYilQ2EDRztF805mNUlQVkZjYMs
 yDMyRENkbTsZPFgGEqY87BBUP201jV4yYSWCxdp2foat4+OWZ36a4oUOiN30CSkHyudeVeUkqBV
 XecFRVtabwLAtnOBR+eiYjenpXr2CYthTIFQMRoFywDCJQac/kl3bE7/tXPeghKVy/R0Qg6MLc3
 FaqWvz3sPF+D5P7eUz+3B+Yzem2yoEUx5dQPThDmnU0QiBQfMMlVKc/TUQ2x0Dc9t+D1/3mGHQh
 4V/JrKTuYaNXwD9Yn8m5r7DU4QEucMaFGjmMBSZDEQIZLagJ9j12ji4lOf6g1p64xou8MbvyAAO
 4nlK5Df68cR3G1aqiTQe4H2uSBGHRomKHB3+fh0abvVxgavhaKeJZWinoVYTcaw==
X-Received: by 2002:a05:620a:8385:b0:915:8e2b:e5de with SMTP id
 af79cd13be357-92e696afcbdmr1198347185a.7.1783000429742; 
 Thu, 02 Jul 2026 06:53:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8385:b0:915:8e2b:e5de with SMTP id
 af79cd13be357-92e696afcbdmr1198343685a.7.1783000429194; 
 Thu, 02 Jul 2026 06:53:49 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm89006595e9.0.2026.07.02.06.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:53:48 -0700 (PDT)
Message-ID: <0733e5b9-ba75-471d-855c-92e9a2e97b28@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] gdbstub: Introduce GdbBreakpointType enumerator
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-23-philmd@oss.qualcomm.com>
 <6594f37b-e10e-4252-b5ac-fbf5023335f7@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <6594f37b-e10e-4252-b5ac-fbf5023335f7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4SYXTtEQCk6kHte54_55K9Z88BsKWQQu
X-Proofpoint-ORIG-GUID: 4SYXTtEQCk6kHte54_55K9Z88BsKWQQu
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a466d6e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1mGjvZ0QwBs30myUpCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NSBTYWx0ZWRfXz3mc2aKV/z35
 2n4JwODHidFqi3TZuDfeUdQV01TKBBGTFt8RqVgYs8EMmdXC2rRa/tDO3UtEPEEpRGwRfg4DG2A
 vtGqSS/ZyFuK0Q2bxyAmCSseGQnwcep5tRcwGU72fCkjGIEe7eYz2lAJMtZi6HLJM4KHDFJuLfJ
 6k4QPdB8uu+jRq6Bn4hsZmuO553xsBw79WLmTzoYU1DlZpfnqKYaNH9bBDLdD6sn5uGl3Zy6va0
 lX05lRNx+MzFa9RbY/YVEymdd9MM8TF53yn0xF0szxg7BvdQIjsONRb4gyOdDAb8XPS30y/j/5F
 BF3muqcbWf85eVABukb+asU20Kov/4sFiFMkRe2p7hQrArEuCLE5OP+NFHHS5ohrhRRABnFPT3H
 xVgXzjH9eGw6+31IVe9UTUUUwpfleqxa1S5hflApaej5vttTxhO4WmYwjzFqBRB+D0WapMvSS1i
 k3ms3s3JgNgw+o+2c8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NSBTYWx0ZWRfX0xVCx2NWKdtU
 4kRtGjQqsQGwxlvy2FNwAZQIt9gZMfZ9+gNlrzNYVL55hFFF/iVjl2bpQa7Jh0Jx5m8t68ZrPoZ
 ZFv/Jo12TFDod4Qe9XO0oavHYvacfuw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020145
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

On 2/7/26 15:29, Daniel Henrique Barboza wrote:
> 
> 
> On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
>> Introduce the GdbBreakpointType enumerator to better follow
>> code related to GDB protocol handling.
> 
> I've been thinking about using enums a lot more lately ... not only
> because it's more idiomatic but it's also a built-in guard for allowed
> values.

Here or in general?

For me the direct benefit is finding all the API uses (call,
implementation) with a single 'git grep GdbBreakpointType';
that would have been helpful 20 years ago (now we have clever
IDEs).

> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks :)

> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   gdbstub/internals.h     |  7 +++++--
>>   include/gdbstub/enums.h | 12 +++++++-----
>>   gdbstub/system.c        |  6 ++++--
>>   gdbstub/user.c          |  6 ++++--
>>   4 files changed, 20 insertions(+), 11 deletions(-)


