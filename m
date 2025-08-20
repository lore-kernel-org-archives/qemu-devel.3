Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33033CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoepw-00081M-S5; Wed, 20 Aug 2025 05:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoepV-0007qU-0v
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:10:05 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoepS-0007CN-Vt
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:10:00 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 12EBC8843F;
 Wed, 20 Aug 2025 12:09:55 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id r9ONC10oKiE0-bMJxOOk0; Wed, 20 Aug 2025 12:09:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755680994;
 bh=akug96SiicfEQeYXseXutjaGaBNQtIwQeOPt71fs1rA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MXW7shyoza3iHwLuPQHpVFV5P+UTwVCG2M6vMEtdTP8ex6U3A30qamK97GMw9Q7Po
 sHz9IdcTp3xkpNFNKXWCGGxiwZeTxxIbDEG2jmPDiD87e3zSyh7+L32Ahj8jI/35R3
 Ip2H4uQfQ9EToTrtGfmsnSMbfK9Sh2rwT/hFDpDQ=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <27cd42d8-fe41-4263-aafa-d2ff11ce94da@yandex-team.ru>
Date: Wed, 20 Aug 2025 12:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] net/tap: net_init_tap_one(): add return value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jasowang@redhat.com
Cc: qemu-devel@nongnu.org
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <20250818140645.27904-2-vsementsov@yandex-team.ru>
 <bf4a3994-1cb7-4c00-9f01-e114acf559ca@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <bf4a3994-1cb7-4c00-9f01-e114acf559ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 20.08.25 09:30, Philippe Mathieu-Daudé wrote:
> Hi Vladimir,
> 
> On 18/8/25 16:06, Vladimir Sementsov-Ogievskiy wrote:
>> To avoid error propagation, let's follow common recommendation to
>> use return value together with errp.
> 
> (looking at commit e3fe3988d78 "error: Document Error API usage rules"
> again). While not return a boolean?

I thought about it, but decided to keep the common style of the file, all
functions here tend to return -1 on error and 0 on success. And making
1-2 exclusions will not make things more readable.

I think, if go this way, it should be another commit to convert the whole file
to use boolean functions where appropriate.

-- 
Best regards,
Vladimir

