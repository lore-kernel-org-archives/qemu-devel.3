Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE43606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nta5YEQi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TsqN8ww+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNu5-0006vR-0t; Fri, 06 Nov 2026 12:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNu3-0006vE-Eu
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:39:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNu1-0005Q2-4s
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:39:03 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F03Jx045199
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OhUPnoI8i6wvko0Ubc293zTuhe9aPN0Lzf1bwh0vIVg=; b=nta5YEQi4477WcBm
 llJ6uD2JkY7JDKV220w56EAV9j5AZ9crOdo1hEOIK+9CyTsADjLNEZQQMzLWZlkS
 c3lfXeEKBu7L+F1t1M544bnB6ucUtaEwwPYw9MdwHzuINsG0BhJ9SkrHt34H/pix
 hXQ65KHc+011N4bjzclGz5U7UxVl7dGv/jur7a/s0AvlXKAK1YI2nCeigrbNN5B9
 4FYeUNKzxR/2XG482DjUkOomTFZ5QvwE4+IQXy82MW9HuLTyN1Zlbw56GolQg6mX
 BmszcABFwSyWnM6AQiApqBkBRR4VSVW7Ya6Rak3xO3CCvhTLcf6MRfMNCPdlXZhq
 Ln6q+Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3wgd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:38:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so3338807c88.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793986738; x=1794591538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OhUPnoI8i6wvko0Ubc293zTuhe9aPN0Lzf1bwh0vIVg=;
 b=TsqN8ww+cpy1LJjp4aApMdyWzOPfujDB1jTwVUUfJTooQISmA2r+1Ryj82kXfKLXl5
 DhSWu2who7ngkEvkH/v/kukZ/+m3425/5wZWuw+nFZzlG/1ysokgehRFVL/DKVp9GnKo
 EwfAlwStkwQ9MGaTm3v8rxJfSFp8xtieoJCBxqj0FPOvlXUmLqW+ke7rGhf889PdXmPm
 C4Z0XIjoKVzg2Xqq/scIFFTZOLNahoa1PsSyutBi1WDyCZ1X/7ZUC6Gn5F5RJgo0TuEC
 5e9z1sYcWa7iBuN16xnLqZMs+ApeqpECfSFALY3tQoNUnLwk8q1E38ziFKXKBmZP148r
 Cy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986738; x=1794591538;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OhUPnoI8i6wvko0Ubc293zTuhe9aPN0Lzf1bwh0vIVg=;
 b=xx+eYOor/MwMTeopdcxZpPJ605MCkFSIdOXy8AoIHT3NKgmBJ/YnEttDy3cRz5mh6o
 dA4wrnwm1iVggmdhdd+WYodPx+ef3VXmhI1eCtSe180U0BlBJc+tK7YmlJ9dsstQrBg0
 uYGK+MD+4tz50vTyT6nxCkEqDB1kF+8b+FpxFNYRA9fSe7T9r9vxGpmzxzRddkt5xQpt
 ZV1YHMf3j/pcZixo1gc/mgIPHwPH5ywOHvsugSZ5cN9aqpnSg9Re57KM3UJEBVoH6psA
 lmbZm+GyCsRNheIyEi0u4OSptvGtoLlLj4QEsK1j+q8ZwBqGq9PfKMSA0oZ6Hby/09oq
 0Svg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg2DFmn88/uWjAkHYB6VwJobfXymzL3ce4KikpiJVtFnjMVuI2yjMtMLi6ZFq9kD19aeygFZQzMkG4@nongnu.org
X-Gm-Message-State: APuU4Z8rXOyRIdkUZlHO2ASEQUY/zpz2R1QMTPRKP6SyYRfdTESdQiCa
 5OhM0gMAVgPvynBinkuRvCEit/ZkhPCK0OwZAaa1hJzIIPKIl05si/HJaI0YokNydomU7aGBLuB
 Ip88p5ZURGNUiwdVfJF7oFb5S8fEYT+7366uOpPSe69EPTBq4Br8j+dQZQA==
X-Gm-Gg: AYBFou3z7SEDa0Mr4EQztxYBwerKqg40OAH32qTvW4ay72MDRudzfNNfYMrX+iDs8no
 Rn/kICyjYqLKEgEssDsikxEb2Ufpx03ku4g4ghGmWyEKH2xOcP/KEvQaQ+UB8gDgdg3BLTQYEE+
 UJ/X2rKbePz98TEz4MbJ/XMOTSzNjtiMdul0j2JcXA7nNPXTT0CtAaCTtjm/fFtWAl8TXRh5+bE
 moczXWXqI7rAIIAC7mYjmNX+jFFJ65eHwlqFtmXihEgnl44xENlibPzulR21sfquq+QL2IgSQpq
 TLEqOv0DEKBM+BPRukXy2BvK7zae6vKMgm3gRe1OnghdO4MP9+XZ9aUJgvAr6/SE1nA3R+v1zN/
 BClib06bou45YU3ROdPNGzBQSmqEZuh6bLk8K5Dup8n8p4yJJO73JzuVaY05BNRQ5eBz1uZxqxp
 bC/rAgcsCHPAmF8lu5HaIru1b09SLr4XeoYw4e4UMllg==
X-Received: by 2002:a05:701b:4250:20b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1b25d361f47mr4181689c88.39.1793986737731; 
 Fri, 06 Nov 2026 09:38:57 -0800 (PST)
X-Received: by 2002:a05:701b:4250:20b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1b25d361f47mr4181643c88.39.1793986736911; 
 Fri, 06 Nov 2026 09:38:56 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4fd2d6sm7327884c88.23.2026.11.06.09.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:38:56 -0800 (PST)
Message-ID: <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:38:54 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs: add a diagram of the development process
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20261106122111.3005638-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106122111.3005638-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aee10b2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=kne_o7KXAAAA:8 a=KKAkSRfTAAAA:8 a=z-U45okY2Ogv-PVlNlwA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=c4Qo8gn-6q4hmEPFHG3F:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX7xPtDvFZ+McF
 3479zdoZOgCp5VxOwXKfoctXdKTIcMnWp5NsCrX9Bzhfj6gK4TF3AoEhp0lOxHpzZPDO2wp+1uX
 4JGitAj/TAJg45AvM5kfynx3pgKwJYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX/LYR2h827LST
 1YfizZ0jUOLTGkE2EuOkpgMTYL5PC6PpstpgD4DitcAlwDIlThQd73xjvEbW2JRj91XksvGUd3x
 +8np/5dxXYaG4jxKG310w8TrzY5OJdJ+7oEHBe9jWqIcMKpfxn64RFmuMc7ZGXw+tGmEVX+0KG+
 WqwkS/1ICL3AdBFfBZBG6mNmu1kdj8h+FRvYcPnNiJGawOLjya0vb6z2rt8I1ABCGhfUd0jLGD5
 vLaWl0gJzvDCrsnMaL3cH28kQHN1Uk1xNxNvJxow7z8XfhF4ltSpzrepYto+PdxzGoqq4cosOlM
 2vkgzN3MVufLTBF83KjvvpRSbtvkQf5SOR368ko1KAFMin65n7QnxVmNqCtkbgrhlBFoBJg23Iu
 OhzOscqhj8O5IVtNGdP8tku7+5wQC2G7VbIq8LFjm5OgfDIZjEC0SgOJFEDqbP2hfnCCc2ebkW4
 pAxOsVuHCiQJjhF1Rvg==
X-Proofpoint-GUID: Rrtp5nV2YWuBZDvqhI2pDtbFb4meJ22k
X-Proofpoint-ORIG-GUID: Rrtp5nV2YWuBZDvqhI2pDtbFb4meJ22k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 4:21 AM, Alex Bennée wrote:
> We've had various versions of this diagram for a while so I thought it
> would be worth adding to the developer docs. I chose plantuml as it
> has a plugin for sphinx that we can use and supports sequence diagrams
> which could be useful for documenting other features in the code base.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> vRFC
>   - I've bundled all the plumbing together in this commit but it can
>   be split up if we want to go forward.
> ---
>  docs/conf.py                    | 22 +++++++++++++++
>  docs/devel/index-process.rst    | 47 +++++++++++++++++++++++++++++++++
>  docs/meson.build                |  3 ++-
>  docs/requirements.txt           |  1 +
>  configure                       |  6 +++++
>  pythondeps.toml                 |  1 +
>  tests/lcitool/mappings.yml      |  3 +++
>  tests/lcitool/projects/qemu.yml |  1 +
>  8 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index 914bae67d9c..9fc7be362ba 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -66,8 +66,11 @@
>      'qapi_domain',
>      'qapidoc',
>      'qmp_lexer',
> +    'sphinxcontrib.plantuml',
>  ]
>  
> +plantuml_output_format = 'svg'
> +
>  # Add any paths that contain templates here, relative to this directory.
>  templates_path = [os.path.join(qemu_docdir, '_templates')]
>  
> @@ -345,3 +348,22 @@
>  qapidoc_srctree = os.path.join(qemu_docdir, '..')
>  dbusdoc_srctree = os.path.join(qemu_docdir, '..')
>  dbus_index_common_prefix = ["org.qemu."]
> +
> +
> +def setup(app):
> +    import docutils.nodes
> +    import sphinxcontrib.plantuml
> +
> +    # We manually setup the plantuml extension so we can skip nodes with
> +    # diagrams when generating the text based output.
> +
> +    def skip_node(self, node):
> +        raise docutils.nodes.SkipNode
> +
> +    app.setup_extension('sphinxcontrib.plantuml')
> +    app.add_node(
> +        sphinxcontrib.plantuml.plantuml,
> +        override=True,
> +        man=(skip_node, None),
> +        text=(skip_node, None),
> +    )
> diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
> index ce0f4e73197..1c13dd3f7b5 100644
> --- a/docs/devel/index-process.rst
> +++ b/docs/devel/index-process.rst
> @@ -5,6 +5,53 @@ QEMU Community Processes
>  
>  Notes about how to interact with the community and how and where to submit patches.
>  
> +.. uml::
> +   :caption: QEMU Patch Review and Acceptance Flow
> +
> +   @startuml
> +   skinparam roundCorner 8
> +   skinparam shadowing false
> +   skinparam defaultFontName monospace
> +   skinparam sequenceMessageAlign center
> +
> +   actor "Developer" as dev
> +   participant "QEMU Community\n(qemu-devel)" as list
> +   actor "Subsystem\nMaintainer" as sub
> +   actor "QEMU\nMaintainer" as top
> +
> +   dev -> dev: Develop & test feature
> +
> +   loop Needs revision (v1, v2, ... vn)
> +       dev -> list: Post patch series to list
> +       note over list: Code review on list
> +
> +       opt Review comments
> +           list -> dev: Feedback & change requests
> +           dev -> dev: Incorporate feedback
> +       end
> +       opt Review tags
> +           list -> dev: Tags (Reviewed-by, Acked-by, ...)
> +           dev -> dev: Apply tags
> +       end
> +
> +       dev -> dev: Prepare n+1
> +   end
> +
> +   group Patch acceptance & release
> +       list -> sub: Maintainer accepts some or all patches
> +       note over sub: Incorporates patches\nfrom other developers
> +       sub -> sub: Add Maintainer Sign-off
> +       sub -> sub: GIT branch foo/next
> +       sub -> list: Sign & Submit Pull Request
> +       list -> top: Pull Request delivered to list
> +       note over top: Pull Requests from\nother maintainers
> +       top -> top: Test and Merge Pull Reqs
> +       top -> top: qemu.git master
> +       top -> top: Tag Release
> +       top -> list: QEMU Release
> +   end
> +   @enduml
> +
>  .. toctree::
>     :maxdepth: 2
>  
> diff --git a/docs/meson.build b/docs/meson.build
> index 4d8cc545fcc..600d3283299 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -1,9 +1,10 @@
>  sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
>                              required: get_option('docs'))
> +plantuml = find_program('plantuml', required: get_option('docs'))
>  
>  # Check if tools are available to build documentation.
>  build_docs = false
> -if sphinx_build.found()
> +if sphinx_build.found() and plantuml.found()
>    SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q']
>    # If we're making warnings fatal, apply this to Sphinx runs as well
>    if get_option('werror')
> diff --git a/docs/requirements.txt b/docs/requirements.txt
> index 509d56bd1e8..1cafcbaa38f 100644
> --- a/docs/requirements.txt
> +++ b/docs/requirements.txt
> @@ -3,3 +3,4 @@
>  
>  sphinx==7.2.6
>  sphinx_rtd_theme==2.0.0
> +sphinxcontrib-plantuml==0.30
> diff --git a/configure b/configure
> index 42dffed28f0..b0dedde65dd 100755
> --- a/configure
> +++ b/configure
> @@ -1020,6 +1020,12 @@ if test "$docs" != "disabled" ; then
>          fi
>          echo "Sphinx not found/usable, disabling docs."
>          docs=disabled
> +    elif ! has plantuml; then
> +        if test "$docs" = "enabled" ; then
> +            error_exit "plantuml not found"
> +        fi
> +        echo "plantuml not found, disabling docs."
> +        docs=disabled
>      else
>          docs=enabled
>      fi
> diff --git a/pythondeps.toml b/pythondeps.toml
> index c9a697046c6..c21d127ec93 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -30,6 +30,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
>  # Please keep the installed versions in sync with docs/requirements.txt
>  sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
>  sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
> +sphinxcontrib-plantuml = { accepted = ">=0.5", installed = "0.30" }
>  
>  # This test group is for dependencies required to run various tooling
>  # and tests that should always be installed at configure time. It should
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index c99f007798e..eca6748ac09 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -3,6 +3,9 @@ mappings:
>    bindgen:
>      Ubuntu2204:
>  
> +  plantuml:
> +    default: plantuml
> +
>    python3:
>      CentOSStream9: python3.12
>  
> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
> index abbd3e3f0b8..de4395cd3c7 100644
> --- a/tests/lcitool/projects/qemu.yml
> +++ b/tests/lcitool/projects/qemu.yml
> @@ -89,6 +89,7 @@ packages:
>   - pcre-static
>   - pixman
>   - pkg-config
> + - plantuml
>   - pulseaudio
>   - python3
>   - python3-numpy

It will silently disable doc by default for most of the people
unfortunately, not sure it's the best move we can do.

Maybe a simpler solution could be to generate diagrams out of sphinx,
add them as a dependency, and generate a blank image (or an image with
diagram source and a message - please install plantuml) if not
available. What does plantuml brings compares to graphviz builtin extension?

Also, text diagrams (https://asciidraw.github.io/) with raw formatting
have the advantage to not require any external tool.

What do you think?

Regards,
Pierrick

