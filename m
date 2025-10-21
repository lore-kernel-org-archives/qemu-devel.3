Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9675CCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEX7-0004ST-04; Tue, 21 Oct 2025 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBEX4-0004Rm-Il
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:44:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBEX1-0006Bw-Lp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 96F1A5972DF;
 Tue, 21 Oct 2025 17:44:11 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Y6O6I8p73s_m; Tue, 21 Oct 2025 17:44:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26ECF5972DE; Tue, 21 Oct 2025 17:44:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 222B559703F;
 Tue, 21 Oct 2025 17:44:06 +0200 (CEST)
Date: Tue, 21 Oct 2025 17:44:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Alberto Garcia <berto@igalia.com>, Thomas Huth <huth@tuxfamily.org>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 "Collin L. Walling" <walling@linux.ibm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Corey Minyard <minyard@acm.org>, 
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Michael Rolnik <mrolnik@gmail.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 Vijai Kumar K <vijai@behindbytes.com>, Samuel Tardieu <sam@rfc1149.net>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Raphael Norwitz <raphael@enfabrica.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>, 
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH] char: rename CharBackend->CharFrontend
In-Reply-To: <CAMxuvawWEJHmJS=xOKbSnFS58HSLxRi0r7KP-GV9nuDDASTNcQ@mail.gmail.com>
Message-ID: <dcb71aea-37c3-5d42-7dd7-797700ba5862@eik.bme.hu>
References: <20251021122533.721467-1-marcandre.lureau@redhat.com>
 <01a51fe7-4414-e787-ddf5-5ede0c1e1e74@eik.bme.hu>
 <CAMxuvaz8GueSp-vPHFWnbv+Odcy63Cz_hZHd3NzReWXp3pnsqg@mail.gmail.com>
 <6c5e599f-f106-e89e-2a2d-6760a2b65c08@eik.bme.hu>
 <CAMxuvawWEJHmJS=xOKbSnFS58HSLxRi0r7KP-GV9nuDDASTNcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-702529982-1761061446=:27696"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-702529982-1761061446=:27696
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Oct 2025, Marc-André Lureau wrote:
> On Tue, Oct 21, 2025 at 6:11 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Tue, 21 Oct 2025, Marc-André Lureau wrote:
>>> On Tue, Oct 21, 2025 at 5:25 PM BALATON Zoltan <balaton@eik.bme.hu>
>> wrote:
>>>> On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> /**
>>>>> - * struct CharBackend - back end as seen by front end
>>>>> + * struct CharFrontend - back end as seen by front end
>>>>
>>>> I stopped here, haven't read the rest of the patch but the above comment
>>>> seems to become inconsistent. Which is the front end and back end now?
>>>>
>>>>
>>> It's the "frontend side" of a chardev "backend". Naming it CharBackend
>> has
>>> always been the source of confusion, since the actual backend is Chardev.
>>> There was earlier attempt to rename it and various complains. I believe
>>> this is is long overdue.
>>
>> Comment after patch says: "CharFrontend - back end as seen by front end"
>> This can't be consistent as it calls CharFrontend a back end.
>>
>
> I am not sure how to better explain it than:
>
>> It's the "frontend side" of a chardev "backend"

Then maybe:
CharFrontend - Chardev as seen by front end
would be less confusing,

> Another way to think of it is a "handle" ? but since we use char-fe.h and
> _fe_*() already, this is just renaming by following the current API...
>
>
>> Maybe it's actually the frontend/backend terminology what is confusing so
>> just swapping the names won't fix that. Better find some clearer naming
>> instead? Maybe something with Guest/Host or we already have
>> chardev/blockdev/audiodev (matching the command options to specify these)
>> for backends so call backends like that. But then I don't know what to
>> call guest side as it's added by -device so could be CharDevice but
>> CharDevice and Chardev does not seem too clear either. Maybe ChardevGuest
>> ChardevHost or something along those lines?
>>
>>
> As I argue earlier, Guest/Host is not generic enough as it ties a bit too
> much to hypervisor terminology.
>
>
>> Alternatively it may be easier to just add a file to docs first, listing
>> these for existing frontend/backend pairs and explaining which is which
>> before renaming anything and once we have a list of all of them at one
>> place we can see what is the easiest way to rename them with least churn.
>> I think that's similar to what Peter also proposed in previous reply. I'm
>> afraid that renaming only some of these won't make them less confusing.
>
>
> We have all the users in this patch. I don't think it's necessary to list
> them in a separate file, but if necessary I can.

Not listing all users but listing all such type names and their relation. 
Such as
Chardev - CharBackend
QEMUSoundCard - Audiodev (or whatever is that)
etc.
And do that before any renaming so we have all these types documented 
(that alone helps making these less confusing) then we can think of how to 
name them better without getting other inconsistency again. Just renaming 
few of them without considering all of them may not solve all 
inconsistency.

Regards,
BALATON Zoltan
--3866299591-702529982-1761061446=:27696--

