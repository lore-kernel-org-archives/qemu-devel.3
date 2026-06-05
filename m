Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A86CD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 06:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVNm2-0003md-Rj; Fri, 05 Jun 2026 02:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVNm0-0003mL-My
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 02:11:16 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVNly-0007Gk-S2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 02:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780639867; bh=sG+tU3zdx1PbyYUrdWE5l9sMW2dEpg2Y7d8AwOfdQYE=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=UWGHHpogqGm/yLh/LMP0QnMBGqmG2KKCc8HPJ2cNrH8NTIhb7lJOvg26HszZ3aTHQ
 TYkBFY70u8IKFAxnetkSnFvGAan5l59UA5v4jf2C82UyH/2VRsShUSJmCHvqB4u6WN
 TIVr7a+Oo5+T5nTls/W0Dv5kKNZiSJF/606P+NsE=
Received: by be1-7.in.mailobj.net [192.168.91.17] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 08:11:07 +0200 (CEST)
X-EA-Auth: eo16WrVDQ8N9cyQoN5okh8M2PjHAOq4FvnkbAE6/fjoOiBXwhJaNsNw3GV/3k3ApOcIahGVifYDCgVZWcQXCbSWnBHmsKbIz
Message-ID: <11f4d005-ccbf-44b6-a703-dffc9317adc8@mailo.com>
Date: Fri, 5 Jun 2026 08:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests: add ubuntu 2404
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
 <20260604215148.3769627-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260604215148.3769627-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/6/26 23:51, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/ubuntu2404.docker | 172 +++++++++++++++++++++
>   tests/lcitool/refresh                      |   6 +-
>   2 files changed, 176 insertions(+), 2 deletions(-)
>   create mode 100644 tests/docker/dockerfiles/ubuntu2404.docker

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>



