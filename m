Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD190C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR5zv-0006rC-LM; Mon, 16 Jun 2025 05:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uR5zi-0006lL-Bs
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:19:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uR5ze-0004KF-4i
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:19:10 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55G9IxMV091183
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 16 Jun 2025 18:18:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ecKadnOOTQorV0wy714Q6CeVUBRfNk3XvAjnKAXS/Xw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1750065539; v=1;
 b=h/VqPmz/jJnJRbqjNe1IVpXZwxXh7AS3SE8l38LCMkDICr4JWPuGDkJSIk1hR5wS
 ZPWFJP6h3w8mOZ/MfUH/yv+R7UMrnlz45Y6Mil4tecKNL2L8bCOlCLluoRm94/00
 I1dkxErnNYhWIl2YhfM3xBLzrdJH3HfGpzEgQzxUBSJc6JjqSKKOQx3dbDr8LwDL
 jArVaNwOgzTiAA6ZSf9S2XeoTTc8mOAIxuVVTu/RXVp3nPm8hbIEoe8h3OYCNq1m
 cS7w9PWKQ7RPtoKdLYXZEJnm4yswGMePnQ3pXGCnRnmX4u4U4sTn02PMak0ccKfQ
 WhfV4Rd3sLEcJbfRm17e9g==
Message-ID: <af738046-a2d8-4c4b-896d-e4a1db6f1d1d@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 16 Jun 2025 18:18:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] contrib: replace FSF postal address with licenses
 URL
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.10@sean.taipei>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250613.qemu.patch.10@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/06/14 1:53, Sean Wei wrote:
> The LGPLv2.1 boiler-plate in pdb.c file still contained
> the obsolete "51 Franklin Street" postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

