Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579B7CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 19:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKLSt-00060n-2H; Tue, 05 May 2026 15:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKLSr-00060e-Qv
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:29:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKLSp-0007Pj-RB
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:29:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645ErA9v248286
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 19:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6yDu7JhbxczH3o3NTLsl2oPNZspuZcK1wSkJJS3a1qU=; b=gPWenWqPS6dZ2nDf
 Mi6Bh7eug5dSVc1KqyoNFC7QyAfW5avDdyg10z9lE/iwM/jSNgAYUrvtPzEHEKxq
 2sRznntyRRM5QsuBxjeSB+DZ3M71WaY3Psb4ZHCQAzWIpv1K4z6GEUngelXTZcdn
 zjcbPCKGkjv3v25N+y+3ptEa30FlPa5ldUlOHgu7XJG3WSGMo0i4JZbQouP/TEIt
 nMxsNG4Dyv+1zJqw/5/OqS/sg99ljL12dY6Zx46yLQwwZNkt1iB460taOiMfcvxA
 tqWxM/WXJbMZKauW2HaQIwE3mL9HhrIRa4qjNDKlvDQr+m+3nzbNiUIBSi5fAzQt
 Iip3VQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyjq4133h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 19:29:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so7499785eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778009387; x=1778614187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6yDu7JhbxczH3o3NTLsl2oPNZspuZcK1wSkJJS3a1qU=;
 b=fL3TarrkPMgXi6ObdH+gA+W7953CKpCJeqdNioUvXvuae5lVwxvLLTxtYmiJ2J0iCo
 fWgVYLh8PeuvbtEm5NIQwKE1KFh0iKUEBhPb18ML5CBw5ZkoqL6XvhtfZt8nS6K0RFf3
 67QYy5++wfNp3bXCxI7mCeSTs81nC5YrLCsjamPPeuNDfLGoxOs6AAhy4nJdX/Rqedqw
 19H5agNdQsebuX2JGfZ+FuuHDchopyxM9Z4rDlFZv56JGHBbnLul8VAlKAlSU120rCPB
 QoQGe6x25XUGhl1FrF0d5DXV/PcZMjGRATwDef9ade+9W6mnyLniwQjnrl+CaSCR+f7x
 tGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778009387; x=1778614187;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6yDu7JhbxczH3o3NTLsl2oPNZspuZcK1wSkJJS3a1qU=;
 b=KLHLs7Vl1tD4OCthUHulHHa66P79QmBaZ0hGg5WHhTVUws6mePlHtPPfw4reqJ79mm
 n1G0f1ygH4068dFEyQ/JzT2LhgrE4PihNtBSNbIe2GflZWPJOOuXgYjYLEzVBh4jtbqI
 h+rONPXk6vIj9bQ8L6uRQEmWgDMDT+d5ss+oHOJWjntFxsCYcPmwBlVLNO3JttbcKKcR
 iAUzDkCiD96vHIDxHUghh42Lzp/66Qx+KgplK/G0z/er5tVpieTPGBvG3mE730fomDte
 Zbr5JFFKom+D3fGTakcMLZIeGeoN55+u8jdIOTxGTWR+6tiPPa8E5xHW/OuwKJgzU1JM
 Ij2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iOlMDv5OIbLdTo3Dve8esGrmNbPNVPqkz/6YtAtiG3P7V6Ex866YExnafNvhrHkXaoWT1dgGB716c@nongnu.org
X-Gm-Message-State: AOJu0YweTUpVfKDaeSF/KcyR1WMwaXZb9PsQdBdwQxOxOsZrrBeijri2
 FZlLJBBax1iN53Opcv+b6lbwpeEkB4v/EIJ3m94jEbaEHnYwURz6Ef+zWkRV2aEfRsdUFq8UHTO
 8m+Bfs4sIo5mOZHlplqjT6nNkayvuWDwAzY25NruXrnkzOmuYOTAuHDJT+Q==
X-Gm-Gg: AeBDiesYlykGdSwlP3IbyEoWl+1Xdeavia7JfiEq0mk6q7FgJr1S/hW92rebUA4TVvB
 O5JQzKr4IUUt8rCWc7M/obJFG4wcaRvbGJ3DR9G9nk41r8XyAAVn8i5lL+TxsvPGOEkMqHrcW1S
 pFJLUPY5LNhi6rm4ufUjwuV62Mg+SrJcQEegk/qFROOBia2L2/OrlX1+aVp2ncFqCxzteyE6zry
 z7OoR0qKhEsWk9Jz1HS48FJrleoW6YIc5idOhrsjpm/8NIRyCs/VI/INdCAwhyJaOQax4vZOWjs
 L13P9Xrg/zDuJFXGeLRrdyjph3T0ZbTMA44TdKF77YqIO1PWebBsqfgeAh3iFtLK4PDwZGiQDF8
 gkWGVCUYNTNDLww3uLDApY8yv36QbNkJirthemoEA3aWX8wMXU6aQTQ8RFkoXMxnbv7n1C9C1wQ
 42Eo5jaorU8Yo7z3hsAkbPKPmb
X-Received: by 2002:a05:693c:2c02:b0:2de:cc07:e83 with SMTP id
 5a478bee46e88-2f549294192mr357881eec.15.1778009386759; 
 Tue, 05 May 2026 12:29:46 -0700 (PDT)
X-Received: by 2002:a05:693c:2c02:b0:2de:cc07:e83 with SMTP id
 5a478bee46e88-2f549294192mr357850eec.15.1778009386064; 
 Tue, 05 May 2026 12:29:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56fd909c8sm55771eec.22.2026.05.05.12.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 12:29:45 -0700 (PDT)
Message-ID: <5fa6dab1-f5b5-4818-ae77-425b6994cc2a@oss.qualcomm.com>
Date: Tue, 5 May 2026 12:29:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] .gitlab-ci.d: Define new clang sanitizer CI jobs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260505122721.429174-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505122721.429174-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MYxcfZ/f c=1 sm=1 tr=0 ts=69fa452c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=Snzr3CObmigFLxGQ5tAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE4OCBTYWx0ZWRfX5nXx7BO6fQCh
 xpv9jmRAhs+QD29aMy0VayXqlPvPFWxjZ0WqYQFKa2H39RWqARJtyn8os93iwO5Z/Af5jEcFbOk
 yQmsT1jyZY+8zdO/cU1X/ILvdaoSwtBnR0roCjgcGnWJAY5Y4XFLbwbfmOxML+oMSDzO9UJIf0a
 X9Spt+utsukO/tErsXZW6UDLPkmlALkuYKy3JqsAfYHjRjZ9Fq7bcAimcw1UJWtfE5ug51dt+sd
 nriQmFWz+8gil6Jq3waa7CPP5bDWGXDt+jD20nZgy+RuYSXEfn1hCaY9G5Dza7YdoZcpYS4RukO
 MJlMpkj8E0kHuOphJNCuZBqd7JhHLJ4evct8NT+kEz4fIKBg6k0OVAEcYyB5f5HbRormPsP11kc
 GTGYwK1iT/iUeSvgVDCNMQfYOe8O9UBEJGmoy3BWpW+wC+CqA/++5jctT51bsC57EIu+5vAuvZd
 +7bbc0xBSi5qRoNwXTA==
X-Proofpoint-GUID: oMAxtyrnWN2_ghaOtzZUi_FlYZoFDtle
X-Proofpoint-ORIG-GUID: oMAxtyrnWN2_ghaOtzZUi_FlYZoFDtle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050188
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

On 5/5/2026 5:27 AM, Peter Maydell wrote:
> Define new CI jobs to build QEMU with all the clang sanitizers
> enabled and run "make check".  The split jobs are patterned on
> the existing build-cfi-aarch64 / check-cfi-aarch64 ones.
> 
> This patch is RFC because the resulting test job times out.  I'm
> posting it for suggestions on how we want to try to do this, because
> I do think that now we're very nearly at "clean pass on sanitizers"
> that's worth defending in CI. (We ought also to be able to do
> similar for "make check-functional", but that has an even longer
> running and also in my local testing it seems to be flaky for
> reasons unrelated to sanitizer fails and which I haven't tried
> to track down.)
> 
> The build job is fine, but the "make check" job times out long before
> it finishes: on the general gitlab runners that my personal QEMU
> gitlab repo gets access to, it completed only 102/591 tests within
> the hour:
>     https://gitlab.com/pm215/qemu/-/jobs/14179464576
> 
> We could have multiple versions that split up the targets, but it
> would be nice if we could build once and have multiple test jobs;
> especially as we move more files into "build-once" having multiple
> build jobs split by target means we're building those common files
> more often than we need to.  But I don't think "make check" has a way
> to say "limit by target".
>

To parallelize, how about structuring things like?
1. Build (asan) for a single (small) target to build common code only
     ||
   cache for ccache
     ||
2. Build (asan) for each base architecture reusing cache.
   This ensures common code should not have to be recompiled
3. Run all tests specific to each base architecture.
   - check-tcg
   +
   - func-quick+func-*
   - func-thorough+func-*
   - qtest+qtest-*

Also, we can run all generic tests with a job 1.b, running after 1:
- decodetree
- qapi-schema+qapi-frontend
- qapi-schema+qapi-interop
- softfloat-slow+softfloat-ops-slow+slow
- softfloat+softfloat-compare
- softfloat+softfloat-conv
- softfloat+softfloat-ops
- tracetool
- unit
- unit+qga

The only thing left would be block tests, which are deactivated for asan
builds:
- block
- block-slow+slow
- block-thorough+thorough

Tests and categories can be found from:
$ ./build/pyvenv/bin/meson test -C build --list --setup thorough

With this, we can even ditch all other testings jobs since asan ones can
be the only reference we need to have.

> Note: to get all the tests to pass you'll need a few patches that are
> on list but still awaiting review/commit (one sparc patch, three mips
> patches, Marc-André's fix for tpm), plus a patch to
> lsan_suppressions.txt that silences warnings about target/riscv
> leaking of hashtables.  You can find those (plus this patch) in
>  https://gitlab.com/pm215/qemu/-/commits/asan-fails
> (the branch as of commit a987eab2ed is what I tested with).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .gitlab-ci.d/buildtest.yml | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 4b1949a3a5..9c73b1a646 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -434,6 +434,32 @@ clang-system:
>      TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
>      MAKE_CHECK_ARGS: check-qtest check-tcg
>  
> +# We split "build" and "check" here to keep the job times down
> +# below the timeout
> +build-clang-sanitizer:
> +  extends:
> +    - .native_build_job_template
> +    - .native_build_artifact_template
> +  needs:
> +    - job: amd64-fedora-container
> +  variables:
> +    IMAGE: fedora
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan --enable-asan
> +      --extra-cflags=-fno-sanitize-recover=undefined
> +    MAKE_CHECK_ARGS: check-build
> +
> +check-clang-sanitizer:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-clang-sanitizer
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
> +    MAKE_CHECK_ARGS: check-qtest check-tcg
> +    LSAN_OPTIONS: suppressions=../scripts/lsan_suppressions.txt
> +    ASAN_OPTIONS: fast_unwind_on_malloc=0
> +    TIMEOUT_MULTIPLIER: 3
> +
>  clang-user:
>    extends: .native_build_job_template
>    needs:


