Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC64606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YdlxVD3o;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QWTbkD/j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1vM-0008SC-9w; Fri, 27 Nov 2026 14:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xX1vD-0008Nm-4x
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:47:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xX1vB-0001UC-5M
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:47:50 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAuY52454926
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 19:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RylBF+1zdDgFUp43TfhbVyR1Cw8wghmmv35rdBsLFa0=; b=YdlxVD3oKd7tZB+E
 BdGxKg6Aza08Cs5JsuuQpb0nHlMbAl7W2vjfXihtUu5uhpyZ9rjURsgPZtf+izSZ
 9JzWWuJvwMKBvUIcnkcgLeKUjZKSYOJ34DgycWpiXnjnQP0UNE6xk4DF0g8HLbqm
 ABcN/9Biz8sX9w2QTWdYyD2Qe+JUu7Sytvt64KaQ8gmEDrq0C1Bd/rfgpSk+MuLs
 K5B8W2vOcm5UtajiIaUyYjX6v+j6ybf1CRemvfiYQjF+F71mBLjnha3oTKayWyKl
 LkFRlnltbAep0LzWvyU1MzUPHOSDLZifNxuIRVSMtKHy2rMDm7daELtaFiLgH+NI
 4EPEuQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3bvqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 19:47:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386c3309469so4228404eec.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808866; x=1796413666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RylBF+1zdDgFUp43TfhbVyR1Cw8wghmmv35rdBsLFa0=;
 b=QWTbkD/j+LM8KL0ezTrXUZmdaKy4Xcc1am2llAInBCH1Ch1se4x1XV7f3Sk4DoCKrA
 eZN6JSCIkUioj214E6fy1LmAIxBo6FL+B3sulLEDGoXDTcz2vn1NQwJt2YB5I5iJcZKZ
 swgE+uNJuh3OiZe4srFuKcjN3k0cNI4wyZ0kjfrZWtXiZj2TNsjteP3ws+rkEQqORAxa
 69vbQGFMO/fgw+oXXENyW7GwxFSb1kDwsG2FRhUbpCyPV8XfjWGWbUVjFiSlN254VBOK
 M+wwmFXfLJNh6CcePd8+aOwnfZ3iAS1aEg8GF4eCpJT/c2xibF5kVzBECtzAms+DjBIK
 XqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808866; x=1796413666;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RylBF+1zdDgFUp43TfhbVyR1Cw8wghmmv35rdBsLFa0=;
 b=edIf5avnZB1f0Va+lXcJ2Vr3boUax5kktyyhcD65Z0dDh0FEQ0SUM7TWgdNz/IAUef
 c5ZU1j2mFRy3wYVj7nhqmRgRf198RdZShLDShfwqIVR0p8IIYNL/8CWATDgIvwPCrH44
 rYh67UZUawzcjZ7kjR9z0ny8mgT8uKshUIaTcqDpy3LpuQ2glAOtr1u6RgjTx6RqGBke
 Yi0bUk3JH1rRbBl9tI2WwYUR41q0iIfJCFdgIHfpVa4/hZefqEM3ZO5wxVEuMewkFI44
 RxUXmtqJI98IbHbT8qwYRm7cjqv7CtetWVkkywBGHQnS3yL3FORQCDGaz7x392PzWWXE
 4L5g==
X-Forwarded-Encrypted: i=1;
 AL+hErG4JujgQxi0Fjh+CfU5YnVkJQ0BM6+fH3DEC0R6nPfXoH2JTk4d3w4xgJuhDa8HBICLIgW1dKMpmMbX@nongnu.org
X-Gm-Message-State: APuU4Z9vWGxTDCxiY2ojewylHqJMqS+macxvDwqL6ruB7/eeFUGFn0M+
 OsDx8Fs4fvNuCX7ND4+NajlE/S5h3tg/lMg9b+SK0CD8CQNGXsO5J2/W0Ns48x9wxHBpZ2HE8Us
 mnan2mh2kknwgwSH98/52OvGaQEPZHCmHCQmzxMGqezMhzJuW5FhoHieB8g==
X-Gm-Gg: AZFdTZenH81/cQXhwflEpFuZpd73IoJJ4JNFTW/aUCNHGfzOFe+OS5qgtA3dms9aZzD
 2cc5RUtkUWOaDMfJat+2Bv5EEnTPPZkUILPR71bQbF+Orv3G4pKUFYSth2IAxE3xh+nGRwFoqDL
 bGqyMDNwzUNViHl1bouHZwmQwMWJyiiK41Hh/D8nBQByJ7a2Vwoucq1fkDwqQa7rSKbY/VdqL7A
 ZZ49DkrrOJSrN/wJBf3w0hq/MJDO16PGja0CkpWFB3c20PFMu1l5GxhjD6xGIO97RJX54L/IM9r
 FCAeY1ugEWXZZxzapWBspL4BZ7stDGqb+6/IHH2KsKeRC5JwefpHwJvfxvkGqWkDZgmVTp92RhU
 KC60jTRNWrBCt0TD/iM9IRPHSwyrKaqf/ddP3fNx4av7vVQNJHvD1dAquieMCiiOB85jI33AwHK
 LXJDgOutm1altdrYH7pgLGG5UXFxHxsWOxo6Li3eGzTeU=
X-Received: by 2002:a05:701a:844e:10b0:1b0:20:6444 with SMTP id
 a92af1059eb24-1b56e185990mr16757215c88.39.1795808865921; 
 Fri, 27 Nov 2026 11:47:45 -0800 (PST)
X-Received: by 2002:a05:701a:844e:10b0:1b0:20:6444 with SMTP id
 a92af1059eb24-1b56e185990mr16757180c88.39.1795808865312; 
 Fri, 27 Nov 2026 11:47:45 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55684c85fsm88807571c88.14.2026.11.27.11.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 11:47:44 -0800 (PST)
Message-ID: <cb370019-7376-45a7-9f5f-a3776676af80@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:47:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 0/5] dump, hexagon: add support for cores
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <899a468e-5fd7-4a99-91b9-309f83ec1d4c@oss.qualcomm.com>
 <79e927bb-dc28-497c-892f-6916e6a832ed@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <79e927bb-dc28-497c-892f-6916e6a832ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b09de62 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=r_X93xHfxAjBygCGPRAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: KUNOnikJgsTrMha50aC9E1enkWKeMvV-
X-Proofpoint-ORIG-GUID: KUNOnikJgsTrMha50aC9E1enkWKeMvV-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX2kEvbweVK0mC
 zhlwFvLikX9RQXzmM/dxvQQOGk2j9oqpIuXvlefrw8Duc2Edew23Y5o69j/sfONj56/nnF9cAAh
 uCLDFbvEIpJCBtXR131awiwx8JCAxp2nELLca+O+GluNqqm5nm4pgr7kquAHibBdCDZko+EQ7zM
 ezCTeJs6Vr6VoX1ARR4dwlSbOdmBNvjbI2rAWqAw7p80+P4qlos7h1bl/DwhR/VlccYJm/fYPo7
 SvGSlZ1XJW6a84bQPZiWCzPejt8Y7F97Ef+66qQovdtuCLQqh09VkaOpdxUjBwfyIVA36+537H0
 an30BrQsqgiEkKsUHYmUGOlxQSLp8lN+Nx+SORysA7STSyZ5xEoK2UwHih20y29fPZwpq3LibJC
 u6JqB1D/AreED5p7ox7MSVG6HF7skuz/ALk/3y4VFhyA6qROvowVLPBJ6W8KjWPbvClo3gwlcpg
 f4/Komh/AKPaq/2qTUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0DY/mSCxhbq8
 e92upjCP2e3atzdcrxLmFaRxrL0jzI55pc/qJDAdnLS3fc77Wy4X5vdlYCBxoFAlIMbi7f61ntH
 O/+uXcGvz44ppUXileZq6lvVRd6MR3o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/2026 11:27 AM, Brian Cain wrote:
> 
> On 11/27/2026 11:36 AM, Pierrick Bouvier wrote:
>> On 11/25/2026 11:48 AM, Brian Cain wrote:
>>> A bugfix and implementation of core dumps for hexagon linux-user and
>>> sysemu.
>>>
>>> "fix e_ehsize in ELF core headers" seemed like it might not be
>>> appropriate
>>> for -stable, so I've not specifically added it as a Cc/Fixes.  Could it
>>> cause some incompatibility?  Seems safer to just land it for future
>>> releases.
>>>
>> Was it tested with lldb, or something else?
> 
> I tested this series with lldb and "hexagon-lldb" from the Hexagon SDK. 
> The community lldb fails w/"Unsupported OS" but hexagon-lldb is able to
> handle these cores.
>

Excellent, thanks!

> 
>>
>>> Brian Cain (5):
>>>    dump: fix e_ehsize in ELF core headers
>>>    dump: let targets set e_flags in the ELF core header
>>>    linux-user: let targets add notes to core dumps
>>>    target/hexagon: support ELF core dumps
>>>    target/hexagon: dump vector and sys regs in cores
>>>
>>>   include/hw/hexagon/hexagon_tlb.h |  10 ++
>>>   include/system/dump-arch.h       |   1 +
>>>   linux-user/hexagon/target_elf.h  |   8 +
>>>   linux-user/loader.h              |   9 ++
>>>   target/hexagon/core-dump.h       |  89 +++++++++++
>>>   target/hexagon/cpu.h             |   2 +-
>>>   target/hexagon/internal.h        |   8 +
>>>   dump/dump.c                      |   6 +-
>>>   hw/hexagon/hexagon_tlb.c         |  17 +++
>>>   linux-user/elfload.c             |  14 ++
>>>   linux-user/hexagon/elfload.c     |  14 ++
>>>   target/hexagon/arch_dump.c       | 129 ++++++++++++++++
>>>   target/hexagon/core_notes.c      | 245 +++++++++++++++++++++++++++++++
>>>   target/hexagon/cpu.c             |  17 ++-
>>>   target/hexagon/meson.build       |   2 +
>>>   15 files changed, 566 insertions(+), 5 deletions(-)
>>>   create mode 100644 target/hexagon/core-dump.h
>>>   create mode 100644 target/hexagon/arch_dump.c
>>>   create mode 100644 target/hexagon/core_notes.c
>>>


