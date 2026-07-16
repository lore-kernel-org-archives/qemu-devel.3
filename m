Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F23C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkI1p-0003bM-QK; Thu, 16 Jul 2026 05:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wkI1l-0003aN-DR
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:05:10 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wkI1h-0003zB-Gw
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1784192691;
 bh=a7S+tWL15EUUj3HAbbb1I5NmGFxzUzH/GGf5qT1farM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sjd5IHpaT3hSKZRq1/jWnWnf66PXJpzpmuc/p0pVdQUvI5SyaqNGppwzypAycHdzz
 +/A/+UP35FIyGoojPt/91176yXSRmwKJG2bQuUkkc9HYqWVEK+swFYdfiUGOTPjmab
 AWZK5d8859tjUaxGoS9umKUGKXs806jCtMw10ikgji7jtdJWwdWMfWEH33kqw0U8xM
 DdTtk60hIk4jSkV9QY6lgqk8NTItXOl/2xLUPOAdvrYiAI9iUS7HJqvz8tKtBQG943
 i+DMoV3OA+XVXRLTB3TuKI8rJSYZg9XVmUDpnOtZVd4r46QYQJxdv9+LOTZByn96ce
 bOj13azmOSEeg==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 946652FF367;
 Thu, 16 Jul 2026 09:04:51 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6E06237C8CA;
 Thu, 16 Jul 2026 17:04:20 +0800 (CST)
Message-ID: <870c0e63-47b1-413e-b6bb-e70e2eb10c56@sjtu.edu.cn>
Date: Thu, 16 Jul 2026 17:04:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260710212601.583352-1-functioner@sjtu.edu.cn>
 <20260710212601.583352-3-functioner@sjtu.edu.cn>
 <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
 <5a303ce5-cb6f-43b9-857f-39cffc8c7d67@sjtu.edu.cn>
 <8c2aa5fe-026e-45c2-a908-5f6c245b2993@oss.qualcomm.com>
 <2c57e188-b9f5-45b9-90b3-81a3d128254a@sjtu.edu.cn>
 <69924eee-ba12-4a3e-baff-8ecb86d1ce77@oss.qualcomm.com>
 <37b40d64-aaa7-4358-ad5d-70c15dc05cba@sjtu.edu.cn>
 <9b8f79c7-1f30-4036-ba05-22d390a22410@oss.qualcomm.com>
 <e46324ae-0853-422d-aa45-11d73b4b3a18@sjtu.edu.cn>
 <4b825174-6ba6-49c5-b135-be611a4cf04a@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <4b825174-6ba6-49c5-b135-be611a4cf04a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 13 Jul 2026 11:15:29 -0700, Pierrick Bouvier wrote:
> I know it can be frustrating to address all the picky comments, but in
> this case, I really think it makes Lorelei better and easier to use, and
> not just to accommodate my personal taste. Hopefully it will help to
> make it more popular and integrated with other emulators also! 

Not frustrating at all. Thank you for getting it into QEMU upstream, 
which makes it accessible to many more people, and I really appreciate 
your recognition of Lorelei's potential.


> Yes, the important was to have the simplest example possible, without
> requiring any external dependency. I hope you can use it on Lorelei side
> as a minimal CI test to keep things working as they are.

That is a good idea, and I will keep the example as a standing check on 
the Lorelei side. Thank you for your meticulous guidance over these 
weeks, it has improved Lorelei's usability a great deal.


> Congrats again for your work on Lorelei!
> You're welcome to share your paper here once it will be published :).

Thank you, I will definitely share it once it is out.

We will keep exploring what native pass-through can do on top of the 
dlcall plugin. For instance, we already have pass-through working for
C++ libraries.

On the case you mentioned earlier, running Arm or RISC-V programs on an 
x86_64 host, that is a real need for some companies, and Lorelei should 
be able to support it without much trouble, since it is ISA-neutral.


Thanks,
Ziyang Zhang


