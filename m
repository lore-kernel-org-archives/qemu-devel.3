Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7F606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=miEDe2I3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEyt+23t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0wd-0000wn-JG; Thu, 19 Nov 2026 07:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0wX-0000ow-Ma
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:08:46 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0wV-00023p-Rz
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:08:45 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBkik12685286
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /Jd8z+VCh/y1vhxDPfLkrH5SPedM9ss12fwyVG1O+JE=; b=miEDe2I38j0gmRrr
 3YObVwsHljSCxL+lTreD1s0IBo2vnopef4KP2QTI+S9O/BfQur40rszsrrwBhAMH
 Pz6UjFi/BswkO8HaO4ToQob0w958d2AeYwWytFbdNqGLa88rKCVEkiU+LykbepPB
 9zB+Zk2l6hYjif4jBF2LgeP4rldPcZjHfKCmmGhrkxT1uQR9kHjGjbfJgGdtEhRc
 Gvb+bfh0NKNGrCqqqXjXSDM23QITwB4t/Pzqx4B3Emi9EOPv0EMSyFopp6Z82O0c
 h3eP1/KEQqdH8Re63krBaeMifgU1QgW+zKpYDrdyHwY7g4IP188KBMC8phoiIVSt
 sDHlhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j20gu82rt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:08:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so464857485a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795090121; x=1795694921; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Jd8z+VCh/y1vhxDPfLkrH5SPedM9ss12fwyVG1O+JE=;
 b=OEyt+23tHNSz4uTGQXZUZ7Wna5m4T3zv47A5jC3Pl4+jUb+Iz/oXPDF9ycZbT5+0+I
 1quSuw0XGyAtTz8uVMRuK5dmO2Nyzwss7Q34cEjcUyOvRcdXteUZtLnl6d8hW1xhPvQe
 DHyhlWfmcoHTgEkXqkgDHUPujca8/UjW4m/rMZHiw/KDiGB4Qb87M+6dIOPhL+4CGV8s
 dGVHrRlg48isAQaNW/e83lzVj+uNt48/lsMO7W18aWJ3jT0X2wvuEK1JTPXdubgPlIs8
 h9IUW4iKCVvjED0JQ6yqXfb8lBae6uQHp9glWTZ4kVfYsyAHHohxKYvCpVoltFzUxWB5
 73OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795090121; x=1795694921;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Jd8z+VCh/y1vhxDPfLkrH5SPedM9ss12fwyVG1O+JE=;
 b=oYSP+g5SACECLg1aVS82aCHHmsm2oEbnggERU4+/3FPSVJzkOJzUOmHhd/aWXhNq77
 ioLoK+j+IQTkBxRepUw/T+OFoG6LcnpAJDj8MPT/o3PjkqLDKxUJOK8HWt3Qp7xxIHhC
 pXWaR3gN3jKGFbjSUJC6+b1DfO3y1m2FCA6D2frFqU7HcphezvR9Pscn7+G1uu9WIjGF
 no8MPPx5r1d/U7SidqB/fG21MF+frZpJxpS8l7Y/A8SnkOtYV3IbUcEv9XaPHyMd3Mlo
 QaS1ZEQUySXBxB/NP70EDXA5EryvcFoZ6RotWRxrqhbvek4XEzXFlRKFIV7vPYQYM2Ie
 wuDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErESyejLaBPh/PWFGgneUTCwrSAVoobpx+JUYGDIdgA+Wfxk9/3zuErpY/YVvZsd1WyvPjm4f8lGZdGC@nongnu.org
X-Gm-Message-State: APuU4Z99pR75hMlLIrsvnrhBVAR8JKO/SJpl8Vxtqr61Fxly6MaxjTf0
 ShIZg/kjh7gTbryNE1Lh41fpJ7Z+SDRiXGCQeZK3I9hMSXwUV9hl+RAwvpt6htOMRIBo8lyhHj4
 krSaZh0CBJzcKkQ5uPb/I/+o/wv8L1u1vlE2foMOWZMyd8WELCsKQQZMPcw==
X-Gm-Gg: AYBFou1JVpBz3sC5KPu7NYi8u1dbo5R6pYPx/005EQYJ2tMTBN758q+D4IHvszWIRyq
 H64LZVvxqKyJ5KE10Z8db2D/YX+IvTcRfy7l/mp/9rUqzWmoOLsple1fsr4E8Sn3hfj76K8gxiF
 8zpw6k2LjiAippcmtWccDFE2etmY5qlACcKj4+/pJP/oU3R9s8KRfiFlyaDA1KLBIQq+Gf2YUPO
 QG3gIdo9CMPgPp24fhgnSSa+8fddn8bdxJtW8CcyKnfeeGDNhzqS7VZveebixa9ZZ2jP3bC/43h
 4LpGdKw83mj8cgk/5roU6RfxizmgFspk66kcQs0ueDC63K47zYVzDHPoU4Qx5vIay6LoBTrQ2DH
 /7eaQipTkcNy6vMNl+wxKcitaB5W1paRpk60SEnQ8ZGrxvGMhKCE6CcHpdoWArCeL51zBqnXxwU
 3AGmH+tAo=
X-Received: by 2002:a05:620a:8013:b0:945:afc1:a73e with SMTP id
 af79cd13be357-949994af028mr896585685a.8.1795090121064; 
 Thu, 19 Nov 2026 04:08:41 -0800 (PST)
X-Received: by 2002:a05:620a:8013:b0:945:afc1:a73e with SMTP id
 af79cd13be357-949994af028mr896582485a.8.1795090120606; 
 Thu, 19 Nov 2026 04:08:40 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65541f3b3sm10350652f8f.23.2026.11.19.04.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 04:08:39 -0800 (PST)
Message-ID: <bf9dbb38-3658-4838-902e-58b5a2dc08cf@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 13:08:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] target/mips: Require the MT module for MFTR/MTTR
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-4-philmd@oss.qualcomm.com>
 <ec413b6f-23ff-42f6-8e21-52c565afb426@linaro.org>
 <72caf091-61e8-40a7-bb07-abd19478f0c9@oss.qualcomm.com>
 <663f579e-7281-4b71-9e38-d3d5639af55e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <663f579e-7281-4b71-9e38-d3d5639af55e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OCBTYWx0ZWRfX/GW7WQ+ICxhO
 8tz5N5qkzIWbMhc7X/vRKW10yU6pXagMwKW/oueaA8FDtIJzBmramdDdXaJcZDU55bsnGn7nOEu
 VMlDVI4lVXP/Fa3t8JrDSE2jOehnpqw=
X-Proofpoint-ORIG-GUID: 9cFrPMsnsujTucb1GixRvIS3aPJmDWbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OCBTYWx0ZWRfX0AqVLfKNsWWk
 Tn778DR+GmzrdOw5NCbJWb3ecSCVYUPYaKVLZLBM52HivpZBjDrDvhKZKXCFjA9QiFNvzDM3HVm
 Q7cg35PuDXcd2P0LSV9GLqowwctqNx7lZ1ynaV7k22gK0WVhV9wq9DwbPZmlm2WdDjwzyPNOrQH
 Q/gWA1cjhB3g5VY3+5enRFTljQgafp2RUl6Vd059PBcKjDzlpqSNp/fyU3oMJHD3eK+FaiSJXS0
 BHhqLcss1bdp9/ekezPW2aWVwZvT3FjJ/311qr3K0asTVyqvsNLpaJzycUrKiL/HwOCeU/ICq1T
 wz8cMOxxAvXbkglau3ofdNWSKETNgwnRngklLKpWE5owJr9af6qMLUGAiz27DDTnRSF7KuvEy6K
 5mzMmAWWakcMWFMszLxeZWUwlYd+XzI5hh9hmA6/2qmaYPudPagssP2Vj7ojIc+ePXLGLjdoRF5
 XUSf8IoKEqXXgVTBQ3g==
X-Proofpoint-GUID: 9cFrPMsnsujTucb1GixRvIS3aPJmDWbQ
X-Authority-Analysis: v=2.4 cv=XutvqlF9 c=1 sm=1 tr=0 ts=6afee6c9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xvT4CB-XxrhjR8IleK4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190048
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18/11/26 01:01, Richard Henderson wrote:
> On 11/17/26 14:35, Philippe Mathieu-Daudé wrote:
>> On 17/11/26 20:00, Richard Henderson wrote:
>>> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>>>> MFTR/MTTR must raise Reserved Instruction on processors not
>>>> implementing the MT module (MD00378 pp.46/50, Config3.MT:
>>>> table 6.21). Use check_cp0_mt(), as done for the other MT
>>>> instructions, instead of only check_cp0_enabled().
>>>>
>>>> Fixes: ead9360e2fbc ("Partial support for 34K multithreading")
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>   target/mips/tcg/translate.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> Surely check_cp0_mt must be enabled for user-only,
>>> not sit behind an ifdef.
>>
>> I suppose I got lucky, MIPS_HFLAG_CP0 is never set in user-mode so
>> the OPC_CP0 dispatch already raises CpU before any MT check could apply.
>>
>> I'll remove the #ifdef (and fix the Config5/Config3 typo in comment),
>> thanks!
> I meant, check_cp0_mt is undefined for user-only.
> How does this compile?

It doesn't have to :) gen_cp0() is itself compiled out for
CONFIG_USER_ONLY -- the #ifndef CONFIG_USER_ONLY region holding
the CP0 helpers (opened at translate.c:4875) is closed right after
gen_cp0() at :8717 -- so the new call sites only exist in system
builds, matching check_cp0_mt()'s own #ifndef.

Still, check_mt() is available to all builds and there is no technical
reason to hide check_cp0_mt() (its body doesn't use anything
system-only), so I'm moving it out of the #ifdef as announced, along
with the Config5 -> Config3 comment fix.

