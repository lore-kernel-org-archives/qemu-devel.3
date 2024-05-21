Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1430FC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KYd-0003no-Aq; Tue, 21 May 2024 04:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s9KYb-0003kI-3e
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:09:13 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s9KYW-00029U-73
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:09:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CD0F460DFA;
 Tue, 21 May 2024 11:08:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8819::1:2] (unknown
 [2a02:6b8:b081:8819::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id w8EiRI0IX8c0-6FbcCN5t; Tue, 21 May 2024 11:08:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716278939;
 bh=ogL4sPHQ1vQtGe9bM/tUAqaIGQSY1xgr5opXqD4TyjY=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=vk2QP3fsm153jQWAa6wXIy+C1SNzp9jhUYMZnzuW0OsoQYjJxw8l4wzuX/XFjAC5d
 OCoKP/Edq52OTf2nwXCxn4pZ62pcpQpV0drIrfYWMKBx2DZsYTN8Ctz0kipe2CE1rW
 bip5DicFkOp5cwXPjVNSqLv4bk9hCViJS1tgL6D8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------Tx18aKqxZjxsn032mmmSvseW"
Message-ID: <42ad8fe7-0de8-4284-9d37-ff6b5f66acdf@yandex-team.ru>
Date: Tue, 21 May 2024 11:08:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mc146818rtc: add a way to generate RTC interrupts via
 QMP
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240506083420.557726-1-d-tatianin@yandex-team.ru>
 <123481715669864@mail.yandex-team.ru>
Content-Language: en-US
In-Reply-To: <123481715669864@mail.yandex-team.ru>
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------Tx18aKqxZjxsn032mmmSvseW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Could you please take a look at this revision? I think I've taken 
everyone's feedback into account.

Thank you!

On 5/14/24 9:57 AM, Daniil Tatianin wrote:
> ping :)
> 06.05.2024, 11:34, "Daniil Tatianin" <d-tatianin@yandex-team.ru>:
>
>     This can be used to force-synchronize the time in guest after a long
>     stop-cont pause, which can be useful for serverless-type workload.
>
>     Also add a comment to highlight the fact that this (and one other QMP
>     command) only works for the MC146818 RTC controller.
>
>     Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>     ---
>
>     Changes since v0:
>     - Rename to rtc-inject-irq to match other similar API
>     - Add a comment to highlight that this only works for the I386 RTC
>
>     Changes since v1:
>     - Added a description below the QMP command to explain how it can be
>       used and what it does.
>
>     Changes since v2:
>     - Add a 'broadcast' suffix.
>     - Change the comments to explain the flags we're setting.
>     - Change the command description to fix styling & explain that
>     it's a broadcast command.
>
>     ---
>      hw/rtc/mc146818rtc.c | 20 ++++++++++++++++++++
>      include/hw/rtc/mc146818rtc.h | 1 +
>      qapi/misc-target.json | 19 +++++++++++++++++++
>      3 files changed, 40 insertions(+)
>
>     diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>     index 3379f92748..2b3754f5c6 100644
>     --- a/hw/rtc/mc146818rtc.c
>     +++ b/hw/rtc/mc146818rtc.c
>     @@ -107,6 +107,11 @@ static void
>     rtc_coalesced_timer_update(MC146818RtcState *s)
>      static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>          QLIST_HEAD_INITIALIZER(rtc_devices);
>
>     +/*
>     + * NOTE:
>     + * The two QMP functions below are _only_ implemented for the
>     MC146818.
>     + * All other RTC devices ignore this.
>     + */
>      void qmp_rtc_reset_reinjection(Error **errp)
>      {
>          MC146818RtcState *s;
>     @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>          }
>      }
>
>     +void qmp_rtc_inject_irq_broadcast(Error **errp)
>     +{
>     + MC146818RtcState *s;
>     +
>     + QLIST_FOREACH(s, &rtc_devices, link) {
>     + // Update-ended interrupt enable
>     + s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>     +
>     + // Interrupt request flag | update interrupt flag
>     + s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>     +
>     + qemu_irq_raise(s->irq);
>     + }
>     +}
>     +
>      static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>      {
>          kvm_reset_irq_delivered();
>     diff --git a/include/hw/rtc/mc146818rtc.h
>     b/include/hw/rtc/mc146818rtc.h
>     index 97cec0b3e8..e9dd0f9c72 100644
>     --- a/include/hw/rtc/mc146818rtc.h
>     +++ b/include/hw/rtc/mc146818rtc.h
>     @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus,
>     int base_year,
>      void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int
>     val);
>      int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>      void qmp_rtc_reset_reinjection(Error **errp);
>     +void qmp_rtc_inject_irq_broadcast(Error **errp);
>
>      #endif /* HW_RTC_MC146818RTC_H */
>     diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>     index 4e0a6492a9..7d388a3753 100644
>     --- a/qapi/misc-target.json
>     +++ b/qapi/misc-target.json
>     @@ -19,6 +19,25 @@
>      { 'command': 'rtc-reset-reinjection',
>        'if': 'TARGET_I386' }
>
>     +##
>     +# @rtc-inject-irq-broadcast:
>     +#
>     +# Inject an RTC interrupt for all existing RTCs on the system.
>     +# The interrupt forces the guest to synchronize the time with RTC.
>     +# This is useful after a long stop-cont pause, which is common for
>     +# serverless-type workload.
>     +#
>     +# Since: 9.1
>     +#
>     +# Example:
>     +#
>     +# -> { "execute": "rtc-inject-irq-broadcast" }
>     +# <- { "return": {} }
>     +#
>     +##
>     +{ 'command': 'rtc-inject-irq-broadcast',
>     + 'if': 'TARGET_I386' }
>     +
>      ##
>      # @SevState:
>      #
>
>     --
>     2.34.1
>
--------------Tx18aKqxZjxsn032mmmSvseW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Could you please take a look at this revision? I think I've taken
    everyone's feedback into account.<br>
    <br>
    Thank you!<br>
    <br>
    <div class="moz-cite-prefix">On 5/14/24 9:57 AM, Daniil Tatianin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:123481715669864@mail.yandex-team.ru">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div>ping :)</div>
      <div> </div>
      <div>06.05.2024, 11:34, "Daniil Tatianin"
        <a class="moz-txt-link-rfc2396E" href="mailto:d-tatianin@yandex-team.ru">&lt;d-tatianin@yandex-team.ru&gt;</a>:</div>
      <blockquote>
        <p>This can be used to force-synchronize the time in guest after
          a long<br>
          stop-cont pause, which can be useful for serverless-type
          workload.<br>
          <br>
          Also add a comment to highlight the fact that this (and one
          other QMP<br>
          command) only works for the MC146818 RTC controller.<br>
          <br>
          Signed-off-by: Daniil Tatianin &lt;<a
            href="mailto:d-tatianin@yandex-team.ru"
            rel="noopener noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">d-tatianin@yandex-team.ru</a>&gt;<br>
          ---<br>
          <br>
          Changes since v0:<br>
          - Rename to rtc-inject-irq to match other similar API<br>
          - Add a comment to highlight that this only works for the I386
          RTC<br>
          <br>
          Changes since v1:<br>
          - Added a description below the QMP command to explain how it
          can be<br>
            used and what it does.<br>
          <br>
          Changes since v2:<br>
          - Add a 'broadcast' suffix.<br>
          - Change the comments to explain the flags we're setting.<br>
          - Change the command description to fix styling &amp; explain
          that it's a broadcast command.<br>
          <br>
          ---<br>
           hw/rtc/mc146818rtc.c | 20 ++++++++++++++++++++<br>
           include/hw/rtc/mc146818rtc.h | 1 +<br>
           qapi/misc-target.json | 19 +++++++++++++++++++<br>
           3 files changed, 40 insertions(+)<br>
          <br>
          diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c<br>
          index 3379f92748..2b3754f5c6 100644<br>
          --- a/hw/rtc/mc146818rtc.c<br>
          +++ b/hw/rtc/mc146818rtc.c<br>
          @@ -107,6 +107,11 @@ static void
          rtc_coalesced_timer_update(MC146818RtcState *s)<br>
           static QLIST_HEAD(, MC146818RtcState) rtc_devices =<br>
               QLIST_HEAD_INITIALIZER(rtc_devices);<br>
           <br>
          +/*<br>
          + * NOTE:<br>
          + * The two QMP functions below are _only_ implemented for the
          MC146818.<br>
          + * All other RTC devices ignore this.<br>
          + */<br>
           void qmp_rtc_reset_reinjection(Error **errp)<br>
           {<!-- --><br>
               MC146818RtcState *s;<br>
          @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error
          **errp)<br>
               }<br>
           }<br>
           <br>
          +void qmp_rtc_inject_irq_broadcast(Error **errp)<br>
          +{<!-- --><br>
          + MC146818RtcState *s;<br>
          +<br>
          + QLIST_FOREACH(s, &amp;rtc_devices, link) {<!-- --><br>
          + // Update-ended interrupt enable<br>
          + s-&gt;cmos_data[RTC_REG_B] |= REG_B_UIE;<br>
          +<br>
          + // Interrupt request flag | update interrupt flag<br>
          + s-&gt;cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;<br>
          +<br>
          + qemu_irq_raise(s-&gt;irq);<br>
          + }<br>
          +}<br>
          +<br>
           static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)<br>
           {<!-- --><br>
               kvm_reset_irq_delivered();<br>
          diff --git a/include/hw/rtc/mc146818rtc.h
          b/include/hw/rtc/mc146818rtc.h<br>
          index 97cec0b3e8..e9dd0f9c72 100644<br>
          --- a/include/hw/rtc/mc146818rtc.h<br>
          +++ b/include/hw/rtc/mc146818rtc.h<br>
          @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus
          *bus, int base_year,<br>
           void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr,
          int val);<br>
           int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);<br>
           void qmp_rtc_reset_reinjection(Error **errp);<br>
          +void qmp_rtc_inject_irq_broadcast(Error **errp);<br>
           <br>
           #endif /* HW_RTC_MC146818RTC_H */<br>
          diff --git a/qapi/misc-target.json b/qapi/misc-target.json<br>
          index 4e0a6492a9..7d388a3753 100644<br>
          --- a/qapi/misc-target.json<br>
          +++ b/qapi/misc-target.json<br>
          @@ -19,6 +19,25 @@<br>
           { 'command': 'rtc-reset-reinjection',<br>
             'if': 'TARGET_I386' }<br>
           <br>
          +##<br>
          +# @rtc-inject-irq-broadcast:<br>
          +#<br>
          +# Inject an RTC interrupt for all existing RTCs on the
          system.<br>
          +# The interrupt forces the guest to synchronize the time with
          RTC.<br>
          +# This is useful after a long stop-cont pause, which is
          common for<br>
          +# serverless-type workload.<br>
          +#<br>
          +# Since: 9.1<br>
          +#<br>
          +# Example:<br>
          +#<br>
          +# -&gt; { "execute": "rtc-inject-irq-broadcast" }<br>
          +# &lt;- { "return": {} }<br>
          +#<br>
          +##<br>
          +{ 'command': 'rtc-inject-irq-broadcast',<br>
          + 'if': 'TARGET_I386' }<br>
          +<br>
           ##<br>
           # @SevState:<br>
           #</p>
        --<br>
        2.34.1<br>
         </blockquote>
    </blockquote>
  </body>
</html>

--------------Tx18aKqxZjxsn032mmmSvseW--

