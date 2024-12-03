Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0477E6C61C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOcE-00079J-Cj; Tue, 03 Dec 2024 03:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIOcC-00078q-66
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIOc9-0006p8-MX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733215834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xp+wbJjrihEefSIwr5JG9sD8xmGv154ykZqibQGLRoY=;
 b=H95uGYJOnWu0Bdpw+/7Ctw5tAP0qvpvTTnVOCIRuo+f94dFS+4P8TyoYR9kqiSRRW7IByu
 VlnnPt+V2FrkCajfJM8Gbmjj5CrIidAkCa841fGp9g/VE2YtPm6lOowsIsbT3nmD/DCdPe
 K3u/EY2Wz2RuQ+FgnWsfRJx5svpBmGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-UEzbJa6NMjuyB6KA-V9cTA-1; Tue, 03 Dec 2024 03:50:33 -0500
X-MC-Unique: UEzbJa6NMjuyB6KA-V9cTA-1
X-Mimecast-MFC-AGG-ID: UEzbJa6NMjuyB6KA-V9cTA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a37a57dfso43798665e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 00:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733215832; x=1733820632;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xp+wbJjrihEefSIwr5JG9sD8xmGv154ykZqibQGLRoY=;
 b=pa9qKu4MuiQT2gPq8KS5xRIAA7R7s2wOUJoKMtPRrmM2bw5fzls8jrBCmH08zSuhlD
 Elbi2tdSppo3G300oLB18L/dIMWGe1hTxksfBsduyp9QoR9rvWtYt2u0e6CYUc+mRWAk
 gexjnddPgzrZz7XgsbIpDCr4Qx346Zr8QS7Lnj6dQa4xnxQwSl8MxeU3BRMpVJ+BE1uc
 qjtbPsfcfAfT5oZYw1e+5uo/+FUXDlToR9MIu5lB0MyE6wnJLkgNs7T4WPqGY0sD4c2i
 LrxbTNgsaj2ewcC8sTovU27oJ8tX2LHwsULiISW6r9fAHasUXlAlRi+4Pz8IxdpG1qQq
 5FFQ==
X-Gm-Message-State: AOJu0YxSVXNOw2Od7D4amMD5IuzTOdvSJGeVlsyyHnolF069YbGx4Fto
 WDxjeduClm6IJxXdwF4IBrvjGNcJST/Abtsn7BfaHUj94WH6608h2PFEYuSxYOpFxNopEuqN7Pf
 poTLgV9ZatwigAJvH2vwfzlmbdJplePt8mgpD2SxBPGJzCMvriQ1Q
X-Gm-Gg: ASbGncuVajf/XTTuOGi/nVwKfrX04HretJ8ZVTE1Mb09YttCM1sV0+aS3/U/dp0ldbJ
 Kn1L+yT+024W6GhAe6hofHs/jzZtiVnZ9gOE1gO4TN7BOBE4Ptns99WgMEPmY9JPE0mONj/yGwn
 o0o6HwSynVmtGKWH27PC4fXahiCPQOp3Al72lOIFnxIDmI+YioAQCcJDYzH3kMEnW8t2uyRK83l
 YBMSOVcTviBys3I2dFRP0nDWE/cx//ar4FiqqwbHNellDxwbGr4lL0ZHYCydw1aXgKo2KHFbiVH
 gceAlw==
X-Received: by 2002:a05:600c:35c7:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-434d09a6b0dmr14312505e9.4.1733215832406; 
 Tue, 03 Dec 2024 00:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXmJY9+SkMT96mekQdl7lXl/XUC04gJML2IymuHNo16vYhXh+TqdrWmYsea5/5wxlJG5crvA==
X-Received: by 2002:a05:600c:35c7:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-434d09a6b0dmr14312335e9.4.1733215832057; 
 Tue, 03 Dec 2024 00:50:32 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f70d9csm185481475e9.38.2024.12.03.00.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 00:50:31 -0800 (PST)
Message-ID: <d721668a-3865-4846-ac00-bba1e55d37ab@redhat.com>
Date: Tue, 3 Dec 2024 09:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] tests/functional: switch over to using
 self.data_file(...)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-12-berrange@redhat.com>
 <544db3ce-f37b-4c09-85f5-b6ad96708292@redhat.com>
 <CAK3XEhMJLQ9TE+_pGHk=bkyV6GsDbC15VTavKgWHs75j7=7Big@mail.gmail.com>
 <Z069ThRGuxIH1YVt@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z069ThRGuxIH1YVt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 03/12/2024 09.11, Daniel P. Berrangé wrote:
> On Tue, Dec 03, 2024 at 11:09:14AM +0530, Ani Sinha wrote:
>> On Mon, Dec 2, 2024 at 3:02 PM Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
>>>> This removes direct path manipulation to figure out the source dir
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>    tests/functional/test_acpi_bits.py | 22 +++++++---------------
>>>>    1 file changed, 7 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
>>>> index 4de5fae37e..948b134b16 100755
>>>> --- a/tests/functional/test_acpi_bits.py
>>>> +++ b/tests/functional/test_acpi_bits.py
>>>> @@ -41,7 +41,6 @@
>>>>    import tempfile
>>>>    import zipfile
>>>>
>>>> -from pathlib import Path
>>>>    from typing import (
>>>>        List,
>>>>        Optional,
>>>> @@ -122,7 +121,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
>>>>        def __init__(self, *args, **kwargs):
>>>>            super().__init__(*args, **kwargs)
>>>>            self._vm = None
>>>> -        self._baseDir = None
>>>>
>>>>            self._debugcon_addr = '0x403'
>>>>            self._debugcon_log = 'debugcon-log.txt'
>>>> @@ -137,26 +135,22 @@ def _print_log(self, log):
>>>>        def copy_bits_config(self):
>>>>            """ copies the bios bits config file into bits.
>>>>            """
>>>> -        config_file = 'bits-cfg.txt'
>>>> -        bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
>>>> -                                       'bits-config')
>>>> +        bits_config_file = self.data_file('acpi-bits',
>>
>> I do not understand, Where is data_file coming from? AFAICS its not
>> there in QemuBaseTest or QemuSystemTest or unittest.TestCase
>> https://docs.python.org/3/library/unittest.html#unittest.TestCase
>>
>> what am I missing or failing to see?
> 
> It is coming from patch 6 :-)

Sorry, my bad, I put Ani just on CC: for this patch here, but he was not on 
CC: on the others :-/

  Thomas


