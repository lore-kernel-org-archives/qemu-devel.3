Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j5tLFbyj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i7e9lkXD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDaI-00005b-VY; Wed, 28 Oct 2026 20:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDaF-00005P-PK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:01:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDaB-0007tJ-Fu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:01:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMA3s12979514
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SOpNmQ32lxBuH1Q1Vn3r4ki2NYgeQeSZz/bWbhgHVjY=; b=j5tLFbyjR96txiDl
 Dizil3+cRwhDOfH44pBbYR5lpxHnRUry8y+eWumjD+8u5nMZIY2vVngqZdzTggqJ
 HJe18JFnqnsANLlAgMyxOLonRc0teflYdmzAOZ09BLGgOnaIKe9U8z8XHxHUYN76
 VEbUdT/QXSj7cDtE4lRe5lBD8+LRNLldJbQBkHw8/3juBWQPCm3lNOsVkc868z0x
 CmEftRZbQV1yE8GxDM7/+KJXzsvMzwS+oDFBlIXKjOro9cP82QHUwA/Qbwrlq3M4
 ibf+8ZzV6IXWjYt0axjzRwDjSHX+hwTaXUBdS0ceichADRLoJmaUxVS6lIlHy/yy
 fZa8Ng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc11qx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:01:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so3030846eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793232080; x=1793836880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SOpNmQ32lxBuH1Q1Vn3r4ki2NYgeQeSZz/bWbhgHVjY=;
 b=i7e9lkXDiSxcalbREdEuy+0Yfv9dvddzW+75G62Frh7sfrx0RiEDmP6EBdoqmV53vU
 qJStlkm3KblbpstJ+hD+6ZUpPevEi439YzgmS8sYxfdl4BlLu6ZhG70yo0lqhdNxaxnL
 6z34/IUOdBGrldU+DoHhX8hSg/IEBhNDKiGB1UbiHz5WKad+CuFg5Pa/spjCEsnfMF4c
 +JGxrtkYnpw9yqzAtPIyC/igs3c7VD/xyEUoxWYMog+lTzWixh1YTikiX5wreoYza3SM
 0agqwciP87Sbj5qNtAr/XSpIjAUobp1WxhLHXWUKqaaubfiNKWHb4LPyj9AnSwIXojOY
 O/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793232080; x=1793836880;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SOpNmQ32lxBuH1Q1Vn3r4ki2NYgeQeSZz/bWbhgHVjY=;
 b=C7WXbgcXcWjzCcDBIT5MFH+XzBh2AVugPYd+ihgOOZhO/wMf4gW1LdRz0cyBu5IeBs
 eAaXyDAmBAPWYHR9AjvKDCaE6TXYgjXJEC3o85xocHaRk7sYvvKwj0tNXW7wFQT3dtn1
 0KquXj6R+u9TSujpcTZcEtQPGQ7r3BDiY9Xnd9cN5mx2d4JgdOG7O5XeZiymEhSmrHRN
 d66RB1ZTnxvVfnsQvWObH+MfGqjO4y7Kfuc5cIkw+zYkLr7jAu2UC5K0pvxDJeqrDQMQ
 jHww3c2BXZYwW79pWOIz1Gqpwl7hEyrUiE+Bw0ze6Jockb8CkgXuigyRFrDWyLQFhbCt
 jijw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuK7NO8D50JUbulFoIUyEYNhVJuXZD6+IkUycMm1R7QsbUGHnSJtOhoq9zzo7s1mO8j5DYstfavZik@nongnu.org
X-Gm-Message-State: AFq9FYKnl6qrMoQrP/920Bj7dIHdKIvnwa3ysiinPd+oi1x4n8wgDEgr
 vvZFkDw654KS5ud6SYTvKM89QhUSQFsyHsA408nVBBY05HMCQjpa0S9Gdaoch3zgjgWSMNHhogF
 0rSOaMMF2E30C01m1ALnd+1UzvPxyIhE9qrUgUy8egqmOFPePn9IbRH5xpg==
X-Gm-Gg: AYBFou1t43HEk53H8HulCsdHNxOeCSGE/4OeMaZQFUKgDl3azV+PUC6lxoeB2+9w4Ay
 z6GCER6R0Q0Ok5sKMRicXhl+T3G87H33HvYB21cCU/l1jvvy9ruhaN5I97lwv/YOvtxfLkfBkl0
 Ie3y1Ow5Vmw46FoJQXQX1wgDDHOsgqUULhpmnALfneOtR+gJpxDJHPlpariKd/KkvbjLKecVWcM
 JoPS2gZ33GNpXlerhR+wGG96b8ivUN9h8NrPjjs1HUz9jPUEYkJC6LktXtUoYbTm4QSa/Ac3NS7
 3JNL5CYi8bzMu3pXPFBQ3ZMp8gYRAA5DJp3lsFyzZbNFVzOs0gOBn+o/T97b6k1kRWQQb/69PAV
 VXHhk21uVKoe43CR7iPCn22fjK4a/WJfqA4CNPc1nrX6n6cBUXjOjqFkb8q6Dq9kJ9FAfFPitW/
 DFJioia5FyGWVpap5RshX2deMF5ltZEc/HaHj7Yo8XH5w=
X-Received: by 2002:a05:7022:b0c4:b0:151:f0c5:7a09 with SMTP id
 a92af1059eb24-1a6d059df3amr4825897c88.43.1793232079829; 
 Wed, 28 Oct 2026 17:01:19 -0700 (PDT)
X-Received: by 2002:a05:7022:b0c4:b0:151:f0c5:7a09 with SMTP id
 a92af1059eb24-1a6d059df3amr4825842c88.43.1793232079162; 
 Wed, 28 Oct 2026 17:01:19 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm16546295c88.14.2026.10.28.17.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 17:01:17 -0700 (PDT)
Message-ID: <2dceac98-6423-448d-9501-d9214da17760@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:01:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] scripts: add build_release_container.sh
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 mjt@tls.msk.ru, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
 <20261026210801.179790-3-pierrick.bouvier@oss.qualcomm.com>
 <874ie5jur8.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <874ie5jur8.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae28cd1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=5Qrsnc7qlKPVD3grI2YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: bq27GCgk8TfzzI36hM5YvnjI0gTIoYOa
X-Proofpoint-ORIG-GUID: bq27GCgk8TfzzI36hM5YvnjI0gTIoYOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5NSBTYWx0ZWRfX14gw2Rtt6XzK
 fXA2743xa0AibDlLUIQesNCnUPMpxwmWjDBUAXS2ZiLtrEfcZyVQHTHScZgWZQqQhMtshqNWFEL
 4kk9//r8Twx7yKRDD9wETeF1YlgfiDXFfFNWB7ppHTx0qt0gzTbOOkmAVRHkkjwd0N9IVQft6D0
 zt2bNyVuzJjrjWapmBW0e2O++VW465JtQmuUQtSsJrZgIuOOmA1C2flCOWaUbLdhWnh9d8EJTWQ
 5lKr7F6Xq5hb3fIQGfbiN4J3CxSwf4K25TmInpwsANNqU17nyxNqeZoLC17VqT/ohH19/gAEb+g
 lsl9J4V9AVlSO5LecZDTBJ+RF+cs28liDlt+YFx6RMu+dFIZ50N35vXjlMRGqIkHjIiAuS/srM6
 ApYBFDJG4On5I5hx//aY2gVBYz04wjFCObnGujfeTbf4nNC/8jouoiL/DJ4PfeqBOsIcM5L2LVY
 UmHYFCgf/SuCjAaqSwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5NSBTYWx0ZWRfXymeL6zzc1sEH
 b9nOOc1xP4aZ03s/qLcdmVX+sCbl20LMHiKqC80zTTfeWA7VCIwYb2IvCdmTr6hHGv9dKpZNUF2
 eshBwsI6Z9A1pNedLoBN38XdTYdiF+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280095
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 3:00 PM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This script allows to easily build a qemu release container, based on
>> dockerfile introduced in previous commit.
>>
>> It names image "qemu/$version" and automatically detects which ubuntu
>> version should be used to build it.
>>
>> $ ./scripts/build_release_container.sh v3.1.0
>> $ podman run -it --rm qemu/v3.1.0 qemu-system-arm --version
>> QEMU emulator version 3.1.0 (-dirty)
>> Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  scripts/build_release_container.sh | 63 ++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100755 scripts/build_release_container.sh
>>
>> diff --git a/scripts/build_release_container.sh b/scripts/build_release_container.sh
>> new file mode 100755
>> index 00000000000..ae57aa21db3
>> --- /dev/null
>> +++ b/scripts/build_release_container.sh
>> @@ -0,0 +1,63 @@
>> +#!/usr/bin/env bash
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +set -euo pipefail
>> +
>> +script_dir=$(dirname $(readlink -f $0))
>> +
>> +# The oldest buildable release we support is v3.1.0, as previous ones require
>> +# additional tweaks in Dockerfile.
>> +# For building previous releases (down to v0.12.0),
>> +# see: 20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com
>> +oldest_release=v3.1.0
>> +
>> +if [ $# -lt 1 ] || [ $# -gt 2 ]; then
>> +    echo "usage: version [git_repo]"
>> +    echo
>> +    echo "- version: tag or sha-1 (>= v3.1.0)"
>> +    echo "- git_repo: (optional) QEMU repository URL"
>> +    exit 1
>> +fi
>> +version=$1;shift
>> +
>> +git_repo="https://gitlab.com/qemu-project/qemu.git"
>> +if [ $# -eq 1 ]; then
>> +    git_repo=$1;shift
>> +fi
>> +
>> +year=$(date +%Y)
>> +month=$(date +%m)
>> +if git rev-parse $version >& /dev/null; then
>> +    year=$(git log -1 --format='%cd' --date='format:%Y' $version)
>> +    month=$(git log -1 --format='%cd' --date='format:%m' $version)
>> +fi
>> +
>> +# Ubuntu LTS are published every (even) two years in April.
>> +ubuntu=
>> +if [ $((year % 2)) -eq 1 ]; then
>> +    # pick latest LTS from previous year
>> +    ubuntu=$((year - 1))
>> +elif [ $month -gt 6 ]; then
>> +    # LTS published this year should work
>> +    ubuntu=$year
>> +else
>> +    # pick latest LTS from two years ago
>> +    ubuntu=$((year - 2))
>> +fi
>> +if [ $ubuntu -lt 2014 ]; then
>> +    # oldest ubuntu release available with containers is 14.04
>> +    ubuntu=2014
>> +fi
>> +ubuntu=$((ubuntu - 2000))
>> +ubuntu_version=$ubuntu.04
>> +
>> +dockerfile=$script_dir/../tests/docker/dockerfiles/release.docker
>> +docker=$($script_dir/../tests/docker/docker.py probe)
> 
> For docker this gives:
> 
>  ERROR: docker: 'docker buildx build' requires 1 argument                                                                                                                      
>  Usage:  docker buildx build [OPTIONS] PATH | URL | -
> 
> I think it expects a . or - since the dockerfile is passed with -f
> below. Going back to
> 
>   docker=$script_dir/../tests/docker/docker.py
> 
> makes it work.
>

Thanks for catching it, fixed by adding context with '.'.

I switched to direct call because our cache mechanism does not allow to
change build args for a given tag.

>> +
>> +set -x
>> +$docker build \
>> +    -f $dockerfile \
>> +    --build-arg QEMU_VERSION=$version \
>> +    --build-arg UBUNTU_VERSION=$ubuntu_version \
>> +    --build-arg QEMU_REPO="$git_repo" \
>> +    -t qemu/$version


