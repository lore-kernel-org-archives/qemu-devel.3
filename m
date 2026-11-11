Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7F606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IfzivaiR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IKAH2cla
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRCyg-0005Ie-N1; Wed, 11 Nov 2026 13:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRCyf-0005IU-EW
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:23:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRCyd-0002xI-HM
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:23:21 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtA6L3056646
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uUMDfLJeuEZgiogtdSL0eoJW9Hy08zDmdfG6hCLJS5k=; b=IfzivaiR1uQXxgfd
 GR5DOS8/HPO+xO/lavXoRyT3XMVNTGdMj/ii+y7yqzHabBwXkPsiqatez7uOk8tq
 Wrq6bkIRermzx5pePuSFa/D+7fWYa73UGWVbgWEGA5jG2gbxl0sADPnvuicObAPp
 k6n3HOmy5b/k4CR73o/xPUJj+yobv9Vm0qz9IM2h3/KTpZWQQEjtsuEsT5leOlBF
 M8v5oQSep/bWFV8LTqZUn9lGszVZi4vPGEAC7gc0U59888OBzGRmjDKnZqblMaHp
 WTVMkRPlD/33kyKB0FTU9m7fHD/barxLwgq9oUhr5eo8qkPhH097n4zfVOAkCFlx
 t33R3Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdk8ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:23:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36ecd5db581so6876106eec.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794421396; x=1795026196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uUMDfLJeuEZgiogtdSL0eoJW9Hy08zDmdfG6hCLJS5k=;
 b=IKAH2claocYWtX4jn9EhToLnJrICJcVxCo/wwBdmQrGLzjDejz4ufyPUxSQhAf1Ez3
 N4ZReeVj0LP1TobSOdKyn9oGhEE5rRAWgH8CSD6jjYLzNCeDlhzc3JVkcU2Xb7XXzPh8
 oWE+jjPJacH6+appy3wFSWLTVzuJTtbRZBixN1oU2b0n6WYXyBII0XA+mZMOvPBTyL58
 y+Bm9RA5wPyTvp1Z7zQTvyWMK8e82+Y0fVu3EaegN3qMtoI4EWo46px2AiUQ4dsRsMbK
 lEauK2q8ZDYUb7tnuSqW+pgLf3JgCzDc683dZ2knG8S8MJ1FQtQQY4BnXcbJkpeh0YfA
 +3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794421396; x=1795026196;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uUMDfLJeuEZgiogtdSL0eoJW9Hy08zDmdfG6hCLJS5k=;
 b=ESkdF6ZpYZfL5yJyRyd5EVPjJ9l6yPeQB6szTY4fYVaVDiuPllLLEkt8WtTpN3heiB
 0jEbk+TuAHPh4/dAivEmAJTFyu9ZcMM7DFphePbxZVc36FRMej9o1J6dqTckEHFs2vLJ
 TZCZmIwy5wbJ4hsbexasZ2tVr6zwiclmGYmEo4IPn/Jy1rR+SIftbhgIvX06bviJUBHr
 y98EUf8sLNM3rZuAoO+3Y4E6ewvMf8fvThY/0cUNSCeupQ2V1v33fd+HIgLsK2IH32tU
 GsV64sxDTcti+5CJAOAtSczbxH/C0l5w7yC1JBryR1zMli7/zhduN9FgqgOcxpC98E6q
 dgxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE3HITEGB2bFYewrUgVAR5lBzcUrq5NJrsskJnhPE2dbvvOViYIB4uiDps2xQEkJl674fn26BFeY+yQ@nongnu.org
X-Gm-Message-State: APuU4Z8krMddWy5w7I1nif36Zc03LbH8xsCn9Fdna+OuCJ+qTX7Bt8xT
 fPw1ofGc3kDyof23T6SUTWtz7LjSOMEGTeqk/9Cf+JaqHrrzgZ8OHNC/VGKwMFyqsTstBaL777x
 mWnuveNe8dg0tqpZYT0m68VS6kujeh9p5lvSC6ewlKWnw9tH5NFD36TI1cw==
X-Gm-Gg: AYBFou03Oj8P91MKq6FF/N/q36rDCKYks0druNRQkepuXasPUAj+YPz4HJ/mbpT720K
 G0An2JgFuPJQxO3ev3Wobb48OQmUBYFHSjC3vP+LeMpiAECUQ/4VGgDFOfpA1jlz1GfLzKTMMPe
 neud0KuZTDPdX6Na8q0C+lWc83YkuLXBmsNiAhxKD7iYJHpaROjTurMjyEO/B96v6qqvp55ZXjR
 dJKmXotiSTvzK64zpBOpbakGvQYhEhC75XpkjzHX1JYXXUnRImgnzLn2X58NpnQjp7pTWGFre0c
 XOVeRSVJD/pL646QliU8CYFSZ9cUVUyOeFHrzWhHpWt2gip0wcRKu1/Z5Zcp+hoSsfrFIasNuUK
 5miMSiugLOIGhyg/hwFWV7frfc4wDKR9cbAUTw+SOtNW+nWVBiJlm05XJYZ0Z+dYN7QOn0OvhHN
 f62O0v7Zs2lALjySuTDR3diFJ8DtvRJ8B34JMwakVBpHw=
X-Received: by 2002:a05:701b:465f:20b0:152:3812:496a with SMTP id
 a92af1059eb24-1b3c0875263mr2994598c88.43.1794421395882; 
 Wed, 11 Nov 2026 10:23:15 -0800 (PST)
X-Received: by 2002:a05:701b:465f:20b0:152:3812:496a with SMTP id
 a92af1059eb24-1b3c0875263mr2994570c88.43.1794421395015; 
 Wed, 11 Nov 2026 10:23:15 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b11346sm20730973c88.7.2026.11.11.10.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 10:23:14 -0800 (PST)
Message-ID: <f03c7a6d-57f3-4b9a-8376-54b4c8d6582b@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 10:23:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: add H2 firmware support
To: Michael Tokarev <mjt@tls.msk.ru>, Brian Cain
 <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261024180657.2036255-1-brian.cain@oss.qualcomm.com>
 <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
 <4e004471-b8e2-498f-8c8b-19f0983f7082@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4e004471-b8e2-498f-8c8b-19f0983f7082@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af4b294 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=5Wu2R5wkfPJvXjBZcMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: S9ir_fe1TBDv5AB2bT4TbyfTxahkwPwQ
X-Proofpoint-GUID: S9ir_fe1TBDv5AB2bT4TbyfTxahkwPwQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfXw2h84mhyW7CP
 fWB0OXZgk+dPJeuJWC5lOk9IUt1iNjiZrxsjsOo/DTrPbH71WnZ3einaHslT/fXzgFDqLg4ML6y
 MLOBGt/zlchPx2fInTBxNgwV4y52IThfzkVE7xua921p2b/eklcO2w+zIXUaNOoSdAaeTqKx1n5
 dBa1haB7z5Qtnt0AZZcg1+goDDxWODB7QRl6n8kXRjkR3dCL85A/kitBnChFrwS0fmdBQuqGP97
 1QapPUL+z3/9BuwyexuXOjeFpo5+5mTz8IVSr1ASMT1a7276fJCZCH1VaVYa+WSHINl68v6ozmz
 uW9yUyEs8+4Z7DIJ7X920J36q36V8Ah0pa2HmzwjdWRz1IrSjUqlJC7bWcUdfepwlnd2Hz2eB7w
 4oT+jdf/iH6u3HRcaZpwp8vmRoj4Hym8obpoYdVvz5iRZ6V2cYMJRoE2lK6yndPZrf/8DC2O0KJ
 8K1rakOYrD2c0x9LEHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfX+H7OnA6sVTyd
 CO3fU/3bv0qCfggTr4McFYgcZCPHILydfULe39Qf4PjugyjxxGdNPSEYmRjYzVoimFw5j2KfwVN
 JE9ayMZ+KmIUuu5RDJfLVxsfNf4cR24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110073
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:09 AM, Michael Tokarev wrote:
> On 10/24/26 21:06, Brian Cain wrote:
> 
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
> 
>> +# Needs Hexagon SDK on PATH.
>> +hexagon_h2_build := hexagon-firmware-build
>> +hexagon_h2_src := $(CURDIR)/hexagon-hypervisor
>> +hexagon_h2_out = $(CURDIR)/$(hexagon_h2_build)
>> +hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
>> +    hexagon-booter-sm8975-nsp hexagon-booter-sa8775p-cdsp \
>> +    hexagon-booter-sc8480xp-nsp0 hexagon-booter-sa8797p-nsp0
>> +hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>> +    hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>> +    hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
>> +hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>> +    HMX_HLX_SUPPORT=1 \
>> +    H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
>> +    H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse --
>> short=8 HEAD) \
>> +    H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor rev-parse
>> HEAD) \
>> +    JFLAG=-j$(shell nproc)
> 
> Can we get rid of the git thing here please?
> 
> When a user downloads tarball from qemu download area and extracts it,
> there's no git repository in there.  So the above `git rev-parse` fails.
> 
> I dunno if there should be official releases for the hexagon firmware or
> we can create a file with some version string inside the subdir and use it
> if exists (as we've done previously for some other roms, for exactly the
> same reason).  But the current version is not good :)
> 
> (Testing 11.2.0-rc0 as a tarball, and noticed this immediately ;)
> 
> Thanks,
> 
> /mjt

Hi Michael,

What is the use case to build from roms if you don't have access to git
submodules to get sources for the projects? Any other rom build will
fail, simply because submodules are not present.

The difference in error message is subtly different (rev-parse failed vs
'no makefile found in subdir X'), but the result is the same: you can't
build any rom that requires submodules.

If we want something that works with a tarball, Makefile should do
explicit git clone per project and not rely on submodules.

Regards,
Pierrick

