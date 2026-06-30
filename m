Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED2C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weS3Q-0004Rb-HU; Tue, 30 Jun 2026 02:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weS3M-0004R8-Sz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:34:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weS3K-0005lG-U8
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:34:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CKks1088652
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BOOg6O6+65ktwznpGGrJGfmOMMCE+AZyIJa3ldSeALU=; b=AdoUT8ztyNTeSMX3
 CWmUfyOgpvvckS92wXO7Q3B/U6HC//FjAoESx0bPR2pG+kOLoh8mOotNcrmzDOcH
 RSFNJ6QQIKeyIi9jB+jmyso5kWy4X2I5JIUjiKVRLnp2aHZdRi5N8zE/N+T3KC4P
 i2os027vb+4Nu+bps9qrTOFWJa5mDSD3M0WoQSsSedFIwo90fFBRaY8oIZqQNlaB
 YXB/N1JC9cHj1RaqK5oj0SEPShSdnRdO6Kt5/IK46RkGHPmQ/v1XLKGkcG7O1TGJ
 g1peGghtPzC1aKqfwB83THNYOZ2Sptd91r2X9p8FC5oa1ym5N6xCfXoQPCfmhz7w
 1TfyEw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fgkeg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:34:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso225217eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 23:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782801276; x=1783406076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BOOg6O6+65ktwznpGGrJGfmOMMCE+AZyIJa3ldSeALU=;
 b=FQQ35UHkZSMIVUSszhOOc5U5gQFqVBO4MhxFmT52h+ZE+0mNUWru8YwRGHMGZ5HYGo
 P2g8YJDwpnQZIQaeX5RcWgRqxyh+N5DHW5MlY7S/dyT0O0/x9o3KFcuvZQjZVIEO/3BY
 ihctsPWGAt1Iagb43gnLSYSxr9qGvRGXTpDmkgQId8fT7+wavUXgFAtoZQF5QG3HpiFn
 mVjYfdyNXZ1ifCnDmZyZmNEeyA9Vn6bbPT9WCwKu9246mT1u0f355lF8lFt6WrcCGZe5
 WMFQSqhcMpvcvNwmwngwoDVMCIwjHrjE866OoSiLYyfgVGdWpgr9fUkuwvNSIzSP8R2k
 a7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782801276; x=1783406076;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOOg6O6+65ktwznpGGrJGfmOMMCE+AZyIJa3ldSeALU=;
 b=qy1JxpZRm9eVqDaICG6eo8nTCZeFZ5fR/dNnbJvFdq//1RipTfERD+DyMWysz/Q06B
 NYHng4qk/dsKMJQ/Q8mv9S+sYtnVElOjWWXsIZmF5qUsi6t0AJLVjrng+Qjebgg1Ci2I
 il05zs4MbODxIg1wW9SZoXe0a7t3qbJEYVjQh9zPc3UXJbPxooijlNBile2w5nNBQnrT
 wUUX2JKPaJPWVQiqhvOdJuXcmpw4wyo6McUM7Bnf9t00M4hm89ToMVxiUsSDIUlg9Wew
 CXp0L8Qj25RRG0HhhqvR+2mXW9VEgRINbn13AIZiAAFPZwNvsE8fgwstMbRBZ9QGuDxc
 wlgA==
X-Gm-Message-State: AOJu0YzxkY2mV3/ANPZ7E2Gj1msjtUlaDrmtMgpNTq+eA4VF5YZBVTtF
 Fw4mpv33KI//ZZVN0OvveRDCGuVhDDUi+MzVDlxgYIlXNuv1k5WvMIjdut7VRU4kshn8mNhH6qO
 o2ik6+L0USXBc6cZZpcEtheeOcJ3gRAYZ16DeJ8q+tYvXGzV3fuUSYEFbfzUfTwJ7sg==
X-Gm-Gg: AfdE7cm7YumG0k0IHCp91Xke1gwMOg6dGpW8wrHydp8VmPiGjYh11GItIINBtQDtKXz
 CKLfirdSh6/aTzm9Z0SKLKRAFxilfe3/jMmxfHWJUZQ+8IUra7AC1DQTQM9lfJ7NoX+h0bJxvEY
 Fu9a/SM9veUFENY3KK7vfynaQ6dIDHC1N0g8E1euPa9dlVPHHmuGCpwRyiTQhnpmOMqt5NczGks
 GOfLlo7kPH5EgCMrhxAxsWZ8ppkC0UMdoEqe5D47DPhFWGqGTl42KpZ2gNHu3OzA3oxMT4ix/Qj
 paPug3jZyVjAZU8vG8hEKmRUfiocqOrKUNpkU0xkL8DtALnxAsXooYQSWSk7A57fc/UjHrLr3QX
 Z7EL6EABNmmF1As7AAEJKGoEi9kPE7mwlfEpMa6N1usQVB4un1cIMZqlpoJJkWcanzLaygPUcGC
 k8JAc=
X-Received: by 2002:a05:7300:1898:b0:30c:ab4f:46be with SMTP id
 5a478bee46e88-30ee13a266emr1873153eec.36.1782801275875; 
 Mon, 29 Jun 2026 23:34:35 -0700 (PDT)
X-Received: by 2002:a05:7300:1898:b0:30c:ab4f:46be with SMTP id
 5a478bee46e88-30ee13a266emr1873129eec.36.1782801275292; 
 Mon, 29 Jun 2026 23:34:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2f5ed29sm4775377eec.1.2026.06.29.23.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 23:34:34 -0700 (PDT)
Message-ID: <e349d913-21fa-4b35-be24-e554356c1d2d@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 23:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/37] tests/tcg/meson.build: introduce cc_dockerfile
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
 <20260626233918.158740-36-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626233918.158740-36-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1NCBTYWx0ZWRfX5a5D8TmKUZrx
 bO38uZiSws6TZzilVwWbr1cDOiQkwHkYvRJf4Ry3/8G9mKsxR54okoy+2cT6k6+D7c8yr1L/fpf
 A5vnSgCO3nn0tMGmM8zPxeQX3q/GyCSrGuKM4OPXTapV68a+mlf2PycbVQvgHz4wDOwQB4zJ8H3
 aGLwgZHOH9Z4EywhufOqPanlCWETXVDQST8LN98E+oZbR+dnqbYPBkZGKvREFmtQ+S0HxuWRs2b
 gX2kB66mFlQtlR9wTGzaHQTdCaKNGv4zTrJ1Jgy5HzCilL2+HrAr4Y6iEjL2qmY7enB7YHzPCW0
 oDuiWnjma2Mul+YqDuaml2LQKOtnGVCp/XxZdcykqgz+r1XJ9syk5ackH80DvE2rVaxx24JUh7M
 HsFos+dYnVSl72E85xwZlIUDNTLvoYe2POWZ50Wr7x6WTlDWigwpNCspkwyv/NH2adUZ6/l8bsc
 Sn+kPIF/zMHh5HBcwIA==
X-Proofpoint-ORIG-GUID: EGusyatlhYZWNRCPZYKDI4hTvu7FINfm
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43637c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=b1d_VCPYNydq6P9BhPIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: EGusyatlhYZWNRCPZYKDI4hTvu7FINfm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1NCBTYWx0ZWRfXzz4qmn4IhQE7
 NGZWJqXKstmdTSNqzubcplojubartMkLASi/g9ZChZ1F8AmvY9YrHrA8yiSQ1N36sesBALE3pDM
 UPy3ePQ7ZyKppi3q1O1u+hZ6bNx15M0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300054
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

On 6/26/2026 4:39 PM, Pierrick Bouvier wrote:
> We allow target to declare a dockerfile containing required cc. We reuse
> tests/docker/docker.py, and correctly set dependencies for tests on
> original dockerfile.
> 
> In case we rely on docker, we do not build tests by default anymore.
>

Added (coming in v3) cc_docker_arch to specify host architecture for
which the image supports the given cc.

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 52 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 2a308d8ad32..eb6b65c0021 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -1,6 +1,7 @@
>  cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
>  env = find_program('env')
>  
> +docker_wrapper = find_program('../docker/docker.py')
>  gdb_progs = ['gdb-multiarch', 'gdb']
>  if config_host.has_key('GDB')
>    gdb_progs = [config_host['GDB'], gdb_progs]
> @@ -21,6 +22,7 @@ tcg_tests = {}
>  # {
>  #   'name_of_target': {
>  #     'cc': 'cross_compiler',
> +#     'cc_dockerfile': 'name_of_dockerfile',
>  #     'cc_feat_cflags': {
>  #       'name': ['feature cflags'],
>  #       ...
> @@ -75,6 +77,9 @@ if gdb.found()
>    endforeach
>  endif
>  
> +docker_supported = run_command(docker_wrapper, 'probe',
> +                               check: false).returncode() == 0
> +
>  # plugins come first, as we need to build the list
>  test_plugins = {}
>  subdir('plugins')
> @@ -120,6 +125,7 @@ endforeach
>  # Now let's go through all architectures
>  subdir('aarch64')
>  
> +image_targets = {}
>  # Finally, we can create all test executables and test targets
>  foreach target, plan: tcg_tests
>    if target.startswith('multiarch-')
> @@ -135,8 +141,8 @@ foreach target, plan: tcg_tests
>  
>    # return a clear error if user misspell a target entry
>    foreach key, _ : plan
> -    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
> -               'qemu', 'tests']
> +    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags', 'folder', 'gdb_arch',
> +               'gdb_feat_version', 'qemu', 'tests']
>      if key not in allowed
>        error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
>              ' (possible: [' + ', '.join(allowed) + '])')
> @@ -144,6 +150,35 @@ foreach target, plan: tcg_tests
>    endforeach
>  
>    cc = find_program(plan['cc'], required : false)
> +  cc_from_system = cc.found()
> +  has_cc = cc.found()
> +  build_test_depends = []
> +  build_test_depend_files = []
> +
> +  if 'cc_dockerfile' in plan
> +    cc_dockerfile = plan['cc_dockerfile']
> +    dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
> +    image_name = 'image-' + cc_dockerfile
> +    if cc_dockerfile not in image_targets
> +      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
> +      t = custom_target(image_name, command: cmd,
> +                        build_by_default: false,
> +                        output: 'none')
> +      image_targets += {cc_dockerfile: t}
> +    endif
> +
> +    if docker_supported and not has_cc
> +      build_test_depends = image_targets[cc_dockerfile]
> +      build_test_depend_files = dockerfile
> +      mount = meson.project_source_root()
> +      mount = mount + ':' + mount
> +      here = meson.project_build_root()
> +      cc = [docker_wrapper, 'run', '-w', here, '-v', mount,
> +            cc_dockerfile, plan['cc']]
> +      has_cc = true
> +    endif
> +  endif
> +
>    folder = plan['folder']
>    gdb_arch = plan['gdb_arch']
>    qemu = plan['qemu']
> @@ -237,10 +272,14 @@ foreach target, plan: tcg_tests
>          cc_feat = setup['cc_feat']
>          if cc_feat not in cc_has_feat
>            avail = false
> -          if cc.found()
> +          if cc_from_system
> +            # check flag for host cc
>              cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
>                                check: false)
>              avail = cmd.returncode() == 0
> +          elif has_cc
> +            # docker cc always have feature
> +            avail = true
>            endif
>            cc_has_feat += {cc_feat: avail}
>          endif
> @@ -252,12 +291,13 @@ foreach target, plan: tcg_tests
>          cflags += cc_feat_cflags[cc_feat]
>        endif
>  
> -      if not cc.found()
> +      if not has_cc
>          skip_test = 'compiler ' + plan['cc'] + ' not available'
>          built_tests += {exe_name: exe_name}
>        endif
>  
>        # build executable if needed
> +      # build by default only if cc comes from system
>        if exe_name not in built_tests
>          exe = custom_target(exe_name,
>                              input: file,
> @@ -269,7 +309,9 @@ foreach target, plan: tcg_tests
>                                        cflags],
>                              depfile: exe_name + '.d',
>                              output: exe_name + '.test',
> -                            build_by_default: true)
> +                            depends: build_test_depends,
> +                            depend_files: build_test_depend_files,
> +                            build_by_default: cc_from_system)
>          built_tests += {exe_name: exe}
>        endif
>  


