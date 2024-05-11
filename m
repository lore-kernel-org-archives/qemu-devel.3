Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0C3C25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jvY-0005UZ-OC; Sat, 11 May 2024 06:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s5jvX-0005UN-2B
 for qemu-devel@nongnu.org; Sat, 11 May 2024 06:26:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s5jvV-0004vJ-7q
 for qemu-devel@nongnu.org; Sat, 11 May 2024 06:26:02 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51f57713684so3396123e87.1
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715423159; x=1716027959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jUMuynr621B88ea2YaTKQGDeFDZ0Y/pgztyLvxNxco=;
 b=RnQXf1JgiceZpf2xUaujCEfrVlMoMb76mfJNoAiAbdlqbjZwIeyqL+OIsxeh25llLo
 fxGydmZcgBWtHUku0tBCdoGA33YBBFqzXMF37ptyS7GqmWD9btAGT38OeMzST5+ODmwR
 YbzoiLjoQkl7iwKoWUJrZnMSTUn1iiyMKO/YuaUcY2bnhOMjMvHDWfGpkavy3cdMb0dO
 XYCCI0FzT+f1k12RYnNui4/bf67nWMfsgIKfkM1B6ltBHUaGWiP94ucAQaBh9NpofxdH
 aQrY/IZ1dWEWwZpjVs5qlNbnCYw2V3bc8FigxWuJvQ8KLfykhqAWgKPybKyNPz+bFrMe
 obLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715423159; x=1716027959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jUMuynr621B88ea2YaTKQGDeFDZ0Y/pgztyLvxNxco=;
 b=iPcL6F5m9BL2/Qd1Pjn3taT+j1Qe6Xyvd9QEeWi9RhkjlMOOkSrIgLC6c16JZNmQiB
 06UUW1+1/tVn3fO2VvxYAi8OIV975TM/L2mvXTpTHIFv4+IjdBMPcD+8xHpfxXRuLqpA
 QRZ4rGOdUy98pt49JgThQFkGU7U2yNSsdr2H+M1nazNIcNFNQRgc7BNgKb9GxRx1QjL5
 FdRi08hN6PdjqeAJ508lMZE2hA9r1OrzC6s0ZEotDKbqbOkvzUsAJ/f3KGwPCOdIE8ux
 kvv4isb057m8OTxvWrm0LMkiT8v68rpbFA4eL9JON62MxSwcJ69ecNh5E9CXAcEpuEsh
 DFBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXphXuivUaSApkgguiHIVpgOVc00CR/bmu+0WbKj7g4Z+jNZSaUMyOvvvcQditRG9aipsf08yP0DAJ/IhKrbf/ge4ZpMZg=
X-Gm-Message-State: AOJu0YzFeeSzSwv0FEQZo965E8BeJ9JTgjYXj/AmeNJIP7bybMhy/2of
 5KXPecf8etq7Yr8Y5V+kYDJthrKei+QKQG38uGBl406mHhtCbqwDSephDlYNKzge34VoAU1r8DT
 g6mw+Nw2uCromvzIsdPhfLuRBU4evE5eh59GLPM3QqEVXxo+E
X-Google-Smtp-Source: AGHT+IHasVrLm03MP9q+fXnPjNgdQDdZOvZDn5HDSTwHmlbTdUb1x+msAW+4DFGN/tuiHvKf9mBwhZ02HoTdmngRqoU=
X-Received: by 2002:ac2:5445:0:b0:522:2193:9085 with SMTP id
 2adb3069b0e04-5222193919dmr2111419e87.35.1715423158592; Sat, 11 May 2024
 03:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
 <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
 <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
 <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
In-Reply-To: <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 May 2024 11:25:47 +0100
Message-ID: <CAFEAcA-4OynucjRAHQEUkwqKd=mGtVmUZako-K3crinFEiTRYg@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 9 May 2024 at 19:17, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>
>
>
> On Thu, May 9, 2024 at 12:48=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Wed, 8 May 2024 at 16:29, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>> > On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth <thuth@redhat.com> =
wrote:
>> >>
>> >> Your Signed-off-by line does not match the From: line ... could you p=
lease
>> >> fix this? (see
>> >> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-=
emails-must-include-a-signed-off-by-line
>> >> , too)
>> >
>> >
>> > I'll submit the new patch request with my pseudonym in the From: and S=
igned-off-by: lines, per your request. Doesn't matter to me. However, this =
arises simply because I don't give gmail my real name - https://en.wikipedi=
a.org/wiki/Nymwars
>>
>> I'm confused now. Of the two names you've used in this
>> patch (Cord Amfmgm and David Hubbard), are they both
>> pseudonyms, or is one a pseudonym and one your real name?
>>
>
> Hi Peter,
>
> I am attempting to submit a small patch. For context, I'm getting broader=
 attention now because apparently OHCI is one of the less used components o=
f qemu and maybe the review process was taking a while. That's relevant bec=
ause I wasn't able to get prompt feedback and am now choosing what appears =
to be the most expeditious approach -- all I want is to get this patch done=
 and be out of your hair. If Thomas Huth wants me to use a consistent name,=
 have I not complied? Are you asking out of curiosity or is there a valid r=
eason why I should answer your question in order to get the patch submitted=
? Would you like to have a friendly chat over virtual coffee sometime (but =
off-list)?
>
> If you could please clarify I'm sure the answer is an easy one.

I'm asking because our basic expected position is "commits
are from the submitter's actual name, not a pseudonym". Obviously
we can't tell if people use a consistent plausible looking
pseudonym whether that corresponds to their real-world name
or not, but if you have a real name you're happy to attach
to this patch and are merely using a pseudonym for Google
email, then the resubmit of this patch didn't seem to me
to do that. i.e. I was expecting the change to be "make the
patch From: match the Signed-off-by line", not "make the
Signed-off-by line match the patch From:". (For avoidance
of doubt, we don't care about the email From: line, which
is distinct from the commit message From: i.e. author.)
So I was essentially asking "did you mean to do this, or did
you misunderstand what we were asking for?".

On the question of the actual patch, I'll try to get to it
if Gerd doesn't first (though I have a conference next week
so it might be the week after). The main thing I need to chase
down is whether it's OK to call usb_packet_addbuf() with a
zero length or not.

thanks
-- PMM

