Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AA1C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBCw-0001Ga-OA; Wed, 12 Feb 2025 06:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiBCk-0001CS-5W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiBCd-0002YV-I4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739360810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6XiwCfz+nKDKJLdJPfvfodCuEZr+wHsHEy+a5HiTISo=;
 b=a65jV0A+gXV/YCCrMrEghA0gad6V1cShJdNNnVzhGvNJVxpZ7gFlSHBxBjUBFD8pJpkLYa
 J7NAPSeUGjw7JlmG6YAHE8zoUvfVzIp/v02eDuWhms2GoNWDJqGe9p5L/cAMiJVh7k2nqA
 /cOKJ1dicMvDRaU14LyGZCLjm2wADQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-hcXVbOWcO0ylBAzENEVJ3A-1; Wed, 12 Feb 2025 06:46:48 -0500
X-MC-Unique: hcXVbOWcO0ylBAzENEVJ3A-1
X-Mimecast-MFC-AGG-ID: hcXVbOWcO0ylBAzENEVJ3A
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4395586f952so8201025e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360807; x=1739965607;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6XiwCfz+nKDKJLdJPfvfodCuEZr+wHsHEy+a5HiTISo=;
 b=GvYq5517EtLf6DO2m1tznTPcj7uVEjF80xgNJjruvC+EQjloHg4LwoK4Lahfp3JNPR
 EJqCN620fQau7fqV3fpkSJyuxrzI5y1tESjAjaOxoW5ZErlye70vJG0wGXhORPg07PD7
 vJxyU7Q+uulOy2ljwqZURIjswIBSJ4LzZGZzbKC6eNLHNjEdw4I12BO5XQe1d5o82wXe
 0OQUGYeyDRgeNjGR60pKKnRv7kCEDNENiFz3mWtpBTWQD+rJLY2FphVRy49eTJ+gERt6
 d5xSnUsGzaPKysld9K7WHrsa66D1AsfTD+mjlHu7RX1R5ZFJbbH9A1vYtMW4cU3Up+Oc
 3CmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPP3FUFowAOg76laZt3/CLeRefQmUSbCfrrRUl3v/WTkyCt4CyiNauvWCMkaaOX0MovBrhNjOC8JDn@nongnu.org
X-Gm-Message-State: AOJu0YxPHBY36cooeXqluL9vdzLXCvWsbhVzH3YP6Lrj7sMgTHN2p+HT
 U3IaTTS/xDln0ebvOlN9yE1TNJfqHyyWQNQphVuSilTQUBnzfytLW445BXqXCPOac+hzqCR/Eka
 Ht0KUDeLXmw/M7jcNH8BOo27EXq9huH7WHoTvja11lWjlFMmjMAaE
X-Gm-Gg: ASbGncsNSc53S1FVSKQKLuL/PQUsO3d//2voD4oUQpROwhhFirxRT2VQrIin889gML/
 ckP1oIkPTlSMCyk4M8aog+olvoxBLJNaNLw6l8t3ajm0MB6CzsF+4Kl2vbZ4mgofeUEG752eo/u
 nSfZPRujKk2CCo6EVbrtMbMApfeB2aCmj1d7azb5F9KbbHl6jxkauLwWDyYXem/CgrdgMwdZc1t
 e4OBxw5LFy6I+TRBED01hrw495eJa0LH90s66oLR7/c3xsENZiRdwBZhwyr2kPCRHW7GfA8vz3R
 lO93nE4ROQfS3TdfAIVdfLYlV1kWekGRBA==
X-Received: by 2002:a05:600c:3007:b0:439:5b36:b4e7 with SMTP id
 5b1f17b1804b1-4395b36b75bmr15718315e9.9.1739360807425; 
 Wed, 12 Feb 2025 03:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgi0nPqlLOjDK5yHHzp6rXlnu+/fA/r4tHiOcbeJHOul8Uo7B0gDGTdQaLCx7NTBfA8mv/SQ==
X-Received: by 2002:a05:600c:3007:b0:439:5b36:b4e7 with SMTP id
 5b1f17b1804b1-4395b36b75bmr15717975e9.9.1739360807007; 
 Wed, 12 Feb 2025 03:46:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a07ce08sm17337985e9.39.2025.02.12.03.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:46:46 -0800 (PST)
Message-ID: <c18f47eb-c308-4dfe-9e2f-5f33bf73010d@redhat.com>
Date: Wed, 12 Feb 2025 12:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] tests/functional: Have microblaze tests inherit
 common parent class
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-12-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250212112413.37553-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
> Have the MicroblazeMachine class being common to both
> MicroblazeBigEndianMachine and MicroblazeLittleEndianMachine
> classes. Move the xmaton and ballerina tests to the parent class.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20250206131052.30207-16-philmd@linaro.org>
> ---
>   .../functional/test_microblaze_s3adsp1800.py  | 24 +++++++++++++++
>   .../test_microblazeel_s3adsp1800.py           | 30 ++-----------------
>   2 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
> index c4226f49cf3..650416e0c09 100755
> --- a/tests/functional/test_microblaze_s3adsp1800.py
> +++ b/tests/functional/test_microblaze_s3adsp1800.py
> @@ -7,6 +7,7 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
>   
> +from qemu_test import exec_command_and_wait_for_pattern
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern
>   
> @@ -20,6 +21,11 @@ class MicroblazeMachine(QemuSystemTest):
>            'day17.tar.xz'),
>           '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
>   
> +    ASSET_IMAGE_LE = Asset(
> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
> +         'day05.tar.xz'),
> +        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> +
>       def do_ballerina_be_test(self, machine):
>           self.set_machine(machine)
>           self.archive_extract(self.ASSET_IMAGE_BE)
> @@ -34,6 +40,24 @@ def do_ballerina_be_test(self, machine):
>           # message, that's why we don't test for a later string here. This
>           # needs some investigation by a microblaze wizard one day...
>   
> +    def do_xmaton_le_test(self, machine):
> +        self.require_netdev('user')
> +        self.set_machine(machine)
> +        self.archive_extract(self.ASSET_IMAGE_LE)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
> +        tftproot = self.scratch_file('day13')
> +        self.vm.add_args('-nic', f'user,tftp={tftproot}')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
> +        wait_for_console_pattern(self, 'buildroot login:')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +        exec_command_and_wait_for_pattern(self,
> +                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
> +                '821cd3cab8efd16ad6ee5acc3642a8ea')
> +
> +class MicroblazeBigEndianMachine(MicroblazeMachine):

Add this here 'til the problem with the precaching is fixed:

     ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE

?

>       def test_microblaze_s3adsp1800_legacy_be(self):
>           self.do_ballerina_be_test('petalogix-s3adsp1800')
>   
> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
> index d50b98342d7..56645bd0bb2 100755
> --- a/tests/functional/test_microblazeel_s3adsp1800.py
> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
> @@ -7,35 +7,11 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
>   
> -from qemu_test import exec_command_and_wait_for_pattern
> -from qemu_test import QemuSystemTest, Asset
> -from qemu_test import wait_for_console_pattern
> +from qemu_test import QemuSystemTest
>   
> +from test_microblaze_s3adsp1800 import MicroblazeMachine
>   
> -class MicroblazeelMachine(QemuSystemTest):
> -
> -    timeout = 90
> -
> -    ASSET_IMAGE_LE = Asset(
> -        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
> -         'day05.tar.xz'),
> -        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> -
> -    def do_xmaton_le_test(self, machine):
> -        self.require_netdev('user')
> -        self.set_machine(machine)
> -        self.archive_extract(self.ASSET_IMAGE_LE)
> -        self.vm.set_console()
> -        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
> -        tftproot = self.scratch_file('day13')
> -        self.vm.add_args('-nic', f'user,tftp={tftproot}')
> -        self.vm.launch()
> -        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
> -        wait_for_console_pattern(self, 'buildroot login:')
> -        exec_command_and_wait_for_pattern(self, 'root', '#')
> -        exec_command_and_wait_for_pattern(self,
> -                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
> -                '821cd3cab8efd16ad6ee5acc3642a8ea')
> +class MicroblazeLittleEndianMachine(MicroblazeMachine):

And add this here:

     ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE

?

  Thomas

>       def test_microblaze_s3adsp1800_legacy_le(self):
>           self.do_xmaton_le_test('petalogix-s3adsp1800')


