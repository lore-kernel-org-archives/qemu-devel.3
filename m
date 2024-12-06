Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27921E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJY6b-0003LE-Gl; Fri, 06 Dec 2024 08:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJY6Y-0003Ks-1b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:10:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJY6S-0006uD-Ky
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733490638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fztbBt3oPPS5vS3YOfG6DvEv4wXNUE9k+QZeZz1aFoY=;
 b=aAb5L/GApW53DgiXjInQSM7GMucUIzIAvN4sdfTSNxRwcQUs2J5aghS80nkTGYMDMo5/JV
 J5I2Bjcxo+ZM+Vm1Tj9jskctbPIV2jVzKjnw/LDJmfn0lR8nNgsbu/myIiuUHhEtoSd6gq
 3zNp1ZMCmcjMYpq2EXijIBBEubm4AiQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-PPZGbN7LMbiAqkn4DdEWvA-1; Fri, 06 Dec 2024 08:10:36 -0500
X-MC-Unique: PPZGbN7LMbiAqkn4DdEWvA-1
X-Mimecast-MFC-AGG-ID: PPZGbN7LMbiAqkn4DdEWvA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-466901c5c1bso38508961cf.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733490636; x=1734095436;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fztbBt3oPPS5vS3YOfG6DvEv4wXNUE9k+QZeZz1aFoY=;
 b=EKR8kUEh3XG7rD2334WhPzGbajOWF/rdll0UAtLBsXR0H1pxdyeUUOtouZ+JYUNSXD
 han7huINVPU4dxmoRN/sC/QNaguk85XodKtDUSUZObL28t0fYfsrmlH/oEgiZ6VWkcUr
 wImAcgeV8S7u4xKw8rzLvMYBiBIneq4PvkVEQTHWmLn0CrmvLbH9+5Ie1f+MZtS0HygC
 GzNI2SVSBWaKwiSTof9FDmeD9CxL5g8Xsuh9eL3DSLxEXWhh+VE7VzkQw4SBsCsverV6
 K8aLXLv7fAIJrOFpXoAiRITFHksmppXWoPfDwythWBexfZf1kRf8Q6q82Y/ZPK7of0d+
 b8VQ==
X-Gm-Message-State: AOJu0YyT8A9G9mWEjMCnAI6UT1GHi/w2RHvbTY37mlNQvEiS9NxOKJmj
 yF9ihZccptpo9L9feZAEAAGlOTqWUuiWb/9qmOqkySBLezYTEGbV64LkD3xoXacRd6/Zh0a0Qp6
 ffh1n8If5NPwDDlLTFxq7aBk1DjYxAycQDuWfx5MVDlT8AjSqdALs
X-Gm-Gg: ASbGncsT3gac5AYW46JblSlhxryzqqs47Ck3t+YlZ8/npNAPjv6dSPeVC27dfAeOpPC
 BmmdNXUFYya8sxgg0lPDbbCqslpTbKFmhqxNL4fUWwcHGY1S92svXiHJcxFx1OKW3VprS56LqEP
 k2aP7Q1sXhoAEWSFezkmdjJF0fSsER22NEZMQatxVG/RGe/Uu7H+K3dKKT+CAs81R6c13kKb0QP
 hsIAg7n+iZKhbafsTsrlywVh6dzbOhT6xnzsSJyVqwL5pIO41WehKTKgYNFJnj+VPxfUcb6pPDt
 GZCXMg==
X-Received: by 2002:a05:622a:1496:b0:461:59d5:e5a8 with SMTP id
 d75a77b69052e-46734ce305bmr45773631cf.28.1733490636223; 
 Fri, 06 Dec 2024 05:10:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkn0F5nBULsvfHW8fPRgSieeDJYw/Ve8r4GZsk9yH0zXu9MSyM3ijbXlgblpyj9n1OUffbZg==
X-Received: by 2002:a05:622a:1496:b0:461:59d5:e5a8 with SMTP id
 d75a77b69052e-46734ce305bmr45773381cf.28.1733490635894; 
 Fri, 06 Dec 2024 05:10:35 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296a4930sm20748831cf.18.2024.12.06.05.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 05:10:35 -0800 (PST)
Message-ID: <250a1e4a-6db6-4a95-8940-141e28565197@redhat.com>
Date: Fri, 6 Dec 2024 14:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] tests/functional: add 'archive_extract' to
 QemuBaseTest
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-19-berrange@redhat.com>
 <9277a627-13d6-4d0f-9802-dec6b2606cbe@redhat.com>
 <Z02kTzobRDeEYHQR@redhat.com>
 <808c81b0-c64a-4a32-9683-c96b51145da3@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <808c81b0-c64a-4a32-9683-c96b51145da3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 02/12/2024 13.52, Thomas Huth wrote:
> On 02/12/2024 13.13, Daniel P. Berrangé wrote:
>> On Mon, Dec 02, 2024 at 11:30:28AM +0100, Thomas Huth wrote:
>>> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
>>>> This helper wrappers utils.archive_extract, forcing the use of the
>>>> scratch directory, to ensure any extracted files are cleaned at test
>>>> termination. If a specific member is requested, then the path to the
>>>> extracted file is also returned.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>    tests/functional/qemu_test/testcase.py | 36 ++++++++++++++++++++++++++
>>>>    1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/ 
>>>> qemu_test/testcase.py
>>>> index 2f32742387..31d06f0172 100644
>>>> --- a/tests/functional/qemu_test/testcase.py
>>>> +++ b/tests/functional/qemu_test/testcase.py
>>>> @@ -28,6 +28,8 @@
>>>>    from .asset import Asset
>>>>    from .cmd import run_cmd
>>>>    from .config import BUILD_DIR
>>>> +from .utils import (archive_extract as utils_archive_extract,
>>>> +                    guess_archive_format)
>>>>    class QemuBaseTest(unittest.TestCase):
>>>> @@ -39,6 +41,40 @@ class QemuBaseTest(unittest.TestCase):
>>>>        log = None
>>>>        logdir = None
>>>> +    '''
>>>> +    @params archive: filename, Asset, or file-like object to extract
>>>> +    @params sub_dir: optional sub-directory to extract into
>>>> +    @params member: optional member file to limit extraction to
>>>> +
>>>> +    Extracts @archive into the scratch directory, or a
>>>> +    directory beneath named by @sub_dir. All files are
>>>> +    extracted unless @member specifies a limit.
>>>> +
>>>> +    If @member is non-None, returns the fully qualified
>>>> +    path to @member
>>>> +    '''
>>>> +    def archive_extract(self, archive, format=None, sub_dir=None, 
>>>> member=None):
>>>> +        if type(archive) == Asset:
>>>> +            if format is None:
>>>> +                format = guess_archive_format(archive.url)
>>>> +            archive = archive.fetch()
>>>> +        elif format is None:
>>>> +            format = guess_archive_format(archive)
>>>> +
>>>> +        if member is not None:
>>>> +            if os.path.isabs(member):
>>>> +                member = os.path.relpath(member, '/')
>>>> +
>>>> +        if sub_dir is None:
>>>> +            utils_archive_extract(archive, self.scratch_file(), format, 
>>>> member)
>>>> +        else:
>>>> +            utils_archive_extract(archive, self.scratch_file(sub_dir),
>>>> +                                  format, member)
>>>> +
>>>> +        if member is not None:
>>>> +            return self.scratch_file(member)
>>>> +        return None
>>>
>>> Ah, ok, so the guessing is done here ...
>>>
>>> But somehow it feels wrong to have a "archive_extract" function in the
>>> QemuBaseTest class that also does asset fetching under the hood.
>>>
>>> Could you maybe rather move this into the asset.py file and rename the
>>> function to "fetch_and_extract()" to make it clearer what it does?
>>
>> We can't move it into asset.py because not all callers are passing in an
>> Asset object - there are some cases where we've just got a local file.
>> eg when the asset we extracted contains other archives that need to be
>> extracted.
> 
> Couldn't those spots rather use the function from utils.py directly for the 
> second extraction?
> 
> Anyway, I guess now it's likely better to keep it here since you want to 
> have access to self.scratch_file() in this function, too.

FWIW, I think I just hit another reason for having the function in 
testcase.py: We want to skip tests if the download of an asset failed with a 
temporary server failure - for this we need a test object reference for 
calling skipTest(). Checking for HTTP errors within assets.py does not work 
since we cannot call skipTest() there without a reference to a test object. 
So please keep the function in testcase.py!

  Thomas


