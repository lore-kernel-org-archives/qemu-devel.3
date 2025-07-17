Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160B3C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucKGf-0007Iq-Dy; Thu, 17 Jul 2025 04:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ucKGb-0007B8-QO
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ucKGV-0003zs-HM
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752742012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wrcBbo23Ev5G6ybN0tXe7LMqDELdj3G9EwS7qwfW+h0=;
 b=Hu2eQ+WHv0H1PYi7HHmWLhTnJwi0C8IMV555GkQ0iHfLKBHrSPuMZP/iHHmvtYwrH3x7rm
 YPqSGAvxbAv51DTS87BcfXofejroyXGKamtjjo41wKCDYWwKhdAEUe/ios8lbYvJXRHvFB
 2Q0FC93G3/HcM4kjLC3CjAtJQWq6kp8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-HtxPnVuKOautHIb4C8HOIA-1; Thu, 17 Jul 2025 04:46:50 -0400
X-MC-Unique: HtxPnVuKOautHIb4C8HOIA-1
X-Mimecast-MFC-AGG-ID: HtxPnVuKOautHIb4C8HOIA_1752742010
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b39cc43f15so332285f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752742009; x=1753346809;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrcBbo23Ev5G6ybN0tXe7LMqDELdj3G9EwS7qwfW+h0=;
 b=KnmugZR/9v8mcIdv5Y/2eO/t0pz9v6MIAXrzVnP7nfl3ZwKjIcNEPv9HfDuFU/scPE
 Ul6obTlPPObW/IDwg2QrL0sLPxF4quyJ17+jw10wvdIIXjiQvbvXTH6LlkR4dcZ4f+Et
 4Cl7Snb/Z6coe3sVA/9BpAURjL2RA8Mb2KbiJ6gKKFzX9z3Fj4J2AbuR57BfIXc51WaZ
 fESzc1gD4Wkl6e+g54iMJhRGhkshl6on1TMVNNPlVurjNEVXm3ig6Dwi8Mf8ClqWjsNT
 1P0Dqb4ynWMe4MO0IsnBqC1Hn2XS/3CRAoZ0hyvpeRoGHmL7gPydXxRggukHltAKr/38
 FZrg==
X-Gm-Message-State: AOJu0YzQxlbUVGA3yAm3RhHJseVnWApF+tCTxxKV7gT5MhwjfncrnsX1
 mr2nP3z3Myg1wQwFV2RsL0cwVcXVEg3vkeW2DIrEc3xDpg1iEtPBuk2JlA09V3tUuS11Vrd1gJB
 5ouB4HpGY8dyM01yj/1iG/7Jks37mPw9Bwf9L2tv0zzJNsjD2eDfTgEmI
X-Gm-Gg: ASbGnct3mAyMVLCP8cmpmzRp7KZGVg7He7ucqoN7zo3gQvl2Bp8GGD6rtLQhLVoOa/n
 dyYcyDD7i1/+zHCdbQMzKa7ivAVJrCksC3LbErHu1U/qN9rPolqDQRgZCPrAotebR+KLYTD4jEM
 b/XY3bdy59EqKa/9hbVXEGlxBEnOp/sAAUZbgd2I22zHuqaFsKDOvGfry0Vs3VC3qzCCwCNXsXE
 gA5ftZ2DC08SfYfe780D1fox6IXv5LBx93xumHMhjMp3XiV6Pxv8FpyOYNlqtm6Vte5yrBiRZJl
 RGeMbVb6Jz6lrw2T2U0vqSmz5O04n+aJvidvLiHRl5ENW6dUZt5JJqYqgQXDmg6csoTOAhnWVRw
 YkDU=
X-Received: by 2002:a05:6000:2084:b0:3b2:e07f:757 with SMTP id
 ffacd0b85a97d-3b60e4be9a5mr4907022f8f.1.1752742009332; 
 Thu, 17 Jul 2025 01:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBjllyIlSrimI86v4FcZdjQar/0n3MIeI+nvGjsUtFV8e/qdiqIMLzvMuW1pAPys6zEYiZgA==
X-Received: by 2002:a05:6000:2084:b0:3b2:e07f:757 with SMTP id
 ffacd0b85a97d-3b60e4be9a5mr4906994f8f.1.1752742008915; 
 Thu, 17 Jul 2025 01:46:48 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-097.pools.arcor-ip.net.
 [47.64.114.97]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f4c34dsm15612675e9.6.2025.07.17.01.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 01:46:48 -0700 (PDT)
Message-ID: <7924aab8-2d89-4b69-be5d-40ffb0c839a5@redhat.com>
Date: Thu, 17 Jul 2025 10:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87ms93xl69.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/07/2025 10.42, Alex Bennée wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> 
>> Add argument parsing to functional tests to improve developer experience
>> when running individual tests. All logs are printed to stdout
>> interspersed with TAP output.
>>
>>    ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>>    usage: test_aarch64_virt [-h] [-d]
> 
> Am I holding it wrong?
> 
>    ➜  ./pyvenv/bin/python ../../tests/functional/test_aarch64_virt.py --help
>    Traceback (most recent call last):
>      File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/test_aarch64_virt.py", line 16, in <module>
>        from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.py", line 14, in <module>
>        from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 26, in <module>
>        from qemu.machine import QEMUMachine
>    ModuleNotFoundError: No module named 'qemu'
> 
> I thought the point of the venv is we had all the modules we need
> automatically available to the PYTHONPATH?

The "qemu" module is special since we ship it in our repository. See the 
"PYTHONPATH" description in docs/devel/testing/functional.rst.

  Thomas


