Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BEBD6EBF1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 09:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGxfD-0003ab-LB; Fri, 29 Nov 2024 04:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tGxfC-0003aS-Fn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 04:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tGxfB-0000xe-30
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732873908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P35OpQJs1WXsfxzXQ6lmbbwmLk7R5Ei6UZJtOK15f0=;
 b=Oea/n552j9Y4FMX4edSgJFv3SWmP8wySgZO0fUIVQUVmtgFzuLwXaPrrZqU/RyGPhIGpG0
 tuhfslI0NmYq28o6dIkt+kp9P3C49BhAHmC066unH+18nyvGRK9b+HUEPOCLxhitNnN5w4
 ZZ1gYyrgrY0Ht3Qe9gv2P7z8InfzvUU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-jdjmjlYePmG6xgtB7DvAgw-1; Fri, 29 Nov 2024 04:51:45 -0500
X-MC-Unique: jdjmjlYePmG6xgtB7DvAgw-1
X-Mimecast-MFC-AGG-ID: jdjmjlYePmG6xgtB7DvAgw
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7fb966ee0cdso1212790a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 01:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732873903; x=1733478703;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7P35OpQJs1WXsfxzXQ6lmbbwmLk7R5Ei6UZJtOK15f0=;
 b=Eh7JP4aAuqbhdy2yPaQBbaq0g0Pe6lJZs9GQ6mjS8nY5ibdizXIGq0kIYo/7wuwa/U
 YTnVGPqcoDMLqPRsx3gJ82RLWsAiAd84PIl5oyxsb3+hbD9d2wYFhOqaF707TBFjqbml
 ILrXGmCunFKS8AFDcX5LW8kNcuZ+aJKiCTyL4j6YyC6epcAgde7anJHGdzxMXrDhsLzN
 xOEkQrKqcsTvLiS4cUWkjDKRuIehjHUVFccaQuitUrYXlrmhFJBxGJzQ6wqix6UjYCJl
 jTxGH4d0Ew8wIacRSBPhMjsob4EUZyAxBgnK2tuoFxf/zI7G4pvpemoSUguo6xgLKVu2
 Zq+w==
X-Gm-Message-State: AOJu0YzFCSnnUkERWvw61QrgY0MQH1GTaGLPhLtRUm28ALK0OWhzCPsU
 aEhH4z9MGL+Gy743rVCveKiTRicpT1/ouVyZqHmnyPzjPTUByITB4lZWbO9Ot5AT0M/ELs1WMFb
 o/zbiOpN5BE7SX57IC1KX0Gm5L8OZf3IIhUNkhp0/iCCq0/bjkxBYprM3NW/HVZk=
X-Gm-Gg: ASbGnct08Ya0XCMauGf0OGP8a4zktNw9qdbBYxvMZi+Am9KVJ5XzBHUEzaeFgw+o7Cc
 wscOvu6nd3oUHNPY7+zrlnplORE/Wj/kri5iSoI150nNMDGbzgtPB1zx45/56Soj6DkL+rR6TMY
 M9boVS1Xhj5NmVxxtd4db5NWsMA8OiSdcUKG1a5N1Exc/ctzN+P8zIrJ7RwC+gw4xbDdbh7hN5W
 Lrt/vrcpunSupWfSeL6bjHifCWv6qHzbg/eVvsBGGH9iF7ViLgY9PNUp+FfUOzoUg==
X-Received: by 2002:a17:90b:3902:b0:2ea:49a8:9169 with SMTP id
 98e67ed59e1d1-2ee25ae1094mr11291709a91.7.1732873903539; 
 Fri, 29 Nov 2024 01:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNdjGg6NKJutsNYWDh6K/1BRgeQQDW4Qr3EFo37mbf7I6UPKXogNBKwhBhMaykfOPm6JdM3g==
X-Received: by 2002:a17:90b:3902:b0:2ea:49a8:9169 with SMTP id
 98e67ed59e1d1-2ee25ae1094mr11291673a91.7.1732873903159; 
 Fri, 29 Nov 2024 01:51:43 -0800 (PST)
Received: from smtpclient.apple ([116.72.142.63])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0532e9acsm2791969a91.1.2024.11.29.01.51.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2024 01:51:42 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] tests/functional/test_acpi_bits: Turn the test into a
 QemuSystemTest
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20241128115019.591362-1-thuth@redhat.com>
Date: Fri, 29 Nov 2024 15:21:27 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3658F5CB-5175-49CA-AAD9-183A9E1A1ED5@redhat.com>
References: <20241128115019.591362-1-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 28 Nov 2024, at 5:20=E2=80=AFPM, Thomas Huth <thuth@redhat.com> =
wrote:
>=20
> By using QemuSystemTest as a base class, we can use the set_machine()
> command to check whether the required machine is available in the
> binary (otherwise this test is failing when QEMU has been compiled
> without the default 'pc' machine type).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/functional/test_acpi_bits.py | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/functional/test_acpi_bits.py =
b/tests/functional/test_acpi_bits.py
> index 3498b96787..e2f84414d7 100755
> --- a/tests/functional/test_acpi_bits.py
> +++ b/tests/functional/test_acpi_bits.py
> @@ -50,7 +50,7 @@
> )
> from qemu.machine import QEMUMachine
> from unittest import skipIf
> -from qemu_test import QemuBaseTest, Asset
> +from qemu_test import QemuSystemTest, Asset
>=20
> deps =3D ["xorriso", "mformat"] # dependent tools needed in the test =
setup/box.
> supported_platforms =3D ['x86_64'] # supported test platforms.
> @@ -127,7 +127,7 @@ def base_args(self):
> @skipIf(not supported_platform() or missing_deps(),
>         'unsupported platform or dependencies (%s) not installed' \
>         % ','.join(deps))
> -class AcpiBitsTest(QemuBaseTest): #pylint: =
disable=3Dtoo-many-instance-attributes
> +class AcpiBitsTest(QemuSystemTest): #pylint: =
disable=3Dtoo-many-instance-attributes
>     """
>     ACPI and SMBIOS tests using biosbits.
>     """
> @@ -284,7 +284,7 @@ def generate_bits_iso(self):
>         self.logger.info('iso file %s successfully generated.', =
iso_file)
>=20
>     def setUp(self): # pylint: disable=3Darguments-differ
> -        super().setUp('qemu-system-')
> +        super().setUp()
>         self.logger =3D self.log
>=20
>         self._baseDir =3D Path(__file__).parent
> @@ -354,6 +354,7 @@ def tearDown(self):
>     def test_acpi_smbios_bits(self):
>         """The main test case implementation."""
>=20
> +        self.set_machine('pc')
>         iso_file =3D os.path.join(self.workdir,
>                                 'bits-%d.iso' %self.BITS_INTERNAL_VER)
>=20
> @@ -388,4 +389,4 @@ def test_acpi_smbios_bits(self):
>         self.parse_log()
>=20
> if __name__ =3D=3D '__main__':
> -    QemuBaseTest.main()
> +    QemuSystemTest.main()
> --=20
> 2.47.0
>=20


