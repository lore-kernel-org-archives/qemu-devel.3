Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73095C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Gsg-0003lP-CK; Mon, 14 Sep 2026 20:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Gse-0003kc-8E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:18:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Gsc-0007ec-44
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:18:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxl9P1984420
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o62Ys5YNlBz0uQNEq6FhQ2VZRL7QOzsQ1bzMkmrr+Fw=; b=n84HNHYBovdQhntz
 7u0GEvcVx1ls8OM4l/u1CwDZ33RvlWgLT+Ti18+NpdK9shE7fggQ3hDmsVpkwo4r
 /YROQDRAJasfqzqGyUbDwtxE8XGEkj74QZLuC3opX/WcdG5C6R95J+1Hb1eXamJN
 OXxa1gYVi2l8V8qgUk/sSHx3p8HmibcW8tauBUe/MYhqynhSZrfz0UnBvcwb8SRx
 tOGiIZMAHSiV4O9A7kV1cOqZYOTIwkb3jAgbKghcwf0lQxV37j+hkH6NUhh+LGgn
 HDysH6OQDq+QA/8MRKNOP9N+/eunlXkv3Me2qkQmwEfifdIb6gdrllgcT/UOsmv+
 ZjhHow==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet18bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:18:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so581467a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789431510; x=1790036310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o62Ys5YNlBz0uQNEq6FhQ2VZRL7QOzsQ1bzMkmrr+Fw=;
 b=GD8+isUJHBzylmD27GiVJsJGpaS6qHojuMSGstsnvEQUUiW2g9qvWBfaI7NYv1yG1f
 HPyaQWxyhdxB+/YvnWp2YVNmZPRtWxSapPpZ6c74T1TqEKivaViLTEIN4e7JishfyNb+
 DvxTbMN0D+ml8in/YDY1Ysu4OsF3kXfM8LiC6RWZmFQTKN6k+taPmcz6qstAep2ve/Aq
 rBdyx2a4ZNJ3qxJCOIZJXzsjcGToHnASCxushEdk9b0thS+Hn63SBVgia1B/vZlqiAYt
 U1wxx7IAjtxejPGrI+abmhOLaoCqhjVb+BzVFZtqyM2Iqyfp8P3wv76LR15hMMfQAiHh
 SSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789431511; x=1790036311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o62Ys5YNlBz0uQNEq6FhQ2VZRL7QOzsQ1bzMkmrr+Fw=;
 b=rSo8JuPmwyHzVJ1/cRHRZ2jq50S/nv1QWfHWSttJgF3m2iwH54ySPMb5sWoFWFUqMl
 GVGSR7VrCSOpDPImBTP0gDWmPntRFdo6/LgZXIqgtbQ2FfrhvE25VnG82q/jQ37Vuymm
 vnZb+k5o6sV/L2iMndx4lYjwff+ZnO/xc0vz3uju/FbvV9h+aQya3aHfnMR2Q/iZLPxH
 vTDnbgLXSKoLdKsXA507GKqlmoJzSSihSrEOjA5Y6t2bSbLIMy9OU/brmHJrRCUDlZ4j
 Am1ZQmVLUdblNVOKYxrYWvJQvDP2idXmg+7K9FYMAd7Fx4WePWVfyo3E0sMq5UFlb+Da
 LDUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPLhJtoPXi4v7xPgL20q2JkpNQm2zfXYts7JoqHxN2c5Ql322oer/dmUGIPn+AKZVBfLTB6aFD4iOt@nongnu.org
X-Gm-Message-State: AFuF++n5JmS1//sJeY94Q6DrQdOZSBTr7qYkkYDxnuqw6xMaqNXBa0b7
 W/z1TEHWlWzdGWeWMyfUpsucFVrAta8w+08xFgxpLK0jXrN9ZW+dmpcKnXyqxRG26NoIpV/i6AP
 XtK6vvhiRoG4q1ft04UgbXFQUxBh1pOu5eV7hdTOWhWFCINWCFiEA0YFnVA==
X-Gm-Gg: AYBFou1QXYNjQnThXRLuM+rqJKwhO+HwdkmDVO0Yyp6CKS8C1sriz58HwQI5hPmuTK/
 oCJMILAki2CSpT+C3LOHu34YcC39ViUWzZwhW13HGlOCUv1cbCwSQoe2P/6bMQ6UW/Goe7+KOlW
 eYG4Z1ciIN/AJmkQhj0NhMyjM4owwSStsSc7L8YC7hcOJenW27Yt4+txIZAlhw85aDwnGQkroCI
 73laD+QciPxjMOw9jjfl9eVb/ZAB6pl4kJfFuSrK404NLSQzwd91bBWJIlxygE9axxOpEf7L+HV
 qnXGB0SL9yvmg/rH3tRHbLkLj45p63L2rTP9j0cdw3DMX+Te52M/sDJKOpo6bWDba2WgCAVnvkP
 9MWr3B0BWF9F7BTHvTBGX4WGEOSUoWETvMRj8E0lnuKK9soGywTHhcdWHkQx4Bd6S/xbt
X-Received: by 2002:a17:90a:d44d:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-39dfe187ee6mr2594029a91.16.1789431510438; 
 Mon, 14 Sep 2026 17:18:30 -0700 (PDT)
X-Received: by 2002:a17:90a:d44d:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-39dfe187ee6mr2593996a91.16.1789431510037; 
 Mon, 14 Sep 2026 17:18:30 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f06423sm33636387eec.20.2026.09.14.17.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:18:29 -0700 (PDT)
Message-ID: <3a1e2293-7390-4aee-bf36-c8ee77791643@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/s390x: Restore the SLOF libc include path
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260914235113.272992-1-iii@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260914235113.272992-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwMiBTYWx0ZWRfXzEyxGZTgS5YT
 UO8/7jyNWrxheulfDgSLR2yGxk2y0HgCXxUbvLhpql2s6sOhtsPYCXwNeMEcClsrPQSsmniIYXs
 NS7TCp2Fs8ncqjq48wPcj4nWtmeHzj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwMiBTYWx0ZWRfX433AblX84cx5
 +moL17nh6UiXRcObgMHLjupTgJtWJpbbo7yysHv20kE/Xp9qLvtYHjS3qBb2x/WSZ7ivMBLNB51
 pl0pI8S5kDB5eNrB/v7KfNWVq3BYU3KU4wYRvCH7fcrC1EBKSxL5xVuidXXYd3d1Zg8Huzmd9vo
 k/B/wFn/OyniBaEv4iO6Iin6Byr/NUNr3+4QzjA5B7I87R08fK8StMEPNY2XqTdloqapaf/0dAb
 Ub1fsbuIQrx8/0E3NGPySijwTijwwQLerGkS+iWT1Hke9hsxmDrvADJ06Zd+/YDIaeX0FFCGAIG
 8jfHblZnAHS2RY0CnGRfnrmj10+8Q4fLxINBYQMdZxFqnOYtxm7tkdB7O4r955NCPneL8e9dE2A
 PZyjjBEyNcYBL1OwFHL1QgbY+QwzIgOHNKPkecoIE+jGdNvEThTr98JsZiW1eraF7Fk5zT2sCdD
 pq3308fMEIozPRFpywQ==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa88ed7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=GaQpPoNlAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=RsrfAPnzSv9tpYPlwikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: liu1RVXTRk-Mwz2JWTBlW_hnSXDE2um0
X-Proofpoint-ORIG-GUID: liu1RVXTRk-Mwz2JWTBlW_hnSXDE2um0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150002
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/14/2026 4:51 PM, Ilya Leoshkevich wrote:
> The meson conversion dropped the SLOF libc include path that commit
> 3fa010d5317 ("tests/tcg/s390x: Use the SLOF libc headers for the
> multiarch tests") had added, breaking the build on systems without a
> cross-libc, such as Fedora.
>

Would that be possible for you to post the exact compilation error?

If that's a missing string.h header, we can simply add declarations with
implementation we provide here:
https://lore.kernel.org/qemu-devel/20260904124604.2207440-86-alex.bennee@linaro.org/

If there is another missing, we can also fast forward what's needed.

s390x is the only arch having this kind of dependency, so it would be
better to align it with all others and ensure tests are self contained.

> Restore the include path. Add the logic to check out SLOF libc.
> 
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Closes: https://patchew.org/QEMU/20260910100120.2076092-1-berrange@redhat.com/
> Fixes: cd81cf86834 ("tests/tcg/s390x: system tests")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/s390x/system/meson.build | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
> index ca07f503058..26f47d4184a 100644
> --- a/tests/tcg/s390x/system/meson.build
> +++ b/tests/tcg/s390x/system/meson.build
> @@ -6,11 +6,13 @@ link_script = files('../softmmu.ld')[0]
>  head64 = files('../head64.S')[0]
>  console = files('../console.c')[0]
>  ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
> +slof_inc = meson.project_source_root()/'roms'/'SLOF'/'lib'/'libc'/'include'
>  cflags = ['-nostdlib',
>            '-ffreestanding',
>            '-Wa,--noexecstack',
>            '-I', minilib_dir, minilib_printf,
>            '-I', ipl_inc,
> +          '-I', slof_inc,
>            '-march=z13',
>            head64, console]
>  asmflags = ['-nostdlib',
> @@ -21,6 +23,11 @@ qemu_args = ['-display', 'none',
>               '-serial', 'stdio',
>               '-kernel']
>  
> +if not fs.exists(slof_inc) and get_option('wrap_mode') != 'nodownload'
> +  run_command(meson.project_source_root()/'scripts'/'git-submodule.sh',
> +              'update', 'roms/SLOF', check: false)
> +endif
> +

If we can't update the submodule, we should probably not continue further.

>  # Multi arch tests - add cflags only once per src
>  multi_src = []
>  foreach t: tcg_tests['multiarch-softmmu']['tests']

