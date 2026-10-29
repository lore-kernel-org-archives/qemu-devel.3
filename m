Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EshizDJi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aQUSS56A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDj5-00032r-0t; Wed, 28 Oct 2026 20:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDj0-000329-DW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:10:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDiy-0000YV-Jk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:10:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMA4Om2062455
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s1LDyS12vFqTNTV6E41SlKy2wMPF68++18xyfapiCzo=; b=EshizDJiJ2T8aZZL
 c6Ngk6x1WfTAd/ZBw5CG+Rt4MvMtz0cZ30k4fNGxWLuA5qRXUFJDuOZSshc2MN0Z
 /RsxRLNoR2c8nn5hpG0JUQ2k6Iryqvwc90Tq3OTe6e+5L6g5JlghdeJgFcQaCHqK
 qUX4awACuypGqWmBobe8CplFwmQayMkQl0IoF9eqsQNRrCUj89Itp6aeTD6gX1Fw
 Aov5Rg1KEOcmys2/WG4o1xCf+XNEmO6qtVEfWiZ/QxgmHY21qyVcSjUqud3ArdXu
 N+Vpr8nVjC7T5CWGKvEceVf9cPB9QTiPdicnDBgToUyurF8IugbHH3IFUNdvV7AH
 Zn+AYw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp9b4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:10:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3698bd5392cso195183eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793232629; x=1793837429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s1LDyS12vFqTNTV6E41SlKy2wMPF68++18xyfapiCzo=;
 b=aQUSS56AeiaTwzNc8gODt0qe8kNL8g+nUAejDfSeS3UQoKeykTrk2PJG9IRIYJfFed
 zbqDsZ/ojSAMrauZmhmFz8BzIlXPLNreodMo15blpHomISWwZohq9ARaTER5rsr2lk2W
 H4pAoLCLgM3fbgAcS/VIhdQOZPT50SBAdyB3oxKrk0Pqhj8wCFUqn3is+Up2tmn7/B/M
 vcnmWTtAv2Kbwfqy2pUhnJwjQR2/t+euaswI04S1vJNDtxMKqs/MwOW4WAkhPn11xexV
 l8pMEBB6HiUkcEU7yx8/w0m2Xqys54NHZWgQIEanwqIZ8DKNzy2wRr9mUQ9/GgYcpDtA
 fvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793232629; x=1793837429;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s1LDyS12vFqTNTV6E41SlKy2wMPF68++18xyfapiCzo=;
 b=zwgiAgwfM2AyLDoNzEkR/HuUxhPCGeiotYe7aGWI1IL52biIvL81lkkd3ulT2057ht
 MkuCviZpD2EBg6/i/F+87SqVhYXlPLiH9N+mcr7ww/bpLaak5cKDsHiuUT064A30ZmWX
 3ePzYLYbWMxuQ76LbmkeKRGoLvVtg+nQ8TfGrWD2/pgyWy+elXh1I3tvRtcg6bBU/xjg
 18k/VuZr81mPxwg/8WOXPdI4/UNxBSm+7OpQ1n75cAjV6ThJe7bv11EZ1xhWfMLGfAbH
 YMwMkh4ziXgaab7IyPWnLSs9RSe12GBrPPpyfWQp0WBRy/xw5HkQCLF5UnMTvZ2HW+Zp
 R0qg==
X-Gm-Message-State: AFq9FYK397oR2A9Dt6QjtqFfVOgVrBRSGOpIElbj9sHS9XaQ3ribtU5r
 J7hR3hccQCdFKduP2KcOduhyUcSr6+3z2evahmYczAsAinlUvGbEmOB5EOkAHuV258IEpOJge9z
 KMjqA/B4xMSNqnHAGxMtluxogFc5YWtJScQ3X07PDO+qq6gylkfoHZRIe4Xl1Omwdkw==
X-Gm-Gg: AYBFou1VNDm2YhoxqDffNsv4dgpd0hicSlA4PppsUkUhydKE855b5rDfdzgyw/DmsCs
 8o1utIAJ000qOEkXaVv0RotFc5kphwiF8O5rojUGNeosZ2Xu0CE/SPXmItMVRmEPMpTvtL91hLa
 oEURCkfBzpraefGRdEAydgu3jYfLOynsZf7oxIpspuIituKzt0+nd6qrA2hcgLIvTdSzahWNPdc
 BK64XunKUvpt7TzB5fgUky0PlpEu7BusWmXY9UefT5c8jKk41b7VlsCbZlTPRQs9qLOfYEmSEOT
 5O3HbjCVE7mc44bCrztLQpqjPgnJKQmyCKIDwAiIB1NWE6HlQHv+y4Iuq8gBIP+/ijG4SWDnu3P
 c5FpDRqu/BGEgaTCvOA+MQzDHkstB8XMTe+aKue7QmlAHdrFcoVtiWxoyI1aLyKYoA7CXkbV3iN
 8eq6lwKal8OK6zitAVu2N8PcbYniP2oV+GSe/oyIqLtWE=
X-Received: by 2002:a05:693c:41ce:20b0:359:27e6:b684 with SMTP id
 5a478bee46e88-36a2fd486a2mr1473330eec.3.1793232629303; 
 Wed, 28 Oct 2026 17:10:29 -0700 (PDT)
X-Received: by 2002:a05:693c:41ce:20b0:359:27e6:b684 with SMTP id
 5a478bee46e88-36a2fd486a2mr1473300eec.3.1793232628726; 
 Wed, 28 Oct 2026 17:10:28 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2399b05dsm10906405eec.25.2026.10.28.17.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 17:10:28 -0700 (PDT)
Message-ID: <46eea678-4a89-4d48-bf31-a894814a4959@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:10:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] releases: build and run any QEMU release easily!
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 mjt@tls.msk.ru, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>
References: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae28ef6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HcjIUGKs2DahF9jiNQQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Oiv-pPkVr9PYe0b6_T4gD1oHPJGsDnvC
X-Proofpoint-GUID: Oiv-pPkVr9PYe0b6_T4gD1oHPJGsDnvC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfXzDJM6sjRbZqH
 4MlML/cA1LqUIwiBuXFfjKNOu0hxl8g44nHm0vP7uoJ3ECtbL0rowhqYoKYDzp9qQ/tdo9AuSwh
 J0+xL1uVMy/3hU7fGYkcuPHFVpusMBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX/owwoJ2izhdX
 HTkzbX46tJpmSjccCoUv0smLtyylc66Hv8xpf36cNqIQ+2zgd2XghDa/puPNLnHmFsLvbf1iWb9
 aLwo+f5eqRlUPtRaxX/rluQN5pNtHSdtQ7nzY7We0C0JAockTWFPEQbS6Yhy17UX5y+5Twr2DZk
 I3f71iSZbq9szkd8VCHHBlxbhtGDGyoocebntckw20FT60jbGdYzlR5ydY/Og1zaA94yA+luRVv
 6kLPBmtQc/43seGWtC4bb9gMdzy393IR8GTknN2WwjPCD4lDrQ9qwmaXpyTxNHfcSwwttpNN1o+
 FvBR21qvUVwJUAY4uxjeFvcYOF3IcnGmVZzsrd6QXV2yM254E3EtkMup21sPErrCeaI50MfEoPn
 cL3XbJO1GgeCrcZteLjz3Tw98x95GokXl1a/NB+DHaR6uwVLj1Y+ABPpq0mz7+AKMOLBAw1G6a1
 GxNL9KNyRhKIiEi34sQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290000
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/26/2026 1:07 PM, Pierrick Bouvier wrote:
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
>   Ubuntu version when building a given QEMU version.
> - A script build_release_container.sh which automatically detects which ubuntu
>   version a given release should be buildable on (based on date). It works
>   great, and the heuristic works for all our versions.
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
>   URL for QEMU repo
> - simplified Dockerfile by supporting any version >= 3.1.0.
> - removed patch 3 generating wrappers to published docker images
> 
> v3
> --
> 
> - extend dockerfile to support ubuntu 12.04, and lower older revision we can
>   build from v1.6.1 to v0.12.0.
> 
> v2
> --
> 
> - fix generate_release_links.sh: was missing userns option for podman
> - dockerfile: cleanup "|| true" and replaced with proper ifs
> 
> Pierrick Bouvier (2):
>   tests/docker/dockerfiles: add release.docker
>   scripts: add build_release_container.sh
> 
>  scripts/build_release_container.sh      | 63 +++++++++++++++++++++++++
>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100755 scripts/build_release_container.sh
>  create mode 100644 tests/docker/dockerfiles/release.docker
> 

Sent v5, fixing build with docker:
https://lore.kernel.org/qemu-devel/20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

