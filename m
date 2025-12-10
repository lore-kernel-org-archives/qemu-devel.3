Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0E7D3E768
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOSn-00082f-JX; Wed, 10 Dec 2025 12:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vTOSm-00081Y-7E
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:58:56 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vTOSi-0007kx-VC
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:58:55 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so35740fac.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 09:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1765389531; x=1765994331; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWqKb2hzP2YD+8r/qQtjCFHcKaIocN5VHwSLyi5fvpo=;
 b=AGdFkfciOtT5Uu/mglcVCC+uTe64wQ9S867GhEKAjMWBbIDtEHUbk4CfZdpAGCelcL
 z1E7eyIo0QuIRpVzdvRsvH1/D2fOASdWqPFPWyXzARbPqVODDCU6Z+FfdXZBL2INTv+2
 /hO0F/p+lRjh37OIMNRXg2NEBvSxohi+vG5bC/3adjWihc89nhfTGkmHlqIEy56Uu6Yw
 0O6rTU79v6hRY5rKvfyG9FM2ho8y19ad+6QJM17+y7JDLz02OwII1RnqITVBVhLu3JGe
 Q+6gW7mJUqy2uu9Ok94nnza+EMwoZdvg9AUKOi+4hC2vbWEXE2hba9N7W8osLEQkDB1Z
 6zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765389531; x=1765994331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rWqKb2hzP2YD+8r/qQtjCFHcKaIocN5VHwSLyi5fvpo=;
 b=Uonm5TyIUW6Yv1kFKQyLTATSZisk+IUFzRgyLxskyiA5+HXYiUk06+ISLv2J81AaIo
 Yx5uRM+j73OAWTAT5uv4NVNs8UcmSutl3MB+N1MfO6X4vYoURsBNZBEkS1ZGqCTow9J1
 m0vOdyDaSnMihDBuTnk0rtVp8wkHqthnpsH8bSTAWlv/lw73HMCDUgVWp/UN6rcLobZ2
 YF6YnSo5F6xq3VifaEVEcp57qWm9Ye65spOo2ub4jERa+CZWk1ik8FKlbdQrm6TXZetB
 h0TuYyyNVKR/F0tt0Jz39RqaaCXN7Nu1URpC8GFC1dMhWmmEQqQYgLyn6EZYo1Xcz90L
 350A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbAhdBs4gDPfU1ZnODyOFEqjHIJZzrYHsXinhJ65xXo1FZZaMmXcPS5Zd9GeIUy4bRKCeaLn31525P@nongnu.org
X-Gm-Message-State: AOJu0YzKUYqCbOmnhXVE+I0mxvNt+fhrN9hqyHqVs+p/9/k3TJQLbI8g
 7Zb1em7sDpuRnhUOIMpUAXVxdThttlJMsWffHJZPOYOTwTP0u7cdNF1gC/9BvYWaDWcAKruToNW
 WOaehK9V2hZMy9AzftKPOvrUtOrcHs4V0REl/nqVpWg==
X-Gm-Gg: AY/fxX5BHPxda2kBu4sSGXoRdA9ghmyr0+ap6VMrrcQG1D7wlmLGGI3I4vm2xsoZjUd
 pmfrCWsNE255AkGRTqYU7EGvP1HZr3Ik6Dfxs11WiG8/vzurfWuLomWXYF7T8ERNzsMsIM2gSlX
 4s1UpDMFiYSxY17Fvcped88Pf2T16GsKoo7X5gI4LsmaGJCH5x+849yVPcccc162OsZviL1uGQG
 ogyMDMj9cxCnQH/snR/HIL0AWc7+AKUsb+ncSLTx+Si/WID1YJEG2sl5v5/9FlL7FiVWdxi
X-Google-Smtp-Source: AGHT+IHsyjQYujZueje6Ri8EQzqRVOAkV1UMDOJYYbTe61Ib61NZCbRGK3BeY9UtrjtdoxwonzP141snlkjE6YyNyJc=
X-Received: by 2002:a05:6870:8587:b0:321:2772:dd9 with SMTP id
 586e51a60fabf-3f5bd96fd31mr2043152fac.12.1765389531249; Wed, 10 Dec 2025
 09:58:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
 <20251209022028-mutt-send-email-mst@kernel.org> <aTfpQO14axEvcOIT@redhat.com>
 <CAJ7pxeYbd+yq9VXob2zTShBd5Ph598kmjLJTsKdKzFikCbVLLA@mail.gmail.com>
 <aTmlzlAWK8BcGaEp@redhat.com>
In-Reply-To: <aTmlzlAWK8BcGaEp@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 10 Dec 2025 17:58:40 +0000
X-Gm-Features: AQt7F2p6tsQFHKnsXtdAx3cbNgVZL-_r4ghNli7bT3olUqwZunnxjvyhLoO3SY8
Message-ID: <CAJ7pxebQnOYkMyFUwucn+VL-xasJ559SjcONtAYw+NvfZkd-fQ@mail.gmail.com>
Subject: Re: FWD: [ATTENTION] Mails on qemu mailing list are disapapearing
 making communication unreliable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>, 
 Vishnu Pajjuri OS <vishnu@os.amperecomputing.com>, 
 Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ATTENTION=0.5 autolearn=no autolearn_force=no
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

Hi Daniel,

Many thanks for your reply.

On Wed, Dec 10, 2025 at 4:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Dec 10, 2025 at 01:20:26AM +0000, Salil Mehta wrote:
> > Hi Daniel & Michael,
> >
> > Many thanks for replying.
> >
> > On Tue, Dec 9, 2025 at 9:18=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > >
> > > On Tue, Dec 09, 2025 at 02:24:44AM -0500, Michael S. Tsirkin wrote:
> > > > Hi guys,
> > > > who has ability to contact the list admins? Can help Salil?
> > >
> > > I'm not a list admin, but I have some observations below
> > >
> > > > ----- Forwarded message from Salil Mehta <salil.mehta@opnsrc.net> -=
----
> > > >
> > > > From: Salil Mehta <salil.mehta@opnsrc.net>
> > > > Date: Tue, 9 Dec 2025 00:44:04 +0000
> > > > To: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Subject: [ATTENTION] Mails on qemu mailing list are disapapearing m=
aking communication unreliable
> > > > Message-ID: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@ma=
il.gmail.com>
> > > >
> > > > Hi Michael,
> > > >
> > > > I hope you are doing well.
> > > >
> > > > I=E2=80=99ve noticed that some emails are going missing from the qe=
mu-devel mailing
> > > > list. This has now happened multiple times, both with emails I have=
 sent from my
> > > > official address and with emails from other contributors.
> > > >
> > > > Over the past three months, I have consistently observed emails dis=
appearing
> > > > from the qemu-devel archives, which makes the mailing list communic=
ation highly
> > > > unreliable.
> > >
> > > I can see patches arriving in my INBOX via qemu-devel from salil.meht=
a@opnsrc.net
> > > but no patches from salil.mehta@huawei.com
> > >
> > > I do see some (non-patch) emails from salil.mehta@huawei.com, but the
> > > mailing list is re-writing this From address for DMARC countermeasure=
s
> > >
> > >  Salil Mehta via <qemu-devel@nongnu.org>
> > >
> > >
> > > Recapping mail delivery policies, DMARC requires a pass for *either*
> > > SPF or DKIM checks.
> > >
> > > SPF checks will always fail for mails forwarded via any mailing list.
> > >
> > > DKIM checks should still succeed *provided* the mailing list does not
> > > modify the message content, or certain headers. QEMU mailing list
> > > behaves in this respect generally, and applies countermeasures when
> > > appropriate.
> > >
> > > I see no  DKIM records huawei.com, but I do see SPF records.
> >
> >
> > Thanks for identifying this.
> >
> > When you say there are no DKIM records for huawei.com, do you mean
> > that my @huawei.com mails do not contain any DKIM-Signature header,
> > or that a DKIM-Signature is present but cannot be validated against
> > a published key?
>
> I see no DKIM-Signature, and not DKIM DNS records with the
> default selector.

This is definitely a problem then =E2=80=94 thank you for checking that so
clearly.

I=E2=80=99m still trying to get a hold of our IT team, and I=E2=80=99ll sha=
re this
information with them so they can look into enabling DKIM
properly for @huawei.com. Once I hear back from them or have any
concrete update, I=E2=80=99ll report it here so others aren=E2=80=99t hit b=
y the
same issue.

Many thanks again for your help.


>
> > If there are SPF/DKIM/DMARC logs on the list side, would it be
> > possible to see whether DKIM validation is failing for my messages?
>
> We have no access to anything in the mailman service - we're just
> using the nongnu.org service for QEMU, run by the GNU project.

Understood, thanks for clarifying.

If you happen to know who maintains the nongnu.org Mailman service,
or where I should direct questions about mail logs and DMARC handling,
a pointer would be very helpful.

>
> > > This guarantees DMARC fail for any @huawei.com sender using any maili=
ng
> > > list, however, the @huawei.com DMARC policy is only set to 'quarantin=
e'.
> >
> > Agreed. I will check with the IT department here about the DKIM
> > headers and whether the public key is being published correctly.
>
> I should have checked before, but I see there are other people
> using @huawei.com email addresses that are posting to qemu-devel
> successfully.

Yes, that matches my observation as well. Messages from my
@huawei.com address do sometimes reach qemu-devel, but others
(particularly some patch series) appear to vanish. A couple of
colleagues have also mentioned similar intermittent issues in the
past, although it now seems to be affecting me more consistently.

What makes this confusing is that I have been using the same
git-send-email configuration and the same Outlook setup as before,
and earlier mails sent with these settings are present in the
qemu-devel archives. This suggests that something in the delivery
path, authentication checks, or domain policy may have changed
recently, even if not all @huawei.com senders are impacted in the
same way.

I am following up with our IT/mail team about DKIM and the correct
SMTP relay configuration for mailing lists. If it is easy to see
from the list side whether my recent missing patch mails were
rejected or filtered due to SPF/DMARC (as opposed to never
arriving at all), that information would be very helpful for that
discussion.

Many thanks again for your help in digging into this.

>
> That seems to suggest that the huawei mail is able to work with
> QEMU lists and nothing about SPF/DKIM/DMARC is a blocking problem
>
> > > I wonder how Salil is sending patches ? Some tool like git send-email
> > > or git-publish ?
> >
> > Mails disappear or not appear in the mailing list even when I reply
> > via outlook and the same happens when I sometimes use git-send-mail.
> >
> > check these:
> > https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta=
@opnsrc.net/
> >
> > AND
> >
> > https://lore.kernel.org/qemu-devel/CAJ7pxea721f4EwqpDdcztgRoN-rsB2tqthf=
-_Kb+mmsRkK1GyQ@mail.gmail.com/
> >
> > I'm replying to this broken link which existed but disappeared later.
> >  [not found] <20250930224037.224833-1-salil.mehta@huawei.com>
>
>
> > > If not, perhaps that is triggering some rule that discards the mails =
when
> > > sending is amperemail.onmicrosoft.com
> >
> > Could be. Do we have access to the logs to verify the reason?
>
> Unfortunately we have no insight into operation of the mailman service
> as that's not run by QEMU.

Got it, thanks for clarifying.

If you happen to know who is responsible for administering the
mailman service or whom I should contact to request more detailed
mail logs, that would be very helpful.

Many thanks!

Best regards,
Salil

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

