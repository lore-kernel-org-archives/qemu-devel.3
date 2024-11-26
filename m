Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0DD5A6DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 04:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFmkN-0001Yw-Tj; Mon, 25 Nov 2024 23:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tFmkJ-0001Vr-Gb
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tFmkH-0007xC-56
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732593612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx4ZrmYZbaomkJLQz/txIiMAtBdfbA/CsJYKkI+NBN8=;
 b=Gigay5w7PLqPq5QS8bbGmNJh4PXPlujj2q3nbYEJOICVs0yaa3mDMv5fOb9eaFdWu1jTn4
 Jqsnl40T1pm0C83anksf2HnBifwZQmAqW7h0+6j4MklTywA2ODykASVBhpB3nI0+VWMKge
 1EYdMzOFU6j8u8xksr59BjgA7zjP+3A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-1X5_eU2XN6Wy1DLAWIKv8g-1; Mon, 25 Nov 2024 23:00:10 -0500
X-MC-Unique: 1X5_eU2XN6Wy1DLAWIKv8g-1
X-Mimecast-MFC-AGG-ID: 1X5_eU2XN6Wy1DLAWIKv8g
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa5449e1d9cso188057466b.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 20:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732593609; x=1733198409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yx4ZrmYZbaomkJLQz/txIiMAtBdfbA/CsJYKkI+NBN8=;
 b=DyWk7WRmEfgPYZm76ftuN2XaAoNJEMLWDj1Byv1Aagd3g0nclMj9a3pw4kPcOIDsM3
 kT5y/pGWgyTKQxDlJ0JjWxviz2UF8KskV3NF3UPnaGeV0i9vZBsBAEjbVhG+JFz0MFeF
 zggehh4zSdrTOT6CsilyLWaSN05bYs2E2PXufOrcCSulSKL5XG8Hbhw46fjYuNwLCBk9
 ncxYM2Z/ehPjWSEsqASm/S0WkP5bpG7w5N6TFsxWkQnqR0guRATElAMgVyJAqlHL8Pmu
 9lo+bSJae8ZlPHmpXNEl8r/5EhMbuBC7uiXhR+iK/RW2qfubSRLfPNEVoWIwT6A+0fOv
 +svg==
X-Gm-Message-State: AOJu0YwKG4gFCPn16RUGh9GxFhjBqgWnZCfh1X19RWl7igVrytiQovk4
 p7dU4NGbBLfo2+zlCf/8M/ws9X+9BokatUeYBE4dh/+BDgux0KmYEdmXdfOdUKHaoWEwcjvLhMY
 LltJ4qka1986xEZbcE+pDIPo+2w293smBtgA6iIYYSC6vUPL+4OYk3YituQTtMawIhnSriiU4Mo
 LAyTBrxZfhqccJJ5q0r5U0sHHfwYSNf54cv3DoKA==
X-Gm-Gg: ASbGncuwMVUKbW+cgStoOsuTToXGrcxD9BDYLeoy8PmpzuiMWPmK94ZX3hXCGJWL26i
 SRH3T1y9nLQgpsZ/0qhdjhmpCeyCHMto=
X-Received: by 2002:a17:906:9ca:b0:aa5:451c:ce21 with SMTP id
 a640c23a62f3a-aa5451cd10bmr575955266b.40.1732593608844; 
 Mon, 25 Nov 2024 20:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj1GfiqY9Mj4ERlfDakQ3lEVtkDKPaIp0Rd0FiYO2+dWeIG6Ral+Trmmv+RloUPwDoagK6WK1Vw75FzhQSI3I=
X-Received: by 2002:a17:906:9ca:b0:aa5:451c:ce21 with SMTP id
 a640c23a62f3a-aa5451cd10bmr575954066b.40.1732593608490; Mon, 25 Nov 2024
 20:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
 <20241125152105.2100395-9-alex.bennee@linaro.org>
In-Reply-To: <20241125152105.2100395-9-alex.bennee@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 26 Nov 2024 09:29:57 +0530
Message-ID: <CAK3XEhOkpJ6cxQtd7TrWt2+o8COF6O2Gv5wHDVi62GtEZ1WK3A@mail.gmail.com>
Subject: Re: [PULL 08/28] tests/functional: honour self.workdir in ACPI bits
 tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 25, 2024 at 8:51=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The ACPI bits test sets up its own private temporary directory into it
> creates scratch files. This is justified by a suggestion that we need
> to be able to preserve the scratch files. We have the ability to
> preserve the scratch dir with our functional harness, so there's no
> reason to diverge from standard practice in file placement.

Thanks for fixing this.

Acked-by: Ani Sinha <anisinha@redhat.com>

>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-Id: <20241121154218.1423005-9-berrange@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20241121165806.476008-9-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_a=
cpi_bits.py
> index 4c192d95cc..3498b96787 100755
> --- a/tests/functional/test_acpi_bits.py
> +++ b/tests/functional/test_acpi_bits.py
> @@ -150,7 +150,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=3D=
too-many-instance-attributes
>      def __init__(self, *args, **kwargs):
>          super().__init__(*args, **kwargs)
>          self._vm =3D None
> -        self._workDir =3D None
>          self._baseDir =3D None
>
>          self._debugcon_addr =3D '0x403'
> @@ -169,7 +168,7 @@ def copy_bits_config(self):
>          config_file =3D 'bits-cfg.txt'
>          bits_config_dir =3D os.path.join(self._baseDir, 'acpi-bits',
>                                         'bits-config')
> -        target_config_dir =3D os.path.join(self._workDir,
> +        target_config_dir =3D os.path.join(self.workdir,
>                                           'bits-%d' %self.BITS_INTERNAL_V=
ER,
>                                           'boot')
>          self.assertTrue(os.path.exists(bits_config_dir))
> @@ -186,7 +185,7 @@ def copy_test_scripts(self):
>
>          bits_test_dir =3D os.path.join(self._baseDir, 'acpi-bits',
>                                       'bits-tests')
> -        target_test_dir =3D os.path.join(self._workDir,
> +        target_test_dir =3D os.path.join(self.workdir,
>                                         'bits-%d' %self.BITS_INTERNAL_VER=
,
>                                         'boot', 'python')
>
> @@ -225,8 +224,8 @@ def fix_mkrescue(self, mkrescue):
>              the directory where we have extracted our pre-built bits gru=
b
>              tarball.
>          """
> -        grub_x86_64_mods =3D os.path.join(self._workDir, 'grub-inst-x86_=
64-efi')
> -        grub_i386_mods =3D os.path.join(self._workDir, 'grub-inst')
> +        grub_x86_64_mods =3D os.path.join(self.workdir, 'grub-inst-x86_6=
4-efi')
> +        grub_i386_mods =3D os.path.join(self.workdir, 'grub-inst')
>
>          self.assertTrue(os.path.exists(grub_x86_64_mods))
>          self.assertTrue(os.path.exists(grub_i386_mods))
> @@ -247,11 +246,11 @@ def generate_bits_iso(self):
>          """ Uses grub-mkrescue to generate a fresh bits iso with the pyt=
hon
>              test scripts
>          """
> -        bits_dir =3D os.path.join(self._workDir,
> +        bits_dir =3D os.path.join(self.workdir,
>                                  'bits-%d' %self.BITS_INTERNAL_VER)
> -        iso_file =3D os.path.join(self._workDir,
> +        iso_file =3D os.path.join(self.workdir,
>                                  'bits-%d.iso' %self.BITS_INTERNAL_VER)
> -        mkrescue_script =3D os.path.join(self._workDir,
> +        mkrescue_script =3D os.path.join(self.workdir,
>                                         'grub-inst-x86_64-efi', 'bin',
>                                         'grub-mkrescue')
>
> @@ -290,17 +289,7 @@ def setUp(self): # pylint: disable=3Darguments-diffe=
r
>
>          self._baseDir =3D Path(__file__).parent
>
> -        # workdir could also be avocado's own workdir in self.workdir.
> -        # At present, I prefer to maintain my own temporary working
> -        # directory. It gives us more control over the generated bits
> -        # log files and also for debugging, we may chose not to remove
> -        # this working directory so that the logs and iso can be
> -        # inspected manually and archived if needed.
> -        self._workDir =3D tempfile.mkdtemp(prefix=3D'acpi-bits-',
> -                                         suffix=3D'.tmp')
> -        self.logger.info('working dir: %s', self._workDir)
> -
> -        prebuiltDir =3D os.path.join(self._workDir, 'prebuilt')
> +        prebuiltDir =3D os.path.join(self.workdir, 'prebuilt')
>          if not os.path.isdir(prebuiltDir):
>              os.mkdir(prebuiltDir, mode=3D0o775)
>
> @@ -321,10 +310,10 @@ def setUp(self): # pylint: disable=3Darguments-diff=
er
>
>          # extract the bits software in the temp working directory
>          with zipfile.ZipFile(bits_zip_file, 'r') as zref:
> -            zref.extractall(self._workDir)
> +            zref.extractall(self.workdir)
>
>          with tarfile.open(grub_tar_file, 'r', encoding=3D'utf-8') as tar=
ball:
> -            tarball.extractall(self._workDir)
> +            tarball.extractall(self.workdir)
>
>          self.copy_test_scripts()
>          self.copy_bits_config()
> @@ -334,7 +323,7 @@ def parse_log(self):
>          """parse the log generated by running bits tests and
>             check for failures.
>          """
> -        debugconf =3D os.path.join(self._workDir, self._debugcon_log)
> +        debugconf =3D os.path.join(self.workdir, self._debugcon_log)
>          log =3D ""
>          with open(debugconf, 'r', encoding=3D'utf-8') as filehandle:
>              log =3D filehandle.read()
> @@ -360,25 +349,18 @@ def tearDown(self):
>          """
>          if self._vm:
>              self.assertFalse(not self._vm.is_running)
> -        if not os.getenv('BITS_DEBUG') and self._workDir:
> -            self.logger.info('removing the work directory %s', self._wor=
kDir)
> -            shutil.rmtree(self._workDir)
> -        else:
> -            self.logger.info('not removing the work directory %s ' \
> -                             'as BITS_DEBUG is ' \
> -                             'passed in the environment', self._workDir)
>          super().tearDown()
>
>      def test_acpi_smbios_bits(self):
>          """The main test case implementation."""
>
> -        iso_file =3D os.path.join(self._workDir,
> +        iso_file =3D os.path.join(self.workdir,
>                                  'bits-%d.iso' %self.BITS_INTERNAL_VER)
>
>          self.assertTrue(os.access(iso_file, os.R_OK))
>
>          self._vm =3D QEMUBitsMachine(binary=3Dself.qemu_bin,
> -                                   base_temp_dir=3Dself._workDir,
> +                                   base_temp_dir=3Dself.workdir,
>                                     debugcon_log=3Dself._debugcon_log,
>                                     debugcon_addr=3Dself._debugcon_addr)
>
> --
> 2.39.5
>


