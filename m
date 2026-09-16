Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9E1C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sWx-0008Td-Bg; Wed, 16 Sep 2026 12:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sWq-0008I1-Ov
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:30:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sWn-0005k5-Ve
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:30:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeKqW1855006
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEhix1JPVKJPRvLKpSWmE41G8fXUfNYvUUOIm/hpNEw=; b=WlCIHTUNFAKW6VHW
 hEAlUIj5VTYTJqLkz13+yWG38AyDuqSrEIIZMFHITo2xUCeJApotHKioDoMWV/4S
 aAVtn30pEtrmi15AKUNnRfOOwRvk+tICdCgZAWrJM0DqwjI9ItlgfOXFkv3hCfWH
 tR/suyZpKYw+NEbut1gwVSrsINot7b1vCHxPEJseV+jqexM9trzwRGHrkqzTVQ+P
 YaJP9LQCdecCd4Q1zHALCK6qKtSZ6sP3P7MzRumFHo3TrvUuc5ka252lwVYJ0wGW
 U1QjDBjTMnd4YUAAa2LDV27hWiDYNovVUNdxWOE74AhHm00ysdxCDj6+ivRgSFu/
 xSY/lg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqqp3t1we-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:30:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so4993217a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789576231; x=1790181031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mEhix1JPVKJPRvLKpSWmE41G8fXUfNYvUUOIm/hpNEw=;
 b=MVj/Kn/+NJ8jVl7FcagCP3XmEpp77KKGtfpcgW05lRzjXcOcHTVgQe586CnC/4BdfJ
 84HfSYPCyWGowWdzAzSOPKbsYKqm1ngi0jszVrHiGBxicsc5oDm724ouvU0Qwv2dH2db
 r0WWBZkaJSZqB9nnsqV+GpOxC9wQSoMi+SjAGFR2/W1SmWur7+Ci72jYtazB2+8LkRsq
 EPquiZW9UQ5YzLPufOLCeETbEn2DmtJwpN6tIriniDIFdZQCnUZRa0KIF8IJbyTfROaJ
 O4ewAnOeQvZoJfJB5CbudtXW4IMuCYCeopKG3ah1HfkvPFkTgm5Sf7bOVeeD8dUv5IXV
 orgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576231; x=1790181031;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mEhix1JPVKJPRvLKpSWmE41G8fXUfNYvUUOIm/hpNEw=;
 b=XNnYF9MKGkwyYKabRCtlfzHCVd8o+9XVv9xh3lu57dxniDavEgJOvS2jxX6XGo5BIp
 qVk+yH5Yt9PiDuqmFC4KrXw49PNXcL8uaCBKo+kK3JcROQe3o5hNglsjqqpNOvnDS48T
 Yn+f30MMCd5cQxxfYx/UqJGWtc7iCsYOHroZh4b0PDjSN/mANusU8JbmgsQ8dpwEBHWN
 uSzM0OllN1lpho6SlVc5YZvdgwfl8XSFDCKE8bkUbBn0lBau31SNQujI3fYtBpy4YM/D
 TUqwuT0daHnsyWt8WQ7g25v5Cr62ac0rodqnbKbejg3hAVRrpk4JMVdJy54PWUAMBBDJ
 muhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOv+Gfq8SPgWuP6ZYCW6jZxNLhhFm5K7b3GsDrSeGuDQI/KamRuakpbBTUWi+xoVcvgzLUxG7Fcmru@nongnu.org
X-Gm-Message-State: AFuF++l6wJ31E/5Lq/dXsztx8KGq2qse/NbtuuEPvbWDC1AmsiovL+NZ
 ixwPoZ52pMuWxilOPLhOuDtVMKe5VT9nVQxGDJFaqVDRcxxPAoyKXt/bxGuQOmzC/u642VWzy95
 XfKoYMPbRSwf/SdoQunILAO47okcrDhFfg0RB6r4SrP3RkzOYCh8xSy1wmw==
X-Gm-Gg: AYBFou1QM/ERmHIhtGZ2pixAyDY4uz1C4bcs09AF0fXEEwXbsUA7irGRtpGsu4LaY9T
 0R530cLSTjGI6OgnQgVzYJvmATWYmIapUAepkkEbeP8LLWQPLSSyxXmCpOpKBmGlj10d+jq4KPm
 javLk1Pkfi1BrsxcMsPr5hPxs9lKw856RvuqiZHVvxCxRnUwihoFIxltQOVpElxxr6iGdH4FUCK
 tc5GTYh6ShkfT5a1GgTdRU0vj1Id532FTXV8fR+aScNmX6Qtnl3zc6NdmlB1P6bqIuooaMjR3sE
 M7xt0+kmGVBTRnj8a4ZDYNpmx2S7cqh78YPJZT8mSY7xi/8ZIK+T7GNmckFEjuHAMXgmghndyYh
 Hjusu58H8qUyo2rvfwGldspak4LHu101dadJPaG43pmAv2QU8cBipKayWCIV1nxYytYFb
X-Received: by 2002:a17:90b:2ec7:b0:39d:f317:44cd with SMTP id
 98e67ed59e1d1-39e1e4907f3mr8931910a91.14.1789576231130; 
 Wed, 16 Sep 2026 09:30:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec7:b0:39d:f317:44cd with SMTP id
 98e67ed59e1d1-39e1e4907f3mr8931775a91.14.1789576230567; 
 Wed, 16 Sep 2026 09:30:30 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aca3fbsm9457405eec.20.2026.09.16.09.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:30:29 -0700 (PDT)
Message-ID: <36cbf64f-e187-4d15-b710-7d4e6124ca07@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:30:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] scripts/make2mtest: add docker dependencies for
 check-tcg-% targets
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-18-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyNSBTYWx0ZWRfXzej6K9HAfqpQ
 TTBKt0EdZ3c0MjNbN8Xf8fqhAQ6XPYpqRkfmhA6WikYYAm9yAIlwAgGkaP+2D+6hQdWqbsQhR6D
 cNOz1dSxnu5xQgGpu/lkTMV3KoRPG+F6tktIIaY1X/cwnwR/gf9qXYUfM3KtBD/1WDF3bC+zXxk
 ppTdiVma/gkM0P2HCHI8fw8W+QwkLTBl79KxfLzXPgTqhIhnjNu9dBJUuMrd43fhcNo9d5Uv972
 RX16Ir3DPZp4m5zxh7xHixJL37W7ppmTTUBDmuUs3PS7Pv93oKBIVx8f9FpXVbWK7kAQdq2RSJd
 uDAPL5ic/ccXKuVqpFjZxNh+fSb7UYeY/MXXhxqPwwwduI3t+V27yfwHUYnQgLcCMxyeaaMSvG7
 MdjsUui/LMlCTiBK7Qts6rVudcnGgg6T0RVkegpyYCeoa5ihmZ8GtuJWdWrLm3KtDY6xHX+er8G
 E1VWRXmfveH4l1m6y6g==
X-Proofpoint-GUID: 3Hdkg65MZoTFbw6kfRcTgtNZktwxDbkg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyNSBTYWx0ZWRfXz8wbIA0uwM8v
 8SA+++WfYOjdVY2m3oPHvR8vuQMDxifINlPbbJ+eQwQ3mDtx/JYye6o34nD1AwQ92Ta0YZEm7CR
 d6FS8RKxoB4Yi2sm7aezRfosaHELHkk=
X-Proofpoint-ORIG-GUID: 3Hdkg65MZoTFbw6kfRcTgtNZktwxDbkg
X-Authority-Analysis: v=2.4 cv=F/DC5ahN c=1 sm=1 tr=0 ts=6aaac427 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=dlnC7Bs9CAUtgJ-sswUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160225
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

On 9/16/2026 8:30 AM, Alex Bennée wrote:
> This should trigger the building of the docker image when the user
> calls "make check-tcg" or one of the arch specific targets such as
> "make check-tcg-m68k-linux-user".
> 
> We still keep the internal meson dependency so individual tests can
> launched and the docker build verified.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/mtest2make.py | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index 383ea68b16d..ab894d90d47 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -14,6 +14,7 @@ class Suite(object):
>      def __init__(self):
>          self.deps = set()
>          self.speeds = set()
> +        self.docker_deps = set()
>  
>      def names(self, base):
>          return [f'{base}-{speed}' for speed in self.speeds]
> @@ -40,7 +41,22 @@ def names(self, base):
>  
>  introspect = json.load(sys.stdin)
>  
> -def process_tests(test, targets, suites):
> +targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
> +           for t in introspect['targets']}
> +
> +# collect the docker images uses by the tests. This is totally a hacky
> +# heuristic that fishes the images out of the test custom commands by
> +# looking for the qemu/image pattern.
> +targets_docker = {}
> +for t in introspect['targets']:
> +    for src in t.get('target_sources', []):
> +        for arg in src.get('compiler', []):
> +            if arg.startswith('qemu/'):
> +                img = arg.split('/', 1)[1]
> +                targets_docker[t['id']] = f'docker-image-{img}'
> +                break
> +
> +def process_tests(test, targets, targets_docker, suites):
>      executable = test['cmd'][0]
>      try:
>          executable = os.path.relpath(executable)
> @@ -51,6 +67,8 @@ def process_tests(test, targets, suites):
>      deps = itertools.chain.from_iterable(deps)
>      deps = list(deps)
>  
> +    docker_deps = [targets_docker[x] for x in test['depends'] if x in targets_docker]
> +
>      test_suites = test['suite'] or ['default']
>      for s in test_suites:
>          # The suite name in the introspection info is "PROJECT" or "PROJECT:SUITE"
> @@ -59,6 +77,7 @@ def process_tests(test, targets, suites):
>              if s == 'slow' or s == 'thorough':
>                  continue
>          suites[s].deps.update(deps)
> +        suites[s].docker_deps.update(docker_deps)
>          if s.endswith('-slow'):
>              s = s[:-5]
>              suites[s].speeds.add('slow')
> @@ -81,6 +100,9 @@ def emit_prolog(suites, prefix):
>      print(f'all-{prefix}-xml = {all_xml}')
>      print(f'.PHONY: {prefix} do-meson-{prefix} {prefix}-report.junit.xml $(all-{prefix}-targets) $(all-{prefix}-xml)')
>      print(f'ninja-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.deps))')
> +    print(f'docker-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.docker-deps))')
> +    print(f'docker-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.docker-goals.$g))')
> +    print(f'run-ninja: $(sort $(docker-cmd-goals))')
>      print(f'{prefix}-build: run-ninja')
>      print(f'{prefix} $(all-{prefix}-targets): do-meson-{prefix}')
>      print(f'do-meson-{prefix}: run-ninja; $(if $(MAKE.n),,+)$(MESON) test $(.{prefix}.mtestargs)')
> @@ -93,6 +115,10 @@ def emit_suite(name, suite, prefix):
>      print()
>      print(f'.{prefix}-{tgtname}.deps = {deps}')
>      print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
> +    if suite.docker_deps:
> +        docker_deps = ' '.join(sorted(suite.docker_deps))
> +        print(f'.{prefix}-{tgtname}.docker-deps = {docker_deps}')
> +        print(f'.docker-goals.check-build += $(.{prefix}-{tgtname}.docker-deps)')
>  
>      names = ' '.join(sorted(suite.names(name)))
>      targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
> @@ -105,19 +131,16 @@ def emit_suite(name, suite, prefix):
>      print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
>      print(f'endif')
>  
> -targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
> -           for t in introspect['targets']}
> -
>  testsuites = defaultdict(Suite)
>  for test in introspect['tests']:
> -    process_tests(test, targets, testsuites)
> +    process_tests(test, targets, targets_docker, testsuites)
>  emit_prolog(testsuites, 'check')
>  for name, suite in testsuites.items():
>      emit_suite(name, suite, 'check')
>  
>  benchsuites = defaultdict(Suite)
>  for test in introspect['benchmarks']:
> -    process_tests(test, targets, benchsuites)
> +    process_tests(test, targets, targets_docker, benchsuites)
>  emit_prolog(benchsuites, 'bench')
>  for name, suite in benchsuites.items():
>      emit_suite(name, suite, 'bench')

From previous answer on v3, this patch does duplicate existing
dependencies. If we don't have a specific reason to repeat it on
Makefile side, it should not be included in this series.

Regards,
Pierrick

