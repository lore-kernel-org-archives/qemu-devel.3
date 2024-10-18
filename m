Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0695ED30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p4N-0001mi-LB; Fri, 18 Oct 2024 11:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1p4H-0001kB-Nu; Fri, 18 Oct 2024 11:39:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1p4F-0000UJ-DG; Fri, 18 Oct 2024 11:39:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 28ABF99D09;
 Fri, 18 Oct 2024 18:38:31 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E46D815787A;
 Fri, 18 Oct 2024 18:38:53 +0300 (MSK)
Message-ID: <52cc6540-b1ff-495e-9b98-98f13ecbf380@tls.msk.ru>
Date: Fri, 18 Oct 2024 18:38:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Zhiyi Guo <zhguo@redhat.com>
References: <20240917163835.194664-1-peterx@redhat.com>
 <20240917163835.194664-2-peterx@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240917163835.194664-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

17.09.2024 19:38, Peter Xu wrote:
> Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
> was a separate discussion, however during that I found a regression of
> dirty sync slowness when profiling.
> 
> Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
> statically allocated to be the max supported by the kernel.  However after
> Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
> the max supported memslots reported now grows to some number large enough
> so that it may not be wise to always statically allocate with the max
> reported.
> 
> What's worse, QEMU kvm code still walks all the allocated memslots entries
> to do any form of lookups.  It can drastically slow down all memslot
> operations because each of such loop can run over 32K times on the new
> kernels.
> 
> Fix this issue by making the memslots to be allocated dynamically.
> 
> Here the initial size was set to 16 because it should cover the basic VM
> usages, so that the hope is the majority VM use case may not even need to
> grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
> it'll consume 9 memslots), however not too large to waste memory.
> 
> There can also be even better way to address this, but so far this is the
> simplest and should be already better even than before we grow the max
> supported memslots.  For example, in the case of above issue when VFIO was
> attached on a 32GB system, there are only ~10 memslots used.  So it could
> be good enough as of now.
> 
> In the above VFIO context, measurement shows that the precopy dirty sync
> shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
> to any KVM enabled VM even without VFIO.
> 
> NOTE: we don't have a FIXES tag for this patch because there's no real
> commit that regressed this in QEMU. Such behavior existed for a long time,
> but only start to be a problem when the kernel reports very large
> nr_slots_max value.  However that's pretty common now (the kernel change
> was merged in 2021) so we attached cc:stable because we'll want this change
> to be backported to stable branches.

Looking at this from qemu-stable PoV, I'm not 100% sure this change is good
for stable-7.2 series, because 7.2 lacks v8.1.0-1571-g5b23186a95
"kvm: Return number of free memslots" commit, which was a preparation for
for memory devices that consume multiple memslots.

I did a backport of this change (currently it is at the tip of staging-7.2
branch of https://gitlab.com/mjt0k/qemu.git) - I had to tweak context and
also to remove now-unused local variable in kvm-all.c.  It builds and the
tests run fine, but I'm not really sure it does what it is intended to do.

Should anything else be picked up for 7.2 for all this to work, or should
this change not be back-ported to 7.2 ?

(for more recent releases, everything looks ok).

Thanks,

/mjt

