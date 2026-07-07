Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D255C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzHq-0000Gv-G5; Tue, 07 Jul 2026 02:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzHo-0000GJ-Kk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:28:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzHn-00060C-0j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:28:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6676KTk12922479
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RNKSMMXGRfP2udUqGQ1XishfQQoYzoVU1fnyw6Cd6iQ=; b=f3GEFPOqY3GZNdl/
 plD6lG5aR4gvZ8OCjDwG17b1XGOLeqFkk3SQN4bderxkhFSd3j330/GmepVXsDVY
 c7dcDGItxno5Kz62tayAnm57bVRvD6IQUh9bHKjddPQYoqQ7IkhJ5HMLlJkBqyWu
 s6txiTV4pAxxYJ0KWBZ3j2+leHnXqNnQ21w8JiHdzXzDSapX5N4mlhiWj95UuiIk
 fGFo+9xFVdgkh4PBc60il1Ulvbe4nVl3DdZL69X9OVpu8Y55P9V+BB7dC/rU9maP
 C3CyIwIYILOs9jHyCRLb8tDp1D+fkrl/KMyJvfTngppWNxKjVlMT1HnwlXiM4V4b
 g1X1XQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t80ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:28:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so346438385a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405681; x=1784010481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RNKSMMXGRfP2udUqGQ1XishfQQoYzoVU1fnyw6Cd6iQ=;
 b=AluyxApM+gQRfQf6TFcWOceMkgbMQJJkHqq9WRHp8qx7E2RDIEiHOVxGdCxnXOHJTN
 I9L925p1LxdP8ybKMfJNnkFo+cw+Rp5M+8UUlZPaUh9QheSls5AqSWikOL9pyumHzDcI
 3YoOAj3yOLgKHGU5O5uB2iwlbQXZSG2dy27kx4z6urEQP3mMbGN4M+ozjhRp+00+GbRZ
 h5fKvOJecNXPCBhc53+b5aDIzkUe51eQBm8L0u56qAsr8RsY20fM/KygmqOTywidLAif
 L6FDyZ795Enfxz275LQV8kSI06TbYdVHU/WiGCSeC7sDOlC9qhYcRRICv27fajppz/ro
 oblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405681; x=1784010481;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNKSMMXGRfP2udUqGQ1XishfQQoYzoVU1fnyw6Cd6iQ=;
 b=ZS97iAeMlSqPhFWuYGsuy7Z3hxP+iZXWNKsyq1UvLKIRX+2avLuezXPewt+qa9TcHW
 19OiAT3/OAjzq6JGJRmQYo/FCkZGcrW30VtM7fMl5/tFh0jDjDcmcYV2HiYhE9frvv+N
 0NX0dYLWfMzim7vUcyucgHmHS9RvnUPQX6C2IW++xJ1/DjQioPnz4efmyFnyagq8WMEK
 QQBviriYiZdoeLCmQZgwRrVvymAqdlTB6K30SbkeiiMYXgcXkcjdFCuIFNCVAgANK+Oq
 dXylfbBy3iZGAIELM9jKBwB3nBCmqurkUoOivLCaY38jTfOjUObisRDlGWorI5zwza7d
 twjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdANnCGq/GZdgfbHMmZYbjCKnJBUXkYgWK8kUaUU934c5vpApebhVBTx50r3n/mm3H5LvTPAxtlEgA@nongnu.org
X-Gm-Message-State: AOJu0YwSkUXZaL1ARKwjdZcKVqSi86KoPHjN5tSubGnmipwMd0RKdzkN
 gkunKApWnIfT5eTRsP2SomVwg/ZZs/BWy+LV48E6r7Qe0mW7tLbuhheVeshOjoA1oNmF3GRhzkm
 MvB4uxFR4Ab2Sw8forZ1mElSyWYyiXd2BSALXKkmgUqu5l1ZioaOv7ufs4w==
X-Gm-Gg: AfdE7cleBzjQk4PonAJxjbtPUeH402NYcVjgLfXRr4ftnS8SIVZM4Z0QlQF4UI2ziB0
 DEL69msQF7YhD1C192SGSlw4Lxg44bu/gRdPk85r234NQ0PVb8gvTgdTxDFHJDjvf7vUtwYA4ob
 pj0CqtMONyc+gS78Q/qLYpKvod9GIXtEDjbbARMLhXe7OPfbKCU9944g16+IZ0Qao8OEOxIlg7v
 Mu68OiXWFy6m0VXx9CIwshipuqUImVdFqPBm/anuWG9ot62JNdjrYiCJ8r9bWHqYvcnx1fTViGU
 iA5V2vzELGcK0sO4oWq2WSfF5kFWnisxL4J6RRnFQa61RBqoNEfr5mD3hYgu3yYV0olWRmZFeoX
 wIGYlAZ+gG7RkU2EBcqQYHen1s6+l8WtOU1GgPqo2CThvMAMvxQvpxMxhpStSDA==
X-Received: by 2002:a05:622b:5a:20b0:51c:7b11:41bb with SMTP id
 d75a77b69052e-51c7b11438amr6439591cf.87.1783405680902; 
 Mon, 06 Jul 2026 23:28:00 -0700 (PDT)
X-Received: by 2002:a05:622b:5a:20b0:51c:7b11:41bb with SMTP id
 d75a77b69052e-51c7b11438amr6439501cf.87.1783405680275; 
 Mon, 06 Jul 2026 23:28:00 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f51193sm31853995e9.12.2026.07.06.23.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:27:59 -0700 (PDT)
Message-ID: <055ca0c3-5c8b-424f-bd7d-b3398505a555@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/91] tests/tcg: run tests with meson
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-riscv <qemu-riscv@nongnu.org>,
 Parthiban Nallathambi <parthiban@linumiz.com>
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AZwevdr3S71EVbI0RbVBO1lMrKlw4viJ
X-Proofpoint-ORIG-GUID: AZwevdr3S71EVbI0RbVBO1lMrKlw4viJ
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4c9c71 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=cDy9niVPjdeetTRvGlIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2MCBTYWx0ZWRfXzLgPBjZOIEjD
 w578y2lM4u/EhuzVMjb3xbL7L3jLa3qn1IKEydFJO2lgMXKLvXpCTOl+a2mOfTvyq9fA/KXNjR7
 /nNLBFxU2rOY3Qw6qZoKCp7mfMuvGXhb43J9snClMAaXrRhD6MqiBbXSQ08BOsKRRLc6zt6WW4A
 R+sg361YBh1/uh8wzFq3HKzpKiN2CdW5lrZEzzgXEU7cmQ+w7kfYhT6aea5fKhJF5bGik9ktEb/
 wL52r5J82XE44Su9yJFJmZXv0F3yZcmUk5dzd0lCWtZYqLx/6/4jEk0OYQWmNiTs50reox3qIqU
 NOw3rWR3KapxWPXgRX68v6ApFvNxwX3ktiEVc7zZwIECTPUnlQcp5Z+bNwHY9V57mRzCptSEE9W
 Wpcx13+hkewrwdp65r18Q8OpgrpL/LhT+Z+/tnEg/3hw2IxJ4Z76qapjOnQSvId8OquFiSNG0eL
 me4DYEr9ki5c/lg9nLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2MCBTYWx0ZWRfX1/Z9m7d6jBQ8
 206oNSNVtx0KKXGcqX6+10A/x98NYBENQzlyCLcB+YmVDKQX0fXbd/CYFuo+6WloI1lSQkHJVSl
 6TXruS1cb4PUi8d3E6bLsIlWQZJ4a2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070060
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

On 7/7/26 00:32, Pierrick Bouvier wrote:
> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by integrating
> them with meson directly.
> 
> It covers all existing tests for all architectures, including
> user/system/multiarch-user/multiarch-system. It implements all requirements
> listed on original thread [1].
> 
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
> 
> We also have for free:
> - correct and complete dependencies for any test, including:
>    scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
> 
> Series first introduce the meson machinery needed in tests/tcg/meson.build, step
> by step. Then it adds support for all existing archs. Finally, we remove
> Makefiles and configure bits.
> 
> Usage:
> 
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
> 
> make tcg-tests
> 
> ninja clean
> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
> ```
> 
> A few items were left for further work (out of scope for this series):
> - xtensaeb: didn't find how to cross compile for this architecture with what we
>    have now in container debian-xtensa-cross. Tips are welcome.

Cc'ing Max

> - tricore: implemented but reverted as all tests seem to hang. To be
>    investigated.

Cc'ing Parthiban

> - riscv64/interruptedmemory.S is hanging. To be investigated.

Cc'ing qemu-riscv@

> - i386/test-i386-fprem.c is deactivated for now. It's broken (output does not
>    match bare metal result) and is the slowest test we have. To be refactored and
>    fixed.
> 
> v3
> --
> 
> - add all architectures
> - reduce number of plugins tests (only add one test for each plugin from
>    multiarch pool)
> - add depends for executable - allow to depend on a custom target for generated
>    headers (x86_64 mmx, avx)
> - add new tests added since last version for aarch64 (mte + gpc)
> - refactor series to keep all arch files at end
> - add docker host architecture selection
> 
> v2
> --
> 
> - s/mispell/misspell
> - moved comment about why we remove 'lib' prefix for plugins
> - if user declare a wrong entry in a dictionary, list possible keys
> - build tests by default (with 'all' target), as long as cross compiler is
>    natively installed, to avoid triggering a container build.
> - reword some comments based on reviewers feedback
> - always declare all tests and avoid "per config" errors (no 'if' in arch files)
> - move compiler feature and gdb version checks directly in tests/tcg/meson.build
> - add support for cross containers
> - add top target 'tcg-tests' to rebuild all tests


