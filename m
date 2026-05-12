Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7AFCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpJI-0006Mq-GF; Tue, 12 May 2026 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpIs-0006Gc-G7
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:45:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpIp-0000GH-Vy
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:45:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CChP5b1410916
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gsUVGw6tVv82+Saw/3gCCIZm8cSovGohEr0ixLvY6cU=; b=F5pTTkzITnQiYGkT
 k/GWqscLQb+NEJYhvcgXxwOSudqHvOmoIeOF2uCks3qMGv3wB2bbfrxqKhdFQ//Q
 e9vWBrots5KXd+qMbIOE/3OObv7gZGWquRrhtNPcyKAlGWMFHGQ48eKWyT1GwI9y
 93nbzijHDkqFwYcbpTiAaQtgWPT3pFDJeEGu+R3+RAbZ8gsqqeiSXaY3ww9mSobX
 AyQpNqKr55T+cPw3aN0dV+mvy3m39K1ti9Ekb2Ww3Zb1DbC3ELBUltWd2vBdWUv4
 o5n8G5T5jMuwJ1YqWLQ8HVDiQ15g578UXgVxEYiXHoTqvQRKd42427A1R+zIfiDt
 o3tu1g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f30pmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:45:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso4431715eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600746; x=1779205546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gsUVGw6tVv82+Saw/3gCCIZm8cSovGohEr0ixLvY6cU=;
 b=Qzq953m4O5pJHxTu6IJeJmiY5zgAJled84JQf9yvCFGvrO1naakrMxkSGvOVxPWX/n
 R3DDRIu/jBWGGGNXYqSzgd82KGnFKmbJOBTXvg6Z2lhptCZpA2yDY4oJ4HJPayHxyKlu
 86Hfwx5vkGFW6ZjOAJGR7GjiO0Yx1O8G9D5lfzzD225d2QNnqZudd9z0RVVMVlzsVjqZ
 l/8mi5voNG+db1m3+aJZUtyptNfr4RVDcuJSXrQvEcswPdU632QHH+3rplqwLRm1sx6q
 JX3CH9g4/6IBnohCG1skY3AnKHOgmkSwBofxNpPq0RL17L/oA3T33dH7+/v6WBPM5nz/
 o8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600746; x=1779205546;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsUVGw6tVv82+Saw/3gCCIZm8cSovGohEr0ixLvY6cU=;
 b=PMGBhljic9+BkfUQNIsO4cuWxtHM1cvqjiUqmxGlzyiNJp/+cV2DaoRNwmJ42IJmfQ
 I+0Wxx58UQfcYFzi1WZwKgf1pOA8Ojv1XoD2r0tW4sbx3Q4uLvAYoP20mWvZrBMmeqNd
 hf8fbpbTpufktrSPvb3sxggPeu2LHb26TfaVHPs+vfvIyjKlRTCR+UGWE3bIXrkIxyqB
 tdVj/QIspiL+FbFxATfKqJiUcpx7xPdUhNsW3r2xqYzD3q4KFiUtvrh9UkKd6S2o8S+3
 SCkwhZxxpq8nYjReO3pwOMMSO3BHa+VGLhkLHhPxLzZBbBHOM+Eu09JWINvJZ6n/za84
 vIFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9inON0eG96P52GMXETPJuverUsURbs7cD162pr2pLDwU8mMvLvXYs1apARfCF5ADj/2iWLXxhtfnlc@nongnu.org
X-Gm-Message-State: AOJu0Yw+jAya0vkibuWTKB7Ch0tTxX9COL+Yiv+WhkdIL8mu5jBJQgyN
 JNPs5voXpl6dNMqeHkJgoj8WeKiTh7mK3We6ceOOPWp7CS0a9914htb0jZkx2G2cApbrkWFQaqX
 h7nDzVyXdXMlzi0SYXh9hmm0ycQw8PmW3yhGEPn1O9OKTuXMQyTDwgpO8YA==
X-Gm-Gg: Acq92OEo7XSjx9s5mahDs9RheNhPJqAjbyBQCVFTWqBfbAuzrCVj1ipdHLopImw0XxC
 7ROqgsqr8p+v83Crn+d/DFH54HfyD8QTuG58OdV3zVCVInojXh27ceGnFSD++jn8/4YjVK5XA+c
 i1HoywxLgZcWmHXNVqhfSEPdMYC3jzlH+lydlHcDxgaJ0AAgVtqI92dIksBlroSeFJKjZPMl4wK
 W/DTWDwwWQFeVGWhJNFiCDf7rkAkrGQHtka/9eCkBWNk7BKMEOSnBTQASJeRuAl5fiGoMzSHK2a
 BrcR+eNn96D6eDA0iJf0gi50z9LiAONLM1A2VUqXMEvYDABe3UppLVO62UrCKltuEcsu8Q+aC0d
 EPBfagIYRrrqw4xTnfj+kXYILkwCJ2bsJ2j5oQ8QeK1SNagvY8/FKtFhekhenP2goR5bIcI1qOQ
 Fa6dwMaQwL8AlguA==
X-Received: by 2002:a05:7022:523:b0:12d:b8e5:5d6 with SMTP id
 a92af1059eb24-132a83f76f2mr7242313c88.24.1778600745535; 
 Tue, 12 May 2026 08:45:45 -0700 (PDT)
X-Received: by 2002:a05:7022:523:b0:12d:b8e5:5d6 with SMTP id
 a92af1059eb24-132a83f76f2mr7242287c88.24.1778600744862; 
 Tue, 12 May 2026 08:45:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13278210ff2sm19692791c88.6.2026.05.12.08.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:45:44 -0700 (PDT)
Message-ID: <170b791e-ee66-4d7a-80d0-5c959c9ff359@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:45:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] scripts/mtest2make: support optional tests grouping
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-8-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TUwCuYE80FoiwouOq2O_ywEgmX7jollW
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a034b2a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oFKfEV3VOaf3XY432p0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2MyBTYWx0ZWRfX9uLC+Qk5p7Yz
 jstBWeNm30HAsZWXGNkuvyoewPvfTUR1VZt/nVi4FKxKCJrpHgR/P8DIyVHXECuSCrPkjzJH5Zv
 902IJxOEi682bV+ldQd/WcHSc0JZw6m1IEwJgWA+PpcTC7FfelsCyXk7CNJi0cy9N/Kihu+XRBs
 +E7aviLOMuseBhWulNEMawnINblTEV7EkhZlwuwf3RA1G2tQvfWO/6DFD4HI0SBepmsgcbgfUEM
 yl1C9gi6Lr3ihQfCDD4Zgo9CgZInYIEQ+LIbN9jZpXxju3a+QHxNg6DgqayI/Kn+UfuNB6XwMix
 TQjBFum17Q690WoCMj+6IcJKdCZauBMP9oSotht/i5qR03EMKcd0zRwclI1TnmCpZgvh3h/dEuG
 uu3Y6/p4POayZdFvlguKoSnDgfRsEDfzB3WsXTJaMKTjiH2e+xB0SQXf5FJeauQQhBGRitvvebA
 Vu8ltqfGwgKb6H30hHA==
X-Proofpoint-GUID: TUwCuYE80FoiwouOq2O_ywEgmX7jollW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120163
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> Currently tests can be classified into three speed groups depending on
> whether the meson suite name ends in '-slow' or '-thorough' or neither.
> 
> This gets turned into make targets that match the name of the meson
> suite, with the speed suffix stripped. e.g.
> 
>  * suite=block ->  'make check-block'
>  * suite=block-slow -> 'make check-block SPEED=slow'
>  * suite=block-thorough -> 'make check-block SPEED=thorough'
> 
> The set of tests under the "thorough" speed, however, can get rather
> large and it would be useful to have a way to expose further make
> targets for directly running a particular subset of tests.
> 
> This needs a way to run a target without requiring the SPEED variable,
> while also not having them enabled by default as if they were 'quick'
> tests.
> 
> This modifies mtest2make.py to support this idea by allowing for a new
> suffix '-optional' on a suite. When this is present, a correspondingly
> named make target will be created without the '-optional' suffix which
> will never be run automatically.
> 
> This is intended to be combined with use of other suites. For example,
> a single NBD test might be added to two suites, 'block-thorough' and
> 'block-nbd-optional'.
> 
> This would allow running it as part of all the block tests with
> 'make check-block SPEED=thorough', and as part of a standalone target
> 'make check-block-nbd'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/mtest2make.py | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index 915f02d600..383ea68b16 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -22,7 +22,7 @@ def names(self, base):
>  print(r'''
>  SPEED = quick
>  
> -.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
> +.speed.quick = $(sort $(filter-out %-slow %-thorough %-optional, $1))
>  .speed.slow = $(sort $(filter-out %-thorough, $1))
>  .speed.thorough = $(sort $1)
>  
> @@ -66,10 +66,15 @@ def process_tests(test, targets, suites):
>              s = s[:-9]
>              suites[s].speeds.add('thorough')
>  
> +def target_name(suite):
> +    if suite.endswith('-optional'):
> +        return suite[0:-9]
> +    return suite
> +
>  def emit_prolog(suites, prefix):
> -    all_targets = ' '.join((f'{prefix}-{k}'
> +    all_targets = ' '.join((f'{prefix}-{target_name(k)}'
>                              for k in sorted(suites.keys())))
> -    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
> +    all_xml = ' '.join((f'{prefix}-report-{target_name(k)}.junit.xml'
>                          for k in sorted(suites.keys())))
>      print()
>      print(f'all-{prefix}-targets = {all_targets}')
> @@ -83,14 +88,17 @@ def emit_prolog(suites, prefix):
>      print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
>  
>  def emit_suite(name, suite, prefix):
> +    tgtname = target_name(name)
>      deps = ' '.join(sorted(suite.deps))
>      print()
> -    print(f'.{prefix}-{name}.deps = {deps}')
> -    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
> +    print(f'.{prefix}-{tgtname}.deps = {deps}')
> +    print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
>  
>      names = ' '.join(sorted(suite.names(name)))
> -    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
> -    if not name.endswith('-slow') and not name.endswith('-thorough'):
> +    targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
> +    if not name.endswith('-slow') and \
> +       not name.endswith('-thorough') and \
> +       not name.endswith('-optional'):
>          targets += f' {prefix} {prefix}-report.junit.xml'
>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
>      # for the "base" suite possibly add FOO-slow and FOO-thorough

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Not blocking this patch, thus reviewed, but I think it would be a better
abstraction to use meson suites for this (a test can be added in
multiple suites), instead of adding more clunk to makefile layer.

Regards,
Pierrick

