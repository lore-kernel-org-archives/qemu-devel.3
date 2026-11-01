Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55EB606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+RbxwUY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNVSr-0005B0-NP; Sun, 01 Nov 2026 08:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xNVSi-000592-0a
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 08:19:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xNVSg-0001En-7Y
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 08:19:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so19543335e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793539140; x=1794143940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ksHhiQCiUnxbhloByktUJ8gXU9lR2HIKf8kgi+Hc+8M=;
 b=n+RbxwUYTh2tPLP6nbmK2655EFfJJD63fHgjYns3AukMgjczmG1COu1kgh8NHpX6Gs
 /2iRP/35+PngarZYH3m7qVdolI++QGL6X+mTiy+QRDQHVsLpCB+s2h0Hk4tYAUKlq2a/
 Ebk4yGF1i4zJNU8IEHlztS6CWIgxiSu6yERPUPC686hNUjTEVj3Al5LaDDptiq6dy1IG
 V1rnri7xGZR8luOfT5ToVNIbGDEPRBbcdQUGWO82p1YDSd1OqJJh+5kN7q53iwtFrLI6
 PpIMhDuBSqh+jpVudhiJpOpbPVNiCKcG3xZXICZL0bwd9aaqzy2IjI+qNj8qo7HQC9Yg
 U5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793539140; x=1794143940;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksHhiQCiUnxbhloByktUJ8gXU9lR2HIKf8kgi+Hc+8M=;
 b=t9ApRf2ivDIM3B7FIVGMs+CfTRX4T4B7LLn3l2UuqWt88JsEzNcewrHy/tK5kdI2+v
 CZT7ifnZgRGw5fXNfbfgMZ0ljbb+UkcTy9DKvAgxxtWyrbF+7vlSAipF8Hpku88/4Rkv
 7Q4iOk3DorvJd5Knd3YQbHLK9O7mUcZ9Hc5q5iGRa8ga/rMlGQKUTle2+AsJP4FXSzJz
 Tp+fkdFp0qlMuTVe+iJuCkuwA5rAJg6fXUREDhlNyNq3e7AkQMpwAXWPAJE2YpWyNaAp
 IxUpT8DmIRQabkUZuZfsj7DJ+5cCKbonR40TSuQd7WtMHbjNvm//Rz52TCGoMjNmdh6a
 OAcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr63GxaeQ6R5HCSfwpqzcG+6VdlbzrVn77yGOMSfvngK39Xt7iarbH9NB9fiTBV7IMS3/ueOeIzh6l@nongnu.org
X-Gm-Message-State: AFq9FYJN8dw0mYDwEZyYTenXSHgUEorraChN9w1zlt2Udj/h9BwNSoU2
 pwZRkUYmnXXEh2KdkPy5qQDuzpoWxWun69tTCMXmc5KeEOXLEuRMR3w/
X-Gm-Gg: AYBFou0Nlg8OiAd+ATW522xZbGIR0DInXmlcjNu8F8rCM4YwZuVN1GGfKpKTNrQT3eS
 VEPOlPJ1kzIUOPtX0gt/VGc9DiRx6NNqTLKveTJ6dx9q2+tUJp9AawUoizwMvUlVHpGuzd5TYfD
 toGrjdGSvKcM6NJCmnnmDf9mfz/ddPoHvi1rKvWV2gdtkPg185EC0xDZinu5gcp+BxqDYGTNDFR
 pTS8mF3c42vzGc6AmwrSWKgtANeTLIOgN+ovKGdexU3ak9P3H5Rrz8VDHxicXZ9pCL96niVBFnq
 XnlYyoU+m1tbAMdhsddXgvQd+ljWDJCz6FgsRHex4xYs43dQqwhxcNevxuWYclVURHxPlMGrF4N
 aFiEUuVTel+D3I0/5HXinHfs6mjMVjL92cj1/VRvodq9g5mstd8nCsoW8IIcZi8L5EXXry/weMw
 7VmQ7uzdVf+nPhs1OESbPhHffZajbFB2ed+H2ehPP9042yOiQwYtbOQbM7UvU54UxfJlcdEQdWu
 oVKMVoO1smSUdtjfMZJboCPTZ6XySS+EKcOKDgyqDO8/z8R0f4sTz37dMWgUylHDh2bVsioBuJJ
 fG2kpsAdHca6NOosxNYOlwUi9yAl0p4egH1mwwAx7NniCXhJOUiU95Jr0XEgDUb3rSTwPELwhOU
 Ij0i+uifYV75ij7Y=
X-Received: by 2002:a05:600c:1909:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4ac18b7dff9mr164059855e9.21.1793539140029; 
 Sun, 01 Nov 2026 05:19:00 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-077-013-241-109.77.13.pool.telefonica.de. [77.13.241.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm14207266f8f.57.2026.11.01.05.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 05:18:58 -0800 (PST)
Date: Sun, 01 Nov 2026 13:18:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_03/11=5D_tests/functiona?=
 =?US-ASCII?Q?l=3A_Fix_i=2EMX8MP_EVK_SMP_configuration?=
In-Reply-To: <20261007101105.3917771-4-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
 <20261007101105.3917771-4-gaurav.sharma_7@nxp.com>
Message-ID: <AE3F9CD0-3F2F-4BF9-BD20-427E15706EA4@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 7=2E Oktober 2026 10:10:57 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7=
@nxp=2Ecom>:
>Remove the explicit '-smp 4' argument from the functional test=2E
>The SMP CPU count is now fixed internally via mc->default_cpus and
>no longer needs to be specified by the caller=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> tests/functional/aarch64/test_imx8mp_evk=2Epy | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/tests/functional/aarch64/test_imx8mp_evk=2Epy b/tests/functi=
onal/aarch64/test_imx8mp_evk=2Epy
>index 99ddcdef83=2E=2E6046c573d5 100755
>--- a/tests/functional/aarch64/test_imx8mp_evk=2Epy
>+++ b/tests/functional/aarch64/test_imx8mp_evk=2Epy
>@@ -53,7 +53,6 @@ def test_aarch64_imx8mp_evk_usdhc(self):
>         self=2Eset_machine('imx8mp-evk')
>         self=2Evm=2Eset_console(console_index=3D1)
>         self=2Evm=2Eadd_args('-m', '2G',
>-                         '-smp', '4',

The -m and -smp parameters are both removed in current master=2E However, =
this patch is not obsolete: It should contain the smp hardcoding to 4 which=
 is still mixed into patch "[PATCHv4 11/11] hw/arm: Enable Cortex-M7 AMP bo=
ot on i=2EMX8MP"=2E

Best regards,
Bernhard

>                          '-kernel', self=2Ekernel_path,
>                          '-initrd', self=2Einitrd_path,
>                          '-dtb', self=2Edtb_path,

