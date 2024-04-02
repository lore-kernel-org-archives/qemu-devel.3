Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA53CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrfBE-0005sJ-0W; Tue, 02 Apr 2024 10:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1rrf9o-0005Hd-KO; Tue, 02 Apr 2024 10:30:36 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1rrf9m-0002ZO-S3; Tue, 02 Apr 2024 10:30:36 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M72wZ-1rtZdZ3wop-00Djd6; Tue, 02 Apr 2024 16:30:31 +0200
Message-ID: <465cd941-4830-4adf-be76-011702bb71b3@vivier.eu>
Date: Tue, 2 Apr 2024 16:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Trivial patches for 2024-04-02
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20240402093157.2931117-1-mjt@tls.msk.ru>
 <CAFEAcA8UBewAHriNkbJNO9CFKgf5bBGRHntbb_y11JdfoNTvcQ@mail.gmail.com>
 <60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru>
Content-Language: fr, en-US
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pn0IV7FPY4yPlSqrMZYz+qM1d0guW090u0EudIKfegvzuq4yU/L
 mCeCPIvlC1mFmgYx0WPsx1EoooP+FAfHJtyMKQIShQPrLNtuWQI5PJ7qM2OVlhJxupKCQsQ
 bCp8yUCK2K1zO7fFXXBto1pUSy1vB4PulDGnTBTrLyWDn6JNt2/atXHTjUTXIbU5b+391OL
 s6StjvrxKkoQMyKzcg7Vw==
UI-OutboundReport: notjunk:1;M01:P0:hoXn6nVEJHk=;WuyjJUgdEUlqAfnaO4E64DPu0wi
 vgGfs6SUK7p3lBJlwgSlnAA63FPXRyX3jH2xpq9RfZAnl/+miMwGUtIElozhn9Ux92GWbh/TP
 zhja6HhvDQmZA5Vxb39sEU88KsACMc7Mh3f6ydkBNbSP0wV3xhO4pad1T0n4Lz45l4EoaaaYD
 2n3iTnHkS2CjiqsiWfLLiyk0AiLOO4JHpcgPItdJsP3o59zYvnnWodgEZRHRlXNjQw1kxttKp
 mHxaSFcCcaPLhjTMusnND3SphYwEnTu6ZThnGVf1rZWydvZMoHNV9qOkuoc5KEoYhEeWzlZ/S
 UaZVaCIb10YiRhOLij6n+zzsmEFuoC3cUkt8s3Fwk78lRflNS1eeAgm4risks+3PvykHuPWoR
 xLAH4Yxdi1vstqhwFwKRS+B4qnfvvp3jwQW5d51hM00Tr3SWgnilGP07XcNdB/ZF7YXfYk9dm
 YVOtQkQbhOS/sMN/fXDfGej0406HxHRT0UsqpfKWEZCHi9hgaQkaec9z3BUAMtOKjRoYXdJr1
 z/XaRr0vSfDJS78Z9UzEbn2ezJyvPB/P9ISRgFFm1Nyi/R89Cikskz5KVryoEUtkfh/AiWyQy
 ewm7ew+j0DlQfH8S6gkKBPAc1f9saBYX9+yqpp+eC/aERh3f41rEU2DRxxNyhwEwuwCAD0skT
 F2U3INqpSKX+KkjbbX92j8+hFJDWU6berQSNVAOFY/CUxAx01sBZkxjh6TSvgn6XmFd5Atubq
 vkYtMajLe8ldVPmGWzCaA09dxmtqC1FSOD/MyMwoKo1hX8HmORJR6g=
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Le 02/04/2024 à 12:41, Michael Tokarev a écrit :
> 
>> Author: Stefan Weil via <qemu-trivial@nongnu.org>
> 
> *SIGH*  This happened *again*.
> 
>> (you'll need to tell git log "--no-mailmap" to not get confused
>> by the mapping we have for the last time one of these slipped
>> through...)
> 
> Now this is interesting.  And this is exactly why I haven't noticed
> it - I did pay attention to Author lines this time.  -- because
> it is displayed with mailmap applied.  How very useful.
> 
> I have to use `git show --no-mailmap' to see the original " via.."
> version.
>

To post PR I generally use git-publish and I have a hook that checks that.

$ cat .git/hooks/pre-publish-send-email
!/bin/bash

NAME=$(git config --get user.name)
EMAIL=$(git config --get user.email)

for PATCH in $1/*.patch; do
     if [ $(basename $PATCH) = "0000-cover-letter.patch" ]; then
         continue
     fi
     if ! grep -q "^Signed-off-by: $NAME <$EMAIL>" $PATCH; then
         echo "Error: Missing sender S-o-B in $PATCH"
         exit 1
     fi
     if grep "^From: " $PATCH | grep -q "<qemu-devel@nongnu.org>" ; then
         echo "Error: Author email address is mangled by the mailing list in $PATCH"
         exit 1
     fi
done
exit 0


