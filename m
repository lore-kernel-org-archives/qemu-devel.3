Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D273D11181
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 16:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7dQ3-0003t6-KS; Sun, 03 Nov 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t7dPr-0003sf-LL
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 11:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t7dPp-0001gs-C3
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 11:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730651121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=5h9Sva8QyeUXwD/rvc0sjEMJD/8QNSneBckMPuAzAAI=;
 b=Wog70I0d8yG+CZ6NfrkQKXcg1Ko1mitnETEQBAVUF8Q1PYe9yYEShrE/XDBtoe2Acqqvse
 0I6+N+HimS2xViQ/9HqOuNxwCY85k7FwEKGlk747c2/EmpIurD6uWn0hplSKiE0BPJGVrA
 qvMqNSLIXpKlskqMPwdHx/Hjt6CoACU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-48fA2Wp_PVSJxdKdMuDDNQ-1; Sun, 03 Nov 2024 11:25:19 -0500
X-MC-Unique: 48fA2Wp_PVSJxdKdMuDDNQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e2c3338a9dso4387443a91.0
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 08:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730651117; x=1731255917;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5h9Sva8QyeUXwD/rvc0sjEMJD/8QNSneBckMPuAzAAI=;
 b=uafsmKK9DS13UCq6tr3P7JPIR+iZEg26tUvoSCQSBsbPzBY/GGavCk0UkUpjJKV5Ii
 7oL1cifvVJKnyvRZvCfXWaSbUTNiEz4rotDHKtvfs54/tJbLrqTsw/+Tyy/tGRtvWwO0
 qLpMfpgYDY0nJmiQkJ+2FV7/CCXkPj88eTP18GoIKFIqB95labjNtv6XIKeWQ7py6asW
 w6lRxHlimzd3qXoz1aTaQ92ku5qmWx7K0ZxwTx/PghaBJBv7+aZaQhtthVA1/Vp8TeCl
 ArA0Hi+Gno+veTInFs1gOjMN2lk3fw9BSwhUpCgDfDt0sFFUFjiBx3JZUfRInlFKvkYd
 WU3A==
X-Gm-Message-State: AOJu0Yytp8MafJQndHFj9yeolir8wr4O1R1vJzJ+SIedhFPFXJmC6IZv
 Xdc80eELqn5wRa4AHKGqi7nF2poQL8JxRPolhMAqJh5KFH9XMcEza1YaMJmSPCi7ensW4/HG/y9
 46U7K6Tp0LWFg5AredDg0FOf+VDzYi+lPRWQRRbXGyKh5B/RUFhTl070GQjtyAk7MDi47dr+GEq
 CvT3P7IIcLMT+liGFt3iZhuuNIqZLDLl89UB1S4Q==
X-Received: by 2002:a17:90b:2243:b0:2e2:c421:894b with SMTP id
 98e67ed59e1d1-2e93c14fd5dmr17134747a91.14.1730651117004; 
 Sun, 03 Nov 2024 08:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEzBGONvpWNQUd3RyvTFYTG7ImW7I98q1I4RhMb5OF+q2SnCzuCM7ewWS9PjOWQuzeBxpN/bz9UEZ7V8Q8RWU=
X-Received: by 2002:a17:90b:2243:b0:2e2:c421:894b with SMTP id
 98e67ed59e1d1-2e93c14fd5dmr17134726a91.14.1730651116654; Sun, 03 Nov 2024
 08:25:16 -0800 (PST)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Sun, 3 Nov 2024 11:25:05 -0500
Message-ID: <CAFn=p-b-j7Ucxv53ZqpE_e4uuzpsAG+5s=QgMPyiB8gSCsAV9g@mail.gmail.com>
Subject: Where's jsnow?
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Daniel Berrange <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000009f4b90626049d54"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000009f4b90626049d54
Content-Type: text/plain; charset="UTF-8"

Hi all - Just a note to say that I am dealing with an ongoing family health
crisis and I have been away from my desk for extended periods of time, and
not reliably available for normal maintainership duties.

The python tests appear to be in a bad state at present and I have sent a
series to fix the bulk of it, but there is work that remains to be done. If
you run into any issues, please document them and CC me so that I can fix
anything else when I return.

(I am well aware that the lack of pinned versions for these tests when run
locally is proving to be a major pain. I have plans to address this, but
simply have not found the dedicated time to push the changes through yet.
In the meantime, as long as any always-run, must-pass tests on GitLab are
green, that should be sufficient for now until I get improvements merged
for the optional-run and locally-run tests; ideally merging everything into
"make check" and using the increasingly-not-new-anymore buildtime configure
venv with more robustly pinned tool versions.)

The new sphinx documentation project has also been delayed as a result,
though I have been collaborating with Markus off-list to hammer out some of
the nits that prevent the next RFC from being mailed out; work is still
actively ongoing and progress is being made, albeit slowly. I will return
to discussions concerning Sphinx versions et al when I return -- Sorry that
I did not respond to that topic of discussion yet; you have all been very
kind to participate in that discussion after my KVM Forum talk where I
mentioned the difficulty of targeting a wide range of Sphinx versions, and
I feel it has been rude to not participate in that thread yet. Thank you
for your patience there - I meant to "strike while the iron is hot", but
circumstances have had other plans for me.

In my absence, please feel free to merge whatever you'd like if it's
becoming a blocker and you cannot wait for my input -- I'll sort out any
accidental only-python-people-would-care mess when I return. I trust the
judgment of the iotests, qapi and build system maintainers :)

(Ideally, just make sure "python-check-minreqs" on gitlab is green and that
"make check-tox" passes, once the patches I mentioned above are merged. If
getting check-tox to pass is too fiddly, it's okay to let it regress in
order to fix a blocker elsewhere and I'll sort it out later.)

I hope to be back to normal within two weeks or so, with efforts in the
meantime sporadic and unreliable. Feel free to reach out with questions,
but I may not be prompt in dealing with "emergencies", so please use your
best judgment.

Thanks everyone,
--jsnow

--00000000000009f4b90626049d54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all - Just a note to say that I am dealing with an=
 ongoing family health crisis and I have been away from my desk for extende=
d periods of time, and not reliably available for normal maintainership dut=
ies.</div><div><br></div><div>The python tests appear to be in a bad state =
at present and I have sent a series to fix the bulk of it, but there is wor=
k that remains to be done. If you run into any issues, please document them=
 and CC me so that I can fix anything else when I return.</div><div><br></d=
iv><div>(I am well aware that the lack of pinned versions for these tests w=
hen run locally is proving to be a major pain. I have plans to address this=
, but simply have not found the dedicated time to push the changes through =
yet. In the meantime, as long as any always-run, must-pass tests on GitLab =
are green, that should be sufficient for now until I get improvements merge=
d for the optional-run and locally-run tests; ideally merging everything in=
to &quot;make check&quot; and using the increasingly-not-new-anymore buildt=
ime configure venv with more robustly pinned tool versions.)<br></div><div>=
<br></div><div>The new sphinx documentation project has also been delayed a=
s a result, though I have been collaborating with Markus off-list to hammer=
 out some of the nits that prevent the next RFC from being mailed out; work=
 is still actively ongoing and progress is being made, albeit slowly. I wil=
l return to discussions concerning Sphinx versions et al when I return -- S=
orry that I did not respond to that topic of discussion yet; you have all b=
een very kind to participate in that discussion after my KVM Forum talk whe=
re I mentioned the difficulty of targeting a wide range of Sphinx versions,=
 and I feel it has been rude to not participate in that thread yet. Thank y=
ou for your patience there - I meant to &quot;strike while the iron is hot&=
quot;, but circumstances have had other plans for me.<br></div><div><br></d=
iv><div>In my absence, please feel free to merge whatever you&#39;d like if=
 it&#39;s becoming a blocker and you cannot wait for my input -- I&#39;ll s=
ort out any accidental only-python-people-would-care mess when I return. I =
trust the judgment of the iotests, qapi and build system maintainers :)</di=
v><div><br></div><div>(Ideally, just make sure &quot;python-check-minreqs&q=
uot; on gitlab is green and that &quot;make check-tox&quot; passes, once th=
e patches I mentioned above are merged. If getting check-tox to pass is too=
 fiddly, it&#39;s okay to let it regress in order to fix a blocker elsewher=
e and I&#39;ll sort it out later.)<br></div><div><br></div><div>I hope to b=
e back to normal within two weeks or so, with efforts in the meantime spora=
dic and unreliable. Feel free to reach out with questions, but I may not be=
 prompt in dealing with &quot;emergencies&quot;, so please use your best ju=
dgment.<br></div><div><br></div><div>Thanks everyone,</div><div>--jsnow<br>=
</div></div>

--00000000000009f4b90626049d54--


