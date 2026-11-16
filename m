Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A300606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gC0/SxN/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jNh03Fi8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Jx-0006z5-RM; Mon, 16 Nov 2026 15:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3Jo-0006Td-AD
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:28:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3Jl-0001Zo-TA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:28:47 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfeBE2042253
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oyHwdOCt3CYqUwKtk7U5qIkh2Wp1sldlJN1yRbZAMAk=; b=gC0/SxN/Ftt1RV/i
 3wBqJ15H3sJMvrQyaW6raqsXzUpSypm/JyUPskHHzpUYKUeNpLHzBVbKt7kYv3f/
 dwB9bq9HrzV9EkXjK1Z+jxMI7Hrat0045BFyLJkCmzxb9HZuojHq+afy9ACilEX+
 E2Va3P2rzh5KJIUYoRwwUx0pIbpnS0WaT0F1+9EkJKZYQfGBnzzBhqzbfdaLL364
 7Pn9yb6RN1CMWEnWW0NW/Shmpl5V9ZVSHiEHf8GlPcjulXe+zGKEeIM3JWKuQAOL
 /YY0P8RaEoZ1pf4YmNn1U/j0hwVuJoQSGCy9+ILvjMjyKRD3avPeK0TPnFmxjp5x
 TE8n/g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g2cme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:28:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37158b53d06so130888eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794860923; x=1795465723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyHwdOCt3CYqUwKtk7U5qIkh2Wp1sldlJN1yRbZAMAk=;
 b=jNh03Fi8FhG9OyuiMLdEI/NR8G+Cs7wgvQA66eFICjGxF19o9FX0yMirBVeQdJzgNT
 ag+YkYEQgneY9cGKvPw1AgbXIaT71/bs4HciU036t0CzSWkxprV7Aw/uUkXLHk2ElHQe
 XMj7WPNPDdF9iW08hlBQ/fnZXu+oY6LFibZVhIXvq8rWZve0qsOP+osBqRWRbFXKUBBn
 Gf6C9BmlJ9gv3/zJ2fUw6JVH09ImITqI56a7DLs/jp48CdNCT9izSABwa0WyoooTKQqT
 VZpjGeCoy+Iw/TuqlhHxFizyqTXxyEath3UJgtFoEcQmarRwbt3Ry/MO2I8zYqNCuXu3
 lZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860923; x=1795465723;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyHwdOCt3CYqUwKtk7U5qIkh2Wp1sldlJN1yRbZAMAk=;
 b=HmTki98d9qIQfHFQV3Gz4OfRxuIEAieBCDiR51oJncBQlzw3i4ujMgWOjEij8p3qrf
 Hh9ufYH9+ME1s2Vit35KkgR8RWavSWGq0UVBN5Hh0ay6hysp1jXDNuzZICWnWvm4VDtx
 NNq2c6T0FIri6RNML/nU0sX0DIsfEFOlKkAc7VUlXbgQPZ4XPh4w38OptOBi1w5OhPnr
 /7KjhI/WFZGAev/96M3/14Z2rjHWENpFjs6RW6OVxaJvKDUUG9ZOsdx5fDQEVEHYpqJo
 on9I9XpM/CPoafJyNn+DbcWEhYQoO+XC8pPBVvrvAj9lSZJhOzJBxEipJ2tP6vcKfVb/
 HUEA==
X-Forwarded-Encrypted: i=1;
 AL+hErEoVbQo4t+DiwNaZ7Fl/QKheqivxvV4Pu2zdfmz3e4RCbGhpngh8z4t7jIFrK4bvVVcvqjngX6A2ulE@nongnu.org
X-Gm-Message-State: APuU4Z8BgsiEShoCCXzRWBryVXWD5o1Kt/O0dMdphlXwdm21frLu3v6V
 eVrt4ZcTHylHpdxAiz3SSjBr9o25+pVijTD0QepIC8P9lN73/4bkLKbgk2aAy6AAJF0BcWd7k4B
 8O9Ucu0SbIEUgcB0UfhpY3GiIJdI8ohPjV49oylwIdKJiJBMe9vpGWz6pTA==
X-Gm-Gg: AYBFou3rMosk+p1kEh0CRi3WdmW8zQaWBcsNvSRyZI7zCl7h/zO6NWpi/IdYSabHZkz
 Uqlprafn1NiEwAbhpcuBKuQzEvNhAG9eVoCwctbjlSHr5q9/4/pIvVW0Qhwyt6DmiTVyQ2ny9Do
 8zmmT1UosIWC5ryIoHL3HhMZM4R/JbhAjd3R7cQS83lFZ1QVmAETdNx3GkUIsr1EA3eJWHiLlCm
 raXwc6N3CBIWfc1Ht0FGR02NQ4Jo/O7UYkUjhXUWrdq126SCnzlTx4APRoHOLBDYIo0G2W0nhzi
 nVxMk9Udx3D+TVb2Lw8rOaRgVzNtLAbYvYI/0BJLmP0L/NYKNdLRhfvnxQU2RsEGFQQabxr+rXl
 0HLdxkP3H22EB/jyckYTdqOsYOnfoh29xkvM1sy7basjoIXhq3o42rdy2xatHpapXGfU1PUMCxq
 czzfld/fXj60FeNVIcM4+ru+aMujEn5IwU31ogDDnS7J0=
X-Received: by 2002:a05:701a:cccc:10b0:1ad:1574:aa9d with SMTP id
 a92af1059eb24-1b53a2e629dmr470632c88.0.1794860923072; 
 Mon, 16 Nov 2026 12:28:43 -0800 (PST)
X-Received: by 2002:a05:701a:cccc:10b0:1ad:1574:aa9d with SMTP id
 a92af1059eb24-1b53a2e629dmr470602c88.0.1794860922258; 
 Mon, 16 Nov 2026 12:28:42 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319d40asm34893807c88.11.2026.11.16.12.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:28:41 -0800 (PST)
Message-ID: <629c6ab4-7ea6-4209-8404-39eb8274249c@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:28:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/48] iotests: better heuristics to find I/O tests
 build/source dirs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-2-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MSBTYWx0ZWRfXz12EyvB/j8zG
 J3b8BpfmXOxb7NFAFjc9uEc1MrxIAFXd2ip3uR2Zr92rERKk415M7E1lyBjznb2kYP3dWOrU/65
 7BuO9pGZ29C73WH5SGSq0ZcBbX302KcNwKmFziWA9oF/qDwLauhd1q8sMl0ue77wvZv3vypyAoU
 ntceBy+joDaRwdoJmGpN78Jl2nnHelQemqKCJpRlt2I+InLtDfGAVeU5tAj7LAZrzYrwUVuHoQy
 1v6FmGcaHZeovQunldYUy6BTBO5NRIvSbypkX91KHSi20YSHAW+IFswblCMs+6bidsBLrVRDJdM
 bOlKhlB/B6rsV62C5Sn//0k6bzqomGMVZuWzotGbwKBMWFtt1EFPGorzrzP4sGErSGLFmSB6Yah
 jnprdR1AeTnYPjtYxUh67Mc2v2bueWbNFiG8jjDTU1+A+UX6Y0MJkjfM35GWt3WgFe6RUe+Nbij
 GgQM+Qt+mR7DOgm+N1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MSBTYWx0ZWRfX3k3McwvuWG2q
 8RWZCUi8QNZjiB1clwAvZwuW2BTCk9d6zA67BcjciZ390dwsLfSxzhQ9O2iXIdfaiHCSYVV+QLk
 1Skrz5dUhvJ14xN6ESM5zFB5+44rbY4=
X-Proofpoint-GUID: Or1s20zeVS8L28fP9lqLw-H_vIEvsVuy
X-Proofpoint-ORIG-GUID: Or1s20zeVS8L28fP9lqLw-H_vIEvsVuy
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afb677c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=fSx4luJoT7KqZ8dMk5cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160081
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Currently the I/O tests cannot be run if executing directly
> from the source directory, even when wrapped by the 'run'
> script, due to inadequate heuristics to guess the directories.
> 
> If using the 'run' script, meson can tell us exactly where the
> top level build and source directories are, so we don't need
> to guess. Just read MESON_BUILD_ROOT and MESON_SOURCE_ROOT
> env variables if present.
> 
> If not using the 'run' script, we can do a bit better at
> guessing the path from the 'check' filename. Always resolve
> from sys.argv[0], even when it is not a symlink, instead of
> falling back to 'cwd()' which doesn't work since we stopped
> having in-tree builds. If invoked directly from the source
> tree, guess that the build root is the default 'build' name
> which often works.
> 
> With this change the following all work:
> 
> 1. From root of build dir, with run script
> 
>   cd build
>   ./run tests/qemu-iotests/check 5
> 
> 2. From root of build dir, without run script
> 
>   cd build
>   tests/qemu-iotests/check 5
> 
> 3. From I/O tests subdir of build dir, with run script
> 
>   cd build/tests/qemu-iotests
>   ../../run ./check 5
> 
> 4. From I/O tests subdir of build dir, without run script
> 
>   cd build/tests/qemu-iotests
>   ./check 5
> 
> 5. From root of source dir, with run script
> 
>   ./build/run tests/qemu-iotests/check 5
> 
> 6. From root of source dir, without run script
> 
>   tests/qemu-iotests/check 5
> 
> 7. From I/O tests subdir of source dir, with run script
> 
>   cd tests/qemu-iotests
>   ../../build/run ./check 5
> 
> 8. From I/O tests subdir of source dir, without run script
> 
>   cd tests/qemu-iotests
>   ./check 5
> 
> Before this commit, items 5-8 would always fail. Items 6 and
> 8 will not work if using a build directory with a name other
> than the default 'build'. For those scenarios use one of the
> other 6 possible variants.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  meson.build              |  1 +
>  tests/qemu-iotests/check | 52 +++++++++++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 

I'm not sure if this patch is a required change for current series, as
it seems to be unrelated.

Regards,
Pierrick

