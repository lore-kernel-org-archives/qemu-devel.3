Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E65FC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtuB5-0006NV-Oe; Mon, 08 Apr 2024 14:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1rtuB3-0006MY-IB
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1rtuB1-0006hu-E1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712602625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPbkqLAov835az6hD+Bi8avBSYssnFkrOP7tQUT+aJE=;
 b=P5dQpIHZkh+SoMENsXy1pKtm3BIDoJaTVE0cewGj6psbxnasMkDvGObcoRfgnFKw9oqcH4
 AAyJ+nnNI/JAg+xaxy5fI6+Foy1z0KmZZq0SskyaEh+6lQCTHXooHRHXFLciGa+7Ogv8xR
 BfWEEQxh5ibuLsnNytb9rZjmMHBHJo0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-6PxzQvggMdqbXxfsSlQMqA-1; Mon, 08 Apr 2024 14:57:02 -0400
X-MC-Unique: 6PxzQvggMdqbXxfsSlQMqA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6152848f192so16244427b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 11:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712602622; x=1713207422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rPbkqLAov835az6hD+Bi8avBSYssnFkrOP7tQUT+aJE=;
 b=nwsmomu3Nabogj0dfJcFJOjjXZyar4cqQYj+LfESU9D2nPHIVfzwcVoL2MTfKIx1bn
 SyQYNZ7lZQWYQ2s/+L6+y8IOVGgsaNKx9S7cVWZUVIvnlca04Mwn6TJipW2j9f9LH1PK
 KUbn49VSnuMuhGtHK/W5ON4ngVeakRhjO50zz0cDW8jmYaB6CyqxSZ4HXb2vvo4qaW1W
 eCaV9nC0Bm3vx//o0QgoiMRRlqwQ6pS8StpEDU63VoiDz/yQ37HZDr32iB0tjR0LQfD8
 9kAHHWAvsvdgZDFne1H0IPas+4D4jD3oLf5c/TwPf1HNVdqzY9ykYK4J/wnBpFy7wKlg
 73xg==
X-Gm-Message-State: AOJu0YwPdXKKqmoVFW4iNd9+pIROGYbC94PChhusX7BCEk9+f2KBZ5yC
 H2cRVSR6XTkVktWCfxEzbY582r916KvrcDaFuou03VuFRTv7cpmr4lvyQgBgmCGYKyM04Rn0roo
 SW0pX7p8CNH0MGj+VB3BT9j+jSvS9w5RkCyNs+FXTAc1ygVk+y805CLKL8LD6JXDSYas7JlTlj0
 v+6BspfORPVjC8Tsi/T7vLJ4zVa7A=
X-Received: by 2002:a81:af06:0:b0:618:1996:86e8 with SMTP id
 n6-20020a81af06000000b00618199686e8mr1804515ywh.3.1712602620373; 
 Mon, 08 Apr 2024 11:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKPyMLGYkeTIN9BEGxpdiBjjSq8lZ+5KCWT8Scp/veAJ1Ubg/XvjslxyY8hD0ZefYnYSpYVP5io1zAQDBt7Sw=
X-Received: by 2002:a81:af06:0:b0:618:1996:86e8 with SMTP id
 n6-20020a81af06000000b00618199686e8mr1804497ywh.3.1712602619849; Mon, 08 Apr
 2024 11:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240407132125.159528-1-het.gala@nutanix.com>
 <20240407132125.159528-2-het.gala@nutanix.com>
 <ZhQOzMuQBNiqQVsi@x1n> <76fa8f88-02e2-4431-bb28-5c29bbaa8436@nutanix.com>
In-Reply-To: <76fa8f88-02e2-4431-bb28-5c29bbaa8436@nutanix.com>
From: Peter Xu <peterx@redhat.com>
Date: Mon, 8 Apr 2024 14:56:48 -0400
Message-ID: <CADLectnx5Hc9aXu9ADSf=f9Y6ZiXqjQ3UFxvt0Srifwvu1iudw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix typo to allow migrate_qmp_fail command with
 'channels' argument
To: Het Gala <het.gala@nutanix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Prerna Saxena <prerna.saxena@nutanix.com>
Content-Type: multipart/alternative; boundary="000000000000cc415e06159a5ee9"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000cc415e06159a5ee9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Het,

It's all fine, no worries! This is good enough.  Let's finish the
discussion in the next patch before a repost.

Thanks,

On Mon, Apr 8, 2024, 2:35=E2=80=AFp.m. Het Gala <het.gala@nutanix.com> wrot=
e:

>
> On 08/04/24 9:05 pm, Peter Xu wrote:
>
> !-------------------------------------------------------------------|
>   CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Hey, Het,
>
> On Sun, Apr 07, 2024 at 01:21:24PM +0000, Het Gala wrote:
>
> Fixes: (tests/qtest/migration: Add negative tests to validate migration Q=
APIs)
>
>
> I think I get your intention to provide two fixup patches on top of
> migration-next, which indeed would be preferred so that I can squash them
> into the patches before the pull.
>
> However please next time use "git commit --fixup" so that a better subjec=
t
> will be generated, and that'll make my life (and Fabiano's I suppose in t=
he
> future) easier because git rebase understand those subjects.  Then you
> don't need Fixes with an empty commit ID.  They'll start with "fixup: XXX=
"
> pointing to a commit with subject rather than commit IDs.
>
> I apologize for any inconvenience caused by not using "git commit --fixup=
"
> in my previous submission. Let me resend the patchset with correct messag=
e
> convention. Will take care of this in future patches too, thanks for
> bringing it to my notice. Regards, Het Gala
>

--000000000000cc415e06159a5ee9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Het,=C2=A0<div dir=3D"auto"><br></div><div dir=3D"auto">I=
t&#39;s all fine, no worries! This is good enough.=C2=A0 Let&#39;s finish t=
he discussion in the next patch before a repost.=C2=A0</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Thanks,</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 8, 2024, 2:35=E2=80=
=AFp.m. Het Gala &lt;<a href=3D"mailto:het.gala@nutanix.com">het.gala@nutan=
ix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><u></u>

 =20
  <div>
    <p><br>
    </p>
    <div>On 08/04/24 9:05 pm, Peter Xu wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>!---------------------------------------------------------------=
----|
  CAUTION: External Email

|-------------------------------------------------------------------!

Hey, Het,

On Sun, Apr 07, 2024 at 01:21:24PM +0000, Het Gala wrote:
</pre>
      <blockquote type=3D"cite">
        <pre>Fixes: (tests/qtest/migration: Add negative tests to validate =
migration QAPIs)
</pre>
      </blockquote>
      <pre>
I think I get your intention to provide two fixup patches on top of
migration-next, which indeed would be preferred so that I can squash them
into the patches before the pull.

However please next time use &quot;git commit --fixup&quot; so that a bette=
r subject
will be generated, and that&#39;ll make my life (and Fabiano&#39;s I suppos=
e in the
future) easier because git rebase understand those subjects.  Then you
don&#39;t need Fixes with an empty commit ID.  They&#39;ll start with &quot=
;fixup: XXX&quot;
pointing to a commit with subject rather than commit IDs.</pre>
    </blockquote>
    <font face=3D"monospace"><span style=3D"color:rgb(236,236,236);font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;word-spacing:0px;white-space:pre-wrap;background-color:rgb(33,33,33);=
text-decoration-style:initial;text-decoration-color:initial;display:inline!=
important;float:none">I apologize for any inconvenience caused by not using=
 &quot;git commit --fixup&quot; in my
previous submission. Let me resend the patchset with correct message conven=
tion.
Will take care of this in future patches too, thanks for bringing it to my =
notice.


Regards,
Het Gala</span></font><span style=3D"white-space:pre-wrap">
</span>
  </div>

</blockquote></div>

--000000000000cc415e06159a5ee9--


