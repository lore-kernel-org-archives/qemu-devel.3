Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D98C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 18:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxWht-00053K-CF; Thu, 18 Apr 2024 14:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>) id 1rxWhr-00052v-Br
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 14:41:59 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>) id 1rxWhp-0007kC-GX
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 14:41:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id C28561140094;
 Thu, 18 Apr 2024 14:41:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Thu, 18 Apr 2024 14:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1713465711; x=1713552111; bh=WYona33Oi0
 91DmN3yevCSRN9ewoDtBHoqopr8VTRAnM=; b=gVLvCxMIpcQ+HMquC6K/n1sHMJ
 GdZPYyzlKf6w6OJUhXoVhtdz0r3qgYSSRcEGZD7rNCBlmpd2aZ2VCaqD1EQgn4bO
 eEWxCbte0LES0O3a79A2E84rXJUjpFtaarXRLFsOYIT6D5UBZ9WP3iq7Cj50wzmr
 nOdSUrAZ809gbZCqeMNSRCd4wTvY9adVvssUEBjyeVIMaZzS2XKXcob6knLBWTHi
 ccXkf28c64Gip381CGkWt7JYNHpuI7z/eqnGRLE6PkbrjsQWkNpyVJYAq0Stv5lL
 F5VNG+g4mkcYqNMco70937f7jpCsnWtfwFRkgvAhQi09IwyG1GVcY3qzU67A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1713465711; x=1713552111; bh=WYona33Oi091DmN3yevCSRN9ewoD
 tBHoqopr8VTRAnM=; b=P5hlAXkwi7ODwwNHH8mGFota2lxmlcL8dyjn19Lgz0Qo
 rvv4QxCON/6NLayy0jHW94UAqJd72XxAcugHQxoqNWhPz0PDu6e6e7w0jcGwG/m7
 RJAYzOYNqojB16P0wsefXsP0oWugipemGdZi3+aWPOyD6dQPMxrwx7BL8+tyh4pf
 HBiEZUpGUeOaZRjK/L0euvkCtKva/i5SPMfI8YTvfBfAWqMTpmvb5iEU4wOUq8Z9
 gbCuXp1QHn4nOybr9lC0K1XxodLkASgW2Qs/jKn0VrW53Zh05RVrjKct0ddXAl97
 yxrubCJ0CYM/57f/12S09Kjbq2WJY4dY5NfHlLby1A==
X-ME-Sender: <xms:b2khZiuNJNjhd1upEA6hRgg5IOsWQNB1Zc9T_vqt5CgTRFRRy97qvw>
 <xme:b2khZnfZ_pPDxQZhSFHQKveKsW7Hhce076MRjppp-jegNt5F00S5mptOQAC3G8hFG
 _ULb4-ucTU7r8cySrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddguddvjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:b2khZtzZ952xaa1RjxYuUIlqgZbN6igB3jxwdoJP7xSVNqjzKeZXtg>
 <xmx:b2khZtPW9tMjTI7BsNG9syTDd6kiBbnmKBO3Yw9RL0cLzSG9YTjdzQ>
 <xmx:b2khZi_O4kXQi-CTFpPBJeWLbrx1kynZd_2pMnNiR-0gzc50taSZnw>
 <xmx:b2khZlWgCt2RzWmw9HWfWTpdgqCTq9nnTqV5gKhKOf6Q0jQ3R4BleQ>
 <xmx:b2khZmU0dU692nswnxkOv7NuXrZyCPS4D-xMDWWcv0KZfQKX_XFGG0qY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4D343B6008D; Thu, 18 Apr 2024 14:41:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
MIME-Version: 1.0
Message-Id: <320677a6-1c3a-477c-95fc-b74cb5a4c5c6@app.fastmail.com>
In-Reply-To: <b5d375ed-283-974a-febf-892760ff855@redhat.com>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <b5d375ed-283-974a-febf-892760ff855@redhat.com>
Date: Thu, 18 Apr 2024 20:41:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Joseph Myers" <josmyers@redhat.com>,
 "Sandra Loosemore" <sloosemore@baylibre.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,
 "Xi Ruoyao" <libc-alpha@sourceware.org>,
 "Chung-Lin Tang" <cltang@baylibre.com>, andrew@reenigne.org,
 "Yao Qi" <qiyaoltc@gmail.com>, "Dinh Nguyen" <dinguyen@kernel.org>,
 qemu-devel@nongnu.org, newlib@sourceware.org,
 "Andreas Oetken" <andreas.oetken@siemens.com>,
 "Bernd Weiberg" <bernd.weiberg@siemens.com>, "Marek Vasut" <marex@denx.de>
Subject: Re: Deprecation/removal of nios2 target support
Content-Type: text/plain
Received-SPF: pass client-ip=103.168.172.159; envelope-from=arnd@arndb.de;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Thu, Apr 18, 2024, at 17:44, Joseph Myers wrote:
> On Wed, 17 Apr 2024, Sandra Loosemore wrote:
>
>> Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and remove
>> support from all toolchain components after the release is made.  I'm not sure
>> there is an established process for obsoleting/removing support in other
>> components; besides binutils, GDB, and GLIBC, there's QEMU, newlib/libgloss,
>> and the Linux kernel.  But, we need to get the ball rolling somewhere.
>
> CC:ing Arnd Bergmann regarding the obsolescence in the Linux kernel.

We have not yet marked nios2 as deprecated in the kernel, but that
is mostly because the implementation does not get in the way too
much and Dinh Nguyen is still around as a maintainer and merging
bugfixes.

Almost all nios2 kernel changes I see in the past decade have been
done blindly without testing on hardware, either for treewide
changes, or by code inspection. The only notable exceptions I could
find are from Andreas Oetken and Bernd Weiberg at Siemens and
from Marek Vasut (all added to Cc in case they have something to add).

We should probably remove nios2 from the kernel in the near future,
but even if we decide not to, I think deprecating it from gcc is the
right idea: If there are a few remaining users that still plan
to update their kernels, gcc-14 will still be able to build new
kernels for several years.

     Arnd

