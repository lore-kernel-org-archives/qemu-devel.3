Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B1C79F85
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 23:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2zMv-0005lF-Od; Sat, 05 Sep 2026 19:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2zMs-0005km-UL
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 19:00:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2zMq-0006nu-Iu
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 19:00:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685MoE1o2917447
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 23:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t8oRNPl1cmk5i3RQNXZJ9dCwCbGbGERIPI2wNJp4lMI=; b=mWqGD94K56MZkc4X
 GELaQ50Xia3lmzdGddTSO8lcvP6p4G0YDINJfCPShLqUuyNQtSzxC1dTyRWNJVpT
 Ba3vb2V1tFAYe9iUUIOoAhvMT8p2phSR1nY19ftS3L4wmaqSbaJxvSCfYH3AnOuW
 f2EY0jYQBA7esTRKSbGD+vdj/ps8k5v04QgWpWpfXP4UDS9nHdddy1+LBNlCypxN
 Cc5GsJBy0t20HYPPw24Mlnd+mUUaSEjlhS/NN7/ePXxtgtqO1VRLsxxZzcaMlODE
 4SIgwnUlNAEWKyosYd48i6CXJ57qfBnLG9pWJUdjl6gw2faWAcehAz1UDNP/4ZG9
 PhTM8w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggcca25ja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 23:00:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso362634785a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788649208; x=1789254008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t8oRNPl1cmk5i3RQNXZJ9dCwCbGbGERIPI2wNJp4lMI=;
 b=PXvPuG0fkm01FgXGLuMHQkh2+iFvia1wUyC7H8OLodk40UzpEhPpOV9GdydALc8cAs
 rY9mLfY6VOkXSyEe7ZdwH4+8npCXnE0thxIBb0VXGxdObBCXo8tnMa2xpGUCSaaVb+a2
 vu51F4PTskxtvJ+rTFctOjCIafXzT6rCxxyMZCJxzuD0+rqgeyW9DzFLdb7V1KrO10Pt
 fmlSO2h4+xc0OSRvQXwW9fqBlqCccIjxQujM3nUzHxLFTbvPY44GudgTmJGjuJDQuHHG
 /4uH7dp0NpH9qKy4izY/afnf7nZ0nf2Sou9TktQnkK0kjC8nQGWywCoTf5p1lEjf5CJi
 p9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788649208; x=1789254008;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t8oRNPl1cmk5i3RQNXZJ9dCwCbGbGERIPI2wNJp4lMI=;
 b=PLhyDDbzuKD0+SANB7VuR9H5PT4ykJO9OHr8Q0nPu8a/dCEiSOezZpwf8wpAiuPjCy
 +RgiW+z4QDDpI4daWsSxXXf/CRBXDlt/N2UoiazC12DBkeBHrAstCtvngptSp2m2isva
 qTtFQWU0eXrV+VUhZ75KaDjcmsQ5l+KIwvyYq3kl++gH3ZdPKqrWVyvBnGq/xbpely2s
 NMecAp96KfnSQxsadUYOXY4TJja53h3LFeTwP4AgT8onmXpVGs//sYE+3EIcdxNlRYdL
 jnEJMvX92raUHgJXljdcoLq6FmLbqqpoFnnW0DNQbEdGFRORfSSeZHSjC4LYlzLGyMtN
 9Ptg==
X-Gm-Message-State: AFuF++nnvxbwakUBoGreZqeyBTrcno+sYx0/ztoTwyXToyb5yGDSmsFq
 svAJ+wz0e51nsf+4jTP3WyOfhedjQVZzCuF+5bp5H9y+A4D9wmRpmkQPCHUNk9xPXXAMVOOT1yk
 8KFjJeIhunxU/0JMt1XHZKPufbPRBFGaCw/xvsP3zT6QT0MnmBiMBhyEqkg==
X-Gm-Gg: AYBFou0WlHIICEDOGemwRZr4Phg8x4ife11YjH0rq8F4L21Fee6n9F9vgh22sjS5VMv
 /SFuQc0zKzA1jNwZBrW2IxxIOGqzX9O5xxwHhSvWxEFpMETSotpvkVpFgnk4wb4ui25xoFu+vuy
 FzSb1j/yWubrGmFhW+MrtTfzY/FDxbGTUPJrke4PGGhLd3mkJUea7WDS9zFyFnlMTiRXUWnwmHU
 MtaPbB44u0B9/xw0z+J8s6TRScuOGJ2vHtYiSu5nfkXrm1d90eDObnPeGWNBl0nQobOLOMqdFvK
 RkwhSBOVEvwezLsqwcfVVly1Lj3W/YAI2msYtSWWgoxnpzHPE9d95H+W6Xum3Fwjt4snzJkkoWG
 l79aAZoO8Nx7CyFPeOCQkmmw8u6k2f1X2jiosTe19PAFgL/d6tH00s7zM7iu1A4xrhxI5wXMf2T
 Py1PlK
X-Received: by 2002:a05:620a:6086:b0:915:a953:4b9c with SMTP id
 af79cd13be357-93980324543mr1424820485a.3.1788649207759; 
 Sat, 05 Sep 2026 16:00:07 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:915:a953:4b9c with SMTP id
 af79cd13be357-93980324543mr1424814785a.3.1788649207203; 
 Sat, 05 Sep 2026 16:00:07 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb36195sm530373385a.21.2026.09.05.16.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2026 16:00:06 -0700 (PDT)
Message-ID: <2551b3fe-02fb-4966-8bab-cbad2ecce2c5@oss.qualcomm.com>
Date: Sat, 5 Sep 2026 18:00:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/28] target/hexagon: add main arch-specific semihosting
 operations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
 <20260902044231.843004-10-brian.cain@oss.qualcomm.com>
 <CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: InsA30FvXhfkEF0_4k36rfXyQozT4Ne7
X-Authority-Analysis: v=2.4 cv=EJo2FVZC c=1 sm=1 tr=0 ts=6a9c9ef8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=AkmwMN0QN9jAmoAwxQEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: InsA30FvXhfkEF0_4k36rfXyQozT4Ne7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDI1NSBTYWx0ZWRfX3VsQCjNTDwpt
 izDUyugP8aNMSVV50QPQ9iupxMcoP+f2taiYtfCMgUN+ExFKtoQftN9yw7TFR7tP1CESsKJc6M7
 RY7+u2PEHcXD+pfs/J3hZU9nFOaRoUUzgEYvu5IS5gNj+rtxUDg++QwdQ5fFJ9HNbCAyjigXQAj
 R5OFEtDwEvteB2sCAEj27yzu9gIDT/dKO8Gc+a4E2frTUzJpZO292ErKokqGQIczjGemoh7fOxs
 HHCjUBCqaEqu4xmMYDZyvD0dCCoeispLhNOGCHAmnUl7iAPErRb1odcGi/SJuj80ecedHu1YR8k
 Zp34UplbIssjTg6iGQDAkZzV4MGy0iC4Hvv0EocPl+qXlOZkwhEUl3RgahvJrztEQnmoHJQ2O+9
 Z/at6EI2XF8CtNn8r6Lyejkrd5SYymFSL9HZJLYYiUHPTpL1+k19jboNtwuRiZeVJsFKEd8WYBC
 Tgv7lHoXgU/Hsuojr2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDI1NSBTYWx0ZWRfX9ymoj1NEi/r2
 i5EbctG+Qi17C3B0OLRTYnRoKFI53Z6S3i3+Y68gLdXuynDU8KsSuk3APKm1IjbG8eP3qHcf2he
 mlX5RsC2Nyv+35aQv12/ZxvmY3qGR3U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050255
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/3/2026 2:55 PM, Peter Maydell wrote:
> On Wed, 2 Sept 2026 at 05:43, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>>
>> The Hexagon semihosting ABI extends the arm-compatible set with
>> operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
>> SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
>> that baremetal programs using the standard Hexagon simulator ABI can
>> perform file I/O when running on qemu-system-hexagon.
> Hi; Coverity points out an issue in the filename buffer handling
> in this code.
>
>> -    /* TODO: implement other hexagon-specific semihosting calls */
>> +    case HEX_SYS_OPEN:
>> +    {
>> +        char filename[BUFSIZ];
>> +        target_ulong physical_filename_addr;
>> +        unsigned int filemode;
>> +        int length;
>> +        int real_openmode;
>> +        int ret, err = 0;
>> +        int i = 0;
>> +
>> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
>> +        hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
>> +        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
>> +
>> +        if (length >= BUFSIZ) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: filename too large (%d)\n",
>> +                          __func__, length);
>> +            common_semi_cb(cs, -1, ENAMETOOLONG);
>> +            break;
>> +        }
>> +
>> +        do {
>> +            hexagon_read_memory(env, physical_filename_addr + i, 1,
>> +                                &filename[i], retaddr);
>> +            i++;
>> +        } while (filename[i - 1]);
> Coverity didn't notice this one, but I did. We read into a local
> buffer from guest memory, so we can't trust that the guest actually
> put a NUL byte terminator in. If it doesn't, then we'll happily
> keep loading from guest memory and overflow the filename[] array.
> This needs a termination check involving sizeof(filename).
>
>> +    case HEX_SYS_STAT:
>> +    case HEX_SYS_FSTAT:
>> +    {
>> +        struct stat st_buf;
>> +        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
>> +        int rc, err = 0;
>> +        char filename[BUFSIZ];
>> +        target_ulong physical_filename_addr;
>> +        target_ulong statBufferAddr;
>> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
>> +
>> +        if (what_swi == HEX_SYS_STAT) {
>> +            int i = 0;
>> +            do {
>> +                hexagon_read_memory(env, physical_filename_addr + i, 1,
>> +                                    &filename[i], retaddr);
>> +                i++;
>> +            } while ((i < BUFSIZ) && filename[i - 1]);
> This one does have a check on BUFSIZ, but if we terminate the
> loop because of that then filename[] won't be NUL terminated
> and stat() might blow up when we pass it.
>
>> +            rc = stat(filename, &st_buf);
>> +            err = errno;
>> +    case HEX_SYS_ACCESS:
>> +    {
>> +        char filename[BUFSIZ];
>> +        uint32_t FileNameAddr;
>> +        uint32_t BufferMode;
>> +        int rc;
>> +
>> +        int i = 0;
>> +
>> +        hexagon_read_memory(env, swi_info, 4, &FileNameAddr, retaddr);
>> +        do {
>> +            hexagon_read_memory(env, FileNameAddr + i, 1, &filename[i],
>> +                                retaddr);
>> +            i++;
>> +        } while ((i < BUFSIZ) && (filename[i - 1]));
>> +        filename[i] = 0;
> This one is wrong in yet a third way: we do check against
> BUFSIZ, and we try to add in a possible missing NUL terminator,
> but if we stopped the loop because i == BUFSIZ, then we will
> write the NUL terminator off the end of the array.
> (This is the one Coverity found: CID 1685942.)
>
> Better still, can't we use the lock_user_string() handling that
> the common-semihosting code does? That avoids all this need
> for tedious manual byte-at-a-time looping and fixed sized buffers
> and potential for bugs.


I'll investigate and fix the issues raised - thanks for pointing them 
out, Peter.



