Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC22CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxV7-0006Gl-3y; Wed, 30 Sep 2026 12:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxV1-0006Et-II
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:49:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxV0-0003I5-3i
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:49:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UGjFRF4035250
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Hsl3omRAfgRz+HbKeMzIN8QIXcOdlNfk9fc30UhFLs=; b=mxOmp45rrx76ImsC
 6ub3FbjOL87/ra4YB2fK+/8jSYM0+4TC7RRRN2UN5SIrdbsfKhy+aAhTBYnhh/aZ
 hWWgE7x4Vdz3biBf28htZMBI0LJ2hv/uFoeRBj7w5no37ekqSFvYJIO/cjaR2UFE
 RS0hYUuVw2aHh++txI21yM3BZH+8+a5cyQF5dEPiezqjbAyLFa+bDHhjpq/Pgh2g
 BJmfeli718MMcdftTZKdwSkz+l/d7Yo2o+wYBME4jx12bptJwabU0kJY68OFcKc+
 rl+sCyYsmYXobBR2DSImEqPRNOJBot1N8HSgHayDRMXUiNUAlCIUy1Rsr8OL1mn2
 Ex1Q8Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pg147-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:49:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5d7c4c26so1053773985a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786979; x=1791391779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Hsl3omRAfgRz+HbKeMzIN8QIXcOdlNfk9fc30UhFLs=;
 b=HuuGVgkjiulluofYVbR6Mu50kHHoyo5XAlewV6EYlwCg/H0vD8d1oNRBlRlTaHo9Oy
 eiNz05l7AuR0Wc2cKo3O2MAbDUAeXz4M3L+VV6F0YsDEBiz/wESLDrEPNhY6rXUhGMn7
 49SnD2Qp48Pc82WGYyxhUTseg9J4lNLMNfzm9V/B1/yRJV2rVFC8ev+g/PXYSV2NmZ0S
 JE1D6P2xefpksBwdUv3khS5/BLKlqk9jkPAVRjQcNSV1csHo+4D3DD6dx/jXewJz/lwF
 Iao9OWbJL7qTZz4rF7MMLYLr/tQnxUwUIshx7u8Da5j2WAO6IHSgVFvRtbcSX4NzoAc/
 nAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786979; x=1791391779;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Hsl3omRAfgRz+HbKeMzIN8QIXcOdlNfk9fc30UhFLs=;
 b=iFNXgzs2NYHSf7+6iZXBo3IoA9LoIBTWvd3MiShL9CaHKW5qVlbmCj8kUc6DPoW9SR
 0nMzVdxI5gmciuAuUV5eceIav79paVjSWG4W/GKBVSAdlA+KTJHJ18+GR9fmN2w7z9LJ
 BQtz50AsY0eE6eQfJsBZ1HLqthEupvj3c96usiuRmJEfN/H+oifLEcnibLBARy/entfb
 OhCPXeW5ZUJ9CROP86JOrr2knVkFU6+lCTahHkVLvs0izODNvS6zls9ige0g//zv25kj
 mYDhrEGplguSoBapnNnD44LMB/c1Do4LPE1CxfiXTdrc2YL4tiXn9L8s9/md5uUb7X0j
 3Y3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcLXUmAh+R2De6vq9XnRwyiUJ5Wmd1ALDd3ryheAcMTXPTgxBoccT47EUndqAzAhn0x+rGfGXA3+1O@nongnu.org
X-Gm-Message-State: AFuF++nlOJbaiIredyWHbPLYuCUdhJeiRwaArWerPF2zQwPdjrJX8RVJ
 WIpfmUWIIb5iZpHNbu+IemyqVvRjy17YgPxGHg+FCBWjgrdyw0BlW36aV15Vr2CJKltXut3HBBZ
 A11rJ2EcFR8az993r0k6eFHvht12PKPUIkO2A1Rt2xdkfCkvupWQt1hLOVw==
X-Gm-Gg: AYBFou2/YjAeHAIHARuEUPfghaIoKiw0Xyx/RfqGkV/iDfZpjzMCZIsd1MuF+6fFzev
 2shzQcoArICRBLFxw5SY22HPkG0dLT1keJefTxgspmQxARREvymMn/9n32Ez1VDfzrY9lSi0lVe
 fA6K7x/bpbHqI38h/jfnPbfBaSL88dmTeX7C3sGQDFhicXeOz9OIUL7fAQ5lmQYwB5m3tW/owLo
 mrNITIql8TpJZqxLH6ro2COEptHpQs4sIYLKgoA7WskR8RZzhXmxVCLS2G35wQkUzGXlp10CBgr
 m2lFTuArxh6fYd+raWbaNhBChk+YxcvoIo7lvQQlQf90w+q5k1p6rSo0zuhn/YwSezMqXNQbY8m
 pmhj+UAtSBoNZmXGmcgU=
X-Received: by 2002:a05:620a:7102:b0:930:f35d:41ba with SMTP id
 af79cd13be357-93ca972f3f6mr347900385a.36.1790786979552; 
 Wed, 30 Sep 2026 09:49:39 -0700 (PDT)
X-Received: by 2002:a05:620a:7102:b0:930:f35d:41ba with SMTP id
 af79cd13be357-93ca972f3f6mr347895885a.36.1790786979078; 
 Wed, 30 Sep 2026 09:49:39 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff64asm238006f8f.10.2026.09.30.09.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:49:38 -0700 (PDT)
Message-ID: <d780aa85-219f-4ecd-8524-9e6c6d08435b@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] CCID smartcard reader fixes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <CAJ+F1CKfsCkk_dtEd2YXTdT1Bno_5Z5kKJxg-22y69+cXem-qA@mail.gmail.com>
 <CAJ+F1CJm4j048Sv5po5zn7NRd4c25k6+VEnfDGRf4+2Tii80Zg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1CJm4j048Sv5po5zn7NRd4c25k6+VEnfDGRf4+2Tii80Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vJ9rkxZYTgvMCNj6LVQDnuTYiQ8UmxCU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX9eOlsjOk74i3
 KSiq0ub3AOXfwU+HHUf+hrmMEnfA2qcsHHfabBBALpplejSgvDiXUjdeE88Y002ioVidKbw1iNA
 JNyI2/aAu/sX/cE8vb01/1Juo+k/m+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX8liilq4GUMzM
 iDJcFc0u8+616rGGHZ/mLyrA13o3u48g2z/oYPc22PVVh4+5Aq2QtXwfPbIjSaUW1GwWkwI0EWR
 KmuQu1KPckLfmg2bohgysZawYKkCtcIOjQ27AA0JdHymCGBAjVzoRK+ijDRZro1PAk5JweolEy3
 JigCJxKssomVR36NPPAGI2HO93Ga6VNgScs62o8ZcrY0fTswWFy1vnn+QeVzurMLX20lA1sSTuy
 kH+/8h7rM0gNIYhcTYpUxrmpBxyrQZlyxqsaGh5KUZEzQLi28tsKXcR61o5JlAyYxX3XG1YdQRS
 4VihQKcNdMWCKvA8tHAVZMr14SvCpWGnCgTsbo4hFTzPVj19BEhQYSGQbTi+TI3GGVqsNPJu7Cn
 0VQid0TMQngRoJF4LqsDNvV3EvBWfVQRpgEtv9BiCh8nJufLGrPJwoIs1EMgGp5RV7LUjxXW5G5
 6YV6WK6L2xcDrqQosow==
X-Proofpoint-GUID: vJ9rkxZYTgvMCNj6LVQDnuTYiQ8UmxCU
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abd3da4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300067
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

On 2026-09-14 12:59, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Mon, Aug 31, 2026 at 3:36 PM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> Hi all
>>
>> On Wed, Aug 5, 2026 at 3:52 PM Marc-André Lureau
>> <marcandre.lureau@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> While tackling some CVEs issues, I also found several correctness and
>>> robustness improvements/fixes. The series:
>>>
>>> - has 3 CVE fixes (OOB/assert)
>>> - fixes xHCI compatibility
>>> - some endianness fixes
>>> - blocks & fixes migration
>>> - better spec compliancy
>>>
>>
>> almost a month, and no feedback. Should I just send a PR?
> 
> I don't know what else to do at this point but to beg people to take a
> look or just send the PR. Any opinion?

Sorry for the delay.

I left a comment on the CVE-2026-18204 fix. Please -- if you agree
it is correct -- squash it before sending the PR.

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>



