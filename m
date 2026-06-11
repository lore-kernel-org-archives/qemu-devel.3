Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD84CD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZMA-0002so-Nz; Thu, 11 Jun 2026 02:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXZM7-0002sZ-Vi
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:57:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXZM5-0008Ss-4J
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:57:35 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B6vC7f033380
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 15:57:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QJvNOTwiYID/wSypyJoijiJIEi0TPaeNkSeEcYV3Sek=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781161033; v=1;
 b=CIeWXJPFvYwKBKI3AKBI8NcXu9sBOqZQh8PioXOBeQ3F6tsqO9q1ugifQRn8lSEs
 /FQl6TQ/vXlx0Iai2ihOGazI0gN2EJQ7NkWUAncMjSrHp9FJTidUV21F/+F4uR3T
 L7PQBZrL5Ab0HOfOHJnzo7/cjha1eE/2fUdmJWMykmOcLIcbYCxxyu1iQCIJbr3x
 4MssBx2XBMyG8LXbSJ5OVxz8xKB9iKBP5msbmLZiXOsUkNRhgHH9+g6aokfC9PiB
 gNm1Ijl08y62twlZGcZeGFRh+R3pqJRKwD4tfqRL84FWzznjKScRPlJEicauXFrN
 YW4tHy4TsDZAtqe0oDSv+A==
Message-ID: <469bf4b8-0027-40d3-b0fa-242286022e30@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 15:57:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] checkpatch: Check .m, .build, .hx, .in, .json, .txt
 and .plist
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 devel@daynix.com
References: <20260604-checkpatch-v3-1-23fc7b12a7e4@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA8uV11z1BGp05gs+f-v4E+CE4DQQJa++DFUMxcCZ8kCDg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAFEAcA8uV11z1BGp05gs+f-v4E+CE4DQQJa++DFUMxcCZ8kCDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/08 18:31, Peter Maydell wrote:
> On Thu, 4 Jun 2026 at 11:11, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> Check more text files: Objective-C, Meson, "hx", JSON, and property
>> list.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> This is missing rationale. Currently checkpatch is set up
> to check source code files, and the bulk of its checks are
> for source code issues. Why do we want to make it also check
> non-source-code files?

The intent is to check source code files. More precisely, it is intended 
to check manually-written text files that the generic text checks apply to.

> 
>> -our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
>> +our $SrcFile =
>> +       qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|hx|in|json|plist|txt)$};
> 
> If I run checkpatch on our .hx files, I get a lot of complaints
> about trailing whitespace after "\" characters. I have a vague
> memory that those are deliberate, though I forget the details.
> We shouldn't add a file type to this list if it's going to
> produce a lot of false positives.

I found the rationale in commit 09ce5f2d6bd6 ("qemu-options.hx: Fix up 
the autogenerated rST"):

 > rST does not like definition list entries with no actual
 > definition, but it is possible to work around this by putting a
 > single escaped literal space as the definition line.

So the whitespace check cannot be applied to .hx files. I'll drop .hx 
from the source file type list.

Regards,
Akihiko Odaki

