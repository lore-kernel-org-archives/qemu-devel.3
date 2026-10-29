Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F4606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mvista.com header.i=@mvista.com header.a=rsa-sha256 header.s=google header.b=CD8LIF2+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPWB-00069q-TT; Thu, 29 Oct 2026 08:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1xMPW8-00069U-8B
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:46:04 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1xMPW6-00030j-0X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:46:03 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af81963f35so1303639b6e.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1793277959; x=1793882759; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n9z7k08eBx4jDkXGaxfs5PThl8tMfJj1lBu3r3o/XPQ=;
 b=CD8LIF2+h5ujr4k4k6LykWH4IV+YqfF6P6rH5Bo+N9MHbcCUzIHzYtJ2XDJjxa7Ljr
 6yotrMS2riN38u/2S2OaNszaPT6d0s2Imk5nM8kLpWPBjjFHTyvJtAfpdKZaJZ1xMm4q
 GrxPgdPLbeDJu2q0FGOWWpUVhor3mnpe/AimI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793277959; x=1793882759;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9z7k08eBx4jDkXGaxfs5PThl8tMfJj1lBu3r3o/XPQ=;
 b=uSPkOi6AtY3S7XC88+BJAmKor+RstK8XYbkHZqaNE9J6IEerZ5XSXjxnC8uLKrhBrB
 7kJV313xc22HdPGs87Ja42Qm9oVEpw4QQADvR1nR1RRjBNPfJOScIHO6sdI7+FlKtN6D
 CkZuSnR+5bUBpqSv0xa6+1hchDqpQPqCkBaWuExVbWb96ot+Wltd7UMx7N7LV9nGyxIL
 zYvx4TnGkKB0rhdB6Z94e/LSK2Zx9kMUtrSXhGLgBAFwGrbDHQfeBXNfk28KCuqvcpjG
 /h3bhSe1sAr7+sPYPo5bJ9cMXnA5lRhPtuD/yCYNlI0k9VPBtpQr3d1nmoBJjLMkzfJt
 y2eQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMtYrtuwlUVmvSXa99xF+ZvEdf++X6/Wbj4fLRkO5gl46UZPpfPR9nW1j3bwydsB3SLG7+fqkM+hl4@nongnu.org
X-Gm-Message-State: AFq9FYKBG1Mpr55bcpZdLKQsvE7KAu2iS0beidWYiBIyhi+861tSw18n
 p7caM+fn1uTd03knneVK0ysNE41xMXtSQj6Ere1fV0oa1xy54db4qTTrxK67rugFvfU=
X-Gm-Gg: AYBFou04laxR1GrkBqWF3rOLP4Aj8fav0bs9Q3HrPtgj7yhsi5BmrxDSqhVAJ39YKOr
 95kvEKrY1hD5/fzLlmIc3pOSUAr99F3oEyE1S8hOujQC3In/ClqI5Y4BiyKI1dHQaPXUcFm49Xh
 pLlNVCg1i310ueQEQMdpylOK4KyZ4O6Pci0i3jDZveK4whB9EvG44qr9l8iwIzPFuGw1D1vc/ip
 r+UxZZXfe16N2r19KaSup570t05oYQYyCqmaLwfH/TQ1wB51LX0oC+QkWJ5rFNl5j0VnGdIVRPR
 RWzQxLVWyPKLg5pmyauCvg+9yt2+uidCGuXE1xjcBX/Gcjw1ksLnxFYo8yqxRmt7+yxPUexxQr8
 CMB+ue6sDR/wWtdAEB4mXIzGk/OF+82sBxjC95MrAP59lXxW5gq78XsOayNsZncPu9FChkYnKao
 5Q+aFXRlnrgd8I8va9RVz7wZFDLlx93QvpBBCW6OZtGOLImDt2ewqsWd6aLRyK7xvAMAK2F2QQq
 1hj2go9szpsj0nKGZg47y/FbpF5WkVPZhDrwPX7frtOA30oskvTfpjv8VDBYSkLIqVGFinORK4T
 Cf4bWZoM4d1w4TJ7z8KpYzttEC3IqJOQBh9CFT7HhKeFkJT9O63FYafE
X-Received: by 2002:a05:6808:1927:b0:4e7:d180:7719 with SMTP id
 5614622812f47-563a2b4a6a7mr3014311b6e.42.1793277958607; 
 Thu, 29 Oct 2026 05:45:58 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:2f32:e466:d3ef:5b82])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b788a09csm5008926fac.10.2026.10.29.05.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 05:45:55 -0700 (PDT)
Date: Thu, 29 Oct 2026 07:45:51 -0500
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Timur Maksimov <gessingate@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
Message-ID: <auM__1eixNuS8NMv@mail.minyard.net>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
 <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
 <874ie6ku2u.fsf@pond.sub.org>
 <5d219f231fb1f97c6d90cbef4068e82dff803a18.camel@gmail.com>
 <87pkwtezsz.fsf@pond.sub.org>
 <c850cbe681b0328cf3c3f93140132f8363e253e2.camel@gmail.com>
 <45822012-fd39-4263-a8de-d66a440d1061@kaod.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="fYQA5/hgxCyf38G5"
Content-Disposition: inline
In-Reply-To: <45822012-fd39-4263-a8de-d66a440d1061@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=cminyard@mvista.com; helo=mail-oi1-x232.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: cminyard@mvista.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fYQA5/hgxCyf38G5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 09:37:14AM +0100, C=C3=A9dric Le Goater wrote:
> On 10/29/26 09:20, Timur Maksimov wrote:
> > Hi, Markus
> >=20
> > On Thu, 2026-10-29 at 08:22 +0100, Markus Armbruster wrote:
> > > Timur Maksimov <gessingate@gmail.com> writes:
> > >=20
> > > > Hi, thanks for the review.
> > > >=20
> > > > It was my decision to use such API, I thought it would be okay for
> > > > a
> > > > test device. I don't think there is a way to expose integer array
> > > > as a
> > > > single QOM property.
> > >=20
> > > There are ways, but I need to know what you're trying to accomplish
> > > to
> > > be able to provide guidance.
> >=20
> > We need to access the transfer buffer array with QOM. Actually, I have
> > a few ideas on how to do this without cluttering the QOM with
> > properties, such as using a FIFO interface.
> > >=20
> > > > Actually, we can go without this model. I suppose I will rewrite
> > > > tests
> > > > so they don't use it.
> > >=20
> > > You haven't answered my question on code-provenance.rst.
> > >=20
> > > > On Wed, 2026-10-28 at 11:17 +0100, Markus Armbruster wrote:
> > > > > C=C3=A9dric Le Goater <clg@kaod.org> writes:
> > > > >=20
> > > > > > + Corey for I2C feed back.
> > > > > >=20
> > > > > > + Markus for QOM
> > > > > >=20
> > > > > > The brute-force solution to expose the contents of the device
> > > > > > array
> > > > > > with 128 properties has a slight AI smell. I find it ugly but I
> > > > > > am
> > > > > > human :)
> > > > >=20
> > > > > Timur, have you read docs/devel/code-provenance.rst section "Use
> > > > > of
> > > > > AI-generated content"?
> > > > >=20
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 That said I d=
on't know if there are better
> > > > > > alternatives.
> > >=20
> > > [...]
> >=20
> > Sorry. Yes, I have read it. This is solely my work, no AI was used to
> > write it.
> >=20
> > I also have a question about MAINTAINERS file. If we keep this device,
> > where should I put this file?
>=20
> You can put it under Aspeed for now, since it will be only used by
> Aspeed machines for tests. If it grows, I guess we should move it
> under "I2C and SMBus" if Corey agrees.

This seems pretty generic, so I think it makes more sense under the
I2C directory.  But I'm fine either way.

-corey

>=20
> Thanks,
>=20
> C.

--fYQA5/hgxCyf38G5
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIINIQYJKoZIhvcNAQcCoIINEjCCDQ4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggpVMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBl
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkw
OTIzMTIyNTMyWhcNMzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2Vy
dCBBc3N1cmVkIElEIENsaWVudCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAOqxRa06rLwKBvrDb/qQ8RtXfeKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln
4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeGvJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpI
SoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ug
LMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrgunsrYj9wgfW7XuhAi2j0y5d9oMT0SuVe
KFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05WI2G2RNVVlHYaU0CAwEAAaOCAgQw
ggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAfBgNVHSMEGDAWgBTOw0q5mVXy
uNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUwQwYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMMBgkqhkiG9y8BAQUw
EgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdp
Y2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMwgcAG
BFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBh
Y2NlcHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0
dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQC
o3MAIqR0kekGYrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJ
dgkASGsINabAfY2ljUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fj
CMf4NMWLUC8TqotnnrKNuw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2
y/1IVTPlh57zBfjHJQFqLWzHdou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILc
g/3qVwaHNLM5R+8nB5gPI5+u5Uh56w1i+9Ds1pjYAiTHdeUwggTuMIID1qADAgECAhAImztE
U4o9odkEsuVgiJc8MA0GCSqGSIb3DQEBCwUAMGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lD
ZXJ0IEFzc3VyZWQgSUQgQ2xpZW50IENBIEcyMB4XDTI0MDUwMzAwMDAwMFoXDTI2MDUwNjIz
NTk1OVowQjEcMBoGA1UEAwwTY21pbnlhcmRAbXZpc3RhLmNvbTEiMCAGCSqGSIb3DQEJARYT
Y21pbnlhcmRAbXZpc3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJm1
ZE9brEiQnF7EKiV+aYzHyqPFJ+z1wwdJ4wvNiwUCgXJejBxFj04Z7A62Yx6Sp59vfjbo05eA
IOyaLOFp3vbMBQAe8Qe4XrFv7wPcKZxwS+sgCuBvNs4NVGKYGjiKZW8WPq9ZcEl5BM8BLMrl
rchAUHJJcMdcEJUsed6rIB//EtnGOe74/vR1Tz3sN1WzC1Wa9COvcbLgVvWC/o4WysUfC9+f
9/5JzAiib7U7S/iRigkmEahibZgYKB7y6F1v9hxUwHxfa7GtJ8cv6LtRcPLhAO86GgXMfpgq
k3fxzQu8uwACpINbmQNLcRzg6mHFDYRK3mFp4puUnHO5EUJ8RgUCAwEAAaOCAbYwggGyMB8G
A1UdIwQYMBaAFKViIFDcu1tXl60jjzXiVGypfvlOMB0GA1UdDgQWBBQiHrUOKuj1vJe3OXAz
gOP5Qbl2FTAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlzdGEuY29tMBQGA1UdIAQNMAswCQYH
Z4EMAQUBATAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MIGLBgNVHR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEFzc3VyZWRJRENsaWVudENBRzIuY3JsMD6gPKA6hjhodHRwOi8vY3JsNC5kaWdpY2VydC5j
b20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNybDB9BggrBgEFBQcBAQRxMG8wJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcnQw
DQYJKoZIhvcNAQELBQADggEBADkBdRyx41eUGmsYXBXt3WCsYeDr26rJL7lbx2PvqaZyRCJm
J9CN2TljF0YHsXSPU+un1RfUlYz+PtcNFIqNuSf3N5fGU0bEpSzXozd/nZ32yWFLkd5CzYyN
F1xrpbyP2a87jKM0uqEHXZFl7NPiAfEchjFCddciHTOXjN66L+kJ/ZsOoNJLG8yFN401EGew
Nk8z/hJjWqR7DG0/YWn9h7jQ5SmqkqyhLwTO9s6KoByacWuKpKWSc/DaOuWmROlROrOA1hD8
0sKqC6jGeLxNpiYzSwBy8qKF0weZdhcHUeO1HOm1csrvWl1UghnlR7SLir3bb5LiesTVvSuR
Q3aDywAxggKQMIICjAIBATB+MGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgQ2xpZW50IENBIEcyAhAImztEU4o9odkEsuVgiJc8MA0GCWCGSAFlAwQCAQUAoIHk
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MTAyOTEyNDU1
MVowLwYJKoZIhvcNAQkEMSIEIPQ4RSs99Lb85jPslZKdlaZbktjUEKdQCcqXhs4b9ECOMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAG6VStgCzIMhvUELOaYQmndf98e4ykEj
DkgWhVAOqRM/qYLDLYXTUbuiKPrPTtR4p16+v1n1XUUfHHLLG1uj8+MSGjR+xHZvH6o45sxZ
lbv92u4YxMAD9bn3sjMEQxtNdOIF/lkEmO3OBDQRQTO8/4KHpbH26lS3VUIir3Sh6Nh3ZhO0
XZgz7qrgGhqZrkRZKuJIYvh+AhkhCBYN3tpAUZvmvb6W/ByxoFhFVBCdcqlkN/5aEpr2bxXw
C/j+PQMEX0beyn60weeRRDDEAjZgkWmfqmuBZ8gNbi9xZHrYuEWluc0uctUrrqqem+Sof15+
9yZ9OtSna/Aj6+4BLMXm2Ig=

--fYQA5/hgxCyf38G5--

