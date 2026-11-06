Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21743606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=XvsRaQqM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJ1p-0006kg-67; Fri, 06 Nov 2026 07:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPJ1O-0006dh-P9; Fri, 06 Nov 2026 07:26:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPJ1K-0008OX-4H; Fri, 06 Nov 2026 07:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793967969; bh=aQyiqc992ueh1RbmnhfQCj9ISnoieNtje27DzjWeq9U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XvsRaQqMJKeK/kWC0GpYdjpeaWUj0ZHjjBHTAHsdKV5KNQcbuIowOErob5d7iy8bj
 2D1AbCgTUoM+x8S0RjuUFsTTc1ytMUvy1s2RIMfPn1g9dqzw5W3sv7Vgd7dCcPAMWe
 ZSNQkTYBryoY2oeam0BxP0Wq8u/FwkYeWz9+WSx6bE+kmCWDCokVo40C4bfXLHQ+QU
 CEGDtlMUHwTcBZIWS2lbOxhvBJDiQn8TpWeqh8lRHw8Kj8TdAePKe2oTbOFk7PGGGl
 HJm/Pr4eRYYPfixqNHXHIyF87+iVkp4MIV/tT/Scac3kG7Mw5HkpsQ0dS66mm8O2kH
 FHvDD0TjVvlMA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 712161E44FA;
 Fri, 06 Nov 2026 15:26:09 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61D36455A29;
 Fri, 06 Nov 2026 15:26:09 +0300 (MSK)
Message-ID: <fff79cf8-68dd-4652-ad71-0b6c10aadd75@tls.msk.ru>
Date: Fri, 6 Nov 2026 15:26:09 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fixes for stable qemu series
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Oleg Drokin <green@linuxhacker.ru>, qemu-devel <qemu-devel@nongnu.org>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <cfcac305-df2d-4b95-b27a-21518cb73841@tls.msk.ru>
 <au2cGqMNssHcxCXd@redhat.com>
 <CAFEAcA9HfbL-VTB7uG2cdMT6FcHtkog+TRRPcQY-yH3Qtkg=7A@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFEAcA9HfbL-VTB7uG2cdMT6FcHtkog+TRRPcQY-yH3Qtkg=7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 13:17, Peter Maydell wrote:
> On Fri, 6 Nov 2026 at 09:22, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Fri, Nov 06, 2026 at 12:15:06PM +0300, Michael Tokarev wrote:
>>> Hi!
>>>
>>> What's the way you use to find these patches, with security impact or not?
>>>
>>> I usually quickly screen all new commits in the master branch, and often
>>> catch things which aren't marked for-stable, - not everything of interest
>>> is marked as such.  I also tend to remind the maintainers about these
>>> markings.  But my resources here are limited, I can't try to understand
>>> every patch, even description of it.
>>>
>>> How do you perform a security review?
>>
>> FWIW, with our new security triage process, we should be fairly
>> reliably getting issues in gitlab tagged with CVE::Assigned, if
>> they have been accepted as an in-scope security issue and had a
>> CVE assigned.
> 
> I think in this case we're talking about #4802 (confidential),
> and the problem is that the commits in question were not given
> a CVE or tagged for stable, because it wasn't realised at the time
> that they were fixing a bug.
Not really.  I understand this one weren't considered an issue at
the time of patching, - only now it come as a serious vuln.

I'm talking about what Daniel mentioned above, exactly.  Plus how
Oleg were finding the issues/fixes, including this #4802 too.

Thanks,

/mjt

