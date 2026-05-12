Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFECD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpTi-0002iR-HG; Tue, 12 May 2026 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpTh-0002hp-1x
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:57:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpTf-0007Y9-8n
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:57:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CAkYgr739985
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LihbsBIYCLZcZ3zv1TBKVe7K+Pir6Ledka+UoWPYczo=; b=Kf4qOSB8y47iSFrl
 7+RabtZIXUMENsiazoJcNPSGEBmnq3nFHLzBVOChMBOFatEIdDDNTRiPYDOOqt7M
 WnDDi7eXYSGPC95NQ5Ofb7ITcZE/j7oMjXeL5zBK1KMu99gzXNhIU8I0niHW8AwA
 uUQ9iGgryzcEHpl/jRo8WYMcKJTddIqkBKn+PCa5L60+SR/an/+9h4a2eJvkyDhR
 QyzPQveJSCynRAxNVMmQzuysSpkeA/Dj2tKM6uzOtOlP45rEzLUZ6or8u0QOicLW
 2mp3G45OiQtvZBmrLoWIBfg2TSPai9ab4p5PO+2Fr0MiyCOLNrISQecXt6z4KqEo
 Mp2yMw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhs9fa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:56:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso7304808eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778601417; x=1779206217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LihbsBIYCLZcZ3zv1TBKVe7K+Pir6Ledka+UoWPYczo=;
 b=C99EHchvsUFHau24Hq5QbQZ2pnWLvnh4KVKN/2XNLDSQjJkWdReUNA/PNfmGHCXzi8
 ZsoXn/4NQXDpKzuAEm7+jqIXXrPug/Uf/g8MSiffl5XvxsuzBS5EbX6GP0N1vdoNhv58
 jb6jH4vaC+xEEnYjUImnr9EKoVfMX8PISDXV8cwqCjh1mI3TJ0P7bs+4JDuTFmd+4ddX
 rWUaJvi0GLr1tfhIldf9FegJ7EUD1ck96oFm58Xc72FyOM0F5L/Pjvjp26OJE6trLHL8
 E5ZWncRpWbPoS9x+96qTxjAuF/a5tiX87iqMCSNReLLLblmE8reqxRbYOia1OrHzvDhO
 Y/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778601417; x=1779206217;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LihbsBIYCLZcZ3zv1TBKVe7K+Pir6Ledka+UoWPYczo=;
 b=F1l6F6f7CDBJi5AVG4yZj3vp47lzbBU8z+16hwI9DWp5NlamRvMKP+tAve4fNldFHP
 nYyroZaoEbiAaGgmXpE/gzF1e6uTe1qgWYq7gQuFxZWL1TWRDQS5wlUEknAk4WVKP1Gr
 RjHTC413M316UVGhWtcicErZ5ZN1kzlLzwCM2lNfEBsdngjA+kM9n9mHj7pzga2XMiIb
 2YXw9T2qy6fMzKpMWLW05kN01G/0KfwFybSjKx3INFj3qnG2u1p+mVdFnRSs48cp0rec
 Lz2lLJfjHRTIsyDkOIuQa+4ksBSfPye1ayR54PydflxGV4mh4+BUCnyFlRycRjQSb5p2
 Kz9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hS/PGOPra7YSO8RVX0rE67QgtZO6gMk/XLQ1baACbstktM7kNSkxdtK8NTm5EjmQA9SBGAx3eYn7f@nongnu.org
X-Gm-Message-State: AOJu0YxzyFUT8uhjq24NbNgw5f/R93oS++tQ7sHpW457mBOGv+2G0SfO
 AluYJeCk/+MH5JNmBFTb5EE43fu8oAeOAZvCj4IPaP1nhC82VQtxvN7NXuxD00nvGucZHVGvn6O
 fQ9tIMwGrNLvJrwyL2L8q8kE06Zb1Q7x9FPF8rAGV4h8Pu7M6FSWifncmHQ==
X-Gm-Gg: Acq92OHWKnlPy5xp7Bo00t81RUz2dmneicjI0jhwSixZyEyYJYjW8H2jGo5W4Earjpf
 PxyTANTR3O13QuzYA+iJYkX0pxmRzpDJLLJvEDsd/KQY/LYgvWV1EU6qzvkd7koImnAnTFgR685
 R0trelE5hwY4OgK6mWE7HLLikrInjwKKBFrBRg6aIB3f0mWVomSVvWIIfBlW75ADCM0BLP5mqGB
 pBKx0Lb/+gidGSoOak9psX7YLOXBQUvBRZp/1VtQcFnpAGum34Dfc0fcFy4QiKFMZ6CfVVs6/KL
 1dr74smI+RAxm5RMfyuSEVLbttss0QViafAXuAgrx2TXDQ1OhWnCJ2n/JcuwoUO40awu2HigOXe
 p9/n2N8F0ILJJZnCvfTdJTXWVNiFV9yEDXWhxwQFnZXkn+tmZpKS7Q+bd7YFxHk4YCwD05dzPFY
 /1SyUmT+nQugUv9Q==
X-Received: by 2002:a05:7300:c88:b0:2be:7885:31df with SMTP id
 5a478bee46e88-2f54f93d050mr14175643eec.17.1778601416649; 
 Tue, 12 May 2026 08:56:56 -0700 (PDT)
X-Received: by 2002:a05:7300:c88:b0:2be:7885:31df with SMTP id
 5a478bee46e88-2f54f93d050mr14175619eec.17.1778601415921; 
 Tue, 12 May 2026 08:56:55 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e3e285sm21553853eec.27.2026.05.12.08.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:56:55 -0700 (PDT)
Message-ID: <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:56:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-15-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NiBTYWx0ZWRfX60N7gJ31qOMb
 OwutRv004HEJeu3elgQDhb1qCpNbn6nqYntBrkEZs7wFmdv2n+PRo6dfK5oYUq3vlhGct2f4mMd
 DZwLYcEM4PZtKWisZ1pLpGssbUturFibun0drv9yYNRqnmSZI8Odxp0e56cyprNEcaEPckCiALy
 baDXIypr3tn+5n2fKWYKTQwRdvMM85pR25TfxI1Uh9ZkJT8JmBBLiYo0kFfg5kCX3bFVGZj3/SF
 9WwverqWGraL5lfaztxXWFQWX2vZ+Ae/AkOIn9mgj1uOyPhbxw3lQrtEwtgfWXSarIe3MrDbP+D
 oUv9A2+nx7w89yYrj+BrtpGfVksLtsnIqztbU/rXT2lzxa85B9IKLQFq05+3enhMTmjaN+kkrx1
 9nNnzLw0uXaRrf3yqPbpgeqOmgQtK7VZMRyDhPRI5BNrtqShuyGuViqdTFS7zdEix5B9SNg1XNo
 Cm6HBH4LZO5uQG+SaOQ==
X-Proofpoint-GUID: Stcw1I10yW7yfpW4J1ZgkZsuX65GU4El
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a034dc9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=n3iCv7x4eOGbQ2_T6jgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Stcw1I10yW7yfpW4J1ZgkZsuX65GU4El
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> The nature of block I/O tests is such that there can be unexpected false
> positive failures in certain scenarios that have not been encountered
> before, and sometimes non-deterministic failures that are hard to
> reproduce.
> 
> Before enabling the I/O tests as gating jobs in CI, there needs to be a
> mechanism to dynamically mark tests as skipped, without having to commit
> code changes.
> 
> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
> variable can be set as a GitLab CI pipeline variable to temporarily
> disable a test while problems are being debugged.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/testing/main.rst      |  7 +++++++
>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 797111009a..f779a64415 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>  More options are supported by the ``./check`` script, run ``./check -h`` for
>  help.
>  
> +If a test program is known to be broken, it can be disabled by setting
> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
> +leading component can be omitted to skip the test for all formats and
> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
> +
>  Writing a new test case
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> index dbe2dddc32..ecb5d4529f 100644
> --- a/tests/qemu-iotests/testrunner.py
> +++ b/tests/qemu-iotests/testrunner.py
> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
>  
>          self._stack: contextlib.ExitStack
>  
> +        self.skip = {}
> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
> +            rule = rule.strip()
> +            if rule == "":
> +                continue
> +            if ":" in rule:
> +                fmt, name = rule.split(":")
> +                if fmt in ("", env.imgfmt, env.imgproto):
> +                    self.skip[name] = True
> +            else:
> +                self.skip[rule] = True
> +
>      def __enter__(self) -> 'TestRunner':
>          self._stack = contextlib.ExitStack()
>          self._stack.enter_context(self.env)
> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
>                                description='No qualified output '
>                                            f'(expected {f_reference})')
>  
> +        if f_test.name in self.skip:
> +            return TestResult(status='not run',
> +                              description='Listed in QEMU_TEST_IO_SKIP')
> +
>          args = [str(f_test.resolve())]
>          env = self.env.prepare_subprocess(args)
>  

Why not simply remove the broken tests, and create issues to add them
again in the future?

Once it's green, in theory, code breaking existing tests should not be
merged, right? So what would be the usage of this variable?

Regards,
Pierrick

