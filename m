Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80E5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsfb-0002n9-1E; Thu, 09 Jul 2026 13:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whsfV-0002ih-10
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:36:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whsfS-00052J-1k
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:36:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HX8I62563673
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 17:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZomP1pe+QlXIAs5uj77apFQT9F01UhqaIeU1kh7bpe0=; b=jIhX4uA7S95kd1wV
 rsEU1CdKKo/UbyUNcfgoVZMBge2cQ/Y60xtManWhjp5YiCRYND8WozYYLNXQqLRz
 AC5qjaUbzv+8aSLM+91JPruamErQYFsiptJFQuLMU2KF9Sy62XbBuNykIQ9zXUFH
 V4manNAktNiisrMteebuyBKD27yCFcyuHra56qKezVyjyINXhB2XvoLBgprEHTxY
 lunJLwEVEvk2LYqRpPvJ2BkDQq9df48xK7u2d6rc8vmxTTzxMKYXf3d2zoKcJftu
 edYRDn2P5unV9f8cq8ZDIqumR/uQV75VQlAHUjWq+vVKECNawg1jG24Lv2tQV7SV
 ZUnIEw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3gmvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 17:35:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so212695ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783618559; x=1784223359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZomP1pe+QlXIAs5uj77apFQT9F01UhqaIeU1kh7bpe0=;
 b=h7R9WNHtk9LQY1XKJhGO4MIUQp6Sw6c+2hePNJ6L/6QaDQicrA4HULR06IS+JTHKMj
 Mr0Bl8GXAA4SPyxlRmbF75lVcGFNp9DxYJ1Rq5J0rEh6HXqliSQXT4Sk7K+10yNfB+aD
 DeoMMQnO+WATk4bVa2LdgjmHvosM7jGFdUVprFZtAE1SE0seHJKT9aBllAuN3X9uuRC1
 ODgYQZsKl4VCWQ64oAOHW4CRa66ZEGdylvf0I+f5715UDbEVM1i6awyefiwlT1XtPRhT
 qN4Zih/rP4IH7wqajp2MzLPfPwW/XkHZ022FrY63ssioL9ppPoujlbTYUzAY+m0xHFkc
 dQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618559; x=1784223359;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZomP1pe+QlXIAs5uj77apFQT9F01UhqaIeU1kh7bpe0=;
 b=l2qTrX1/PT1HPZtQByoDyRj+xg1shJZoCwjFkwnXpu04ErV7oHhUdH61dorHs6O1Ko
 6N4SOMGckW16yR2yovPnvzk/5XYOTJYyr4XUWF0zhAkh4RPu9uDmYoBrtBIPT8Mm8eng
 gZg2ypMB1jkWeeIwliYOH0HVsSwUaDskbw5ALseGmOkO34utXM1TgogZyQqXvManNMkS
 43pN25hg2W0UGCBQV07HY26obGvp5408ZaR989co0PNyykdPrO775Ckbt1HjXzuXS4D+
 DSMLadIZ8OD7i1bCvqGXSt6nz9omfuaIJq8sqO6x4Yd9sDXqh5JI9j6bguQpDwe5NGQL
 aJMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLi9JGBzn2+FGEAp6/EisVD7Cwv6ovL+1CEUqzPHBGk4obIJjWYWvlS+MrN77Uhii6klIdaugHFU4O@nongnu.org
X-Gm-Message-State: AOJu0YxGdVLZoZriJC/xZvucXn2Q514psNcnLQxrmadJVMGhlNKWOp2c
 eGOcVak9peSf2h3PqKShs+OJAXddI3y19rD5Pg/cThwA76SV55UOIukaHZ5XzQzM3fFIIHGYGnP
 EAfy8qDFuUsfBB0No3ypoBHfpu7HWUAPI1JydBrDEuepP7jxKTOw+CYzi/Q==
X-Gm-Gg: AfdE7cmQJZp/Mx6LAIEzfIXNSYRrG55oGhtLZ1YQksGW4A0dXigiZGto7Dh/ciXNLVT
 6BdLh5vCAW67YWjZKntFh8GAWrRtOXx3ihs0SjnGKl8hV+ZxUzUB9FwgVlR1HNnBXQKxd7Ff56S
 lj0Cj2HPjfIT4N/rph6iCYlxgLKgwdJNKhMJwJfbpcWxOHVRmAGdLxpkWG9Xp/ua0+o2UwelcwF
 vTyR6/RhzGk/yvVOvM9Mj4DgI3vIZv604Tmv0l0aA5lKzbKBZFb2RjI3zEutr1uSuHzT9AgWCeI
 YcfbF/206JQfHbjxbhfodkf3Ku02sTHt4TlBgXqY/tfFhqhpiaNXcMChE1V1jcsh7gkENERMOfg
 yjO1LN0CGnDdK1MBFOwnsqwS0f1HNaA2Zyy3mK9yVeD4eaadkY8dZdl/UYEPAlz4z8LTDuKM3RB
 W0HeA=
X-Received: by 2002:a17:902:ff8e:b0:2cc:9179:325 with SMTP id
 d9443c01a7336-2ccea387551mr90004575ad.13.1783618558488; 
 Thu, 09 Jul 2026 10:35:58 -0700 (PDT)
X-Received: by 2002:a17:902:ff8e:b0:2cc:9179:325 with SMTP id
 d9443c01a7336-2ccea387551mr90004185ad.13.1783618557924; 
 Thu, 09 Jul 2026 10:35:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf7858sm48158945ad.23.2026.07.09.10.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 10:35:57 -0700 (PDT)
Message-ID: <f70d71d0-1aed-4b2d-b91d-822144e799cd@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 10:35:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709170437.363560-1-functioner@sjtu.edu.cn>
 <20260709170437.363560-3-functioner@sjtu.edu.cn>
 <cd750bed-c681-4afa-abf6-ac659b8de10b@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cd750bed-c681-4afa-abf6-ac659b8de10b@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3MyBTYWx0ZWRfXy1XZK6V9Kx+7
 U4lfjBcIU5GCS+61bc/ipuXTsiz7eUQjm9A1BaIb8sGbtaJ+pAiS00Xgan/hqNLfUrCJ76A/qvj
 logLyU2QhMAFsou83DqeV2TFrAT+pcG3/P93UlpPQybQzdBdFRPxjeo44On7CDUemnL2GwBzkMp
 XlOXoPMOcJSF5o9qlOYVx60/XsrB/q2l3hDijqEKikDfgrNc3HlHWcN5DuV3bQKzCZrIM5d++8S
 7/xuMULmImOgUqk7N7LySyjVMWNfRLx+MUc1YXqlyU4HKxMpfF2rvjQ+6xrzHMv+GcKiXrikmwx
 M23mLBvJvsQxYhwJGEJ0kKW04csd1JwzXTWaAZtxZO7IyuWg8IGplfXIx/bfStFlUu8AXKzZQlu
 D1C+3XB7z1/Fp6ies8+8YzJjpQewynVHrNIwvay+/Ybp7xd5rks1r+Dze8/YcgC5oNlh69VP3to
 IHtQYYKTTFcNWfXFI8w==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a4fdbff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=jQIij1hyAAAA:20 a=tn6FHibbyO4NPMFoDIkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3MyBTYWx0ZWRfX8yhbuGGZ6TAa
 ayEyHrOgQZ00hkhVVpc3HTlcl9SgSCzWhKBmpkao7+6ZwkFVoqxBEkNpAbOt4j4BkZH6bYjOFdR
 yv28prwOJF7CTGlOjw4Vt/IWD8IoG2g=
X-Proofpoint-GUID: --NoNqo7vQz4wjbpSBkm4HX2PsDJptOS
X-Proofpoint-ORIG-GUID: --NoNqo7vQz4wjbpSBkm4HX2PsDJptOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090173
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

On 7/9/2026 10:13 AM, Ziyang Zhang wrote:
> Hi,
> 
> On Fri, 10 Jul 2026 01:04:37 +0800, Ziyang Zhang wrote:
>> Document the dlcall plugin under Example Plugins: what it does, the
>> trusted-
>> guests and guest_base == 0 constraints, how to load it, and a pointer to
>> Lorelei, one end-to-end userspace implementation, for the toolchain and a
>> runnable example.
>> Patch 2/2 walks through the hello example one step at a time. If you
> would rather not run those steps by hand, the self-contained Makefile
> below does the whole thing in one command: it downloads the devkit,
> writes the sources, and builds the thunk tree from patch 2/2. After
> that,
> 
> make QEMU=<your qemu-x86_64> PLUGIN=<contrib/plugins/libdlcall.so> run
> 
> runs the guest both ways and prints hello from guest then hello from
> host.
> 
> It only needs wget or curl to fetch the devkit from the GitHub release,
> plus a qemu-x86_64 built from this series for the run step. Drop it in
> an empty directory and run make.
> 
> 
> # ---- Makefile ----
> # One-click Lorelei hello quickstart. From nothing, this Makefile
> downloads the
> # devkit, writes the example sources, and builds the thunk tree from the
> # walkthrough. Everything lands under this directory.
> #
> #   make            download the devkit if needed, then build the tree
> #   make tree       print the resulting directory tree
> #   make run        run baseline then thunked (set QEMU= and PLUGIN=)
> #   make clean      remove the generated src/ build/ thunks/
> #   make distclean  also remove the downloaded devkit and tarball
> #
> # Set DEVKIT= to reuse an already-unpacked devkit (then nothing is
> downloaded).
> # Override VERSION= or ARCH= to pick a different release or host
> architecture.
> 
> VERSION ?= 1.0.5.0
> ARCH    ?= $(shell uname -m)
> DEVKIT  ?= lorelei-devkit-$(ARCH)
> TARBALL := $(DEVKIT)-$(VERSION).tar.xz
> URL     := https://github.com/rover2024/lorelei/releases/download/
> v$(VERSION)/$(TARBALL)
> 
> QEMU    ?=
> PLUGIN  ?=
> 
> CLANG   = $(DEVKIT)/bin/x86_64-linux-gnu-clang
> MKTHUNK = $(DEVKIT)/bin/LoreMakeThunk.py
> GTL     = thunks/x86_64/lib/x86_64-LoreGTL
> 
> .PHONY: all tree run clean distclean
> 
> all: build/guest/main $(GTL)/libhello.so
> 
> # 0. the devkit, downloaded and unpacked only when $(MKTHUNK) is
> missing, so
> # pointing DEVKIT= at an existing devkit skips the download.
> $(MKTHUNK):
>     @echo ">> downloading $(TARBALL)"
>     @command -v wget >/dev/null 2>&1 && wget -O $(TARBALL) $(URL) \
>         || curl -fSL -o $(TARBALL) $(URL)
>     tar -xf $(TARBALL)
> 
> # 1. the sources, written out so the whole tree comes from this one
> Makefile.
> # The guest and host builds print "from guest" and "from host", so a run
> shows
> # which one ran.
> src/hello.h:
>     @mkdir -p src
>     @printf '%s\n' \
>         '#ifdef __cplusplus' 'extern "C" {' '#endif' \
>         'void hello(const char *name, int lucky);' \
>         '#ifdef __cplusplus' '}' '#endif' > $@
> 
> src/hello_guest.c: | src/hello.h
>     @printf '%s\n' \
>         '#include "hello.h"' '#include <stdio.h>' '' \
>         'void hello(const char *name, int lucky)' '{' \
>         '    printf("hello from guest: %s, lucky %d\n", name, lucky);' \
>         '    fflush(stdout);' '}' > $@
> 
> src/hello_host.c: | src/hello.h
>     @printf '%s\n' \
>         '#include "hello.h"' '#include <stdio.h>' '' \
>         'void hello(const char *name, int lucky)' '{' \
>         '    printf("hello from host: %s, lucky %d\n", name, lucky);' \
>         '    fflush(stdout);' '}' > $@
> 
> src/main.c: | src/hello.h
>     @printf '%s\n' \
>         '#include "hello.h"' '' \
>         'int main(void)' '{' \
>         '    hello("world", 7);' '    return 0;' '}' > $@
> 
> # 2. the guest libhello.so (x86_64) and the guest program. main has no
> rpath,
> # so which libhello.so it loads is decided by LD_LIBRARY_PATH at run time.
> build/guest/main: src/hello_guest.c src/main.c src/hello.h | $(MKTHUNK)
>     mkdir -p build/guest
>     $(CLANG) -shared -fPIC src/hello_guest.c -o build/guest/libhello.so
>     $(CLANG) src/main.c -Isrc -Lbuild/guest -lhello -o $@
> 
> # 3. the host libhello.so, native to this host, for the host thunk to use.
> build/host/libhello.so: src/hello_host.c src/hello.h
>     mkdir -p build/host
>     cc -shared -fPIC src/hello_host.c -o $@
> 
> # 4. the thunk pack (host HTL + guest GTL) generated from the host library.
> $(GTL)/libhello.so: build/host/libhello.so | $(MKTHUNK)
>     $(MKTHUNK) --name hello --lib $< --header hello.h -o thunks -- -Isrc
> 
> # print the produced tree
> tree: all
>     @command -v tree >/dev/null 2>&1 && tree src build thunks \
>         || find src build thunks | sort
> 
> # run baseline (guest build) then thunked (host build) under qemu.
> run: all
>     @echo "== without the thunk =="
>     $(QEMU) -E LD_LIBRARY_PATH=build/guest build/guest/main
>     @echo "== with the thunk =="
>     LORELEI_THUNK_PATH=thunks LD_LIBRARY_PATH=$(DEVKIT)/lib:build/host \
>       $(QEMU) -plugin $(PLUGIN) \
>       -E LD_LIBRARY_PATH=$(DEVKIT)/x86_64/lib:$(GTL) \
>       build/guest/main
> 
> clean:
>     rm -rf src build thunks
> 
> distclean: clean
>     rm -rf $(DEVKIT) $(TARBALL)
> 

The problem is not to automate the 5 commands we need to copy paste, but
to have a functional example, which is not yet the case.
On Lorelei side, feel free to do what you want for the docs and
examples, but for QEMU doc, we'll stick to have something as simple as
possible, without any Makefile.

I politely ask you to not add anything else to documentation out of what
was asked in v9. This just makes things slower, and more iteration needed.

Also, please see the comments sent on v9, you can answer to them
directly on v9.

Regards,
Pierrick

