Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CB1CF11F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt5w-0004SK-80; Thu, 10 Oct 2024 09:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1syt5p-0004Os-LT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:20:37 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1syt5m-0000Na-TH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:20:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0CEEF609D6;
 Thu, 10 Oct 2024 16:20:25 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a408::1:13] (unknown
 [2a02:6b8:b081:a408::1:13])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MKjYIc0IkW20-IT10Afi5; Thu, 10 Oct 2024 16:20:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1728566424;
 bh=PiFzHf2MOgd7KXzYc4/O+2V3oMizwL0AO7/UdY+Motg=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=qCyxtgV2SjdFUaDPllBSIiJnBN4xZLhJVyoWzbql7H/x3YC9RuPKJc2DOBa86nWoF
 qdUngDnf3gC21y94aAWIh0vcRhurezXQBmNka7U7KSWYDhIvQ4rRet/JLxfa1c+ue0
 sW1Bb/OJ+OYuqMDb/y/ubkVv0lnr83Q7Yk98iLQY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------P2FywPgBrskyX7ElxuEgwyJD"
Message-ID: <4701f00c-4cea-4817-b11d-3f13440ab1ca@yandex-team.ru>
Date: Thu, 10 Oct 2024 16:20:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Peter Krempa <pkrempa@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <20240913094604.269135-1-d-tatianin@yandex-team.ru>
 <fa326630-8304-4700-9995-d98287356c1f@yandex-team.ru>
 <CAJ+F1CJuReS0R08QvWfgeDeDN8xD+=xYWrybBEDONvo5H-HtHQ@mail.gmail.com>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <CAJ+F1CJuReS0R08QvWfgeDeDN8xD+=xYWrybBEDONvo5H-HtHQ@mail.gmail.com>
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
--------------P2FywPgBrskyX7ElxuEgwyJD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/24 11:32 AM, Marc-André Lureau wrote:

> Hi Vladimir
>
> On Mon, Sep 30, 2024 at 5:17 PM Vladimir Sementsov-Ogievskiy 
> <vsementsov@yandex-team.ru> wrote:
>
>     Hi Mark-Andre!
>
>     Could you please take a look? We have collected acks for QAPI
>     changes, could this be queued?
>
>
> While writing to 9.2 changelog, I realize that we should probably have 
> addressed a few more things:
> - change -netdev stream to use reconnect-ms too, for consistency
> - update the qemu documentation to use reconnect-ms
> - update code and tests to use reconnect-ms
> Could you look at it? thanks

Hi!

No problem, I'll take a look at those as well. I'll have some time after 
next week.

Thanks!

>
>     On 13.09.24 12:46, Daniil Tatianin wrote:
>     > The 'reconnect' option only allows to specify the time in seconds,
>     > which is way too long for certain workflows.
>     >
>     > We have a lightweight disk backend server, which takes about 20ms to
>     > live update, but due to this limitation in QEMU, previously the
>     guest
>     > disk controller would hang for one second because it would take this
>     > long for QEMU to reinitialize the socket connection.
>     >
>     > Introduce a new option called 'reconnect-ms', which is the same as
>     > 'reconnect', except the value is treated as milliseconds. These are
>     > mutually exclusive and specifying both results in an error.
>     >
>     > 'reconnect' is also deprecated by this commit to make it possible to
>     > remove it in the future as to not keep two options that control the
>     > same thing.
>     >
>     > Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
>     > Acked-by: Peter Krempa<pkrempa@redhat.com>
>     > Signed-off-by: Daniil Tatianin<d-tatianin@yandex-team.ru>
>
>     -- 
>     Best regards,
>     Vladimir
>
>
>
>
> -- 
> Marc-André Lureau
--------------P2FywPgBrskyX7ElxuEgwyJD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 10/10/24 11:32 AM, Marc-André Lureau wrote:</p>
    <blockquote type="cite"
cite="mid:CAJ+F1CJuReS0R08QvWfgeDeDN8xD+=xYWrybBEDONvo5H-HtHQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">Hi Vladimir<br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Sep 30, 2024 at
            5:17 PM Vladimir Sementsov-Ogievskiy &lt;<a
              href="mailto:vsementsov@yandex-team.ru"
              moz-do-not-send="true" class="moz-txt-link-freetext">vsementsov@yandex-team.ru</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi
            Mark-Andre!<br>
            <br>
            Could you please take a look? We have collected acks for
            QAPI changes, could this be queued?<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>While writing to 9.2 changelog, I realize that we should
            probably have addressed a few more things:</div>
          <div>- change -netdev stream to use reconnect-ms too, for
            consistency<br>
          </div>
          <div>- update the qemu documentation to use reconnect-ms</div>
          <div>- update code and tests to use reconnect-ms<br>
          </div>
          <div> </div>
          <div>Could you look at it? thanks<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Hi!<br>
      <br>
      No problem, I'll take a look at those as well. I'll have some time
      after next week.<br>
      <br>
      Thanks!<br>
    </p>
    <blockquote type="cite"
cite="mid:CAJ+F1CJuReS0R08QvWfgeDeDN8xD+=xYWrybBEDONvo5H-HtHQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            On 13.09.24 12:46, Daniil Tatianin wrote:<br>
            &gt; The 'reconnect' option only allows to specify the time
            in seconds,<br>
            &gt; which is way too long for certain workflows.<br>
            &gt; <br>
            &gt; We have a lightweight disk backend server, which takes
            about 20ms to<br>
            &gt; live update, but due to this limitation in QEMU,
            previously the guest<br>
            &gt; disk controller would hang for one second because it
            would take this<br>
            &gt; long for QEMU to reinitialize the socket connection.<br>
            &gt; <br>
            &gt; Introduce a new option called 'reconnect-ms', which is
            the same as<br>
            &gt; 'reconnect', except the value is treated as
            milliseconds. These are<br>
            &gt; mutually exclusive and specifying both results in an
            error.<br>
            &gt; <br>
            &gt; 'reconnect' is also deprecated by this commit to make
            it possible to<br>
            &gt; remove it in the future as to not keep two options that
            control the<br>
            &gt; same thing.<br>
            &gt; <br>
            &gt; Reviewed-by: Vladimir Sementsov-Ogievskiy&lt;<a
              href="mailto:vsementsov@yandex-team.ru" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">vsementsov@yandex-team.ru</a>&gt;<br>
            &gt; Acked-by: Peter Krempa&lt;<a
              href="mailto:pkrempa@redhat.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">pkrempa@redhat.com</a>&gt;<br>
            &gt; Signed-off-by: Daniil Tatianin&lt;<a
              href="mailto:d-tatianin@yandex-team.ru" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">d-tatianin@yandex-team.ru</a>&gt;<br>
            <br>
            -- <br>
            Best regards,<br>
            Vladimir<br>
            <br>
            <br>
          </blockquote>
        </div>
        <br clear="all">
        <br>
        <span class="gmail_signature_prefix">-- </span><br>
        <div dir="ltr" class="gmail_signature">Marc-André Lureau<br>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------P2FywPgBrskyX7ElxuEgwyJD--

