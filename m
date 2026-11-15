Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF3606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xScCH-0003rC-0C; Sun, 15 Nov 2026 10:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xScCE-0003qh-KU
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 10:31:11 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xScCC-00008h-JZ
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 10:31:10 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0BBA660C38C;
 Sun, 15 Nov 2026 16:31:04 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id my-SFOgcthHZ; Sun, 15 Nov 2026 16:31:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4CEEC60C347; Sun, 15 Nov 2026 16:31:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 46FAD13CF1C;
 Sun, 15 Nov 2026 16:31:01 +0100 (CET)
Date: Sun, 15 Nov 2026 16:31:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yonggang Luo <luoyonggang@gmail.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
In-Reply-To: <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
Message-ID: <1447ca17-52a6-c069-d3b0-f778c60dca20@eik.bme.hu>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
 <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1046429862-1794755918=:11041"
Content-ID: <76fb01cc-e803-0bdb-a917-2df08ea41616@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1046429862-1794755918=:11041
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <525adade-15d0-0900-afb3-584c04e7137a@eik.bme.hu>

On Sun, 15 Nov 2026, Yonggang Luo wrote:
> On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> All QOM types must have a globally unique typename, however, for
>> user convenience, some might also want to have aliases which are
>> permitted to be ambiguous. Define an "Aliased" interface which
>> can be implemented by types which want to support aliases.
>>
>> When resolving an alias, if there are multiple QOM types with a
>> matching alias this is considered an error. Ambiguity can be
>> resolved by matching system state, with the selected target
>> being the currently implemented filter.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
>>  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
>>
>> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
>> index d222a3d7481..010e37d63f7 100644
>> --- a/include/qom/object_interfaces.h
>> +++ b/include/qom/object_interfaces.h
>> @@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>
>>  typedef struct TargetSpecific TargetSpecific;
>>
>> +#define TYPE_ALIASED "aliased"
>> +
>> +typedef struct AliasedClass AliasedClass;
>> +DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
>> +                       TYPE_ALIASED)
>> +#define ALIASED(obj) \
>> +     INTERFACE_CHECK(Aliased, (obj), \
>> +                     TYPE_ALIASED)
>> +
>> +typedef struct Aliased Aliased;

I wonder if it would be simpler to add the possibility to define aliases 
to all QOM objects as standard instead of by an interface? This is useful 
for other cases, it came up here too for example:
https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00113.html
Or maybe this could be done with this interface by common super classes 
implementing it such as device and machine allowing aliases that commonly 
need it to use it but then it would be quite widespread use to consider 
just adding it to object right away which may also help interaction with 
arch. Why separating it into an interface is better when we need it for 
most objects?

Regards,
BALATON Zoltan
--3866299591-1046429862-1794755918=:11041--

