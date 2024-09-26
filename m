Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D260CCCFA07
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 06:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sthgy-0003fH-1p; Thu, 26 Sep 2024 02:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sthgo-0003eL-Ea
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 02:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sthgh-0002oQ-VZ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 02:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727330954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xYlgMidlBxihLGTDW5eYp+2XaxxbSBMMiXXXK1PXi2I=;
 b=JSUysFLCfHdAWqwFVQxgmLdoJRin4ZUJG1mnD8mtRS0KeHmaRG4bc8O2qroEuJieF75SA2
 hKCztar1sneb/cFlENJoG+cHcrOUnkkHZn7PcQXbuOjGkkFs+rnIhK27Bh0/zG2y06CkmT
 HKRVnfhmQ9iay7BxSa5ZwG2CbvwCZbg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-MMv7iZqePCudaQdw5ZXxcg-1; Thu, 26 Sep 2024 02:09:12 -0400
X-MC-Unique: MMv7iZqePCudaQdw5ZXxcg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb9e14ab6so3668875e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 23:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727330951; x=1727935751;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYlgMidlBxihLGTDW5eYp+2XaxxbSBMMiXXXK1PXi2I=;
 b=kEnqVBDFcBqWH721nvSZ6KGVgohKj7RexQztONM2KA5zbVELTVe73gnyD0TrUMIEZ8
 6g9PIYOiEcfjNjVbXjzCKuGyLFHyPeQyT+hwZw/YWnhJ9CKB3zpO9+c4CVKXVM9Mnpsj
 syUaZEp0S2CVXd6lAKswUNKGqBK+CFfo9M5jGuPw+LnIsDx/sjfSxBSeP8ZBNQ0agiRM
 Tqt73kwYWY66DEtNfN1KAFg4vy2J2DquRwzo3/hZEXVA0iOdwKSWspk6aFVh/Q2q7tOH
 LQEbPzlVyv+jXSKpHaG4WjV3r+XHUKDjgbOX2Zi1bLsO9/hP3PZ7uorBn8gxs6Blh1rF
 xgeg==
X-Gm-Message-State: AOJu0YyNzaFrX1kfrDRFIgUNoSOoYvHmmkg5pN4Ml9MGeFFwu3ELAIR7
 y/ddfdhlbblq/QSS2JzkrhDoYDS6XSsikpPIxYsqZ7XdiN2ykvcqIFvY+vNQ7t0lt6F/5+kFSlV
 wfqM0UMRxwaulPscrD52Dtl3EMu8oxa2PmLlFYtWS2lx98FLtTEHEaFE49hmJoKJQKDlsIj9sAl
 o57xDm7g0LXRTcgqveBaSWOqcyeK6Fnmr2QpE=
X-Received: by 2002:a05:6000:2185:b0:37c:cbca:fd82 with SMTP id
 ffacd0b85a97d-37ccbcb0633mr3422433f8f.1.1727330950923; 
 Wed, 25 Sep 2024 23:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe9NigTjtXyc+ifDFa2xhB14OCcqW8b3haReScMALsBqrG4c8AYr69VQRPGFa/VQ6TR0ujmA==
X-Received: by 2002:a05:6000:2185:b0:37c:cbca:fd82 with SMTP id
 ffacd0b85a97d-37ccbcb0633mr3422415f8f.1.1727330950486; 
 Wed, 25 Sep 2024 23:09:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddb1fsm36769535e9.3.2024.09.25.23.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 23:09:09 -0700 (PDT)
Message-ID: <e609161b-bb13-4600-bceb-c5fe884c39ea@redhat.com>
Date: Thu, 26 Sep 2024 08:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 32/38] tests: add FreeBSD tests for aarch64/sbsa-ref
To: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
 <20240919131106.3362543-33-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240919131106.3362543-33-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19/09/2024 15.11, Peter Maydell wrote:
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> 
> FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
> than OpenBSD (7.3 we use is already EoL). Also bugfixes are backported
> so we can stay on 14.x for longer.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-id: 20240910-b4-move-to-freebsd-v5-2-0fb66d803c93@linaro.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/test_aarch64_sbsaref.py | 43 +++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
> index 528882f4fa9..89d0b9587a8 100755
> --- a/tests/functional/test_aarch64_sbsaref.py
> +++ b/tests/functional/test_aarch64_sbsaref.py
> @@ -1,6 +1,6 @@
>   #!/usr/bin/env python3
>   #
> -# Functional test that boots a Linux kernel and checks the console
> +# Functional test that boots a kernel and checks the console
>   #
>   # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
>   # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
> @@ -184,5 +184,46 @@ def test_sbsaref_openbsd73_max(self):
>           self.boot_openbsd73("max")
>   
>   
> +    ASSET_FREEBSD_ISO = Asset(
> +        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
> +         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
> +        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461')
> +
> +    # This tests the whole boot chain from EFI to Userspace
> +    # We only boot a whole OS for the current top level CPU and GIC
> +    # Other test profiles should use more minimal boots
> +    def boot_freebsd14(self, cpu=None):
> +        self.fetch_firmware()
> +
> +        img_path = self.ASSET_FREEBSD_ISO.fetch()
> +
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            "-drive", f"file={img_path},format=raw,snapshot=on",
> +        )
> +        if cpu:
> +            self.vm.add_args("-cpu", cpu)
> +
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Welcome to FreeBSD!')
> +
> +    def test_sbsaref_freebsd14_cortex_a57(self):
> +        self.boot_freebsd14("cortex-a57")
> +
> +    def test_sbsaref_freebsd14_default_cpu(self):
> +        self.boot_freebsd14()
> +
> +    def test_sbsaref_freebsd14_max_pauth_off(self):
> +        self.boot_freebsd14("max,pauth=off")

  Hi Marcin,

these new tests cause the CI to time out in my fork of the QEMU repository:

  https://gitlab.com/thuth/qemu/-/jobs/7915380405
  https://gitlab.com/thuth/qemu/-/jobs/7916009309
  https://gitlab.com/thuth/qemu/-/jobs/7914930038

Looking at the console.log artifacts, it seems like this 
test_sbsaref_freebsd14_max_pauth_off is hanging at arbitrary points in time?

Could this somehow be fixed, or if not, shall we add a @skipUnless decorator 
here, too?

  Thomas


> +    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
> +    def test_sbsaref_freebsd14_max_pauth_impdef(self):
> +        self.boot_freebsd14("max,pauth-impdef=on")
> +
> +    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
> +    def test_sbsaref_freebsd14_max(self):
> +        self.boot_freebsd14("max")
> +
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()


