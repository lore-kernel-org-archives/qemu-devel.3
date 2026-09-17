Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFA1C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FSb-0002dJ-7C; Thu, 17 Sep 2026 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FSC-00020R-H5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:59:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FS6-0001Aa-9u
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:59:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HDiUC42974879
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gQEom3ktQNgl4qCGyw7wweJ/PiK0iASc/EUEzVNUN5Y=; b=Kw0h8an1Zbfthq+8
 VVoDx/INqydtTAuFUAyqZTaaNUSUmOCNtwfJR9SXkf7lOjW6NBigmkGc2Xi0z48S
 DvocDJoJVx3SEB49FcdVVyuiMyitFWUXSJukzS35e9da2YxOQypNMB7bIDmts4pG
 B3DT+CL4LJmhMSUfyLBVDNEm+8R7lYggtabx8GtQ5yxHl3YsPK8EgJPwsk7EZxkD
 FaeiqEzChWFNC3EvDauLI/GLKDC8+IxAymOg1tNW0d1dY/IC3TFYQOUMwRFs6KXT
 H1uHEmKdFWoVfs/XgRlyUzjNF2AHiLto8Z6kiVlkv545gVvbQW8t8BQ2KIe+z+tz
 oA5B1Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grdd6j4be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:59:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39e3dad7ab3so1155472a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789664352; x=1790269152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gQEom3ktQNgl4qCGyw7wweJ/PiK0iASc/EUEzVNUN5Y=;
 b=Si2TpG4+rBwHM3SBzKVwq13MwnZPEVh1AxNljueMeJKUMbuiDUe6vFkKuGfX8l6Ekq
 ZKmGaHOJdbAv/2I3ULYpnid8053XpWgtQ0uruB1xTLyxdUpY1naAnvo1Q22hx71Cr9Cl
 IBiEuCjTr3iw9vAsSSZ1FVrjAm1APrv65xUeukUMSjZLnH98svwEED3GJYiET/QDOpE7
 1ifDzi0WfFTbegQOJ1gWerTq+TvSwU+bhBm+l01rfQkzGURTRAg3BMTRMHHwh1xlqt7i
 eRpt5i5iQMSX5olkJmMUfZZ1DrW5CDqA+q/V8H8XllbcMxFo0jeAposnVvYXFbY16N4j
 C+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664352; x=1790269152;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gQEom3ktQNgl4qCGyw7wweJ/PiK0iASc/EUEzVNUN5Y=;
 b=Aj5IArD+7v0wXoZeRX5n1OUE1aM4pREYNXd5svrL5/f4LL4wGigKqnRukiLQwOWkmV
 kLs0gnLkKbFH+qxq0DlI7eWxtjYbHLfN2Zpb1M6FZPCS+ZlTHwsIcY4hDk2/l4Tc8XQL
 yQ0fCt1PbWdhUi0EKA+Ukx9ZYXfwuFYaYn9H7cHfz7ds0LefeDQGWgcyZJpTGaSr9lB6
 ti1phMW4J5R3m4abdf/qIroXJEX4y2oB7k3P/oIohurzlV2fpPm5j8dJYtU3QEadnGg9
 PxeVwkNn7E8As2ZnSywtyyaslb0KCjJ7FWhG7+Q8bI7ZsRsWSOF/1A0F0A+0YwQVFqko
 e01g==
X-Gm-Message-State: AFuF++lD+q0u98YjFlM7LRaumV+7uP+38ixZGu1zqRMbbUTINx5di9S1
 HTcQp8qyzi9jS55pfKk0i+Zn6xaOpOAFL+K5BEADDcU+jr6NSgNZub15gIGWZ/sCLV+7yleUbzw
 5BhBrU9dF5OjQXkaafaYZUFHqiHcjknQKsyUF0ASXdGojXUcfKK37VFtMYg==
X-Gm-Gg: AYBFou36Hezzmi6LlD+qO6TTOytGfgMcXtCjPbTVW92f6c/mm3xL+g3dzVNicwe3vnD
 9xeq8B/ivnwEQKoEf5D6EMpmZwgQNPTYUXOkYekegfmD+mqQigfZ6GgY1G9P71FXaJ0URbEAqE5
 PrHjw7uTG8S5uhFAa3vteM3w9woo0JqNiTPFZGy2usCmYGVEQFcDkpR46lN4jlLVDacaVBoO0Jj
 bbiwcYOolTmwuoIXlpLLKDxAWjqFYDkHDyRf1V2nyqMwicZ7HFS06aXJkFl+oJTc1g7qEtYin39
 3szItX21Mgnjkg3/FcFbsWHebDW0Y272KEYqRV5Pfa1zYQM99QOrI5lH4L5es4Ey2NN3k/pn7Uy
 EbxXckWz9Vb/HvfRIrzoKCuPnsT3v+vQX+z+IPmdM+PRzqwrHnbJsFs2L5pVagr1VDgYQ
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e1e5777famr17490824a91.23.1789664351891; 
 Thu, 17 Sep 2026 09:59:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e1e5777famr17490798a91.23.1789664351381; 
 Thu, 17 Sep 2026 09:59:11 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144c6f2384bsm3699824c88.13.2026.09.17.09.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 09:59:10 -0700 (PDT)
Message-ID: <b30b72f3-e3b2-44ec-9b10-245898cc2a08@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 09:59:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] scripts/make2mtest: add docker dependencies for
 check-tcg-% targets
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
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
 <36cbf64f-e187-4d15-b710-7d4e6124ca07@oss.qualcomm.com>
 <878q508bua.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <878q508bua.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g_qBOViEhYAzf7dhrIvfd9xoKyVlL7rT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfXzCq+HnbzcxXN
 TEsPlrwntDBOizkAVTsKdC9wcaeRzmICFjpriTgmIQ19YVD4TVIvz91oEi+J7XljxbQb46eQP7x
 uiCEvv21aGHI7RgA9veOG2kQ0unRObGgOUfeDeLdM6x74Vc+kbHFxwg25VC/xP63SjWm37bCUOE
 7DOhl8RcQ63BfGcMbgZwn0V/XjviV/SyV2iuOHBXLSspwkELc65+gqcBuCYFzQg5TlWmZWnxX87
 VBlntakcZsCbX/o0CHRcB54diFWHa8CG0ua3Bf8AuoSxIN9N+uRIAHIYfy6y6LsZdvddVD2GlBn
 sDdHgCJ9pF7j1VA9mcBc4fyx6IZV0IxS9bJnA1ekf8jJjBX1gUx5ZQmzMupROXRzjZ358EYo6bQ
 ekEJ3CMzHWtQ2xsnxsMAAz6EMy65o8wfRpaVokDQgYpgOUootx+Hxk0ysX9kum7sK3lQFDl2ZWS
 2uCCMrBeg4XN4KvyD1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX70r/wZ2ecpGb
 xfTTF+oxHlDjTVHyMsV9jiGk+OZnCL728zia0qrJuZfWXZMKDUjEWovbYj1zwAyZgZCMbXc3Hxj
 suQ7LlP/sIxJn43P9j8+ZuKS4BkjBbQ=
X-Authority-Analysis: v=2.4 cv=GeOCDgXL c=1 sm=1 tr=0 ts=6aac1c60 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FiFrMHM1c5R2TP_u9pIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: g_qBOViEhYAzf7dhrIvfd9xoKyVlL7rT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170242
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

On 9/17/2026 2:29 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/16/2026 8:30 AM, Alex Bennée wrote:
>>> This should trigger the building of the docker image when the user
>>> calls "make check-tcg" or one of the arch specific targets such as
>>> "make check-tcg-m68k-linux-user".
>>>
>>> We still keep the internal meson dependency so individual tests can
>>> launched and the docker build verified.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  scripts/mtest2make.py | 35 +++++++++++++++++++++++++++++------
>>>  1 file changed, 29 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>>> index 383ea68b16d..ab894d90d47 100644
>>> --- a/scripts/mtest2make.py
>>> +++ b/scripts/mtest2make.py
>>> @@ -14,6 +14,7 @@ class Suite(object):
>>>      def __init__(self):
>>>          self.deps = set()
>>>          self.speeds = set()
>>> +        self.docker_deps = set()
>>>  
>>>      def names(self, base):
>>>          return [f'{base}-{speed}' for speed in self.speeds]
>>> @@ -40,7 +41,22 @@ def names(self, base):
>>>  
>>>  introspect = json.load(sys.stdin)
>>>  
>>> -def process_tests(test, targets, suites):
>>> +targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
>>> +           for t in introspect['targets']}
>>> +
>>> +# collect the docker images uses by the tests. This is totally a hacky
>>> +# heuristic that fishes the images out of the test custom commands by
>>> +# looking for the qemu/image pattern.
>>> +targets_docker = {}
>>> +for t in introspect['targets']:
>>> +    for src in t.get('target_sources', []):
>>> +        for arg in src.get('compiler', []):
>>> +            if arg.startswith('qemu/'):
>>> +                img = arg.split('/', 1)[1]
>>> +                targets_docker[t['id']] = f'docker-image-{img}'
>>> +                break
>>> +
>>> +def process_tests(test, targets, targets_docker, suites):
>>>      executable = test['cmd'][0]
>>>      try:
>>>          executable = os.path.relpath(executable)
>>> @@ -51,6 +67,8 @@ def process_tests(test, targets, suites):
>>>      deps = itertools.chain.from_iterable(deps)
>>>      deps = list(deps)
>>>  
>>> +    docker_deps = [targets_docker[x] for x in test['depends'] if x in targets_docker]
>>> +
>>>      test_suites = test['suite'] or ['default']
>>>      for s in test_suites:
>>>          # The suite name in the introspection info is "PROJECT" or "PROJECT:SUITE"
>>> @@ -59,6 +77,7 @@ def process_tests(test, targets, suites):
>>>              if s == 'slow' or s == 'thorough':
>>>                  continue
>>>          suites[s].deps.update(deps)
>>> +        suites[s].docker_deps.update(docker_deps)
>>>          if s.endswith('-slow'):
>>>              s = s[:-5]
>>>              suites[s].speeds.add('slow')
>>> @@ -81,6 +100,9 @@ def emit_prolog(suites, prefix):
>>>      print(f'all-{prefix}-xml = {all_xml}')
>>>      print(f'.PHONY: {prefix} do-meson-{prefix} {prefix}-report.junit.xml $(all-{prefix}-targets) $(all-{prefix}-xml)')
>>>      print(f'ninja-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.deps))')
>>> +    print(f'docker-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.docker-deps))')
>>> +    print(f'docker-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.docker-goals.$g))')
>>> +    print(f'run-ninja: $(sort $(docker-cmd-goals))')
>>>      print(f'{prefix}-build: run-ninja')
>>>      print(f'{prefix} $(all-{prefix}-targets): do-meson-{prefix}')
>>>      print(f'do-meson-{prefix}: run-ninja; $(if $(MAKE.n),,+)$(MESON) test $(.{prefix}.mtestargs)')
>>> @@ -93,6 +115,10 @@ def emit_suite(name, suite, prefix):
>>>      print()
>>>      print(f'.{prefix}-{tgtname}.deps = {deps}')
>>>      print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
>>> +    if suite.docker_deps:
>>> +        docker_deps = ' '.join(sorted(suite.docker_deps))
>>> +        print(f'.{prefix}-{tgtname}.docker-deps = {docker_deps}')
>>> +        print(f'.docker-goals.check-build += $(.{prefix}-{tgtname}.docker-deps)')
>>>  
>>>      names = ' '.join(sorted(suite.names(name)))
>>>      targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
>>> @@ -105,19 +131,16 @@ def emit_suite(name, suite, prefix):
>>>      print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
>>>      print(f'endif')
>>>  
>>> -targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
>>> -           for t in introspect['targets']}
>>> -
>>>  testsuites = defaultdict(Suite)
>>>  for test in introspect['tests']:
>>> -    process_tests(test, targets, testsuites)
>>> +    process_tests(test, targets, targets_docker, testsuites)
>>>  emit_prolog(testsuites, 'check')
>>>  for name, suite in testsuites.items():
>>>      emit_suite(name, suite, 'check')
>>>  
>>>  benchsuites = defaultdict(Suite)
>>>  for test in introspect['benchmarks']:
>>> -    process_tests(test, targets, benchsuites)
>>> +    process_tests(test, targets, targets_docker, benchsuites)
>>>  emit_prolog(benchsuites, 'bench')
>>>  for name, suite in benchsuites.items():
>>>      emit_suite(name, suite, 'bench')
>>
>> From previous answer on v3, this patch does duplicate existing
>> dependencies. If we don't have a specific reason to repeat it on
>> Makefile side, it should not be included in this series.
> 
> The reason was to trigger the build outside meson where it doesn't stall
> the output. Maybe we can drop not we have the console fix.
>

Yes, it doesn't stall build anymore, and it's adding duplication. That's
safe to remove current patch.

>>
>> Regards,
>> Pierrick
> 


