Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF42CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZRfn-0007MW-FE; Tue, 16 Jun 2026 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wZRfm-0007M0-89
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:09:38 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wZRfk-0003PG-Db
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:09:37 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 4DDA2240104
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 13:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
 t=1781608171; bh=+8YYeIGf/QAqc4lndQigHLMIsRj9NTVzRKK98f288tU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=Ucau4jC2cTNRVN/0C34451IHFFVxpjC0PxzmtE9KR76GnDdaJK8CrR5THEwIxOz57
 8PU8RQRlroz/FVFeSsNm6n0Oo5ev9tDnEiU+CYSgtq0UrTBbeGkc0uhxeonTjvHz91
 WDbKW9E8bPh6xaCysCu8AfBiMeOum3aZ/tUaGSr0Of28SNp1v1IX6rS4QGPx4W+FY/
 3ZyjVr2F6rhvm99LDSks1bm4IwDx7K3+t1HxEyuqK+Pbf80MkQ2xkpGcH9BJIHtYvD
 bOJ5yWLhjB6+WdQca1XW9WiaWQesTNfvV6CJvai1IiZLLsqq0pLcH6IJ9TwmYYxCE9
 8rtS2IcC0QNGA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gfklY6w9Wz6trs;
 Tue, 16 Jun 2026 13:09:29 +0200 (CEST)
Message-ID: <7e6fec6b-be34-4fcf-bdcf-f94ba26b691b@posteo.de>
Date: Tue, 16 Jun 2026 11:09:31 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] testing: some minor QoL changes for functional tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
From: Thomas Huth <th.huth@posteo.de>
Content-Language: en-US
In-Reply-To: <20260614100902.885698-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.de;
 helo=mout02.posteo.de
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

On 14/06/2026 12.08, Alex Bennée wrote:
> I spend a lot of time trying to recreate functional test failures on
> the command line where I can add gdbstub or run under rr. Invariably
> this involves running the test with "env QEMU_TEST_KEEP_SCRATCH=1" and
> then extracting the command line and tweaking it.
> 
> I finally got annoyed enough to look at the command line code and see
> if I could do this a better way. Ideally I could just do something
> like:
> 
>    ./pyvenv/bin/meson test --suite thorough func-arm-aspeed_anacapa --cmdline
> 
> but for now I'll stick with copy and pasting a line from the logs and
> saving a few seconds removing all the QMP and console sockets.
> 
> I've also included the pylint change which is now reviewed and can be
> picked up. If not I'll grab it next time I do a testing/next sweep.

Series
Reviewed-by: Thomas Huth <thuth@redhat.com>

Feel free to pick it up through your testing tree, I don't have much other 
things currently pending that would justify a pull request from my side 
right now.

  Thanks,
   Thomas


