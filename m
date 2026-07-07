Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE1EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz5e-00015V-J2; Tue, 07 Jul 2026 02:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz5b-00014K-JX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:15:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz5Z-0000lw-Ua
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:15:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674951c2498874
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 paxy4DGIqUZBvKg+DJdzLkUfz4wES6uTcyO7WhsW7vI=; b=bJMkdhnGJl8YXkZw
 Qbb8RVtNEVxuVTqKSSXY/UpLvaDTYa3BHsA4cshxsFqTswTwJ5jZmWgoS6eYLz3F
 Qp9BXW55ell4o14KTA6ttYbpFGczARuX1wGJN2+jC2Vqdiw4GiDpsVmY7EYrB5va
 QhRx63Q0mPlNCUAjYtee9RLe2x1KxuTFjbAaNNAzlVl48+AdmH22olhVYUhdnsUQ
 rWaKVBNw0sTy7W/65yiVPNyD7C46+LdyEsKy7CLwzr4g3mKdWp7YdrR9QlatOlUr
 pd4hsinVjR2h2r8BB7Jf2s71cQ1MB8i3231BL2AOSZ7BvO0HiOg28ojlhy6tk+j6
 Ng+nJw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hscww7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso48932551cf.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783404923; x=1784009723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=paxy4DGIqUZBvKg+DJdzLkUfz4wES6uTcyO7WhsW7vI=;
 b=DGkeT9ut4XnQ8nV2P6R+cnA8crG1q3+JWtkFJD6xMCiLfrM4L1K2oVWxNsbCPvE/gj
 qjQOB01g+HB0QUo+h/HQxQMkI3AaKGsM+jibmatLHhnOmN6f32nn3Ooh7hdSB/kVWFyO
 zoeK15chVyW7ZJUokIac92ll9Bgv7CFOrlj+XKoyeN/jX3aLt8tm4N5p1hhPQGza58VP
 KtQuI78r7phm2Y2RJSAlSmUJ6AxL0fZu0PplwBd614DKaX/Wh5Nv8FhaFZsysEJiCW5B
 sVKTbOl7rCAzJomwlCQig9Ch9BwSRhaOcymbXbhaC4tHkR0aIwMOG/J/rQ2xXOJdgpzl
 QmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783404923; x=1784009723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=paxy4DGIqUZBvKg+DJdzLkUfz4wES6uTcyO7WhsW7vI=;
 b=Kt5efNkaLdr1gcz2I6LrB6CvhCfjnyF0TsRUMFecudq/NsAZrU4ESQMmNQ0EGffyEh
 m9UXx2BUqEH7U0AO7dVENKTqUikHUprlKH3UO1uLe2VSnG+SDCAGYPkXOQZusLxkMW+d
 ceNMTyoIiWTB2RDps2Mo52CmwyPCOLglCBYB2nb7FHhiOSMgOjsotW04mrC0n6bsLqrD
 GGnKSKZRH0eCjVo7AbH0BU1GkIY3O/8VOvZiHim/0Fp0X7QItMX1q7M2jGCyan+AF061
 iZAgUx2OZlIoisbL6GwhGAhw5ar7K+RYZAnc5IAsdHqCm+HwD41A/+1OJATntE/0xibd
 wrtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzB5jUIiK6xncGZ/7YcAXfVAkLDpshSkHqz3tSbY0m6QeiYMcaZ0OQQ/lWpzWI+VMOJjmFb76/4hVT@nongnu.org
X-Gm-Message-State: AOJu0YwJONJhietBdEcp+PCLeUXkIu7uVCciaGs9V4FAL7oCCDAuR8mX
 UcjYmI9nS7e4u4C63HPEjsy08o1BqJ4Q2uncvLgZUFwYuQfrupEAm2ouUqJVLPrp40SKbSsgyMJ
 rGP9i9NwxOZDzvEaz5+Rktxvguh01+3OogUSHU1SgI5JSfrutmvMWhvskWQ==
X-Gm-Gg: AfdE7cnpL11CYkv8c7VetwkulCQ3DaKXOrOsjLC+m/OobXfSgrtmpbGDniPMg7DP7bj
 uqMBZUmo5k5pLNvHDkQ0epy6Zgsz6Batb3VNenfR3aBl22KTntEEU1sR30B0MFS2Y5D+az7fdzk
 ROHi1GB0ppNKAhBtebWN3cg4R6oIFY7S/Gi4YKNh/u9ItgssGoXab7tr/yn+t5gcnhHzILF+9ki
 lOY5Y/73JS6lxIVeMaCgMuvAGcjNSQjfCuuCBPl1j8kazp+DzYQ9aIdHuCWKa17jolc+1w0PFl9
 sbglfbysPCxOjsfdTd/dzyEqVZibgWoBw6i9bRfoEN43tKAD/ZyC4rQwb8+ckbxZg0so1qUqvX/
 7bdv3H6sesPDScfPyyQxEiZZ9NExbuxbNi+HFijcRjykW+mqni1z+SNiZsIZ9nw==
X-Received: by 2002:a05:622a:8d08:b0:51c:7b13:6301 with SMTP id
 d75a77b69052e-51c7b136a2emr8002131cf.87.1783404923217; 
 Mon, 06 Jul 2026 23:15:23 -0700 (PDT)
X-Received: by 2002:a05:622a:8d08:b0:51c:7b13:6301 with SMTP id
 d75a77b69052e-51c7b136a2emr8001931cf.87.1783404922747; 
 Mon, 06 Jul 2026 23:15:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm31773569f8f.18.2026.07.06.23.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:15:22 -0700 (PDT)
Message-ID: <1275323c-ccee-4ccf-9ce9-3f18bb20e407@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/91] tests/tcg/meson.build: introduce cc_dockerfile
 and cc_docker_arch
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-29-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-29-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e3SJ3k9ftozUKTv4kLrjSk9ZDL6xS3VA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NyBTYWx0ZWRfX2VwJwmUcJaAk
 NlUvlHRdoqtkgvfMKZMRUwgXlvqfUGHBvxWfR7LD1cSOK5VKCfpB1eb8Wte9IjcINOaiStRJmhR
 /4jfPh90MaI94ep5tKpBTH+IwvzG1auxYtc9QkoJUBGmXF3CkzvFjHBT8FerosCunRIfdh+v7gh
 OBIkz09D4ZNVvUSYfMdl4rNPOhtfzL4n9RwxQCTiTY3CS3Nw8NEtsLKGoYQu65oMZN5n9fMU2vJ
 dWMbA4M5/0dlHt4CVWD5dcsuPj1i6Rt9IfeK/GOJ+3bBSq+VH4RZCtov58ldVIXfETzE7pYvS5T
 JnR10JUFbHHUM+tZUdQe/U0UcGVkACKF9ymPoY33SFjUDYvK2eiNwpwjRPG0TVLXID8yriAzMgK
 mDaSCsRaQHFZhFffg8t/luR+x6nni5re4Gdvp3n3T4AgNQT40wIsRLJYnoPnchdiV3ssLpljzfN
 Ca1uhpI57NMXJYgVrHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NyBTYWx0ZWRfX8jJ29Cs5pLbt
 OlvIe+CBX6oQvdaDesEHIWuyFTh9zWaB8riN7Axqw6Aqf9nEuSwgOMZj1nVHzo6f9gVcRYZKdVW
 6OHYr/cTepo1D0cL/pRXqcVDjjVONv4=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c997c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_O0o6oa801hCTzwlR6cA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: e3SJ3k9ftozUKTv4kLrjSk9ZDL6xS3VA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Pierrick,

On 7/7/26 00:32, Pierrick Bouvier wrote:
> We allow target to declare a dockerfile containing required cc. We reuse
> tests/docker/docker.py, and correctly set dependencies for tests on
> original dockerfile.
> 
> We specify list of hosts for which image can be built and contains
> required cc, using cc_docker_arch.
> 
> In case we rely on docker, we do not build tests by default anymore.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 61 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 0d2fefe8f51..57e7c3f8801 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -1,6 +1,7 @@
>   cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
>   env = find_program('env')
>   
> +docker_wrapper = find_program('../docker/docker.py')
>   gdb_progs = ['gdb-multiarch', 'gdb']
>   if config_host.has_key('GDB')
>     gdb_progs = [config_host['GDB'], gdb_progs]
> @@ -21,6 +22,8 @@ tcg_tests = {}
>   # {
>   #   'name_of_target': {
>   #     'cc': 'cross_compiler',
> +#     'cc_dockerfile': 'name_of_dockerfile',
> +#     'cc_docker_arch': ['host_arch_supported (meson cpu)', ...],

This variable confuses me while reviewing the other patches in this
series. What about naming explicitly as 'cc_docker_host_arch'?


>     cc = find_program(plan['cc'], required : false)
> +  cc_from_system = cc.found()
> +  has_cc = cc.found()
> +  build_test_depends = []
> +  build_test_depend_files = []
> +
> +  if 'cc_dockerfile' in plan
> +    cc_dockerfile = plan['cc_dockerfile']
> +    cc_docker_arch = plan['cc_docker_arch']
> +    allowed = ['aarch64', 'x86_64']
> +    foreach arch: cc_docker_arch
> +      if arch not in allowed
> +        error('incorrect docker arch ' + arch + ' for target ' +
> +              target + ' (possible: [' + ', '.join(allowed) + '])')
> +      endif
> +    endforeach
> +    docker_arch_supported = host_machine.cpu_family() in cc_docker_arch
> +    dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
> +    image_name = 'image-' + cc_dockerfile
> +    has_docker = docker_arch_supported and docker_supported
> +    if cc_dockerfile not in image_targets and has_docker
> +      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
> +      t = custom_target(image_name, command: cmd,
> +                        build_by_default: false,
> +                        output: 'no_output_' + image_name)
> +      image_targets += {cc_dockerfile: t}
> +    endif
> +
> +    if not has_cc and has_docker
> +      build_test_depends = image_targets[cc_dockerfile]
> +      build_test_depend_files = dockerfile
> +      mount = meson.project_source_root()
> +      mount = mount + ':' + mount
> +      here = meson.project_build_root()
> +      cc = [docker_wrapper, 'run', '--run-as-current-user',
> +            '-w', here, '-v', mount,
> +            cc_dockerfile, plan['cc']]
> +      has_cc = true
> +    endif
> +  endif

