Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEE6CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73zN-0006uo-Tv; Thu, 09 Oct 2025 23:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v73zH-0006rj-Ko; Thu, 09 Oct 2025 23:40:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v73z5-0004jY-KW; Thu, 09 Oct 2025 23:40:10 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59A3dW06082485
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 12:39:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5xWLhTlqoKELDWsGn6MbHGLwpxizdd+e7qoTjDZhRog=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760067573; v=1;
 b=MF0OuiAnmVtS2kXbqTGuC3FHC/jMfYiLQlEO5mU1jQS19Z8uGpOPZ8CJ22lUe09g
 CF2b2ySXedoEc81MNsgsHlH2lTUJZ/F+3G5/NG7hzE4p3TaeUZd/qCqpKp4M84vI
 1Tkue9v5Yck47/ZJEnkiqSX6UQitwF/cGm4xUtqKcUhSde2f/zS+z8QfiNCsgZ26
 jS0Li6v5n2YH36YPwb7WKsRvYJUDY97OayROfYXdfoE11njdI7pfR98/MAC2O/cZ
 fhfg9NhsPB3JXTlSZBnVZOd6ZZPDhxoWPNPg9YOngMQKo5qPzAxya3dSC71Hn/bl
 1naHjDRc3s1owbqspULWcA==
Message-ID: <f5542e18-0046-45bb-aba0-8b718ed278b9@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 12:39:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, viktor.prutyanov@phystech.edu, hreitz@redhat.com,
 kwolf@redhat.com, maochenxi@bosc.ac.cn, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20251009141026.4042021-1-rjones@redhat.com>
 <20251009141026.4042021-2-rjones@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251009141026.4042021-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/09 23:08, Richard W.M. Jones wrote:
> curl_easy_setopt takes a variable argument that depends on what
> CURLOPT you are setting.  Some require a long constant.  Passing a
> plain int constant is potentially wrong on some platforms.
> 
> With warnings enabled, multiple warnings like this were printed:
> 
> ../block/curl.c: In function ‘curl_init_state’:
> ../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
>        |             ^
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

