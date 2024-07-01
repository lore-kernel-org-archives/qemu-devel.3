Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ACBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOHIT-0005TG-1g; Mon, 01 Jul 2024 09:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sOHIQ-0005Sa-OV; Mon, 01 Jul 2024 09:42:18 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sOHIO-0005FI-0I; Mon, 01 Jul 2024 09:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rdnldjpHDymTTRDdDSW8yidhms6Fd8LcekCMTT7BZPU=; b=CfJSIMrdteRdkF+NMkoVANamRZ
 9P5MQWCdEXQu9NI86vAzQHj+44zM5Aiih2qoTiS+/T5eepHEVSYbaD7q8rkLsWXgSg/3ztImRl+di
 SX10zcOWlqyhixf5twPP7wtQVo/PiWmmyaphwO+0UBqAKmLD/t0RTmK3o1qdFvWuUDtyzsiywRB0+
 QlOfTXbBL4YCnCL3CI6f1v3q9SwdqV26+aBqrLIqydt2f13SzLENaxJjcVxNG5uU3RFjWRyTgpasg
 590ckOUImna3MjuaDup5Bmuc1+lRVmL7bfE5DqXoEp9qHh2NtYSacdk/x8lRF8ca2i/andbILDgyA
 tJUWKRNg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sOHIJ-009r9x-Tv; Mon, 01 Jul 2024 15:42:11 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sOHIH-00Eidv-NH; Mon, 01 Jul 2024 15:42:11 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sOHIH-00GAUn-1o;
 Mon, 01 Jul 2024 13:42:09 +0000
From: Alberto Garcia <berto@igalia.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake
 <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek
 <hreitz@redhat.com>, Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
In-Reply-To: <CAAjaMXau1qvDrBGn1Kj4Z7g0rRGsp0x6n9hmyK_-SA2HFeZ0Pg@mail.gmail.com>
References: <20240610144708.81351-1-berto@igalia.com>
 <eyt18.e0s2rty6vd9y@linaro.org> <w51sewtpk1t.fsf@igalia.com>
 <CAAjaMXau1qvDrBGn1Kj4Z7g0rRGsp0x6n9hmyK_-SA2HFeZ0Pg@mail.gmail.com>
Date: Mon, 01 Jul 2024 15:42:09 +0200
Message-ID: <w51a5j1b55a.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
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

On Mon 01 Jul 2024 02:07:01 PM +03, Manos Pitsidianakis wrote:
>> and I'm not sure what benefits using pathlib brings in this case.
>
> implicit type requirement, argument value validations, path
> normalization etc.

Do you have a specific example? I don't see any difference in behavior
if I make input_file a pathlib.Path, I still need to check if the file
exists, etc., I don't see that this is validating anything.

>>     with open(raw_file, 'wb'):
>>         pass
>>
>> If so I don't see the benefit, I just need to create an empty file and
>> close it immediately.
>
> My only argument here is that it's "more pythonic" which I know is of
> little value and consequence :) Feel free to ignore! They were mere
> suggestions.

In general I would agree (that's why I'm opening files this way in other
parts of the script) but for this case I don't think it's worth it.

>> I'm not sure that I understand, why would I need to use a shell here?
>
> I must have meant capture_output=3DTrue, not shell=3DTrue, sorry for that
> =F0=9F=A4=94. The explicit check=3DFalse says to the reader that this won=
't throw
> an exception so it's just for readability. The capture_output part is
> so that you can print the outputs if the return code is an error.

Ah I see.

I'll send a new version soon.

Thanks for the review,

Berto

