Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4023606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=uXdCG0Mi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNY9-0000Sz-55; Fri, 06 Nov 2026 12:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green@linuxhacker.ru>)
 id 1xPNXe-0000JZ-7D; Fri, 06 Nov 2026 12:16:00 -0500
Received: from linuxhacker.ru ([159.69.87.85] helo=eagle.linuxhacker.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green@linuxhacker.ru>)
 id 1xPNXY-0002xT-AP; Fri, 06 Nov 2026 12:15:51 -0500
Received: from [10.137.0.31] (unknown [162.81.204.199])
 by eagle.linuxhacker.ru (Postfix) with ESMTPSA id E4AD9BEE42;
 Fri,  6 Nov 2026 17:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru E4AD9BEE42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
 s=mail; t=1793985345;
 bh=CEDzSG0/ahMosM5mgsTVJGGN9IE2QrapWsOY7kQRr84=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=uXdCG0MicfdupG9jAHMlkxuguCRv/sVBEXH1EONivQsNJlym7uuFjdn4wnvq6xW9O
 E5U4qzLknxWKsJvwyndphwJ8qJKxKnRo7SXUCZMSt0aDxo8IPFZxhiwBdCZA6Zetig
 cmjVFR3hfpJGSANz/8gv3SSfqyjgnGNDerGoYvtBecf0oK8hnEUg1Kf8LP9LIuQNgU
 8STPUAbgiPPcDBPdx6MFKPKSs4Rcq0D7W8BslNFLmQpveMTcY3Jn+4o2Re50t+ap/M
 cHp8EOWDMlEIr8b19OSQB7xOzfJn3NBc0vMIuWXP/r5LxEy+rNuqFcoxRm+BNpLouJ
 0vFkN2sUGzMrA==
Message-ID: <e8d071a8b531f0a9a8535979a4a7ee2e2c36637b.camel@linuxhacker.ru>
Subject: Re: fixes for stable qemu series
From: Oleg Drokin <green@linuxhacker.ru>
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>,  "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, QEMU Stable <qemu-stable@nongnu.org>
Date: Fri, 06 Nov 2026 12:15:43 -0500
In-Reply-To: <fff79cf8-68dd-4652-ad71-0b6c10aadd75@tls.msk.ru>
References: <cfcac305-df2d-4b95-b27a-21518cb73841@tls.msk.ru>
 <au2cGqMNssHcxCXd@redhat.com>
 <CAFEAcA9HfbL-VTB7uG2cdMT6FcHtkog+TRRPcQY-yH3Qtkg=7A@mail.gmail.com>
 <fff79cf8-68dd-4652-ad71-0b6c10aadd75@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=159.69.87.85; envelope-from=green@linuxhacker.ru;
 helo=eagle.linuxhacker.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 15:26 +0300, Michael Tokarev wrote:
> On 11/6/26 13:17, Peter Maydell wrote:
> > On Fri, 6 Nov 2026 at 09:22, Daniel P. Berrang=C3=A9
> > <berrange@redhat.com> wrote:
> > >=20
> > > On Fri, Nov 06, 2026 at 12:15:06PM +0300, Michael Tokarev wrote:
> > > > Hi!
> > > >=20
> > > > What's the way you use to find these patches, with security
> > > > impact or not?
> > > >=20
> > > > I usually quickly screen all new commits in the master branch,
> > > > and often
> > > > catch things which aren't marked for-stable, - not everything
> > > > of interest
> > > > is marked as such.=C2=A0 I also tend to remind the maintainers abou=
t
> > > > these
> > > > markings.=C2=A0 But my resources here are limited, I can't try to
> > > > understand
> > > > every patch, even description of it.
> > > >=20
> > > > How do you perform a security review?
> > >=20
> > > FWIW, with our new security triage process, we should be fairly
> > > reliably getting issues in gitlab tagged with CVE::Assigned, if
> > > they have been accepted as an in-scope security issue and had a
> > > CVE assigned.
> >=20
> > I think in this case we're talking about #4802 (confidential),
> > and the problem is that the commits in question were not given
> > a CVE or tagged for stable, because it wasn't realised at the time
> > that they were fixing a bug.
> Not really.=C2=A0 I understand this one weren't considered an issue at
> the time of patching, - only now it come as a serious vuln.
>=20
> I'm talking about what Daniel mentioned above, exactly.=C2=A0 Plus how
> Oleg were finding the issues/fixes, including this #4802 too.

I am afraid I am one of those stereotypical "drive-by genai" users in
this case. I have a toy hobby project of migrating a particularly
security-conscious project that I use from xen to kvm because of xen
shortcomings for my usecase ("scratch your own itch" scope lately
became quite expanded thanks to the new tooling availability) and as
part of that I instructed the agent to perform a security review and
compare surfaces to xen and it came up with a number of findings in
qemu and kernel and elsewhere (which is not atypical today, we have
quite a bit of a problem with that in Lustre (that I am one of the
maintainers of), you are just working on something and then do an ai-
assisted codereview and suddenly it highlights a bunch of adjacent
problems that are security related). And then the next step is to just
tell the same (or another) agent to see if there are known fixes for
these problems and if not - to develop a proof of concept to
demonstrate the problem is actually real (because hallucinations still
run wild everywhere).
So when generating the follow on list it just became a "scan everything
else in master that's not in 10.0.x that we want to carry" and it
checked all 14300 or so commits since 10.0 evaluated them and came up
with the list. This does not make me a qemu expert obviously and I
fully realize that but the list does look real.
Once my toy thing progresses far enough I also plan to do a "you are
here in this vm, try to escape" test and I hope it fails ;)

I guess it is a mostly one-time thing to cover the gaps of the past (I
rerun ai-assisted code on 4 years of historical Lustre commits in a
similar fashion and it was very valuable) and going forward there are
processes in place already to cover all this current stuff better and
consistently (like what Daniel was talking about).

The other thing is Anthropic has some sort of an OSS scanner/fixer they
run in-house that you can apply for and they work their magic to find
real deep defects and even submit fixes (apparently qemu is not keen on
ai-generated contributions so may be that's off limits for you) and you
might find at least some of that useful.

