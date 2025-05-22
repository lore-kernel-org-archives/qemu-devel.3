Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C41C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyKt-0003aO-Dz; Thu, 22 May 2025 01:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHyKr-0003aB-SY
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHyKp-0000kt-NK
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747891154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4movF3wEDTm5lWIIdT94CuqC7JJacBtjFNZ+zoK3u10=;
 b=E6BexEJmFXGPSxuVFvIVSxecAihoLFWWMaPtmJagivr6+A97/yCfqD396hjBefVuZRTenh
 uVdCFXNiTDvKzNgwdRXX61ufdcD8Gt/PO6aLjJa+Q4SEr2oES0iaY5qByz337fjZSLXmIC
 1a/1C3OgHG+kgd7jPxgmXe7VQI091c4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-5ugOyIcOPDeAPorfOKXbaA-1; Thu, 22 May 2025 01:19:12 -0400
X-MC-Unique: 5ugOyIcOPDeAPorfOKXbaA-1
X-Mimecast-MFC-AGG-ID: 5ugOyIcOPDeAPorfOKXbaA_1747891151
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5ffe81b2ec9so8211944a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747891151; x=1748495951;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4movF3wEDTm5lWIIdT94CuqC7JJacBtjFNZ+zoK3u10=;
 b=ee39L5LcxzRZpfIzMg3N79p3NERayuRIuyq3aoH1/Bi1J5wDhSFrT7+H/Vk82u5GKH
 jLV3f1hvUcADd/h1yuqdF3PgsssGBtGsRdfc2y7W2NS7wN7fVlTMTZHKigeKi39fod0w
 1bMjTp7C4AW66INdTCA02qh24yh4hwsNNbMs786uCwsghFw/zslR2y2QPlb+GuyA0NPc
 UwaN28AKYY+/AB01VeR9C80FeuB3uzxqrhcswT9P5gOf+Nao8TqrAoOKY50epqhpCBQ/
 yamAe/LnCC/s1anwUNEnW/UiDLeY0gzS9ocw1me+0SZPIeuQ4wv/foGxCgXAFPdoj+1m
 c3Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9m/Jue9puKc9lrj9CZzgh0rOnzvo+3scjtbDE11/fBJPR25fuE278eSnriAjIyMr6chk0fvLSlL+C@nongnu.org
X-Gm-Message-State: AOJu0Ywg1RPpQ6ZRaNrI24AfphejXo58bK8b7kcR93knU1QP1REj+wYb
 XAUep/OynyIE/ORdjWh9OBMdf4ycIETnANvxI/FQ+AK9Pi0j9sjNnrOtzBtZwDnNuEzhzL5pgRZ
 lIMqGTVRI6SXnUFlbA/u9cdNTa+hD8qZpFVcJ9FVktJR5EzG23tB/c8kN
X-Gm-Gg: ASbGncuNl3VXmC1d1lWNY/OtahWDf/vV4j+T07jPguFKTBqFM/q4OFLu8Zfo/XHL9Og
 OANTzSxHLugajcndhCXGP84+ayPevHfiovPUdIKcc2IPj5TTUk9Ld7FLoRfBq8kra832kxYqM+P
 LVfRpOzXzJGGjiafZ/0MxrvmGHyLFZHcP4//iyKc5329CDkvpICrge+ftvEacZQ1kEB7Kpc2TEK
 1c1bIfrzD0c3yBPkO/O8H9bhNmIwLit7PDh9om7lMz2XC+o8ggIkP7tpfw0PtszQA2Pi3j8jvmF
 lDY+ijpUJ+g3gmujJdJh3wtUArYuLOGfU9d6yMBxNbk=
X-Received: by 2002:a05:6402:2692:b0:601:f610:5dcd with SMTP id
 4fb4d7f45d1cf-601f6105e4fmr10761269a12.23.1747891150946; 
 Wed, 21 May 2025 22:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSV4aPgvLMW8mTEPKLiQe1J+wPBpNhE6r8WFrZiQK2M/siMjdTNrim7lIPT+xH1XHqqKs/Lg==
X-Received: by 2002:a05:6402:2692:b0:601:f610:5dcd with SMTP id
 4fb4d7f45d1cf-601f6105e4fmr10761253a12.23.1747891150494; 
 Wed, 21 May 2025 22:19:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6024e8fd0absm1010398a12.57.2025.05.21.22.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:19:10 -0700 (PDT)
Message-ID: <2ed1e3eb-14d9-4869-80b1-6d93c20b84ca@redhat.com>
Date: Thu, 22 May 2025 07:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] tests/functional: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
 <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/05/2025 15.55, Alexandr Moshkov wrote:
> Add new tests to check the correctness of the `-overcommit memlock`
> option (possible values: off, on, on-fault) by using
> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
> anonymous segments:
> 
> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
> * if `memlock=on`, then Size, Rss and Locked values must be equal for
> every anon smaps where Rss is not 0;
> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
> smaps and anonymous segment with Rss < Size must exists.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   tests/functional/meson.build     |   1 +
>   tests/functional/test_memlock.py | 107 +++++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+)
>   create mode 100755 tests/functional/test_memlock.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0f8be30fe2..339af7835f 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -61,6 +61,7 @@ tests_generic_system = [
>     'empty_cpu_model',
>     'info_usernet',
>     'version',
> +  'memlock',
>   ]
>   
>   tests_generic_linuxuser = [
> diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
> new file mode 100755
> index 0000000000..a090e7f9ad
> --- /dev/null
> +++ b/tests/functional/test_memlock.py
> @@ -0,0 +1,107 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that check overcommit memlock options
> +#
> +# Copyright (c) Yandex Technologies LLC, 2025
> +#
> +# Author:
> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> +#
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import re
> +
> +from typing import List, Dict
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import skipLockedMemoryTest
> +
> +
> +SMAPS_HEADER_PATTERN = re.compile(r'^\w+-\w+', re.MULTILINE)
> +SMAPS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
> +
> +
> +@skipLockedMemoryTest(2_097_152)  # 2GB
> +class MemlockTest(QemuSystemTest):
> +    """
> +    Boots a Linux system with memlock options.
> +    Then verify, that this options is working correctly
> +    by checking the smaps of the QEMU proccess.
> +    """
> +
> +    def common_vm_setup_with_memlock(self, memlock):
> +        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
> +        self.vm.launch()
> +
> +    def get_anon_smaps_by_pid(self, pid):
> +        smaps_raw = self._get_raw_smaps_by_pid(pid)
> +        return self._parse_anonymous_smaps(smaps_raw)
> +
> +    def test_memlock_off(self):
> +        self.common_vm_setup_with_memlock('off')
> +
> +        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
> +
> +        # locked = 0 on every smap
> +        for smap in anon_smaps:
> +            self.assertEqual(smap['Locked'], 0)
> +
> +    def test_memlock_on(self):
> +        self.common_vm_setup_with_memlock('on')
> +
> +        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
> +
> +        # size = rss = locked on every smap where rss not 0
> +        for smap in anon_smaps:
> +            if smap['Rss'] == 0:
> +                continue
> +            self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
> +
> +    def test_memlock_onfault(self):
> +        self.common_vm_setup_with_memlock('on-fault')
> +
> +        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
> +
> +        # rss = locked on every smap and segment with rss < size exists
> +        exists = False
> +        for smap in anon_smaps:
> +            self.assertTrue(smap['Rss'] == smap['Locked'])
> +            if smap['Rss'] < smap['Size']:
> +                exists = True
> +        self.assertTrue(exists)
> +
> +    def _parse_anonymous_smaps(self, smaps_raw: str) -> List[Dict[str, int]]:
> +        result_segments = []
> +        current_segment = {}
> +        is_anonymous = False
> +
> +        for line in smaps_raw.split('\n'):
> +            if SMAPS_HEADER_PATTERN.match(line):
> +                if current_segment and is_anonymous:
> +                    result_segments.append(current_segment)
> +                current_segment = {}
> +                # anonymous segment header looks like this:
> +                # 7f3b8d3f0000-7f3b8d3f3000 rw-s 00000000 00:0f 1052
> +                # and non anonymous header looks like this:
> +                # 7f3b8d3f0000-7f3b8d3f3000 rw-s 00000000 00:0f 1052   [stack]
> +                is_anonymous = len(line.split()) == 5
> +            elif m := SMAPS_VALUE_PATTERN.match(line):
> +                current_segment[m.group(1)] = int(m.group(2))
> +
> +        if current_segment and is_anonymous:
> +            result_segments.append(current_segment)
> +
> +        return result_segments
> +
> +    def _get_raw_smaps_by_pid(self, pid: int) -> str:
> +        try:
> +            with open(f'/proc/{pid}/smaps', 'r') as f:
> +                return f.read()
> +        except IOError:

FWIW, I think it should rather be FileNotFoundError in modern Python, but 
IOError still seems to work, too.

> +            self.skipTest("Can't open smaps file of the process")
> +
> +
> +if __name__ == '__main__':
> +    MemlockTest.main()

Thanks, I'll queue the patch for my next pull request with functional patches.

  Thomas


