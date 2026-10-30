Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAF606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j8TGPM8d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MelSYRnf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpZV-00075m-CM; Fri, 30 Oct 2026 12:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMpZM-0006yI-Py
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:35:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMpZK-0000hS-RN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:35:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UES6de3208994
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RVjxeLkqmxw8BAOaWrctZYm9h9CMJ6qEl3VQMKy+8KI=; b=j8TGPM8dzjiRBwJX
 6+4Oo+PhQuyuuPiZ7OrZZAiMXYD4H5tGBv9b3RSSseUAQEA1ym1PjRn234Z0W6dX
 bcfZNIcckzDfNm/nHTNJtKkPqpDiTqGcgJG2A0HM0A+O6NcEEvh777AYHPA/gifA
 xzWR4LYAjtCdlnu3j0clRi05PJMRlWSzR+3/xf1VbXLh0zgNoTR9O4e/3mrFTulM
 0LlvX5Khh3R3rnrqji+bqQV3tKrb0xcLgfVGGURk+m3CJPghqKsCl8Hq+lzMLfVj
 m3n433ip2XYPPvTQUkiuVnfJve3cgVC89T9o7bYjArO/IW51oJGCzPE9g6TUsnDJ
 ITAXYw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm110-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:35:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso2207647eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793378103; x=1793982903; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RVjxeLkqmxw8BAOaWrctZYm9h9CMJ6qEl3VQMKy+8KI=;
 b=MelSYRnftaY9OitXpBU8PU26dPD83d72d0CNsTgxq4Mc5rPVtNcZuRvwj6hweXHiPZ
 UEG8FSDuiE/u9HRUIJcb45wZZSsdr2zxrEuhFKxhx1rqt4qVQppx8QwsK6yTYqALNgsV
 pYwYHLbf0QsUHHQN9nB4hFVQYYvb8c1g6gkyoQ0qsQuxFUOAgC44XtX1EAvlBlgH4c7q
 MKswQDtOk+kfZmqZr6tPlCsxv+hx/6+jIUPO/8zhutRplVawL3NgaevzmIV/vsK/rQAl
 TWp3KBiloqrf75mgpUk53cEEVhxTnoKXS2DE31ulv/93DfaSTS3655k++QtuLJN/3Bxu
 VNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378103; x=1793982903;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RVjxeLkqmxw8BAOaWrctZYm9h9CMJ6qEl3VQMKy+8KI=;
 b=lUjdDqFy5hCb0Si+CJAl+6lmnXf1Z+qzDLBWRVWcZeTb6c6ue1kmLk3u8ddCVSF/vy
 Pk5B0x3qhXd4Mg662ztUF+IxP5y8tEcEGpEqg6ByZp8FfPA1+6i0+SpEX5j6YsFuV93C
 FlPrrFw0kgKRRFSksbEwyAaHFYKN7i1yOj7RVo/duVUmOi3i9UTUJzomSE4wMNizKx2k
 ZvP0KMIO5WzM/3F3AgPPQGzRgDsc/ZsRSLGE6yzqNOVv4MHKuVUzItEMILIUQSSGFcEt
 tTUn+2f0FZjWfXtdLUYxDku9gVgBpkAJ5JsfpScKanNA7QMYG8ZQNF5u/UED30XMOAZ9
 heVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1oIaYuORr6L/vd+TyTAVI3dmL2x37Mq8fZlGywFuol5+22G0MW6kA0iwolOpjX3qVU6aZDgOaDQA3@nongnu.org
X-Gm-Message-State: AFq9FYJ5vns/Qob7WSfA31W/oljgObX88N3pgLZb6uygGnsWQa60NkFe
 F3mJxf4B8g9DVC2Kz60RMSrlYCyeHAT6yy812Uh83PilHXGNiLtcQNwQ3rZJuRtnbffkV3hZ5vH
 3IzZuBEtKs6seaRVGCOicZC4DyIxqp/MdqPHb+eMaw0qstH7smI6ma3DSDg==
X-Gm-Gg: AYBFou2IihhDEtXheT4sffL7xmvAmQQ2klRYiDgSbFep+pkYJYIJ6FbBytncSzH2q6Z
 JbLTjJ+9PgNz/nHFT86byxqQlXT9MwbwNc+ZWLtaS22s/Ey91RtHa6Z5BXQmHMMeHx8B4mVT2K5
 YP4fzlA6iyg1y8E5nnPtdjKmOMMJ0O6vWR1uiaUhoagWNhNCFgvTfW9lFisQYYwAWluP+1Wb43n
 ISnoltk4hQTKw985PFYWhPb9Ro+Y5cb852B7cqMZnjMSb+dGMbZUZWoLdAf/1BrxMh6lRgjDzPh
 tNuV+ZVNdryS0GCSd54M/LGCQUGWxXd41RCqPo5uRJlFW0F+vFW2uW1vVaMSF2BOwb21VEqhkkJ
 iWXLb7e+BlujWpca16fyvYVL3/nbH9miUiLv39Ht7wOLN3mHkMqPkvSJy74aNr1KTHbztrTnAoF
 Yv9u9G5YR5BmNQfBEzbIYxvMKcM8mC7/MtMfVpBEBd2QE=
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id
 a92af1059eb24-1ac5b9cb040mr3983246c88.26.1793378103218; 
 Fri, 30 Oct 2026 09:35:03 -0700 (PDT)
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id
 a92af1059eb24-1ac5b9cb040mr3983196c88.26.1793378102485; 
 Fri, 30 Oct 2026 09:35:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c27cdsm13505532c88.10.2026.10.30.09.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:35:01 -0700 (PDT)
Message-ID: <6c3de71c-d2fb-4c8b-8e86-f206f7d5fff0@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 08:35:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tests/docker: Add the mips32r6el toolchain
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
 <20261029174434.27985-2-philmd@oss.qualcomm.com>
 <474cb441-7d8e-4bc0-933d-8cae08e98aeb@oss.qualcomm.com>
 <f65ed1e5-10b4-4610-8981-6fe4d9499090@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f65ed1e5-10b4-4610-8981-6fe4d9499090@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4c738 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=ZOE9s65IINkYR6HpnngA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: TQHecRssmax2UvhWviZRJC8SkQNcAKfY
X-Proofpoint-GUID: TQHecRssmax2UvhWviZRJC8SkQNcAKfY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX6jPb2hMBskmf
 B2oTM7LDwIBTM5TD8IEOkRLcSSVkq3nj0gPbkQL9N1YBwlVeF02z7k1aeGftC1CYtCmDL7+P1Qo
 XBaZrBguRyvDbbLa8gqr09mAFYLbTlGWCSuIbQ0IN7bFVFljU0p2opYZtNZwm12Ay0iJ/vWxS5i
 KjVKyAjQTwp9Ah68d6pbuVcrHht0454HSxSJost4dXFVlZS6CTqTp8aOCEWE6JxvpMp+QoHvYmD
 yjR8KHrNsaPTgUKUnrFewVSYXY7qrVo7IH3dHfrFMXc/acueuhkV3TQrqPT3dGIHwonJ08rRXvP
 4TX6MeZJQLhw3gEnvwYeciWAZpkU7z2mi+UlORGODtlhLY2VEleZVQW0evAL+STM+V2bNUg3IUV
 zQOkaVf51mrkkEnnzKZDQhx6DPrSLn0RYAmprmSAZHkzw7tnLAfPcr/jQqQg6dZJdf9PaVFxpc+
 u+KTVsFHBmph1PAOEhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX7W+4w62ZGUDO
 IgZLPQHLHsADTH7JdIz7JqfuDzifr0jRjCBE/TIQFDC3+JzC/oshdKmnAs4xiP9+t3cuC6dfLWA
 4VT5Jb8vPaytlDZp8gaG3JINHfT4n9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/2026 3:18 AM, Philippe Mathieu-Daudé wrote:
> On 2026-10-29 20:27, Pierrick Bouvier wrote:
>> On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
>>> Similarly to commit eaba84a5e1c9 ("tests/docker/debian-all-test:
>>> add mips32r5 toolchain"), add the Bootlin mips32r6el glibc
>>> toolchain, renaming its mipsel-* binaries as mips32r6el-*.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   .../docker/dockerfiles/debian-all-test-cross.docker | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/
>>> tests/docker/dockerfiles/debian-all-test-cross.docker
>>> index eefc03c49a4f..d0e59df84ebc 100644
>>> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>>> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>>> @@ -129,6 +129,19 @@ RUN apt update && \
>>>     rename 's/mipsel/mips32r5el/' mipsel*
>>>   ENV PATH="$PATH:/opt/mips32r5el/bin"
>>>   +# download mips32r6el toolchain from bootlin, and rename binaries
>>> who are simply
>>> +# named mipsel-linux-gnu-*
>>> +RUN apt update && \
>>> +  mkdir -p /opt/mips32r6el/ && \
>>> +  cd /opt/mips32r6el/ && \
>>> +  wget -q https://toolchains.bootlin.com/downloads/releases/
>>> toolchains/mips32r6el/tarballs/mips32r6el--glibc--
>>> stable-2026.08-1.tar.xz && \
>>> +  tar xvf *.tar.xz && \
>>> +  rm *.tar.xz && \
>>> +  mv mips32r6el--glibc--stable-2026.08-1/* . && \
>>> +  cd bin && \
>>> +  rename 's/mipsel/mips32r6el/' mipsel*
>>> +ENV PATH="$PATH:/opt/mips32r6el/bin"
>>> +
>>>   ENV QEMU_CONFIGURE_OPTS=--disable-docs
>>>   ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-
>>> user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-
>>> user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-
>>> linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-
>>> user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
>>>   # As a final step configure the user (if env is defined)
>>
>> Would package mipsisa32r6el-linux-gnu (and companion libc) from debian
>> work instead of this one?
>>
>> I added mips32r5 toolchain from bootlin because there were no matching
>> packages in debian, but I think it's better supported for mips32r6.
> Indeed it works with the Debian toolchain, all the tests pass. The
> only difference is Debian packages older versions (GCC GCC 14.2.0
> vs GCC 15.3.0 for Bootlin and glibc 2.40 vs 2.44), not important.

No problem with this, that's a better choice since we don't introduce
another external dependency.

Regards,
Pierrick

