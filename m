Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FC3FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM31-0000IV-Sp; Fri, 24 Apr 2026 15:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGM30-0000IK-Q6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:18:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGM2z-0006p0-6o
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:18:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OIf1Ol1858806
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tb+AC1tAzwKRt4CcSsWYoG9yHttF4feSEm5yPHnSHNE=; b=V50UTmHClh2B6eQs
 JsEuEr61a0vm5rvCvEIj5ipJaL5YXviTHK+W+9eOgen2FlpoS0gHWYXBGip8m9KC
 w2ZkUN44gSl1YOWr/ndI0uo57ZpGRdl8ZS5+D4+UmcccQdt5mUAwGTwOzD84/8Nw
 oINBNnKzp+4UHqBrZmQESBcNDp/PBFBmgF/ZYe9IVSSOevkTRFj/sWspi4HxRjf5
 i0mSSMZ7we+bLTgRtU9aF4cvOusUiR+nu2Dhb4gr4YS9bGvRM88DFEGvfGu0Q7tc
 /GpuypGC+pNBWX3Z2agRByYqlZgWWqqm/GAiGozlORQZFsNeBIPN7s1r/EBkQAjk
 F+ckOw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dre0wg3jp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:18:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c8de02a4dso10764295c88.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777058315; x=1777663115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tb+AC1tAzwKRt4CcSsWYoG9yHttF4feSEm5yPHnSHNE=;
 b=BXgEoBFvk1QOm3Fr35YirqYIOtwAsX9vt7rdqrb22J3ET5nGzVquGKIbBGerIzcz8X
 zbzg9qvMb9Sy7qqgsOj0UmOIyEJ+ESqsXL9JeMRs3SS7JtLJJNfhgLluRnvSl/4mkcFa
 UWRxi0q8+5V1gVUZYAZ0yCM/kwPS0DBGhCibpi4M41yM40LzlwWPDi4lmKuDo9Vb/esh
 mOKLjVJgXtsiVB5g3txhLJjt34lBpOa8ks8o021VZvdbbg6RwUSLFkVzfCoXxyeggDks
 M5O4HlTNewwZOxD7jLOTBwYBvLFzcLKHA58TwGNpQYp+PT8ATZY/RoiTdSWjnTu7t1GJ
 Lw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058315; x=1777663115;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tb+AC1tAzwKRt4CcSsWYoG9yHttF4feSEm5yPHnSHNE=;
 b=V6hfcmrA1JgRApG3pIv1Tg42NM/Jr7BA23azxrhgzGte6fX+G6pU9J23rR27HPbZA8
 M0pl28wP9XZHDhe2F01ymJjo51x6C/c3s0zFQHaoq1mo6oD5QppvmHSwjeiHhk1TDRN2
 u5zw4/K4mnEDMyrLTuOyx+wS0a41XYatipSszMWcAUlZyJfGzA61LUp2Q0EefQRanLIP
 Q1OOgR5VPVaJLJsIWKUIISXgwoIpU9xDnG1XpUkeRlf8I9FTmtMAUg+F1cQFZ2DTkuTL
 J2mX735JvHnkiz+WQp8Fp4wKuzfDtHvBqIAsI6RaNLVtj7aoynxlU/2K483bc29hWS8b
 SWtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mjJ5G+Dx+iNz9LF0Isig6WtRUBMeU+7GC1PbSEBgjbuNY38+vYW+Hy38tykLBit/3KP9uP3RVQR7J@nongnu.org
X-Gm-Message-State: AOJu0YzfnUeANdqiXJ6L/L5PULZ4OQVAlVmOpbT/b0jzOZW/KeW+4o4B
 u8OsTdvdn3ztEZVRpWBIzgIno3Qyg+aaBZQZ2M0f4FGLz0uEdNqy3ZQ5OVldORWjQ3Z4/8d/8HO
 k1iBpJEP3kLJjanLk4mKfrXSgGwD/18lu59oglZjx41rYdLFU9QKdK2R/6w==
X-Gm-Gg: AeBDietfpgVFNt40e+ACJrMKL2EkkiGB6gJA9qt2kjb4tdwMBrJzfor4YM0PelxUQhb
 EdkMtXfcysJDH0t9arLIXSl6TqDKBHBK29y9mblEFX9wY+s/yQA48u+LOYzkRPZnxZqEOqYVqvC
 TyhvvhoDaVE4YaAxidltJ42xy2/Q1KGyyR4JTpfjwX2JGYTWLD3pfnSnK31IZA/hc4jdDxUfiEw
 X9PLlPhPMouIXSRToiUyZq/YGSyRewsFSkUT5q7OIR83mXaQbAKDgvNyjoychRvlWl1r9QUgnpl
 U8JstjqMd7jyJvnQYbO6/YSHycKmhsaQDUbjYLRWOhh9EFYfSrQqN6ATeIBK0tYp36epe5u4aYe
 tWUfflr79d6ehZ8DOyqoxhIQZ2MCIPcGErGoURQxhrTLQfNPnklmeBwFd+GlldA5Sv9x2OJwKij
 Zp8O2aFJ7l/EWhYAzN9R86ooWI
X-Received: by 2002:a05:7022:fa0:b0:12a:72af:83d1 with SMTP id
 a92af1059eb24-12c73f6f6famr19448460c88.11.1777058315314; 
 Fri, 24 Apr 2026 12:18:35 -0700 (PDT)
X-Received: by 2002:a05:7022:fa0:b0:12a:72af:83d1 with SMTP id
 a92af1059eb24-12c73f6f6famr19448443c88.11.1777058314749; 
 Fri, 24 Apr 2026 12:18:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dca2c1c16sm1917136c88.5.2026.04.24.12.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 12:18:34 -0700 (PDT)
Message-ID: <2bcd35a4-0963-43df-8d5f-e19d1af16452@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 12:18:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] contrib/plugins/uftrace_symbols.py: fix symbols
 reading
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
 <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
 <tdzmry.259an10v60tlz@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tdzmry.259an10v60tlz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H+frBeYi c=1 sm=1 tr=0 ts=69ebc20c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QyBD342zQ3NEvY_O8aIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: _yJvt0DCtE2a_A7OD0VhdsamshOCj4YN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NyBTYWx0ZWRfX3O+S60wntwZ+
 7bQeKksJGbh0FRHAng2qJSouhDSX1AkoB0Nyw+RMEwN8wc0uTbjSmIBIQoK+on4bEGGEFa9XWVl
 aPiU9Q71P3iUqC/C7yNx99gDbybLyHz3e5ajs6lLlhM4SvX091kGcCNS/hn3rz+hCx0K62phhyi
 sGdTR7j0dJ+8+mRzcZxaF/bURqy9dQSqcPqmHvqlQwiE05J3NDIfMv/ZD4fbJx+54uPQeMxqBEt
 vx9OrFZtSkNVrNIYB09M/EBU1APPWxHWIM0+UEyvkXT0YemIrK86adE7i9Igz/9Fi2MqkTv8UGV
 XQPR5/YZzRQdHkiWJJmhDh+9c8kozDVm9zMpl1pyl1bkz373J6klTFh08Q5Ae4mlOLznyugMJKg
 QaTsMOyXztzFIMktkpcxcQyHxZPc30f7fvGDtkFdBTFjAtQ2BEvTKo4xw7f0pZQF8gJgMovec3N
 3yrCECPGhBM/Ke++Nuw==
X-Proofpoint-GUID: _yJvt0DCtE2a_A7OD0VhdsamshOCj4YN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240187
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

On 4/24/2026 12:41 AM, Manos Pitsidianakis wrote:
> On Fri, 24 Apr 2026 00:38, Pierrick Bouvier 
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> When running this on hexagon binary, we observe some undefined symbols
>> without any address or size.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> contrib/plugins/uftrace_symbols.py | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/ 
>> uftrace_symbols.py
>> index 02d1221228c..895fa1a6b7a 100755
>> --- a/contrib/plugins/uftrace_symbols.py
>> +++ b/contrib/plugins/uftrace_symbols.py
>> @@ -36,8 +36,8 @@ def get_symbols(elf_file):
>>     out = out.strip().split('\n')
>>     for line in out:
>>         info = line.split(' ')
>> -        if len(info) == 3:
>> -            # missing size information
>> +        if len(info) < 4:
>> +            # missing size/address information
> 
> On a second thought, shouldn't this be != 4? Otherwise the unpacking 
> will fail with ValueError: too many values to unpack (expected 4)
>

I don't expect nm to add new columns, but you're right, it's probably 
safer! I'll change that.
  >>             continue
>>         addr, size, type, name = info
>>         # add only symbols from .text section
>> -- 
>> 2.47.3
>>
>>

Regards,
Pierrick

