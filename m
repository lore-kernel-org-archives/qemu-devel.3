Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA41606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gOuAZZ2d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j4yEiNCo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTcO-0004tt-34; Thu, 29 Oct 2026 13:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTcM-0004th-8N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:08:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTcJ-0007V1-LO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:08:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXR03234256
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SUlklgUjY0gU2CiCR1hEpaRyBJvNSjdFmUUIyce7xxk=; b=gOuAZZ2d7DNcsQ1Y
 3AYa/apaPWPMkhdmn0XCN5B69DIMNSn0xT/Wj0MvwlpB88YGh4bVImDuwNhw44+t
 zYwjM+hfL5rzfWAlSC16IExNCWkt8ZXaDRtWRjLWyEMMzNmYzKGByM3n+08B+f5f
 Lm9KOSODeawfZp6Ves8tdoY9NLQfCOWJ9tNc847PU50Ppn8dOfFc7ZmhcwPw0yrk
 2wy9z3IRqHmRU7WfzsUexh9+6RS1XM6yc0dT0K/qP8qzpU5ejmJ4wJvN7yJajoXQ
 gzMihyme7V1BqjZvEkqPTPnlgMdvhT3grPTJqwsHX43QXCmz1DTShf6UduPS40lI
 bfxIsw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b21vm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:08:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so9154226eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793293721; x=1793898521; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SUlklgUjY0gU2CiCR1hEpaRyBJvNSjdFmUUIyce7xxk=;
 b=j4yEiNCo01QifrSo3Jy1kf2yneiZPaLHtmV7MRwxnI8k1ERDSrxgbQfNoHVzh6NOre
 ATXgYOAC8f2hlG6yiWi/4CPlXVS2MsZONlkXz/+UqGaE+UClIkXd914HoslmYD0nkf1y
 MnHWU2vYEx5PXo36glkgFFaHvb0PLVkBGU50D8FW4heBeKnj51JQO7IImEvYrGqrrnnm
 B0fGPlsQZNPE+6EJs6sVi1zJniaYW6XExt9zQv97KTbcUbYNEfr6eYr51W3MmQs6hzWb
 zedkf6Wi7Fvn57wcflsLl0Iq07TOYinvhqDoOaxWvz1Kgrk2U0AZT243Xje1BgTvCl0r
 1E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293721; x=1793898521;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SUlklgUjY0gU2CiCR1hEpaRyBJvNSjdFmUUIyce7xxk=;
 b=GsGi91fjeCeBMD2mACPSa1rkdbp7mzHtV/UK686ZolC/GBH6eKRSkzSXsEtQaEKnp8
 gFFwyUTgrur7Nkz/20JehjWZdhLX++64e1agfHexFGG52zaj4zbN9hvRGRCWM2fthiuO
 YYftl4l+IdYa5Akej+tGVV+STz5Yv8IGd5SfuU8hC0KXanrYYwTzzH+shCZi2Wx7q4qG
 jrHJYQANbdtV4fhzMYkcQ7jKlPYc4EO3Qjtp9ZzC8im4AToKCb6o/7EFo3/IWvBnCAe6
 98RpVRYLzw9ytkthuQNjZ7SxrnEcQfYwGRbrXswmD4jAlNjexQCxfmEOmU7EoliliUhf
 IpTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFkabTQ2Gs/EAhl1ET4j5CDq8SBxPoPKJLQi7bNO2g+ZbaS6Mqw/KrwHsCh9uWTW66LRfOH3UJ7EOj@nongnu.org
X-Gm-Message-State: AFq9FYK+M+bgCwmojbUfaeJGw+plhN9HT105eGoOTH6fA7+2MlWRTV5u
 QixEDphAm66KKTTVpZExdj62iQJ6n+IsG14XKFy7j9sXg4v9XJt2vAhVIabL80WKPYc1UyVVcXG
 OcqcPNpvK0M56BGjM50ZUDqhfUYqOr39infOJ8QwTyyWA+9YiLWMfVzp8TQ==
X-Gm-Gg: AYBFou01xZMbMpaIIdplW249xfy6QEoNmwrANQH2zzmCr1g/qSHgy1lYc7c2zrmCxnM
 Ov4f5AIxSfYpNGNIlthD9VsZU+czeecJdBgpm3zc6QHqThdDPkl2re0opVEeNVII4EXv7mwBq+J
 RyMW6TXu5mwegUB9JwUl9m4DNpAxyx/v9F42SF7vbEy+sZTvTMJGLD6Ukgb8I68e1wyadVx89y8
 QJznWsqHrETVjUAnqcwM1sJMPVvoYeTtUvzkmSbmqMnWmDeq8oeLt3Rzb7mjMduDg+ExhHnXljV
 1trH+JQDt7rV5RboqpSdGZslYj9kZeqKuHqeHWrwUXxFukzgRvPCnN5Cddva7JmcHWVyFVUz799
 Sc56osfsRMpY2mhkaAHIBIK/dS7m26x7Qc3rMY9ipl6/cFqSZqU+Z7Z7joO/2DI+Y8aw/s3ht09
 eVkO23mWLmBVoolEztHHo0GI0J7J/1NEXLNRTZzdhvHOI=
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-36a42434630mr2819eec.39.1793293720556; 
 Thu, 29 Oct 2026 10:08:40 -0700 (PDT)
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-36a42434630mr2772eec.39.1793293719922; 
 Thu, 29 Oct 2026 10:08:39 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a40ee6c18sm531526eec.1.2026.10.29.10.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:08:39 -0700 (PDT)
Message-ID: <7757e99b-0338-4508-b36f-9460d4efdb2f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:08:38 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] tests/docker/dockerfiles: add release.docker
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, 
 mjt@tls.msk.ru, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
 <20261029000853.15166-2-pierrick.bouvier@oss.qualcomm.com>
 <87ld7gin6q.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ld7gin6q.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfXxNRwJZT0Qk3u
 Ash1K89bHASVl5GZ/lILxMu1nshq/WBOtvxm/fIt92wjQOKiEzH8gQX81KT+mCOVzgvZBwPwKbf
 pN+ImtHS+h0j/Se4A0MkqnaMOMM+n5g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX8mmxCejG5ivW
 oLPFiXkUjtxLyLXW2AN0EucaYIYCO0dF7A8g3ihqW5QZi+pd8HZDz96Y1JNmzpUkKOH73PLszE3
 isMIYtRKqSFbfgz1I4NxuEnXf/m3crRo0j+HqnN503S+2+MGqetdcqTjTPeIc/jVH0iRTaFQWwc
 vaZ/DW67zDGqpxaf3xZLy2teyOe1sYcrNEc20fLWPkvpE2fPUBtApoZycWHb4WfXcXwV5ifDwOf
 fFRvT1lWRinzCGj2ouR3SiG/xTDhi+UwUEWmVN05JnT7Ox44SgYolMzcNFn1XjSoW483eFssIRj
 Iw9ukX5qyx2ZEaFwS3gTVnMkkquB4QMddLNM5kZIRZScekpcc0QWxZcLD8DfxnRDaexfrXschV7
 cF8U/Ju+6ZIe7pCKLTfArPPg5MJOHNunp0b3dZQuzNqEfrgblzWNWIGPJE0K3N5lUEt/wGocxS4
 Z24BG5oilwX71Lgej6Q==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae37d99 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=sRQYoUIEv7qwtnaMGc8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-GUID: zIXMGVGiyhfimznakR_QFh7RSrZOdjx2
X-Proofpoint-ORIG-GUID: zIXMGVGiyhfimznakR_QFh7RSrZOdjx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 6:41 AM, Fabiano Rosas wrote:
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
>> containers available down to 14.04. Debian old old stable have broken
>> apt sources for instance.
>>
>> This unique dockerfile works for all qemu versions >= 3.1.0 (2018).
>> We could build down to v0.12.0, but it would require more tweaks in the
>> dockerfile, so we keep it simple instead.
>>
>> To build the image, you need to provide a qemu and ubuntu version:
>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>>
>> To run it, as there is no shell, and no defined entrypoint, you need to
>> choose the binary you want explicitely:
>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>
>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>> new file mode 100644
>> index 00000000000..ca6babde01e
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/release.docker
>> @@ -0,0 +1,48 @@
>> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>> +
>> +FROM ubuntu:$UBUNTU_VERSION AS build
>> +
>> +# add deb-src for apt build-dep
>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>> +# archive.canonical.com is not reachable anymore, and cause a long timeout
>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>> +
>> +# build dependencies
>> +RUN apt update && \
>> +env DEBIAN_FRONTEND=noninteractive apt install -y git build-essential flex bison
>> +RUN apt update && \
>> +env DEBIAN_FRONTEND=noninteractive apt build-dep -y --arch-only qemu
>> +
>> +ARG QEMU_VERSION
>> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
>> +ARG QEMU_REPO="https://gitlab.com/qemu-project/qemu.git"
>> +
>> +RUN cd /tmp && \
>> +mkdir qemu && cd qemu && git init && \
>> +git remote add origin "${QEMU_REPO}" && \
>> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
>> +git checkout FETCH_HEAD && \
>> +./configure --prefix=/opt/qemu --disable-docs --disable-werror && \
>> +make install -j $(nproc) && \
>> +strip /opt/qemu/bin/* && \
> 
> For the record, here I included a 'cp <list of bins> /opt/qemu/bin' line
> to make migration-test work from inside the container:
> 
> migration-test
> sh
> env
> docker (installed as docker.io up there)
> cat
>

You mean by mounting current folder in the container?

I'm not against it, but I feel that if we go this way, it's just easier
to say "let's use the full base image", since it will become "I need to
run python, and X, and Y, and Z".

What is missing to just use the container as a binary, instead of having
to mount anything inside it?

>> +rm -rf /tmp/*
>> +
>> +# retrieve runtime dependencies (libs)
>> +RUN ldd /opt/qemu/bin/* | grep '=>' | sed -e 's/.*=>//' -e 's/(.*//' | sort -u > /opt/qemu/libs
>> +# store them in /deps/lib
>> +RUN mkdir -p /deps/lib && cp --preserve --dereference $(cat /opt/qemu/libs) /deps/lib
>> +# copy loader (with its original path)
>> +RUN cp --preserve --parents --dereference /lib*/ld-linux* /deps/
>> +
>> +################################################################################
>> +FROM scratch
>> +
>> +COPY --from=build /deps /
>> +# copy qemu and all associated artifacts (roms, ...)
>> +COPY --from=build /opt/qemu /usr
>> +
>> +# build with:
>> +# podman build -f release.docker --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>> +# run with:
>> +# podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version


