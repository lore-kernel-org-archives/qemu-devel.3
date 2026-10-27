Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D37606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LEUkwR99;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ehPE0cyD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXpv-0000rE-FQ; Mon, 26 Oct 2026 23:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXpu-0000r2-4U
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:26:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXps-0008Cp-4J
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:26:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F5T01421286
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BMs9j/qe6LLaf9ZkdP5aYoCGhsz5HK8OL6dpCcK/f1Q=; b=LEUkwR99Ke6bmWG6
 aavt078ovJQapDqMWGCXHWI0nr9Lt37IOw6DEsrOqK7CO4QDOIYDOGnpm/DcSaQc
 F+IjPRvoL2hT69Dl9jFMlsApxOWZXxFqDz4mRNzyQkt6/hz4SB1HCBU/wLR2CpqW
 GZhmtC+5cBO0KDk5bNBLMdCEcq1fwqXBlRzmXoBwrZiIjVuCEI4FFjOyHnpVIMdh
 ISxx7qXhrg30zDH1mlf4hr7jR7plk8dKNrBta5UysMDsUGwDmMnMXD7lUkVrEzfP
 2vBeiT2QzwIT64ejS0dR13GxAyFXy7UBOPBQPGGAqQqWhyvZyIp/2Q1uGK9oq3oS
 y7jy3Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf3hkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:26:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b7e7d5f56so94690016d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071609; x=1793676409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMs9j/qe6LLaf9ZkdP5aYoCGhsz5HK8OL6dpCcK/f1Q=;
 b=ehPE0cyD1qWO9d7BCAMydJPVdHBTLn37Nkesodz5Mar6JOfY7i2Q8Uund985pFurUv
 qDG7Dmf5XfzY9M2zdcRZyr/B1mn4chkg6Y9Mrh5ORnU/E8PTRAQ/d2gHPjKahtbLd63k
 yB99eN42v70HEXslLXXBsp5Cf9nP8ysA/EDjE7Kh7uy0mUOGSt/pxy/ZYxvzXxMuVXk8
 J5dsA0zw3OjPU0so6esXdqp1h1npyd38QibN/BnhQLDz+aMq+w+q/j6kSQvAIy3ircfh
 v5AnJyTwSJxG1sIdvf8o4kOpjKEZSG6Y2VrFPR/ZaX3OwErqQ+YdliHcZGsXTJNExXRp
 VLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071609; x=1793676409;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMs9j/qe6LLaf9ZkdP5aYoCGhsz5HK8OL6dpCcK/f1Q=;
 b=x7FV/g5ErfZR3Bjxstl+TbP7OwpCgm9Hpx8s+6QA4PQ7B9ancqrfv6z9RtEe0d6mc+
 BKgNXVOt+k0k+4b1DVlEvvsTu0cCxlgVcKbU5Q7LFCh0OJL1uO1l7SdVer1xJ66wyqxf
 R47BX5GI7CV8OXgDtYvb2A4GSR2Dw1rRrmDiA2kzTK91ioAwNpRxB+8TcpFK/Oqg8WVq
 Zj9wy8prx0jqPZi/jAJZhOGmTsarsSP8Cc/H2OG//7UlGTiLpxG7B9SS01WYFX1Souzv
 IXR7yXMbNrjDSG8af/0dqdYsu/uGsP9fKXmHjOjRwPvsmm7QsKWB9ovYkAjU7/+S/+pv
 GUwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmymWpqWaDHiMnMUrhwYW20ZqMMIWb9Teoqy/8OejPo2sIPkN+I1WcZ7sUmsyoirMSyYoPf7JDfWu8@nongnu.org
X-Gm-Message-State: AFq9FYIGeZMPwLGVJCgeUawkk2YgBvphbPPtCiN7yROGydAn43xz4Z07
 NR4dk7hiADPQplrHjZQ3X4hLAi6SuaYVyuEdDSS/+ISaDQIc/gU6jSKW4QpwoY3/ss+vzWQbR5I
 dGNnhDZJRwJIfs+Xo5CZ0vuurCNNtafc0bhbCPaTQXpObuAglei8qVLjRIw==
X-Gm-Gg: AYBFou3wOVhEJZ0Aobra7B211N5R/yECDg5sPcuilb0paXZVr6HrDqgBKZxpaDl4cpS
 UVVwGVzcjMGC4qCXudNDh5Zz/TfXL3NjM39oAsiJJYByz9lELuUAZAtfymeDtRvCO5X6yrIH81b
 uR7M49dwCIZkpOVT8WrzTuVJ4i36Q4A4YKyjKC8nDeqCwlaD6Q2h4VDpdDH/VqYC24HcJdH55fc
 Pd+ozydk8y8OJ1M5PECexvLHRGs5fXQLupdSCqwBOMw5YeDBrJ0tIOpfKhi92tVRkF1ujZj8dfc
 BQna5h6ruLU3IIEo/9N/9jg98Aa577PElDEiS2+CpMFSz2cZxapWVNigBF+nfc+b5hblG4l44q5
 Qrie2QQ0tKCNXoyWemOzDtjjM+uq00FtcAg==
X-Received: by 2002:a05:620a:8808:b0:93e:9834:3863 with SMTP id
 af79cd13be357-940ef8bbf1bmr1393441385a.15.1793071609048; 
 Mon, 26 Oct 2026 20:26:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8808:b0:93e:9834:3863 with SMTP id
 af79cd13be357-940ef8bbf1bmr1393439685a.15.1793071608554; 
 Mon, 26 Oct 2026 20:26:48 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4ba7sm20082824f8f.33.2026.10.26.20.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 20:26:47 -0700 (PDT)
Message-ID: <924191ab-7191-4b3d-a1a5-fab33782f4c5@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 04:26:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] releases: build and run any QEMU release easily!
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>
References: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXzRPN/OK9KH+V
 t5xCaj3bWHwb++/ibXS5l4VsnDgsg55WHPgXrjgMYsjqZJwPbArp5U2xXiymu5FUNDejzlrGhQl
 A8lzgRwzM34SY8rMVwL6E26GYz3Ya8Q=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae019f9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=HcjIUGKs2DahF9jiNQQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 03F7O4x3eGQRuFMQ1NUp_4-IxMku6Xjp
X-Proofpoint-ORIG-GUID: 03F7O4x3eGQRuFMQ1NUp_4-IxMku6Xjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX3e2kF9mF0CYl
 R0Sy5GBlwfIj07HPDWR0zLoD/72dWt4MKg72VzPz3HsDy/mzURvHjK1C1BxMPYBlyok8CDrr1ga
 xNus9PCKWFH4VcnzQTO86TFdR7rwl1eYythMKS7gOSQl+UrK71i6VliuaAh6/TQuktb/7qp3QKe
 mSJtq+tf3K/f9COzIGDK73LwnrLcIkYP59zNFw7qW8TqCmKXqP9TI8W8sM5OAKHApcewS0vtoup
 irt78quxjr2qqdytclzrnvzc213Bro1dyJ+OIdywHyhspX/zS0S1/R8cPuKBfDr6x+yxdWnW3dA
 gwDxkhrLkMOdS6TongNI0KBOjVnCbKT2F463PTfurTl1njmRxD2XE5+mCxSpaxCyGBAw/iWKH3f
 tMWMI8nwokDj8pCAzaREKG1tK4dhSpkYx8psKSgVs96caImHCNf7T3KPB/k8TafPq9qtbMgTvmT
 ZW+u26Qhg6wmQPwqEYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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

On 26/10/26 22:07, Pierrick Bouvier wrote:
> This series was inspired by a recent post from Fabiano to provide container
> images for migration tests:
> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
> 
> The idea to be able to build and run any QEMU (past) release with containers was
> in my mind for some time, so I gave it a shot. Finally, it was easier than
> expected to obtain a single dockerfile (with a few hacks) that works over all
> our releases.
> 
> Images have the absolute minimal content possible. It's only qemu binaries,
> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
> tool included. As a result, images have a size from 581MB (v3.1.0) to 1.1GB
> (v11.1.2).
> 
> This series adds:
> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>    Ubuntu version when building a given QEMU version.
> - A script build_release_container.sh which automatically detects which ubuntu
>    version a given release should be buildable on (based on date). It works
>    great, and the heuristic works for all our versions.
> 
> TLDR:
> $ ./scripts/build_release_container.sh v3.1.0
> $ podman run -it --rm qemu/v3.1.0 qemu-system-arm --version
> 
> v4
> --
> 
> - supports build for any version (tag or sha-1)
> - adds an optional parameter to build_release_container.sh to use an alternative
>    URL for QEMU repo
> - simplified Dockerfile by supporting any version >= 3.1.0.
> - removed patch 3 generating wrappers to published docker images
> 
> v3
> --
> 
> - extend dockerfile to support ubuntu 12.04, and lower older revision we can
>    build from v1.6.1 to v0.12.0.

I haven't read the previous version discussions but so far this is
useful enough to me, so series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

For my bisections I have a crazy script that adapt the ./configure
options between commits (when they are added / removed / renamed
like in [*]); it only covers the options I use. I'm adding to my
TODO a remember to polish and post.

[*] 
https://lore.kernel.org/qemu-devel/CAAdtpL7p+BG=O8b4+fjAhGO4y-ongpcYX0N5gcLDSYq8q9z2Rg@mail.gmail.com/

> 
> v2
> --
> 
> - fix generate_release_links.sh: was missing userns option for podman
> - dockerfile: cleanup "|| true" and replaced with proper ifs
> 
> Pierrick Bouvier (2):
>    tests/docker/dockerfiles: add release.docker
>    scripts: add build_release_container.sh
> 
>   scripts/build_release_container.sh      | 63 +++++++++++++++++++++++++
>   tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++
>   2 files changed, 111 insertions(+)
>   create mode 100755 scripts/build_release_container.sh
>   create mode 100644 tests/docker/dockerfiles/release.docker
> 


