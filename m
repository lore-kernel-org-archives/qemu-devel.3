Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06174C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiL0-0008B6-U5; Tue, 14 Jul 2026 14:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjiKz-0008Au-Dg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:58:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjiKx-0007A3-GY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:58:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwNQV1455251
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W4ETRXQ7H6j
 WOxJcA3O7pRjT+l0bbC+OkNIAQym4Q9I=; b=hvEM6ICs6hDyv7U4di8xr2vmmBg
 9rsw3N8GaRYztZKf2GdK/52C5rcA2XVAiRdpr6KvnKY2Lz8MfUZcBsEtWxEBcLbb
 cRtIaT7atbQGiMybwacgYajd4cFBUFvbNRzdUZMAjVCIj4caGTVQcY5drLBfxXOu
 R0ILMJ7d0qXK+ujGhb6zWk3B/9tFVzn8qOOgVnJMeR411x40X5tJ96ishjaOG0Cc
 OulDWlgLtxyVrOri2yg/rAiqOq0PG+XwNFz1qgdzRo+EvCzh1Hcxtfaj/dzQx3XY
 Ci/ujf4KfuLK2mHcbSlm73jhFP/avRhNu9vdqYmryax+mpZTXcx2XZCcpXg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq1qn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:58:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso2522697a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784055511; x=1784660311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W4ETRXQ7H6jWOxJcA3O7pRjT+l0bbC+OkNIAQym4Q9I=;
 b=Qm7iWukgQDtnHOB3heF/zV312E88nubCkZavjKIe0AcezV4/4L0ARKjST99cI3ec33
 wRXhIZhKnEk+OiqqLUF6tqU7lx+dh+DdLFfqwtDRhdwz2o6+qQFfEiuAPTI06IBJAM1X
 qTfRRKZrdEmqPRjphaXakCrLaAuTtU4rGgW3VjnxFGSXNlwryV29+ZQSwm6bz8EB0NX4
 /mSN+dr7AcM1EKIZV1/rBV6Q7QKemG+BS38gOkopGtYU2HPIGEChE77+HWXOrsUJNtU0
 N0KO0tWj2mP9eJOlN8/ph89Jw9skI7Gcl2Diqffm/CIHO+wrkFO+eY0IW1aXLmizz/hn
 Wmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784055511; x=1784660311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W4ETRXQ7H6jWOxJcA3O7pRjT+l0bbC+OkNIAQym4Q9I=;
 b=tL+aUfjWSnJ7/UMR0pdAzPaAtZT6iTZidWb7tNVM2pEF/Obou1B+rvwTIdkidHid/8
 kaAkWWNKYfszH02lVZiIgD7M3oF6lHVsBBOE0oQ7ZDO5OW+q8RfVBPcOo8lXshVwW/E2
 lWlrZxwgsj7YMSQ2vdNHD9j6aDNDWbIT0oPq87+0Y8cIdMyY8Joi8nHozxDd6auAxYS5
 ep7OglYZXs9YvQblqKg57WrO7iehl66NTswhrIF6IeyRJuGC+lNZklub/h48C/sI+qDf
 QPTSKefjea6q+VyDg9trDTGyU2vjUD8DNxscDfNpjJmkDRuys4og3uS9c+7P/ySUs5ky
 E5AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB3Ex720pEa5sinnnlV0Mv6YrdWCXAcbQz6+6uY4f9WpnCde6KdYTIE719xJk6mV3jeM8+qZRJtdqq@nongnu.org
X-Gm-Message-State: AOJu0YzW6HUAtRNCOjWnrx6d+MZpNbUm4USZNO8zI51v5Y26F+mlhbvc
 YDACaYQdmJOBzwnp7EqCbJEkJFpGZU4b8JTU9tmphw7DA91Ms6SscEdkNw/gaEGjN86cNh5wqbt
 ITTiEX2GPYl/CLAUXvtvz8ZiBCC5ICGLP8daYdnN4s1qC4p48jCnn8kp6ZA==
X-Gm-Gg: AfdE7clT4agdBP9bZ2E/hU1+S2Vg8qFLxGRC08l0kDgdSDkUANE8nx476mYyNa0aF8y
 rvwxqV3gQA95c33z7TcwenkWrJ+idubDQxtIe5HQ9+4l61tL3zfDUcwk9EPimOjg8cnBLr6c1iz
 dRvO+Izwc+lZ0kSXLQELeIhXAfPp0jlJDBnCZwospnaQn3icoW8ek224DMfGGKPOEf8F+bG4/ex
 PBtka8leLa2zmXusl5sgi3rBg51+V8aalh/dH3z6nj7Re6YtfV4RL71g5jSUCkGND1oxE8MS5W2
 pz7CzY4gWv6+9sHlpOoBCHb1dRe6PG37rw4ZU+sIw5rH7e1APBaWWjKgOAceJfsQK2E702MmsGr
 kmtaqiGc6wDqW0FjDAJnIuGKVQZZcaDkW4RUDHYKKXH9A2+MaGmMfvwtzHypcuZAZ3OBXqO8N3w
 ==
X-Received: by 2002:a17:90b:3ccc:b0:37f:c2a8:ce45 with SMTP id
 98e67ed59e1d1-38dc73b936emr13559363a91.4.1784055510831; 
 Tue, 14 Jul 2026 11:58:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3ccc:b0:37f:c2a8:ce45 with SMTP id
 98e67ed59e1d1-38dc73b936emr13559338a91.4.1784055510213; 
 Tue, 14 Jul 2026 11:58:30 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313af819732sm54003340eec.16.2026.07.14.11.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 11:58:29 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: berrange@redhat.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, th.huth+qemu@posteo.eu, philmd@mailo.com
Subject: Re: [PATCH 14/14] tests/functional: Add hexagon semihosting systests
Date: Tue, 14 Jul 2026 11:58:22 -0700
Message-Id: <20260714185822.773736-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <alXyZCtBmMecWdf1@redhat.com>
References: <alXyZCtBmMecWdf1@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a5686d8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=5vFef2XoAAAA:20
 a=20KFwNOVAAAA:8 a=n8jiqwHFPunARSMjdsMA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: BH9S5W1pfANxxRFBHigtHHQEO7DAfXex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5NiBTYWx0ZWRfX1TEchGeU0VZ3
 JsOhMVKqPdFqvHd6RBCSzD0Me8w3Fm6in6EcZ/7D3nY8AQtKryDuopQNx8wxi5jU/3TA1OgIMHG
 iE4nRPVJ67j6i8AYKVBpTkwwUKbu0+U/fR7TpPxQ20F1AYyG50bfqYXSG22Uln+jJeBrdfmC11Y
 mRT1bA2TfEegxwD0dcKe015L9nE0wqfl4PJP5kzJ3UiWzqZ1q6jbDR2x4XJPTqZoj0e0ziDGBfR
 uUza4IXYlEc3QKPNpm+Q+focFqPYIZvGhBOHNz7PGK/S0B7bDly+359XgGT3TPRxm7nmxl/cwy2
 hKQHMz7Bdt2YyOGYAnwCiWIu+J+0RnAfMBzspM6c/ZljOh027uajb88HTQGASSePrWAjTbN/35y
 8xDEcdySx4tzb5+aG3L0kD02MIGG1Dylsdwt8EQFJ+soqpW41lv/tp8ApUULDRlkDAKouoL9BWv
 uaqdOVuUW6DPFBSvxEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5NiBTYWx0ZWRfX3/8DLoQTGdiq
 1v8VLpCNnr4iW5OHjfdBkDLf0NM1aPSAJDCkaSP5yhmLlL8GBxx6qH1eatgnM+1NGHZJfY59v5I
 nw10jDacuBsYPawS5LpjCAUA1zakzYc=
X-Proofpoint-ORIG-GUID: BH9S5W1pfANxxRFBHigtHHQEO7DAfXex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140196
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Tue, 14 Jul 2026 09:25:08 +0100 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com> wrote:
>
> On Mon, Jul 13, 2026 at 01:07:22PM -0700, Matheus Tavares Bernardino wrote:
> > 
> > --- /dev/null
> > +++ b/tests/functional/hexagon/test_systests.py
> > @@ -0,0 +1,133 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +import re
> > +import time
> > +import unittest
> > +
> > +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> > +
> > +
> > +_TARBALL_BIN_PATH = os.path.join(
> > +    "systests_standalone_package",
> > +    "StandaloneSysTests_6.4.0.2_v68",
> > +    "bin",
> > +)
> 
> Don't use os.path.join to refer to files needed by the test
> suite - always use one of the helper methods on the QemuBaseTest
> class....

I'll use self.scratch_file, like you suggested below, thanks.

> > +
> > +
> > +class SysTestsStandaloneTests(QemuSystemTest):
> > +    SYSTEST_TIMEOUT_SEC = 30
> > +
> > +    ASSET_TARBALL = Asset(
> > +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.9/systests_standalone.tar.gz",
> > +        "db961ea3fcc389b478b3d5c2f3bac60bec87e7f3d7efef5e58a9ae8ee78d0e40",
> > +    )
> > +
> > +    def setUp(self):
> > +        super().setUp()
> > +        self.archive_extract(self.ASSET_TARBALL)
> > +        self.bin_dir = os.path.join(self.workdir, _TARBALL_BIN_PATH)
> 
> ...so also skip this...
> 
> > +        self._orig_cwd = os.getcwd()
> > +        os.chdir(self.workdir)
> > +        self.addCleanup(os.chdir, self._orig_cwd)
> 
> Don't change directory during tests - use properly qualified paths
> to files.

Our test kernels from systests_standalone.tar.gz expect the files to be in the
current working directory. But if changing dir is not advisable, I'll modify
the binaries to receive the paths from argv.

> > [...] 
> > +    def test_fopen(self):
> > +        """fopen reads a file passed via --append and verifies its contents."""
> > +        with open(os.path.join(self.workdir, "dummy.so"), "w") as f:
> 
>   self.scratch_file("dummy.so")
> 
> > +            f.write("valid\n")
> > +        self.run_exit_zero("fopen", "-append", "dummy.so")
> 
> How is this working ?  You've created a file dummy.so on the host OS,
> and you're passing a filename "dummy.so" to -append which is a kernel
> arg. The implication is the kenrel opens this file, but how is the guest
> kernel accessing the file from the host ?!?!??

It access the file through semihost, which exposes host I/O to the guest. This
functional test strives to validate that.

> > [..]
> > +    def test_semihost(self):
> > +        semihost_dir = os.path.join(self.workdir, "_semihost_dir")
> > +        os.makedirs(semihost_dir, exist_ok=True)
> > +        open(os.path.join(semihost_dir, "fileA"), "w").close()
> > +        open(os.path.join(semihost_dir, "fileB"), "w").close()
> 
> The intermediate dir feels redunddant - why not just create fileA & fileB 
> directly ? ie
> 
> self.scratch_file("fileA")
> self.scratch_file("fileB")

The test[1] checks that qemu's hexagon semihosting can traverse the directory
to list the files, so we create a new directory to control exactly which
entries will be in it.

[1]: https://github.com/qualcomm/qemu-hexagon-testing/blob/c0f407d429dd26b453174a5a61082fe5ffdb8d2a/standalone_systests/src/semihost.c#L240

