Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA0606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p4b5qz7M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LCwF5wMk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTg2-0000Ga-FI; Thu, 29 Oct 2026 13:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTfy-0000Ba-Ef
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:12:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTfw-0008Dg-Bh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:12:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD9HZ3873152
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qvyaaGQNHiDM6gm2Ql1Ha0lFy9Sa0AbxZ/3j/0i8HYo=; b=p4b5qz7MgbSn4Mrd
 r4bWctl/4ZD1iQ9B0/EAtFQP0zFnipNi4lNK/H/yvHyfi4+C5WwkiUNgndXaBBA1
 MmbSzp/F3I3wwaPZ3x/5OwmLHXOCWifiFEwS2C/Hk94hd3bo2BiP/nGmLGU0ul6z
 0wCNPk1TlvXhSTDuNcJQ8PSMLlBpujENqKH6SuoCvN2+xLmkIi0umoo6VDKJm7sJ
 he8y15T+LFQF6py5/VK16EJM1ALCdJt8+eZ1qEr1myr0zDwNxWYihVyfT97VrraR
 j2FwTNjvjd6MKEcYxXXusF87mL18COmofm0bOoIE2o38DPKCPXWfTJd2JYXSMcgn
 BuDMKA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm762129x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:12:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3692c5b061bso6422678eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793293946; x=1793898746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qvyaaGQNHiDM6gm2Ql1Ha0lFy9Sa0AbxZ/3j/0i8HYo=;
 b=LCwF5wMkvKLhAVXXRc4qfa5/mTTqztJ2HuKrKB0rPeEtg40fg/0YCBA/3xY9ZxEh4h
 WvDPPmNX7gMRDiYMJ9lLBGbG9ZFDyZu3H2cJw0Dd48EFi9C/zshVEmN9DzGgM6piACoi
 Xb+UkjZWfsxjpdGssVLfucQO6MFLkIPymo9hVl38s0ra+5BY10jaUYpojX6HVRAaDh1I
 r8sVQiA13H4EvZss2shShAhDo4Sw7sefDCYtaInluZXiuZLYEwn2RfGLzGBMav8o5tF+
 aJ4QqEBOY5AWDOF1X532GxST03kCq5SepUTbkX50/0Dig1pYyezbxp0nT7mh75UY/7G6
 lR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293946; x=1793898746;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qvyaaGQNHiDM6gm2Ql1Ha0lFy9Sa0AbxZ/3j/0i8HYo=;
 b=B1fiwVSQPLP73qk8fpk9EDYI+gCNFpnOJEEcfj4x+fkthbDd54Boxk8JvwoGTAY3ho
 sDLMwev7NgcMntUk/cFu+uX9ZZD0/wnOXbqQinWfZJ8xQ58mM82E3xRFN4jMOYV2dCYf
 inEnw9yhnGoIDxB7cHzUNkEbNFurF11TYPx5G+aT6pm2be8Tbs78KRAqtV53qV/22Dp5
 T6KDnP5hbQlUevL1OdHhf88OOKEljTcvdgcIRp7zRxocEY9JvimSXG5h8WnOMbiqcbhZ
 OsLjPJ2tTK3Ds2bXIXlbBZcYnSA6zv/k8tiAe68V90EBS6qS9hZGTGRAQ7r1wRWcFlHQ
 Z74w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYMcjspDXE2Omo2vyZSoGQASwxA/gBrHmNn678QnqDjwQgcFeTR0r/2VFkt6rh8gCMyAfXq5PSgmY/@nongnu.org
X-Gm-Message-State: AFq9FYJ3v5N8zvlzzJLz7P2vPqTiXbCtfItsmzNOwa436U7RZo2FY2/J
 6KdZcQaIXTedg2SE+bUuRncgWOypnnx+5ly/qZbLJCE0zG82pIoJuOYtcW/OyDx5raqZ6NzYVcD
 SE02N/LTulsYda3fdj9ZNno0gLRgXcwEyBJQQAO60RzwLPskdRwxiSdzLWA==
X-Gm-Gg: AYBFou2GOHhA74s6aDpenPxoVMTPEFWbu60ZkRxrDNQDgo1fYn/xHXBHh/sMgm9rw1k
 RNgikTwX+PSobXtn/PPDtSy/DksB4TzcPlTM/enXve+Pfnt3ISwuJWOHBf80j66vV1ZKoXEZT55
 CMIYwG00wOlXWUp3rlB1pKq/k78FlDPTcxt2FGmjU3+bNVqNiIyP+nxxmp1rgouFPVxuMAupx6e
 bV0/PBl+l4CZaX3MsMk7+wAmhkyj4lwwZkkpLwyljOKsAVeAZh0ns6vXrb7b/m9TOljcSECTvBW
 ypATD15g/wHrctSq7pZv27jKdwdmc2hxblKy6niyGw7KeTX6mT3i/JFoK36Y2XHgzfoA6uTvvRo
 o4FPNvuu92a3c+plMCPrhv4e8t84ZlE7zVxoYZSTFvOlrPNw73U0rGnD3RRVEHrziyDg+5zUhkT
 2cK6bJwpr/5yJtc+jynmNOtgU0PpQQIayWEUwGks3Id4U=
X-Received: by 2002:a05:7300:c39f:b0:366:6644:2839 with SMTP id
 5a478bee46e88-36a42203e90mr76621eec.3.1793293945732; 
 Thu, 29 Oct 2026 10:12:25 -0700 (PDT)
X-Received: by 2002:a05:7300:c39f:b0:366:6644:2839 with SMTP id
 5a478bee46e88-36a42203e90mr76588eec.3.1793293945140; 
 Thu, 29 Oct 2026 10:12:25 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4108c52csm445056eec.16.2026.10.29.10.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:12:24 -0700 (PDT)
Message-ID: <c8bc6def-3c86-4fac-a84b-6664d40d5006@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:12:23 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] scripts/checkpatch: validate fixes against
 origin/master
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029161310.2065290-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TwY2UF4VzuyXWSC_mJ1xIdKskRVBP1U8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX/QgLd9MAMUHi
 ftnYY60TauNWVEdHDQ3Hukiqf1q0/FENBFU5eGEQjcPJxXiXW7p8kzjUHVWyEjh3wOEmdc3yIi9
 lDcY12rM8M7ZlqGdXeAbA/5bt3uvbM5bKQB3vbmWBqd8J5ce/kjQNmUHxsKd/PR9wxP2faPa89A
 hte1M/Ty1u6VrUkoom5jEZEaLDG5Ugb9MWNr15+/JnVTnLW0hfR2MdPOGwPvFiPFsmz7c2Ko/Ei
 M2nOKKASOItXkoF+nZWqEPLK4RoW4toiC4W23YtEuJxeG6QBdpG7aB3MxiVOSFOWFdbmiBHwjE5
 DjIwhZRKI5JyP7uPZ+2YMG4r4WkTNyqZ/a+bJZMg4dKvacectemORmwAkv4wXxcvvH68k4cY0Lc
 JM1UKCSDChPphqCo7kFYpxcz7z7A6T8qTtjPXKQ/BY16zMelwtz71iLaUkkaGcTwQFX7SZGNMKr
 reyi7qh8XEdun3xQVfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX98LHwJcq0T6D
 3lOZWigXwNDqJXP9/3BuWmOXSypjuLsMqRABKlqWZ+gJCoK+5EOmxMn4+u1Ksrcw1nHF+JaaCDJ
 PJAekXYwaQwAOr1zme3vHdKVNWbiFfg=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae37e7a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=t6Jf17RKvxzU3DPCqfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TwY2UF4VzuyXWSC_mJ1xIdKskRVBP1U8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 8:13 AM, Alex Bennée wrote:
> The current check for a referenced fix commit relies on the developer
> keeping their master branch up to date which is not always grunted. If
> you create your branches directly from origin/master this will keep
> failing.
> 
> Given that origin/master should always be up to date (module the
> developer eschewing convention) lets use that in the test instead.
> 
> checkpatch complains about the line lengths but this seems to be
> standard for the perl script so I didn't try and fix it.
>

Or... you can use something else as origin, with origin/master not being
updated, and master as a tracking branch to upstream/master, and in this
case, this patch doesn't work.

Using master instead of origin/master has the advantage to not hardcode
what your remotes should be.

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 82f62f60212..60e8b6bf7bc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1913,9 +1913,9 @@ sub process {
>  				}
>  				if (which("git") ne "" && -e "$gitroot") {
>  					my $hash = defined($cid) ? $cid : $orig_commit;
> -					`git merge-base --is-ancestor $hash master 2>/dev/null`;
> +					`git merge-base --is-ancestor $hash origin/master 2>/dev/null`;
>  					if ($? != 0) {
> -						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
> +						WARN("Fixes: commit $hash is not an ancestor of origin/master\n" . $herecurr);
>  					}
>  				}
>  			}


