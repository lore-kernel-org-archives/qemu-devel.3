Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C725C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 19:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUWsv-0005O4-1g; Thu, 18 Jul 2024 15:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sUWss-0005Mj-Qw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 15:33:46 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sUWsq-0001Na-VF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 15:33:46 -0400
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
 by mailout10.t-online.de (Postfix) with SMTP id F34AE37879;
 Thu, 18 Jul 2024 21:33:40 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.28.154]) by fwd73.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1sUWsk-4ar17p0; Thu, 18 Jul 2024 21:33:38 +0200
Message-ID: <ea645f54-26e4-416e-820a-7bb87db0dc23@t-online.de>
Date: Thu, 18 Jul 2024 21:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix the html docs search function
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20240717201123.9742-1-vr_qemu@t-online.de>
 <CAFEAcA_ODXCwNhdqTMBQhzNV60s=oWJfPeEARAx3XQRLbLGwPA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <CAFEAcA_ODXCwNhdqTMBQhzNV60s=oWJfPeEARAx3XQRLbLGwPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1721331218-B1FF2886-F259ACBC/0/0 CLEAN NORMAL
X-TOI-MSGID: c830ca27-2410-4a6a-93cd-99181d9ce9f0
Received-SPF: pass client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 18.07.24 um 11:17 schrieb Peter Maydell:
> On Wed, 17 Jul 2024 at 21:11, Volker Rümelin <vr_qemu@t-online.de> wrote:
>> Fix the search function in Sphinx generated html docs when built
>> with Sphinx >= 6.0.0.
>>
>> Quote from the Sphinx blog at
>> https://blog.readthedocs.com/sphinx6-upgrade
>>
>> Sphinx 6 is out and has important breaking changes
>>
>> Bundled jQuery is removed. The JavaScript asset is easily added
>> back using the new extension sphinxcontrib-jquery. It is included
>> automatically by sphinx-rtd-theme, so if you are using our theme,
>> you will also continue to have jQuery available in your
>> documentation.
> We do use the sphinx-rtd-theme, though:
>  html_theme = 'sphinx_rtd_theme'
>
> so that release note suggests we shouldn't need to manually
> pull in sphinxcontrib-jquery ?

You are right. I had a broken version of the sphinx_rtd_theme (version
1.2.0). This is a known issue and my patch is not necessary.

With best regards,
Volker

>
> thanks
> -- PMM


