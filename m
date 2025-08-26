Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4D3CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHO-00045a-2T; Tue, 26 Aug 2025 12:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uqwHM-00042b-8f
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 12:12:12 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uqwHI-0007s0-9c
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 12:12:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1756224711; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oIgY4wP+n+J0RuHiEpxnuDCbQyJmEgf+ELDsixTID0KvXYCR9zk0o7XC9YLS+9Wd9D6GgzGnaXUNZRUeKB+FyxxQSOeCoZHPHap+npUkzUaiWVa2+H1FncXqPXQnpCl1YsGoVkoVAytYUMF0HtaBpeh5o3s98qNBE8Qr0v/rw2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1756224711;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YUDA0L4U1Vf1e3PJBNHvJc2zWuNcqsgNP1gSSwsEPOs=; 
 b=GPp1FfS0pPsNP4qKRW8/wu1p2OBQnL9njqoA+18soF3YA1t51J5uJTowu7XTWoTz1CiBSrPE250cfGy2FCT+8WJN8WyOYH8qyLPyfgQPXc3EnXaTUBUUdHvbzXnz6GqO0JnKouTHeL6pZq5Blsl0Di1Fe9d9suPADTU09zRDfWE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756224711; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=YUDA0L4U1Vf1e3PJBNHvJc2zWuNcqsgNP1gSSwsEPOs=;
 b=fTyuJ+2WiYDT1Ytms0hooqp3JZ0Y6wO557eNrGhY5HJSyfwJUocR5zgYnH8ofdcO
 YnfhQ/xYARSGyCr/gLBDR71jkhEG0nM9wVAmg2eyomW8QCccbveZRkVhpNMyX35sbaB
 5QWr7dx/tdrUfxlVSSSOU+AA2s8wg4Cz/CeEdi88=
Received: by mx.zohomail.com with SMTPS id 1756224708787629.6723358167159;
 Tue, 26 Aug 2025 09:11:48 -0700 (PDT)
Message-ID: <98f97bda-3936-4025-b706-61ac6136493c@collabora.com>
Date: Tue, 26 Aug 2025 19:11:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_aarch64_virt_gpu: Skip test if EGL
 won't initialize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20250826123455.2856988-1-peter.maydell@linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250826123455.2856988-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/26/25 15:34, Peter Maydell wrote:
> If you are using the Nvidia drivers and have installed new versions
> of those packages but have not yet rebooted the host kernel,
> attempting to use the egl-headless display will cause QEMU to fail to
> start with
> 
> $ qemu-system-aarch64 -M virt -display egl-headless
> qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
> qemu-system-aarch64: egl: render node init failed
> 
> together with this complaint in the host kernel dmesg:
> 
> [7874777.555649] NVRM: API mismatch: the client has the version 535.247.01, but
>                  NVRM: this kernel module has the version 535.230.02.  Please
>                  NVRM: make sure that this kernel module and all NVIDIA driver
>                  NVRM: components have the same version.
> 
> This isn't a problem with QEMU itself, so reporting this as a test
> failure is misleading.  Instead skip the tests, as we already do for
> various other kinds of "host system can't actually run the EGL
> display" situation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I run into this fairly often so I got fed up with just ignoring the
> spurious test failure messages...
> ---
>  tests/functional/test_aarch64_virt_gpu.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index 38447278579..4e50887c3e9 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -76,6 +76,8 @@ def _launch_virt_gpu(self, gpu_device):
>                  self.skipTest("egl-headless support is not available")
>              elif "'type' does not accept value 'dbus'" in excp.output:
>                  self.skipTest("dbus display support is not available")
> +            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.output:
> +                self.skipTest("EGL failed to initialize on this host")
>              else:
>                  self.log.info("unhandled launch failure: %s", excp.output)
>                  raise excp

Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

