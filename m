Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE4606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHCoOMLe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DAC2GQqI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKBj-0001jE-O9; Thu, 29 Oct 2026 03:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMKBL-0001iB-Jb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:04:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMKBJ-00077e-PF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:04:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5Gw6B2974020
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m9jGdFrAyS6E9sDfacRXRc9Od8l8zjvJBG/jnJON6g4=; b=CHCoOMLep5HRW5Bu
 yXQqFrT3EvOhReVLEf3dWzBmkyqm9QkrpjNAfBM821MWgUdTAnLISOiFCLLV9gkG
 QEdztnYBaQL3Rr5Bv8LIL71dj8i00se09t0AaLjwirTmW8Huoslrd8ujxYOlVqSD
 AVJUOzNDxuXwhLyiTwSYqOEDXwOrLSKToMwRfHzfR8HFYqBIruVQ5pRMggq9as8d
 oXphJDfECVhAX1+BxCMWh9OjsXOoTSBI41+U96rVmxXcXWO427ap71jr5RlZq5EH
 6RrliKnRBhPzSexyLgsj1tdWz561L2qs95bHAJqvgqs/Si0p80kzyohHL5qDtYKi
 OwZyEA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkpakuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:04:06 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98a829c43f3so464696241.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793257446; x=1793862246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m9jGdFrAyS6E9sDfacRXRc9Od8l8zjvJBG/jnJON6g4=;
 b=DAC2GQqIXGw32yX65MzjaYDedLrTDjm4t7SGmszpIobxMq9y8grngGae7lMbcbytB6
 tI0FMZXXTtxfeq9O4sMgOBO1jc0rv/8A1AP4SaPT5Kt7Nf9e79fNzkcyW07QMYurWyKb
 DPyh2r6Bs9LIxLfs1s7YH/9AEkxt4xP93VWvnN1dRkFAv9OH2lw9X1fL53eFsEiRRk4v
 XIWtEeFJg50cac0Q12rPYh5BWj6ffrGelrlJ1UOIN47bUdhlR2yCERpV8BFrrOvWw6Lc
 RgEg4P3FGYIFz8ae9OMO/D0Y8YiD9eChi4pFp0sChitJg7dPtdieKYpBcgshRjhDYpaR
 AswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793257446; x=1793862246;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9jGdFrAyS6E9sDfacRXRc9Od8l8zjvJBG/jnJON6g4=;
 b=feLRGVKPMV5WAv2gBBPC8VXFHTiC4dBR4H+1XyH0+N0MaiLXxkoeUNQyZD54+ULlR1
 gFVeBA7GlGSgkJeP7UKo0R1p2d4qTIytGWv7z3HbLdTOwORbiANzRpis9E1voP+zUxq9
 mVgok7nHkbnZF+ZH31Xtkjg6Y5fqWxJXgGcHYuHkWUIuWTkk9T8z4hN+9stNhGEPW8LF
 yVsdkiHajE+QREorqAsFgUpcijGFFpim77atUnAIN8R03m4GZGE78/Al/DCdjiPW/Uhr
 0mTMchbeI1n5hKL1D80kfBT8dRduj9sQAyfhatQMTEvwnZburOTTKcXjm2RH2ZWYyTCS
 w0Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvByWDn28sJ4BNjb73NejrHdM69+4buHAhUtLlw1meBiQux2LqMNzjuLkK80e9Bm93pN1XPPfy+ocOf5U@nongnu.org
X-Gm-Message-State: AFq9FYKBEtiK6uNxBnt2YZ8tuStRnTRC2bdis9+XFDzti4yEQCJHrGs+
 3vqAJXOUlhx9wMNMes37Aglz3ZI4PpBfuWvAiLEH9yPyY1GHUJ+RX1VevmFPOw3A8TRX9l0UHKw
 odVVuD4hMKGH0hrQC1xLERySPVXqWOo4wg3kif4jOTz96WpQUpFeoVw0row==
X-Gm-Gg: AYBFou2mCDq8pKxvtFy0PMx/kuLgOkQNf8c7KaFwvQXBfsfUEBkGSOkp2sSKy1tCHn1
 avLECJZ2lRAgW7AkwHbN9Ouz5L1uS4/L9eCCZ5ZB3jyXGiF3m6pxR8e2t/Knqw9aI3tc+xPaGVh
 tGy2H1tEwWbYr/vVwOK0dltowhI8d4RG6rXW5seb9e00Rz+OMVGbBpGZCmgmF54o1ooCKQxF3o1
 8MnfrWGByyNWOD3eS+2GSsjtQgyqX4AT72zmbF0twOBnTxLPUEyTvtUJON2HTasB5CXaVcMWJLd
 NC3P95pV3uyVYk5vWAtiIMDwMFTgwcYnBWHzBi+O+3h50+/YIZIY0qjsTn35g/7uGWBYPX6kgv8
 +8HtpZ6diKkQYSJYFOp+eEdTuNkh5NRrEk7kSxhiDoqD2y1mK0Z4CWz5cDC6EK33XRwrL5ySo1Q
 VQ1ZGXhcx0XiCI1p0t+w1lCAA=
X-Received: by 2002:a05:6102:2b83:b0:7cc:2152:4f95 with SMTP id
 ada2fe7eead31-7d03a289c38mr2114853137.3.1793257445856; 
 Thu, 29 Oct 2026 00:04:05 -0700 (PDT)
X-Received: by 2002:a05:6102:2b83:b0:7cc:2152:4f95 with SMTP id
 ada2fe7eead31-7d03a289c38mr2114839137.3.1793257445350; 
 Thu, 29 Oct 2026 00:04:05 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm32567464f8f.34.2026.10.29.00.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 00:04:04 -0700 (PDT)
Message-ID: <32777ab5-3c29-49f4-9650-765fc6648aaf@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 08:04:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/tcg: Massage MIPS tests for easier maintenance
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
 <057696cb-8206-4d9c-8dae-41c39df6fdfb@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <057696cb-8206-4d9c-8dae-41c39df6fdfb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae2efe6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=zi3TCBqjKv4HLfUEEvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: yAs6Qj-ZoUdrY8guh9Fc_y28SNDd3ZsP
X-Proofpoint-GUID: yAs6Qj-ZoUdrY8guh9Fc_y28SNDd3ZsP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNiBTYWx0ZWRfX9zo+P94J6nvd
 0tYjoE8D5U2QTGSBQClfdXbLhyag69WcG+sBD0oJZSYWcFsGkKmIyci17OFcZ0w/Q2C2fvt0ZY7
 AHUM3P6xWjXpRVPatp5V9B9cClRoH/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNiBTYWx0ZWRfX2Rbn3s+3WLJL
 URdHLSpCJ19a52FUL8d9XTxvS+dA9NpqP2WXIKXNjM/LkzXwNrFnJ2K15c/mfCSh6nca2MZCA6H
 w5bL94NK4DHiNPtsAs1sHsHR+mhTMloI/ooeDw3jbkUWsIyh/jrm//pLDyAyWLpC95l9FfzDq+s
 Tf2Jb5GxgeOqEMbEPYKyW5rjB4qBudkhwuWE5XyERGOeSD8uToBy3df7XFBpRclKZvhKS3nLgjf
 QioXhXco+aXm5/z4PsgMyDFhRShIOLE/8R5b8jZ//W1kGodGLn7uBi4bm58wEYgzcRoAIioRpoJ
 PBQOHRzBldMauTVNU1RIO/qDThHPxk/mhl7ClG4QnfpwrsgTiRZXn6h38RPjCEEk5LO00A3vVu2
 fIdL+Txc0rl5gyvCkif0nZsMWP0JBOqdskbejfhkWlZYIb3RiT6KGCVlnsNv7g3nQT7i9FdDdyR
 pbEQgDwxyyBIs7NHX8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290026
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 28/10/26 21:07, Pierrick Bouvier wrote:
> On 10/28/2026 11:21 AM, Philippe Mathieu-Daudé wrote:
>> I'm glad we have many MIPS tests but they are in too
>> many files, taking time to get compiled. In particular
>> on Aarch64 host via x86_64 docker image... Group the
>> test in order to reduce CI build time.
>>
>> Philippe Mathieu-Daudé (4):
>>    tests/tcg/mips: Clear DSPControl at start of DSP tests
>>    tests/tcg/mips: Group DSP tests
>>    tests/tcg/mips: Group Release 6 tests
>>    tests/tcg/mips: Group MSA tests
>>
> 
> That's a good idea in itself, but this would need additional work to
> have a clear report per test. We can't trade usability for faster
> compilation.
> 
> Right now, a test will stop on the first assert() met, without going
> further.
> 
> Ideally, we can keep the list of tests in a static table, and perform
> the DSPControl clear before each, so patch 1 can be removed. Also,
> assert could be replaced with a proper return and print information per
> test.

IIUC the requested changes are only for the DSP tests, as the other
groups (Rel6 and MSA) do not stop on the first assert() hit.

I'll rework patch 2 (indeed 1 is then unnecessary) and respin, thanks.

