Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71876C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEEx-0008AE-KO; Fri, 25 Sep 2026 18:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEEr-00088m-H9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:17:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEEp-0001Vf-IV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:17:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIoHq82335480
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V53G3lP1RqnlwzMkdWeomuvIq7++etCLnXJuGxe50aM=; b=K5sCyBay/F9ANBR0
 7lBJQO/m4X3/CJC6uwIrPz7xFsLzueDVFGTIA0jQcCC9iXX8xNTv2Icg19VrXzoP
 fjtdaDORdzMILn+qLyGVoYlgdADaEsvYihVx8jqddwzvTEuZ7CFSKgrEkEuvDf8I
 8C11B8ZpgefsAzFpmCF57hrZeFCNtGhO/P4eeS7Dn2/G9PhX68wZoB/Si8NQVKNb
 wbxiBPCHc22JTxN9p2tCsL4bsl/KM7VN0iwWxooeAxYrcb6bq9rh/MbYoYiXrZRE
 e8SUYhq8uSU9n1h+Mk5Lh4fVDqwPAWMiR1mgT0I6abqB7eaHB64DHBsNmPwF50Ex
 ugdlmw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvw1h27p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:17:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3284bbaa89dso5177452eec.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790374669; x=1790979469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V53G3lP1RqnlwzMkdWeomuvIq7++etCLnXJuGxe50aM=;
 b=MhNzw8SbI0poY55Puv9HNSOms/wi0WHVW3B4ld4Ev3UoUlCRIfpP6+v7y+3pq4Fa62
 yuDDbu/Tc9GIhqo7o+N+h6uySbQrFOdavpX0HfARtlTkLg+VP2ylQFL5797jTQ7u68xP
 ROU7JTmi+LYGjjaEAfbHC7LWalWLOwkTCgSqSh8laUJzSvB87Fy9vmy+GdIavcGXyP34
 ou/oGWquVlTaQ7EWxEJsbymIE1zrlQ7ZnkrstyXmSLyYxbgmtaJtvzDStQe0hPapIwTT
 XH61mfIJhuIoJGTK2XsRwknIVegEZh/hYFYz1PbgsDO+y5NlMHaj2mZ2w3UbEMwS+zYM
 b2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374669; x=1790979469;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V53G3lP1RqnlwzMkdWeomuvIq7++etCLnXJuGxe50aM=;
 b=vQl84sMbzNo9lAetIs+inAVOPc3OBuyaQgF0GO9gjBxRh8Da+O66tJ97H09nVFSKPD
 qFVF6TWRd5Ghz4rgbWqQ9Ujr6YwKt7Pu4ghBwIvk0/Nxy/4SZcuw2LOHupOiXpKbMKvm
 siGqdAN8udgoVIoPQaKYhpqiG8l6v3PvW49OLb52aw8cGiMR4qiRJLVD3s8yhB+P69V/
 FNS5HvjGYc0hFWCU/nZKOBQgJtZeFDfY4ZcWR3JFrdLeMUUoud07Ph79zAlQDEm+dPb7
 q1GKSeee9/mFNzfAkgxMR3umBXF5czrmfA1h4mwx51tn7zcS8nFNglZXktgiCpGcq0Co
 Q4Tg==
X-Gm-Message-State: AFuF++l9qwfiM2aeNdwV/4aHbbzsA4acYiUSc9cJkACWT8lf/GogaHC7
 v07GBSPnGMNs9J2jupMD1j/4DA7DPGUC3hsNhntNzVpZzdil3DpHI8v+I36a098TpVm2nUIboJT
 7DPk6h1vaTby6QC2PTPtfkgSwVoUMD9/860UXyZ37PCI5v7R/baFNQ2VzXKm/tmv7cQ==
X-Gm-Gg: AYBFou280SO0m+6p7ehDSkP+cigieVgnoQYsvCRvTXOyBKpJMP43uNCdQUXEw0Qi5va
 Z8WSWPL83ITOrHLgcol1jXEuSbUjswDWjyVDubMUECdTIjhxYsvUYz52Vs+a/6HAza3kQ+MjgbD
 1u7hhCb9DqBJTsPUY0xpkO42eReBCPoFj1+eH0TBwRRBPCFN7MMZFojmszEcX7ySgswqEuVBLLO
 OJsWdE2vuUysojl/8Te8Fbwo7hmyg2e38qinMz+CXMF+94E8DWJmL6VObsKr1vYJ4QQNDsI+bvq
 0mIPGBZTN/WwkaVRQjgDDOShxMw/eNNduNt4mIP2vu/bSccQu3YVQ+qjxccnaPR+weVI/o7DIZn
 yuhsOwcTorT+Dxej8hR+c4rmrJMf5tKfBycvvbr/19HXz+Ea5/THQxDB7lzjDQqqArXFxq/ljI8
 udLA==
X-Received: by 2002:a05:7300:2728:b0:33b:f206:845 with SMTP id
 5a478bee46e88-3427304f495mr1149428eec.32.1790374668513; 
 Fri, 25 Sep 2026 15:17:48 -0700 (PDT)
X-Received: by 2002:a05:7300:2728:b0:33b:f206:845 with SMTP id
 5a478bee46e88-3427304f495mr1149411eec.32.1790374667959; 
 Fri, 25 Sep 2026 15:17:47 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145c17074sm7713796eec.26.2026.09.25.15.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:17:47 -0700 (PDT)
Message-ID: <b1a177bd-40f6-4b64-a299-b14ff0afd2c2@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:17:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host
 architectures
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mj1HKPwW_WEG2OvhbBjUVBWfWxiFuKvt
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6ab6f30d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=RpKn5Ei_aLjrA3wclnEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: mj1HKPwW_WEG2OvhbBjUVBWfWxiFuKvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX+hzDcm9MJ4og
 nfBmjaw8DogCyYF7yJc1ZdGbYW3ag35TZBrlLZ6Vy55UM9e9oQvjHyJTvVBP2jbcb6qMChU+oWY
 wj6GtNtKjUZ4nqmkUIXG+S4BPDys1B0BZ81pW2ZbdGdu+IK6pnrByrv/d+RbgRW7dM1DUoaCqSV
 i6iNPsPboPVQDxHMivTIAagbulwgtlHL7PMnxLOZ+o2vCOBtoJO6FDI6GXiXkHBkqnngr7aAT4S
 zmo0lGaOhU+4Zxy8nY1EqJP5ZqarqbIMJz+tOFc54LEox9BQN1y+F3kJLIe0GX0rZtYIJW6jrkk
 /dVMKvtoONuunotyQCDwDAPM4UeMGgrAO0Je++UN60CvyV4yQpJrkcdeyclVvxFbXzGiEFaDV7c
 FUPtT0xIOnYmOzJX+LuYFhPMTmLYghRX6YRHpxyFKk9b6IwoKhS/DPu8MSTDZnNXwFxKitzW7Wl
 MMyugdRTUEJisiLh56w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX/vOZTUWQHy8V
 /afuKEEazTDfd9Bxb126xLraSrRKpB+N3Xhcf7W1I1rGHFNzbSIX0bVRQHSJze0qa7Aylb91hJm
 /DPJPh7F1ZaoNHwb9cAudzMORGK/b9I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250088
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/23/2026 11:57 AM, Pierrick Bouvier wrote:
> To increase our testing surface on aarch64 and other hosts, and also to ease
> maintenance of docker images, this series introduces x86_64 base containers.
> We rely on qemu-user-binfmt (available at least on Fedora and Debian/Ubuntu) to
> be installed to execute x86_64 binaries on other host arch.
> With this, we can run the full tcg tests suite on any host architecture.
> 
> This series exposed an issue with on aarch64 hosts with test
> loongarch64-softmmu-memory that was reported in issue:
> https://gitlab.com/qemu-project/qemu/-/work_items/4567
> 
> v2
> --
> 
> - Add comment in patch 1 to explain we detect x86_64 containers execution
>   capability
> - Replace the registry change patch with updated libvirt-ci, that now generates
>   arch specific Dockerfiles by default
> - Use lcitool --host-arch x86_64 to have stable refresh output on different host
>   architectures
> - Add a patch to speed up compilation of x86_64/test-avx.c.
> 
> Pierrick Bouvier (6):
>   tests/tcg/meson.build: force use of linux/amd64 platform for
>     containers
>   tests/lcitool/refresh: generate dockerfiles using --host-arch x86_64
>   tests/docker/dockerfiles/debian-all-test: remove arch specific bits
>   tests/tcg/meson.build: remove cc_docker_host_arch
>   tests/tcg/loongarch64/system: deactivate loongarch64-softmmu-memory
>     (hang on aarch64 host)
>   tests/tcg/x86_64: speed up compilation of avx, mmx and 3dnow tests
> 
>  tests/docker/dockerfiles/alpine.docker        |  2 +-
>  tests/docker/dockerfiles/centos9.docker       |  2 +-
>  .../dockerfiles/debian-all-test-cross.docker  | 39 +++++++++----------
>  .../dockerfiles/debian-amd64-cross.docker     |  4 +-
>  .../dockerfiles/debian-arm64-cross.docker     |  4 +-
>  .../dockerfiles/debian-armhf-cross.docker     |  4 +-
>  .../dockerfiles/debian-i686-cross.docker      |  4 +-
>  .../dockerfiles/debian-ppc64el-cross.docker   |  4 +-
>  .../dockerfiles/debian-riscv64-cross.docker   |  4 +-
>  .../dockerfiles/debian-s390x-cross.docker     |  4 +-
>  tests/docker/dockerfiles/debian.docker        |  4 +-
>  .../dockerfiles/fedora-rust-nightly.docker    |  2 +-
>  .../dockerfiles/fedora-win64-cross.docker     |  2 +-
>  tests/docker/dockerfiles/fedora.docker        |  2 +-
>  tests/docker/dockerfiles/opensuse-leap.docker |  2 +-
>  tests/docker/dockerfiles/ubuntu2404.docker    |  2 +-
>  tests/lcitool/libvirt-ci                      |  2 +-
>  tests/lcitool/refresh                         | 37 +++++++++---------
>  tests/tcg/aarch64/meson.build                 |  2 -
>  tests/tcg/aarch64/system/meson.build          |  1 -
>  tests/tcg/aarch64_be/meson.build              |  1 -
>  tests/tcg/alpha/meson.build                   |  2 -
>  tests/tcg/alpha/system/meson.build            |  1 -
>  tests/tcg/arm/meson.build                     |  2 -
>  tests/tcg/arm/system/meson.build              |  1 -
>  tests/tcg/hexagon/meson.build                 |  1 -
>  tests/tcg/hppa/meson.build                    |  1 -
>  tests/tcg/i386/meson.build                    |  2 -
>  tests/tcg/i386/system/meson.build             |  1 -
>  tests/tcg/loongarch64/meson.build             |  2 -
>  tests/tcg/loongarch64/system/meson.build      |  6 ++-
>  tests/tcg/m68k/meson.build                    |  1 -
>  tests/tcg/meson.build                         | 33 +++++++++-------
>  tests/tcg/mips/meson.build                    |  1 -
>  tests/tcg/mips64/meson.build                  |  1 -
>  tests/tcg/mips64el/meson.build                |  1 -
>  tests/tcg/or1k/meson.build                    |  1 -
>  tests/tcg/ppc64/meson.build                   |  1 -
>  tests/tcg/ppc64le/meson.build                 |  1 -
>  tests/tcg/riscv64/meson.build                 |  2 -
>  tests/tcg/riscv64/system/meson.build          |  1 -
>  tests/tcg/s390x/meson.build                   |  2 -
>  tests/tcg/s390x/system/meson.build            |  1 -
>  tests/tcg/sh4/meson.build                     |  1 -
>  tests/tcg/tricore/meson.build                 |  1 -
>  tests/tcg/x86_64/meson.build                  |  8 ++--
>  tests/tcg/x86_64/system/meson.build           |  1 -
>  tests/tcg/xtensa/meson.build                  |  3 --
>  48 files changed, 87 insertions(+), 120 deletions(-)
> 

This was merged into master (efa3b9d5ac8024078225e1ab434411fdfe53b457).

Regards,
Pierrick

