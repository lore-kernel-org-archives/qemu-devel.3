Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l5w+JXJz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PKfpPclb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPcm-0006lp-Op; Fri, 23 Oct 2026 20:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPcl-0006ld-Rv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:28:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPcj-00032d-GR
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:28:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvJGK2963825
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gXvp3//yEkh1wZo2X9INpD6RaEG4IzdHVEoT3HNRgIk=; b=l5w+JXJzGAX0hx1X
 8ZkOf5BXHir9sGtxBunQuM+31fbpQLJI8UX7JtpzMCVMK4qIly4MJUxTzXq54soc
 XOOe4FFfqhXf2dprtpncdeJr2gU2mkmLbquq46pcgPjs6Hiofukqr3AGJZI+9DiR
 NJGDqGBWMT04V36YahefXaK0fZ69QfHdRThRYMbX5Iz4LGrlx8IpBBcbvpKDA65m
 hqR2q7X903awf6C7glAbkDi1Q5q3md6kUaod4k7y9/XT9lj/9TJ12Rs74nmNceMq
 AjXSNSV7hlIZNrBQBdQeV2lFCkLWOdieCNAYSsP7XATassyFRPMJ9SLL2ZWly7oc
 A/4lpA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc9h73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:28:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a04491c56so1121686eec.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792801714; x=1793406514; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gXvp3//yEkh1wZo2X9INpD6RaEG4IzdHVEoT3HNRgIk=;
 b=PKfpPclbngb9I8pXZYc+fSsubt6Tr1bsNDFW6d8CFtUHs+jaEcGvhx4dcxTKYFnsLK
 Jk2v87B0Zf7vzwI19Lxnftb9H1Xxht7QcTEdkmPAFfCUWuIBjM8zQSaYUe5TWyycA8+u
 ExtXSXxV4OjaANVUqMt/s6E3nLBMvb4pALxJo8slk24kWxQWGVHPstQgRwjx2ALQcLpU
 GDwyHFSvSEnwTSKingFS1Sy3bTEvCz/c+X8OpkAF7Huq95Us2i1gNWnXgDOjVWPwpM/X
 1GTwAt1/ab7QlgGeKUlBaDne2XwOav91NtMU3I6469LD8TarY/z5VQNIxxF3tDVwJP79
 v/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792801714; x=1793406514;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gXvp3//yEkh1wZo2X9INpD6RaEG4IzdHVEoT3HNRgIk=;
 b=HdasUS2H8szQrNipHVrOc34CaDByfwVGjijJPHIj//gdjIRGWLipQGiORZ7ip/SMmR
 ZFtWl2ximXziZ9SB36CA9inXRptjC27Yv5ZxtdThzYyamk9/d0hqJDmkwG2VXnzjWS2c
 +8xQ5tMz/+iatFq50Frt4dUa5lvRIuGieFf4LJN3Obz7MCj0zN7rHoq7oipdMmCeibbl
 wdWHPfJC/qFT9EWK0BoVfNwTyUJQkohBDmC39e6nmaeeTyhEFotFdp8LmheLhoZx/LtS
 FWa6GzwydpIyl4Ywh2bKHDfw31IL3l3TjaVg/tmsIZd8x6qBEI2BdwpbTi1SXtiw8SP7
 MVOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMDBRqfhAqaiyodh7T8yw2vQpiLLSKP2NgYvt+T9ev1TmPTS6NhG9EtkCERIgIfYZYIWAuhL14qxUr@nongnu.org
X-Gm-Message-State: AFq9FYIrGXez3KsrjcVZ2FjF2bT2xu3pgrKcboxuLmyj6muLdCNr2ncq
 GYzI9L3aGFiv6bGMZwMc6nKrHW9BXEVdd5XxbVvrwZkmKbNjb77UzEIrMGrN6s7kdmOBdwVMWdI
 J+AA/ULBiAVi3HUvlvEfI1HFix3VYIstYbQRcIs83J4KFX7EQvORQBA362A==
X-Gm-Gg: AYBFou0ZvXld7cuz5c7viDW22S5nCO+7tX0Yzlf9zvlxvESR0a/OUN9zlBBf62zIl00
 ebHjRf96ZP6iVlB8x4JnRhW6xIMkKurkb9TP5oG0U77yKQXs6V3LmbZjqVLG1F19Zz5ePRy/qCs
 MjYyF1U5g0MQmtpy5QHlYxNbuezN62zBMafsu+sn4JU+XGaEyhaiaKJ5s1LIgEOEGtKmHl/dlSo
 CyD25RCJzOCTqCctR4z+3PQI58Tx07fwi3CWvo5/gNpMevVafrNjeGuVY0enlCONF4JP/WDfpb6
 qSZfKKkdlgaoWidAfHr1T146uRlcJD16k4wyqnrlxJAdTIeK800Og1+Bh5SUvGPRH3d6GfKTH3T
 PiqBKdX1/NTmyX3aToG5SIf6JwfVx3NcgKPjAJD5mt1QTXJJR6fT/Is2PGq5k+gtUt623vw==
X-Received: by 2002:a05:693c:2d89:b0:366:42ad:7074 with SMTP id
 5a478bee46e88-369e85012f1mr1359782eec.22.1792801713852; 
 Fri, 23 Oct 2026 17:28:33 -0700 (PDT)
X-Received: by 2002:a05:693c:2d89:b0:366:42ad:7074 with SMTP id
 5a478bee46e88-369e85012f1mr1359746eec.22.1792801713113; 
 Fri, 23 Oct 2026 17:28:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec50bcsm2831237eec.23.2026.10.23.17.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 17:28:32 -0700 (PDT)
Message-ID: <9aca799c-3f3b-4234-a38b-725879818755@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:28:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] tests/docker/dockerfiles: add release.docker
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014005338.34657-2-pierrick.bouvier@oss.qualcomm.com>
 <87ecdgl7v6.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ecdgl7v6.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfX0Ra63Sxj13gM
 raCa6EYLyFhpGolgXN74pOW669cjT86xsXEdHCUNlDgnany8zjNR0pbsjujOPhxAVDf8otMax5L
 yYNUn3PShjTmHrfBdBi4yCZ6gZ/Vn3sYlkh4JWzUW/Zr9BqThmcd2wxGzWt5YQx9BsjaYmy4owU
 AwjPlpgwUwk5Z2t9u1Qz4hq1K9H77IsJrUp+SMJjYz36fQJht+cksSurEuxWHx15Qc4GN6XlrYY
 vk+alHIM7RS4DexoVMBtU++Du3ygCRUMWRY959e9hqre+EjhdWzFgDFnI6Rau4mq9IzpT56nmp+
 ue88sV8yxqFlV0p3aXBSwb3x23RsFg79Htmg6hzsfBGrBdsHAPvUngQ1XROFreYXwqwElm/bl3u
 xwKvvh7att/FPuOIjirgR9B6mxvoilfK3/nlBvtIRgr03h+MeYrS2/6n/f/4V0XdJJTDaoZvpB8
 e4PWUgxZVwDR+GlFJ9g==
X-Proofpoint-GUID: gynVzvBNFdKSLwYapMx2Wj2vdj3m6Vh-
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adbfbb3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fxJcL_dCAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8
 a=3g6hpDkY38Rxvr0pvxwA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: gynVzvBNFdKSLwYapMx2Wj2vdj3m6Vh-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfX7t/FtX1r1gzV
 HTFm/hcr3ZwNz4/GfKRF31XkBxw62rd4A8Z9WO7018NDIFzzpMnbnDTVdOkOlCx9oc5/urW90l2
 V/auWzY1pBgZwh88kUqtITCJ02neuR0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240001
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 9:06 AM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This new dockerfile allows to build a distroless image containing only
>> qemu stripped release binaries, their lib dependencies, and installed
>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>> else. This is achieved thanks to a multi-stage build, where we add qemu
>> binaries, artifacts and libraries in a new scratch image. Image has
>> the minimal size possible.
>>
>> This is based on Ubuntu, which has the advantage to have working
>> containers available up to 12.04. Debian old old stable have broken apt
>> sources for instance. Ubuntu 10.04 binaries segfault due to missing
>> vsyscall emulation on modern kernels, so 12.04 is the lowest possible.
>>
>> This unique dockerfile works for all qemu versions, with 0.12.0 being the
>> oldest we can build today (based on ubuntu 12.04). Previous ones need an
>> older compiler.
>>
>> To build the image, you need to provide a qemu and ubuntu version:
>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>>
>> To run it, as there is no shell, and no defined entrypoint, you need to
>> choose the binary you want explicitely:
>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>
>> Notes: We could optimize a bit further, by creating a base container for
>> each ubuntu version, that is reused between all qemu versions built with
>> it. Given that recent QEMU have around 800MB of binaries + artifacts,
>> and only 100MB of library dependency, I don't think it's worth the extra
>> complexity.
>>
>> Notes: Also, I considered create one image per binary. Problem is
>> that qemu depends on other artifacts (rom, keymap, etc) and it's not
>> easy to identify what is needed for one binary. Thus, I think it's
>> better to stick to one container with all binaries per release.
>>
> 
> Yeah, it's fine this way.
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/docker/dockerfiles/release.docker | 76 +++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>
>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>> new file mode 100644
>> index 00000000000..611ecca9859
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/release.docker
>> @@ -0,0 +1,76 @@
>> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>> +FROM ubuntu:$UBUNTU_VERSION as build
> 
> I believe FROM should be capitalized the same as AS.
>

Dockerfile instructions are not case sensitive, but yes, AS would be
more consistent, I'll change it.

>> +ARG UBUNTU_VERSION
> 
> Is this duplicated?
>

ARG have to be duplicated for each stage of the build.
In this case:
- pre-stage (to be used in first FROM)
- first-stage (to be used inside this stage)

>> +
>> +# add deb-src for apt build-dep
>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>> +# archive.canonical.com is not reachable anymore, and cause a long timeout
>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>> +# LTS < 14.04 are hosted on https://old-releases.ubuntu.com/releases/
>> +RUN if [ $(echo $UBUNTU_VERSION | cut -f 1 -d '.') -lt 14 ]; then \
>> +    sed -e 's/archive/old-releases/g' -i /etc/apt/sources.list; \
>> +fi
> 
> Hm, so I imagine these containers have reached end-of-life? I wonder
> whether we should cap how further back we go based on this. It's one
> thing to workaround a few installation bugs we list/install our
> dependencies, another thing is the distro image poiting to dead URLs.
>

If we want to cap it, then 14.04 is the lowest limit with fixed url.
Note that archive.canonical.com still has to be removed, it's present in
some LTS > 14.04 and create a long timeout for apt update.

>> +
>> +# use apt-get since apt was missing -y option in some ancient distro
> 
> Ok, this is a reasonable issue to encounter and fix in the dockerfile. I
> pointed at this on the cover letter, but we don't gain much in knowing
> exactly which apt version has -y or not.
> 
>> +RUN apt-get update && \
>> +env DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential
>> +RUN apt-get update && \
>> +env DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --arch-only qemu
>> +# additional dependencies that are missing at some point in history
>> +RUN apt-get update && \
>> +env DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build flex bison libpixman-1-dev
> 
> So a discrepancy on which QEMU version and how the distro packaged it at
> the time vs. which dependencies we had. Is this something that would
> have been solved by lcitool? (Hm, did we even use it back then?)
>

It's new dependencies added by QEMU over time, that distro didn't
reflect yet at a past date. (ninja introduction, or recently hexagon
target which requires flex/bison for idef tool).

>> +# python3-venv didn't exist in ancient ubuntu distro
>> +RUN apt-get update && \
>> +if apt-cache show python3-venv; then \
>> +    env DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv; \
>> +fi
> 
> Maybe good to know which version so we know when to drop this block?
> 
> I see some of these check the ubuntu version, some not, I wonder how
> easy it will be to break an older image's build when trying to fix a new
> one. I find it a bit confusing.
>

Good point, I think I had this written *before* trying to go before
14.04, thus the inconsistency.

>> +
>> +# patch cc and c++ to inject warning suppression options
>> +RUN mv /usr/bin/cc /usr/bin/cc.real
>> +RUN echo "#!/usr/bin/env bash" > /usr/bin/cc && \
>> +echo "exec /usr/bin/cc.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/cc && \
>> +chmod +x /usr/bin/cc
>> +RUN mv /usr/bin/c++ /usr/bin/c++.real
>> +RUN echo "#!/usr/bin/env bash" > /usr/bin/c++ && \
>> +echo "exec /usr/bin/c++.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/c++ && \
>> +chmod +x /usr/bin/c++
>> +
> 
> This assumes this dockerfile will not be used to test a current
> build. Probably ok.
>

Why is it a problem? It just disables werror in a systematic way,
without relying on configure --disable-werror that was not always there.

>> +# 2.9.0 => 3.1.0: clone git submodules from expired url, replace them with gitlab.
>> +# 2.9.0 => 2.11.0: issue with libfdt version, solved with dtc submodule, which
>> +#                  was removed later.
>> +# Ubuntu < 14.04: git has no --single-branch, so perform manual fetch after clone.
> 
> See how unstructured this has become? A comment here, the code down
> there, nothing actually checks the version, the sed happens for all
> versions, etc. Dockerfiles are bad at this kind of thing.
>

This one is just a comment, and the code below has a single
implementation that works over all versions.
We could have ifs with multiple code paths, just a question of personal
taste I suppose.

Out of the if on ubuntu version at the beginning, the general approach
was to have a single code path for all versions of QEMU/Ubuntu, without
ifs per version.

>> +ARG QEMU_VERSION
>> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
> 
> In order to build local trees I added at this point:
> 
> RUN --mount=type=bind,from=qemu-src,target=/tmp/qemu-src,rw \
> cd /tmp && \
> if echo "${QEMU_VERSION}" | grep -q "\."; then \
>     git clone https://gitlab.com/qemu-project/qemu.git --depth 1 && cd qemu && \
>     git fetch origin "${QEMU_VERSION}" --depth 1 && \
>     git checkout FETCH_HEAD; \
> else \
>     git clone qemu-src qemu && cd qemu && \
>     git checkout "${QEMU_VERSION}"; \
> fi && \
>

We can extend to support any sha-1 (it's just a matter of doing full vs
shallow clone).

For the local build, I don't like the idea to build from local state, it
has zero guarantee for reproducibility, which goes against what
dockerfiles are IMHO.

Regards,
Pierrick

