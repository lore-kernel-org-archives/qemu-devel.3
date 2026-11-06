Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12939606A32F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OBodOkdS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LNNyCJBU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNHw-0002dX-4i; Fri, 06 Nov 2026 11:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNHr-0002dF-FU
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:59:36 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNHp-0000ab-Fx
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:59:35 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6ExwIO1039347
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 16:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSt5FyktCdFBdyxbMh1Wec0jmo7nloyP8x5cCCeYyns=; b=OBodOkdSqeCdnB2n
 qrZ/HJp18BbzJiRBdat70KXYCn45rXKBzDmfnrvJq3q+fCDgNuMDjJsu53r8xNd3
 jAD8PvupSZQ5UY3ULV23GWlFOfstiFTvxenziBB/iHbqRBGkzZfiBmTdU6P7y54z
 DvsFVwA28oAEq0xZC/myQ1myebJ0Tkn0WQ/r0U7anGV7fezPyk9J80z/yXuDUlMN
 7Bz8qvi3Dx7J040HpTmnWqzP2PEzHxhL7KSjARzcCgPIXtlbf+CpU7dOIwmwZGxO
 xGVdN6egzd59QQhFcuVSwQaol3YAjL7LfUJ8xfkfD6+NtkPAkn2alkpzQ5XTsiS0
 pQaXrA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9usua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 16:59:30 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so1646059c88.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793984370; x=1794589170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iSt5FyktCdFBdyxbMh1Wec0jmo7nloyP8x5cCCeYyns=;
 b=LNNyCJBU1A1/+5o2LJeXONqeVFJ+sVydb+KmCYnLxycBqkJcRzBsXqY0xzVRQ3mQfp
 +7oJ+Qa1W9Kgq+9Spfmu6k43yzNBUiD5ChA+edi4Z1HKN3pcDl48DDGJ8e30OT4DqCWe
 Hbc2LfkzANDBoCZAEdtMVp/RVU99d82wlsBhvzHtSOOtLHcbP2k0NEVcsokIYii+5WmI
 n+iFkZZJ7yxQz59Xn0i+03qroKJSblHo5t53NhFtxNWyG4qG2OzGXJb+RI94UvwpxhOm
 x2O+CpU7I88fDVE3Ucnhr9Jwclxj9WtfSR3BvFlDym8H960g7OiN1YZwm6irkdA5m2MA
 oy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793984370; x=1794589170;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iSt5FyktCdFBdyxbMh1Wec0jmo7nloyP8x5cCCeYyns=;
 b=1VPhr9qTvyah9g4IyhNVX5ybhEmiU0xl8lwKd5AOW5BAZCiXPXAjxM/qIgmogA6EXs
 8HLzwRZkLmuCpkA6+Bvs+MNW2qBJnlw/YyEK5J7htuTr+HUevQCTrAQP3bBiCiQH6TMM
 lhT9a8xgS1EtkOEaSYA/pa3MyXE21c0B5W7Cdz8CPPPCaaTzevWZ6AfTNh/FSNfzqOd1
 haUSSaHrfKX7ygAD6Sj2xq+YPXHqcxB3LDkMx2t+jU4BB79z4yasKS6vQtYDksfUbQ/h
 BaQmWACaPZtmkGMcS5uaJl+LZyLf40+Fl1aivR+dC5lWi6YgpgRVwYJ0R+20cEg3qJhh
 Jq3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfM3a0Nxc7nJI8O1ujKk2I2KDV4+ZB4MbLR1Hir74mOksFe38Yg9E3ciARXhi2J75bwOu/sNqZi+Gt@nongnu.org
X-Gm-Message-State: APuU4Z9CkKE/v7OnVqVWjHdfrnE7u9TBLEem85XIeYLx8lc0uOJTCmxF
 a/P9ZmGiVSGx1oqUKwR9Z2NdYdaLrVvjRnqJrsaIQvwzPPaWq3mTP6V8xmIwYJDt2dJyto6XXBR
 zc+KLTSmq4AO5bq9j8295wNnULwVln8Umw6q+fip5/bqHRtna+bp+fBJg5g==
X-Gm-Gg: AYBFou1YWlSSVilUCKf8SrEoLXDnEXFmLxxRay2yMkYpp1vRVKMbhmwHX5j0TLAe+0S
 ZEAcl6wm/9y2xonAeX30oUXra7xJxiDUDK6ZdLYmDPO/0MCdbXFH+MaslRm+GFbLb2xDb8LzOYF
 ybHWbyPOOCVgtgL16lFLGNqmBpGu1gi3HLoTkX/FVLlmuW61ncJRZUbmvk5ZAmIZqxjqvYJJ5jT
 5Al8+zMuZiugo1hE+P7rmlPF55+M+xyJl7gmvBVThVOJbFwmUhs+DGFUkW8Oji9OifliS/fsyyE
 utMzlHDRuJRPBWWafJttmx3HOf8YqQFQROeRIK8dXbJAOnitEAOdj0hx/oCqiY4kgoR89rKcq+/
 OBZ2JYeKLsSXHUR22AW15iErkYlqpB/v10+K45YFSkfCYnWJGwmdi3g82qUnTiMK+JKuUrh7bTa
 qKRb3bOaqv+fUsJzb0CqACy0iJkZCXgK3Qloh9V5cJbQ==
X-Received: by 2002:a05:7022:5f07:b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1b25d31e658mr3267681c88.10.1793984369684; 
 Fri, 06 Nov 2026 08:59:29 -0800 (PST)
X-Received: by 2002:a05:7022:5f07:b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1b25d31e658mr3267637c88.10.1793984368961; 
 Fri, 06 Nov 2026 08:59:28 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4b1449sm6491472c88.12.2026.11.06.08.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:59:28 -0800 (PST)
Message-ID: <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 08:59:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh
 directly in meson.build"
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
 <20261106155858.3779237-2-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106155858.3779237-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NyBTYWx0ZWRfX3h2s1upduGbt
 68FhXAUG/YnvN1X8IN1gTnR2sYqI0umCyj/BwVm+Brq8xCmZoQRL7G55j80hu75fvHKqZ6omRCn
 nb60rq0veALRPRKmivZbcAaQkurhU+g=
X-Proofpoint-GUID: B8ZQt9vYu9RAwSdPkx0_FTISX-5mCxRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NyBTYWx0ZWRfXx9nv00wgzf10
 Xri4JgYaDQAv/NAP3af2TCxym+WCaYiyMSRy4HOF4DQb7p/xoPGFaaRHDnthgOCtuW31ZZFv9rh
 VqXiU3ItDgkE+lUnDXim68cPblbwW4f7HijbYFiumtSVHq1vAoQ4uVdAbmaTJUXguoZsdT49QZv
 Tk+2LkzaZnUPsgQddIwvhI80l00tHDfaxHvrcaE+O7wXoLsdpk/2s7VuYywJgiD86uKIvMIh5oy
 dAEHPepHFR2yjXmv3FCi9hVP2CujuNGaqvn0nopfRr2p3HxZrqha5sSeR0rxjtyWboDebzPf8s9
 V3uDWYBKL5kpYON1FG9O6RJ+hgPlEH103PF6JGZLpEaZ8hgY6del8nNveVGo7SNazg7a8hcFzjx
 F/tK6HsuPcKv93baxU2hOlj3PUd/x/MY4vxT9HVZSWmM/7wKIzOYV3xm5z6VsyGGUelYQiqNaIo
 23+zRtuRoJcmbR9lufA==
X-Proofpoint-ORIG-GUID: B8ZQt9vYu9RAwSdPkx0_FTISX-5mCxRg
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aee0772 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=MKyoWAqrCm3wuAtb96wA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060067
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

On 11/6/2026 7:58 AM, Peter Maydell wrote:
> This reverts commit ab78ac76f44a1241e76fd32d248df62d83f1ea58.
> 
> The change to create the version header in meson.build loses
> the dependency needed for the header file to be built when
> it doesn't exist. This means that:
> 
>  * if you delete the build/qemu-version.h file, an incremental
>    rebuild fails, rather than recreating it

That's not what I observe. From current master, file is correctly
recreated. Do you still observe a problem with a clean build folder?

>  * if you do an incremental rebuild from a build tree that
>    pre-dates ab78ac76f44a, it doesn't have qemu-version.h,
>    and the rebuild fails
>

The problem seems to be crossing this commit, which we can't do anything
about since it's there.

> Revert the commit so we can think about how we want to address this.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  meson.build               | 29 +++++++++--------------------
>  include/qemu/version.h    |  8 --------
>  scripts/qemu-version.h.in |  1 -
>  scripts/qemu-version.sh   | 25 +++++++++++++++++++++++++
>  4 files changed, 34 insertions(+), 29 deletions(-)
>  delete mode 100644 scripts/qemu-version.h.in
>  create mode 100755 scripts/qemu-version.sh
> 
> diff --git a/meson.build b/meson.build
> index d7bcb581c18..93da3e6f2bd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -78,7 +78,6 @@ have_user = have_linux_user or have_bsd_user
>  ############
>  
>  sh = find_program('sh')
> -git = find_program('git', required: false)
>  python = import('python').find_installation()
>  
>  cc = meson.get_compiler('c')
> @@ -3561,25 +3560,15 @@ tracetool_depends = files(
>    'scripts/tracetool/__init__.py',
>  )
>  
> -qemu_pkgversion = get_option('pkgversion')
> -git_describe_version = [git, 'describe', '--match', 'v*', '--dirty']
> -if qemu_pkgversion == '' and git.found() and fs.exists('.git') and \
> -    run_command(git_describe_version, check: false).returncode() == 0
> -  # Refresh the version at build time, so that "make" after a commit updates it.
> -  qemu_version = vcs_tag(input: 'scripts/qemu-version.h.in',
> -                         output: 'qemu-version.h',
> -                         command: git_describe_version,
> -                         fallback: '')
> -else
> -  # Unlike vcs_tag(), which always defines QEMU_PKGVERSION, leave it out if
> -  # empty.  include/qemu/version.h then omits the parentheses from
> -  # QEMU_FULL_VERSION.
> -  qemu_version_data = configuration_data()
> -  if qemu_pkgversion != ''
> -    qemu_version_data.set_quoted('QEMU_PKGVERSION', qemu_pkgversion)
> -  endif
> -  qemu_version = configure_file(output: 'qemu-version.h', configuration: qemu_version_data)
> -endif
> +qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
> +                    meson.current_source_dir(),
> +                    get_option('pkgversion'), meson.project_version()]
> +qemu_version = custom_target('qemu-version.h',
> +                             output: 'qemu-version.h',
> +                             command: qemu_version_cmd,
> +                             capture: true,
> +                             build_by_default: true,
> +                             build_always_stale: true)
>  genh += qemu_version
>  
>  hxdep = []
> diff --git a/include/qemu/version.h b/include/qemu/version.h
> index dd0f937f30c..38405495c0e 100644
> --- a/include/qemu/version.h
> +++ b/include/qemu/version.h
> @@ -7,14 +7,6 @@
>  #ifndef QEMU_VERSION_H
>  #define QEMU_VERSION_H
>  
> -/* qemu-version.h defines QEMU_PKGVERSION only if it is not empty.  */
>  #include "qemu-version.h"
>  
> -#ifdef QEMU_PKGVERSION
> -#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"
> -#else
> -#define QEMU_PKGVERSION ""
> -#define QEMU_FULL_VERSION QEMU_VERSION
> -#endif
> -
>  #endif
> diff --git a/scripts/qemu-version.h.in b/scripts/qemu-version.h.in
> deleted file mode 100644
> index b62d4c22652..00000000000
> --- a/scripts/qemu-version.h.in
> +++ /dev/null
> @@ -1 +0,0 @@
> -#define QEMU_PKGVERSION "@VCS_TAG@"
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> new file mode 100755
> index 00000000000..3f6e7e6d41d
> --- /dev/null
> +++ b/scripts/qemu-version.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +set -eu
> +
> +dir="$1"
> +pkgversion="$2"
> +version="$3"
> +
> +if [ -z "$pkgversion" ]; then
> +    cd "$dir"
> +    if [ -e .git ]; then
> +        pkgversion=$(git describe --match 'v*' --dirty) || :
> +    fi
> +fi
> +
> +if [ -n "$pkgversion" ]; then
> +    fullversion="$version ($pkgversion)"
> +else
> +    fullversion="$version"
> +fi
> +
> +cat <<EOF
> +#define QEMU_PKGVERSION "$pkgversion"
> +#define QEMU_FULL_VERSION "$fullversion"
> +EOF


