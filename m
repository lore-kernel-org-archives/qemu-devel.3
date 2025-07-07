Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F316CC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 04:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYdEj-0005KD-FB; Mon, 07 Jul 2025 00:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uYdEI-0005DB-SG
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 00:13:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uYdEF-00076c-IA
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 00:13:22 -0400
Received: from [10.160.60.105] (p7852202-ipoefx.ipoe.ocn.ne.jp
 [123.225.53.201]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5674D4B8050148
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 7 Jul 2025 13:13:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JsRiF/xE/0jATtkZ5lqnBHE2Xt9UvVx8/jteJQ5Wr3g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1751861585; v=1;
 b=fMKlRw5HIz8xHAUu1lBUgN4v5LXpITQ2TCGQKGade/1+DgSekomSiD/Gfxr2RYjw
 BJIaRGgaFbQ5GTsDBFRP9Fdi5PNCK/gGaYG310OUMLhL5bQka0SON7+2SJa0Ljg1
 YW9AYFrYEZoWv8gWasKfoLcRN3geKxO1YYdpAzqWwvYhyfj3Cv9SyUbiGtt6kJ4r
 aomKKXlvJTUwvpP8JDNu0Iw9Hh/m01LrGUjhsK2m/Zd3cchSMY9mcOnDwWQCg1o8
 0Wl2WUf0sy4rNqX5Uynq/+XmErrM7b363s27/arURf/wI85K6MGbvXlY9TdW0AX/
 TJQqFDJsBVSJ9eUPfkyL4w==
Message-ID: <025885e2-4126-4da7-9590-ef90a8241064@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 7 Jul 2025 13:13:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: about 0x602 in e1000.c
To: Liu Jaloo <liu.jaloo@gmail.com>, qemu-devel@nongnu.org
Cc: dmitry.fleytman@gmail.com
References: <CAOYM0N1ffwdV1CDCrt_=ZcuQRnNbZ4ZNC3CS9VoxF=Yz4yMdUg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAOYM0N1ffwdV1CDCrt_=ZcuQRnNbZ4ZNC3CS9VoxF=Yz4yMdUg@mail.gmail.com>
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

On 2025/07/01 20:30, Liu Jaloo wrote:
> in the source code "hw/net/e1000.c"
> 
> [LEDCTL]  = 0x602,
> 
> maybe should be:
> [LEDCTL] = 0x07068302,
> 
> according to the "*Table 13-60. LED Control Bit Description*" of the doc:
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe- 
> controllers-software-dev-manual.pdf <https://www.intel.com/content/dam/ 
> doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf>
> 
> 0x602 is EEPROM default value, just for LED0 and LED2, according to the 
> same doc:
> *Table 5-15. LED Configuration Defaults*

I think you are right. Can you submit a patch to fix it?

Regards,
Akihiko Odaki

