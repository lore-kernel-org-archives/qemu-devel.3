Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA477C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfhi-0000aY-96; Sun, 18 Jan 2026 22:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vhfhc-0000Xv-0B; Sun, 18 Jan 2026 22:13:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vhfhR-0002AM-Gv; Sun, 18 Jan 2026 22:13:15 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60J3C1nH080798
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 19 Jan 2026 12:12:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=puth5B9OAwLCoI89BHyj1Yu5Zpb+rPMmdqRbS3ckdU4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768792344; v=1;
 b=bfBAmmnunlNT+OrqvL35qRQk3PIn4Q2QOAW8yYBheDNrYUaunBPiR0WM95mxBbgQ
 I0ZaFo6NthO2OP/RRH006VQchucBBP2f6Hd+h3nyFyUriAQ9ay+IUHUL6//vlP0x
 ZN/F6CFCXqPmo2SJfExdZwj47dM0OVe+YQWoo0uVBOXdjUvNfW4kpxE4JTrU5i/o
 VL7w67udGMrVKpV1SZzkxM8/5T7AkA6CHhdNrQfXnfMhLOJv67gmk29H9i9356/+
 OoEPrxEHW3cN97dBN6umZqOf6Y3kgu2cziQgXtWszwpT6rIpdzKpevYffvjgXzgb
 bBG6rRYLsU45rsO891Ashw==
Message-ID: <fbeae56f-38ab-4bad-867b-19c07ba7c08e@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 19 Jan 2026 12:12:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20260118215945.46693-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260118215945.46693-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/01/19 6:59, Philippe Mathieu-Daudé wrote:
> Since v4:
> - Addressed Akihiko's comments
>   . Do not introduce hvf_arch_cpu_synchronize_[pre/post]exec() hooks
>   . Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0 in hvf_[put/get]_registers()
> 
> Philippe Mathieu-Daudé (2):
>    target/arm/hvf: Move hvf_sysreg_[read,write]_cp() functions around
>    target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
> 
>   target/arm/hvf/hvf.c | 167 +++++++++++++++++++++++++------------------
>   1 file changed, 96 insertions(+), 71 deletions(-)
> 

For the whole series,

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

