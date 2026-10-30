Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB72606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lsFyLRvh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SpcsvqHt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkdZ-0000NW-47; Fri, 30 Oct 2026 07:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMkdT-0000N1-Lu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:19:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMkdR-0002Rc-4n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:19:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGErI2784198
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jZfjE0r9Xn+L3FIBPpeJI/9+r2/G4aKjXZOFrH5dJI0=; b=lsFyLRvhBLuZXi3Z
 51A1m1H4QvmaOyrkEmOxhK33U3FCh8dUHzv5xHe3ChLirfnsWspq2j39EvH30ASO
 MHUX+E+D8n305RMNlBGfiHxIkOuN3YFi1XA6bAl/MUifQRYm9nL6eO3YEowhybGK
 VycJ/DqzSorL/zIB/XvT/zffQP2RCu7GlK11ivWS6Q2msSddV5Y5FG9bfo9uqQ3D
 C7dCCETZTymqE8a23CuArRE7DgPdYOjizEmoQ23yD84VHn2bf//YqK22xLjCrXu+
 aA/UcUGrkv6o/TEV4af3dvT0SnVIlLoqOqtEUup0nf6qJgihvRSQKZHYdIj7cd/y
 1PV5zQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qjq63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:18:58 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98f0cae5b9cso53710241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793359138; x=1793963938; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jZfjE0r9Xn+L3FIBPpeJI/9+r2/G4aKjXZOFrH5dJI0=;
 b=SpcsvqHtFGUHr50MQ+DIEJxGpal9vU4AcxxaIdPcD/wXXn556e3GxSqIG7KBdr4irX
 XERANrkKOwjW9wImm2I4v7WR4+fNLRQT2IfF7hOnvZzA2dLtshBmbUHnNdwMRYy8FQRE
 d0NBvvqzD12YmmYmIHqZRQNgLVj3R0YnBMitBNJ6bHqqfiD/YYjBmK26DmTtiztrmx+G
 /XBFo59Y1elMJPqQ4iKLaBoY1AQWuiHjSGJvVRgZatnV1AMYgq/QQNqIwwaMhPZHAgfW
 YfoGwoQnYya+P9l2845jnmzW+o3qim5KR+aByw71f+Tt74HHQ1iJb0cfHWr6HK3zUbcJ
 n00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359138; x=1793963938;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jZfjE0r9Xn+L3FIBPpeJI/9+r2/G4aKjXZOFrH5dJI0=;
 b=umvhTStwOpOg01LA3XcUdBT9N+0r2smiWIksdEUIh8Im79Pi6KihMFICRANSpQIXE0
 1MYlu6I2IT+8GmDESoz2NaaDPM/iT7z4F2Ll6uoI6VYi0Cf4iOjRIbkFtsLPQmbIIWHv
 pR51dw/KShYH8YuiOgQe9CcRNW2HDAhb0+rbhrqNuRWJLQmxcLrA2CuAze6byL43gN9F
 aHcLU7vg7tm1C6uk7aza/KMGvGrszc4rOgBKmij5l0uoGtz5ddFSCchj7JG092Ooh0yB
 fem0yOR+z4VWYyLXMhepEf2cS/cknVY6qwJw/MHOqumNzO2RNA8yWC2HnBlwgjPnbpWq
 iyyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf+QL3cRid6dQZyHnfd6Aofy5fVlrYaq5osKB9zgOk/wLxw52BlEhpl+qBWBNB8B1ghge/taPtoNtj@nongnu.org
X-Gm-Message-State: AFq9FYLWl/i9UJVFHe3JX8j0VuF4qYgFcLs1h5MheaqGVuOQd3N4iC7k
 w3KWTxIN/HKDNYqDEy8fJv3syF8GPnBg5gj6MwfPtVNoujyAaQZUW2CbmXpZgQqyYASP0xeJaBi
 t7GU7DcUB/Xf1hX/hgp63EDmtgXQJ66E50wNdA4PyBus519nm+h3t+6jm3g==
X-Gm-Gg: AYBFou0GXsEEDQvjYvbPvAN8iCQrduFMu9ba/aObZH9r8nwvH9J51e2u4wpp9dg5wkv
 uPQFTrGJ5X2CBGTg0NCmKh8libI9vWIcLMScO3AppDRXZq6Rdpk97iC/4hIf5t2CttvxoERyY/O
 uCZygB2gePibpJuhuVYD+y+E2vwv6pAMer36yHpO0RstkBSAa0+2DqcwhkFXfrtuXDho5y8e1bJ
 E9BzoY+IKk/DJqvihZvi2cvoL8FjiBHWt7PGXbQL/rZE54gLlGOsprZwNRI4WDUHPDleF+7XrY/
 o6wwiRhZnmuYUTIn2QgrtY6ZoM0n3PcFwOOXXlkq1vpTrJQlo14Wo+XFxS0e5OwQ9nZZ7QXSPjm
 LY+VXixaaC+ReL3+5yU4qr7QdHOsNoK0s/aKPXwJpMwKCLsAIzCfAvhkKpDwN6cs8SXe9cIZ8
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id
 ada2fe7eead31-7d0725e16d4mr724725137.21.1793359138162; 
 Fri, 30 Oct 2026 04:18:58 -0700 (PDT)
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id
 ada2fe7eead31-7d0725e16d4mr724714137.21.1793359137599; 
 Fri, 30 Oct 2026 04:18:57 -0700 (PDT)
Received: from [10.111.141.177] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm2670939f8f.57.2026.10.30.04.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 04:18:55 -0700 (PDT)
Message-ID: <f65ed1e5-10b4-4610-8981-6fe4d9499090@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:18:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tests/docker: Add the mips32r6el toolchain
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
 <20261029174434.27985-2-philmd@oss.qualcomm.com>
 <474cb441-7d8e-4bc0-933d-8cae08e98aeb@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <474cb441-7d8e-4bc0-933d-8cae08e98aeb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae47d22 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=BjUQuXb3_Oxl_CUVfsQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: siToUKIaLSOogyoJtfM7VuqWEavkXTOq
X-Proofpoint-GUID: siToUKIaLSOogyoJtfM7VuqWEavkXTOq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NCBTYWx0ZWRfXwgOrxNRGTpuq
 yKMw36ksm3lJ4otqZR+Fy/1N89BSeA540jZWPDmq2AhoeLmG3GPhaSpAmMXGIUx/ygQxl+EOA5+
 glrZU8HImNK8gi76ol76gQ8tOYn1HrsO28crW2RP5uD66vjluIKZjrzNmH1iOw9uNK0q5nMQ39v
 7xNLalPx2TUKF0ZOfu2flQerYmPnI0iatbg8qaecZJJE0KMfC2ovHQbdI0nJhLHOXAjEhxmbjhs
 TIUaYz+aUdxZyYrsduBWzNJHEtsb8mpIlGTGkbRnh3138g9YGyXW/h9lnrSF2nHYN/iaRMGJk7d
 uEUcXTkYlzq2bKO1rl2oNUbRpEhim3VvxFOrHQvrILpCGzfEsmIPrc0lRXnae2HzEuNqiuyTJ5h
 NaNjAU8G6oeZFVgZX07PK2YcFN/rLxpHMr/LluKIh4iiXil//jO7ME782VVGCaStF8omFQ2J8eP
 J+rzXt3JAwmCS0o0C8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NCBTYWx0ZWRfX5EocuI9yhrdM
 2r1XB4OGgHgnGSnVtuzjOFZzCo4BBmGu7LK8mqVYixtSIm4chmZsPiOyMQWDuRGCdYih0z9tYWr
 xYkY4l4ZXW8UovKqsAiIw35rUewkOcQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300044
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

On 2026-10-29 20:27, Pierrick Bouvier wrote:
> On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
>> Similarly to commit eaba84a5e1c9 ("tests/docker/debian-all-test:
>> add mips32r5 toolchain"), add the Bootlin mips32r6el glibc
>> toolchain, renaming its mipsel-* binaries as mips32r6el-*.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   .../docker/dockerfiles/debian-all-test-cross.docker | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> index eefc03c49a4f..d0e59df84ebc 100644
>> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> @@ -129,6 +129,19 @@ RUN apt update && \
>>     rename 's/mipsel/mips32r5el/' mipsel*
>>   ENV PATH="$PATH:/opt/mips32r5el/bin"
>>   
>> +# download mips32r6el toolchain from bootlin, and rename binaries who are simply
>> +# named mipsel-linux-gnu-*
>> +RUN apt update && \
>> +  mkdir -p /opt/mips32r6el/ && \
>> +  cd /opt/mips32r6el/ && \
>> +  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r6el/tarballs/mips32r6el--glibc--stable-2026.08-1.tar.xz && \
>> +  tar xvf *.tar.xz && \
>> +  rm *.tar.xz && \
>> +  mv mips32r6el--glibc--stable-2026.08-1/* . && \
>> +  cd bin && \
>> +  rename 's/mipsel/mips32r6el/' mipsel*
>> +ENV PATH="$PATH:/opt/mips32r6el/bin"
>> +
>>   ENV QEMU_CONFIGURE_OPTS=--disable-docs
>>   ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
>>   # As a final step configure the user (if env is defined)
> 
> Would package mipsisa32r6el-linux-gnu (and companion libc) from debian
> work instead of this one?
> 
> I added mips32r5 toolchain from bootlin because there were no matching
> packages in debian, but I think it's better supported for mips32r6.
Indeed it works with the Debian toolchain, all the tests pass. The
only difference is Debian packages older versions (GCC GCC 14.2.0
vs GCC 15.3.0 for Bootlin and glibc 2.40 vs 2.44), not important.

