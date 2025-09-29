Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2DECAC5BD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 06:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v37JJ-0006B4-K7; Mon, 29 Sep 2025 02:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37JF-0006Af-3s
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37J8-0002vp-SI
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759127047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X2EWl/rUt+7l0fd6siOmv82WVxsRMpFjG+44x0/rp8Q=;
 b=Zz7QtaeDh930X2tCzWEicDZcjcn7+kks1LzDRfNEa5nhshWfC1Jw21Wa4PgIJ0i8VkTplS
 T+lbzdNFGhSPR3nKHQE1+ldkiVkMd41RSq+qpF5uT/Z6E+jUOrYkQ2JJ2U1t1gfuUDN/U4
 vPS2Lgh7XK2D/Re5TSMVyKh6RXJ0FdA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-_uOOCzVMMHGvC_5dpEzirQ-1; Mon, 29 Sep 2025 02:24:06 -0400
X-MC-Unique: _uOOCzVMMHGvC_5dpEzirQ-1
X-Mimecast-MFC-AGG-ID: _uOOCzVMMHGvC_5dpEzirQ_1759127045
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-632c9a9ceb1so7348375a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 23:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759127045; x=1759731845;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2EWl/rUt+7l0fd6siOmv82WVxsRMpFjG+44x0/rp8Q=;
 b=EOyJpFAfLtweVt9xaLJKMjnls6A8UF363lkGhb0tOJmcPeDjHYqX8tLguzqcd3mZ+p
 CejHzg2WchWXAqgsF6M37Cd6hKzQzk3qWVtwoiP5U41p0ySplooMj62UW4E1gmSLXpZ4
 Gkd+3fh8CJMXDdWBljbAaT5+BTjiJeEzQJ/gBi8H4O1M7oCnt3uIm7JWSno5uh/2W0Bt
 jm5M083ScTJl3mHiUGn1gkWumuqvga6oUGAvxBC0w0YwwsCdXqnEA/QgEdao6bXXYENe
 C4yvv5fw0pFQX7U/luKJ5EXOsKoByqXA6XPOcFOnquY2GVJQefGvknNbh1PmCqctiu12
 ooiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFcxHP0xts4mJhqQhIZhijPL5jZKn4OCxg8fjLgIe6h3HdsNmeIE7ZHl/ET52GVFBKj/aEIJDaci7t@nongnu.org
X-Gm-Message-State: AOJu0Yy4Kt+9x2AWC976+QP2ky1U4IFw3oE8P4/2N734tlwl+u3N/bzV
 rClRYGp7O3TZguPl3ZtcZFNtWEoye23Lm2XPfpaefcPyi4qCxtk718O3cdmch0kqph2pChmnK8C
 HWQJkDbWYh3xNFDFVVqZtemW28fkydhwp4tf3DKtNaSsnQDf8L7WtwAP2
X-Gm-Gg: ASbGncuX73SQi21i8eVAW6uicqhmlzZsHNEKxTNb9aMbAMorfEIXgYj0+aYPIN6lHJ2
 jPy9Rcw58LGtSbCRN+/mbtQzM4BPQQ98vDMVbVZArtKnwAUOMNVB8Mc5JB2ufKGk5SvzBitTmbN
 4+yjs7dwjJm/VxN+Z1Y2ITJG0nOmhKB2aiW7mkRyx09OdjIGuHA478SQnd7b+o6ONjXhfpi+JEb
 BxoxmBBRnBBPUMFu+l+sXxhdOUKN6jzPxrDcoZGvCeY63bmUHqil5bmmitRgXvVZWF8rZeyt/nh
 BrLME7/vKY3PgQIKo6b1YiMWsTAvEgSAx6fpNI15UWhjXchRxUyzC34C7PKmkLll2unx/YTmgoc
 9nR9OPw==
X-Received: by 2002:a17:907:6d0f:b0:b0d:9d6a:fe14 with SMTP id
 a640c23a62f3a-b34b7ccdd35mr1845225466b.26.1759127044901; 
 Sun, 28 Sep 2025 23:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIl2WzPG/X4/WxY9tG4230Lb6nLbR7ehWriLrDjh1/FxBDPPHUVvyioQcpKlNe4stHCzrGdA==
X-Received: by 2002:a17:907:6d0f:b0:b0d:9d6a:fe14 with SMTP id
 a640c23a62f3a-b34b7ccdd35mr1845223866b.26.1759127044502; 
 Sun, 28 Sep 2025 23:24:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3544fd0a9esm879426966b.84.2025.09.28.23.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 23:24:03 -0700 (PDT)
Message-ID: <b57e8c52-1241-4d34-b2c9-d5a67e762a2a@redhat.com>
Date: Mon, 29 Sep 2025 08:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-9-gustavo.romero@linaro.org>
 <ec28971b-fe8c-4a6a-b241-10ff1468c991@redhat.com>
 <4266bc6b-44ad-4318-99ac-71d94d02fae9@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4266bc6b-44ad-4318-99ac-71d94d02fae9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 26/09/2025 18.00, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 9/26/25 05:44, Thomas Huth wrote:
>> On 26/09/2025 07.15, Gustavo Romero wrote:
>>> This commit removes Avocado as a dependency for running the
>>> reverse_debugging test.
>>>
>>> The main benefit, beyond eliminating an extra dependency, is that there
>>> is no longer any need to handle GDB packets manually. This removes the
>>> need for ad-hoc functions dealing with endianness and arch-specific
>>> register numbers, making the test easier to read. The timeout variable
>>> is also removed, since Meson now manages timeouts automatically.
>>>
>>> reverse_debugging now uses the pygdbmi module to interact with GDB, if
>>> it's available in the test environment, otherwise the test is skipped.
>>> GDB is detect via the QEMU_TEST_GDB env. variable.
>>>
>>> This commit also significantly improves the output for the test and
>>> now prints all the GDB commands used in sequence. It also adds
>>> some clarifications to existing comments, for example, clarifying that
>>> once the replay-break is reached, a SIGINT is captured in GDB.
>>>
>>> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
>>> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
>>> before running 'make check-functional' or 'meson test [...]'.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>> ...
>>> @@ -53,49 +55,11 @@ def run_vm(self, record, shift, args, replay_path, 
>>> image_path, port):
>>>           vm.launch()
>>>           return vm
>>> -    @staticmethod
>>> -    def get_reg_le(g, reg):
>>> -        res = g.cmd(b'p%x' % reg)
>>> -        num = 0
>>> -        for i in range(len(res))[-2::-2]:
>>> -            num = 0x100 * num + int(res[i:i + 2], 16)
>>> -        return num
>>> -
>>> -    @staticmethod
>>> -    def get_reg_be(g, reg):
>>> -        res = g.cmd(b'p%x' % reg)
>>> -        return int(res, 16)
>>> -
>>> -    def get_reg(self, g, reg):
>>> -        # value may be encoded in BE or LE order
>>> -        if self.endian_is_le:
>>> -            return self.get_reg_le(g, reg)
>>> -        else:
>>> -            return self.get_reg_be(g, reg)
>>> -
>>> -    def get_pc(self, g):
>>> -        return self.get_reg(g, self.REG_PC)
>>> -
>>> -    def check_pc(self, g, addr):
>>> -        pc = self.get_pc(g)
>>> -        if pc != addr:
>>> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
>>
>> I think it would make sense to keep wrapper functions get_pc() and 
>> check_pc(), since that functionality is still used in a bunch of places 
>> (e.g. "gdb.cli("print $pc").get_addr()" is used a couple of times).
> 
> Yeah, I considered that, but I really think that using the
> wrapper functions doesn't add to this test (as in the original test).
> First because I like reading the test code and easily map it to
> its output and, second, the original test that used check_pc() was
> actually failing with this "Invalid PC ... " message in all the cases,
> which is not informative. In my version, because I check PC in place,
> I also fail with a specific message for each case, like "Forward stepping 
> failed¨,
> "Reverse stepping failed", "reverse-continue", etc.
> 
> If you don't mind I'd like to keep the test this way.

Ok, fair point. But you could at least consider keep the wrapper for 
get_pc(), I think.

>>> +    @skipIfMissingEnv("QEMU_TEST_GDB")
>>
>> Somehow this SKIP is always triggered on my system, even if I correctly 
>> pointed "configure" to the right GDB with the "--gdb" option ... not sure 
>> why this happens, but I'll try to find out...

It was the additional logic in patch 3 (see my other mail) that caused the 
gdb detection to fail and thus the environment variable was not set.

  Thomas


