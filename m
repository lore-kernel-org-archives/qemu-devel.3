Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pg5Hjqqo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=APhcZ2GY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIym-0006hr-SV; Thu, 29 Oct 2026 01:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMIyg-0006hg-EB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:47:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMIyc-0000YF-JZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:47:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5HBre3889649
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F6cBR/fpPC8yRddawHV43JGPywnjL4/RoILxkowUzko=; b=Pg5HjqqoAnmDUJW9
 t1EJOwoFF0mdd6HUbj30Cv31Kn1ZTnkDu0a0Utee6HYYd4Z8cNWV+NnWY3Od1g/5
 vDHxdNYhdSmtFeTDkJU3J9ynGgfXBhSPUFAZaXeU29waR5lCJQqUC4JdgxvfVS8l
 k5sHRj+yyonVHKCyDwmaICo5s1u0/Kqzue1XrNm8017IbsBWLJxoGBQDkt248u2o
 DgX7ur4KOmsk1lc0RQ8MAI6mP7ZRi/YWCcVgZcVZN5z1gAKc2efLFALrPPqf5vmL
 ms5wyFqmYyNljQZtbq2mucmxFm+iJjbNqDBETA20eoRYiRP0e22JiWwCx/7sC7/Y
 uZXRWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc220d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:46:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so347825685a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 22:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793252819; x=1793857619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F6cBR/fpPC8yRddawHV43JGPywnjL4/RoILxkowUzko=;
 b=APhcZ2GYyS7qajzhooOWacVnNJr+w64ZDTx4G2tkxTfolSh0DVYN+nYm0OgMEh5Jtd
 BaIF7ml4ho5SXS2F5qImU+wdEOdYeZw+BlrDJNkFGTZidVuyAWFTQA+Zo8Y0RMkZQMk3
 odMNQ2rxUIVI/gAVwa7/NSGUFq4I3v29AzmQrrsPebWcc63GCR5Hsk4TPvQ4g0cNqUJj
 +2W8JZmC2FsoHMhOHsQCxSWs84UHPY2LzYTY4HNV+rAaFxjdX5zBX8vSMOK2B/dnl73Y
 5ykDWvus9yzYV14pHaGQPJdPZhVll9bV/WOemcVNTMTU276uxGWl9HlypW747ogxk5DA
 8Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793252819; x=1793857619;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F6cBR/fpPC8yRddawHV43JGPywnjL4/RoILxkowUzko=;
 b=Lir2UScwliDzcoLbfXu7+ehy3UXXXYNPK71PGj01pebz3ZPRbtY3dz6Xyhoh04lHo6
 OH2bP4k5099NeZAQAdHxaj83wHQ/ekFuarSLiKvmR1eOdbXK+4k2pStvj3jBvlpGAsrE
 LiAyZfxANmP1QL/jaVoNJKfbHjFM3qj1VmjHn61+v72Tsv1WHThxISmJbmcdSa6CI57y
 jEK+hRLPSCfXl4G3SGDziw74AoJ/kzLYEvPwgV5bexhAWeMXa+XJz64Trw3m7PciZs6s
 vhrq3V9xHZ+0EA+UWuKWl3diAryUjSlsbgYWjeBAVm6mo6BrnMbKen6zNnj8UfG8mARl
 r9Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbqGGXg+mycCRMywFmItG8l8zkDlL7nL+pEJn8RoaL1SSJt87MttEvkA4O5SpC2/KspB/fCTML8HBg@nongnu.org
X-Gm-Message-State: AFq9FYJ8QLrq7P+9w61jKTy38p0BfUiEKUonrbdy76+pu8jzkwoG7DNc
 2vkRxRDoYjSJflja6iZM6lxZUCH5l0xv2V8NGY7YgDIhYk18mVGAyhrtBWoSvCpPegG9CNrCqiE
 7mHzDBhbEuOtUyWAHF0Jll63HxmSLJL/RVsAVcaHRa96B4TVLM6UIpy4N9w==
X-Gm-Gg: AYBFou1xWLxyJ9Xvuwq9kP81DLFQ0YZBQfMV4BIctR0iQHmn992wm7VE2OlPdrz18pw
 MimkVLTMbZrtoL8ubDywmIrU3hBQCBr0qUdHU6mow0weFq/SowB5qCC1l3vSZpJwSirvCJDAQgu
 Eu49NZDQC6iUOh5AoC7Ohz4ngdJChKGUd/dKvfDd22h9j+9iPb49f/2W7D7QK2O03qUHReLNY77
 +Jxyqh3N66D1y+Rm6oqqBxFchNwv05xhnLRyr4/LOXina17CV9MIxyKl0I+OH4SwggE1fIkbG5Y
 1rVc5h33fjLSXyggVvLFz0f3La9kDmkkBuGy/xdIi4zBGxUkbSMCR5+KmHN7RdJH/UY4eEHilG7
 +JVQ7/LSg6PUT8Is1bzbAPnycrR0SW5yEox+otR/fIduyiJNviWV0XjFMex131WmryeOLDMupH8
 DYE1IhxOod7Vxzrj5DdmMJI8o=
X-Received: by 2002:a05:620a:801c:b0:93f:1dbf:6cfc with SMTP id
 af79cd13be357-94408cfe972mr605097985a.36.1793252818651; 
 Wed, 28 Oct 2026 22:46:58 -0700 (PDT)
X-Received: by 2002:a05:620a:801c:b0:93f:1dbf:6cfc with SMTP id
 af79cd13be357-94408cfe972mr605096985a.36.1793252818245; 
 Wed, 28 Oct 2026 22:46:58 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f4cdbsm45320175e9.7.2026.10.28.22.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 22:46:57 -0700 (PDT)
Message-ID: <4ef98888-b13d-4033-aa02-f48482fc0b7a@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 06:46:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gustavo Romero <gromero@redhat.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
 <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
In-Reply-To: <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae2ddd3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=sNlpPvWGQGutK8D2FkgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: NPCt9lz1L36ZRMihVvn6kCv_pOLDfBvf
X-Proofpoint-ORIG-GUID: NPCt9lz1L36ZRMihVvn6kCv_pOLDfBvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX9wVE1/w1KYGr
 BjXWy7z6A+GhCdBz/76RnG7dVANxTQ1QA9XXQ3IiuIOHRVnAIfELyTcThPLTS9pgD/uAyz10rYY
 VxlMCuE5Zkb2aueoupQdLkgqDzdgIkhAZHCGX58v4DKo7DE9/J/5IIf/eE3Qjon7PEZ+v95OOk/
 ThEnCCWZhYvFyU8Y9G50gN96ak5hvQcHsZyPBwoorYcdv+TFSUaVkRrcJWOCNcwYrE1ZS5Y2t9y
 OzeGtGJTHYfVRPY4vJyqNQUxm1/RsUkS8IlT7SmKLubmpRraljIa01CArVVTUrKuOKtN4wI5qvB
 pY0tu7T2FhtEWZBeeZSui+60opAlJTFE2mQkdyMtVeq5JdcDdv8oHELEqkc2tcsZo2vZWBSyY/3
 0i58jXYIUHTD4v9gZLSVRwHlUSVrNlHljFJq/oLe4K/PcVfq6UnjFJnC5tbn4eOjFOTAm59+Uh/
 MS3TLj6xaptLK/czkxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX7UkNHpzOvZDN
 pZMWpPQBNS4PPecftDD6suEh75jMBbuMJ1b8WYa/OHrEqmvb/4f+CUnCa7Az9lizFCMh9qHL6HF
 1dRarRr6oojtQPCF0wouk2/j0y6Naz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 06:39, Philippe Mathieu-DaudÃ© wrote:
> On 29/10/26 06:33, Pierrick Bouvier wrote:
>> On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
>>> Add R5900 system tests, code is covered, CPU can come back,
>>> allowing to fix a bug on PCGT opcode.


>> See some test failures, related to gdb:
>> https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/ 
>> job/123131480244
> 
> Ah hmm I had similar failures due to too old gdb, I might have
> missed to check the version in that container image. IIRC
> Gustavo had similar problem with ARM I'll see how he fixed
> that (I suppose check gdb version and skip the tests).

Found it, this is 'gdb_feat_version' :)

tests/tcg/meson.build=18=tcg_tests = {}
tests/tcg/meson.build-19-# tcg_tests is a dictionary with following 
structure:
tests/tcg/meson.build-20-#
tests/tcg/meson.build-21-# {
tests/tcg/meson.build-22-#   'name_of_target': {
tests/tcg/meson.build-23-#     'cc': 'cross_compiler',
tests/tcg/meson.build-24-#     'cc_alt': ['list of alternative cross 
compilers', ...]
tests/tcg/meson.build-25-#     'cc_dockerfile': 'name_of_dockerfile',
tests/tcg/meson.build-26-#     'cc_feat_cflags': {
tests/tcg/meson.build-27-#       'name': ['feature cflags'],
tests/tcg/meson.build-28-#       ...
tests/tcg/meson.build-29-#     },
tests/tcg/meson.build-30-#     'folder': 'folder_for_test_src_files',
tests/tcg/meson.build-31-#     'gdb_arch': 'gdb architecture requirement',
tests/tcg/meson.build:32:#     'gdb_feat_version': {
tests/tcg/meson.build-33-#       'name': ['minimal gdb version 
supporting feature'],
tests/tcg/meson.build-34-#       ...
tests/tcg/meson.build-35-#     },
tests/tcg/meson.build-36-#     'qemu': emulators['qemu-...'],
tests/tcg/meson.build-37-#     'tests': [
tests/tcg/meson.build-38-#       {
tests/tcg/meson.build-39-#         'src_file': {
tests/tcg/meson.build-40-#           'exe_name': ['provide an 
alternative binary name'],
tests/tcg/meson.build-41-#           'test_name': ['provide an 
alternative test name'],
tests/tcg/meson.build-42-#           'cflags': ['additional cflags to 
compile test', ...],
tests/tcg/meson.build-43-#           'depends': [meson_dependency, ...],
tests/tcg/meson.build-44-#           'cc_feat': 'feature name, must be 
present in cc_feat_cflags',
tests/tcg/meson.build-45-#           'qemu_args': ['qemu command line 
flags', ...],
tests/tcg/meson.build-46-#           'expected_output': 
'file_to_compare_output',
tests/tcg/meson.build-47-#           'gdb_test': ['gdb test args'],
tests/tcg/meson.build:48:#           'gdb_feat': ['feature name, must be 
present in gdb_feat_version'],
tests/tcg/meson.build-49-#           'env_var': ['VAR=value', ...],
tests/tcg/meson.build-50-#           'wrapper': [program_to_launch_test, 
'args'...],
tests/tcg/meson.build-51-#           'plugin_test': {
tests/tcg/meson.build-52-#             'plugin': 'plugin_name',
tests/tcg/meson.build-53-#             'args': ['plugin_args', ...],
tests/tcg/meson.build-54-#           },
tests/tcg/meson.build-55-#         }
tests/tcg/meson.build-56-#       },
tests/tcg/meson.build-57-#       ...
tests/tcg/meson.build-58-#     ]
tests/tcg/meson.build-59-#   }
tests/tcg/meson.build-60-# }

tests/tcg/meson.build=200=foreach target, plan: tcg_tests

tests/tcg/meson.build:518:        if not 
gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
tests/tcg/meson.build-519-          skip_test = 'gdb feature ' + 
gdb_feat + ' not supported'
tests/tcg/meson.build-520-        endif

tests/tcg/aarch64/meson.build:18:gdb_feat_version = {
tests/tcg/aarch64/meson.build-19-  'sme-tiles': '14.1',
tests/tcg/aarch64/meson.build-20-  'mte': '15.1',
tests/tcg/aarch64/meson.build-21-  'mte-baremetal': '16.0',
tests/tcg/aarch64/meson.build-22-}

tests/tcg/aarch64/meson.build=196=if 'qemu-aarch64' in emulators
tests/tcg/aarch64/meson.build-197-  tcg_tests += {
tests/tcg/aarch64/meson.build-198-    'aarch64-linux-user': {
tests/tcg/aarch64/meson.build-199-      'cc': cc,
tests/tcg/aarch64/meson.build-200-      'cc_alt': cc_alt,
tests/tcg/aarch64/meson.build-201-      'cc_dockerfile': cc_dockerfile,
tests/tcg/aarch64/meson.build-202-      'cc_feat_cflags': cc_feat_cflags,
tests/tcg/aarch64/meson.build-203-      'folder': 'aarch64',
tests/tcg/aarch64/meson.build-204-      'gdb_arch': 'aarch64',
tests/tcg/aarch64/meson.build:205:      'gdb_feat_version': 
gdb_feat_version,
tests/tcg/aarch64/meson.build-206-      'qemu': emulators['qemu-aarch64'],
tests/tcg/aarch64/meson.build-207-      'tests': tests,
tests/tcg/aarch64/meson.build-208-    }
tests/tcg/aarch64/meson.build-209-  }



