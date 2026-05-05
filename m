Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675CFCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 19:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKLaN-0007jR-Oh; Tue, 05 May 2026 15:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKLaL-0007jE-AG
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:37:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKLaI-0002RX-LR
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:37:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645IpAJw2187057
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 19:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ztxb2onSbR8G2/qSh15XaIQ2FZ30gUfDz0epDei5Jcg=; b=VSGFXStI+8fdb8zs
 n3mBF+UDmVhgGdZBTtHqf2GlNdlakfxsDvf5esNEVqx0BEUHUFUrFNibthQppXJu
 2cHziQV4/DKk6CsF32iBCWaTAORTrgsp32vdx1nBfVpnNGB1nyTARwZk3lyMDXqb
 H5KCkjaW3UaJMs3DPCXS4u/oIBnZ5LJYzfhJZ7EtQjhkMvn0lliu+g2sKf3Rr4gi
 iCZukyk3t6NUR/kxLd3pClgUCp3AQWXYLzvhOx5w2WNR1gLSIpr7acDLPrAC+k9V
 GZr8SdujsGpUrIq8NwrlMgEKm0uM/ZbXpRsoxPl65z5tqju5yc79mnBrf5/lS5B/
 KFt3Eg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dygce1u14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 19:37:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso5653366eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778009851; x=1778614651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ztxb2onSbR8G2/qSh15XaIQ2FZ30gUfDz0epDei5Jcg=;
 b=ing++xIIq5pBWaA2Ei7TYH6eTlDwbVI3t1/z/ocK6eT4Z8oarlgbn0NDPZ1WVffPR1
 B+z1kZuNqUtHS5NOpW5Fgx2ZrVHSe5mPDF43172G0ELoThID20sZQr61gmjawHoUhSpk
 xeviyCsvK45huEyS3KnPt0qR22nbCr/T4ShGlQYH/EOup0vLt6/lBWAe6DBbCSQGlEeQ
 t/J7B11P1fUcGyrpgmh/Zqjw34JxkaSik2JyJskvFMgvvjM2I0GYe+Q/cyv6vHtjsqDX
 XOCSH8iV8hGFVjsvBOegJ6sl7xbYglMgSgLi1RHTlRDaCD7qdWvsm8Yaxkmy0f51mb1I
 kMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778009851; x=1778614651;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztxb2onSbR8G2/qSh15XaIQ2FZ30gUfDz0epDei5Jcg=;
 b=ahr6mrfOl7GLYd/TBfJv4g4cAEk6phj8gkAPxRRJE6Dqs/leUNyf6/Y8mzbkeDmN95
 7TDwRhj/r1M+kl7xA9pBI9/4iVNTFrkx2re05oWSVQPnyBSKKwrAkPhJBJENxLsc7iJH
 PqL5IkjPuvcd93qGAReHSnpZKcGBR7OscRFwMxu0o5L2WXm7+VzYpxgYrtvIxsNpXdRq
 +R5a/DEGdPWNnsVwSCoTv8+UPsFxHwg8TZhISQ+77jFpH1Z6daGWo6GdMUeQvHd060TF
 1+jHVDduW3CesnsKSVRtuDzXUHsuzcymRgCv/z9UTCtK43GhaPagwUcqg0v7q0lmLhbV
 UQoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hygcWFUpxn/fxS9UsItiz/hi6icxkQ0Vf6PninBWveeZdopGyCuPoBxKcHRW+Scd/j0EzGgkyervg@nongnu.org
X-Gm-Message-State: AOJu0YyQql+d3rlxWBLhiRd423uSAO3Sb4zCTYntpVPTgWOilClk7Zj8
 D/HuhuLsbsSZrBXInHlpGD3QV755P2g2hW0oYAt97DlQUzxfL8Yed9j1JswKpf6E8ZRzEUSvDku
 Dsn9t7/RCgnGIBA8hppskVPgRv5m7pYWFu/JqbuX+0t3j3ZS8qdw5BJe14Q==
X-Gm-Gg: AeBDietn/fpm019JOR3HHa04pwpjGjFU8j116V393fiEnlc9Oz+LW9EmQCD+emrJYZW
 YucKFKTPQfOfRlkMK+r2e8jHmHfOVnm0ytYN5oKg7scKj9OUHu5tbnwsictgCH1juFMOpTghO+c
 JYfHiMdj1wGnrKmK0oO3NUiLrBxlUB5xiZ1irIJACSz3Yk0S3dRu11J/tKg+H4wFOjvx9X9Yy55
 nqFAKj1NeAfbctZmkHK2sZ46CpmgocgPnLCj5f0NQp368+IVutDZSQLuDf3fMs/PK3cqmgo8dJV
 0vU8q+PMn5uU7Cqa8j8YMq0QMTYvfzgCl5fGsylhFeMaYRTEp4PTP3G1Dlx170LnakfisMTSAvA
 WMN+hYQwohBLFSDAjhTP3J1Ah91ljXTryqD+8CZLu2DOj5LOFxVSRTyf/3y/wagwvDzgaF04q0U
 kXhzwZwOMff0T4b8TQekjdbK/a
X-Received: by 2002:a05:7022:f411:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-1319d14f7efmr297041c88.34.1778009850525; 
 Tue, 05 May 2026 12:37:30 -0700 (PDT)
X-Received: by 2002:a05:7022:f411:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-1319d14f7efmr297019c88.34.1778009849810; 
 Tue, 05 May 2026 12:37:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202fbf850sm109263c88.14.2026.05.05.12.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 12:37:29 -0700 (PDT)
Message-ID: <4eef4cdf-822d-4719-84bd-9ca2692f49de@oss.qualcomm.com>
Date: Tue, 5 May 2026 12:37:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] .gitlab-ci.d: Define new clang sanitizer CI jobs
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260505122721.429174-1-peter.maydell@linaro.org>
 <5fa6dab1-f5b5-4818-ae77-425b6994cc2a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5fa6dab1-f5b5-4818-ae77-425b6994cc2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX1T0YYnNoq3Sd
 RUrA6e1OqF/cPkWw17VkuEhPtou2AaBHqHsVyfoAJG2HilSmuqLirYIZZuh9kmOHZ4eu/7AbicH
 HgrrIhzsRQAZNOSQ8ypIck7sc18bPWzr1hhhHe9mH7Wm0aOEgO5ApV1W+f9PGpWe5hcQ3tjj5wb
 uhXX49XMshL8gDCG2PdPA7hVC/71n3Xehb3jdjybRQfdyazBmj2x3AAI8ialUJ2FhQTKj7WUSvt
 LvK8oRA5e0jFWYdMis7xlW/iNiz2E+A2SyFcN0BD0/U5vY1OYhns/gnbH+0RIz7KNKI/idmsA2i
 hQBMvz5x+956utkPLW9AVqs6md35N7JnZCTzImnxWmnM1Z3SRNwLcvSY4c4hsqmQvAChVr7y+w0
 G61tycAfOxysv/LmRxK4QBXii1fnBX7gqbDh3z3BjESNVS5ebRthIfHRyotsDsVlxdH16zHGUh3
 IJW69dLp5KnQM7Ch+xg==
X-Proofpoint-GUID: yKcyaDX0qJyfnSygBetMnGjo_jIoxA-j
X-Proofpoint-ORIG-GUID: yKcyaDX0qJyfnSygBetMnGjo_jIoxA-j
X-Authority-Analysis: v=2.4 cv=b6KCJNGx c=1 sm=1 tr=0 ts=69fa46fb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=G0XXArCSDt67mUo9M-8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050191
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/2026 12:29 PM, Pierrick Bouvier wrote:
> On 5/5/2026 5:27 AM, Peter Maydell wrote:
>> Define new CI jobs to build QEMU with all the clang sanitizers
>> enabled and run "make check".  The split jobs are patterned on
>> the existing build-cfi-aarch64 / check-cfi-aarch64 ones.
>>
>> This patch is RFC because the resulting test job times out.  I'm
>> posting it for suggestions on how we want to try to do this, because
>> I do think that now we're very nearly at "clean pass on sanitizers"
>> that's worth defending in CI. (We ought also to be able to do
>> similar for "make check-functional", but that has an even longer
>> running and also in my local testing it seems to be flaky for
>> reasons unrelated to sanitizer fails and which I haven't tried
>> to track down.)
>>
>> The build job is fine, but the "make check" job times out long before
>> it finishes: on the general gitlab runners that my personal QEMU
>> gitlab repo gets access to, it completed only 102/591 tests within
>> the hour:
>>     https://gitlab.com/pm215/qemu/-/jobs/14179464576
>>
>> We could have multiple versions that split up the targets, but it
>> would be nice if we could build once and have multiple test jobs;
>> especially as we move more files into "build-once" having multiple
>> build jobs split by target means we're building those common files
>> more often than we need to.  But I don't think "make check" has a way
>> to say "limit by target".
>>
> 
> To parallelize, how about structuring things like?
> 1. Build (asan) for a single (small) target to build common code only
>      ||
>    cache for ccache
>      ||
> 2. Build (asan) for each base architecture reusing cache.
>    This ensures common code should not have to be recompiled
> 3. Run all tests specific to each base architecture.
>    - check-tcg
>    +
>    - func-quick+func-*
>    - func-thorough+func-*
>    - qtest+qtest-*
>

Steps 2 and 3 being ran in parallel (per base arch) in case it's not
clear from my original message.

> Also, we can run all generic tests with a job 1.b, running after 1:
> - decodetree
> - qapi-schema+qapi-frontend
> - qapi-schema+qapi-interop
> - softfloat-slow+softfloat-ops-slow+slow
> - softfloat+softfloat-compare
> - softfloat+softfloat-conv
> - softfloat+softfloat-ops
> - tracetool
> - unit
> - unit+qga
> 
> The only thing left would be block tests, which are deactivated for asan
> builds:
> - block
> - block-slow+slow
> - block-thorough+thorough
> 
> Tests and categories can be found from:
> $ ./build/pyvenv/bin/meson test -C build --list --setup thorough
> 
> With this, we can even ditch all other testings jobs since asan ones can
> be the only reference we need to have.
> 
>> Note: to get all the tests to pass you'll need a few patches that are
>> on list but still awaiting review/commit (one sparc patch, three mips
>> patches, Marc-André's fix for tpm), plus a patch to
>> lsan_suppressions.txt that silences warnings about target/riscv
>> leaking of hashtables.  You can find those (plus this patch) in
>>  https://gitlab.com/pm215/qemu/-/commits/asan-fails
>> (the branch as of commit a987eab2ed is what I tested with).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 4b1949a3a5..9c73b1a646 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -434,6 +434,32 @@ clang-system:
>>      TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
>>      MAKE_CHECK_ARGS: check-qtest check-tcg
>>  
>> +# We split "build" and "check" here to keep the job times down
>> +# below the timeout
>> +build-clang-sanitizer:
>> +  extends:
>> +    - .native_build_job_template
>> +    - .native_build_artifact_template
>> +  needs:
>> +    - job: amd64-fedora-container
>> +  variables:
>> +    IMAGE: fedora
>> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan --enable-asan
>> +      --extra-cflags=-fno-sanitize-recover=undefined
>> +    MAKE_CHECK_ARGS: check-build
>> +
>> +check-clang-sanitizer:
>> +  extends: .native_test_job_template
>> +  needs:
>> +    - job: build-clang-sanitizer
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: fedora
>> +    MAKE_CHECK_ARGS: check-qtest check-tcg
>> +    LSAN_OPTIONS: suppressions=../scripts/lsan_suppressions.txt
>> +    ASAN_OPTIONS: fast_unwind_on_malloc=0
>> +    TIMEOUT_MULTIPLIER: 3
>> +
>>  clang-user:
>>    extends: .native_build_job_template
>>    needs:
> 


