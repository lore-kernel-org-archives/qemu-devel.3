Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C3606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MqTrnayR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JXbtKSgk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVbt-0007hu-Kd; Thu, 29 Oct 2026 15:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVbD-0007b5-0Y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:16:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVb9-0005He-0A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:15:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXwn3234268
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 APJhIFaHaH9q0fqLJXhHconmmg5XLY3Agiti5oo7+iE=; b=MqTrnayRD7sEyCcJ
 ysG2ecwy5IF8c9MFx9K9hgWizBaryx/u5ljNkMxSHnNfe/XC8zufM5CJWuat7bAz
 4E/Chiy7xhcoj5nrmTiJdGrbOjB22zD1QwBkrfEb3jwo7GyZd4oWEss+y4LgfssV
 rKfyBnzWHzQv8FRCvDxBlNs99aV7GCg73iCMca9JutflcTJnL0mrkI5AHXG7zXKy
 vuWPpiO5cohRrmazK1Ne6FnxudYBzbqZS7e4UhsU2i4Zzu78rtfDEm33FRWkb9CX
 oOZNntWobVosEeOQBGwKFfEuCq/cCfds5F2Hq7eMa13yEJMhQTvdgyOIO4WdIf6u
 UReIDA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2qym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:15:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a223755e4so90292eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793301334; x=1793906134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=APJhIFaHaH9q0fqLJXhHconmmg5XLY3Agiti5oo7+iE=;
 b=JXbtKSgkvCiHhzBHntduw9+w0q+230rV6fv2fa2O8NUXw111pP5uupTLubOGBfkhC0
 PiXwBNWk3SHhmf2y3sLW6lqeJcsO7pw1pxZey2w2JW01f5tXR/JFdZcFFZcYOWlnGjIM
 w+BVFBE9WGHqBK6QoovHzPLx3vFrgDK9ptdOQ36pA6HuSK03Npsyk8RQNegx4C7Du2Ld
 3IOfBRpq5UBdDlVdUgDU/RIrGho7cLE9iPkt0Px7wYChp1Fr1S1fCfUnoFZq0m2FEq+d
 5v0lbRr9dlRBZFJDAl7VU1d/sRxx/B+A7U+wCB1j5EjYznpv/JhFkgKa4mg46jjZQKwt
 5PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301334; x=1793906134;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APJhIFaHaH9q0fqLJXhHconmmg5XLY3Agiti5oo7+iE=;
 b=xwJeeVN1l5QGxCyEl1eafgGbDGH8ifYAJ3i9hCw1VNNRaah0czsMZkw3BBSsbEF4qu
 taBi3Ay6/1UU+LO//u0kCc4cCeIHHsRv7kuLEaan4X5J28LOP91tOVV4pEOsBzJGGGKe
 mR3oztpOc9z9+LhmScdf4JsuXC2/+z/5gshuS4YoPX5PX1E7SWEdTDYvvQCOp+q44h3Y
 kWDlJvTvz/qLHgnKOJGfQ7296BDw7ELpGriahlnhBaJwNJovFwjBdKyj2WtKxParHWZA
 tHbxZ3YcfwYSlNROHI4a5Sc+OD8gg6QyE37h18JXhTMP1TCr6rzw1H0mhS3Igu2b9/Tu
 oLLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5ITsy+egyPUu2pMdehOp/Iqs6MB0BLbKCq5OwC/Db1IbSsk563UDi+ts3SkG1PnY19G6OW07bAMUK@nongnu.org
X-Gm-Message-State: AFq9FYKnX2zFAlS2o1O0290FSitgBRvs/lG7z9YIPCQ9rpBa3Z5u8qj+
 oRwIf71PfhnOQu1CcNTLCOxc0ASvUJ85VAjDrfeGutAxFB4ZFngHCYbueN2q4FxPE8zWAw60RJi
 fnHVN4KfHuQ85nm8G4UPe4IxVIOM163LJKqbQ2I4uWnx9zovjbgrYbzt+6Q==
X-Gm-Gg: AYBFou2XD1ixVs0cfEnv44HKUCaqPQs3pB4JBTVnYjxH87Lynnh670MmCjKXM4hiAHB
 bsVGWo8xWGm+MqKe6s+rE8dTTE18lltzD5OYYUhwE1XtnzxjPGmi32sbNZD9YclQ4tLywwJL9WX
 oAvZST39Gx1Pwy6drx45z6cHdyD879EGsmtqFSY6IeALd+3Dz8gmPBrbpje1fa+E+azd/1n+7s2
 PgG0VLsWupizVICudXqZ41D/iRg9pOaq8/QIquQbghtni/KgMH4wiy5HHn+l71Mj8EgE1vDlpGZ
 YqZUmvn3+IG0Fcl4SQlS4fUUVL/33oNE1sOG7wfXq7PlYa1pjJNruLpZPzc2WUxOqfLBITfiXhq
 MgOuOMMBLXt6tE36BfhSpQw0CLQeEYqh0BgpgTB/i5eXF5BCwABuL3Vi1PD69IWA8+CyDKuMjpx
 T2jsA/OlmnEpi+OIZgLmyAqp2+adMCEKYRJztuzZ9NNG4=
X-Received: by 2002:a05:7300:c00e:20b0:36a:12bb:7f8e with SMTP id
 5a478bee46e88-36a4232ede1mr499181eec.13.1793301333727; 
 Thu, 29 Oct 2026 12:15:33 -0700 (PDT)
X-Received: by 2002:a05:7300:c00e:20b0:36a:12bb:7f8e with SMTP id
 5a478bee46e88-36a4232ede1mr499133eec.13.1793301333049; 
 Thu, 29 Oct 2026 12:15:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a5fb97sm654795eec.23.2026.10.29.12.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:15:32 -0700 (PDT)
Message-ID: <796b02d4-9cb0-4d04-a2cf-ca167fb01eb9@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:15:31 -0800
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
 <7757e99b-0338-4508-b36f-9460d4efdb2f@oss.qualcomm.com>
 <87fqxoic5s.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fqxoic5s.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NSBTYWx0ZWRfX7H+swPnAgm5B
 mcJBgfwKjhLCPVKWUYL6lkKrHjJu+ksG5AFVC1J2DV1rMgoFaYwrsI9o+MqolR1CdlZS+U3WZbO
 YiWu7yLgfL4nH6vcJDSzJlAg8A7l/vk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NSBTYWx0ZWRfX6FcW8zu7QAnh
 ZFIm65TvQhQp7Eo0+QzzjSrp09P4DikRWPNtTcVrxEnvlKJ3UBlb2ij4d9TlNhq34lmRzr9Lrkl
 zOL3C0IjY6/SG0qhawBgUb5rNsQWLTa4r2w+k6TD0iv52IbUdoJcb/lmrh3fdgyXHOPbjUCBE9g
 9xaosp8jvuIPCX7PPsCSLR5Y7z3csiCFvfLsIbuvptSyJTg3VaVuaYT0+aGRQ1XzmCptYUVlKhv
 3QxLk015M7euDLsuMOJd/R3+K4blkaaOVChgYQzeiCIeXgteMO4wzdSV/48KSwcQwog3QMqYZBv
 YoXjHmsYMnhZFTFJWHS2gRYRAIvZDXhqVNAR/hwiiI+e1HbdUJhOjQaZ0moLN0WL9fb0TDZ595r
 ezZOXmvemCU716VQ9cKzdNtiTsmmIzY5TeWLkawCR5shi2nIc6BxflitaiY1t2tItwVO+1TVIEJ
 o67gGhGafWOKh8tVIqw==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae39b56 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=_hv2-ujvbyOU4WA8w3YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-GUID: uhRcKKiop0sPmWnZ2ZF4kjDlUEXkiB9O
X-Proofpoint-ORIG-GUID: uhRcKKiop0sPmWnZ2ZF4kjDlUEXkiB9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290075
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

On 10/29/2026 10:39 AM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 10/29/2026 6:41 AM, Fabiano Rosas wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> This new dockerfile allows to build a distroless image containing only
>>>> qemu stripped release binaries, their lib dependencies, and installed
>>>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>>>> else. This is achieved thanks to a multi-stage build, where we add qemu
>>>> binaries, artifacts and libraries in a new scratch image. Image has
>>>> the minimal size possible.
>>>>
>>>> This is based on Ubuntu, which has the advantage to have working
>>>> containers available down to 14.04. Debian old old stable have broken
>>>> apt sources for instance.
>>>>
>>>> This unique dockerfile works for all qemu versions >= 3.1.0 (2018).
>>>> We could build down to v0.12.0, but it would require more tweaks in the
>>>> dockerfile, so we keep it simple instead.
>>>>
>>>> To build the image, you need to provide a qemu and ubuntu version:
>>>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>>>>
>>>> To run it, as there is no shell, and no defined entrypoint, you need to
>>>> choose the binary you want explicitely:
>>>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
>>>>  1 file changed, 48 insertions(+)
>>>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>>>
>>>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>>>> new file mode 100644
>>>> index 00000000000..ca6babde01e
>>>> --- /dev/null
>>>> +++ b/tests/docker/dockerfiles/release.docker
>>>> @@ -0,0 +1,48 @@
>>>> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>>>> +
>>>> +FROM ubuntu:$UBUNTU_VERSION AS build
>>>> +
>>>> +# add deb-src for apt build-dep
>>>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>>>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>>>> +# archive.canonical.com is not reachable anymore, and cause a long timeout
>>>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>>>> +
>>>> +# build dependencies
>>>> +RUN apt update && \
>>>> +env DEBIAN_FRONTEND=noninteractive apt install -y git build-essential flex bison
>>>> +RUN apt update && \
>>>> +env DEBIAN_FRONTEND=noninteractive apt build-dep -y --arch-only qemu
>>>> +
>>>> +ARG QEMU_VERSION
>>>> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
>>>> +ARG QEMU_REPO="https://gitlab.com/qemu-project/qemu.git"
>>>> +
>>>> +RUN cd /tmp && \
>>>> +mkdir qemu && cd qemu && git init && \
>>>> +git remote add origin "${QEMU_REPO}" && \
>>>> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
>>>> +git checkout FETCH_HEAD && \
>>>> +./configure --prefix=/opt/qemu --disable-docs --disable-werror && \
>>>> +make install -j $(nproc) && \
>>>> +strip /opt/qemu/bin/* && \
>>>
>>> For the record, here I included a 'cp <list of bins> /opt/qemu/bin' line
>>> to make migration-test work from inside the container:
>>>
>>> migration-test
>>> sh
>>> env
>>> docker (installed as docker.io up there)
>>> cat
>>>
>>
>> You mean by mounting current folder in the container?
>>
> 
> I mean having the test binary present in the container as well.
> 
> This is something specific to migration compat testing: to avoid having
> issues due to features mismatches, we run the older version of
> migration-test when testing two different QEMU versions.
> 
> But then...
> $ git checkout <old tag>
> $ make check-build
> $ ./migration-test <QEMU old container> <QEMU new container>
> 
> is kind of wasteful. I can simply build a container with QEMU +
> migration-test already in it and invoke:
> 
> $ ./<migration-test old container> <QEMU old container> <QEMU new container>
>

Ok, I see. I'm not very familiar with migration testing, and assumed the
logic was opposite (that migration-test is backward compatible to test
from old versions).

But migration-test is not included in old container, since it's a test
binary (thus not installed). I feel that for this case, you need to
build from sources, at least to get migration-test-old.

>> I'm not against it, but I feel that if we go this way, it's just easier
>> to say "let's use the full base image", since it will become "I need to
>> run python, and X, and Y, and Z".
>>
> 
> I think we should merge this series as is. However if we intend to use
> it in the future for something more complex, something like the above
> will probably come up. Anyway, I posted literally "for the record".
>

Sure, I'm just interested to make something useful for you. If it's half
baked, there is little value in merging this.

Regards,
Pierrick

