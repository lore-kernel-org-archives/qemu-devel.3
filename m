Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878AEC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpqOx-0004Dk-O8; Fri, 31 Jul 2026 12:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpqOr-0004DQ-Vy
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:47:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpqOp-0006sH-Pi
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:47:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFOjwX508113
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 16:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SSB1xJwaabeDfvTYBtA307MqJcypwYgNRIx7+KQ19Wc=; b=OI668LbRi3UerLMs
 GrPr9C6INdBg2Rc0gVHbpIxivfE6VlnFI80NZxzIBMJJuO9ZLH/uumfCwyfTeGUt
 9K7f4ay0U9RUZwB33LIinyqBl1DRZthRULO79Wz1lA2X6IEeX741sLnx4C7QU5q8
 j6xrXRo3SPn4ov5VT+4ZxS2Y3MHSXjBNQGkJeh/vOa2tAVaC9NhFl56JTkQ22W5Y
 051GMftXM4OGnlXHYXyFImNL+0pZ6WyzZzhMlAPvWzuhEDLuiFeVep5IjamAp+vm
 TSlzBx0hhMtdiWtuF9z260v2/nTWYtXDYEqSAptPD384o1QEkGZQy80YsFz0r27C
 fmeAaw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru131bs6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 16:47:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb711c88f2eso624983a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785516468; x=1786121268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSB1xJwaabeDfvTYBtA307MqJcypwYgNRIx7+KQ19Wc=;
 b=dTk/wv1BW4xO5cSTJa7X1PbVnor1dhR7uqqsspA7u45X5jsRqSMxI9W6Qg5GEPp1JB
 Snt9TBKJ/qdt6fCmPGYm1fwJVfXhA4v0XOCRHQuJxwD6UKYEOzABGrGi76AQPUmgBuWv
 pwINA9wojzagPGyspEbPmyCsY8poq8Gld/tRz1BVeqcIzNcnIu7yHaPMdfFelJ/uSLeL
 vqePnEiid62BDXNc2oZ/LvVSrcqsyF5idgR8rZcnvy1i8Yy+6UEcZjzMZN+WZ7zCVb2P
 66ojfkEGS1JYcJGla/7UQpt+5T+uti/6B/qhSTdUmnKngOICo9ijreihKf2+2JjE+ms5
 2PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516468; x=1786121268;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSB1xJwaabeDfvTYBtA307MqJcypwYgNRIx7+KQ19Wc=;
 b=RNNTEHtHNS+VG/IJN2RhhSgSO5KWmgyGlSSV+oXRZ02sg3XemczCyhm1I7ucUhL4n/
 dB80SXjzgjLh9qRlUpHTpZh4mgU1hpqV1r055UWPH1RsgQeNH0qinGwkMWFP+GuaA+nn
 oqLk5hOBbULxFv+NiVX/bnm1LZcUjsV10nObYccAW+GIAzOSXuegVvG8tXN3d+X2v7Uw
 NpQl7rOxM5ftGa6oeya8v/iYfksVXN92lUtYU3Nq7Lbi2YRIegitiwJpiRs6OPs9Zg5n
 s8RkWJz+SzlqXnYF+xQhe0q//9I09twiPHo/7kvU7/qbf40aYFdPEEQvdt5Vi7nro9i/
 qSYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqbz+7xEZEJLvEcjcuZMNCGPGE5rGYxe6G0oYqe96Ym+ejwY5IsVToxeASZXo9EXM45cwK51OuUWz9J@nongnu.org
X-Gm-Message-State: AOJu0YxZPJzt6uIysh7p/aFJFjLuIoi35Cs5GoeyPVX+qUMmmLSo/IJx
 LHIG8in9oV0q/ZzIqt4Eq0YMAVa9F2MbxEQlLQPV1TqzIvOwWaP0nxmHFa3P7vNEF34Mr1nvoyc
 XjASWnTOgYjwx0z5htq254wAdWNPdRgq3dUIhnTOL0oBOMpni+35KJBcU+Q==
X-Gm-Gg: AR+sD10VlqQ4pKLuiDckfU6x/ogo2sFzbqLVyBH0Ju7GTJczFaZvSURZbPDzagO1NK5
 8M5yrZmL2FEeJwcxA6kchBwMwbM/iUwrWp/2luFyxsvx9Q4zfFLBIuJVbz8uPFgvE2aiaa+mk92
 ounzHhCAVe3V6vh6aY8iDpQLfqrQIINkrv97gg3/4tcGwIuvstsDybjA6RdQCbmQbgCwRukuS+w
 /v7ZCBYw0cViBu6hD4LEdX8VQJCDkkwxAZcKcPxwEr1kVL/0FH6neNeh/uSUPhbAgpPQpl+mt5K
 i1mbArlvbNazakjJanHGyqoll1Xz6Ondry0cutqHLUcF2sUfbCxcQfc+PHugApPAWsPXk/5aJZ2
 4/vr/oEO0bwpB2/u3T21ZCJK8IiiMdYg8jQHGICduRiCb6Mbpj9VpOqWpr8vZTUnIDyDJ
X-Received: by 2002:a05:6a20:9e46:b0:3c3:7fff:ba63 with SMTP id
 adf61e73a8af0-3c92a855d59mr463495637.47.1785516467809; 
 Fri, 31 Jul 2026 09:47:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e46:b0:3c3:7fff:ba63 with SMTP id
 adf61e73a8af0-3c92a855d59mr463465637.47.1785516467335; 
 Fri, 31 Jul 2026 09:47:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153ddcba2bsm8536575eec.11.2026.07.31.09.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 09:47:46 -0700 (PDT)
Message-ID: <d959add7-93bf-486b-9368-790b7552039e@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 09:47:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/50] test: helper-to-tcg docker tests
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, philmd@mailo.com
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-41-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-41-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEyOCBTYWx0ZWRfXwjNRbrrHFu/2
 /c/rwwENUiCvGCyvKN5Wl/CS7eOCT6iQG+FjnA3pppM8B/kfeloDB6mnmvC+qyieL+dMXGPWFjW
 9SX/kDJ/YJqUpRypuz2mUXzc0Cjursk=
X-Proofpoint-GUID: t9nUP9dYHKIG6CffzfZrLFczZ5sQeG5E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEyOCBTYWx0ZWRfXx9i0mmtCv/Zy
 Wk//YqROfXtGLRyf6/h0P7n2K5gsJ1tm0KIDRV9wjtfsw2sfTjSygcKhELroTZCkJFRdzAfSyPz
 eRMhyksDnS02S4KZ7XW81fzhnC4lXgZT34vNeJH8e2ExbK/EZO9HtOEusq09xHgQ7FMzxrMf78A
 x6B6elaPmkvoiouVJnJ6v+Z3J2Bcb4+5hrGRAWYWGorpIHwpmBR5nIio9LVBCnR+dnz/GmBoZ+z
 IcVfXfzv6mLkkHxSQBQG6fEdKCv93cPwI2UfdE94Y9LFVnQv7jHSDtBwY0Q3wm+EBZmfVzyuupD
 Xxx8ZXMePaRZmThX7pruvbikWhu9pSCgspTreEE0Jg8SHLS7DE5w63mm6wdjIIJuc94yt0mzrSO
 3po28DVi1cPsaS0ZNl2CjwvrAqZ8mytNWiWunJWEt0dIQWMmbXj13RpR6RN8K03Yy49bxbRFGjS
 QD43emDumqxW+sRa6LQ==
X-Proofpoint-ORIG-GUID: t9nUP9dYHKIG6CffzfZrLFczZ5sQeG5E
X-Authority-Analysis: v=2.4 cv=CYI4Irrl c=1 sm=1 tr=0 ts=6a6cd1b4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Twlkf-z8AAAA:8 a=PEdW6uAvyUzQI0Ov61IA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310128
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

On 7/29/2026 8:10 PM, Anton Johansson wrote:
> Adds a docker container with LLVM versions 15-21 and a docker test for
> building helper-to-tcg and running end-to-end tests along with running
> check-tcg, for testing targets such as Hexagon.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> --
> NOTE: Last I checked I had some troubles with C++17 support within the
> container, was a while ago though.
> ---
>  tests/docker/dockerfiles/debian-llvm.docker | 38 +++++++++++++++++++
>  tests/docker/test-helper-to-tcg             | 41 +++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-llvm.docker
>  create mode 100755 tests/docker/test-helper-to-tcg
> 
> diff --git a/tests/docker/dockerfiles/debian-llvm.docker b/tests/docker/dockerfiles/debian-llvm.docker
> new file mode 100644
> index 0000000000..7bfc084a34
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-llvm.docker
> @@ -0,0 +1,38 @@
> +FROM docker.io/library/debian:11-slim
> +

As Alessandro mentioned in his answer, all others containers are using
debian:13-slim, you can migrate to this one also.

> +RUN apt update && \
> +    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
> +    DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt install -y --no-install-recommends \
> +        bison \
> +        ca-certificates \
> +        flex \
> +        gawk \
> +        libmpc-dev \
> +        libmpfr-dev \
> +        libglib2.0-dev \
> +        libpixman-1-dev \
> +        make \
> +        ninja-build \
> +        rsync \
> +        pkgconf \
> +        wget \
> +        lsb-release \
> +        software-properties-common \
> +        gnupg \
> +        meson \
> +        python3-pip \
> +        python3-setuptools \
> +        python3-venv \
> +        python3-wheel
> +
> +RUN /usr/bin/pip3 install tomli
> +
> +RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh
> +RUN ./llvm.sh 15 all
> +RUN ./llvm.sh 16 all
> +RUN ./llvm.sh 17 all
> +RUN ./llvm.sh 18 all
> +RUN ./llvm.sh 19 all
> +RUN ./llvm.sh 20 all
> +RUN ./llvm.sh 21 all
> diff --git a/tests/docker/test-helper-to-tcg b/tests/docker/test-helper-to-tcg
> new file mode 100755
> index 0000000000..0c27040d60
> --- /dev/null
> +++ b/tests/docker/test-helper-to-tcg
> @@ -0,0 +1,41 @@
> +#!/bin/bash -e
> +
> +TEST_COMMAND=""
> +TARGET_LIST=""
> +
> +cd "$BUILD_DIR"
> +
> +# Checks helper-to-tcg builds and passes unit tests
> +# for targetted LLVM versions.  Run meson from QEMU source so helper-to-tcg tests can find
> +# `tcg-global-mappings.h`.
> +for version in {15..21}; do
> +    llvm_config=llvm-config-${version}
> +    build_dir="${BUILD_DIR}/build-helper-to-tcg-${version}"
> +    cxx=$(${llvm_config} --bindir)/clang++
> +    [ ! -d ${build_dir} ] && mkdir ${build_dir}
> +    CXX=${cxx} meson setup ${build_dir} ${QEMU_SRC}/subprojects/helper-to-tcg -Dllvm_config_path=${llvm_config}
> +    meson compile -C ${build_dir}
> +    meson test -C ${build_dir} --suite 'helper-to-tcg:helper-to-tcg'
> +done
> +
> +# Runs check-tcg for all LLVM versions
> +llvm_config_main=llvm-config-15
> +bin_main=$(${llvm_config_main} --bindir)
> +cc_main=${bin_main}/clang
> +cxx_main=${bin_main}/clang++
> +for version in {15..21}; do
> +    llvm_config=llvm-config-${version}
> +    build_dir=build-qemu-${version}
> +    bin=$(${llvm_config} --bindir)
> +    cxx=${bin}/clang++
> +    cc=${bin}/clang
> +    [ ! -d ${build_dir} ] && mkdir ${build_dir}
> +
> +    pushd ${build_dir}
> +
> +    TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
> +    build_qemu "--cc=${cc_main} --cxx=${cxx_main} -Dhelper-to-tcg:llvm_config_path=${llvm_config} --enable-debug-tcg"
> +    check_tcg
> +
> +    popd
> +done


