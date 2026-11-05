Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7C606A6C5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FXGAhswM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BMxSA2AY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3co-0003Hs-Be; Thu, 05 Nov 2026 15:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xP3cZ-0003H1-G7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:59:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xP3cV-0003xB-Ig
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:59:37 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JL16m751444
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 19:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RlWfBrynmvfqWSZ4v1xRk+fxYaPoGpMlDK+ZE5l1eRg=; b=FXGAhswMQ1srA+iS
 AO5ZETWsuGW+N6hgyd4WPzXDWn7vdz2kVnCOc1bZ4sHh3bVdVIpxhRsB794N3F+q
 kCmiXRwlcDcmLmyvSPvIEMVF0vKOO+9c0lbp21bicfO9uEdOrZCBi72WBYWmCzZ2
 a4TZoPVkAZrTP5o9CkctunSTn8HGTHaAeqkbnKM0mfkw9JCl1cR9irPJuNMSgRfm
 Tiex9hIXngCrlUlWvM61j97Cqr/dl44qWCWD3vVckt6rqB6vgeMDB0joSfoHEGLA
 krv9aPqcjv6XH7N6MwAm0FcQXlnTv9IqBoj66VjiAYL+r3GQuYF7M84w0ecj5Tew
 OIuKIw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryvp84ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:59:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso186886085a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793908771; x=1794513571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlWfBrynmvfqWSZ4v1xRk+fxYaPoGpMlDK+ZE5l1eRg=;
 b=BMxSA2AYPeTJyxL5qvTpF7b0p3hjTDiLWJq56jImLPG7V8dvY4es6gNYzcZFDgqnbg
 17CZw/3hZAIm2ZkmTB9PvPvsZavpLiO3snt71ISsUvg0xsk5+vfaIwxkifG7gilrwjEm
 SsdlBmVMHIEsUdZ8UpIE+NNPxf6rULpvgC20Nj0qOuoHNlmCktVFT9IcHT7A/cdFXDbb
 FSdRTNA60WxtOqCitF+C+euEsInWnguVOLdHyHhX1reCKrXsNYyNRDBgzbFClvaOVW+4
 4mNMoEnjX68FYQs6bOpQIg+pVezRjRiLxFI32IZ3Ti19SdyGwzNCLwHtJdUzlPWkXZdI
 MBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908771; x=1794513571;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlWfBrynmvfqWSZ4v1xRk+fxYaPoGpMlDK+ZE5l1eRg=;
 b=04XOH6B7k2oi95g+DVkW/eJW99pKqFSArlrseXm7ziuQ+mxk/tmukYGoZlC45YBbCJ
 h9M89lBSi1UhirvamwIXlT5BzsRpAqsxHVFdsIO9rt07DNG6sZKTK3TR5EGjRnhyHHfw
 eR7bz3xSIT/QWBy/wVrt8bjyUwS2dGSnOvMSyVCnEBfvHCl+jg7A2QUNAeKUG/WaLWcz
 CWjPDP4WyZLh89C51SbZ3Afs2rRj9/uAMVZYDz9Cve+TcSzZ0kDGm+53pZWlfkOt3CQ0
 M9mDdwFcfnhRBuglaL6nTfuKxdpu3ThMFKoU9qRyXljinp26flqVpJIn9U1qYPAy9XyT
 eZFg==
X-Gm-Message-State: APuU4Z8W6IK0OfFpDGNg76ZK380BgewcuFv09DCuOcC/sMYmKQExB10k
 Ip5rGd2HuX7WFHJf2skI/8dD+nVa7qw/QqvzB/URNiH9HulT0HSm8r32Fk5ruRt6wYWyc8j/6av
 6703eHh4/UaOv98PeRKg0CbXwEMBp0yXVlD8keerljQ3nzeQw23cchXtJGw==
X-Gm-Gg: AYBFou1arJHeDlJJnS5SpsV27RpULVdN33/wVKg9u2oKh/FNjtByax8c9c7t1elI8YS
 ojHeyjt1E6IBjB162rB2guYiFds3hcQrFLgmcl9ON9mW1ww3cgmE5JB+b4sn3IPVBgMGBwUEvj5
 9SoJe5syIoFTbngThFIcrz1tLlKnuiwbAww28oVHg9ZZlaxVwqdT1oOZDr43RSU2ZvXIn++vbMU
 I6lS3lLCqpRC45eGdcFSud0J1M0HLf+9NItVPM59l6fSKlydVFHG3M/pCe1kcKn9UYtv57aCrEO
 t+2CRX5Y2suDFBJQAdh9AuvBwncjL2GGulxGL1zx/HdkxSnOenCQOxogk0JHRhtoR1YoRe7vBnV
 fJVxTxKSjztapqc5CfjvYZSRbAjIr8YSC7lgGUWqsSOcNaaNya5r3YVHiJMvF/E+G1hnPbzodm6
 ITQ51hOGmSrJdJ5e1SG4g=
X-Received: by 2002:a05:620a:31a9:b0:944:4e6:85d8 with SMTP id
 af79cd13be357-945e1595a55mr624422185a.5.1793908770692; 
 Thu, 05 Nov 2026 11:59:30 -0800 (PST)
X-Received: by 2002:a05:620a:31a9:b0:944:4e6:85d8 with SMTP id
 af79cd13be357-945e1595a55mr624418085a.5.1793908770129; 
 Thu, 05 Nov 2026 11:59:30 -0800 (PST)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6df5eab6esm4017225e9.1.2026.11.05.11.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:59:29 -0800 (PST)
Message-ID: <9754a1ce-71f1-4ab1-a95c-98a16ddfa8db@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 20:59:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] qga/vss-win32: Replace deprecated sprintf() by
 StrCatBuffA()
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Michael Roth <michael.roth@amd.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-18-philmd@oss.qualcomm.com>
 <CAPMcbCrrqrBf_7ofh1S=c=2DFTpZf1SjaqEYnVM=miKbSCk-FA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAPMcbCrrqrBf_7ofh1S=c=2DFTpZf1SjaqEYnVM=miKbSCk-FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ib4Symqa c=1 sm=1 tr=0 ts=6aece023 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=tK/gbQidGls/GiIE0Lv0/A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cjEYgBYo8tDwYd4kLZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: oEPpUl03YGX5PPyo7ihxxqrIQBduAkyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3OSBTYWx0ZWRfX4TM4QpSDClNl
 bziFj3yy5O25jXjmMNQLJwK40wl2UWydwts/P0vJJyUF7JDYviAEDtrgfkoRyO7y39zQeXzX1Gt
 hTmmpR6z4wfA/7qeM3tJFjUoI2iiPVY7xySODUlaK+YMi0uy2MJvBbU7CWRSty2mudQBuKshXjs
 KT4oGYNnU1vTSJtAt+x3wU9IQPXOCSmW4XIPecy8EZmLoBx7phKd1w2lXVrDo/827fQbacLbWN7
 RvxraSZqQxsRQUGXmAattReTtPDCwswGTSZWoZpnLmn6zi2uJY7C5UBhH+nwAEQKYiZ4Bdq6mqW
 PtA+mQ16FAd3LBwS9p+rarxTL11rwFauY2nyn8HxcZJLK/YaeDCfu5z6KsmpC+YQLb6RuooVgRn
 R6zO5r7XEdM4EmU9b9WP4b/aGKPpvOVS3CT2jgmYcDJWkduM9xZ+ezaq31MZW+ZVHjrbywG2SoK
 fVR5fVYrC/W8iCBRMIw==
X-Proofpoint-ORIG-GUID: oEPpUl03YGX5PPyo7ihxxqrIQBduAkyJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3OSBTYWx0ZWRfX1jHG+os8VMtw
 WcLLoxu7NAfvlyQok7tsQfOQHCLmgt5EhESNJE+YoH0WEZyqDRPCZtQq1jmtMun0IhnIbJN+Wun
 yWRhlcif3joo910wEtldf4z9Olc4v6s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 5/11/26 16:29, Kostiantyn Kostiuk wrote:
> On Thu, Nov 5, 2026 at 2:54 PM Philippe Mathieu-Daudé <
> philmd@oss.qualcomm.com> wrote:
> 
>> Formatting is not necessary, replace the deprecated
>> sprintf() by StrCpyNA() and StrCatBuffA() calls.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   qga/vss-win32/install.cpp | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>> index df00588c923a..1a3d5cbf75d5 100644
>> --- a/qga/vss-win32/install.cpp
>> +++ b/qga/vss-win32/install.cpp
>> @@ -562,7 +562,8 @@ STDAPI DllRegisterServer(void)
>>
>>       /* Add this module to registry */
>>
>> -    sprintf(key, "CLSID\\%s", g_szClsid);
>> +    StrCpyNA(key, "CLSID\\", sizeof(key));
>> +    StrCatBuffA(key, g_szClsid, sizeof(key));
>>
> 
> MSFT does not recommend to use StrCatBuffA due to security warning.
> What about using StringCchCatA instead of snprintf, even in this case?

Good point. I went back with StringCchPrintfA() for less code churn.


