Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A53CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMf3z-0001N6-BW; Tue, 12 May 2026 00:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wMf3x-0001MB-UB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:49:45 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wMf3v-00019r-Og
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:49:45 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 4141D240027
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 06:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
 t=1778561378; bh=7sHyeKN0qoXREnXZbdLAnWjoOzDEmrhpv4+SesI7SBQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=h1dkJO+YfIMMjlkYtABlvLOo5bhlM/Nc8P+kzzwDyV5fApaijhymq5jRzoL6sjsMB
 SQyIvxrWiBgzM5nM6UNdKwbMxzAwklh1m20tEYv6Ms81kWGXzoB82QBKkLMOZrABCx
 gfQG8S4f7hEKJcBD3EuvlU1SH1706wuAZHlPkKzwMnKCNSPypnxZb1LF+jZVD0bUam
 qzeLG2BIbth266cAlGhmYm6J5Mn64lZC+qwATtIyELyeKEZrigBXOkaknp6BPxah3h
 nE3RUA+94DavNgQ5oVxFcYG88Aqzuxgu7s5uhTuZaVXLO0X8tEWTFOVy3f7MJW7Ouz
 PxgzNFIn2R8xg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gF3zP0YJXz9rxB;
 Tue, 12 May 2026 06:49:36 +0200 (CEST)
Message-ID: <7efaba42-5471-4b75-94ab-450aa1299a22@posteo.de>
Date: Tue, 12 May 2026 04:49:38 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260501115506.3792110-1-peter.maydell@linaro.org>
 <CAFEAcA8QA32mcVOU+iB7Go40h_RwEtYKyZcOQT4nv1nEY92v+w@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <th.huth@posteo.de>
In-Reply-To: <CAFEAcA8QA32mcVOU+iB7Go40h_RwEtYKyZcOQT4nv1nEY92v+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/05/2026 16.47, Peter Maydell wrote:
> On Fri, 1 May 2026 at 12:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> The Python os.setxattr() API is Linux-specific, so trying to use
>> it on other OSes triggers a failure:
>>
>>    File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
>> line 227, in fetch
>>      os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
>>      ^^^^^^^^^^^
>> AttributeError: module 'os' has no attribute 'setxattr'
>>
>> Since we only set the attributes here for informational
>> purposes, skip them when os.setxattr() isn't available.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Is anybody going to pick this up via their tree, or should
> I just put it into target-arm.next ?

I currently don't have any other patches in my queue, so it would be great 
if Daniel or you could take it.

  Thanks,
   Thomas


