Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7E2EA8126
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppEG-0000hB-Ib; Tue, 10 Feb 2026 10:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vppE6-0000O8-3T
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:00:31 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vppDx-00058b-PW
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:00:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45AF3596A13;
 Tue, 10 Feb 2026 16:00:18 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GCbxXmKr6wRn; Tue, 10 Feb 2026 16:00:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F1A2C596A0A; Tue, 10 Feb 2026 16:00:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EFA84596A10;
 Tue, 10 Feb 2026 16:00:11 +0100 (CET)
Date: Tue, 10 Feb 2026 16:00:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
In-Reply-To: <aYsP5xRouGmJFU4X@redhat.com>
Message-ID: <eebcb7f3-1d94-1d9a-2bee-e58866dabcb4@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <20260210054244-mutt-send-email-mst@kernel.org>
 <aYsP5xRouGmJFU4X@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-683344969-1770735611=:83126"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-683344969-1770735611=:83126
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Feb 2026, Daniel P. Berrangé wrote:
> On Tue, Feb 10, 2026 at 05:44:50AM -0500, Michael S. Tsirkin wrote:
>> On Tue, Feb 10, 2026 at 10:12:38AM +0000, Daniel P. Berrangé wrote:
>>> On Tue, Feb 10, 2026 at 11:23:27AM +0800, Zhao Liu wrote:
>>>> Hi,
>>>>
>>>> This is the v2 trying to introduce property flags to detect user's
>>>> property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
>>>> RFC v1 [1].
>>>
>>> This says what the series is proposing, but IMHO what is more important
>>> here is explaining why this either desirable or appropriate to add as
>>> general facility in QOM.
>>>
>>> The idea that code should take different action for a given fixed value,
>>> based on whether the value was set by the user, or left on the default,
>>> makes me very uncomfortable.
>>>
>>> There have been a number of situations where something that was initially
>>> a boolean flag, actually needed to be a tri-state instead, to provide
>>> semantics like "On", "Off", "Auto".
>>
>> But "auto" is exactly a property specific way to work around this.
>> With this, we could allow "auto" for any property (except strings I
>> guess) without per property code.
>>
>>
>>> This "user set" flag could support such behaviour indirectly, but since
>>> "user set" is an internal concept we'd still be only exposing a boolean
>>> externally, while using a tri-state internally. That does not give the
>>> full flexibility of a tri-state, because internally if we wanted to
>>> have the default to be "yes", it offers no way for the mgmt app to
>>> put it back to "auto".
>>
>> I do not get it. Of course user set is an external concept.
>> It is user controllable!
>
> If a property is modelled as a tri-state today the user can explicitly
> request any of the three values
>
>  -object  foo,prop=on
>  -object  foo,prop=off
>  -object  foo,prop=auto
>
> If a property is modelled as a boolean, and we have this new internal
> "user set" flag to represent the "auto" scenario, the user can only
> do
>
>  -object  foo,prop=on
>  -object  foo,prop=off
>
> we're missing the ability to explicitly request the "auto" value,
> which could be needed if we decide the internal default should be
> either "on" or "off".

In this case the auto setting would be not setting the property at all to 
any value by the user.

> This "user default" flag concept is special casing support for
> tri-states in a way that is worse than what we can already do in
> QAPI. That feels like a mistake / bad path to go down to me.

I also don't really like the USER_SET name so commented to rename to 
EXTERNAL but thinking more do we need both EXTERNAL/USER_SET and INTERNAL? 
One of the two would be the default behaviour for untagged properties so 
maybe we only need to flag INTERNAL to omit them from introspection and 
user setting but don't need to touch normal user settable properties 
(apart from adding deprecarion_message that also replaces DEPRECATED flag. 
But I don't have clear idea or opinion on this so these are more questions 
than suggestions.

Regards,
BALATON Zoltan
--3866299591-683344969-1770735611=:83126--

