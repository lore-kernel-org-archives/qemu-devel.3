Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA99FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOIm-0007Nl-37; Mon, 27 Apr 2026 11:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wHOIZ-0007KC-2C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:55:04 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wHOIW-0005Q6-BM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1777305286; x=1777910086; i=laurent@vivier.eu;
 bh=kv3s297F66VapuIm9NxybfwJRxdGFZ6DxkQPiLvZ9Jg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ORPtERicQM8Jq/JLwOIFFjZ/vGMSjEPurUA904lbaJ4XlQwBFgNOapEAdqRBy0wa
 0dooBTBtXo+QhvQXSrTdgNHeRuurlt3hRTdtOCumFk59iiimPmZxiscnYEtCOa3Zv
 KCzbjEputtgJLUf8E5uHmaBCNxcVcE5iK4UvD0+VyQu98NqXbM9dMOdY7uIUqN8q/
 80+1IarWsxjycPLsfpF2VMQ32vXlRZB308u3s5vKCJWsTALqbbjVaY3Gs2zleF+3a
 NLXa4tSL4UnPuiw1T1Qfc0bq4E/lsjkviKV1TVxybhjGZU0bAaGd4k+2sSik5lDHn
 tYuQDz4aPQgHucanQA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1Mbies-1veCvQ06d4-00fWS2; Mon, 27
 Apr 2026 17:54:46 +0200
Message-ID: <fc190654-ea82-48b1-a286-31bb370a4bfd@vivier.eu>
Date: Mon, 27 Apr 2026 17:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
To: Helge Deller <deller@gmx.de>, Peter Xu <peterx@redhat.com>,
 Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20260423151521.3969-1-deller@kernel.org>
 <aeo_xCeDUu2VRKyc@x1.local> <6964cdc9-f730-46bd-874e-99c29600c5d3@gmx.de>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <6964cdc9-f730-46bd-874e-99c29600c5d3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6uZUh7Dv6D7ttr54lcXCj4SGz9jy6LsEf8VmRHRbqnFswj9VYla
 GAnIUkksxQjBJFj9Vtc+Ibt3VqoMqrlj0tjcRKgHSSO8/6DlCp9yHDTxuE//Wq+DWpaNskV
 WAL1siE2a0paxNwiANUeOjCfSHRU+WFTt6DRYdUtc6lCOlzF7HbzdlDQn96cIZHA6khXqji
 VRiMErJqP5EXpmpF1BGLQ==
UI-OutboundReport: notjunk:1;M01:P0:kxzL+G8dZI8=;eK1UMnbpQqjxpYti5QDnbOpb1zN
 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
 cREvfIutxeXV412+TnNw=
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Le 23/04/2026 =C3=A0 17:57, Helge Deller a =C3=A9crit=C2=A0:
> On 4/23/26 17:50, Peter Xu wrote:
>> On Thu, Apr 23, 2026 at 05:15:21PM +0200, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> I'd like to step up as maintainer for linux-user. I'm actively using
>>> linux-user to emulate a HP-PARISC (hppa) linux environment on my debia=
n
>>> buildd servers, so I'm very much interested that linux-user is running
>>> good and stable.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>> =C2=A0 MAINTAINERS | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ad215eced8..4736f5ad74 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4074,6 +4074,7 @@ F: tests/vm/*bsd
>>> =C2=A0 T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-=
rebase-3.1
>>> =C2=A0 Linux user
>>> +M: Helge Deller <deller@gmx.de>
>>> =C2=A0 M: Laurent Vivier <laurent@vivier.eu>
>>
>> Will Laurent still be maintaining?
>=20
> I don't know. I added him when I sent the mail, so I hope he will answer=
...
>=20
>> I don't know if the order matters at all, no matter so.. IHMO it might =
be
>> good to keep Laurent as the 1st entry.

Sorry, I was swamped with email and missed this earlier.

Thanks for volunteering to help maintain linux-user.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

> That's fine for me. I'll change it in my commit.
>=20
> Thanks!
> Helge
>=20
>>
>>> =C2=A0 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> =C2=A0 S: Odd Fixes
>>> --=20
>>> 2.53.0
>>>
>>>
>>
>=20
>=20


