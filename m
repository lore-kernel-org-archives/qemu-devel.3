Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A74C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9iv-0007k6-PN; Thu, 07 Mar 2024 04:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1ri9it-0007jx-OQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:07:32 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1ri9iq-0008H2-Ka
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:07:31 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:dad:0:640:1761:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 77FD160EB5;
 Thu,  7 Mar 2024 12:07:21 +0300 (MSK)
Received: from [IPV6:2a02:6b8:8f:4:b109:a1eb:adad:8bd8] (unknown
 [2a02:6b8:8f:4:b109:a1eb:adad:8bd8])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id x6dMao0Ika60-Ihps5BJC; Thu, 07 Mar 2024 12:07:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709802440;
 bh=gCrALSycJdOKU3RA3TnFzJb5CbfDN0WeWbKvQLQUl0c=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=f31fbUd6cWqaIuP7q6jqPZTvSiGw+7LQh9oNfJsU7aeM5DFuYkMXIswElrAdezia9
 JHFewQyHB/p6kLN37DKJT4UqXrtEIB0ST8iKPNGALgEZNl3w9GNQU8BbgJHJ4y6e69
 2H2XZsKHa7pHuDnHcY+G4M6Kd2rXwRq5mc2muHvA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------NVL33SzOfUKvq6j1zcFrpuy6"
Message-ID: <117b4556-aadd-4287-909c-e5cf988214b5@yandex-team.ru>
Date: Thu, 7 Mar 2024 12:06:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] machine development tool
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, jsnow@redhat.com, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
 <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
 <874jdkn3he.fsf@pond.sub.org> <ZefNfJ3BwudA-M7t@x1n>
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <ZefNfJ3BwudA-M7t@x1n>
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=1.499, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------NVL33SzOfUKvq6j1zcFrpuy6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/24 04:57, Peter Xu wrote:
> On Tue, Mar 05, 2024 at 03:43:41PM +0100, Markus Armbruster wrote:
>> Peter Maydell<peter.maydell@linaro.org>  writes:
>>
>>> On Mon, 4 Mar 2024 at 13:52, Maksim Davydov<davydov-max@yandex-team.ru>  wrote:
>>>> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
>>>>
>>>>    Merge tag 'pull-request-2024-03-01' ofhttps://gitlab.com/thuth/qemu  into staging (2024-03-01 10:14:32 +0000)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://gitlab.com/davydov-max/qemu.git  tags/pull-compare-mt-2024-03-04
>>>>
>>>> for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
>>>>
>>>>    scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
>>>>
>>>> ----------------------------------------------------------------
>>>> Please note. This is the first pull request from me.
>>>> My public GPG key is available here
>>>> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
>>>>
>>>> ----------------------------------------------------------------
>>>> scripts: add a new script for machine development
>>>>
>>>> ----------------------------------------------------------------
>>> Hi; I would prefer this to go through some existing submaintainer
>>> tree if possible, please.
>> Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.
> Yeah this seems like migration relevant.. however now I'm slightly confused
> on when this script should be useful.
>
> According to:
>
> https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/
>
>          This script runs QEMU to obtain compat_props of machines and
>          default values of different types of drivers to produce comparison
>          table. This table can be used to compare machine types to choose
>          the most suitable machine or compare binaries to be sure that
>          migration to the newer version will save all device
>          properties. Also the json or csv format of this table can be used
>          to check does a new machine affect the previous ones by comparing
>          tables with and without the new machine.
>
> In regards to "choose the most suitable machine": why do you need to choose
> a machine?
>
> If it's pretty standalone setup, shouldn't we always try to use the latest
> machine type if possible (as normally compat props are only used to keep
> compatible with old machine types, and the default should always be
> preferred). If it's a cluster setup, IMHO it should depend on the oldest
> QEMU version that plans to be supported.  I don't see how such comparison
> helps yet in either of the cases..
>
> In regards to "compare binaries to be sure that migration to the newer
> version will save all device properties": do we even support migrating
> _between_ machine types??
>
> Sololy relying on compat properties to detect device compatibility is also
> not reliable.  For example, see VMStateField.field_exists() or similarly,
> VMStateDescription.needed(), which are hooks that device can provide to
> dynamically decide what device state to be saved/loaded.  Such things are
> not reflected in compat properties, so even if compat properties of all
> devices are the same between two machine types, it may not mean that the
> migration stream will always be compatible.
>
> Thanks,

In fact, the last commit describes the meaning of this series best. Perhaps
it should have been moved to the cover letter:
Often, many teams have their own "machines" inherited from "upstream" to
manage default values of devices. This is done because of the limitations
imposed by the compatibility requirements or the desire to help their
customers better configure their devices. And since machine type has
a hard-to-read structure, it is very easy to make a mistake when 
transferring
default values from one machine to another. For example, when some property
is set for the entire abstract class x86_64-cpu (which will be applied 
to all
models), and then rolled back for a specific model. The situation is about
the same with changing the default values of devices: if the value changes
in the description of the device itself, then you need to make sure that
nothing changes when using the current machine.
Therefore, there was a desire to make a dev tool that will help quickly 
expand
the definition of a machine or compare several machines from different 
binary
files. It can be used when rebasing to a new version of qemu and/or for
automatic tests.

-- 
Best regards,
Maksim Davydov

--------------NVL33SzOfUKvq6j1zcFrpuy6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/6/24 04:57, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZefNfJ3BwudA-M7t@x1n">
      <pre class="moz-quote-pre" wrap="">On Tue, Mar 05, 2024 at 03:43:41PM +0100, Markus Armbruster wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Peter Maydell <a class="moz-txt-link-rfc2396E" href="mailto:peter.maydell@linaro.org">&lt;peter.maydell@linaro.org&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, 4 Mar 2024 at 13:52, Maksim Davydov <a class="moz-txt-link-rfc2396E" href="mailto:davydov-max@yandex-team.ru">&lt;davydov-max@yandex-team.ru&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:

  Merge tag 'pull-request-2024-03-01' of <a class="moz-txt-link-freetext" href="https://gitlab.com/thuth/qemu">https://gitlab.com/thuth/qemu</a> into staging (2024-03-01 10:14:32 +0000)

are available in the Git repository at:

  <a class="moz-txt-link-freetext" href="https://gitlab.com/davydov-max/qemu.git">https://gitlab.com/davydov-max/qemu.git</a> tags/pull-compare-mt-2024-03-04

for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:

  scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)

----------------------------------------------------------------
Please note. This is the first pull request from me.
My public GPG key is available here
<a class="moz-txt-link-freetext" href="https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4">https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4</a>

----------------------------------------------------------------
scripts: add a new script for machine development

----------------------------------------------------------------
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Hi; I would prefer this to go through some existing submaintainer
tree if possible, please.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yeah this seems like migration relevant.. however now I'm slightly confused
on when this script should be useful.

According to:

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/">https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/</a>

        This script runs QEMU to obtain compat_props of machines and
        default values of different types of drivers to produce comparison
        table. This table can be used to compare machine types to choose
        the most suitable machine or compare binaries to be sure that
        migration to the newer version will save all device
        properties. Also the json or csv format of this table can be used
        to check does a new machine affect the previous ones by comparing
        tables with and without the new machine.

In regards to "choose the most suitable machine": why do you need to choose
a machine?

If it's pretty standalone setup, shouldn't we always try to use the latest
machine type if possible (as normally compat props are only used to keep
compatible with old machine types, and the default should always be
preferred). If it's a cluster setup, IMHO it should depend on the oldest
QEMU version that plans to be supported.  I don't see how such comparison
helps yet in either of the cases..

In regards to "compare binaries to be sure that migration to the newer
version will save all device properties": do we even support migrating
_between_ machine types??

Sololy relying on compat properties to detect device compatibility is also
not reliable.  For example, see VMStateField.field_exists() or similarly,
VMStateDescription.needed(), which are hooks that device can provide to
dynamically decide what device state to be saved/loaded.  Such things are
not reflected in compat properties, so even if compat properties of all
devices are the same between two machine types, it may not mean that the
migration stream will always be compatible.

Thanks,
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap"><font face="monospace">In fact, the last commit describes the meaning of this series best. Perhaps</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">it should have been moved to the cover letter:</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">Often, many teams have their own "machines" inherited from "upstream" to</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">manage default values of devices. This is done because of the limitations</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">imposed by the compatibility requirements or the desire to help their</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">customers better configure their devices. And since machine type has</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">a hard-to-read structure, it is very easy to make a mistake when transferring</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">default values from one machine to another. For example, when some property</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">is set for the entire abstract class x86_64-cpu (which will be applied to all</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">models), and then rolled back for a specific model. The situation is about</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">the same with changing the default values of devices: if the value changes</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">in the description of the device itself, then you need to make sure that</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">nothing changes when using the current machine.</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">Therefore, there was a desire to make a dev tool that will help quickly expand</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">the definition of a machine or compare several machines from different binary</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">files. It can be used when rebasing to a new version of qemu and/or for</font></span><br>
      <span style="white-space: pre-wrap"><font face="monospace">automatic tests.</font></span><br>
      <span style="white-space: pre-wrap"></span></p>
    <span style="white-space: pre-wrap">
</span>
    <pre class="moz-signature" cols="72">-- 
Best regards,
Maksim Davydov</pre>
  </body>
</html>

--------------NVL33SzOfUKvq6j1zcFrpuy6--

