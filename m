Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEEDC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5W4-0006Il-Hl; Wed, 29 Jan 2025 05:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td5W2-0006IR-SZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td5Vz-0007C6-K1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738147305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rKsIqkxhIJzFL53c2E8QgMWxqch1cYpijGwulYYKRdY=;
 b=O9IIi4SiBddgdK4572BffbZXUl4rgQ+2VQJ6bQT/FmUW0flR+DI6RG9MAhLelaxD6Y8tNq
 q3fV1Fh76FpK8cQ00PqVF+VOUEtIcPRjtRUAWmDvnygqfvVoaBdanJh2Ers77GZqfZyjwg
 8C9zfHIEhhapZBH/F77CzNPhfry7v48=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-N-hADQa1ODS2VUlQyKPZRw-1; Wed, 29 Jan 2025 05:41:43 -0500
X-MC-Unique: N-hADQa1ODS2VUlQyKPZRw-1
X-Mimecast-MFC-AGG-ID: N-hADQa1ODS2VUlQyKPZRw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso32210285e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738147302; x=1738752102;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKsIqkxhIJzFL53c2E8QgMWxqch1cYpijGwulYYKRdY=;
 b=kuVrKM2dcuZ51pLQPBqgOlacME+n2bFAtxoKVCHCYXBqltrf5ngNxPvHtzLYuU/AyE
 r2ETDNCXrXP744Kb9wY9WW8Mklbcl8LGdyKxBqjmWGSLZfmp6Lk5PcKUWAflqIZV+3aB
 cJGaR6oX+uluKDsa2yWWLECbQiILc4sgnMMgofl/u7B9q9HIureu7yfvqk3pYvnxmxxP
 ncxDF3Z+0vgBedBREax89XAvP6tC6OMwRIHVDyHpGT83N0P88iu3TTVLQnTVtbr/lP+x
 nFLy0OQnJelMTgWaG7RLWIZZtW1dSQ6a4DlHBZSKOH0n9CLxEuiekJKTrt4yvxzUm+hs
 mXGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3UegvlqEMS5zDbXfa1AdA6uGrgo1KnceTu5HwuEmtZf1JyqPxcVZYcwIjsn9BxckZ5iRlludYrLdK@nongnu.org
X-Gm-Message-State: AOJu0Yw5zlV1TxiA+N5zo8xeb3BcETNKuu6N8EB4NmqfiDRSpi1cfpW1
 zvjiYNkuyebgsjEWtxAx3y8KjOsRfMNaNO/B93Ih6Oi00Wb6s8G15REd913Gwtfs6+uuqap3iIi
 dUkuw1k2bCL7ZU5xWQah3C1qidrp88m+L/GrerVXCA8GHbDmLCB2M0bK7SXB8
X-Gm-Gg: ASbGncs10chCOcy+ZaJ+ZJ9D8gfuXHiu/eYGRN+yhDDofp/ZmPNwQ6kPn2+TktliR8g
 ehVa8G9aidR1Iyp0QwDJe77RPP/CZNtUMYRb4YqzQ77ZQ2C1okQ7y90+ICchfwM8ATam2cMmfRO
 tmP+QjCfHOzcVTbVmN/ih0Y61N4zwKCK/rMDVmne7EOQrREkW28uxL6bNq9yaj3tFB1HRzyD5wm
 FjdirpnC0H9zGazH9WSmwfLsHFxA3V8nlKUB+HOVcenzVwMcnv6MJaJBRjJ6+BqK7uy1l/TAojU
 nG2XvSXaD8nVXIAYFiGl3c1nae+3GeyO2Hza
X-Received: by 2002:a05:600c:b8d:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-438dc3c2221mr20861225e9.8.1738147302496; 
 Wed, 29 Jan 2025 02:41:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmi3xno0TUZqts3dTH/fAKZrUQycC8Y4rXH6TawqFEJGbYxUSpB5rYzikICAkwDQx1TzTNww==
X-Received: by 2002:a05:600c:b8d:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-438dc3c2221mr20861025e9.8.1738147302145; 
 Wed, 29 Jan 2025 02:41:42 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6de2dsm18128425e9.26.2025.01.29.02.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 02:41:41 -0800 (PST)
Message-ID: <03ac1d2d-cb78-40f7-b2d3-31dcba0ee6d6@redhat.com>
Date: Wed, 29 Jan 2025 11:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Extend PPC 40p test with Linux boot
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
References: <20250129102223.1313703-1-clg@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250129102223.1313703-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/01/2025 11.22, Cédric Le Goater wrote:
> Fetch the cdrom image for the IBM 6015 PReP PowerPC machine hosted on
> the Juneau Linux Users Group site, boot and check Linux version.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_ppc_40p.py | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
> index 7a74e0cca70b..5ce79aec5e6b 100755
> --- a/tests/functional/test_ppc_40p.py
> +++ b/tests/functional/test_ppc_40p.py
> @@ -9,7 +9,7 @@
>   
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern, skipUntrustedTest
> -
> +from qemu_test import exec_command_and_wait_for_pattern
>   

Please keep 2 empty lines between the imports and the class statements 
(Daniel recently tried to standardize on this coding style)

>   class IbmPrep40pMachine(QemuSystemTest):
>   
> @@ -72,5 +72,23 @@ def test_openbios_and_netbsd(self):
>           self.vm.launch()
>           wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
>   
> +    ASSET_40P_SANDALFOOT = Asset(
> +        'http://www.juneau-lug.org/zImage.initrd.sandalfoot',
> +        '749ab02f576c6dc8f33b9fb022ecb44bf6a35a0472f2ea6a5e9956bc15933901')
> +
> +    def test_openbios_and_linux(self):
> +        self.set_machine('40p')
> +        self.require_accelerator("tcg")
> +        drive_path = self.ASSET_40P_SANDALFOOT.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-cdrom', drive_path,
> +                         '-boot', 'd')
> +
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Please press Enter to activate this console.')
> +        exec_command_and_wait_for_pattern(self, '\012', '#')
> +        exec_command_and_wait_for_pattern(self, 'uname -a', 'Linux ppc 2.4.18')
> +        exec_command_and_wait_for_pattern(self, 'poweroff', 'Terminated')
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()

With the nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


