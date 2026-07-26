Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96941C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyCJ-0006QU-SA; Sun, 26 Jul 2026 08:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1wnyCC-0006Q5-Hf
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:43:10 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1wnyCA-000586-5t
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:43:08 -0400
Received: from [192.168.178.180] (pd9ec331b.dip0.t-ipconnect.de
 [217.236.51.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 2D3C0DA04C7;
 Sun, 26 Jul 2026 14:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1785069780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LLHxYhn16U17uUzCArJOGljAUuD7X8MqBrn3xOXADHY=;
 b=I5pUgcrPfiEEUykiCW/scoRiitSLisV+47EzWWuoubYSIbAXfoDS/H7WrrKmfEW1Nik1sY
 AZgn40wZ3eK3FF/THVKtDKWHdWygdh8BiLGch4zOq+EH3ZIGs8mRan5Hx5gi1WgVd5127P
 Y+F9zOCcj4geOEIJVfyfswoYwbrVQgg=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de smtp.mailfrom=sw@weilnetz.de
Content-Type: multipart/alternative;
 boundary="------------IUc0ftVnRqJEXqNOJRJC5PuV"
Message-ID: <444dfa34-508a-4679-b8cb-01e902879b39@weilnetz.de>
Date: Sun, 26 Jul 2026 14:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/oslib-win32: Implement qemu_get_pid_name()
To: Evgeny <randomjack94dev@gmail.com>, qemu-devel@nongnu.org
References: <20260621130626.19073-1-randomjack94dev@gmail.com>
 <CAFvcSaTjtztrJvc72e8i3gaGcfhkBVEVURJZxvSsHtpuA987kw@mail.gmail.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <CAFvcSaTjtztrJvc72e8i3gaGcfhkBVEVURJZxvSsHtpuA987kw@mail.gmail.com>
X-Rspamd-Queue-Id: 2D3C0DA04C7
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 12.00]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+,1:+,2:~];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:3320, ipnet:217.224.0.0/11, country:DE];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: v2201612906741603
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------IUc0ftVnRqJEXqNOJRJC5PuV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.07.26 um 12:18 schrieb Evgeny:

> ping
>
> https://patchew.org/QEMU/20260621130626.19073-1-randomjack94dev@gmail.com/
> https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05258.html
>
> On Sun, Jun 21, 2026 at 4:08 PM Evgeny Kolmakov 
> <randomjack94dev@gmail.com> wrote:
>
>     Replace the abort() stub with a proper implementation using
>     QueryFullProcessImageNameW() and g_utf16_to_utf8() to retrieve
>     the process executable name on Windows. Returns NULL on error
>     to match POSIX behavior.
>
>     Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
>     ---
>      util/oslib-win32.c | 19 +++++++++++++++++--
>      1 file changed, 17 insertions(+), 2 deletions(-)
>
>     diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>     index 5f3e8f4d98..2b083b5d7a 100644
>     --- a/util/oslib-win32.c
>     +++ b/util/oslib-win32.c
>     @@ -287,8 +287,23 @@ bool qemu_finish_async_prealloc_mem(Error **errp)
>
>      char *qemu_get_pid_name(pid_t pid)
>      {
>     -    /* XXX Implement me */
>     -    abort();
>     +    HANDLE hProcess;
>     +    WCHAR path[4096];
>

Would it be better to dynamically allocate the maximum path length (32768)?


>     +    DWORD size = G_N_ELEMENTS(path);
>     +    char *name = NULL;
>     +
>     +    hProcess = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION,
>     FALSE, (DWORD)pid);
>     +    if (!hProcess) {
>     +        return NULL;
>     +    }
>     +
>     +    if (QueryFullProcessImageNameW(hProcess, 0, path, &size)) {
>     +        const WCHAR *base = wcsrchr(path, L'\\');
>     +        name = g_utf16_to_utf8(base ? base + 1 : path, -1, NULL,
>     NULL, NULL);
>

I think that base will never be NULL, so the code here could be simplified.


>     +    }
>     +
>     +    CloseHandle(hProcess);
>     +    return name;
>      }
>
>
>     -- 
>     2.43.0
>

Do you have a special use case which requires this implementation 
because it triggers the assertion otherwise?

Regards

Stefan Weil

--------------IUc0ftVnRqJEXqNOJRJC5PuV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Am 26.07.26 um 12:18 schrieb Evgeny:</p>
    <blockquote type="cite"
cite="mid:CAFvcSaTjtztrJvc72e8i3gaGcfhkBVEVURJZxvSsHtpuA987kw@mail.gmail.com">
      <div dir="ltr">ping<br>
        <br>
        <a
href="https://patchew.org/QEMU/20260621130626.19073-1-randomjack94dev@gmail.com/"
          moz-do-not-send="true" class="moz-txt-link-freetext">https://patchew.org/QEMU/20260621130626.19073-1-randomjack94dev@gmail.com/</a><br>
        <a
href="https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05258.html"
          moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05258.html</a></div>
      <br>
      <div class="gmail_quote gmail_quote_container">
        <div dir="ltr" class="gmail_attr">On Sun, Jun 21, 2026 at
          4:08 PM Evgeny Kolmakov &lt;<a
            href="mailto:randomjack94dev@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">randomjack94dev@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote">Replace the abort() stub with a
          proper implementation using<br>
          QueryFullProcessImageNameW() and g_utf16_to_utf8() to retrieve<br>
          the process executable name on Windows. Returns NULL on error<br>
          to match POSIX behavior.<br>
          <br>
          Signed-off-by: Evgeny Kolmakov &lt;<a
            href="mailto:randomjack94dev@gmail.com" target="_blank"
            moz-do-not-send="true" class="moz-txt-link-freetext">randomjack94dev@gmail.com</a>&gt;<br>
          ---<br>
           util/oslib-win32.c | 19 +++++++++++++++++--<br>
           1 file changed, 17 insertions(+), 2 deletions(-)<br>
          <br>
          diff --git a/util/oslib-win32.c b/util/oslib-win32.c<br>
          index 5f3e8f4d98..2b083b5d7a 100644<br>
          --- a/util/oslib-win32.c<br>
          +++ b/util/oslib-win32.c<br>
          @@ -287,8 +287,23 @@ bool qemu_finish_async_prealloc_mem(Error
          **errp)<br>
          <br>
           char *qemu_get_pid_name(pid_t pid)<br>
           {<br>
          -    /* XXX Implement me */<br>
          -    abort();<br>
          +    HANDLE hProcess;<br>
          +    WCHAR path[4096];<br>
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Would it be better to dynamically allocate the maximum path
      length (32768)?</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAFvcSaTjtztrJvc72e8i3gaGcfhkBVEVURJZxvSsHtpuA987kw@mail.gmail.com">
      <div class="gmail_quote gmail_quote_container">
        <blockquote class="gmail_quote">+    DWORD size =
          G_N_ELEMENTS(path);<br>
          +    char *name = NULL;<br>
          +<br>
          +    hProcess = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION,
          FALSE, (DWORD)pid);<br>
          +    if (!hProcess) {<br>
          +        return NULL;<br>
          +    }<br>
          +<br>
          +    if (QueryFullProcessImageNameW(hProcess, 0, path,
          &amp;size)) {<br>
          +        const WCHAR *base = wcsrchr(path, L'\\');<br>
          +        name = g_utf16_to_utf8(base ? base + 1 : path, -1,
          NULL, NULL, NULL);<br>
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I think that base will never be NULL, so the code here could be
      simplified.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAFvcSaTjtztrJvc72e8i3gaGcfhkBVEVURJZxvSsHtpuA987kw@mail.gmail.com">
      <div class="gmail_quote gmail_quote_container">
        <blockquote class="gmail_quote">+    }<br>
          +<br>
          +    CloseHandle(hProcess);<br>
          +    return name;<br>
           }<br>
          <br>
          <br>
          -- <br>
          2.43.0</blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Do you have a special use case which requires this implementation
      because it triggers the assertion otherwise?</p>
    <p>Regards</p>
    <p>Stefan Weil</p>
  </body>
</html>

--------------IUc0ftVnRqJEXqNOJRJC5PuV--

