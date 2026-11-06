Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F4C606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r7qxpg//
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQg0-0005zp-GK; Fri, 06 Nov 2026 15:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xPQfw-0005zW-AD
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:36:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xPQft-0008Ng-U7
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:36:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so8977945e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793997395; x=1794602195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L88WBi5+/sbLAoR4ZU/BeQqMd+HKLe9LvIarCWvOTBI=;
 b=r7qxpg//FI8NecqP8bQsQZFdOZRV6PKib/zyNGbQCH9d4UyYbT1HCWdmzeepSKq8ol
 9zr4OnmMdSIBaxAAexG8LqB/OpJuVJlwHScNay/829P4fNqgPv6UZxlAaM0SZhsUoBg8
 sPRpuhPRBbj6lzoFek0nsQa2Aexm4Wjnst+QUQFmbCzu+suGBDQYIHJ0ZTAECU5KPuTo
 omFOr9FPXDPJLL7dBHSRz9C5UatXXxj1Lg+WzkYO8LORWKI1cKSiQlvriVIiPShbufa9
 /HIN83m6o/0k5gBmg+z5cRqiykdcu/WPUkd/ZS9/z0UvuEyvhh5FVmIWTF9rG3IFLuKM
 l1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793997395; x=1794602195;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L88WBi5+/sbLAoR4ZU/BeQqMd+HKLe9LvIarCWvOTBI=;
 b=eJqq2hRyAoUgJsseOHytu0H6NFeF/O7kOaVI1NeyjhQOVfQgmrTewzIr+H+3R42L/U
 15y8RmVo8UHFuWA3YjulYICYGd/2JjXkLEeXSjq9JT4i3eBAQ6uOqe6IaNi/xVGg2Ew+
 ITdcPfsznyLBmDO57elHzmI9SC2cNFiVUQGZ0BV+szE6UCnY4zAZznffaKA3pXLJpGXd
 b2dgY/F6YXJ9PudoEwtvGSTFkHGzTbFQ8F79Ex3yJ8lWXkqC8xuHNoD0i4tfByPGvaVW
 kdy+SdDcHdZwwez1F6yr2GruezCPSOfdNPF719Eh46iVjtHQkJegpHnNMfZzHFr5Qj2C
 lJ2Q==
X-Gm-Message-State: APuU4Z/qDxWe1EYY/iti90w1XjmVTt4di13uKCaBAF2DyotmryHSbqLV
 GEX+9MkPVgtdZXZuXaQRYGH4sguGfFonCFc/Bb7LhiuJQH5WiQv/QUFCodimgaDJaZI=
X-Gm-Gg: AYBFou1MMYktzRg/zoJGFgnZ0G1yKw7DeeAQ0H6+qfxSjRp3Wut/rZJd3wulLMLgBy5
 c9RzDhF1RpG36WoVhzQ6jSVzPgwF5Otle239ev0C/U/wgUVLrP1ild0vs6ofJsCiIK7itWDvEMd
 dh1Hk0XJNbV4ayQO7te40g/W6SsENjQI6Kaoljwp0sHeMhDWZqWK7/uFzu4B4nJmoKhHTHPhdCa
 8GnUneL8EGhYiZhl6XRGDjQHcH3+hPxG09e3ThXIGaOojTrqXKqyFWg8YLUgxRS846HvvHv4VmV
 WOa5X04QyEGNW9vEOdDgj15FErjNS8vy8K/arW94fBKN7W7FIzEj74803alt+IQc3G+sISWJIim
 D97q23nPaXE0HBhcK0XNRqFdnHwkDtdktfnXEgm1s4iZtfzq568duQ3/QF29ecYPXcBOMIA8Tdw
 rryo7F2bdDCsu7ciaHvKlXd+Y9Ff2h7ZT1jtc1YxPELiwbS3iVLMbLr0YArndaS4Q2uPOPG/ET1
 Vi1ahxe4nULa/CtjV9Xu3kc0W3OU2zXQYUoYtDFsQ/u8ASoH9w4sSC+NHGu4G8vqLcsjWnj17pl
 20R4HycOqpqaHToCuyROMqS2+E1w
X-Received: by 2002:a05:600c:46cb:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4b6d82b296dmr66616255e9.0.1793997394859; 
 Fri, 06 Nov 2026 12:36:34 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7c4afc8e8sm3760885e9.3.2026.11.06.12.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:36:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00B1F5F81F;
 Fri, 06 Nov 2026 20:36:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [RFC PATCH] docs: add a diagram of the development process
In-Reply-To: <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 6 Nov 2026 09:38:54 -0800")
References: <20261106122111.3005638-1-alex.bennee@linaro.org>
 <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 06 Nov 2026 20:36:32 +0000
Message-ID: <87ld7566jz.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 11/6/2026 4:21 AM, Alex Benn=C3=A9e wrote:
>> We've had various versions of this diagram for a while so I thought it
>> would be worth adding to the developer docs. I chose plantuml as it
>> has a plugin for sphinx that we can use and supports sequence diagrams
>> which could be useful for documenting other features in the code base.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> vRFC
>>   - I've bundled all the plumbing together in this commit but it can
>>   be split up if we want to go forward.
>> ---
>>  docs/conf.py                    | 22 +++++++++++++++
>>  docs/devel/index-process.rst    | 47 +++++++++++++++++++++++++++++++++
>>  docs/meson.build                |  3 ++-
>>  docs/requirements.txt           |  1 +
>>  configure                       |  6 +++++
>>  pythondeps.toml                 |  1 +
>>  tests/lcitool/mappings.yml      |  3 +++
>>  tests/lcitool/projects/qemu.yml |  1 +
>>  8 files changed, 83 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/docs/conf.py b/docs/conf.py
>> index 914bae67d9c..9fc7be362ba 100644
>> --- a/docs/conf.py
>> +++ b/docs/conf.py
>> @@ -66,8 +66,11 @@
>>      'qapi_domain',
>>      'qapidoc',
>>      'qmp_lexer',
>> +    'sphinxcontrib.plantuml',
>>  ]
>>=20=20
>> +plantuml_output_format =3D 'svg'
>> +
>>  # Add any paths that contain templates here, relative to this directory.
>>  templates_path =3D [os.path.join(qemu_docdir, '_templates')]
>>=20=20
>> @@ -345,3 +348,22 @@
>>  qapidoc_srctree =3D os.path.join(qemu_docdir, '..')
>>  dbusdoc_srctree =3D os.path.join(qemu_docdir, '..')
>>  dbus_index_common_prefix =3D ["org.qemu."]
>> +
>> +
>> +def setup(app):
>> +    import docutils.nodes
>> +    import sphinxcontrib.plantuml
>> +
>> +    # We manually setup the plantuml extension so we can skip nodes with
>> +    # diagrams when generating the text based output.
>> +
>> +    def skip_node(self, node):
>> +        raise docutils.nodes.SkipNode
>> +
>> +    app.setup_extension('sphinxcontrib.plantuml')
>> +    app.add_node(
>> +        sphinxcontrib.plantuml.plantuml,
>> +        override=3DTrue,
>> +        man=3D(skip_node, None),
>> +        text=3D(skip_node, None),
>> +    )
>> diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
>> index ce0f4e73197..1c13dd3f7b5 100644
>> --- a/docs/devel/index-process.rst
>> +++ b/docs/devel/index-process.rst
>> @@ -5,6 +5,53 @@ QEMU Community Processes
>>=20=20
>>  Notes about how to interact with the community and how and where to sub=
mit patches.
>>=20=20
>> +.. uml::
>> +   :caption: QEMU Patch Review and Acceptance Flow
>> +
>> +   @startuml
>> +   skinparam roundCorner 8
>> +   skinparam shadowing false
>> +   skinparam defaultFontName monospace
>> +   skinparam sequenceMessageAlign center
>> +
>> +   actor "Developer" as dev
>> +   participant "QEMU Community\n(qemu-devel)" as list
>> +   actor "Subsystem\nMaintainer" as sub
>> +   actor "QEMU\nMaintainer" as top
>> +
>> +   dev -> dev: Develop & test feature
>> +
>> +   loop Needs revision (v1, v2, ... vn)
>> +       dev -> list: Post patch series to list
>> +       note over list: Code review on list
>> +
>> +       opt Review comments
>> +           list -> dev: Feedback & change requests
>> +           dev -> dev: Incorporate feedback
>> +       end
>> +       opt Review tags
>> +           list -> dev: Tags (Reviewed-by, Acked-by, ...)
>> +           dev -> dev: Apply tags
>> +       end
>> +
>> +       dev -> dev: Prepare n+1
>> +   end
>> +
>> +   group Patch acceptance & release
>> +       list -> sub: Maintainer accepts some or all patches
>> +       note over sub: Incorporates patches\nfrom other developers
>> +       sub -> sub: Add Maintainer Sign-off
>> +       sub -> sub: GIT branch foo/next
>> +       sub -> list: Sign & Submit Pull Request
>> +       list -> top: Pull Request delivered to list
>> +       note over top: Pull Requests from\nother maintainers
>> +       top -> top: Test and Merge Pull Reqs
>> +       top -> top: qemu.git master
>> +       top -> top: Tag Release
>> +       top -> list: QEMU Release
>> +   end
>> +   @enduml
>> +
>>  .. toctree::
>>     :maxdepth: 2
>>=20=20
>> diff --git a/docs/meson.build b/docs/meson.build
>> index 4d8cc545fcc..600d3283299 100644
>> --- a/docs/meson.build
>> +++ b/docs/meson.build
>> @@ -1,9 +1,10 @@
>>  sphinx_build =3D find_program(fs.parent(python.full_path()) / 'sphinx-b=
uild',
>>                              required: get_option('docs'))
>> +plantuml =3D find_program('plantuml', required: get_option('docs'))
>>=20=20
>>  # Check if tools are available to build documentation.
>>  build_docs =3D false
>> -if sphinx_build.found()
>> +if sphinx_build.found() and plantuml.found()
>>    SPHINX_ARGS =3D ['env', 'CONFDIR=3D' + qemu_confdir, sphinx_build, '-=
q']
>>    # If we're making warnings fatal, apply this to Sphinx runs as well
>>    if get_option('werror')
>> diff --git a/docs/requirements.txt b/docs/requirements.txt
>> index 509d56bd1e8..1cafcbaa38f 100644
>> --- a/docs/requirements.txt
>> +++ b/docs/requirements.txt
>> @@ -3,3 +3,4 @@
>>=20=20
>>  sphinx=3D=3D7.2.6
>>  sphinx_rtd_theme=3D=3D2.0.0
>> +sphinxcontrib-plantuml=3D=3D0.30
>> diff --git a/configure b/configure
>> index 42dffed28f0..b0dedde65dd 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1020,6 +1020,12 @@ if test "$docs" !=3D "disabled" ; then
>>          fi
>>          echo "Sphinx not found/usable, disabling docs."
>>          docs=3Ddisabled
>> +    elif ! has plantuml; then
>> +        if test "$docs" =3D "enabled" ; then
>> +            error_exit "plantuml not found"
>> +        fi
>> +        echo "plantuml not found, disabling docs."
>> +        docs=3Ddisabled
>>      else
>>          docs=3Denabled
>>      fi
>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index c9a697046c6..c21d127ec93 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -30,6 +30,7 @@ meson =3D { accepted =3D ">=3D1.12.0", installed =3D "=
1.12.0", canary =3D "meson" }
>>  # Please keep the installed versions in sync with docs/requirements.txt
>>  sphinx =3D { accepted =3D ">=3D7.2.6", installed =3D "7.2.6", canary =
=3D "sphinx-build" }
>>  sphinx_rtd_theme =3D { accepted =3D ">=3D1.2.2", installed =3D "2.0.0" }
>> +sphinxcontrib-plantuml =3D { accepted =3D ">=3D0.5", installed =3D "0.3=
0" }
>>=20=20
>>  # This test group is for dependencies required to run various tooling
>>  # and tests that should always be installed at configure time. It should
>> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
>> index c99f007798e..eca6748ac09 100644
>> --- a/tests/lcitool/mappings.yml
>> +++ b/tests/lcitool/mappings.yml
>> @@ -3,6 +3,9 @@ mappings:
>>    bindgen:
>>      Ubuntu2204:
>>=20=20
>> +  plantuml:
>> +    default: plantuml
>> +
>>    python3:
>>      CentOSStream9: python3.12
>>=20=20
>> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qe=
mu.yml
>> index abbd3e3f0b8..de4395cd3c7 100644
>> --- a/tests/lcitool/projects/qemu.yml
>> +++ b/tests/lcitool/projects/qemu.yml
>> @@ -89,6 +89,7 @@ packages:
>>   - pcre-static
>>   - pixman
>>   - pkg-config
>> + - plantuml
>>   - pulseaudio
>>   - python3
>>   - python3-numpy
>
> It will silently disable doc by default for most of the people
> unfortunately, not sure it's the best move we can do.

plantuml seems to be pretty widely packaged so in this sense its just
another dependency.

> Maybe a simpler solution could be to generate diagrams out of sphinx,
> add them as a dependency, and generate a blank image (or an image with
> diagram source and a message - please install plantuml) if not
> available. What does plantuml brings compares to graphviz builtin
> extension?

Ohh I didn't realize there was graphviz - I'll see if I can recreate
with that.

> Also, text diagrams (https://asciidraw.github.io/) with raw formatting
> have the advantage to not require any external tool.

I have the ascii original although ditaa seemed more of a stretch:

--8<---------------cut here---------------start------------->8---
#+name: QEMU Development Process
#+begin_src ditaa :cmdline -T -o :file images/qemu-dev-process.png
           Developer                                   QEMU Community      =
                     Subsystem Maintainer
  +-=3D--------------------------+   +-=3D---------------------------------=
------------------+   +-=3D----------------------+
  |                            |   |                                       =
              |   |                        |
  |    +-------------------+   |   |  +------------------------------------=
-----------+  |   |   +----------------+   |
  |    |{io}               |   |   |  |{io}                                =
           |  |   |   |{io}            |   |
  |    |  Develop and      |   | +--->|              Code Review on List   =
           |  | +---->| Add Maintainer |   |
  |    |   Test feature    |   | | |  |                                    =
           |  | | |   |    Sign-off    |   |
  |    |                   |   | | |  +------+----------------+------------=
----+------+  | | |   |                |   |
  |    +--------+----------+   | | |         |                |            =
    |         | | |   +-------+--------+   |
  |             |              | | |         V                V            =
    V         | | |           |            |
  |             V              | | :  +-------------+  +-------------+  +--=
-----------+  | | |           v            |
  |    +-------------------+   | | |  |{d}          |  |{d}          |  |{i=
o}         |  | | |   +----------------+   |
  |    |{io}               |   | | |  |  Review     |  |  Review     |  | M=
aintainer  |  | | |   |{s}             |   |
  | +->|  Post to List     +-----+ |  |    Comments |  |    Tags     |  |  =
accepts    |  | | |   |   GIT Branch   |   |
  | |  |                   |   |   |  |             |  |             |  | s=
ome or all |  | | |   |    foo/next    |   |
  | |  +-------------------+   |   |  |             |  |             |  |  =
patches    |  | | |   |                |   |
  | |                          :   |  +------+------+  +------+------+  +--=
----+------+  | | :   |                |   |
  | |  +-------------------+   |   |         |                |            =
    |         | | |   |                |   |
  | |  |{io}               |<----------------+                |            =
    +-----------+ |   |                |   |
  | |  |    Incorporate    |                                  |            =
              |   |   |                |   |
  | |  |     Feedback      |<---------------------------------+            =
              |   |   |                |   |
  | |  +--------+----------+   |   |                                       =
              :   |   +-------+--------+   |
  | |           |              :   +---------------------------------------=
--------------+   |           |            |
  | |           v              |                                           =
                  |           V            |
  | |  +-------------------+   |                       QEMU Maintainer     =
                  |   +----------------+   |
  | |  |{io}               |   |  +-=3D------------------------------------=
-----------------+  |   |{io}            |   |
  | |  |    Prepare n+1    |   |  | +-------------+  +--------------+  +---=
-------------+ |  |   |  Sign & Submit |   |
  | |  |                   |   |  | |{io}         |  |{s}           |  |{io=
}            | |  |   |      Pull      |   |
  | |  +--------+----------+   |  | | Tag Release |<-+   qemu.git   |<-+ Te=
st and Merge |<-------+     Request    |   |
  | |           |              |  | |             |  |    master    |  |   =
 Pull Reqs   |<-+ |   |                |   |
  | +-----------+              |  | |             |  |              |  |   =
             | || |   +----------------+   |
  |                            |  | +------+------+  +--------------+  +---=
-------------+ || |                        |
  +----------------------------+  +--------+-------------------------------=
---------------+| +------------------------+
                                           +----------------+              =
                |
                                                            |              =
                |
                                                            V              =
                |       Pull Requests
                                                     +--------------+      =
                +----       from
                                                     |{d}           |      =
                      Other Maintainers
                                                     |     QEMU     |
                                                     |    Release   |
                                                     |              |
                                                     |              |
                                                     +--------------+

#+end_src
--8<---------------cut here---------------end--------------->8---


>
> What do you think?
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

