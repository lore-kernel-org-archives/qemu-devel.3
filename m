Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09302EA8128
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppTm-0000UZ-Ru; Tue, 10 Feb 2026 10:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vppTk-0000Tn-Sf
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:16:41 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vppTi-0007XH-5I
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:16:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3AE175969FF;
 Tue, 10 Feb 2026 16:16:36 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id CKxVA4dj1vSE; Tue, 10 Feb 2026 16:16:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B2ED6596A0A; Tue, 10 Feb 2026 16:16:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B09BE5969FA;
 Tue, 10 Feb 2026 16:16:33 +0100 (CET)
Date: Tue, 10 Feb 2026 16:16:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
In-Reply-To: <aYtOh9guoiQocdjk@intel.com>
Message-ID: <0193cb6f-7b73-43c1-ac89-93b426d3983e@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-18388040-1770736593=:83126"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-18388040-1770736593=:83126
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Feb 2026, Zhao Liu wrote:
> On Tue, Feb 10, 2026 at 10:12:38AM +0000, Daniel P. Berrangé wrote:
>> Date: Tue, 10 Feb 2026 10:12:38 +0000
>> From: "Daniel P. Berrangé" <berrange@redhat.com>
>> Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
>>  external user input
>>
>> On Tue, Feb 10, 2026 at 11:23:27AM +0800, Zhao Liu wrote:
>>> Hi,
>>>
>>> This is the v2 trying to introduce property flags to detect user's
>>> property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
>>> RFC v1 [1].
>>
>> This says what the series is proposing, but IMHO what is more important
>> here is explaining why this either desirable or appropriate to add as
>> general facility in QOM.
>
> Yes, sorry this cover letter I wrote is overly simplified.
>
> This series tries to control the property access against external user.
> USER_SET is the base to track external user's behavior, and DEPRECATED &
> INTERNAL flags provide different levels of access control.
>
> Though the DEPRECATED flag does not inherently restrict access, I think
> such a warning also serves as a form of control.
>
> The idea of restricting external access to properties is from previous
> discussions [*] about internal properties.
>
> [*]: How to mark internal properties:
>     https://lore.kernel.org/qemu-devel/2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com/
>
> Since that disscussion, currently all properties expected to be
> "internal" have an “x-” prefix — while this approach can work, it clearly
> confuses the original meaning of “x-”, which actually means "unstable".
>
> Therefore, I think the optimal approach is to provide the capability to
> restrict external access to the property — that is, to implement the
> "true" internal property.
>
> Based on this, it seems impossible to implement an internal property
> without tracking user input in the QOM?
>
>> The idea that code should take different action for a given fixed value,
>> based on whether the value was set by the user, or left on the default,
>> makes me very uncomfortable.
>>
>> There have been a number of situations where something that was initially
>> a boolean flag, actually needed to be a tri-state instead, to provide
>> semantics like "On", "Off", "Auto".
>>
>> This "user set" flag could support such behaviour indirectly, but since
>> "user set" is an internal concept we'd still be only exposing a boolean
>> externally, while using a tri-state internally. That does not give the
>> full flexibility of a tri-state, because internally if we wanted to
>> have the default to be "yes", it offers no way for the mgmt app to
>> put it back to "auto".
>>
>> For properties that are not booleans, it is much less obvious to me
>> whether we actually need a distinct "not set" concept at all.
>
> USER_SET primarily serves the INTERNAL and DEPRECATED flags. However,
> its another function is to indicates whether the external user has
> touched the property.
>
> But, Hmm, I think "auto" and USER_SET don't have conflict?
>
> IIUC, "auto" means the user requests that QEMU make the decision itself.
> However, just like my patch 19 cleanup of “lbr-fmt”, that property
> explicitly requires users to provide a valid value. Even we have "auto"
> for uint64, "auto" can't address this case.
>
> Similarly, the x86 CPU's topology IDs (used for hotplug) - "thread-id"/
> "core-id"/"module-id"..., also require the user to set valid and accurate
> values; they cannot be replaced with "auto".
>
> These existing cases all check user input for magic numbers. I hope to
> simplify these existing logic using USER_SET.
>
>> So overall, at a conceptual level, I don't think that QOM should care
>> about /how/ a value came to be set. It should have no direct awareness
>> of the "user input", rather it just represents the configuration of the
>> system at a given point in time,  however that came to pass.
>
> I also think the ideal situation is not to distinguish between external
> and internal - however, exposing properties to external users makes code
> evolution painful...

So another way could be to not use properties for internal settings but 
add another set of internal properties for those. These could be set the 
same way but stored in a different hash table and not get mixed with 
introspectable and user changable properties. But maybe that would be too 
much refactoring.

Regards,
BALATON Zoltan
--3866299591-18388040-1770736593=:83126--

