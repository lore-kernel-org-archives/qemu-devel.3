Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EF606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fJXSWF4A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RUf2X3U4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPR4C-0001UB-W6; Fri, 06 Nov 2026 16:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPR4B-0001Tz-Ro
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 16:01:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPR47-0002T5-Rk
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 16:01:43 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JKqvV3899134
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 21:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t+oeOoYRU6AUSq321Zu3GMaLPy3AOQQKytY2/lBdGvQ=; b=fJXSWF4A2isMJ3uZ
 DvQ24rIPS5LVIGlSUWaeptf+J5DBHvxE7ormSWkdkTYjKSgQ6n1rkt1ZTH+eFvKc
 97al1IQqWGNScvxLT1MnVd9tcaI4peB8mcxXLJo3glTVOAv3/O0qi2S240FE+LEO
 eXeRRDHeprwXEmfwP3svM/suRafYcbujt9xlDD3044rX3K4Ai7TCZNTQSSGH+9i0
 bd7OmjvLaNyuQkQ2V6i5jVdITS9Mw2hutHq0o3Zv+ITBqtWsy+TeYBPFDBVFUalo
 7YFNf7qcrUiUPTOxQxpQfd5NZpaBx8IQrIeJdarIEg02L+jJfFlYbX/gjURPuFFv
 vtuAYg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyk0b92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 21:01:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b20a4b5f2bso1517673c88.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793998897; x=1794603697; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t+oeOoYRU6AUSq321Zu3GMaLPy3AOQQKytY2/lBdGvQ=;
 b=RUf2X3U4oc5ixlIq0u7STx4SQtJNxd5pfGWLpVq3umMECKW/Y0a3PEDjGLFK/HFRwt
 gD2zI2CFCT9orjkmIO5NPDG2L9NcNKdUk3vGv1jrLPyds/tZer9caVDT/xTxBK5L1GLU
 VICtMdUQoaEvZtVztmZi6Er5eNgUbCLDmiTSmGJGcQpi7WWfu0i4h5Sgyz0gbn0WbonA
 ZnH5bHILU8gm8VPHPhR4cgiImNlIKIItpJUe2rgEArnAnA1zSLyudT5vLuWvWI3aUD64
 4AmRsTsyxaw9tuuLx6lL4TTfdDjoFbVNHY7QDP25wCI+FuHc3/CeuN00YyNw8g8X5p+G
 lJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998897; x=1794603697;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t+oeOoYRU6AUSq321Zu3GMaLPy3AOQQKytY2/lBdGvQ=;
 b=mogvjp3G/KB9C2rIynQB05ABUZ0cYisZLYIp53Us2GUltqg+5nJ/5vdvmBD0V2VYmN
 WS552LZEpyOlTreULaeu2imNy2AJm/mYAp3watP8jt4RiCa2Sd1uXEqW/quKT8kqIzZP
 4EPY38O6KP1htM8f93MZZ2pnnjFhqpeQyxo74RcEz1IeO1gVXvuk0UGKb25gQYvpu/io
 lgunEjP2oYCx3PVTgyVLgSwOG86hY8IGMp6GtchIMZisjwNtjRB13qODnMB+rrlXzRN/
 p4Bwaa9qa/D8tC7LFABiEtAxnIDz6PA6Em6zmldYfpas0IxgWP541xAgs3YRpL49BWu7
 LP6Q==
X-Gm-Message-State: APuU4Z+PgBgB6bOoS825AJdtRjv4N9TLQ9PvJFRVb38/mI2z9GYyqZCp
 omAfBmSYGEcD51cccTwlDpRPtZ0/FThzrOqrwbYypLzKlW/bgBPrchAzzNNfDHkIM2XiTxYBt2s
 MnfUDPeF6LvoyIVctaU0e//XHtJ0rwiraRW9HztTlgqNLRw+F3YOsy7mO5Q==
X-Gm-Gg: AYBFou1JXEh88AxLhLJIAtKhIUDHGmLfijI2kfqPvqSx8eHNkyLD+aX1dalisb7dx9i
 /VrifXKz3qvJu97NME4atSvLNZStC9fGRZ1JtxmCtsJgndSTD42PPkHxaBjtVocuv/L+4ntOMPN
 ZJq2uWYpy+mTjflqxYpOZA4vablqMYvg6fHHpYM8nIi8vbBx3ZP7xgW6Q066vXRCXaUR9PUrWyL
 FkmCdCLGUQFnJu4NOzE/A94ofUbxESDbBvaY5CNy3Ha5hU/3zsG3zfIUChTWLu5rMTKhyP1D402
 yiKn9dff5jvmrHr0FmHRa1x4Av40Stst3FWHUwCZcjKLssiGYcjwUc7OTHebS33f4bqcnMrigkc
 d+ZwPOELXuPqyIpavSmiiNxYfSMnu0PJf7gIW0XDrgMqLH24JIlRA0kAx0hDbu7y99NnY8+Ev9/
 +TrmNuLTKYknl5hglaKN4jrRv8iaLAoys54/7U9VBHLQ==
X-Received: by 2002:a05:7023:a44:b0:1b2:471f:c4c with SMTP id
 a92af1059eb24-1b25d32ad10mr4270525c88.19.1793998896630; 
 Fri, 06 Nov 2026 13:01:36 -0800 (PST)
X-Received: by 2002:a05:7023:a44:b0:1b2:471f:c4c with SMTP id
 a92af1059eb24-1b25d32ad10mr4270471c88.19.1793998895644; 
 Fri, 06 Nov 2026 13:01:35 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa651eccdsm9260964eec.1.2026.11.06.13.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:01:34 -0800 (PST)
Message-ID: <b6a6e0bc-90b0-4162-8ec9-098d1ced1069@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 13:01:33 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs: add a diagram of the development process
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20261106122111.3005638-1-alex.bennee@linaro.org>
 <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com>
 <87ld7566jz.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ld7566jz.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6VpO6EOf-7EL5xudg7Hg_1805Gzjj1bX
X-Proofpoint-ORIG-GUID: 6VpO6EOf-7EL5xudg7Hg_1805Gzjj1bX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MyBTYWx0ZWRfXyMglnG24myFY
 Bd0tHz/UJzHlwvsk14I6lpz5KL3SYcBAabJa2hYMmQ6q4dUYWRJ2RwoN17vJ2CydX75dJmzFHR7
 eoG9AWQ562tjjyc8/XcNh8Z8wEYuRHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MyBTYWx0ZWRfXw2bdsG9biSJy
 p1kCuC8iFJbbRgPHzuLGavNjsDypS8u/h2sBs8r+GDYsvHgliEs7WT1vrJ53Wjy3vq9AFDSTJi8
 pkpsfNkIMVQLN3NAl8rF1c5OzOirpI2YID30psYN/dIjPcGIj5wl/stagJUaogGEHc3nZQyPiFm
 /YANgZ27El7Hsxf8oa7Ys647nil3/o3H99OWTtklmF74hsf+9A6ezIrgFAWgwWkOBfOiHT/aViN
 g3Vd22nd3ph9irMaxAOZ0U16T8biD0hnL13RRrt7F0kM6MM3FVSmPnvyMOmVhLkMLrcN6N+BNZ5
 hy/j3JEyZkcXpfchvEWKT8jNOwBUsd3IRrIMkT1jLyQZCUhoQpuq6uUb38tZ4N8RdxMl/zzpMp+
 oU7YB8WsAbAOcSvqH2P0G7NvVI+F6B9Q4drdwDcEiV1p8ufRt/+SQc4YOkzCsSBVVw2Gbg9bTnX
 GIHpB3Ij84QUJ0COdIA==
X-Authority-Analysis: v=2.4 cv=I5Tw19gg c=1 sm=1 tr=0 ts=6aee4031 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=kne_o7KXAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=xIAX1rflKf4-liiSGw8A:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=c4Qo8gn-6q4hmEPFHG3F:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060083
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 12:36 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 11/6/2026 4:21 AM, Alex Bennée wrote:
>>> We've had various versions of this diagram for a while so I thought it
>>> would be worth adding to the developer docs. I chose plantuml as it
>>> has a plugin for sphinx that we can use and supports sequence diagrams
>>> which could be useful for documenting other features in the code base.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>> ---
>>> vRFC
>>>   - I've bundled all the plumbing together in this commit but it can
>>>   be split up if we want to go forward.
>>> ---
>>>  docs/conf.py                    | 22 +++++++++++++++
>>>  docs/devel/index-process.rst    | 47 +++++++++++++++++++++++++++++++++
>>>  docs/meson.build                |  3 ++-
>>>  docs/requirements.txt           |  1 +
>>>  configure                       |  6 +++++
>>>  pythondeps.toml                 |  1 +
>>>  tests/lcitool/mappings.yml      |  3 +++
>>>  tests/lcitool/projects/qemu.yml |  1 +
>>>  8 files changed, 83 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/docs/conf.py b/docs/conf.py
>>> index 914bae67d9c..9fc7be362ba 100644
>>> --- a/docs/conf.py
>>> +++ b/docs/conf.py
>>> @@ -66,8 +66,11 @@
>>>      'qapi_domain',
>>>      'qapidoc',
>>>      'qmp_lexer',
>>> +    'sphinxcontrib.plantuml',
>>>  ]
>>>  
>>> +plantuml_output_format = 'svg'
>>> +
>>>  # Add any paths that contain templates here, relative to this directory.
>>>  templates_path = [os.path.join(qemu_docdir, '_templates')]
>>>  
>>> @@ -345,3 +348,22 @@
>>>  qapidoc_srctree = os.path.join(qemu_docdir, '..')
>>>  dbusdoc_srctree = os.path.join(qemu_docdir, '..')
>>>  dbus_index_common_prefix = ["org.qemu."]
>>> +
>>> +
>>> +def setup(app):
>>> +    import docutils.nodes
>>> +    import sphinxcontrib.plantuml
>>> +
>>> +    # We manually setup the plantuml extension so we can skip nodes with
>>> +    # diagrams when generating the text based output.
>>> +
>>> +    def skip_node(self, node):
>>> +        raise docutils.nodes.SkipNode
>>> +
>>> +    app.setup_extension('sphinxcontrib.plantuml')
>>> +    app.add_node(
>>> +        sphinxcontrib.plantuml.plantuml,
>>> +        override=True,
>>> +        man=(skip_node, None),
>>> +        text=(skip_node, None),
>>> +    )
>>> diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
>>> index ce0f4e73197..1c13dd3f7b5 100644
>>> --- a/docs/devel/index-process.rst
>>> +++ b/docs/devel/index-process.rst
>>> @@ -5,6 +5,53 @@ QEMU Community Processes
>>>  
>>>  Notes about how to interact with the community and how and where to submit patches.
>>>  
>>> +.. uml::
>>> +   :caption: QEMU Patch Review and Acceptance Flow
>>> +
>>> +   @startuml
>>> +   skinparam roundCorner 8
>>> +   skinparam shadowing false
>>> +   skinparam defaultFontName monospace
>>> +   skinparam sequenceMessageAlign center
>>> +
>>> +   actor "Developer" as dev
>>> +   participant "QEMU Community\n(qemu-devel)" as list
>>> +   actor "Subsystem\nMaintainer" as sub
>>> +   actor "QEMU\nMaintainer" as top
>>> +
>>> +   dev -> dev: Develop & test feature
>>> +
>>> +   loop Needs revision (v1, v2, ... vn)
>>> +       dev -> list: Post patch series to list
>>> +       note over list: Code review on list
>>> +
>>> +       opt Review comments
>>> +           list -> dev: Feedback & change requests
>>> +           dev -> dev: Incorporate feedback
>>> +       end
>>> +       opt Review tags
>>> +           list -> dev: Tags (Reviewed-by, Acked-by, ...)
>>> +           dev -> dev: Apply tags
>>> +       end
>>> +
>>> +       dev -> dev: Prepare n+1
>>> +   end
>>> +
>>> +   group Patch acceptance & release
>>> +       list -> sub: Maintainer accepts some or all patches
>>> +       note over sub: Incorporates patches\nfrom other developers
>>> +       sub -> sub: Add Maintainer Sign-off
>>> +       sub -> sub: GIT branch foo/next
>>> +       sub -> list: Sign & Submit Pull Request
>>> +       list -> top: Pull Request delivered to list
>>> +       note over top: Pull Requests from\nother maintainers
>>> +       top -> top: Test and Merge Pull Reqs
>>> +       top -> top: qemu.git master
>>> +       top -> top: Tag Release
>>> +       top -> list: QEMU Release
>>> +   end
>>> +   @enduml
>>> +
>>>  .. toctree::
>>>     :maxdepth: 2
>>>  
>>> diff --git a/docs/meson.build b/docs/meson.build
>>> index 4d8cc545fcc..600d3283299 100644
>>> --- a/docs/meson.build
>>> +++ b/docs/meson.build
>>> @@ -1,9 +1,10 @@
>>>  sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
>>>                              required: get_option('docs'))
>>> +plantuml = find_program('plantuml', required: get_option('docs'))
>>>  
>>>  # Check if tools are available to build documentation.
>>>  build_docs = false
>>> -if sphinx_build.found()
>>> +if sphinx_build.found() and plantuml.found()
>>>    SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q']
>>>    # If we're making warnings fatal, apply this to Sphinx runs as well
>>>    if get_option('werror')
>>> diff --git a/docs/requirements.txt b/docs/requirements.txt
>>> index 509d56bd1e8..1cafcbaa38f 100644
>>> --- a/docs/requirements.txt
>>> +++ b/docs/requirements.txt
>>> @@ -3,3 +3,4 @@
>>>  
>>>  sphinx==7.2.6
>>>  sphinx_rtd_theme==2.0.0
>>> +sphinxcontrib-plantuml==0.30
>>> diff --git a/configure b/configure
>>> index 42dffed28f0..b0dedde65dd 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1020,6 +1020,12 @@ if test "$docs" != "disabled" ; then
>>>          fi
>>>          echo "Sphinx not found/usable, disabling docs."
>>>          docs=disabled
>>> +    elif ! has plantuml; then
>>> +        if test "$docs" = "enabled" ; then
>>> +            error_exit "plantuml not found"
>>> +        fi
>>> +        echo "plantuml not found, disabling docs."
>>> +        docs=disabled
>>>      else
>>>          docs=enabled
>>>      fi
>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>> index c9a697046c6..c21d127ec93 100644
>>> --- a/pythondeps.toml
>>> +++ b/pythondeps.toml
>>> @@ -30,6 +30,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
>>>  # Please keep the installed versions in sync with docs/requirements.txt
>>>  sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
>>>  sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
>>> +sphinxcontrib-plantuml = { accepted = ">=0.5", installed = "0.30" }
>>>  
>>>  # This test group is for dependencies required to run various tooling
>>>  # and tests that should always be installed at configure time. It should
>>> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
>>> index c99f007798e..eca6748ac09 100644
>>> --- a/tests/lcitool/mappings.yml
>>> +++ b/tests/lcitool/mappings.yml
>>> @@ -3,6 +3,9 @@ mappings:
>>>    bindgen:
>>>      Ubuntu2204:
>>>  
>>> +  plantuml:
>>> +    default: plantuml
>>> +
>>>    python3:
>>>      CentOSStream9: python3.12
>>>  
>>> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
>>> index abbd3e3f0b8..de4395cd3c7 100644
>>> --- a/tests/lcitool/projects/qemu.yml
>>> +++ b/tests/lcitool/projects/qemu.yml
>>> @@ -89,6 +89,7 @@ packages:
>>>   - pcre-static
>>>   - pixman
>>>   - pkg-config
>>> + - plantuml
>>>   - pulseaudio
>>>   - python3
>>>   - python3-numpy
>>
>> It will silently disable doc by default for most of the people
>> unfortunately, not sure it's the best move we can do.
> 
> plantuml seems to be pretty widely packaged so in this sense its just
> another dependency.
> 
>> Maybe a simpler solution could be to generate diagrams out of sphinx,
>> add them as a dependency, and generate a blank image (or an image with
>> diagram source and a message - please install plantuml) if not
>> available. What does plantuml brings compares to graphviz builtin
>> extension?
> 
> Ohh I didn't realize there was graphviz - I'll see if I can recreate
> with that.
>

If graphviz is not installed, a warning is emitted, which stops the
build since we turn warnings into error.

The warning emitted has no type, so it can't be filtered with
suppress_warning setting from sphinx-build.

However, since sphinx uses standard logging framework, you can silence
it this way: https://github.com/sphinx-doc/sphinx/issues/10219

```
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -24,6 +24,7 @@
+import logging
 import os
 import sys
 import sphinx
@@ -66,8 +67,20 @@
     'qapi_domain',
     'qapidoc',
     'qmp_lexer',
+    'sphinx.ext.graphviz',
 ]

+# Render graphviz diagrams as SVG so they scale cleanly in HTML output.
+graphviz_output_format = 'svg'
+
+# Silence the warning emitted by sphinx.ext.graphviz when 'dot' is not
+# installed. Diagrams are then rendered as their raw source instead.
+class _NoDotWarning(logging.Filter):
+    def filter(self, record):
+        return 'cannot be run (needed for graphviz output)' not in
record.getMessage()
+
+logging.getLogger('sphinx.sphinx.ext.graphviz').addFilter(_NoDotWarning())
```

The advantage is that graphviz is not a required dependency, so doc is
still built for anyone having sphinx installed. That's a nice end result
I think.

>> Also, text diagrams (https://asciidraw.github.io/) with raw formatting
>> have the advantage to not require any external tool.
> 
> I have the ascii original although ditaa seemed more of a stretch:
> 
> --8<---------------cut here---------------start------------->8---
> #+name: QEMU Development Process
> #+begin_src ditaa :cmdline -T -o :file images/qemu-dev-process.png
>            Developer                                   QEMU Community                           Subsystem Maintainer
>   +-=--------------------------+   +-=---------------------------------------------------+   +-=----------------------+
>   |                            |   |                                                     |   |                        |
>   |    +-------------------+   |   |  +-----------------------------------------------+  |   |   +----------------+   |
>   |    |{io}               |   |   |  |{io}                                           |  |   |   |{io}            |   |
>   |    |  Develop and      |   | +--->|              Code Review on List              |  | +---->| Add Maintainer |   |
>   |    |   Test feature    |   | | |  |                                               |  | | |   |    Sign-off    |   |
>   |    |                   |   | | |  +------+----------------+----------------+------+  | | |   |                |   |
>   |    +--------+----------+   | | |         |                |                |         | | |   +-------+--------+   |
>   |             |              | | |         V                V                V         | | |           |            |
>   |             V              | | :  +-------------+  +-------------+  +-------------+  | | |           v            |
>   |    +-------------------+   | | |  |{d}          |  |{d}          |  |{io}         |  | | |   +----------------+   |
>   |    |{io}               |   | | |  |  Review     |  |  Review     |  | Maintainer  |  | | |   |{s}             |   |
>   | +->|  Post to List     +-----+ |  |    Comments |  |    Tags     |  |  accepts    |  | | |   |   GIT Branch   |   |
>   | |  |                   |   |   |  |             |  |             |  | some or all |  | | |   |    foo/next    |   |
>   | |  +-------------------+   |   |  |             |  |             |  |  patches    |  | | |   |                |   |
>   | |                          :   |  +------+------+  +------+------+  +------+------+  | | :   |                |   |
>   | |  +-------------------+   |   |         |                |                |         | | |   |                |   |
>   | |  |{io}               |<----------------+                |                +-----------+ |   |                |   |
>   | |  |    Incorporate    |                                  |                          |   |   |                |   |
>   | |  |     Feedback      |<---------------------------------+                          |   |   |                |   |
>   | |  +--------+----------+   |   |                                                     :   |   +-------+--------+   |
>   | |           |              :   +-----------------------------------------------------+   |           |            |
>   | |           v              |                                                             |           V            |
>   | |  +-------------------+   |                       QEMU Maintainer                       |   +----------------+   |
>   | |  |{io}               |   |  +-=-----------------------------------------------------+  |   |{io}            |   |
>   | |  |    Prepare n+1    |   |  | +-------------+  +--------------+  +----------------+ |  |   |  Sign & Submit |   |
>   | |  |                   |   |  | |{io}         |  |{s}           |  |{io}            | |  |   |      Pull      |   |
>   | |  +--------+----------+   |  | | Tag Release |<-+   qemu.git   |<-+ Test and Merge |<-------+     Request    |   |
>   | |           |              |  | |             |  |    master    |  |    Pull Reqs   |<-+ |   |                |   |
>   | +-----------+              |  | |             |  |              |  |                | || |   +----------------+   |
>   |                            |  | +------+------+  +--------------+  +----------------+ || |                        |
>   +----------------------------+  +--------+----------------------------------------------+| +------------------------+
>                                            +----------------+                              |
>                                                             |                              |
>                                                             V                              |       Pull Requests
>                                                      +--------------+                      +----       from
>                                                      |{d}           |                            Other Maintainers
>                                                      |     QEMU     |
>                                                      |    Release   |
>                                                      |              |
>                                                      |              |
>                                                      +--------------+
> 
> #+end_src
> --8<---------------cut here---------------end--------------->8---
>

Nice diagram!
Better in picture indeed.

> 
>>
>> What do you think?
>>
>> Regards,
>> Pierrick
> 


